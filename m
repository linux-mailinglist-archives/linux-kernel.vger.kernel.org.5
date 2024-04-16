Return-Path: <linux-kernel+bounces-147531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553178A75CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35261F2149D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30543AC5;
	Tue, 16 Apr 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kk0hfw1w"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266303C08F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300031; cv=none; b=gEPyXIo390HOjlqkWGBWwRiKKgNSgrLABSNWQNqLDL3IgDaA2iyJqDuDOiamPVvtNhZgnoyKjG3kxvQi2UrwPBTdnvOnNiXj1hIj534Ev4HlWqaZDxNmQQ/lJom+51saMl+M+srimU1AxqDpKeXcHTifQtoNfa77QpEHhg1e4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300031; c=relaxed/simple;
	bh=udfGyNMCI3v/iLI3t4atMNcBgxXlV953jlv2qfOoC/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+pLBJo+o0t9mvkVd4NvfLvLY3FZXtPQYH/KovaDc36zy40fo3pDlH7bwoWxG32X9wDETw3Ym5BgtIaJYb8BeITGFSGasXkWZ8ZSnwsb/Lcpy3foFPIgSWqdAI5e3AsT4kIKyjwU+RUrtDe88mJKqQlBEvAqZO1DTKs+4Qnwp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kk0hfw1w; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a53a4a283eso4072924a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713300028; x=1713904828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjtMTyKyhNTcN+UpxkEkTpYsqk+JWf4FRaAP28rhDY=;
        b=kk0hfw1wkkC0Wk+DxI+cPQvL/G0LuAV1OIKJLov6XhTWvuYHCLs6A2FaaNphcFJ65i
         tCMEt8F4UVef7z7tL5/cqzJr2oWaHfqGBbxxE7uuWEodcMfUAlE+tUYg3hHUB2FXO5NF
         v8WF834COY9Sw4eJG9dL5ZcE+ICKwnMcesrKyjbp1xg/isv2I2Rg/O2+FLDFEA2yEEkb
         8J4DzOizxlMxnmrb4J0J3mU3MKxd265wv6U+AVnuEYu1ZD7KS57iRkrdxO2hMJis9TVc
         EVJOI8mffmdQpu/h8XsXs7TujY2DwJcDLbk4xpntvCTcnkpPMcfc/Kwr9NOEyzWgmND2
         wWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713300028; x=1713904828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVjtMTyKyhNTcN+UpxkEkTpYsqk+JWf4FRaAP28rhDY=;
        b=V6xFKmyulpZVZ8Vj7WyFQRQ8Z6mRYa8lDvAzo2sif61j/azGzQLUwKQc5QPsGZIkpY
         63AuETNpf2aGB6mnC7MrDIeWPrqUfp9/YL8kD6RnDD7NFh1wRm0wr24+Jl3kJnagtM+E
         6d9r9TwtrGpM/MjWGt4bQiyIePoKgEa5AjA4lCaDhDI4nhhXEo6zHKhMtauiuZJ2nryr
         Zyz3F/g+ivuvu7HEQHFzGLYKIDnzze2lH1cnW872iOrZw8U5SS2Qp+EeBAs9cMMOT1P3
         HcKtxslq2jKepAPpAV1OR1aVyTWPUq8mdb3U7DWVeDM1Gll3aS+4iRrXrn1wRAcWD6o9
         1v/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz7kFz8mb+eHSYNK0liTcAOb9TWPuXX7xHKJqi/M3VtVm/V4IVSmMdHDNYl/htQOENORr9Sox68FTYtFuQyWNTnWEZrVTZ3KEoedzQ
X-Gm-Message-State: AOJu0Yzc2sKta1BnXHZOuB7hAZEsl/8gS3OR6Y5ILRROEyI21loF6COk
	Shrhsi3UzZWf2gLLQgBrPkb5eYKhmNit+wMXPa/8VTJBqEVsArcc7IkT8RzQwhY=
X-Google-Smtp-Source: AGHT+IHM3uUWSKt1fI9qO1XxrOHXkeZZaIcR3NFlAXNG12q5BaEwGvMZBQDoAX4Ml6q5YxA9kVBZNQ==
X-Received: by 2002:a17:90a:e648:b0:2a2:acf3:4108 with SMTP id ep8-20020a17090ae64800b002a2acf34108mr16278208pjb.0.1713300028470;
        Tue, 16 Apr 2024 13:40:28 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090aeb0600b002a574ab7f5esm12038pjz.53.2024.04.16.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:40:28 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:40:25 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/17] riscv: cpufeature: Fix thead vector hwcap
 removal
Message-ID: <Zh7iOQ3Snf53HvFV@ghost>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-1-c7d68c603268@rivosinc.com>
 <20240416-swipe-flattered-7cdccc01f0fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-swipe-flattered-7cdccc01f0fe@spud>

On Tue, Apr 16, 2024 at 04:03:20PM +0100, Conor Dooley wrote:
> On Mon, Apr 15, 2024 at 09:11:58PM -0700, Charlie Jenkins wrote:
> > The riscv_cpuinfo struct that contains mvendorid and marchid is not
> > populated until all harts are booted which happens after the DT parsing.
> > Use the vendorid/archid values from the DT if available or assume all
> > harts have the same values as the boot hart as a fallback.
> > 
> > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h   |  2 ++
> >  arch/riscv/kernel/cpu.c        | 36 ++++++++++++++++++++++++++++++++----
> >  arch/riscv/kernel/cpufeature.c | 12 ++++++++++--
> >  3 files changed, 44 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 6e68f8dff76b..0fab508a65b3 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1
> >  static inline void sbi_init(void) {}
> >  #endif /* CONFIG_RISCV_SBI */
> >  
> > +unsigned long riscv_get_mvendorid(void);
> > +unsigned long riscv_get_marchid(void);
> >  unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
> >  unsigned long riscv_cached_marchid(unsigned int cpu_id);
> >  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index d11d6320fb0d..8c8250b98752 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
> >  	return -1;
> >  }
> >  
> > +unsigned long __init riscv_get_marchid(void)
> > +{
> > +	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> > +
> > +#if IS_ENABLED(CONFIG_RISCV_SBI)
> > +	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> > +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> > +	ci->marchid = csr_read(CSR_MARCHID);
> > +#else
> > +	ci->marchid = 0;
> > +#endif
> > +	return ci->marchid;
> > +}
> > +
> > +unsigned long __init riscv_get_mvendorid(void)
> > +{
> > +	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> > +
> > +#if IS_ENABLED(CONFIG_RISCV_SBI)
> > +	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> > +	ci->mvendorid = csr_read(CSR_MVENDORID);
> > +#else
> > +	ci->mvendorid = 0;
> > +#endif
> > +	return ci->mvendorid;
> > +}
> > +
> >  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> >  
> >  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> > @@ -170,12 +198,12 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
> >  	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> >  
> >  #if IS_ENABLED(CONFIG_RISCV_SBI)
> > -	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > -	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> > +	ci->mvendorid = ci->mvendorid ? ci->mvendorid : sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > +	ci->marchid = ci->marchid ? ci->marchid : sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> 
> Can we please not have double ternary stuff? This is awful to grok :(
> Can you do
> if (!ci->m*id)
> 	sbi_spec_is_0_1() ? 0 : sbi_get_m*id();
> instead? I think that is much easier to understand.
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Sure, thanks!

- Charlie

> 
> Cheers,
> Conor.
> 
> >  	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
> >  #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> > -	ci->mvendorid = csr_read(CSR_MVENDORID);
> > -	ci->marchid = csr_read(CSR_MARCHID);
> > +	ci->mvendorid = ci->mvendorid ? ci->mvendorid : csr_read(CSR_MVENDORID);
> > +	ci->marchid = ci->marchid ? ci->marchid : csr_read(CSR_MARCHID);
> >  	ci->mimpid = csr_read(CSR_MIMPID);
> >  #else
> >  	ci->mvendorid = 0;
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 3ed2359eae35..c6e27b45e192 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  	struct acpi_table_header *rhct;
> >  	acpi_status status;
> >  	unsigned int cpu;
> > +	u64 boot_vendorid;
> > +	u64 boot_archid;
> >  
> >  	if (!acpi_disabled) {
> >  		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> > @@ -497,6 +499,13 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  			return;
> >  	}
> >  
> > +	/*
> > +	 * Naively assume that all harts have the same mvendorid/marchid as the
> > +	 * boot hart.
> > +	 */
> > +	boot_vendorid = riscv_get_mvendorid();
> > +	boot_archid = riscv_get_marchid();
> > +
> >  	for_each_possible_cpu(cpu) {
> >  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
> >  		unsigned long this_hwcap = 0;
> > @@ -544,8 +553,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  		 * CPU cores with the ratified spec will contain non-zero
> >  		 * marchid.
> >  		 */
> > -		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
> > -		    riscv_cached_marchid(cpu) == 0x0) {
> > +		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
> >  			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
> >  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
> >  		}
> > 
> > -- 
> > 2.44.0
> > 



