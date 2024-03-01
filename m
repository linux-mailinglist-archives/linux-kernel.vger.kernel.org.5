Return-Path: <linux-kernel+bounces-88971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48486E8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D541C2337E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233A3EA71;
	Fri,  1 Mar 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4nbwjO/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E303D54C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319402; cv=none; b=LXfNiOhRVdobecCa1UHSGdMvC6dIfAeY1Eujt+N+O3RMoZzUwJHQ8D/eBwxSr+ZCHELeOnfUwBZFpegtp+Ui89oOieLKukWJQFyBDZXwr7nsBBPvkL5hHytJlvU359iqLqHkJ3lio45ggjtsTwtn13d/zGR50CVCIV4suFZ2VDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319402; c=relaxed/simple;
	bh=ReQNa++yN3cks/OeqEJawBQb3bmDZtEAQZ6F6yRpdYg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Vak3ruZdSLpwXX02AFhpXyHDCkZy9i5anmi5Otc9BA5TCNVCKd/6yY9l18odW5QZorGARxQ0E+TEOv+ZMMz+I6G/V6A9Quv/1Wnil5grjNQDYBpUDO6okTbgaNzKu1y0ZtGJ82SH+fz6rS7F1NbaAGvOK41lv7a1HL5tOphz9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4nbwjO/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso42109697b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319400; x=1709924200; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iy3P4uSPJWyjA65jWAIGgY8FhfJd7Bx8GKL8ekkcR6Q=;
        b=L4nbwjO/VhKmqGrtuMZOWgx/BX9nDeeT5vnXBovLI/TryzoT5hPLRoYL22lKsArbyn
         nmgI5GZWOqK2eAxs1Dxtssz7Af5fg8xBhbhNe7KG5wCgQqiRDfBqI1VzyobhjdAkbSSj
         11rjv0YBc5ROdX/+SX5LscEGAD/Oxus2KlV2+Nrk4GSEcgOEhNRYAyYtPPBgvgtMluVl
         Y/BlRCJbTVDGlxadWyfI+ENzuBaGnqZFBxZQgCGOrTZXP2Wb/dYhKKQVmWINfwBML7zj
         DJD1i0w3i2nxg5RqZTV+/ZkUcjXBfNqLAt8e/1/xgtzp8YABZyvtsRNn4Dyqr3/ifOiY
         LgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319400; x=1709924200;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy3P4uSPJWyjA65jWAIGgY8FhfJd7Bx8GKL8ekkcR6Q=;
        b=r9XY7Mm/Ecefuv0F7rLhM+R6sRr5Z5Vnd6BxsMNLBFA3d94O5GYS50JgPgL8IkIsN3
         p43ttrRx6cg983K7wogeRbShU/7T2Wp1AjI0KposzOCZdyWRTeBUYQ8Urb1G+O6VqFiU
         y7Z4oJk+Zgy+NCtPhcrxKiMJox/ufI8mEMyoPwS9piG3h/GG9SoolrbJO2Knj4d08BvN
         sHu+uR0wLPM8809aFQhW/U7gPrk56e7M0kA8+sApVfXXjNZy9PWGibrfp8NO+vx7yuUC
         pG/kUwvO95C2eeQhgqvMdlNc8atEYa7qHybrf8syYLcEZfqjb32ULpT9uFIMWrrQ1ezs
         +fMA==
X-Forwarded-Encrypted: i=1; AJvYcCWeqMQd3wthCGhRZe2VbYJtS83fowPHPaFqOLEi9iP9yFuuPCakptAJc52dDON9iEJQRdsCbKa/uNm/tcCUqeyj2JipOzWeSFHFfRmD
X-Gm-Message-State: AOJu0YxGd34pbIc8mYSBSHrlh0AVD14BEo+OsnuMhda3eAcBx7P7j8su
	kGsM//4om/y7ESPLK60ohY2BtUI2o3U8q9wI+dFMi9s7mn18XO8D5Z33JI+jnv+m/WpF3ql0xat
	xIJ/xMQ==
X-Google-Smtp-Source: AGHT+IE/KE3KsJdr5TFLnSzfOCiwccn45ucaLtLE5iDVqP+0SDrXyL7JnoVAXkyzooS6m7HBBYHYYyWkGkRM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:3387:b0:608:d499:3439 with SMTP
 id fl7-20020a05690c338700b00608d4993439mr467407ywb.7.1709319399748; Fri, 01
 Mar 2024 10:56:39 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:50 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 11/20] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 061914834cff..6f6d1cdf6649 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -272,6 +272,35 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("INST_RETIRED.ANY_P")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], core_cycles))
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
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -604,6 +633,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelIlp(),
     IntelL2(),
     IntelLdSt(),
     IntelPorts(),
-- 
2.44.0.278.ge034bb2e1d-goog


