Return-Path: <linux-kernel+bounces-89281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02D86EDB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE5D1C21907
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A887214F75;
	Sat,  2 Mar 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI0xfJRj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B493F9D3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341217; cv=none; b=ntCn4NnCAO7SRjxPgIKaHNJCdeqad5nb0h3CW+4cPLQcLjQz54XZ+Nkld37g/b/v6UT8IbT1Ls/i0OMmEDiEppMM/wOOUX1AtOELzKML8CJoQBnoPFqpR4QZbvyO2KDKPOO2Ox2XYiw8fuAoUUMAH3yGp3rkcUCEweyRn63tJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341217; c=relaxed/simple;
	bh=ZXVWxGkn7pnCvmd8l6DV72SPICzKi/Gva//TpBe7PFE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZnO/0o83EW72tsbaATHd3gCryuW2TygE9X9hmf2RGBM65FuxknEoG7K4fqdoQ01H6fMYsPSwBDFiXWx3UITKKsMu5pObZ7+JdDmj1MOx6feBK9JUrZuUto3tZUki3hq/BYirrFmZWbMLATZgLzqlAeKly5qpYiPP1EYR7kp/V4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI0xfJRj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6098d88e994so11526647b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341214; x=1709946014; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/C1Fptl7F9oJgqV/SnZtPnw4T5ATAHSmXZQvuFpHbZA=;
        b=qI0xfJRjpEdE3s+OWFK/wud9k0lVmfMm3Y19P85FmaYk2SVEokv8w2UtiFTB0o479D
         gyRES8/ofoCKLPMJkk6sR9qQConnJNRRkLTOBs59Y2MsUQ1StCcM5RpJKkl7S70jyPro
         DcZUhNWiMF47sQDGMFeXWnTHSesrnIKonsJecsfa97D84lPCmZJgs5X0jVLAv33koySJ
         jUg087JU2ftUyI3R4y2lRfeHJkULZARZvFz3Zaa6wiPv8ppAceeQBSmhPAx8hb2Z6Zej
         ZXC8ikBoy+eks3S/cM5fxOmp78Deo0ZMPReQFXWQmeOIECpoOmH8jsEf6VUX0EAgIln7
         DS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341214; x=1709946014;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/C1Fptl7F9oJgqV/SnZtPnw4T5ATAHSmXZQvuFpHbZA=;
        b=H9kbs794hu/cH/KP/VgBzPJpKGzVlrnTSHQ/2hRs9PdekpEk/MvrOq0IvDRFsK9D7r
         7JQ/T+2gmka7pVOObl9uwAxgD4cCK2jB74xlQIKT1pvAelx/dxA2GU9oP9AIt3+UxEWI
         UkB1R+IDCS0vWcmF8T6oJx6MB2kUlD5RTEgH4/gYOMaRWpvn3xVPGo+3GKu8D6pkp+LU
         h+ToTy7u66UtBoYY0SfM2LXIRYNyTxQ1cshdlXt7ZdU6aUwPgRisMFUFgn0mhBcsGGCr
         7wHJBxgNMzoJU7KVUVHJfjORl1KJck+b7kxi1e9ky8u+EKrYoEpUrCcv4B9EjHgTwBGf
         ToTg==
X-Forwarded-Encrypted: i=1; AJvYcCVuX31xCLSmwdgX0KA5WzjAQQVSma1R65j2n3fB4z429f+7nAZEJzxdd26Di1xlfklgh1xRrV/eX3wO1JnQGYbT6aiH7sVaBT05ZmP+
X-Gm-Message-State: AOJu0Yy7uvmklWiTRUQ0aRW9Ksr8qcvZBoo3FUUb3KYKcv3qiMoxRpEf
	11yauFhHda4TLF2JNSww642H/bP6aDH9H2qB5qopIkqry1gbX30+KZ0sFqwyd8y5ypVDN93l57l
	s1GYZmw==
X-Google-Smtp-Source: AGHT+IEcLROtrXlhR1p1wHqfQliwAasWDluSReL729q0MZhBdDo3jfqmp3mw4G6E+PWld0UnHXf6WNfZUUQr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:210b:b0:dcc:50ca:e153 with SMTP
 id dk11-20020a056902210b00b00dcc50cae153mr766214ybb.7.1709341214783; Fri, 01
 Mar 2024 17:00:14 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:45 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 07/12] perf jevents: Add threshold expressions to Metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.44.0.278.ge034bb2e1d-goog


