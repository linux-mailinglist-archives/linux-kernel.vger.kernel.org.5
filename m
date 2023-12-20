Return-Path: <linux-kernel+bounces-6126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465258194EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C8928796D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D855FBE0;
	Wed, 20 Dec 2023 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M9w757v2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928CEEA1;
	Wed, 20 Dec 2023 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u3CPpHAtE/Iw6YrtmuuSWmU6FL+8ZBd+nzTHvCANU54=; b=M9w757v2u1vAJbWmptUs8pxHnn
	HcJqHY07CNHbsH1OpcGf17Ld0JZpN2Dge3TArCzRiZWjEiWqUuqg9jQvxA5YqNTJTekwiOLfxOmwZ
	GAQUqe31yXJ1kSmdLBX6fWS55OIwLB7yuFD7Ayrns/r4gNiZ+Kcws0xyg3C1Ph2j5u+cpzewoRkHF
	EF6xceXDHU3KKhOaAjS5Orz3AMzbPDPSZT+0QkdVQLBzlboCeRUb/IIoIXdx2InuI0d+1VJE/YdaO
	iSmrmEovzFj3i/n5dawiVAZN5796jxFx2q4JjnW+JWsZQoPg9HIBTBLGHJ6nQpi/B3AHu/y0q3NPb
	wL92w5OQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFk4h-00FjY0-2m;
	Wed, 20 Dec 2023 00:04:35 +0000
Message-ID: <6e2cdc33-b61a-40da-a2ff-6a99c548ac76@infradead.org>
Date: Tue, 19 Dec 2023 16:04:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the jc_docs tree
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231218182825.39a6562b@canb.auug.org.au>
 <87r0jjmw59.fsf@meer.lwn.net>
 <4cbcd213-55f9-4525-8be0-29db00a468d2@infradead.org>
 <87le9pg2q4.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87le9pg2q4.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 16:02, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 12/18/23 06:18, Jonathan Corbet wrote:
>>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>>
>>>> Hi all,
>>>>
>>>> After merging the jc_docs tree, today's linux-next build (htmldocs)
>>>> produced this warning:
>>>>
>>>> include/crypto/hash.h:248: warning: Excess struct member 'digestsize' description in 'shash_alg'
>>>>
>>>> and 636 new similar warnings :-(
>>>>
>>>> Exposed by commit
>>>>
>>>>   b77fdd6a48e6 ("scripts/kernel-doc: restore warning for Excess struct/union")
>>>>
>>>> I am not sure what we should do about this ... last Friday I only
>>>> got about 18 lines of warnings.
>>>
>>> The warnings were expected, of course.
>>>
>>> The alternatives are to fix the docs or to revert b77fdd6a48e6,
>>> pretending that all those kerneldoc errors don't actually exist.  The
>>> fixes should be pretty easy to do (and there's far less of them than it
>>> seems from the number of warnings).  I can't get there right away but if
>>> nobody beats me to it I'll try to toss some patches together.
>>
>> Hi Jon,
>>
>> Attempt at a little coordination:
>>
>> It looks like you are working on some net-related patches for this.
>> I am currently working on fs/ and kernel/ patches.
> 
> Oops...I did a few net ones now; they are all sent and I'm done for
> today.

No Oops needed.  You can have net. I'll stay away from it.

> Thanks for working on these too!
> 
> jon

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

