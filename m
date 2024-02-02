Return-Path: <linux-kernel+bounces-49259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF16B8467E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC677285F54
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06A481B5;
	Fri,  2 Feb 2024 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vb22f27d"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE03FB37
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854595; cv=none; b=rDwnFSObHkfOAw8GrRlRbU3hQw6xqgXW4FtBMY8HrX1Fvb+DolhON9bOQLbUd6eZAAICxKe2wPouvkbxQHOIrdKm8GoD5CXuv6EoorUsWQ1x2TWZDFP1vz4s5RKypnFtpKqgnYUXIGoT+SR1nq9EUhyC2q2D5RgICmGsfInIZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854595; c=relaxed/simple;
	bh=WyIYFrIhagbqEpEtSnjdCLJyMzbzoqJYvfr5Sd4U2xw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uezguFm+SX3x6zaoZaMajBq9JTE8JyiF2S246T1V+79QcOlghzH54QcEWQi0PliNGOZG6vddVfxktzDZP95ToKLLOSdk2TT+cyCG9OmxTV8QFR6oK8WMQC2xJP0myvOMg5oLd3ibF3Xoxyh5v3+Soiw6k7UbQEttTo1vcqExlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vb22f27d; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60406626b50so38939417b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854593; x=1707459393; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ypNKo2tr4KsqSZVI47f8lu+x9dprlYfSiowX/NLn3s=;
        b=Vb22f27dMpxIkeXh0L5WJ4HCOXp8tebLiiFazOzgAIuAzCgp1FwUyln3t/tXFvexWg
         BFif2qdUFnp1pFfLJd1qq6nvbpGn+4K9aEI4G06OJ62lb+y5GYcjBpXvcNTEHqY4xfWA
         4rOa+7Y15HmQ3hSZOqXbOqteCZDzOSONtv8ZUTe9D1SPbCdwmv0SBGo3Hii7F5e0gooD
         Px4HEM0yrUJlaTw51YYLigJ4ZUHU70fYgmi1UCMlFCmylLTbbfb5R2uAcooS7rTvFC0s
         kYDEwC6sySJYoeuWabfjkjDHUEtjWMUOZjd12OKS0X8Ix0wDcO1pYy4d7M99QMP7166t
         s9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854593; x=1707459393;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ypNKo2tr4KsqSZVI47f8lu+x9dprlYfSiowX/NLn3s=;
        b=Bes0M9zcJVzbLUooDSDVnMKE0xG20D2xIZwkGZ7lZR2du8qLNBmg2TbG1jzWQG/1OG
         0fhboehnndIsnWLcLKBBdcfTD7GrpIp6xnq7T8MoCILKJ90cL1PTOjCI5O2AQEjhQOvq
         8ICs/slAVXTX+rXo5XS0+VlQGcZLkOITSXoVh4jtCDZYlLj7XIdVmvpV1MmOQMH/nQCY
         u7ctFhu/ah2YOCcytJLFRmMK6zb06VGXaBNduFP04TLLv/j/ClB2HeNeS5gWsg2iO6J7
         g+8QVCixm0vXYGmwqjVjRd1LB+PZf1JX+rDETOVHy973lyKyMQoBYzVpi/DprNg6gvHf
         Z3tQ==
X-Gm-Message-State: AOJu0YyN4O6EX2NMgZkf9hNJjJbeo0d5UrF9mK1jEVfIPgE3gS4Er4Rx
	W2YKEFjfURkq83FIaLFgp763joKFl0AF+n0ypng22qJ7PEIdxT3sBmJO8r5lzmxrwf+r8px7K8U
	+QZvo8Q==
X-Google-Smtp-Source: AGHT+IFef3UolGm6Id6EKlJqI+pksFvSr3MENN8gB5l0nRqgie5q6Lk3w+fCnuKVNqOZ12rgtQ3M0tFQpb0R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:690c:84:b0:604:2252:7827 with SMTP id
 be4-20020a05690c008400b0060422527827mr331617ywb.10.1706854592816; Thu, 01 Feb
 2024 22:16:32 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:27 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 20/25] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.43.0.594.gd9cf4e227d-goog


