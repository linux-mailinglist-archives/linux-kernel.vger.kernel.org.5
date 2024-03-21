Return-Path: <linux-kernel+bounces-110497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85C3885FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502242838E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2E283CB2;
	Thu, 21 Mar 2024 17:30:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F549C2E9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042223; cv=none; b=D+ksezhFbu5cy0y5WajXTFbfC7mcepj0vlTE5g9D1BiijeGte/e0yygrzrtbbdk15+edsS1YzQUcw+W6B21G9t8tP4aMEt49429TO24pcPiNrL2mjMsDtp7R/w2Gr6OJJ48l64HB1je9NyqfN8nBcTwolK+RScCBVtaieQ2Gv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042223; c=relaxed/simple;
	bh=aCeT919OkCma1l6oDXXOSV7I7yWmK6bpOsYwA40kB1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T8kyeLVeKrLvnHFJiz9MjvINAzL6Q356KgcJudKT0Pi09qFaVpWmsme7k1rSQcCPtXGaI5dGaH5PbuaQjdxn7W7V2NT5qUK8NAF/rdXv0DDD7LZbpBdXZFZt95TkPRi4b+Adx60fTYrQerEl1t06vChvv8OhW9EnNPupKRH55/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V0smv46GNz6K9C6;
	Fri, 22 Mar 2024 01:25:51 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
	by mail.maildlp.com (Postfix) with ESMTPS id 120DC140A9C;
	Fri, 22 Mar 2024 01:30:11 +0800 (CST)
Received: from [10.81.213.73] (10.81.213.73) by frapeml500002.china.huawei.com
 (7.182.85.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 18:30:10 +0100
Message-ID: <9cfb4aa7-d927-4015-8ef8-1cd081250cdc@huawei-partners.com>
Date: Thu, 21 Mar 2024 18:30:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
To: David Gow <davidgow@google.com>, Petr Tesarik
	<petrtesarik@huaweicloud.com>
CC: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <CABVgOSmNbBzR=QV4RDSdBPzBU=8mP5r0gVf5wqADm_9e9htM2g@mail.gmail.com>
Content-Language: en-US
From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
In-Reply-To: <CABVgOSmNbBzR=QV4RDSdBPzBU=8mP5r0gVf5wqADm_9e9htM2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: frapeml500001.china.huawei.com (7.182.85.94) To
 frapeml500002.china.huawei.com (7.182.85.205)

On 3/21/2024 5:44 AM, David Gow wrote:
> On Fri, 23 Feb 2024 at 22:07, Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
>>
>> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>
>> If a segmentation fault is caused by accessing an address in the vmalloc
>> area, check that the target page is present.
>>
>> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
>> assumes that the fault is caused by a stale mapping and will be fixed by
>> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
>> a guard page, no mapping is created, and when the faulting instruction is
>> restarted, it will cause exactly the same fault again, effectively creating
>> an infinite loop.
>>
>> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>> ---
>>  arch/um/kernel/trap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
>> index 6d8ae86ae978..d5b85f1bfe33 100644
>> --- a/arch/um/kernel/trap.c
>> +++ b/arch/um/kernel/trap.c
>> @@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>>         int err;
>>         int is_write = FAULT_WRITE(fi);
>>         unsigned long address = FAULT_ADDRESS(fi);
>> +       pte_t *pte;
>>
>>         if (!is_user && regs)
>>                 current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>>
>>         if (!is_user && (address >= start_vm) && (address < end_vm)) {
>> +               pte = virt_to_pte(&init_mm, address);
>> +               if (!pte_present(*pte))
>> +                       page_fault_oops(regs, address, ip);
> 
> page_fault_oops() appears to be private to arch/x86/mm/fault.c, so
> can't be used here?
> Also, it accepts struct pt_regs*, not struct uml_pt_regs*, so would
> need to at least handle the type difference here.

Argh, you're right. This was originally a two-patch series, but Richard
wanted improvements in the implementation which would require more
effort, see here:

http://lists.infradead.org/pipermail/linux-um/2024-January/006406.html

So I wanted to fix only the infinite loop, but in the mean time I forgot
about the dependency on the first patch:

http://lists.infradead.org/pipermail/linux-um/2023-December/006380.html

That's because a quick git grep page_fault_oops found the function. It
was my mistake that I did not notice the other page_fault_oops() earlier.

OK, please forget about this patch for now; I must rework it.

> Could we equally avoid the infinite loop here by putting the
> 'flush_tlb_kernel_vm();goto out;' behind a if (pte_present(...))
> check, and let the rest of the UML checks panic or oops if required.
> (Actually OOPSing where we can under UML would be nice to do at some
> point anyway, but is a bigger issue than just fixing a bug, IMO.)

Yes, that would be the best quick fix until I get to implementing all
the blows and whistles (oops_* helpers, notification chains, tainting,
etc.).

Petr T

> Or am I lacking a prerequisite patch or applying this to the wrong
> version (or otherwise missing something), as it definitely doesn't
> build here.
> 
> Cheers,
> -- David

