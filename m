Return-Path: <linux-kernel+bounces-166174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217C38B9725
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F16DB23B08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2056750;
	Thu,  2 May 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0vCt9sr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB556766
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640650; cv=none; b=bSyMrbUtAUUJN9AOluojFpUDvfKK9p6llwySeCppxSz/VSAtW0l59sZYdjqZT1QpRAgHol8VMmxlbQd0IjjJJWgyX0cIG707fTFAjTL5S7Uh82J2qcVshZofqdNPtPM2rBhsF82atv1B1xK6o7UfaGh8OP+x8vhB+cKJ4H1u0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640650; c=relaxed/simple;
	bh=RBNo7t5IGu2yThFFulb8qCfz4Zt2E7C/FOw15MNEb5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC6rq9p+TVrdkMVv+DPVwbsWtQ3M4ChEyZNhQ/xU7bHQhqI/PcGNO8MamV/zEiTJrYsz5hSXDuo6Nx+fynBYvKDg0gkREhtztiolCpAqBSTo+oJLNKj9Nv9uyd8gpssGyzGTorMzKOt2WpzSbccQjLbC94ad1465R/J4RlZaY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0vCt9sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714640647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3z/p7PSnITLar6zjViIxQUZhsvkqQniW+UpUaJYwp0=;
	b=g0vCt9srzzxgOvDFY+d2VULr8KkstIjMmefgpuGFCDgUFbraaMtD//my2ycW1o095BvQbG
	F2jMdcsuxNx7/4QRVfFJjQG+olER8NMsC/VjsIfocRFPavK2hl+fqWeLPydbUkkTw3qWn7
	BW58tygEY/RFewsWfOOnCViK38rLxZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-shbXHky0Ojewoz46za8lZg-1; Thu, 02 May 2024 05:04:04 -0400
X-MC-Unique: shbXHky0Ojewoz46za8lZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC69080E95D;
	Thu,  2 May 2024 09:04:03 +0000 (UTC)
Received: from fedora (unknown [10.39.194.153])
	by smtp.corp.redhat.com (Postfix) with SMTP id 36235EC685;
	Thu,  2 May 2024 09:04:01 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 May 2024 05:04:03 -0400 (EDT)
Date: Thu, 2 May 2024 05:04:00 -0400
From: Oleg Nesterov <oleg@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Phil Auld <pauld@redhat.com>
Subject: Re: kernel/sched/isolation.c:143 housekeeping_setup() warn: always
 true condition '(first_cpu >= 0) => (0-u32max >= 0)'
Message-ID: <ZjNXAEGhAnXX20Xk@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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


