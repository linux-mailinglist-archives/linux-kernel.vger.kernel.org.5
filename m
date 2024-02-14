Return-Path: <linux-kernel+bounces-66073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1A4855643
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829271C21632
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622C18639;
	Wed, 14 Feb 2024 22:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJQItLxn"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3A182DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950592; cv=none; b=ZA/8GA9CQjYxVJW5Tvc3zZ7/tBwBFnGMZLi60BykZIRV50gqSqWkmgKo2L9dfoVcw0mn+TGfDYwME8ACVeeNuEK7krYU/HzpVFujUfmz27XYG9XGX6z2P5ysS5LRLCZ/nYdsZFH1JRGte4t3AS5g3sG2FTT7ion8zUIVG2Cgib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950592; c=relaxed/simple;
	bh=iqpK3bPt1feEPfmct6sF2oKoz18fS9zOtT8gSIo6F24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elzpJbrFAeGZgZbb9QDm9fCCWVUGCrK7O2z2iJ6ZUZgTyZ8AYooK6l+xQOZd7iESYqa1X7gbRxZENzvWeHSVvU/gm1bySgPcnWoA+WEo+NlCO/6gr7dPOxKIcah1YLnWUZg1RKtE8zeqUBN/+TIfJtPgNDr6yuNSmydvVAcx7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJQItLxn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d89f0ab02bso13235ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707950590; x=1708555390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNsPK+5tLWvdv+gYlhpHEpHeZeAqpOS89g5+h/Xob8s=;
        b=QJQItLxnKo1IMO3sGw8Hz/U2admm+PaFEmnUJBUPaqLUOEs8X2kaBNQC/n+vJGVKmm
         hC/WVoRZaBxbaV0tpE4vefpjbG034G2rvLzn3JVIdfCdAUV3yqx/3kFWKvkeYsYJn6gJ
         YSuzE5HYAnnjViLgiM7bXxHsuOVQHDfom7XUirq2ImEV7oRe4xNA3BjO8q8YvjkWhiOq
         0A0y8JVhTs5mHIouXhUV/pDhW+dc/JQ99GXERsi9ITzSLTOo9JzhC++8UzLKAcI6J0bP
         E0llw0oBJexNEG+Dhkzm8AMoDD+ogKMaDNqGQYIqox6dMWPHi5hlUyEH63iXAHGCR+0G
         YJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950590; x=1708555390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNsPK+5tLWvdv+gYlhpHEpHeZeAqpOS89g5+h/Xob8s=;
        b=XcUWiTMiWQJUTSQzYurBv/j9o+0ScyqvSt+h4HgFPOiQwvMogTCnAg0m/7/oYgXMmD
         zafhCkpNnp1BvVRVC5rznbVdbmXIwFLJwNMydP+lSg+MJi8zyrS8teJ80Qcg+PL7xuAO
         VrTXF8gDFBjOoeRYOfsqVaUsIyoK9ds5wxMX9ZvEIf7MHfJQrf3icihOqXwdTj7wUCZ+
         axpJOcZTb4fZ1TlFyDABSOCxdQHs5h7ZfZ9cLnPEeq4ZJ6/OX2UMrRHHKu4gOAqcoKr3
         SBJlYvVKPl6PE30VwSbATh+XXSFJQ5sS6FCDiEPQJwxcxOmMBZy0pECnBva6vzl4k8dW
         RjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn7zYasW9Q4EcM6Up1fUWmhjATgCkL293/3Oww3mYp+z8JqxyxxXfv98srq+tcmbGJW1AkOyk2z+C1cheAEcHIHXHKuWV5iRD8Iqta
X-Gm-Message-State: AOJu0YxncANY5h0XTT0w3o3q5meKBWYKAQLVV2WRTg77yCG8oh4EXHng
	2DVbXmsW8IJObrAcSmdApBYtQPjasMIE7Yq7zerlm4tZDL9hUgj/U47smFzojWOJZIHicSiB38N
	MwoOHDS3lJQ1KvXBtLDO+8l2E7z5e+m3DXbq/
X-Google-Smtp-Source: AGHT+IEWmx9o20zsYkRXJyB8zKsCSkKFNQNuZGphQlbFdMF3zSOKzL3jAFucrutS57uN43pDOJxLmDOolU9Ayg9Z7HM=
X-Received: by 2002:a17:903:42cd:b0:1d9:aa55:e4bd with SMTP id
 jy13-20020a17090342cd00b001d9aa55e4bdmr401175plb.6.1707950589903; Wed, 14 Feb
 2024 14:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214113947.240957-1-leo.yan@linux.dev>
In-Reply-To: <20240214113947.240957-1-leo.yan@linux.dev>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 14:42:55 -0800
Message-ID: <CAP-5=fXqdFrTDY2a2dXK1ehP2AbwPfPF8vYWXgeSMcKh4mS+ow@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] perf parse-regs: Cleanup config and building
To: Leo Yan <leo.yan@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, 
	Ming Wang <wangming01@loongson.cn>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 3:40=E2=80=AFAM Leo Yan <leo.yan@linux.dev> wrote:
>
> Currently, the perf building enables register parsing based on the
> target architecture has supported register feature.
>
> Furthermore, the perf building system needs to maintain a variable
> 'NO_PERF_REGS' and defines macro 'HAVE_PERF_REGS_SUPPORT' for statically
> compiling the tool.
>
> As a result, the perf has no flexibilty for parsing register if an
> architecture doesn't support it. And the source files use the macro
> 'HAVE_PERF_REGS_SUPPORT' to switch on and off the register parsing
> related code, which is not a good practice.
>
> This series is to remove the static building for register parsing. In
> theory, we should can dynamically detect if an arch has support this
> feature and functions can return errors when the feature is not
> supported.
>
> The first patch is to remove unused build configuration
> CONFIG_PERF_REGS.
>
> The second patch is to build perf register functions, without using the
> macro 'HAVE_PERF_REGS_SUPPORT' to statically turn on or off code.
>
> The third patch is to introduce a weak function arch__sample_reg_masks(),
> this function can allow the target arch to return its sample register
> list.  With this change, we can totally remove the macro
> 'HAVE_PERF_REGS_SUPPORT' in the source file.
>
> The forth patch is to clean up the Makefile for removing relevant
> configuration and macro definition, as they are not useful anymore.
>
> I tested this patch set on Arm64 and x86 for building and did a cross
> register parsing ('perf record' on Arm64 and 'perf report' on x86).
>
>
> Leo Yan (4):
>   perf build: Remove unused CONFIG_PERF_REGS
>   perf parse-regs: Always build perf register functions
>   perf parse-regs: Introduce a weak function arch__sample_reg_masks()
>   perf build: Cleanup perf register configuration

Thanks Leo, this is great cleanup! Series:
Reviewed-by: Ian Rogers <irogers@google.com>

Ian

>  tools/perf/Makefile.config                    | 25 --------------
>  tools/perf/arch/arm/util/perf_regs.c          |  7 +++-
>  tools/perf/arch/arm64/util/machine.c          |  2 ++
>  tools/perf/arch/arm64/util/perf_regs.c        |  7 +++-
>  tools/perf/arch/csky/util/perf_regs.c         |  7 +++-
>  tools/perf/arch/loongarch/util/perf_regs.c    |  7 +++-
>  tools/perf/arch/mips/util/perf_regs.c         |  7 +++-
>  tools/perf/arch/powerpc/util/perf_regs.c      |  7 +++-
>  tools/perf/arch/riscv/util/perf_regs.c        |  7 +++-
>  tools/perf/arch/s390/util/perf_regs.c         |  7 +++-
>  tools/perf/arch/x86/util/perf_regs.c          |  7 +++-
>  tools/perf/util/parse-regs-options.c          |  8 ++---
>  .../util/perf-regs-arch/perf_regs_aarch64.c   |  4 ---
>  .../perf/util/perf-regs-arch/perf_regs_arm.c  |  4 ---
>  .../perf/util/perf-regs-arch/perf_regs_csky.c |  4 ---
>  .../util/perf-regs-arch/perf_regs_loongarch.c |  4 ---
>  .../perf/util/perf-regs-arch/perf_regs_mips.c |  4 ---
>  .../util/perf-regs-arch/perf_regs_powerpc.c   |  4 ---
>  .../util/perf-regs-arch/perf_regs_riscv.c     |  4 ---
>  .../perf/util/perf-regs-arch/perf_regs_s390.c |  4 ---
>  .../perf/util/perf-regs-arch/perf_regs_x86.c  |  4 ---
>  tools/perf/util/perf_regs.c                   | 11 ++++--
>  tools/perf/util/perf_regs.h                   | 34 +------------------
>  23 files changed, 67 insertions(+), 112 deletions(-)
>
> --
> 2.34.1
>

