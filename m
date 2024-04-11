Return-Path: <linux-kernel+bounces-141391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2768A1D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7555928978E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D721DB521;
	Thu, 11 Apr 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DukRS+iK"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA7383A4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855757; cv=none; b=THpFescLfIwauarQwWzTOtT2NlgGHeltktHAU4ngEkvbO7oBHW7L3QBK8Bh9SkDwop4M+oPQ0NFUbVPpCWPvnf6LMtBvKO+AEePRnSS1DrhLwQ4/FDu9NucwyhC3vvqauiPWwydzchiTl2qSCsc22nQqGoCg56CyLInrBjDmHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855757; c=relaxed/simple;
	bh=hz5iiCnU83ah651kQ7jAolMEnarIi+rVezSEnYBEX+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyIkG5RocQCQdOnMN6bJqh8AZiT7UWKvMtHUkwRZMJej6QCFc3W/g/fcibs/3paCQXvNkKnPadwPSph2BB2QLqPAxnUHZawAYrJqV+/wjM2tucPTtvPdpRuNKyeKX/NmPW+GzwdYJh2lMaPVrcrmR9Dh3K3vDvtr2cGKjwGVcHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DukRS+iK; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e3e522d803so548557241.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712855754; x=1713460554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To4z9UmMI9cuRfj5YaEO7iuspgkYCOJTB+CRNWJcwHA=;
        b=DukRS+iKTS5jAzmhcXBlguGJz9yTR+O3SZupzU13FcEO0NELV9FsnqRNyea06fhV3S
         y9f6UsGLens3zcmwA3l8LxOj+bHedKLtepsmbn3QXDNBTu4FOFbjxAJs0VHygr+NOCHk
         VLn2+jaDyDmumiaQU2C0TVa/PGM45/6ucMGpXPLp8FTrPVNJzRLhtugwmshvHS1tx6mt
         e0k0HySLkaQA0DPu2LRFUMBJimK9UecfzwLUh7EvtwkYqW6M0VpteDi/h5t3PIbJckMC
         lRT5ZlGWPXEfbwxtxnaHxYFW5O+CkG2Ig09IeGWDfnrMCszQ+SZ4iDLvkxatCdTe8gvj
         G5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855754; x=1713460554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To4z9UmMI9cuRfj5YaEO7iuspgkYCOJTB+CRNWJcwHA=;
        b=w6S9fSz0jHQXpvaltU746t1GUCvzC4dgGoukz2zlIppTfoUJvZOGTPqko+BG18gWFh
         qFkwJV7bH7a0SAxff9wavuw2gANPYA0Qv28QrAxgQ+yj5hXaCJ380pf8sDUjT8a3EZBy
         TRSSLjYZKzndWzTg71XgeI3LOmafMq7wPM1SHjJKdTc7UBTWhDyzMb5jeosyT667vQt4
         HtaEqX0ywxKAME6tzjYx1o1LYajGve/b31z6joiALG+egki36kKInSuh9TVpo2xfD7eq
         N9S2MkoKtKEIF6ACZBaAMEKcKRoCVlFIq5SX5FBAcTDxdghV4gTBxKT86EgluaJuAWA4
         66Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUudi/cyFItksXKShQgAbItAn8pO8BNLKXM8jc1Wuq82a9QzbG3ELtHnYTV01lWx8hrkwnFpKNgIX3s1LhPCbxqw7rXSpD4TdB8/Zsu
X-Gm-Message-State: AOJu0YzgdIuXI+eJPPBpy5/UusOCMaeXl1MTa0notK7YDyG+MHMnDpmJ
	HOZXn/GtOJ7lYoCDXqeW3PRIz5w5lIx0YufAdXhNp+Z+X59X0k98txYZFGukN0LF9/YsbzbMrNE
	F22dUPjdcd8GtLrQUkOdiQT3WS28jiQbkf6Wy
X-Google-Smtp-Source: AGHT+IG8Mab463ffes2ANkePLtsCLN4JtRtaHVbTkLMIpOIAKgLXt4OnkFal81PiCyeO8tfml6LLHVcoAQLc8PxSbOQ=
X-Received: by 2002:a1f:6682:0:b0:4ce:96b7:c2f6 with SMTP id
 a124-20020a1f6682000000b004ce96b7c2f6mr2537665vkc.5.1712855753645; Thu, 11
 Apr 2024 10:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409061043.3269676-1-debug@rivosinc.com> <20240409061043.3269676-3-debug@rivosinc.com>
In-Reply-To: <20240409061043.3269676-3-debug@rivosinc.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 11 Apr 2024 17:15:17 +0000
Message-ID: <CABCJKuee-6GGDDjvByCkikR02gka2BNhwRVBw6UAwEcmSQposQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] riscv: add landing pad for asm routines.
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, andy.chiu@sifive.com, 
	hankuan.chen@sifive.com, guoren@kernel.org, greentime.hu@sifive.com, 
	cleger@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
	conor.dooley@microchip.com, mchitale@ventanamicro.com, 
	dbarboza@ventanamicro.com, waylingii@gmail.com, sameo@rivosinc.com, 
	alexghiti@rivosinc.com, akpm@linux-foundation.org, shikemeng@huaweicloud.com, 
	rppt@kernel.org, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	willy@infradead.org, jszhang@kernel.org, leobras@redhat.com, 
	songshuaishuai@tinylab.org, haxel@fzi.de, samuel.holland@sifive.com, 
	namcaov@gmail.com, bjorn@rivosinc.com, cuiyunhui@bytedance.com, 
	wangkefeng.wang@huawei.com, falcon@tinylab.org, viro@zeniv.linux.org.uk, 
	bhe@redhat.com, chenjiahao16@huawei.com, hca@linux.ibm.com, arnd@arndb.de, 
	kent.overstreet@linux.dev, boqun.feng@gmail.com, oleg@redhat.com, 
	paulmck@kernel.org, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:12=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> SYM_* macros are used to define assembly routines. In this patch series,
> re-define those macros in risc-v arch specific include file to include
> a landing pad instruction at the beginning. This is done only when the
> compiler flag for landing pad is enabled (i.e. __riscv_zicfilp).
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/linkage.h | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/li=
nkage.h
> index 9e88ba23cd2b..bb43ae7dadeb 100644
> --- a/arch/riscv/include/asm/linkage.h
> +++ b/arch/riscv/include/asm/linkage.h
> @@ -6,7 +6,49 @@
>  #ifndef _ASM_RISCV_LINKAGE_H
>  #define _ASM_RISCV_LINKAGE_H
>
> +#ifdef __ASSEMBLY__
> +#include <asm/assembler.h>
> +#endif
> +
>  #define __ALIGN                .balign 4
>  #define __ALIGN_STR    ".balign 4"
>
> +#ifdef __riscv_zicfilp
> +/*
> + * A landing pad instruction is needed at start of asm routines
> + * re-define macros for asm routines to have a landing pad at
> + * the beginning of function. Currently use label value of 0x1.
> + * Eventually, label should be calculated as a hash over function
> + * signature.
> + */

I haven't seen the compiler implementation for fine-grained Zicfilp
yet, but in the kernel at least, this would ideally reuse as much of
the KCFI plumbing as possible. For example, since only C code has type
information, we left the type hash computation for the compiler, which
allows assembly functions to just reference the appropriate
__kcfi_typeid_* symbol.

Sami

