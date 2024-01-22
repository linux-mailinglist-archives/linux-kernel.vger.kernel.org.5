Return-Path: <linux-kernel+bounces-33075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B2D83641F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E041C21111
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0E3CF42;
	Mon, 22 Jan 2024 13:13:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC820DD2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929203; cv=none; b=Ffz8POoJp4hTeR7uhP0MKSlIy9BjFr7igzoyrOhtuw3chcmswWIIrTsaR5+M8ZvB8LTiPpMcxx4HHMhrqfiS8TvlMxKO17hvlTDTyScNjxZakeAjyJ83AGD9iW/Na+nz2VJjbQI7iS+Au3tBPD42BMLgQQlxl51ookMfVwX/Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929203; c=relaxed/simple;
	bh=ShVSGz8bx4QujhaJoJYUvNHGEuQxq+K4Dn8Jt0gFXl0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YwrlZddFiaxzuAMXVsyKQLGdro18bJrVEDhFOV0qBq2zR7xL3OKHksMAvSf+1mwDteptNebxcjoTMHgbNQ4HjY6KwFWhrpHMzMjHAIZT4vNjmdHlE1cCjgv4m4vNhLWghjRjawrYOsWPhf3n1BI2JVzLdcTnc44l7keAeQtT0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TJVxb4TLpzNlLt;
	Mon, 22 Jan 2024 21:12:19 +0800 (CST)
Received: from kwepemd500003.china.huawei.com (unknown [7.221.188.36])
	by mail.maildlp.com (Postfix) with ESMTPS id 70023140499;
	Mon, 22 Jan 2024 21:13:10 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500003.china.huawei.com (7.221.188.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 22 Jan 2024 21:13:09 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1:Check whether indirect table is
 supported in allocate_vpe_l1_table
To: Marc Zyngier <maz@kernel.org>
CC: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <guoyang2@huawei.com>,
	<wangwudi@hisilicon.com>
References: <20240122160607.1078960-1-tangnianyao@huawei.com>
 <86sf2p91zt.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <5de3da53-9c0d-2a2d-876b-2181e540fa2f@huawei.com>
Date: Mon, 22 Jan 2024 21:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86sf2p91zt.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500003.china.huawei.com (7.221.188.36)



On 1/22/2024 17:00, Marc Zyngier wrote:
> [Fixing the LKML address, which has bits of Stephan's address embedded
> in it...]
>
> On Mon, 22 Jan 2024 16:06:07 +0000,
> Nianyao Tang <tangnianyao@huawei.com> wrote:
>> In allocate_vpe_l1_table, when we fail to inherit VPE table from other
>> redistributors or ITSs, and we allocate a new vpe table for current common 
>> affinity field without checking whether indirect table is supported.
>> Let's fix it.
> Is there an actual implementation that doesn't support the indirect
> property for the VPE table? I know this is allowed for consistency
> with the original revision of the architecture, but I never expected
> an actual GICv4.1 implementation to be *that* bad.
>
> If that's the case, I'm a bit puzzled/worried.

I met this problem in a developing implementation and find it's allowed by GIC spec.
In such environment,  in a common affinity field with only redistributors and without
any ITS in it, forcing its_vpe_id_alloc to allocate a large vpeid(like 65000), and there
comes an error message "VPE IRQ allocation failure". It originally comes from
allocate_vpe_l2_table, reading GICR_VPROPBASER with GICR_VPROPBASER_4_1_SIZE=1
and GICR_VPROPBASER_4_1_INDIRECT=0.

>
>> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c   | 28 ++++++++++++++++++++++------
>>  include/linux/irqchip/arm-gic-v3.h |  1 +
>>  2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index d097001c1e3e..4146d1e285ec 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2836,6 +2836,7 @@ static int allocate_vpe_l1_table(void)
>>  	unsigned int psz = SZ_64K;
>>  	unsigned int np, epp, esz;
>>  	struct page *page;
>> +	bool indirect = false;
> Why the upfront initialisation?
>
>>  
>>  	if (!gic_rdists->has_rvpeid)
>>  		return 0;
>> @@ -2890,6 +2891,12 @@ static int allocate_vpe_l1_table(void)
>>  		break;
>>  	}
>>  
>> +	/* probe the indirect */
>> +	val = GICR_VPROPBASER_4_1_INDIRECT;
>> +	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
>> +	val = gicr_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
>> +	indirect = !!(val & GICR_VPROPBASER_4_1_INDIRECT);
> You can probe the indirect bit as part of the page-size probe, no need
> for an extra R/W sequence.
>
>> +
>>  	/*
>>  	 * Start populating the register from scratch, including RO fields
>>  	 * (which we want to print in debug cases...)
>> @@ -2907,15 +2914,24 @@ static int allocate_vpe_l1_table(void)
>>  	 * as indirect and compute the number of required L1 pages.
>>  	 */
>>  	if (epp < ITS_MAX_VPEID) {
>> -		int nl2;
>> +		if (indirect) {
>> +			int nl2;
>>  
>> -		val |= GICR_VPROPBASER_4_1_INDIRECT;
>> +			val |= GICR_VPROPBASER_4_1_INDIRECT;
>>  
>> -		/* Number of L2 pages required to cover the VPEID space */
>> -		nl2 = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
>> +			/* Number of L2 pages required to cover the VPEID space */
>> +			nl2 = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
>>  
>> -		/* Number of L1 pages to point to the L2 pages */
>> -		npg = DIV_ROUND_UP(nl2 * SZ_8, psz);
>> +			/* Number of L1 pages to point to the L2 pages */
>> +			npg = DIV_ROUND_UP(nl2 * SZ_8, psz);
>> +		} else {
>> +			npg = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
>> +			if (npg > GICR_VPROPBASER_PAGES_MAX) {
>> +				pr_warn("GICR_VPROPBASER pages too large, reduce %llu->%u\n",
>> +					npg, GICR_VPROPBASER_PAGES_MAX);
>> +				npg = GICR_VPROPBASER_PAGES_MAX;
>> +			}
>> +		}
>>  	} else {
>>  		npg = 1;
> Why don't you treat the two indirect cases at the same point? It
> really should read:
>
> 	if (epp < ITS_MAX_VPEID && indirect) {
> 		[unchanged]
> 	} else {
> 		[compute the number of L1 pages in the !indirect case]
> 	}
>
>>  	}
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index 728691365464..ace37dfbff20 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -303,6 +303,7 @@
>>  #define GICR_VPROPBASER_4_1_Z		(1ULL << 52)
>>  #define GICR_VPROPBASER_4_1_ADDR	GENMASK_ULL(51, 12)
>>  #define GICR_VPROPBASER_4_1_SIZE	GENMASK_ULL(6, 0)
>> +#define GICR_VPROPBASER_PAGES_MAX  128
> Don't hardcode numbers. Use the definition of the SIZE field
> instead. And if you must have a new #define, please use the 4_1
> indication so that it isn't confused with the v4.0 layout.

yeah, I'm also confused when writing this hardcode number, and just follow
the marco GITS_BASER_PAGES_MAX.
I have another question here. The max number of pages  for GITS_BASER
and GICR_VPROPBASER is different here, while GITS_BASER.Size is
bit[7:0] with max 256, and GICR_4_1_VPROPBASER.Size is bit[6:0] with max 128.
Kernel usually probe ITS basers first and then probe GICR_4_1_VPROPBASER in
a common affinity group. Maybe we need to check this in "inherit_vpe_l1_table_from_its" ?

>
> I'd expect something like the following (untested) hack.
>
> 	M.
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9a7a74239eab..555b86f375e1 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2836,6 +2836,7 @@ static int allocate_vpe_l1_table(void)
>  	unsigned int psz = SZ_64K;
>  	unsigned int np, epp, esz;
>  	struct page *page;
> +	bool indirect;
>  
>  	if (!gic_rdists->has_rvpeid)
>  		return 0;
> @@ -2870,10 +2871,12 @@ static int allocate_vpe_l1_table(void)
>  
>  	/* First probe the page size */
>  	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
> +	val |= GICR_VPROPBASER_4_1_INDIRECT;
>  	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
>  	val = gicr_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
>  	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
>  	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
> +	indirect = !!(val & GICR_VPROPBASER_4_1_INDIRECT);
>  
>  	switch (gpsz) {
>  	default:
> @@ -2906,7 +2909,7 @@ static int allocate_vpe_l1_table(void)
>  	 * If we need more than just a single L1 page, flag the table
>  	 * as indirect and compute the number of required L1 pages.
>  	 */
> -	if (epp < ITS_MAX_VPEID) {
> +	if (epp < ITS_MAX_VPEID && indirect) {
>  		int nl2;
>  
>  		val |= GICR_VPROPBASER_4_1_INDIRECT;
> @@ -2917,7 +2920,8 @@ static int allocate_vpe_l1_table(void)
>  		/* Number of L1 pages to point to the L2 pages */
>  		npg = DIV_ROUND_UP(nl2 * SZ_8, psz);
>  	} else {
> -		npg = 1;
> +		npg = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
> +		npg = clamp_val(npg, 1, (GICR_VPROPBASER_4_1_SIZE + 1));
>  	}
>  
>  	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg - 1);
>
I've tested your patch and it's ok and it can solve my problem.


