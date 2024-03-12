Return-Path: <linux-kernel+bounces-100414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58720879726
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FABB21B35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418016439;
	Tue, 12 Mar 2024 15:08:04 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0978286
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256084; cv=none; b=RBopoapxv8O3NW2j8CH2/eYgrDzCC6mt2685rACIAgeMQ4a/Udos9SgO310zu+S7mz7QzDN5a7m+xXQbIthwwZJ/rTDENZ6QKqXl2yAA7Z769gDMfCOu75g9NJJRAbqpAgeY06TPKWZSfPMEQ29vkGsG+lJ3Aqgy4BY68dNhLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256084; c=relaxed/simple;
	bh=WAR6vC6GYDlT8W8h2fxdm6hhR5Qj23dpzfqj30x+ais=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3j55Dbb0cuUIxlwRhRAYZZyLnPlpO1+K40jzNC1cT2PNuYqQcfV9NDr85GAw8YYH7l2X31x6vqQBQJc3MbWYLlzX6Je3qe1jBUx+WOmTeXKhGIpwmdxMgOF655b7c8bfhbCmwazr5KRT8VLx9uvv1k3BrNMQQ7dQYdJXZ92mDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TvGj11JMYz9xqts
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:48:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3317114059E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:07:54 +0800 (CST)
Received: from [10.48.131.93] (unknown [10.48.131.93])
	by APP2 (Coremail) with SMTP id GxC2BwAXUCTDb_BlMeMqBA--.36492S2;
	Tue, 12 Mar 2024 16:07:53 +0100 (CET)
Message-ID: <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
Date: Tue, 12 Mar 2024 16:07:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
From: Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAXUCTDb_BlMeMqBA--.36492S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryxuF1fWr4kuw17XF1UZFb_yoW8XF4DpF
	W5Ga18trZFg3W2kanrX3sFvr4IkasrJ3W2kr4DA34Fvw1q9FyfArW3GwnxCw1j9ryrGa18
	KrWYyr9Fyw4DJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

On 2/23/2024 3:04 PM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> If a segmentation fault is caused by accessing an address in the vmalloc
> area, check that the target page is present.
> 
> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
> assumes that the fault is caused by a stale mapping and will be fixed by
> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
> a guard page, no mapping is created, and when the faulting instruction is
> restarted, it will cause exactly the same fault again, effectively creating
> an infinite loop.

Ping. Any comment on this fix?

Petr T

> 
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  arch/um/kernel/trap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index 6d8ae86ae978..d5b85f1bfe33 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>  	int err;
>  	int is_write = FAULT_WRITE(fi);
>  	unsigned long address = FAULT_ADDRESS(fi);
> +	pte_t *pte;
>  
>  	if (!is_user && regs)
>  		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>  
>  	if (!is_user && (address >= start_vm) && (address < end_vm)) {
> +		pte = virt_to_pte(&init_mm, address);
> +		if (!pte_present(*pte))
> +			page_fault_oops(regs, address, ip);
>  		flush_tlb_kernel_vm();
>  		goto out;
>  	}


