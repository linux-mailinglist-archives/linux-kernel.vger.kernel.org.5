Return-Path: <linux-kernel+bounces-98090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D218A8774F9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D4B20DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7465720E4;
	Sun, 10 Mar 2024 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0p4sSbDK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6459B11187
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036347; cv=none; b=TrRD9KpScQJCulaP1DQby5IsUfzqqfmurq+RezyMRwuLlX9LX1r1/dZ5K+RpLaz+OfBVuSCMR2p9qsW4mhORehyfBpL7qa3SNGb8EgccBU44CCujxBJn6Th2kykD+Lllox+mplGuXsc3ZAyk6aHWdlV5rpVAywuxlEM5Yo+5BvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036347; c=relaxed/simple;
	bh=6Ap0HyfNfUIjggJWxJHCU3eDXgcXlw9rod9BkywTOBU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tsvyuUaDqUfpH/cbpwpPXnzngl0zJWj4wrLW8LZpX3HZ9k2pfmtTwZhrHyFmRlG57C+tieax40QCK/m69MNMxIP1KopSHAzEPpOspggiiJMoKWypUWsYMkvRNEwui1MT42kNoSE5z5erS2dTBMZOR4TVx7Y6wmQAbk13/c2lVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0p4sSbDK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0815e3f9so25389307b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 18:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036344; x=1710641144; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWN/JVLNlztmw39JaEsdXVzONxn2KraPuSeDAn+uvDI=;
        b=0p4sSbDK+xbwGajxOc/9NHGc3pECJbuzXz2qTm4o3nPD+bK3UfXwNOWVstRLgTD5lM
         W1KWojx/Z/ntmDsARJ6GVG3ZyPG3ZSem43s6PK3oplE3hM18e9BWUGaJ22QqnalSD+/J
         SgO8y5dlhUbs7PvVnaYHvvN4nCxD5uQfbPSrH/N4ERh2ZGXpESwBtS4rIhLtPkA+L6Pw
         /PtVXuiqCfY1Iiq9AynkPUGfmoAeduUGfqJ4WBBAeG+bbUaRRbzDGKrCEnZGeHjab6Qn
         WJx2G8P33hTyuS8Ye4sV/dWLfrlFSLuFsIW3FSZ7xFMzEtvGXTWR//ixPnk3c3uih6M5
         gwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036344; x=1710641144;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWN/JVLNlztmw39JaEsdXVzONxn2KraPuSeDAn+uvDI=;
        b=Eq8XSKq2hiCn1Dt0V2sFECcYrPXuzykLubDZc9q0cH6617lVmKyJWztc7/STQFKuyg
         19Vqh3gynwB58AmHrWRIjNmqV8oWpnUWDbXkKXApObPdBbyryED7EMS0uwGfTQy9dmeG
         Nx61aXKka408wS+ypnU4cxobUICTN6SxMrnLuazE0NKO/d5cIQhH+fi7gp3rJf/ktczO
         Y7s3v0cnPiAjm67wL2S098lmkZjpJzME8FIb4fqI9a7/qt9VAJPS5JAd4/9X6vfC3TM7
         VSYnWfHFzM06FlAa+9r9h76QayUQiYX0yQa9p9WYRNF+CGTyd25SskLB+8+fbe5WRyfb
         zWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiNOcFAZ6YUb5Nhy4881jMNl60965HY6dZ+cRk7lEaoDcXIWw4WYbGRpdLoPzUgWXIIidH8gTSYcpfYQ5siEoMLltnaI6GYYC83DAK
X-Gm-Message-State: AOJu0Yx45+7HxVL4HdkJZvLYqPa1mYscjhvuXj0sqDya0LenA3kc1893
	JZV3xx3zttX/SBovlrw6+uHF66fVj7nLbUb91RgVOIIW9URNEQzDwsf5y4H1wMB4u0SGn1BH1MO
	9+tjYKA==
X-Google-Smtp-Source: AGHT+IGdHS2QsdL4lo4wwM/5ksoTAkI5r0dtMhbFMCM7lkSFe3H0TlXafv3xzq/LQr021fLnWjD7VJ9M/wIG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a81:a04e:0:b0:5e6:1e40:e2e3 with SMTP id
 x75-20020a81a04e000000b005e61e40e2e3mr729292ywg.5.1710036344368; Sat, 09 Mar
 2024 18:05:44 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:00 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 05/13] perf expr: Tidy up header guard
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

Make the header guard reflect the name of the file and add a comment
to the terminating endif.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index d4166b3eb654..cd53ee7989fd 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PARSE_CTX_H
-#define PARSE_CTX_H 1
+#ifndef __PERF_EXPR_H
+#define __PERF_EXPR_H 1
 
 #include <stdbool.h>
 
@@ -59,4 +59,4 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
 double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
 
-#endif
+#endif /* __PERF_EXPR_H */
-- 
2.44.0.278.ge034bb2e1d-goog


