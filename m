Return-Path: <linux-kernel+bounces-153900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382EE8AD4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD7B2345D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82E155326;
	Mon, 22 Apr 2024 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cUbfZ3U7"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410C154432
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813244; cv=none; b=PnfrKN7zrescZTg2QnVFR5xdGBPPGoE4DUqpUMnBLMoJ6h5I1joMklGtIfAW4X9zSU4u+t3ARNfDNMlmnVOYeSeDOJ1DQvYmf9jB0VDPXDCNNFJvBOe2LfufrVrK6BfnVaPB0SiL+A/eNiVdfQOx/NbChn5hzaqDe1Po8Bai8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813244; c=relaxed/simple;
	bh=OUQI9dennHHWuhyJk43erIWoOeZAT/TqxEwk7sv3ZSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcnifPSAeZ35oK/NXrDIS5CKPW+UcazdPonHsP+B1WvDM+sjFj62YzKS7CbtbVz7Ts+iNjkvEtCMLaj3bE9Zfp5T176fx8U7BQZYaGuXCDxfcilNcbDkzgOEPmE9YW1fdbII/dKPb8fM9k0I7YUGKeD4MlH6P2YH3gigs84FQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cUbfZ3U7; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61b4387ae4fso29563847b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713813241; x=1714418041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1scUmSJ5uGPUbNG6hIM1Mj3BSCgLvK4E9dbi4ZuMCc=;
        b=cUbfZ3U7JkDHqwY2lMeiRHdvgrETBZGyUzkqCs/96RREeYigYsJB1PySso9BcUI3//
         uJ9hgt/9z7lwJRlXQbL2K79CDavwf/++YEywxmYEKV/o8oTSyDb/yLIMDFtdb6NnP3Ge
         9YZK3aaWv66aay2u0lZ4h71gZgHf2YMnvJEXTHAy4pU2ABqLKHJRiP3Nrx3Ion9FTnqV
         lFwVEtwagxT4W8vsCgNUsO+u/fTIlsuhOwmdMXYGapRQCnnzl+dhbFQ+X/zoGNs2kdgu
         DTz+CXAJteu1IVV4x5Fl7MXpaR9wBM0bxdwrxx2h6m0D6cxl5t5UfHgcw+Ndl7eIVxNe
         BZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713813241; x=1714418041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1scUmSJ5uGPUbNG6hIM1Mj3BSCgLvK4E9dbi4ZuMCc=;
        b=GQWblMb10DjUoXxp/Vx+P3eaK6mCnmrUlbjC2pH3M9NwoUDZET3ZwLXy/vwhz210mV
         XYBhr4gPH2CDevsJlkPv0PRIPOYMlsvX4ZJY53HEOhEZ62GfkG66+Is6pjL74SjEUYQ4
         1MRzLXpbBPVT1mgyC7PFOt7CyWUJfyb8VwIJ66OKSdGlvnlFzmd/640P+OCtp2qfImMj
         Whssw3/zUOBMH2bXiLyLM4tA7p40WQ0EJWVKiEBW6XSKqgzLBtTfxIUyHjJh8fRn38Vj
         S1bR2dC8+qnxfLEoInYcgU0sdU3sMMNnWeEX/pWpL256eDQPjxfpWgn/ZC+KfDXvRmex
         7qjw==
X-Forwarded-Encrypted: i=1; AJvYcCUN+wsnPJVj2uwL73NHMa1iqAPfBUH5lpTu0aQIII8yOz4Z4LvCbf7FaD1E7XK6FgIoihSV1DwZ+Tnj2V01hfCPB8eC1Q6VGjahlfFU
X-Gm-Message-State: AOJu0YwOf0e3ngjVnroVucHJk5FI6jm26/njYiVI2RVDnxWk04G2YwCw
	pCexgM1OgPMuxUxZQae0Nh7fbTcLs9oEQ3y/uJd1XMkpXJwarF+3BHy5169zSmw=
X-Google-Smtp-Source: AGHT+IEh+PQDiIdCy0QfaSEbiaLMuK5KgJ09F4nU0J2J8VhKDhoiFqsBkQ+g/bfcFms2IMO+uk2PgQ==
X-Received: by 2002:a25:b317:0:b0:dca:59a7:896b with SMTP id l23-20020a25b317000000b00dca59a7896bmr11388887ybj.50.1713813241302;
        Mon, 22 Apr 2024 12:14:01 -0700 (PDT)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id t188-20020a25c3c5000000b00dc6c58ae000sm2185935ybf.16.2024.04.22.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:14:00 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:13:59 -0400
From: Charlie Jenkins <charlie@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	schwab@suse.de, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "riscv: disable generation of unwind tables"
Message-ID: <Zia29wYvScRVdXUP@ghost>
References: <20240416013138.28760-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416013138.28760-1-zong.li@sifive.com>

On Tue, Apr 16, 2024 at 09:31:38AM +0800, Zong Li wrote:
> This reverts commit 2f394c0e7d1129a35156e492bc8f445fb20f43ac.
> 
> RISC-V has supported the complete relocation types in module loader by
> '8fd6c5142395 ("riscv: Add remaining module relocations")'.
> Now RISC-V port can enable unwind tables in case eh_frame parsing is
> needed.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 5b3115a19852..9216bf8a2691 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -94,9 +94,6 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
>  	KBUILD_CFLAGS += -mcmodel=medany
>  endif
>  
> -# Avoid generating .eh_frame sections.
> -KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
> -

There are a lot of orphaned sections created by this, which throws a lot
of warnings. These warnings will only be present on GCC-13+ since
-fno-asynchronous-unwind-tables was a default before GCC-13.

The .eh_frame orphaned sections can be resolved by including

eh_frame : {*(.eh_frame)}

in arch/riscv/kernel/vmlinux.lds.S. arm64 places it in the init section,
but outside init_data and init_text, so right after the .alternative
definition seems like a good place.

init.eh_frame sections in drivers/firmware/efi/libstub also complain
about being orphaned, and other architectures have disabled unwind
tables for that compilation unit, so -fno-unwind-tables and
-fno-asynchronous-unwind-tables should be added to
drivers/firmware/efi/libstub/Makefile for riscv.

This also causes the resulting image (with defconfig) to increase from
22M to 24M. There are currently no users of unwind tables in riscv so
this should be hidden behind a config. arm64 uses this config as:

# Avoid generating .eh_frame* sections.
ifneq ($(CONFIG_UNWIND_TABLES),y)
KBUILD_CFLAGS   += -fno-asynchronous-unwind-tables -fno-unwind-tables
KBUILD_AFLAGS   += -fno-asynchronous-unwind-tables -fno-unwind-tables
else
KBUILD_CFLAGS   += -fasynchronous-unwind-tables
KBUILD_AFLAGS   += -fasynchronous-unwind-tables
endif

Using this same config name for riscv would allow riscv to use the
standard .eh_frame code introduced in
https://lore.kernel.org/linux-arm-kernel/20221027155908.1940624-2-ardb@kernel.org/.

This config is only enabled if some other config selects it in arm64,
but riscv does not contain any users so maybe this config can be left
unselected until there is a user of unwind tables in riscv.

- Charlie

>  # The RISC-V attributes frequently cause compatibility issues and provide no
>  # information, so just turn them off.
>  KBUILD_CFLAGS += $(call cc-option,-mno-riscv-attribute)
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

