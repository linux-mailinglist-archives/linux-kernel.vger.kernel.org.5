Return-Path: <linux-kernel+bounces-129342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8A8968C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E68B1C225F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7F47A53;
	Wed,  3 Apr 2024 08:33:43 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D826ACF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133223; cv=none; b=DAfrCEnzN9QDGGs9PC8vxBJXgDVRLJjQ+zBxAfKU6Jt8waJHEeSHAGlpUIDNspHo7+EHNQe74njzv7h41iu5dLX0LChj6azutihajMSi+Fakw5477v4RsnfkP9vsNmzfXLavVHFRB1uUR+xFOC7xvpCJpcWLzVzACOFLInl5vT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133223; c=relaxed/simple;
	bh=zIJ1FHl187TCKbcPjn4w3Q5JOVKKtPb83S5JygPikuw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IXH1QDjQ/SEsvQioNzilpHo49XSXgFtGduti8eSi5wqB7Qz39iWxNCaU6lch5fKwrX3fTklkA3m8vrSSz5hjIMDGQA4jdsLO6dn1hgaCk2Ek2iw0JESxPUWOa2mZLJ/kLAzcS+z5G3YYWBbVhHchzZlXwv0FPU6yapYC38Ixugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V8dHq5BDtz1QCCh;
	Wed,  3 Apr 2024 16:31:03 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FB93140487;
	Wed,  3 Apr 2024 16:33:36 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 16:33:35 +0800
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
 <cc7a6d40-7fdc-196e-56bc-fe8a15ea29bb@huawei.com>
 <86frw3t27r.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <25208048-822d-0c9e-5183-06035596bbca@huawei.com>
Date: Wed, 3 Apr 2024 16:33:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86frw3t27r.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500014.china.huawei.com (7.221.188.63)



On 4/3/2024 14:00, Marc Zyngier wrote:
> On Wed, 03 Apr 2024 03:18:51 +0100,
> Tangnianyao <tangnianyao@huawei.com> wrote:
>>
>>
>> On 4/2/2024 21:43, Marc Zyngier wrote:
>>> On Tue, 02 Apr 2024 14:32:40 +0100,
>>> Tangnianyao <tangnianyao@huawei.com> wrote:
>>>>
>>>> Thank you for quick fix, it would be great to remove this VSYNC. ITS handling VSYNC unmap
>>>> vpeid may waste some time, trigger exception and needed to be
>>>> handled.
>>> Do you actually see an exception being delivered from this?
>>>
>>> In any case, feel free to respin the patch after having tested this
>>> diff, with the commit message fixed and a Fixes: tag attached to it.
>> In our developing implemenation, ITS would report RAS when doing vsync
>> and reaching an invalid vpe table entry. It is reasonable to report RAS, right?
> If a RAS error is the only reporting method you have, then I suspect
> you don't have much of a choice (the pseudocode indicates an IMPDEF
> SError for VSYNC). Shame this wasn't caught earlier.
>
>> It just reports, and kernel can still run normally regardless of
>> this RAS message.
> That really depends on the policy behind RAS errors.
>
> Looking forward to your respinning of this patch.

I have tested your patch and it's ok to fix the above problem.
Respin patch will be sent later.


>
> Thanks,
>
> 	M.
>


