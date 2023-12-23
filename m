Return-Path: <linux-kernel+bounces-10507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B181D53A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18E01C21077
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9753011718;
	Sat, 23 Dec 2023 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FSif25Dv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE23208B9;
	Sat, 23 Dec 2023 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Q62WNNWZ2lfBVFMcSG5BsRb6SIeoYe2usU45vEczado=; b=FSif25DvNHqBmd4ALT7goYKspC
	2gE4o6sLy+kIsUL2/8RYf743T7k/HneSsZwq6OoUQ2SehqTpbjAkdt5AIkPswCLHuTT0xTKLbE06w
	TMUkSoJp6enwN3NbNZmoR7vpN5dwrlmVXknKG0tVKoKktechUPL7seoh6j7QEXz3u2jB4ioR3wXqd
	CVZEwKonkYAtoctAFmYKyDjnk4Ya/r7GDxPLt33403rV4jqxjPu+gYl0+R6Mws0cx9c3dgcfyGB80
	wiVbroOP04EaRnGR7d1+d/6h4clLwoa/rlbD5svbRIzxMxr6lxPEE95IkywRGdGHbu4s9FIB5Kklo
	11gucG+w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rH5cQ-008D1e-1C;
	Sat, 23 Dec 2023 17:16:58 +0000
Message-ID: <04d355d7-ced1-4dd6-b0de-29478a67f15d@infradead.org>
Date: Sat, 23 Dec 2023 09:16:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] LoongArch: signal.c: add header file to fix build
 error
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev, Kent Overstreet <kent.overstreet@gmail.com>
References: <20231222044554.25656-1-rdunlap@infradead.org>
 <CAAhV-H6pXSuj+bpf=skMYLQh8znboT6YxAA4UXokwm60-aXa8Q@mail.gmail.com>
 <CAAhV-H5-ORE2zGT2oZu+dusfzoXfn6mpSDsyE4wo+3XYVUpovg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAAhV-H5-ORE2zGT2oZu+dusfzoXfn6mpSDsyE4wo+3XYVUpovg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/23/23 02:27, Huacai Chen wrote:
> On Fri, Dec 22, 2023 at 12:59 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>
>> Hi, Randy,
>>
>> I cannot reproduce it with the default config file.
> Oh, I know, this error only occurs in linux-next, but I think this
> patch should be squashed into "rseq: Split out rseq.h from sched.h".
> Or as a fix applied to the bcachefs tree rather than the loongarch
> tree.

Yes, I think Kent is taking care of it.

Yes, in linux-next.

Thanks.

> Huacai
> 
>>
>> Huacai
>>
>> On Fri, Dec 22, 2023 at 12:46 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> loongarch's signal.c uses rseq_signal_deliver() so it should
>>> pull in the appropriate header to prevent a build error:
>>>
>>> ../arch/loongarch/kernel/signal.c: In function 'handle_signal':
>>> ../arch/loongarch/kernel/signal.c:1034:9: error: implicit declaration of function 'rseq_signal_deliver' [-Werror=implicit-function-declaration]
>>>  1034 |         rseq_signal_deliver(ksig, regs);
>>>       |         ^~~~~~~~~~~~~~~~~~~
>>>
>>> Fixes: b74baf4ad05b ("LoongArch: Add signal handling support")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Huacai Chen <chenhuacai@kernel.org>
>>> Cc: WANG Xuerui <kernel@xen0n.name>
>>> Cc: loongarch@lists.linux.dev
>>> Cc: Kent Overstreet <kent.overstreet@gmail.com>
>>> ---
>>> v2: repair Cc: list
>>>
>>>  arch/loongarch/kernel/signal.c |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff -- a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
>>> --- a/arch/loongarch/kernel/signal.c
>>> +++ b/arch/loongarch/kernel/signal.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/context_tracking.h>
>>>  #include <linux/entry-common.h>
>>>  #include <linux/irqflags.h>
>>> +#include <linux/rseq.h>
>>>  #include <linux/sched.h>
>>>  #include <linux/mm.h>
>>>  #include <linux/personality.h>

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

