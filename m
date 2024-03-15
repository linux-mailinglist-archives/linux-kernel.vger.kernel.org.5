Return-Path: <linux-kernel+bounces-104713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293D87D2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB07C1C22168
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3944C600;
	Fri, 15 Mar 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ZviRoxDO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2F45C14
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523277; cv=none; b=Nf2utZsfsfJlWlSrvsg7tMszKrzbx7WI7UlSVlyOaUOcMYaxM+Fsbep2Sldzm3seVbBct/xl4bQ2T4LyrSAOMK1XvgE8cMASHsS2PHycSXbuAv7IFNMVUMQrsRPT8eYS98HsQUq5RJVxd/MyU2vRl0Fk3CqituqBkVP5/cfF/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523277; c=relaxed/simple;
	bh=SxJQdfTuoCb2x/lelfOwJHFDyaV1gs/ZM8Bw0k7kT8U=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=gYgmMyRs/DuYm9ugCERWm9BWFpMyjw59Sp1ejMe+gNUP0ycrpfjMsQkPgDCgIr5yEZ6cl1Wx2xbhzXpVfcfH3hDh2a3aGoSQ6Inzdo2cA6TUcopLJ+h3VUjJcOm/GdwDwYaEIktrUEl3V3w6m5VlqW/Y+uBJel3p4pUQsh5MuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=ZviRoxDO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso1099536b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1710523274; x=1711128074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hwKt2WtLIQ3knQVAXCKQv7Q6M4Yg0kZzDjLYdF3FVk=;
        b=ZviRoxDO2qgaPX9Zb/WzLuxFXHY6HtoMYACIfK1Zmpv9iX5fyAfbd2Xg/7k53PJdGD
         TYXElzLDAlWQZkVejrRUkfsO5E6zUq/8YxNP9INxuD80labOqrmhsA4s3yZV/zK4lFgS
         D+C2gBaLAP9y6+OSKLNiSM00RC1lw5mcN113YE1PXicye66RmC6xNOOpVLdcFu2NYP1N
         quRdOGAZleiBj289reHis9F3g3Ul6DwWijQMdOHErOP4Mm/Zfjqi1wkCVGgCLpjj0gk3
         YaSnd6uTmk0bwXpLae7QWL6z2GO8GPiESywuOXpxApUt0xAfKm41wMQEX0ol8b9fIQRt
         Qosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523274; x=1711128074;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hwKt2WtLIQ3knQVAXCKQv7Q6M4Yg0kZzDjLYdF3FVk=;
        b=qwoEVaKFR4oAX5eUBXTv65yj3/pup+vLda0pb/26t+W3RGD4xTg0o1nN7aahFud2EF
         dmH5fSx7hkySz2YZhzllvu36ssFpRQC3yBG8+0c0YGYfJXtBihuh5hFcKuVTYeKWmaAt
         dk7S+S6cWm3yQPzaGoAsSTG8sa5d7qaebLGCryjabEbcn596X9I6ixd+oIO0gv7jpYp+
         2pP+Tff1rIMhN4jy696cwpT2L1cRI0XmHhPCldMSn9HlzjYERAwzLwB6NiEBqZTkR6cJ
         XcJ63i0Xs6DIu0vLO+mP3dC1mVlq11RtmCAQ3MpQopemfOwXuohHYUbDW9m3Gxhl8bNK
         41dA==
X-Forwarded-Encrypted: i=1; AJvYcCVqJrzFyufZ7cP6Eh2QHyWx2lMvRjm9N2Z43HfaTLF+KW1G0vSjgijqICEOaZ0D7/bik1HaQHH933XefNZIMe1g4rcvtIKDZ9kPHJXj
X-Gm-Message-State: AOJu0Yxa61OACFo4ncRWyGtJ/rbk/0INMOxiFpQN1cq3cb5MyUT0KTUT
	1eULf/Uv3eLTMGaVvmEOj0pVwjTvwsXAm54hJU+jntr9EueuWfY/0JdHPzP7rpQ=
X-Google-Smtp-Source: AGHT+IG2d1HwRlz17fSSyKppMsKotmpDN/qlq2y5UrMrzoFTLJfeFmTGXz0aNVPGXLAHhBK3/RdQ9A==
X-Received: by 2002:a05:6a00:14c1:b0:6e6:4ebc:3cd with SMTP id w1-20020a056a0014c100b006e64ebc03cdmr6389370pfu.27.1710523273519;
        Fri, 15 Mar 2024 10:21:13 -0700 (PDT)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id g1-20020aa79dc1000000b006e6c733bde9sm3630800pfq.155.2024.03.15.10.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:21:13 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:21:13 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Mar 2024 10:16:22 PDT (-0700)
Subject:     Re: linux-next: manual merge of the risc-v tree with the arm64 tree
In-Reply-To: <20240315103146.225b653b@canb.auug.org.au>
CC: Paul Walmsley <paul@pwsan.com>, Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>, jisheng.teoh@starfivetech.com, linux-kernel@vger.kernel.org,
  linux-next@vger.kernel.org, locus84@andestech.com, peterlin@andestech.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-cfc51b24-8f65-4b87-a258-71a9893cb6fe@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 14 Mar 2024 16:31:46 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the risc-v tree got a conflict in:
>
>   drivers/perf/Kconfig
>
> between commits:
>
>   c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
>   f0dbc6d0de38 ("perf: starfive: Only allow COMPILE_TEST for 64-bit architectures")
>
> from the arm64 tree and commit:
>
>   bc969d6cc96a ("perf: RISC-V: Introduce Andes PMU to support perf event sampling")
>
> from the risc-v tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Sorry, I guess maybe I should have looked at my queue before agreeing to 
send the starfive PMU patches via the arm64 tree.  The Andes stuff 
touches a bunch of other RISC-V bits, but I'm happy to do a shared tag 
or something if folks want.

Otherwise I'll just point this out to Linus when I send my PR -- I'm 
going to hold off on that this morning, as I just realized I should have 
taken this GUP fix and thus want to let things bake a little longer.

>
> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/perf/Kconfig
> index 004d86230aa6,564e813d8c69..000000000000
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@@ -86,15 -86,20 +86,29 @@@ config RISCV_PMU_SB
>   	  full perf feature support i.e. counter overflow, privilege mode
>   	  filtering, counter configuration.
>   
>  +config STARFIVE_STARLINK_PMU
>  +	depends on ARCH_STARFIVE || (COMPILE_TEST && 64BIT)
>  +	bool "StarFive StarLink PMU"
>  +	help
>  +	   Provide support for StarLink Performance Monitor Unit.
>  +	   StarLink Performance Monitor Unit integrates one or more cores with
>  +	   an L3 memory system. The L3 cache events are added into perf event
>  +	   subsystem, allowing monitoring of various L3 cache perf events.
>  +
> + config ANDES_CUSTOM_PMU
> + 	bool "Andes custom PMU support"
> + 	depends on ARCH_RENESAS && RISCV_ALTERNATIVE && RISCV_PMU_SBI
> + 	default y
> + 	help
> + 	  The Andes cores implement the PMU overflow extension very
> + 	  similar to the standard Sscofpmf and Smcntrpmf extension.
> + 
> + 	  This will patch the overflow and pending CSRs and handle the
> + 	  non-standard behaviour via the regular SBI PMU driver and
> + 	  interface.
> + 
> + 	  If you don't know what to do here, say "Y".
> + 
>   config ARM_PMU_ACPI
>   	depends on ARM_PMU && ACPI
>   	def_bool y

