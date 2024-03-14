Return-Path: <linux-kernel+bounces-102805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E387B772
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0ED282A63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDCA15E86;
	Thu, 14 Mar 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0SKOH5l"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADD14A8E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395492; cv=none; b=kx8K+He0fi+NqDxQNKUco0da6N7mQFvQxg2lAkGbXGj7aLvy9BUaspCR6POK6nV0CZXskSpAymqaviCPA7O297uVWTsYSRzFsQhjL8yp8qPjCtOO/GY1BUvT0h/GrQVSH3cmDqnKwxaHo97rrvYTD3b8lpVxZg51mTKsuaBNv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395492; c=relaxed/simple;
	bh=oswX3i20yiaJHjTAeWqAXOG6a2/1Ta4qOMh9xoJeXu4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ax1YxUn9S7jWnkBzn16CyKWh0J+UbrzeQpFn2O3CKvVuXUeCzi7A9HJ5kKJp+JDnthXPOBtXfKGrUkzNt+HWokNZqivdRdZb8uRovqUc/z+QNKVpz2GptsRmcEL3kdrR62DEkUnyhHgNe+EiRM83S5QZ4XiRdf4iYiWvjL/VbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0SKOH5l; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ab69a9e6fso16991137b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395490; x=1711000290; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9W2L65moWfkRODZWtj1+8FpZZOCQB/UnzNIcvAZEKE=;
        b=Z0SKOH5lBDXANRYDT3FT4OtVU/68DBsGFiAedYfoHYtmAtNZjcYdRi+bT/VG3Ge2m+
         tKX2QWO0JlasGCCSH1SHWFMlaZci74YOFqlZhT0Yjgx4L3gHJnPxCP8qITe5VpXVPFm7
         2LUOFALrcWicwLmzzLrOIBPzVC1Jg8XuVUQF30yt7zysz+6hUKxYGMYs6wM7DawEyfoc
         GIEC1MvYJuEdw3dEWKOpNFvc7BdJ6P9g6GXiYRT+JDfpjZ7PPt15a7L+Ep7KcGKoe/qy
         bfm37x+P1gcTFWuRxaURc9WO8OyS03qVQ8TuH5YDKnK1kNEKQd6XGKeMo/CfEkmdXuNh
         1RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395490; x=1711000290;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9W2L65moWfkRODZWtj1+8FpZZOCQB/UnzNIcvAZEKE=;
        b=GDeBmMbo4mZ8e9pdJSRUvl0AfTHBtIQb5ng5uymj9rYvtVe4JuAZljxFF2C2FhCeoo
         AGUzgceq2To2tJhO4Y22LK755C3OXxDEezioKk11Yr+ctEk3WboZnBiqUvWnvhiGTbTa
         Q/HrrbSPq1nETtlGkaMysVociQ2uVJxRJana1DoeEhtAGmUVVZ2V/xJGTWEXBFa/HPg4
         YdnW9IUlSg6uf6RxMkLw5soEO+gfrMQ0+5X8W0+blW160SMjWp46wpP+kQdVxa8B1clF
         5ZKPYkQ5560PWLvQlO7rTyh9wDH/MJ8uwpwH0F1zP9KL3fZ381GUxF0yGiHLQmST8Kt4
         wrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXLUcCc4KisoWodEW3Fdb/l818uVToAvsz9c/so+VwpzFPuyimt9AxWeIks8cY4+D3VJdaN0BaH/z/TENNy6mrN8HybC49dMEHLp9z
X-Gm-Message-State: AOJu0Yy9R59h92MH8SXtMm5SqSeILBOKqf+pK7BgHvAs2EFYpfSofiN2
	ZWSWN9g2ZdieDm9Sus2taIHrT7bhqqCgiTUGgWi6aG0se4uShjNuAmtKuTn64YXQUQx+yrg579Y
	KUxv2FA==
X-Google-Smtp-Source: AGHT+IEWSnrDCNmwOwoNayo+Na8bh0N+7sXrpF4N0p5X7i9MQDILAXeEfZ+11sj+7d1o+2cE64r68zbGMoSY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:5255:0:b0:60c:3c63:92a with SMTP id
 g82-20020a815255000000b0060c3c63092amr238651ywb.0.1710395490226; Wed, 13 Mar
 2024 22:51:30 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:45 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 06/12] perf jevents: Term list fix in event parsing
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


