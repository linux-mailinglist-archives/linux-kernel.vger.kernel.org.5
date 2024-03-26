Return-Path: <linux-kernel+bounces-118517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC31588BBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDBF1F3D7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE6133425;
	Tue, 26 Mar 2024 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW209+LY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD412AAEC;
	Tue, 26 Mar 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440620; cv=none; b=GBwL+GClP5Mgy7VZZTzx3OyeaZIpdubxPqdpBd2DWfaCvJ5gSEpW6fm8PFPhiob+CwqX+X58mXATP612YknMqL/HYUXnAg60OSGaKAOUTMliGND0RdxtsThI8wjkZ8nCQigF7nhqVWM/qVKot/Hb5gnQGxpYfm4iaBokwEIly7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440620; c=relaxed/simple;
	bh=UE+rBO/SzfXH+xegaXkyksSZkdDCOyLf+Zjv/2b9PkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3vCC0T1MCzQFEaF3yH5T3SVup78tRhZUBOHs8e3oI0v8tsrg3zEq2i+PSpdUz07yqXRcBlLPC8Axo6U5YDjzckH2/LbxJeY8qlKFnvDQJYVPdgCv8jKAP22GfV04JXFp1Tg2a59NdOfGIieW4I/msP7LnehD2llHPYllzJqqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW209+LY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d599dbabso6832286e87.1;
        Tue, 26 Mar 2024 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711440617; x=1712045417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzQhaG35S/6UwDeOcfUmN5ro7w9ToDnNuXjMnx/wsTI=;
        b=VW209+LYXSpN8ilQ91OjEQYyxRJT4CMsKwJ1HtquVeQN2G2/OzHyjYuHyVCE/fIPh4
         OEJGGwCeNG1/4vOYTZmhNM8EOw9SOt8aWw6+QTfMf8EET2EQEi6Gbu4+IdrgVqiPDdTO
         tFL0LkmbJpnqbUK6UzOrjQtvy+jY2bbwIpUaPsivrCartPyR29GPEmi7zFV2ghPFegwQ
         B5LAKGsoTIxms3gbzA2vfqwX6ImzaX6CO9L8z2WO36Hbd7WyjxVULCiGcgrXj7SwWsZN
         XKpcFbnKgU4r3ESUjZDmlK5XZoVq6bAurg/e+KSU5Fzj/7Sryvw5o3LvB+IvxPnyKd9t
         MMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711440617; x=1712045417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzQhaG35S/6UwDeOcfUmN5ro7w9ToDnNuXjMnx/wsTI=;
        b=kAcKnf6dKztLOZ98+lPgkMsxwQBvORIWevHRygd1Q6Q+JjfzbuJp5JOdT9byr5l8L7
         RES+0AQKvSI0S/ycPTVe0TTMxzt+HyGQlQcxGIkk97CUIyUWwnJYsKYe7AoaqgBeFEDJ
         7+fxvfCf0ve4fZgWgQ4qEzFfFrI3pHY3sLiVeMFHI3+Ryw8nowJwIubVo5nBUh/cg4fU
         liFVmQ4j2W4TNoP8MKoepDCw8Yggj/HzIDiEApQr9+Dvv2h2Mv3iL1wepZhNSfGv43hR
         bmzh/9ScTzvMyL63hkx7naTB8vB0eomXgzJDkkWeJK8qdxSd9n6QYM3B88MSzw80qcGB
         birA==
X-Forwarded-Encrypted: i=1; AJvYcCXdZqbaDo4fCs9OkUHjp+0bTEovGeyu/xLl4bm/Wq1uYXGSDKj8aqDaSgCqkIJMzsYK6OQvFqMrFuI+cUVb34+Ege23rGLSeLSqF8ch
X-Gm-Message-State: AOJu0YwCAaxeEYG5Je0tNjJ3rpPirvWAAX1ocwFuobw0+FfIM/dt9ryu
	4sEXP8Iq8APw4bGRmT9ZIgu+wvXu6YWfE2P50dBL15WUIuIv7h2k
X-Google-Smtp-Source: AGHT+IF8yfTE2aE3kJKB+qSMX2f+wOgVJF6x8Yxdvk7qZLHIUGBPxD2j1bvns39914MaPNqihYxK1Q==
X-Received: by 2002:a05:6512:616:b0:513:ccec:a822 with SMTP id b22-20020a056512061600b00513cceca822mr6810025lfe.28.1711440616315;
        Tue, 26 Mar 2024 01:10:16 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id t25-20020a056402241900b0056bd13ce50esm3828015eda.44.2024.03.26.01.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:10:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 09:10:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH 1/6] x86: add kconfig symbols for assembler VAES and
 VPCLMULQDQ support
Message-ID: <ZgKC5dcqWSEkwuTX@gmail.com>
References: <20240326080305.402382-1-ebiggers@kernel.org>
 <20240326080305.402382-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326080305.402382-2-ebiggers@kernel.org>


* Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Add config symbols AS_VAES and AS_VPCLMULQDQ that expose whether the
> assembler supports the vector AES and carryless multiplication
> cryptographic extensions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/x86/Kconfig.assembler | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
> index 8ad41da301e5..59aedf32c4ea 100644
> --- a/arch/x86/Kconfig.assembler
> +++ b/arch/x86/Kconfig.assembler
> @@ -23,9 +23,19 @@ config AS_TPAUSE
>  config AS_GFNI
>  	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
>  	help
>  	  Supported by binutils >= 2.30 and LLVM integrated assembler
>  
> +config AS_VAES
> +	def_bool $(as-instr,vaesenc %ymm0$(comma)%ymm1$(comma)%ymm2)
> +	help
> +	  Supported by binutils >= 2.30 and LLVM integrated assembler

Nit: any reason it isn't called AS_VAESENC, like the instruction itself?

The other new AS_ Kconfig symbols follow the same nomenclature:

> +config AS_VPCLMULQDQ
> +	def_bool $(as-instr,vpclmulqdq \$0x10$(comma)%ymm0$(comma)%ymm1$(comma)%ymm2)
> +	help
> +	  Supported by binutils >= 2.30 and LLVM integrated assembler
> +
>  config AS_WRUSS
>  	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
>  	help
>  	  Supported by binutils >= 2.31 and LLVM integrated assembler

With the nit above fixed:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

