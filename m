Return-Path: <linux-kernel+bounces-81886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346A867B97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3E81F2D394
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB012C7E1;
	Mon, 26 Feb 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FMpQvOIQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dMXS6r4T"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9E1D531
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964413; cv=none; b=hd5uP6fMfgy7HSDaVrlYxz+Qqe+GeF6o11bAwlVirAn2T1prQQd9K6xyvYnGz9cFwyEqYgh2PVbLjRYl7OPy11BfJVoLm35PqB2bKOIdoMAWJpLXTFTw2vwsID8u2FrJ6CBw01yd/uerLLDZGjS0k8uoOtKJun0USs74zmRvIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964413; c=relaxed/simple;
	bh=8dhDVusp0XZbE+eQwLC50NnsBrC+t2MqBEurbP/qAq0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=YAM/OF2D3+xOOuMODKD1IvLGmQ1MbnjahBAvFHSrFx4w7EhDYjjRegCir9YWAL4ALg6Z4WCjGBmLTdr1GmpDHjgUOZhgiDfMaDkLwzafy/s1QmfY4yYtbgmThbnCLX8rBSYTuxFp9glGzRz+pmB7Jv4hs3bV20H6N0AFFljConM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FMpQvOIQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dMXS6r4T; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id AE8F15C0096;
	Mon, 26 Feb 2024 11:20:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 11:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708964410; x=1709050810; bh=FOYwtQibxg
	xYSfvclhSVGEeajepdg7/RrzYTrMq4NWw=; b=FMpQvOIQdYgHL9DDnr7VNBUl05
	g/KNW8dhdBZ8/ONAVmH+kyw0/+SsRJn0HvfWbcH4PxeFEaNUSb2oOPyiCGimlnxm
	cOapmXiy4Gxmi0meOwG4uR0UXAR7Z4iotUwKmx1jwBvs9uYUtV6gFby7DZLzZIYa
	wGMtpOPtZ8KlUC7GhrCwuGg+wEtJuM43YkriUaJvI7wfO829Kd5hu5asf4TrWbeW
	xFSLQOUeSfpQyrTidpSt69G6vsbh8ayRYYmNNjn4UUcyEzLNLDOPrdLFUTNZVOJR
	r31ElVXbBXWXOT3/jlKAVaTtW/YBvbbpJlDGz1U1quF68LcH80YRMADvuing==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708964410; x=1709050810; bh=FOYwtQibxgxYSfvclhSVGEeajepd
	g7/RrzYTrMq4NWw=; b=dMXS6r4Tq8yi2r2uQWj7keJv2WNT4HIOr74u5y9bQ5bQ
	mU35O57e2/ZyLHNNYtKBUATl4X5L4Km2ZROs07YR0nHi/jaGd4gzmsprzBkyC2ns
	1/35Rvw2Y5+lSOVJTq9IyT5GB579ei4zHEkTInONqDiZjWLeZX+si6nAPPOEBRey
	r4B8LRi34zTbJ7nlvVY1k4ir/KaSjfOJvOXwjjj9bh4RAk1XD30QgdiTj2cK0E5G
	UAItg+IUmqL1yxgrjxLI5ZOakFOGed/ukb3OdXDcvFXWyRQP1D5yjAmfhEbJS9UP
	osgHJwv1FoAHfUExI6HSCAlLyJbCQdUZxR0E7vJTmQ==
X-ME-Sender: <xms:OrrcZU3ntLpyoKrXJEB6_1BS1kKpuyRglEvT8x8hmrd1yu8v9hAUCw>
    <xme:OrrcZfHFx09a0vR8yV71iqJgWIgTfqcxAEsdwOp5voBxDS68j0AwEtExkEZXmlpcH
    k4aH_oBQHYOuVK4MuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OrrcZc4lcuMkyty9kNcygoV_x86ikKImmzva1v7UubM0vNBZio-VhQ>
    <xmx:OrrcZd2YXCik-CVm9xQ0zsMk26X6yufHq76sHm8HBFq7rfK179NrGg>
    <xmx:OrrcZXFowy6EdUQs6S0XxazsaRz7EHKjg8aDYxHVfPQ_Bn6XrUtXcw>
    <xmx:OrrcZdYdTj3syY3eTkgYr7tzD0xFLowElZIpOzjuf0uSS2YAR1jZNw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 58A0BB6008D; Mon, 26 Feb 2024 11:20:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23e6b40b-deb4-4e94-b454-cb2af0543af1@app.fastmail.com>
In-Reply-To: <871q8zkygb.fsf@somnus>
References: 
 <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
 <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
 <871q8zkygb.fsf@somnus>
Date: Mon, 26 Feb 2024 17:19:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name
 'u128'
Content-Type: text/plain

On Mon, Feb 26, 2024, at 17:00, Anna-Maria Behnsen wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>> Commit a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store
>> available for all architectures") introduced a reference to
>> the asm/page.h in include/vdso/datapage.h, but this is outside
>> of the vdso/*.h namespace and doesn't work in the compat vdso.
>
> But the asm namespace works for the vdso namespace. Only linux headers
> do not work, or am I wrong?

The vdso namespace was added to have something that works for
userspace code in both compat 32-bit mode and native (32 or
64) bit mode, while anything outside of include/vdso may not
work here.


> PAGE_SIZE is defined in asm/page-def.h for arm64. So this could be a
> fast fix (tested with clang-14):
>
> ---8<----
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -19,7 +19,11 @@
>  #include <vdso/time32.h>
>  #include <vdso/time64.h>
> 
> +#ifdef CONFIG_ARM64
> +#include <asm/page-def.h>
> +#else
>  #include <asm/page.h>
> +#endif
> 
>  #ifdef CONFIG_ARCH_HAS_VDSO_DATA
>  #include <asm/vdso/data.h>
> ---8<---

I've sent my own patch now, which is something we probably want
anyway, but is obviously much more invasive thank your four-line
patch.

Maybe we can put your quick fix in the tip tree for the moment
and I put my patches into the asm-generic tree, then
we can do the trivial cleanup from my final patch later.

     Arnd

