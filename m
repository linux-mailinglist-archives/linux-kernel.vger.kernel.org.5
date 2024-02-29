Return-Path: <linux-kernel+bounces-85910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AFD86BCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9561F2204B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB565FB99;
	Thu, 29 Feb 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OB3v5o4y"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE75F482
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165946; cv=none; b=etHtAGi4LMttnOrRHKuHS81tpvI3toY6jHuXIZUS5FeuFJ5hC3dYKsqzkwWuW+vetH3ScU/LmzGjjF3XsBl0Wo/S2EeqLXSGHvCaUrvzoIwNRSfJ7JkzQoahOLOTyXGZIAW3ljOQsdWZeVjg619NQwuyKirrW5F2Hcp9rYB3lyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165946; c=relaxed/simple;
	bh=xlzja/1NTHsdXbKI9l/ne67VG4rMNc4Dj/LOyY65h08=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DPcgMhLTiBYg1iNEm0QtwaByzAskCI/ahhMUGN8CRgq7J0/olvw2MFoReLtww+yBP39nLU2QCSXjg+JdXGT7Gj8gVOQVnW5gSeAAgGnwOaNO+j7H5RG7xHmnnCrsaHtLJ0uauvQsmN3UyWjZj8V+HdiWaddVFj4qReFPq4JuUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OB3v5o4y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so5952127b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165944; x=1709770744; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBmMTFqHwHtPnnqhBPb22111ik/LzYAYuMu6eaqCRZo=;
        b=OB3v5o4ycIEF9dUEtS6bl03w8Fd6HEcJX4aemqEEA5Gfu4miFOPsn9g8E76Pjbrk7J
         viGr0gf6mrtt/3kpKjxtm2GSFrZcxPlp1ODukd1s8IzLahNajZfYKzTMCpAyWpnk4O01
         /B2sF1e0kDQEMhEGjArzAzNE6EoMZddtFRMxgaOBFAdntDdPqnA1XYcW7u8jw1cWb+ee
         wrYqvFczuMppXnEScALhCF/dfyXzBR0LVuDmd4X3SeXPQaVNhd9LtCrF7wT/u4HfF2Jo
         9Ssjluq52IsZGrO1UM9fuIIg7nhPoF21jN8VWlBedL+21PIEKb0lfQd7cp5FlYwkvG0m
         PsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165944; x=1709770744;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBmMTFqHwHtPnnqhBPb22111ik/LzYAYuMu6eaqCRZo=;
        b=K3FSKeS/PhDsgaz9ht7V+NiqvidZnwEyqdKieeRgVsNJrYLBzVvYJXDA5/XUttmo0A
         zkZ+EGsSOHOJ1KwIn9lmcEWWq9Rq03CK20K0A97nN3HEltD4euCRQ6esDJM7CIDadnyT
         rhMMPlakKHWclX/XHGf+hh2NtQ1Gdmn9bY9K7P872Q9a2PbKPeTxs+jpjaqNVpmbjraB
         6uqym6sSxaVs7UCYxxR/APK1buJZTyr79y1Vogo41UYxgRbJLFkPwqXexRNH6/bTivdE
         RN6KOFlH5Q2sNzzp8GVhPGRQN7WZUl8CsM3yBusopGSv30hp4sxwiptVuTxMmMl4MUIU
         QWsA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZkA2Cu1XbqnDl5KFg+tdSKhg32sHAt9t6aTUj+u0lMPO9Hg0VzuiMpwCRc8ylIMWUnTCcXeI9pRYqPtZiCF5avI4pfp5KonpJbOC
X-Gm-Message-State: AOJu0YwdMTujcqL0VekFk8fZyIMXjHwl6Z8s8y/dVhSh4EKw0KT+6NGZ
	+c+iVIAFz2ua1vtDHR9P7hACunPdkz940YiTQtZ9Po5JJX2yhqxth4uCkaw/CUa2bavDa9jeHmN
	4IpQjlA==
X-Google-Smtp-Source: AGHT+IHCDdO9dFzWK3In6vqUH2OND0Fpp0Sp9Y3gyvXw3DO6CgLSy8ApIj8iFIAYm3j9m5+eO7k+MnNbGIqg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:9b4c:0:b0:609:51a3:b409 with SMTP id
 s73-20020a819b4c000000b0060951a3b409mr147135ywg.0.1709165943906; Wed, 28 Feb
 2024 16:19:03 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:02 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 17/20] perf jevents: Add dir breakdown metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 82fd23cf5500..07aafdf77f79 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+  try:
+    m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+    m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+    m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+    cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+    # Turn the umask into a ANY rather than HA filter.
+    cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+  except:
+    return None
+
+  m2m_total = m2m_hits + m2m_miss
+  upd = m2m_upd + cha_upd # in cache lines
+  upd_r = upd / interval_sec
+  look_r = m2m_total / interval_sec
+
+  scale = 64 / 1_000_000 # Cache lines to MB
+  return MetricGroup("dir", [
+      Metric("dir_lookup_rate", "",
+             d_ratio(m2m_total, interval_sec), "requests/s"),
+      Metric("dir_lookup_hits", "",
+             d_ratio(m2m_hits, m2m_total), "100%"),
+      Metric("dir_lookup_misses", "",
+             d_ratio(m2m_miss, m2m_total), "100%"),
+      Metric("dir_update_requests", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+      Metric("dir_update_bw", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+  ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
   try:
     loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
@@ -902,6 +937,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog


