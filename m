Return-Path: <linux-kernel+bounces-88948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63BC86E910
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94898B2EC69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376353D56A;
	Fri,  1 Mar 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGOARVnE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2D3D3BB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318894; cv=none; b=JODEdumDYj1/PSPdIDVOpsCuGTbDNL1yDpaToA1BMznlHDZhz3Y8cpWXSz5KjaNjTLqKXDAo6K9S/wkKwIIvJig3KziYnyv/LoXxjvznyNR6tjnXehsSFo4DHsm4cPfuOMigq7olJBk2/9M2rJIec07OE1xvMOTKOor3KakAaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318894; c=relaxed/simple;
	bh=rdT/e0Jk04uz/hli1au/7w9zNoOK9Gsygo85Wow1ix4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oA0ow3TPVaBMDeW1r6Y0UCCV9ehA5QX2haqX/lZ0fcg9vhcSR8BJ4AZ7NSnELybWzai3TrgxaHvN2xFSPeGcM2EqbgdlVHTw8ZiSFMCHvAnWyFusDGOXVLb1yZ8ew/Xj7PgvCIIzLawaqcD7onIiY3+hjc0kNAS2JEynJaVWSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGOARVnE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6093f75fc81so43465157b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 10:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318892; x=1709923692; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHahQF2BiK1eIw2Re/KcTjpVIHmS0xMmp3oAqD999cA=;
        b=hGOARVnEr5xFFtpzaNPWOObxPn2dAndkDKpQzVtrO+tAoB5NZ2q2KHAbuDwAS3cI23
         aqar3Vsrzl2gRropVv0tX1HlfF1ykioTUjcLvzcXBx+kNPaNrJack3kyEaZPmMDuPbcP
         JatgyUP6ooa2qXNltuvHXbXLFla4ZOktfgJkhPkLV8wLecHSqx8MSoZHGYaiKmOdwOlB
         C2Vx73CmXSxvYLCEoRDmzbW72NeNc135uB0xYlYHbSS00SFSr79Tj0VIrrGFEz5oZdn9
         lCHxg0FQtA9+oN4E12lC4NrwMRr61RjTNOoehp1+BJHaIlv2dL0h7p4Zla0qup36cXWo
         m3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318892; x=1709923692;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHahQF2BiK1eIw2Re/KcTjpVIHmS0xMmp3oAqD999cA=;
        b=AwQUwDGzaqiGJoZ66v7UOic0CAcPHvqoTgqSS7B6mdVelH3vTvxKn3ur6DlV3dXOws
         Fy9z/gd8c+YI2QQVwencOi1Ngg0fUXTkA23N1ux3HuCLath6JS0dCbXWYX9lTFzqifTz
         esd7oHF1ZCVP+4k9IaFj9iqP12g74CNTC3AZ/g69v8DkwB/C2L5am47E7vnTpVqeKdu9
         WGbwdGTCx06B135i0g9uqQAhPm7Vv9f+zyDZy22v9MsbXdCPZLO0/oQ0+aGdFybznpcV
         eQzCFVGkhEpy/OMhghOakPHzxaOIkYCBGvZD1kW7GoDccfFnyBAKyxhXKuuHLvAgwYWW
         SFUA==
X-Forwarded-Encrypted: i=1; AJvYcCWleeCm/+FtKwZhM17LD2/rWOJyIO+5pIsTH0HAvpUnuksORMOD/tlV8qTjzY4HXuf+bXKlvyCo91jBkZh5sSwDRGIBFigm4bRn+DMp
X-Gm-Message-State: AOJu0Yz7FtHvyqaKox7pVtpmEmPB673blbpp79kE8OAuIyRRAuzXq6zG
	Fr8yMMq/xtXARgTlTBuC81wY3WWOp5HFIsS2sihP7RDIFx7i1R+6gs5vbmqzCDTukT0IupkIdD0
	AWKHAXg==
X-Google-Smtp-Source: AGHT+IERLQ1O9253ubhZ6XwiYRXZjTmFNYSuz/PkNrZV9PR8nmYbN7mObenIxw1PAB4/Ocm/Luo7AI4JEOva
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:b15:b0:608:e4fc:aada with SMTP id
 cj21-20020a05690c0b1500b00608e4fcaadamr631228ywb.8.1709318892155; Fri, 01 Mar
 2024 10:48:12 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:36 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 11/12] perf jevents: Add ILP metrics for AMD
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
index 6b182a9bbfe5..91f323c1a149 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,35 @@ def AmdBr():
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
   if zen_model >= 4:
       return None
@@ -560,6 +589,7 @@ def UncoreL3():
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdIlp(),
     AmdDtlb(),
     AmdItlb(),
     AmdLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog


