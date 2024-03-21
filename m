Return-Path: <linux-kernel+bounces-110046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A988594F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB7C1F23FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F27883CB9;
	Thu, 21 Mar 2024 12:43:43 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60E83CB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025023; cv=none; b=WyublFFsDQ2nHbe7eWj/58HKi793wEr258F03w7HzuMZl/5jnbVp6ybm0wxsmTzNWB9rdkOTHnbU9c7aIVRNn+2B9ZVVHRuKLly52KUNhskdiSl98MigXXWvxjuaY9ApCt6E2qlWdebj6xArRnWSkBc5z2cxEGMXLRvRp5IQJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025023; c=relaxed/simple;
	bh=pOKCS3IrY8Y+PUy6k/bqSXsqgHpVGEsk1CkhXCwZo7g=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M2nLBAxwCQICQi77Y9KBeq80gnAyKE5PiEYimDuN8VnU+oRxm5OYpYaRQRF5dObikkrR80fWxXjF0dnO5Zl4agL2XVZAPS1l+uBowV67cXbq3zS0C+MbwNrMzLO3/80+ihAZXC7HiIhfVDhiBju1Twl6fhdQB/Ynt1AdHbfoiRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V0lSH2Vhvz1R7nm;
	Thu, 21 Mar 2024 20:41:03 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BDD41A0172;
	Thu, 21 Mar 2024 20:43:38 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 20:43:37 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix double free on error
To: Guanrui Huang <guanrui.huang@linux.alibaba.com>
CC: <maz@kernel.org>, <shannon.zhao@linux.alibaba.com>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240321110454.89410-1-guanrui.huang@linux.alibaba.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <aac642a4-85a1-6df4-1192-638ce0d5086e@huawei.com>
Date: Thu, 21 Mar 2024 20:43:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240321110454.89410-1-guanrui.huang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/3/21 19:04, Guanrui Huang wrote:
> In its_vpe_irq_domain_alloc, when its_vpe_init() returns an error
> with i > 0, its_vpe_irq_domain_free may free bitmap and vprop_page,
> and then there is a double free in its_vpe_irq_domain_alloc.
> 
> Fix it by checking if bitmap is empty in its_vpe_irq_domain_alloc.
> If bitmap is empty and i > 0, means that bitmap have been clear and free
> in its_vpe_irq_domain_free.
> 
> Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index fca888b36680..98a1be90caef 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4562,9 +4562,14 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>  	}
>  
>  	if (err) {
> -		if (i > 0)
> +		if (i > 0) {
>  			its_vpe_irq_domain_free(domain, virq, i);
>  
> +			/* bitmap and vprop_page be freed in its_vpe_irq_domain_free */
> +			if (bitmap_empty(bitmap, nr_ids))

It looks like that 'bitmap' can't be non-empty if you managed to get
here. Right?

> +				return err;
> +		}
> +
>  		its_lpi_free(bitmap, base, nr_ids);
>  		its_free_prop_table(vprop_page);
>  	}

Is it possible that we handle these 2 cases together? I.e., does the
following approach help?

if (err)
	its_vpe_irq_domain_free(domain, virq, i);

Thanks,
Zenghui

