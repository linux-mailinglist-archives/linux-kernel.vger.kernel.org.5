Return-Path: <linux-kernel+bounces-81835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A560867B99
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D481FB353CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC38D12BF1B;
	Mon, 26 Feb 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HNEqAqL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlHi5a6f"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F112BEA2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962340; cv=none; b=tcLN4TmLaHHo0NSJ9pDxZlfMp+FATFmVrASPk2SAvoA32I7UjrDyfWszyi8OLPLa9oywRqRaDtntgYqmTqObztHmc/pLrQdBYBHwbQBTdpKsOjVN6RNu4cQDdOEGzvgVnNcpk9+KJ99JMGBdDM3mdjUOi1hTmyl0A75NGlgh8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962340; c=relaxed/simple;
	bh=7CXIMXtMPfI9H1HLbI6iz7FfltniQmJfgQ9Q9VbG/eo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GljhNVwqlw0l1twqllVHmE+xOykLvjAYm6qqMn0ZmUliidy+L90egSve5KIP++NYwDR3v/mFhphfij/oDEpC2ntidpYCdzDFVpfwBc3UdKURn9R5W14DqbOiWe/Ze/40DzVJarz8p5RoELM29EvtK2tRhvHNhGmXK1Vkfie2qIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HNEqAqL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlHi5a6f; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 05D3E11400B8;
	Mon, 26 Feb 2024 10:45:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 10:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708962334; x=1709048734; bh=+w/dCCzGxZ
	J2NH2QcsLQTSv5pe2kJ9fo4kQQPafe7Ao=; b=HNEqAqL0HeXfamJDzBnO7m6d5j
	M0gkJ7ktSRJAL24kkiCAUHaLK1WAtks34CY+9t5BCPCUm/UWCZ/JmrCbT5YN0gWW
	TYGjAy5EYQx9Qmvcwcrm0iPLS4SWN0bVWrU38qMxi/4ohgRF+/Hx9pQhlR+wiS8h
	M6So4IV/pvFwnoCE0pH3y1sJH+RkjfliuR+xpxQxnsOxuSMxxaZLH07efEuuBEuw
	L4Xus0e4HbEhJYCj8b0GkCfHcTmAUp8l2Mk9mabrD4lS64qecpZtu+nG03p9VuP4
	ayAUHKgTpMD1bAdP7kjcqHhoYsFxWwekuuM928t0yT3CAsDREl5OFJxBkAQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708962334; x=1709048734; bh=+w/dCCzGxZJ2NH2QcsLQTSv5pe2k
	J9fo4kQQPafe7Ao=; b=qlHi5a6fc6YzL+syHyOJopi7WiGwzgCmx7yCX8oPHBas
	xdtvt2S0jQJgINIXsmoMg9t0hXnPkzqfW5XNf/mx+7gV3PQWRwx33C47Qdzh9IX/
	nEdLsKAmBSiJHpXIzESMX33g7wz2LrNhrxRD2yi7rHo5MWo2CqiNTZmTVeK9r0Ye
	sjgg6UGJhLl8Xm3TNBNPxLlMethJk1znjA+3SNqHUEWBqcq85btaDQRCqU+o+fBH
	w7ComemVMSfy5vkPo6H2PL3xY/fpOjwCeL4w8rDvBHkT5bAyttOZQpV6WahFX9re
	fWwx7J7A2EsXAfbeQS3ls1gVSST5kKWs2tji5rXNHw==
X-ME-Sender: <xms:HbLcZYjDP3otViJhuEsudr2MG_qagS7ehdigdEJ3TwezarJYicPTSQ>
    <xme:HbLcZRCNKND2_XeOd81DUr03gF04GS94RMBChcCQZ7BngPfW_I-pBAt05eVueNCnA
    HNvb4oGkbyszWnLZCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:HbLcZQHIIPJiQMJAAYvouHnPN-J8wMdiEbb8gGKX5VTq8psQ3ukxuQ>
    <xmx:HbLcZZR6dQ8ziGydFmPZ4MWbsvXKKSLE6ViBQsgcxO8sWPktJMsX9A>
    <xmx:HbLcZVzt2bXHn4frNZQtojf5m0nbGc-3Yu0PrG5bqvGV7ZVw-4th3A>
    <xmx:HrLcZVdo7v8hBs3HvRdlKBRTixLj6B_sbFqHDX960R6xzft_PfoUGQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CE1E9B6008D; Mon, 26 Feb 2024 10:45:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <17b57262-85ca-42d7-bc67-db2c77d6722a@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYvTtJm8mhQh=c9WL4Ef_7Mb79CbBjFVoujupXFMrNsa-w@mail.gmail.com>
References: 
 <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
 <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
 <CA+G9fYvTtJm8mhQh=c9WL4Ef_7Mb79CbBjFVoujupXFMrNsa-w@mail.gmail.com>
Date: Mon, 26 Feb 2024 16:45:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name
 'u128'
Content-Type: text/plain

On Mon, Feb 26, 2024, at 16:33, Naresh Kamboju wrote:
> On Fri, 23 Feb 2024 at 14:56, Arnd Bergmann <arnd@arndb.de> wrote:

>> I have an older patch that I never merged to unify the
>> page size configuration in Kconfig, and could try to
>> dig that out if nobody has a better idea. If we do that,
>> we could introduce a CONFIG_PAGE_SIZE.
>
> The 16K and 64k page size builds pass.

Those have compat mode disabled on arm64 for historic reasons.
We should probably fix that, but that is a different problem.

     Arnd

