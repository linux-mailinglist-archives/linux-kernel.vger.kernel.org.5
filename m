Return-Path: <linux-kernel+bounces-141842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202448A2426
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB401C21C80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A312134CC;
	Fri, 12 Apr 2024 03:05:53 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249542581
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891152; cv=none; b=M8L84lbj/A22XNXlB+HE4reL31zDjfs7GIso6eLJxr6nq2+PTmfmcDwbXieaQHAZX68Bc8esUD/7Wo8e4Z9Gfdm/1Yr8pKSdkxeAIodan8p7hGiPsq9c8BWFOxMZ9OBErCtj+GXEFbgQw7xCyuD5Yjhn3Y1uJYdrOCtQP76/aKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891152; c=relaxed/simple;
	bh=E8LYEbyEkgRQX28NZZv6zVW4Ofy4brMZkaBWBcH9E1w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o55gfT0BuY5LFWSpjDR6ZlTgp8EpaGFzPFCOylvie/8yW3+rZ49tOK5reUqETmdgFe2ZO07295dWQFYuSU2D3mvy2dNSaO/+q8yqc6DNbNx3s4Xp++O2OfctoovkWu0nxewTdreORz4adukZCQZg7164V1+0XnEzRsfu6rS6tAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VG1b02Kl0z2CcDS;
	Fri, 12 Apr 2024 11:02:52 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id AFBBA1A0188;
	Fri, 12 Apr 2024 11:05:45 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 11:05:44 +0800
Subject: Re: [PATCH v3] irqchip/gic-v3-its: Fix double free on error
To: Guanrui Huang <guanrui.huang@linux.alibaba.com>
CC: <maz@kernel.org>, <shannon.zhao@linux.alibaba.com>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240412021556.101792-1-guanrui.huang@linux.alibaba.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bed81abf-cc39-53f0-6b22-33a0c2678142@huawei.com>
Date: Fri, 12 Apr 2024 11:05:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240412021556.101792-1-guanrui.huang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Hi Guanrui,

On 2024/4/12 10:15, Guanrui Huang wrote:
> In its_vpe_irq_domain_alloc, when its_vpe_init() returns an error
> with i > 0, its_vpe_irq_domain_free may free bitmap and vprop_page,
> and then there is a double free in its_vpe_irq_domain_alloc.
> 
> Fix it by calling its_vpe_irq_domain_free directly, bitmap and
> vprop_page will be freed in this function.
> 
> Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index fca888b36680..55c83e19719d 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4521,8 +4521,6 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>  	struct page *vprop_page;
>  	int base, nr_ids, i, err = 0;
>  
> -	BUG_ON(!vm);
> -

The BUG_ON() is indeed useless, though it'd be better to remove it in a
separate patch, with a commit message explaining why it is not needed.

>  	bitmap = its_lpi_alloc(roundup_pow_of_two(nr_irqs), &base, &nr_ids);
>  	if (!bitmap)
>  		return -ENOMEM;
> @@ -4561,13 +4559,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>  		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
>  	}
>  
> -	if (err) {
> -		if (i > 0)
> -			its_vpe_irq_domain_free(domain, virq, i);
> -
> -		its_lpi_free(bitmap, base, nr_ids);
> -		its_free_prop_table(vprop_page);
> -	}
> +	if (err)
> +		its_vpe_irq_domain_free(domain, virq, i);

This looks good,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks for the fix.

Zenghui

