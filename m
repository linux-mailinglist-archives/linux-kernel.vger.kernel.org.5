Return-Path: <linux-kernel+bounces-102861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC887B7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8331D1F27F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B2A56B8C;
	Thu, 14 Mar 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0intQ5lb"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284254FA0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396017; cv=none; b=TpCx4RY5LeAnlEXBJggm5O/QU3fZ71dpRMxL3F+ohHLI2f/7s8NZ5GE+93YvqY0vY9z+eNDpZS4z299wsItfCY06wOqOuMmgPt0DDTgeaAqTdjkGH9Q7Uxqgp8/ldnJEmOWLZEdbviAa2q8OMLa0aa/J20FPFkCmgoClWhbq7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396017; c=relaxed/simple;
	bh=n0hCKJOhlUlJCmdcwDN2VdNUYO/G7CQ1TA0ZpP6Z6tw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aVEip91uZAJLXcZpXonTb3Jp2xegsqv4oqB1BxrYHXv3vVTqgAaNl2Pir8pcfa9YWyUHIkUofqQBPdBAGmun37uMPKzfWlW8r/U0wo8OwV/cJlneCgBRUbpdaWvGWPVFcrEv/kd/d5ENiJkLZKL3qaDQIvIGiEuinYjaTCP6DWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0intQ5lb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a55a14013so12011037b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396014; x=1711000814; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZF+lDg+x+4lYSQ25pqZOkUZnj+qYtfQQOFRuHTcEG8=;
        b=0intQ5lbE69xDg2IYnFPkyvGhd2ZJ0cwPAP3p6rnzeV8yfPN+EBh/QODXk1qunfjPn
         cOgI/bFJPcqdnXL1790b+UDypKzsae54tgOklwBR8YEhiAxCD6+Oi7FLlnO18ziD0f/Y
         LwYxm4/BdniW1B1ceu5pztsQFTns7HnqosYbL68tezt7FZTJACIgMxFfVKyR5ZRNE0wm
         AqwJ3VL7bTrHHIAAye3ZDu7cEb26ydR38EwSlLWKic0YNR1AUBFzGe9pZUajxmsNlhrb
         gAYoQtY9n5iL/Wcx4nJ00jLa23CTrRFp3f655guMhOS2bAFw6/tVxUvwLH1FRFpNN0rg
         QQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396014; x=1711000814;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZF+lDg+x+4lYSQ25pqZOkUZnj+qYtfQQOFRuHTcEG8=;
        b=H9Q6e/qq4wJgc6pv8fdYpXD+4ajQ9AgJRhxg+zn6QRU9smU22Ias6vzAqhfPw+p3YI
         uAwogHGE2elnkWyxd9sTpEEy8M1TKJWvEdh1igWoikLG/H+BxXgkcZQZ41AVZP5ALwQo
         cvEUeNhG1l7CPVmGmxWBaXqF3OX89XeKNle6iJSN9a/AhFoZz9mEeRb6+CcsRYMAJMO4
         kUllG4XzK/XJZPWUTUTYQEaCg6n3gd2eVWBLE0T3FomIBGOSDYRS5wOrPzUt21b6AvUZ
         KlRP9lAz+jmSuKMhEocGoACPEafHPnYOu+GIEGQHqpcTOtGEqtgmra+pRcaVARXwmoQO
         jndw==
X-Forwarded-Encrypted: i=1; AJvYcCUgLb46In7QQxFQ9uDhdey9pEgXvfUcgcTC+xrVo7EZSGR4sjKfhyq+0kJ1oERldH1puj8uk6niT4UpBalV6HGIzTfI9xwRhHZJzMtX
X-Gm-Message-State: AOJu0YzY4K7WbdbpcAO8b69QuERYXH0av5SSHziKDdvgcWZKlye7HhxB
	gp463hlaf4RCmpyytWnWUKL+PLMEc/odYLt8wlJtkc0T7NVuydSK9N/QiVTIltVrfCjCTAtVHRq
	S3ksORA==
X-Google-Smtp-Source: AGHT+IGTzCPvzNe1FzIzgXs6Q9kbuqyr1aub5IHA6aYENEtw3/TaCG98nTpP+peSoQ96AcjfAYyOdeKlFtDE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:218e:b0:dc2:398d:a671 with SMTP
 id dl14-20020a056902218e00b00dc2398da671mr258706ybb.10.1710396014754; Wed, 13
 Mar 2024 23:00:14 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:17 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 18/20] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0e3ead0fa0b1..6fd45350395f 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -777,6 +777,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+  try:
+    pcu_ticks = Event("UNC_P_CLOCKTICKS")
+    c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+    c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+    c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+  except:
+    return None
+
+  num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+  max_cycles   = pcu_ticks * num_cores;
+  total_cycles = c0 + c3 + c6
+
+  # remove fused-off cores which show up in C6/C7.
+  c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+              total_cycles > max_cycles,
+              c6)
+
+  return MetricGroup("cstate", [
+      Metric("cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -935,6 +961,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreCState(),
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
-- 
2.44.0.278.ge034bb2e1d-goog


