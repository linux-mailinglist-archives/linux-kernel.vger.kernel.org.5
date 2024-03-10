Return-Path: <linux-kernel+bounces-98089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDC8774F3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862E32813EF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234121804A;
	Sun, 10 Mar 2024 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDFA5/1S"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B716FF56
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036344; cv=none; b=EVk5ytVabHZXEpb2DTU+3dyRVyOghEab2nSILF1clQTuPsO0sosoU0mbquJ3Xw4+9mT1Ae6qychweeRDxfV7SsxChwX2zg0iv+Ke2qOjRATzkRjMgOudH/AxKWgjzknqM/NP2o6zKhfT7meY9hO2YbH0aNKCDXryi3qxN/0uIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036344; c=relaxed/simple;
	bh=xr9hx9bRTXredcOnZvT9aTZmO8EItvyRPuWwawu0cX0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y0LCT7BFOxOZR5P/oa97ZVbmu1c4kh79XFExGeE+JRtJYkZIAxlhp11qv8N5OqDXi2DsODkgyexK75WJ+4qPDRhR8mc5CqnWHydLW16af0O72XeVULDTy9+ifoKYso8DX/eaCteYfJ/Hz6xzuVc4cv8HAmhozkG/AaeMB24reb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDFA5/1S; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0151f194so40237197b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 18:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036342; x=1710641142; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OaMyUQu371uaOuekdLYCxktVf9TU0U4kdxUUW/XeAo=;
        b=GDFA5/1SAcDvh5wHDztVT4fdrpGGN0qq+wpmeK16nZfyhHocB7oKXyTmzVAjzmV6VQ
         5efsx7rWgkIJt9XTz3UTXv0jUKjDM44630OfMOWCL+/MX2eTAFoiJOGBI13uUTGVPtTz
         NDN+lhd3oRLxtTVbRD4XZr/lLDtewndKru+9BgwwM7FlnwBteO5LxseGlOoFtQxEBNkx
         mrP9DMhE3682KLijmsAxz1fyTIHq0zDD5ZT8yJohRFnrcvMiz/QlvnRqfLRzwk5Rj2yS
         7y4iNFQSZiHWgNU0RM9VoGK+Gh9T6Fkg3yOEDCSxbtF+obf/+2LqKuC/0FUrQ6sd1l60
         veaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036342; x=1710641142;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OaMyUQu371uaOuekdLYCxktVf9TU0U4kdxUUW/XeAo=;
        b=mxaImYr9mZaNrBaDd32ZwPnzP6N7k3gYq6lpYsxtMV4cIsEBwlXkNQXbtoA54nt4Ph
         KEI06/wS4NppAneF4Z3FfSKiXh+t+qV2hK5uOHNTfcaYrHoqTgWbhUQmtJjaiIiMWjj2
         OkZi6uFfyaMs2DkePlW9eWzUoGxjpYJC340iQ1z1Zx7QcjEKk7gdFfns/y2HjoRSN2rj
         vDVuB6MWK+tDqa8bPM4rRQnY/lFKiOAtpknfvFDWkHdVM5E+jcVi2xRMtCF/H8rSUSAT
         8dMeqkpjyNJBE9y1on5HoIzd+uz4HJrECEVS98YGHoRXTRcRUAB46LZhr1jfL0Ftonwb
         6Qpg==
X-Forwarded-Encrypted: i=1; AJvYcCWyPH4WCL7rlDHllFN90wOeLHXx0L1hc4SDufNnExWTKB2YhTKqNla1/w9E5sYJzyYbAvUUTi4iPLxG9YBTxJj/MEoEhs6T+y+HAw3j
X-Gm-Message-State: AOJu0Yy2vBxyeNZLuXkgvs9osoFeQobMiIi4W3ZIi8x5LzyKWfrh4gGO
	dw3YQXwp71PTsYOVAIKTquPx/JEKwU1i25DVjbfKpfbsqpaUT99jOEP/hZuVej7BGMQDjtMsBYd
	gUXAa2Q==
X-Google-Smtp-Source: AGHT+IGxAKGLHfU5lr4cLxfntoHY/lII821Bv6GcWrrnRg5nZbXZHQCblMErp4nOuwdOu0LpnsGeX3qwWfLp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1889:b0:dc6:dfc6:4207 with SMTP
 id cj9-20020a056902188900b00dc6dfc64207mr903918ybb.10.1710036341778; Sat, 09
 Mar 2024 18:05:41 -0800 (PST)
Date: Sat,  9 Mar 2024 18:04:59 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 04/13] perf expr: Add missing stdbool.h include
From: Ian Rogers <irogers@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@ACULAB.COM>, "Michael S. Tsirkin" <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

bool is used in this header and so stdbool.h is necessary. Add to
avoid compilation errors that aren't currently seen due to transitive
dependencies.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index c0cec29ddc29..d4166b3eb654 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,6 +2,8 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
+#include <stdbool.h>
+
 struct hashmap;
 struct metric_ref;
 
-- 
2.44.0.278.ge034bb2e1d-goog


