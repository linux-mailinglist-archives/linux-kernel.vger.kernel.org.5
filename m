Return-Path: <linux-kernel+bounces-102828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610787B798
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FA21C20A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F58C1BC36;
	Thu, 14 Mar 2024 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sf7uJGJb"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0D1B7E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395951; cv=none; b=D9Hy3gmn9DxblSgc3nw9BbzvT5bo2YZofBxUKOaCtrlfMVlxe1+sqj/Aa83B+wq2lbiOW/XQ5LSHvrJTVW6+iy6TPBd8q6TgSbp1A96kydLefNrmwSfregvkplsSAujMWLIdrXB1i7pdTOubUKQp4Hu+4gJ5aF9vD2HDsfcEEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395951; c=relaxed/simple;
	bh=1kQ5uW3vdTVEojW2lkh4TbCqUKQ9kwqg/lZBltsOY3w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AN00/ZhjDNMXiVmvMdeLdB9Vw82ng0/7Y4cwLkH/iL0bmB1c0rqhzRAOs6GB+2K9WTRG+OKHe8BvjuyFUhRFjSfHZBVqT2trCosFl5pbrtO9xyc1C6ENvd47x5/Iy66Mq0EVcOBWu5MpwqnZLDjXGLcgYr+PS0n+nTSX4ZNMMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sf7uJGJb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e4171382so10438217b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395949; x=1711000749; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d57tF9Q2XhdTDIJ4za9SIwSfvP/kj9N7wv6tDaN1ld0=;
        b=Sf7uJGJb5qj5SnQfJIGpUhuch/c2YmI4CwpzOatHSR7iG21KzSx8BHwQFIWKyWWQQG
         RxF1nIXD6SSkCxOWjfppnw7705lDS3xnzolDVL8S+ekkuKQm1yHz+fV/plOSTMrUZjDo
         1ASPwbYccVFS4qc9bZWStY/t4MHsDz8LZp1lsRRbrUNU7Yj68PKDZXOYuJ5WYOc84Ovi
         KF0gtOo5Q9nag8vwJ5oWRQk6uMC0d5T26LLZH+mEPajL+pOJPlgYcNI7QF4amqikciUJ
         NMOldEQKsWn6oKermX7e/MfCzkqd/a6poyspMM/Fct04V0pKwVl2/TViaYQrF7B2rwfB
         m3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395949; x=1711000749;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d57tF9Q2XhdTDIJ4za9SIwSfvP/kj9N7wv6tDaN1ld0=;
        b=qe3dlM0j9RQi4eXCsC6GAZ+TC4HutI3o3sxxjE5PXCdpeqDGphYsSKg1iYsUDUNPdY
         35M5BwjrtV0Xoh9RTjODvMtDc+xWUoRG8VzOutfpiWY1kiCmuR8WlDJREfNzD8LfQm05
         dK8/kZ14iauxun9kRDpC/Xa0lY1l7Ozaw5aPgSoJIZewwyoIkTOy8Izq1ZfTq+wgqq9P
         V4TZFZewfPbsZ+DBYGayuV7kMY2JMFYKvEDHM2JOoB/avt7Tc9oTna5AnZXSTddmQ1a9
         wYiar4ZmRVKfk2unjBYumb+ltqUWg5hBZJPPK6tZVJgvDOi3l/ITpE//NR1rpsPWVtfE
         GWhw==
X-Forwarded-Encrypted: i=1; AJvYcCXnTVEmtja5NoV0dPh1lNUcj71dZFOOCgSwELLPj3TAjfZtp6ej2LcdVp6huoDOBAxMI4uBo+1YsNxSdWgUNTx5nYf2gO89BN/0EA7p
X-Gm-Message-State: AOJu0Yz+cJGaK0PCQatMmuAIqyeG9l6kA0a3Ax3xLJ9E80KgkZq2GIp0
	43UjBlg7K+mNi4qZYF81WDmgPg5UX9WHjKqtPOjDM7m+CgTJ++YPzmVEZHSNOfZpIq9YbOvKoIB
	HQRWjWg==
X-Google-Smtp-Source: AGHT+IHpTzwZVr+evwz6fT+xaE9J2vpkhCCxsBfF/HuodCT82E805zezsyLrev/LIjgH/VuabifvcDBWF3bV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:4995:0:b0:609:4c74:5cab with SMTP id
 w143-20020a814995000000b006094c745cabmr153105ywa.2.1710395948788; Wed, 13 Mar
 2024 22:59:08 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:38 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 11/12] perf jevents: Add ILP metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 2fc8064e4fc0..bf5c4ffa53e9 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,35 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("ilp", [
+        Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
   global _zen_model
   if _zen_model >= 4:
@@ -584,6 +613,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
       AmdLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog


