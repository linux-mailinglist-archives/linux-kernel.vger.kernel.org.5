Return-Path: <linux-kernel+bounces-130434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AF2897815
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26732822CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67A1153580;
	Wed,  3 Apr 2024 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="kH8CMOU9"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEC1534F2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168527; cv=none; b=dnmSaP+cl1xg28lD/Moy1WHuNr95MAbZelnE7TDiF2OI2iAnORtW18BFg63RACB+mvs69zEwUn3k2zFqgr7KWTnz/QkYS6LlrYhDghUvS3Vq1vyHQi5manOE1CYkrwacIT0pH06uUU/8VlJOy2HVi3IcbvMCNgxnADHIaBwCCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168527; c=relaxed/simple;
	bh=6+2nrIGa61dq0/VeelCYA2bW5+YZa0WC5m2ANvBtBis=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=nBB+EuzefO9MfjCLE57g/OlNhl+gWFYfAD5nOq7OJ/suNv4gP9CWgrEqeHMNd1naJjS7T1XJ3u+9A5u8Je9p3MOqOZfkJjo4aBFEItMRj2Ycs+r7eosuFUYfBKRP93eH19Y6hzxu8a8IrD9oFBEhlhaR47Ds+Pgv/mDw5tFnPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=kH8CMOU9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eafbcc5392so88788b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712168524; x=1712773324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+Kf1VtrPbxx/AIfqj2WJbrl2k9+u/D2i3gfwNLRUnA=;
        b=kH8CMOU96ebcbVpq2GeI07d1Wtg+wghMC6HXmp/DhhqNalxStujc+HueIngwe2s+hB
         cXldia5binjQzZxnqYN8Bf9527lL1DO5w9xgfJaMY0B6YRY3Gvq8348Y1YMxmL+2k/L0
         teHuivnw5vZflVpByEpu5EpnkIl1BHedDL3qwxpDCGJ4JMC5ckfM52PWReXVUWHG0OTc
         lI6P40zoHiK7+SHa5gIXS0E8fGz8kVX3OZs6j7FU/Bb9es2F5mqUjWD7bTPLCag10Bml
         etrnJgsULAsgJxQn15YzB3AVlvF37B1N1IoYHn2yjU7FfdhW1wkqrxDXjkSH1ZiRinkX
         rgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168524; x=1712773324;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+Kf1VtrPbxx/AIfqj2WJbrl2k9+u/D2i3gfwNLRUnA=;
        b=wERQTTJ6IzSghxUFg01gMiF/DkAqSs175N8R5IQvSiGKSj0cSDie2GwaQCJGJXxLTh
         zmONx0jqpQtpbjOcC23r70R11gvYpIk6u7mlgBbrYVa8ChAopgPhZFRteKUdgGcZIebT
         mT0+AXyO7Awvm0eDLrJNbXfPV6oAA4uqRyQs9zCVbluwOxwwSiDk+palWq+ldnlaMNeR
         Ka83JnT4jiqlMym21ICYsgOUeKWNTfwPyQgigMmWMTCm0wm/VvOLCISotTfB4Fm0UPT8
         MU7JMuCfy2G4RGEZzDviEDrupJgOP0DCk1U/LgR6f3pweCwirYKPXe3G4hRes/AFkH/i
         idCA==
X-Forwarded-Encrypted: i=1; AJvYcCVdX6oj0kPnOdcWudx8d430R+fuCXuGIUZ6t09KRvqwei9nYSirBpQLma9y2wFKmmhPAmLFCuKzC6EjuOqTSl0OIGqQpiqsjxF+5M7V
X-Gm-Message-State: AOJu0YwfxCCRQFXPtOb27M3BpZrIKhoEcxl+r7ZxZDw9HbUcjiwCoRHT
	I7kL2GjjVLdDeMwDE9kes69AlKqir9HLbwzFIcc8QCeTSe6Hv7hRAhb1bCKw6XU=
X-Google-Smtp-Source: AGHT+IGty08VcqdEljCIJkfJOB8iEizvRWz0FfAsjUhmWizntDOrlClCKtIX4KMfuzGZun6DYHreSw==
X-Received: by 2002:a05:6a20:7d88:b0:1a3:af38:31de with SMTP id v8-20020a056a207d8800b001a3af3831demr579540pzj.4.1712168524117;
        Wed, 03 Apr 2024 11:22:04 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902864200b001e2602fd756sm4966719plt.95.2024.04.03.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:22:03 -0700 (PDT)
Date: Wed, 03 Apr 2024 11:22:03 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Apr 2024 11:21:32 PDT (-0700)
Subject:     Re: [PATCH v1 1/2] RISC-V: drop SOC_SIFIVE for ARCH_SIFIVE
In-Reply-To: <20240305-praying-clad-c4fbcaa7ed0a@spud>
CC: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
  Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-44dd5bcd-50fe-4f09-bf3e-d2ba2e6cfc74@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 10:37:05 PST (-0800), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> All the users in the kernel are gone and generated .config files from
> previous LTS kernels will contain ARCH_SIFIVE. Drop SOC_SIFIVE and
> update the defconfig.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig.socs      | 3 ---
>  arch/riscv/configs/defconfig | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index e08e91c49abe..e85ffb63c48d 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -14,9 +14,6 @@ config ARCH_RENESAS
>  	  This enables support for the RISC-V based Renesas SoCs.
>
>  config ARCH_SIFIVE
> -	def_bool SOC_SIFIVE
> -
> -config SOC_SIFIVE
>  	bool "SiFive SoCs"
>  	select ERRATA_SIFIVE if !XIP_KERNEL
>  	help
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 89a009a580fe..ab3bab313d56 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -27,7 +27,7 @@ CONFIG_EXPERT=y
>  CONFIG_PROFILING=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_ARCH_RENESAS=y
> -CONFIG_SOC_SIFIVE=y
> +CONFIG_ARCH_SIFIVE=y
>  CONFIG_ARCH_SOPHGO=y
>  CONFIG_SOC_STARFIVE=y
>  CONFIG_ARCH_SUNXI=y

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

