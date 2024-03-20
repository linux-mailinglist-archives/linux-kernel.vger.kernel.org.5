Return-Path: <linux-kernel+bounces-109121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C28814E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD8C1C21224
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4038535C2;
	Wed, 20 Mar 2024 15:50:45 +0000 (UTC)
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997F53E08
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949845; cv=none; b=T5DLVtet4qTOTRt3br3QvRmrdrliYmWNFSdQkMZH7rE4gQ8+4t5fXQQQuGcBG7S1daeCUOMOOrFKK+kcKL1Us/tPQoYWEz2KIkwXSm8pNoGjx90Ai6pwzlsXIwik01jEKK77Pk5OO2mz6jMV6ScWYcHYXXzB4FlAB5+C1JjeLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949845; c=relaxed/simple;
	bh=f071Ed7JJfeSd5b6y5f8E9qApNS+xcwte/z7AGV3tZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sskVCAzLVvJZ1aF1LCddtnuC7bDO+P9da9xA6PiE7QXS1O5CI/bx4SJE2Gr+lTYlv17JSM4+0fqaa6TDlyP91f20WBJaDiUOoZ9cdy203lnlizZH4oionaS6CGgBWG9MeZpyYSV+cfsxW9HSo6piIah/9fHjyqIUsbzb9hOR8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rmxe4-00Etue-PG; Wed, 20 Mar 2024 15:14:25 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rmxe0-005Z95-2L;
	Wed, 20 Mar 2024 15:14:24 +0000
Message-ID: <ecfc31c9-e45a-4e5c-8662-add496246678@cambridgegreys.com>
Date: Wed, 20 Mar 2024 15:14:20 +0000
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
 Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, petr <petr@tesarici.cz>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
 <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com>
 <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
 <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
 <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
 <156343757.79841.1710943777684.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <156343757.79841.1710943777684.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett



On 20/03/2024 14:09, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
>>> Yes. I'm just way behind my maintainer schedule. :-/
>>
>> Understood. Thank you for your reply.
>>
>> By the way, are you looking for more people to help with the amount of work?
> 
> Yes, help is always welcome!
> Johannes and Anton do already a great job but more maintenance power is always good.
> You could help with reviewing patches, testing stuff, etc. :-)
> It's not that UML itself is a lot of work, it's just that $dayjob is not UML related at all...

Same here.

> 
> Thanks,
> //richard
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

