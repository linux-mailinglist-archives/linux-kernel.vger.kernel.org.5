Return-Path: <linux-kernel+bounces-128972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2D89626F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C57B2668A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4F1BDCF;
	Wed,  3 Apr 2024 02:18:58 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A96259C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110738; cv=none; b=sKtsZ46eiJNxnVM0T6lRvfX9ZXmGyfDTo8NiqVzkYoeqrazUAEt61mC4+dEw+/Np++DuDz75Sj2tgiDgLdI1tWYs5E38CdMPYgB14Cg1UkjibEo6/ZpsVfxjG7qRTLKsDpPojdSZT1wHohkshzTDf1+lLlv2xDH/aCP2gRGYqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110738; c=relaxed/simple;
	bh=ZtJ8MsCekNct6K4g9NJkRMimMGXvkYx0wXfrkVCFWB4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AdQKzDq9gMYbfdOtTmVivSxmsnt+sN+NgrhBq5D+9F5zw7ToAvQYaRyAcHzEUvjz6NjFKxyKEEFWpKSYBJE65ZvYtPkRdTax1AeE4IiH/atOEjAIfClIHRCl5FoxOPm02sGq2E1I7WMHHg4SfRf3w9BzK5Y3Lg8rzjB5Nxhdv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V8SzC0fgTz29lVs;
	Wed,  3 Apr 2024 10:16:07 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D72A18001A;
	Wed,  3 Apr 2024 10:18:52 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 10:18:51 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't need VSYNC if VMAPP with {V,
 Alloc}=={0, x}
To: Marc Zyngier <maz@kernel.org>
CC: <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <guoyang2@huawei.com>,
	<wangwudi@hisilicon.com>
References: <20240402114147.3788881-1-tangnianyao@huawei.com>
 <86jzlgt014.wl-maz@kernel.org>
 <8532b19b-361e-2234-92db-83f4d56bae19@huawei.com>
 <86il0zubh1.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <cc7a6d40-7fdc-196e-56bc-fe8a15ea29bb@huawei.com>
Date: Wed, 3 Apr 2024 10:18:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86il0zubh1.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500014.china.huawei.com (7.221.188.63)



On 4/2/2024 21:43, Marc Zyngier wrote:
> On Tue, 02 Apr 2024 14:32:40 +0100,
> Tangnianyao <tangnianyao@huawei.com> wrote:
>>
>>
>> On 4/2/2024 20:35, Marc Zyngier wrote:
>>> On Tue, 02 Apr 2024 12:41:47 +0100,
>>> t00849498 <tangnianyao@huawei.com> wrote:
>>>> From GIC spec, a VMAPP with {V, Alloc}=={0, x} is self-synchronizing,
>>> It'd be nice to quote the part of the spec (5.3.19).
>> yes, that's quote from GIC spec.
>>>> This means the ITS command queue does not show the command as
>>>> consumed until all of its effects are completed. A VSYNC with unmapped
>>>> vpeid is not needed.
>>>>
>>>> Signed-off-by: t00849498 <tangnianyao@huawei.com>
>>> Previous contributions with the same email address had the name
>>> "Nianyao Tang" associated with it. Was it wrong in the past? Or is the
>>> above wrong?
>> Sorry, the above name is wrong, should be "Nianyao Tang".
>>>> ---
>>>>  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index fca888b36680..a0ca5dcbb245 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -789,6 +789,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
>>>>  	unsigned long vpt_addr, vconf_addr;
>>>>  	u64 target;
>>>>  	bool alloc;
>>>> +	bool unmap_v4_1 = !desc->its_vmapp_cmd.valid && is_v4_1(its);
>>>>
>>>>  	its_encode_cmd(cmd, GITS_CMD_VMAPP);
>>>>  	its_encode_vpeid(cmd, desc->its_vmapp_cmd.vpe->vpe_id);
>>>> @@ -832,6 +833,9 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
>>>>  out:
>>>>  	its_fixup_cmd(cmd);
>>>>  
>>>> +	if (unmap_v4_1)
>>>> +		return NULL;
>>>> +
>>>>  	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
>>>>  }
>>>>  
>>> This is a bit ugly. We already have a whole block dedicated to
>>> handling VMAPP with V=0 and GICv4.1, and it'd be more readable to keep
>>> all that code together. Something like the untested patch below.
>> Thank you for quick fix, it would be great to remove this VSYNC. ITS handling VSYNC unmap
>> vpeid may waste some time, trigger exception and needed to be
>> handled.
> Do you actually see an exception being delivered from this?
>
> In any case, feel free to respin the patch after having tested this
> diff, with the commit message fixed and a Fixes: tag attached to it.

In our developing implemenation, ITS would report RAS when doing vsync
and reaching an invalid vpe table entry. It is reasonable to report RAS, right?

It just reports, and kernel can still run normally regardless of this RAS message.

> Thanks,
>
> 	M.
>


