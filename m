Return-Path: <linux-kernel+bounces-132058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E584898F31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0889E2825B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255C134434;
	Thu,  4 Apr 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hlTSVONy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6wFbnK3"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59B12B82
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260130; cv=none; b=FTVv3jVodsyStFN28ZmfQ71sllgGZ9VCHYeDY3JdR5wDrcp+SzyymZzHy7mEfLrw1FZ0PR59A+QhzwwGv6JxVmIHd2FY3G+GtfU8s81hfFPcAWZUBEh+IGoB1zd7fyjgYkUCGSfEZ9S0iCXUvjufeSH2l4MqA9RxFWYxA+ECbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260130; c=relaxed/simple;
	bh=t1ZwwjcZP6tHpNujC16gFKcAmBZAnL6LxiYGHgCsjvg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tP4m3wMrUtvcdcNjGH0WWimB/e9SIaslDC6ESdRHtaEd9QSPluSD3NwJ1MqB8HopNP3WaGlBowaTqz2uWL5mq9t+nu55oAjw/eQqJd1ROckdu5a3vl8vutvT4mx1YaXuvC2IvSb5rp1l2Mgae34DWFLIV4ud2F9fXSNRSAz2RJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hlTSVONy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6wFbnK3; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E6DDE1C000E0;
	Thu,  4 Apr 2024 15:48:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 15:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712260125; x=1712346525; bh=hiQ9PP65yp
	rDlNGzHIE3Deo1U6GRa/cTqCw3rUTctos=; b=hlTSVONye1ukVOCIHyXzI+GsA2
	FSAIUselSgLAkxoPi004HDhkuO/kMDWvV0DfDwKxxb25+Hwhw8ExSJ1h4J3/yF2w
	2tAFyZEYmLLQIgUyxi9ppwkrEX/uO6MyQQno87/u4WUYaBj4UYK7f9MmfdIxBMZ8
	XqCyZJuNvSrTOmr/O6Miw8b3wgu81c+gz6sb9ooJ27vQm1C8eHf2Rig+QJYboQN3
	2irE4YRH/zDKwXeJWUhv587KHvtPCoZ3oVVk9dWoq80P/dF6LyIHw3oKN2bpkccR
	0AaQarOOTHsirP6I1RQqHtz2S6ZI6e69qnaAw1w8HK6Hg95C/e2OzxV7VVUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712260125; x=1712346525; bh=hiQ9PP65yprDlNGzHIE3Deo1U6GR
	a/cTqCw3rUTctos=; b=W6wFbnK3sSgBJsAKxp6mAVBno17pc6Vboff+je/06/4T
	0HS8tYofyJdiwXKkS9aRdHSqs9d3u9kLjIyqAx2SBMMIDntyC8WVohFRI7ksxgYO
	QsjM3kRSPhPCz74n+b1LAtAxOO8DCAMQFz5tKEtY2tJStHzaa5osz+pjXH4Aisyq
	jM3L3/P3YBB3xqVJ0Q5fyUdjX0HCYCCK875tXPRlDKUI7MynsYDQYXh5LOjbrapF
	UBETYNbuAY5GaRMrzGD4difEOite9QGOJAg6KwEVB3nOYEJOqjlhHvVxDkHy8Mg+
	dURGACBcCDV6YEStit7tL04rXeDEOp8Tf/55pGn7lg==
X-ME-Sender: <xms:HQQPZnt5JTBS6StpApXHFnfEkKCm9XBVve10x-4kVf10Z75O8M06zg>
    <xme:HQQPZodXcxrCzXtPjpnKr4gZubGF6ldn7YKmv35EzHGnPOKPF8rDDD2bOhuS8Ton8
    Vu8xR0InBdb9pZoIZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:HQQPZqzmk53CaKhqbY3WGvHIfiEXMRWp9R6Tvi7jbh7-iW6pZ2gSeA>
    <xmx:HQQPZmMrqwyskgQE8CrUlxP8WWCUgErhbCylI8D_mNyrn8FPtXhdpQ>
    <xmx:HQQPZn8vZEPygGFEgk81-4mpqJCgk9S7tQfJQ4avj0TMMcvzFaK7sw>
    <xmx:HQQPZmXvTiBGJ86L3CQ2ESwws12iRB4LrwQ6RxBThCvY1AVvutA3ZA>
    <xmx:HQQPZmWlQ2pxxtj4oI75Hj75ZUif2iFtJdpigJXax97tUb5HXai9zZyU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1F290B6008D; Thu,  4 Apr 2024 15:48:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f4d6888-af13-4419-974e-dbfb5eaffa82@app.fastmail.com>
In-Reply-To: <20240404111744.40135657cd9de474b43d36c7@linux-foundation.org>
References: <20240404124435.3121534-1-arnd@kernel.org>
 <20240404111744.40135657cd9de474b43d36c7@linux-foundation.org>
Date: Thu, 04 Apr 2024 21:48:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Morton" <akpm@linux-foundation.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Andrey Konovalov" <andreyknvl@gmail.com>,
 "Dmitry Vyukov" <dvyukov@google.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: hw_tags: include linux/vmalloc.h
Content-Type: text/plain

On Thu, Apr 4, 2024, at 20:17, Andrew Morton wrote:
> On Thu,  4 Apr 2024 14:44:30 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This header is no longer included implicitly and instead needs to be
>> pulled in directly:
>> 
>> mm/kasan/hw_tags.c: In function 'unpoison_vmalloc_pages':
>> mm/kasan/hw_tags.c:280:16: error: implicit declaration of function 'find_vm_area'; did you mean 'find_vma_prev'? [-Werror=implicit-function-declaration]
>>   280 |         area = find_vm_area((void *)addr);
>>       |                ^~~~~~~~~~~~
>>       |                find_vma_prev
>> mm/kasan/hw_tags.c:280:14: error: assignment to 'struct vm_struct *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>>   280 |         area = find_vm_area((void *)addr);
>>       |              ^
>> mm/kasan/hw_tags.c:284:29: error: invalid use of undefined type 'struct vm_struct'
>>   284 |         for (i = 0; i < area->nr_pages; i++) {
>>       |                             ^~
>> mm/kasan/hw_tags.c:285:41: error: invalid use of undefined type 'struct vm_struct'
>>   285 |                 struct page *page = area->pages[i];
>>       |                                         ^~
>
> Thanks, but I'd like to know which patch this patch is fixing, please. 
> Is it mainline or linux-next?  I'm suspecting it might be a fix for
> fix-missing-vmalloch-includes.patch but without knowing how to
> reproduce this I can't determine anything.

It only showed up yesterday in linux-next. I thought about
bisecting it but ended up not doing it as it seemed simple
enough.

fix-missing-vmalloch-includes.patch looks like the right
place to me, given both the timing and contents, so please
fold my change into that.

      Arnd

