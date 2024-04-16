Return-Path: <linux-kernel+bounces-147087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855518A6F47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26F61F21A38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7DF12C7FB;
	Tue, 16 Apr 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2SsN4HJ"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFB12A174
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279909; cv=none; b=fmxMK/PMD5qNBPTXPSNHtJqRGv/CgNxGN46xjuGBzp19qUSDjFuxN26TzTmqNGU0Z9lSe3aBPgJv0MbXD7M6JZcfjJHHLHG+cKWQht0YdWHBrZualKvOewVH+FHX1S1019pyKwgVFYpcpmO/Y8FgyO0mtmdlgRnB9XzZpsj8KY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279909; c=relaxed/simple;
	bh=TZeXcbtKOMozMWJ/kUHSgG1n49qX5lbSr1iuS7NKbrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbb1/Uud9TGINAgjJcnIR3FLQJgF3m8QJbhUMHLMw+HLVtEdTkNvcNAjq5AngYkNuiPQhMaoMEGYy+EZK4WQf97nj7o97zBfpDipypZaUbcalpvwEBlDL7y6UUAy5lb0g6u/pg2HCMdeG1Dz3zbwEpjOWMa675OseZkjduAydRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2SsN4HJ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36aff988d73so146435ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713279907; x=1713884707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApDEEOzWKbr2lAoaPzmlzkmuB1oGm6TlwwUuSX/oB4U=;
        b=b2SsN4HJqmF8/DlY40a4MIfpFTt0nc0phvFoHv6I+3lHshEU8HJSVlUGvVQDH0gXnm
         8qB2PqokDUg6BR/TlxjjVx3elydri24CMBd1Be3sk+2HAh/I1Vl1RJuGnWPVssHDMFtj
         AG/pTKLeoheOUJLDBjrikDjXHG1dO79z6AfRLbmsMgGJzIIgEyziVt9lEqncdbiZ/T5U
         dqQb2Xv7TSZpVlfqXlwqCRy6GxmJJ0LMUzHttV+PlL/A8IDh3Uh25Dzw1rkiRcmR2qn5
         QWSbswPlh57itqRvOTYCkOHHO1Zk+WQa4UwrFNykzPyqm8UOaKVgOQusKsx6EsTVStkH
         pQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279908; x=1713884708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApDEEOzWKbr2lAoaPzmlzkmuB1oGm6TlwwUuSX/oB4U=;
        b=f0gKqh+9ehsqahQUku7uQOFBjDs2AQ3i0eA7aN4GYrj/gBcrGVvMiGhxzgfAujzw8V
         0yX6a4Sa0SChZ9ii4kt4JjyjkCZt4zBCriKWs7iwh7LpbeqCB15skt1wfG/wpdFrNsuT
         wJfQdGFYbfbhrxR0cGXtMXz1h+wWlab9Y6h5eSpIATqvOFaclILqLon8NAa+k2RqyWxl
         KGPoCXoE42idewExvxTqG5nAiMS5rqsJaDN6cilsKftW3dny7i/IKUjVUO7WbBqm1tk+
         QOZ5rwUiScQi3/quqpR2Z372CA+YTKWrXNpVgUQ1AmDiDNI0PTWcTXep2q208aGsPuIm
         cMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUicfVp7xCZR725B8nHzyhzQvH7xDnl0t6AoYbe6iA8RpfH+xqThyyHVi/GwDXNvblDo4h2hZKu/8xHjXzIkjKAUhF++fFlZuyviTc8
X-Gm-Message-State: AOJu0YxlSr1czgAUEViMk8s1ITPnVgFT7U3y6By/zlXLIv51DfaQwP+w
	mMAxSRW8VXyRKqwtdOOeRslEY9gZdwDGrLTyricLvzLKQs6W5EQyGYi6Coy9ZNysvF/E71Fw67D
	ghdhXJEoSRWlwdJ+NA57XOC05BjsbqHr7nMQQOkLUgCw2rAQx3q9P
X-Google-Smtp-Source: AGHT+IHvWDLJmei1CN4y1/p2zSA/lQX+UTvY0I6sNXRKd7s7bQlKSOTx4dMhC3HH0AIyV6T3oZc3Drm71XkXXTumgbI=
X-Received: by 2002:a92:c5cd:0:b0:36a:fcc9:64ec with SMTP id
 s13-20020a92c5cd000000b0036afcc964ecmr186375ilt.1.1713279907511; Tue, 16 Apr
 2024 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415095532.4930-1-cp0613@linux.alibaba.com>
In-Reply-To: <20240415095532.4930-1-cp0613@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Apr 2024 08:04:55 -0700
Message-ID: <CAP-5=fWZSPTtk+UjssH4Mhw11CAP0-jZcZAbCesdqrVCnZbu2Q@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix compiling with libelf on rv32
To: cp0613@linux.alibaba.com
Cc: palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:57=E2=80=AFAM <cp0613@linux.alibaba.com> wrote:
>
> From: Chen Pei <cp0613@linux.alibaba.com>
>
> When cross-compiling perf with libelf, the following error occurred:
>
>         In file included from tests/genelf.c:14:
>         tests/../util/genelf.h:50:2: error: #error "unsupported architect=
ure"
>         50 | #error "unsupported architecture"
>                 |  ^~~~~
>         tests/../util/genelf.h:59:5: warning: "GEN_ELF_CLASS" is not defi=
ned, evaluates to 0 [-Wundef]
>         59 | #if GEN_ELF_CLASS =3D=3D ELFCLASS64
>
> Fix this by adding GEN-ELF-ARCH and GEN-ELF-CLASS definitions for rv32.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/genelf.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> index 5f18d20ea903..4e2e4f40e134 100644
> --- a/tools/perf/util/genelf.h
> +++ b/tools/perf/util/genelf.h
> @@ -43,6 +43,9 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void=
 *debug, int nr_debug_ent
>  #elif defined(__riscv) && __riscv_xlen =3D=3D 64
>  #define GEN_ELF_ARCH   EM_RISCV
>  #define GEN_ELF_CLASS  ELFCLASS64
> +#elif defined(__riscv) && __riscv_xlen =3D=3D 32
> +#define GEN_ELF_ARCH   EM_RISCV
> +#define GEN_ELF_CLASS  ELFCLASS32
>  #elif defined(__loongarch__)
>  #define GEN_ELF_ARCH   EM_LOONGARCH
>  #define GEN_ELF_CLASS  ELFCLASS64
> --
> 2.25.1
>
>

