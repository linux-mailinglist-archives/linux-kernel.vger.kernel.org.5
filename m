Return-Path: <linux-kernel+bounces-84553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D186A837
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEE928A0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC8621A02;
	Wed, 28 Feb 2024 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HzqEYi+b"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867674A1A;
	Wed, 28 Feb 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100446; cv=none; b=d9leuw/lQ2ID7TQWB97GDH6WIQSbwUI6ZAZynBFYDk0hL8SW9PAHEpaTVMomQgjb6ExOzQrc1MOKldaWWZQn5qgCSpSMtW6in04oRkleiSZwUZ+aEVhMdGRk7tuzl+ABl3+Wxzy1KjggzuSCKOo1WcQI+B9erdpamQ1dEvg6Mq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100446; c=relaxed/simple;
	bh=YViSoMR2lQJQi3H4+zFsBmb+MxoYYAqwfyQrWv5y1vs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KSnPkYSAmVnRaCd/ybIrgwh8L79XgMNF3+nPjVUsOfkKQgJE8iCrAk+R6xP50UbWHr3zLsm4luqDKrcjcS6W84Qn3JsFtLh4FUerqLH1vet99MkpyeY4FNdanI4yXh9VpPzbppHIJMDm7qGUjiLDfsPCXqla7EtAFdJPHiVHb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HzqEYi+b; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709100440; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=VTjKIhOK3qM69jCegJqoVI39eQmDbxUQOTEPlMd6XqI=;
	b=HzqEYi+b3N0uSJLVbYlO6sgrPn75zCPFIKORn8BC+/A3dSpgLupv2xYlIvtF0punLHrhwjauWbEMu6InbOUNruIyDlQfY8/jmvJpVJCeurxb0Lylm4K6DHQkB0CuBe9RYLHCBjh4eTCLb6y2al3ZUEXnCxSrQ8AxQ2VPRO4HV+8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1OnNtY_1709100436;
Received: from 30.178.67.139(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1OnNtY_1709100436)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 14:07:18 +0800
Message-ID: <1606230b-83af-4f5f-b1ef-6ae8f73841f5@linux.alibaba.com>
Date: Wed, 28 Feb 2024 14:07:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv10 3/4] genirq: Avoid summation loops for /proc/interrupts
To: Thomas Gleixner <tglx@linutronix.de>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 yaoma@linux.alibaba.com
References: <20240226020939.45264-1-yaoma@linux.alibaba.com>
 <20240226020939.45264-4-yaoma@linux.alibaba.com> <87le769s0w.ffs@tglx>
 <e78357ae-7b00-446c-b010-3bd770892c9e@linux.alibaba.com>
 <87a5nlapc2.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87a5nlapc2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/27 23:39, Thomas Gleixner wrote:
> On Tue, Feb 27 2024 at 19:20, Bitao Hu wrote:
>> On 2024/2/27 17:26, Thomas Gleixner wrote:
>>>
>>> and then let kstat_irqs() and show_interrupts() use it. See?
>>
>> I have a concern. kstat_irqs() uses for_each_possible_cpu() for
>> summation. However, show_interrupts() uses for_each_online_cpu(),
>> which means it only outputs interrupt statistics for online cpus.
>> If we use for_each_possible_cpu() in show_interrupts() to calculate
>> 'any_count', there could be a problem with the following scenario:
>> If an interrupt has a count of zero on online cpus but a non-zero
>> count on possible cpus, then 'any_count' would not be zero, and the
>> statistics for that interrupt would be output, which is not the
>> desired behavior for show_interrupts(). Therefore, I think it's not
>> good to have kstat_irqs() and show_interrupts() both use the same
>> logic. What do you think?
> 
> Good point. But you simply can have
> 
> unsigned int kstat_irq_desc(struct irq_desc *desc, const struct cpumask *mask)
> 
> and hand in the appropriate cpumask, which still shares the code, no?
> 
Alright, that is a good approach.

