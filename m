Return-Path: <linux-kernel+bounces-166148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E68B96D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D901C21DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584B47A7A;
	Thu,  2 May 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zq0M/7of"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41046544
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639784; cv=none; b=Ms2fxbeFii09+kkgWaimYNjI7xNB9wmrVarRz8KtVeMwptnFb9G48+lf2FjyAvqC4sT4/G8sOw4JlF7stenqtK95p4vKAPy8XpTMGwtIC/D84+M36TdU1iJ8CNOrnHWadSprCS7H8ZWMdlpyIMOppc1eDkYpTFwo1KuaOMM+1fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639784; c=relaxed/simple;
	bh=RBNo7t5IGu2yThFFulb8qCfz4Zt2E7C/FOw15MNEb5o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXGZw7ne3ZkybvZbwpNhvXiAxapVWKmPg9oXjila151fTYrQo9ND3m9nsXm0jdLF4cq6deFqIagucHmGVnRfhyr/2bLq08GgI67/wFivbCjSf5viGk0Eh+/ROjXdNLVn67nCGeUj1n0SbkVkSyqAgguXANbbuKWMo1plueeU8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zq0M/7of; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714639781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3z/p7PSnITLar6zjViIxQUZhsvkqQniW+UpUaJYwp0=;
	b=Zq0M/7of5/OP0hNH2g+d1yGXXvqySUvhJI0Jz+A9lbvjHwKXZEdOQUUGWtc5o1Jwuiv+lR
	ejxXSXDLjvo2AAjxcdJNBsqVMZVe77QyPWHYIsgJLYEBRHJeSSCtRrw8rjvdV2nqGUwS8j
	wzhdythemOjYYFbjCVVDTINQBAIP7Ig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167--go6KHMWP8WnbZ4LLKnQ6w-1; Thu, 02 May 2024 04:49:40 -0400
X-MC-Unique: -go6KHMWP8WnbZ4LLKnQ6w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34da8f1bf7cso1580904f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639778; x=1715244578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3z/p7PSnITLar6zjViIxQUZhsvkqQniW+UpUaJYwp0=;
        b=HFsvDZDMDwju76fju0Zysbp6x7z8Fr1rm6X5rMesatnaxdpnceHUjPuNK/zQUbIceb
         7bllys4b0NdbtAQZkQl9BYSLANENRiAmBrVZe77td8sEhQvaVKWhRc3ajPizU4Dz3cH5
         ZQxMAdoCoQV/MZRbkY1pzUoaVzncJh8JlGHABfFfBt/Vh5ojQKmR6LE2wqgUdKhtHILG
         S/X5BtaZdpP/jiG9G/G93uEyoj2coPjjHExvy9/fdakcd/KI4ihD2yZQbNJKPWv2y9n4
         iCRsmTyWKVGCDfU4P7OmUk9rGOQrBa6fg5I7QhMQsJxx3ln8X43jQ884jzfe9wpKx5U3
         UHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJtVcb9FqxYfr/oNAtr5ARCPhJX9l6DGVeVEVI95MluQdU30XC0OoA6RpoYoWqE1bR+eNTiqfQKwd3ErNKoiyfuOJVnAiv7cvBsSlj
X-Gm-Message-State: AOJu0Yxgo+TRfPxAIrBFpypewgZN35aRWXq1FWrKoM7cTod4bFnmtOBf
	cQgWa0QdMYecBH4VFIkYJHIgwnNXf+bo3+Sf9NQ6XE7DXT1R2QR6gRk9vor7/Jw070J5VyHfCnI
	Zor4cL1e4Aew6GoiT53qZlonsjUPptWb3vgB7/5LR45UDEcI3x4yIPvqXEz4fVNvjCp1rTA==
X-Received: by 2002:a5d:4d42:0:b0:34d:b43d:6e24 with SMTP id a2-20020a5d4d42000000b0034db43d6e24mr4206252wru.32.1714639778645;
        Thu, 02 May 2024 01:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVOHj8C2dd7Bt2GMvMzFkmfLMNHv/OiubjKl8vg1gno+Z4uyreVz7F2PF/KvPDgRwuVCzitg==
X-Received: by 2002:a5d:4d42:0:b0:34d:b43d:6e24 with SMTP id a2-20020a5d4d42000000b0034db43d6e24mr4206236wru.32.1714639778208;
        Thu, 02 May 2024 01:49:38 -0700 (PDT)
Received: from redhat.com ([84.33.125.84])
        by smtp.gmail.com with ESMTPSA id dd3-20020a0560001e8300b0034c9f060a14sm716299wrb.11.2024.05.02.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 01:49:37 -0700 (PDT)
From: Oleg Nesterov <onestero@redhat.com>
X-Google-Original-From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 2 May 2024 04:49:36 -0400
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>
Subject: Re: kernel/sched/isolation.c:143 housekeeping_setup() warn: always
 true condition '(first_cpu >= 0) => (0-u32max >= 0)'
Message-ID: <ZjNToL7ARe_vfJch@redhat.com>
References: <202404300915.WNvfwBz3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404300915.WNvfwBz3-lkp@intel.com>

Hello,

I am on PTO till May 9 without my working laptop, can't even read the source code.
I'll return to this when I'm back. CONFIG_SMP=n I guess.

On 04/30, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
> commit: 257bf89d84121280904800acd25cc2c444c717ae sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU
> date:   2 days ago
> config: xtensa-randconfig-r081-20240429 (https://download.01.org/0day-ci/archive/20240430/202404300915.WNvfwBz3-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 13.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404300915.WNvfwBz3-lkp@intel.com/
> 
> New smatch warnings:
> kernel/sched/isolation.c:143 housekeeping_setup() warn: always true condition '(first_cpu >= 0) => (0-u32max >= 0)'
> 
> Old smatch warnings:
> arch/xtensa/include/asm/thread_info.h:97 current_thread_info() warn: inconsistent indenting
> 
> vim +143 kernel/sched/isolation.c
> 
>    117	
>    118	static int __init housekeeping_setup(char *str, unsigned long flags)
>    119	{
>    120		cpumask_var_t non_housekeeping_mask, housekeeping_staging;
>    121		unsigned int first_cpu;
>    122		int err = 0;
>    123	
>    124		if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
>    125			if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
>    126				pr_warn("Housekeeping: nohz unsupported."
>    127					" Build with CONFIG_NO_HZ_FULL\n");
>    128				return 0;
>    129			}
>    130		}
>    131	
>    132		alloc_bootmem_cpumask_var(&non_housekeeping_mask);
>    133		if (cpulist_parse(str, non_housekeeping_mask) < 0) {
>    134			pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
>    135			goto free_non_housekeeping_mask;
>    136		}
>    137	
>    138		alloc_bootmem_cpumask_var(&housekeeping_staging);
>    139		cpumask_andnot(housekeeping_staging,
>    140			       cpu_possible_mask, non_housekeeping_mask);
>    141	
>    142		first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
>  > 143		if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
>    144			__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
>    145			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
>    146			if (!housekeeping.flags) {
>    147				pr_warn("Housekeeping: must include one present CPU, "
>    148					"using boot CPU:%d\n", smp_processor_id());
>    149			}
>    150		}
>    151	
>    152		if (cpumask_empty(non_housekeeping_mask))
>    153			goto free_housekeeping_staging;
>    154	
>    155		if (!housekeeping.flags) {
>    156			/* First setup call ("nohz_full=" or "isolcpus=") */
>    157			enum hk_type type;
>    158	
>    159			for_each_set_bit(type, &flags, HK_TYPE_MAX)
>    160				housekeeping_setup_type(type, housekeeping_staging);
>    161		} else {
>    162			/* Second setup call ("nohz_full=" after "isolcpus=" or the reverse) */
>    163			enum hk_type type;
>    164			unsigned long iter_flags = flags & housekeeping.flags;
>    165	
>    166			for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
>    167				if (!cpumask_equal(housekeeping_staging,
>    168						   housekeeping.cpumasks[type])) {
>    169					pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
>    170					goto free_housekeeping_staging;
>    171				}
>    172			}
>    173	
>    174			iter_flags = flags & ~housekeeping.flags;
>    175	
>    176			for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
>    177				housekeeping_setup_type(type, housekeeping_staging);
>    178		}
>    179	
>    180		if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK))
>    181			tick_nohz_full_setup(non_housekeeping_mask);
>    182	
>    183		housekeeping.flags |= flags;
>    184		err = 1;
>    185	
>    186	free_housekeeping_staging:
>    187		free_bootmem_cpumask_var(housekeeping_staging);
>    188	free_non_housekeeping_mask:
>    189		free_bootmem_cpumask_var(non_housekeeping_mask);
>    190	
>    191		return err;
>    192	}
>    193	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


