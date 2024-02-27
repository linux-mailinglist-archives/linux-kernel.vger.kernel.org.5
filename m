Return-Path: <linux-kernel+bounces-82822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF386868A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587161F232F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67254FA6;
	Tue, 27 Feb 2024 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="htlqT1yO"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F052F92;
	Tue, 27 Feb 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020117; cv=none; b=h0kA+jgoAX/2YuEkGaXBWbOVWG/tLo8Aprbtn3jGF8F0B62Wk+DwJR6EM3evFI5B/CXtg5IX8ltioSzpOuGYrgzoECyiRAc6XqZ5gmsiwJVwm7zpRQ5dISfEDJeLO7+Jv8tkOL+mUb+OuPs0oD86NQZW4efpdfY6pW8MBj5r4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020117; c=relaxed/simple;
	bh=wG2uIpbEANFW4tW15wCrzK5XccYHhRVggoJTbU34Urw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuJ3DH7W5x4nw1dg6Q0oVfGp1W29HX/9NPAVVqVZf2IxvmtsaL9OtmVmGjiIKLhz0g6wg/plOLYvRRzw4vBOXkjQQacO02pRtF1mYfSLfMYqUZgIXvnFkPYkrcoPIdXJwbzJit7cafqSgXYZK67LfaibVVgl9XgsPRJQ1qcGlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=htlqT1yO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709020111; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ANqhyhYFXNbDTvGM7IZr9p+VwuyJreRc2hLrirn5IY4=;
	b=htlqT1yO5e5cMacS6j9kou8nY4UoeAvtcV3VARjJ5oTTYY9ao0TqJXb9ab4518egq0UkvsB6bE7JjXZSD+IB5YBhRC4DAKdj6ktHGvgm9XdRNJm87wPo1XFvYf6aOBV4NL3Zcyvd2EONyNWKviCGBoTFfXnpDxogJbHJ9PbSVxg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W1M4M.M_1709020108;
Received: from 30.178.80.107(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W1M4M.M_1709020108)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 15:48:29 +0800
Message-ID: <2c1d0ece-a781-4bf7-89dd-cea428842d05@linux.alibaba.com>
Date: Tue, 27 Feb 2024 15:48:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 3/4] genirq: Avoid summation loops for /proc/interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 tglx@linutronix.de, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20240226020939.45264-1-yaoma@linux.alibaba.com>
 <20240226020939.45264-4-yaoma@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20240226020939.45264-4-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/26 10:09, Bitao Hu 写道:
> We could use the irq_desc::tot_count member to avoid the summation
> loop for interrupts which are not marked as 'PER_CPU' interrupts in
> 'show_interrupts'. This could reduce the time overhead of reading
> /proc/interrupts.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>   include/linux/irqdesc.h | 2 ++
>   kernel/irq/irqdesc.c    | 2 +-
>   kernel/irq/proc.c       | 9 +++++++--
>   3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index 2912b1998670..1ee96d7232b4 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -121,6 +121,8 @@ static inline void irq_unlock_sparse(void) { }
>   extern struct irq_desc irq_desc[NR_IRQS];
>   #endif
>   
> +extern bool irq_is_nmi(struct irq_desc *desc);
> +
>   static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
>   					      unsigned int cpu)
>   {
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 9cd17080b2d8..56a767957a9d 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -955,7 +955,7 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
>   	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
>   }
>   
> -static bool irq_is_nmi(struct irq_desc *desc)
> +bool irq_is_nmi(struct irq_desc *desc)
>   {
>   	return desc->istate & IRQS_NMI;
>   }
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 6954e0a02047..b3b1b93f0410 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -489,8 +489,13 @@ int show_interrupts(struct seq_file *p, void *v)
>   		goto outsparse;
>   
>   	if (desc->kstat_irqs) {
> -		for_each_online_cpu(j)
> -			any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
> +		if (!irq_settings_is_per_cpu_devid(desc) &&
> +		    !irq_settings_is_per_cpu(desc) &&
> +		    !irq_is_nmi(desc))
> +			any_count = data_race(desc->tot_count);
> +		else
> +			for_each_online_cpu(j)
> +				any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
>   	}
>   
>   	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)

The modification borrows from the implementation of |kstat_irqs. Looks 
good.|

|Reviewed-by: Liu Song <liusong@linux.alibaba.com> |

||


