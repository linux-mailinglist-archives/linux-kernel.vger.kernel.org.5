Return-Path: <linux-kernel+bounces-89280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00686EDB7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429E51F231C9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9411724;
	Sat,  2 Mar 2024 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLBljgp6"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85312E59
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341215; cv=none; b=KW28C1TOCHZasN7Gbtjh6A/d4TeQOxZ1PpmYXZjk8fjVBrjvndLIJ8kstX6DmMVzURFgZ1DIcT8DOmMdkg3qvyTHkUAu8n16d7rbZrITbeFBwxk2r5nTGGod7RGV9c4fD2+vg2xomNn0jk0qhVcJ9P6FwtyPXAxczXd91wrumK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341215; c=relaxed/simple;
	bh=oswX3i20yiaJHjTAeWqAXOG6a2/1Ta4qOMh9xoJeXu4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UDsmmMc73ep9RtYOtU5bBXifMzixrgNYLag82meLaeYGN7rDnJdflxDuhDk7F1YbuEKBYQKIfPcTIF7SgVvkLGury6JVEOd6i8YB9uKmyeCEssgccw0V7/VfhcYEtqjLM9a78BRh0EliTdivAkLuynlFHaLZkKmVnClJEnHQ7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLBljgp6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dc91de351fso2164616a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341213; x=1709946013; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9W2L65moWfkRODZWtj1+8FpZZOCQB/UnzNIcvAZEKE=;
        b=fLBljgp6qk+iMOADua+20FQ06KrTCkM2VMIShD7IXVBK+bpRtIr0OyKJPlIpwpxfIh
         Ba2kIFN5C1TQ2qxDixFo1A+hb6VE+oSMK/fDuo3LUmnmMFaK91P/myloqeGodGFqkf3r
         8KtNLrR9tSKYUHEx2CIGwGUD+aLEGDWOgywm8kZECGCHdi//yZUOs0w8aq/vO3MEsJbk
         HDu1/7Wp/2o/b86qloTRUOuIWp7aXvaog6dkGIWdt9x5O7x8tThjCKpmD/tnfHHVuAXE
         ZnLeKOLbJi7kMozJmAgyeytX6mfOOOf0c82+ytbcph+87E5/FZ/hOgDtL2+R/M4aJKZB
         sWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341213; x=1709946013;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9W2L65moWfkRODZWtj1+8FpZZOCQB/UnzNIcvAZEKE=;
        b=rSrHNG7mt3t6QuywFKImGLaxvJM6e31lnTu8n6SzloJu25s8TCE2nidHuMEDQJIEip
         xwztREB4jgKm8qhC335NwslPHCTUPMCw+VF+eE/QFRtYYZEedJXKk/im9e4wMarrQ8Td
         16+FWJMI8iOGYtlFtflUi4irGsNn9Cne/p5ORbWXBcHaEi+zP81LPzxlJTBxK+JEvgTr
         wF55WVMoir/acL3qZnm2LoziY1TSkHDiVCIrHX95eEHD9XnGLTgkaO/9pNleSfdg/nyF
         0rV7aVPqx95lMguGMwmopnseHuQO46pTHi0ev9d94F+e343djX6ex/sOV+59/rFZB3qL
         2PeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1xHwLjhQQ3EOPqSIyfMp85zDGvaYZIq29czP0dJx5Iecuk0Pcc0UnK8HX8yB87+kGJIqrAxLzdW5rwW80BTkiaOd4WdI6X1FYljS
X-Gm-Message-State: AOJu0Yw6+xj78Qdk9z0UkQIMDyM8zouofDp4gpBJ6aUi7bR1Qoi5DHKi
	jD/GV7zPE44FvfnaUXPCuK+YFs9rnR1KSqUTd6uXdIwXf5c7AouwFSoPhirQMTr8+BwywMosWrx
	TwGWSUg==
X-Google-Smtp-Source: AGHT+IGOE3OKUnAvgwP9blOB2F+W/4E48XNuZyKBmgeQ3n2ShyrbOn4MKjB1lXOe52HzM2wrPT+//aEA34mn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a63:d94a:0:b0:5dc:cee7:9b1b with SMTP id
 e10-20020a63d94a000000b005dccee79b1bmr7224pgj.5.1709341212230; Fri, 01 Mar
 2024 17:00:12 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:44 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 06/12] perf jevents: Term list fix in event parsing
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

Fix events seemingly broken apart at a comma.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 31eea2f45152..0f4e67e5cfea 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -568,6 +568,12 @@ def ParsePerfJson(orig: str) -> Expression:
               r'Event(r"\1")', py)
   # If it started with a # it should have been a literal, rather than an event name
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  # Fix events wrongly broken at a ','
+  while True:
+    prev_py = py
+    py = re.sub(r'Event\(r"([^"]*)"\),Event\(r"([^"]*)"\)', r'Event(r"\1,\2")', py)
+    if py == prev_py:
+      break
   # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF)"") back to a constant,
   # but keep it wrapped in Event(), otherwise Python drops the 0x prefix and it gets interpreted as
   # a double by the Bison parser
@@ -586,7 +592,6 @@ def ParsePerfJson(orig: str) -> Expression:
   parsed = ast.fix_missing_locations(parsed)
   return _Constify(eval(compile(parsed, orig, 'eval')))
 
-
 def RewriteMetricsInTermsOfOthers(metrics: List[Tuple[str, str, Expression]]
                                   )-> Dict[Tuple[str, str], Expression]:
   """Shorten metrics by rewriting in terms of others.
-- 
2.44.0.278.ge034bb2e1d-goog


