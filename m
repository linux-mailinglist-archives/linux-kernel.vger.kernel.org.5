Return-Path: <linux-kernel+bounces-38572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C790A83C265
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D711F2134D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077BB4502F;
	Thu, 25 Jan 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eotN5GNP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="swr4TGwP"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FC46559
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184951; cv=none; b=XQW3syqZz6PnkMrZR7uWZiyUntMJ9bx6h2TJw3BG1M2ryXk3FDjL47/hI6DnKVND/wmIP5ZxEygmeoysL4wUeaYsza7EwjLiUHuIvq7FwDQY54ceHp3zX870cMDKtf+4FlXhL72cfBKn4ZptUynBu3v4UUqf8/raIb2iOz9G1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184951; c=relaxed/simple;
	bh=iYIlmuM4aHoSjitHdo1GiG11F3ybyCgC/rvqDkKgIZM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=sWzDofgLFFhVym9BGWs7p3gHFkzkSYz+ixHW3onIK6A/zSet+yt/lbpo90BjBty2n2/AmiSKyA+Tv0fiYK8onRHd4TZyHsjyUFeLRhzIcQ2/u8wsd75lWVkdWcEvh/PjcqjAAmN4fCJJJDrcz3mt8QfDZDnSNDzK+ZlaUCunUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eotN5GNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=swr4TGwP; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 327C53200BA0;
	Thu, 25 Jan 2024 07:15:48 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 25 Jan 2024 07:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706184947; x=1706271347; bh=iWY278RAES
	I9tXIJCbcah9hv93rUNqzySmMLK+KnP2E=; b=eotN5GNPRege9OZu5gZt+nSZbV
	i3Qyl2Lpe1ik7aHDnhMnbvIPchaQRplhdcZ+jIYIQEGvcKBsMND/snpFpzzKbVcJ
	yEDuBtF2XyQ84cY/s9XiM/BnryFAcVBIBEJv3HujGMqHq8VcTPSExXxHOzOAqP1o
	9NtWlDOwNup4b4hsWHzkZ2OH4hs26Rr4l7Q0S8OhMJfODUisnsAWCZKST+2djDoR
	K459Yt4ZD2c4yHF0AMZJZZdRVokI0e7Gm2guSlDqpOLRz1AQMPeYZW85zvG0j0/6
	OzBLOdqkXmX0i5qIj285W+Q3nf1Ehc3U8d322PE2QGxqJ16KJIb7ra4kUQ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706184947; x=1706271347; bh=iWY278RAESI9tXIJCbcah9hv93rU
	NqzySmMLK+KnP2E=; b=swr4TGwPEh4Ve+gNquCawDIXWqoV/LWsV7s4LuKZCpcq
	DoK5l/LpCqq27upa8Pa0Ii+yh1qgLwLWnDdtykJM04++kGJdgvc+Gl4GvJ0qe7YS
	eynXOGKhnb1pa04gNWuep+Sg7FHpqoSHwVg6HgfbzDOqQdKJpJqOmJ9IDEZEdJPx
	KcS8pYw9HYMW3Qb8GwepZtoeMadhOHwl0Ysy9I+7V5CCCJtoRLqqZ+FjrpQERxNj
	Gv+vHos/UZBSu/8iyJS2sPk6NK2Xu56soKoFMjNKvdLe11TnVt/qljPvQiJqOmn1
	hXVGcx0zRV7njGBAejubxjuSOGnY2mPuQTiTHRl5/w==
X-ME-Sender: <xms:81CyZSeHa6hjc6lSJ0i0irdpuoK5742j03XDw6GSslZWYrHk-mJ5Eg>
    <xme:81CyZcOxHwMJj1_K2QdryDUUdsb6Q1A24QRQcVyq2qyAiUvF69P64N2XDPjLA8GHf
    gf6gt-_uf3Ff_WYHqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:81CyZTg6WL_QJSyTimAIqxSrpxSW6-RlaJb8czz6kn2pIzW_CnFm-w>
    <xmx:81CyZf-FYj2kkwPBnIwyIRY33d-5IXFJXnp86OiIDcX1gWpIVQEQ8Q>
    <xmx:81CyZevrrYxtL3AUZvpNAMJnnG-hrbAPrGNlVuGMjaIzlWgjv2_68Q>
    <xmx:81CyZcAg6t56_AKQrh-ZhU_0g1uXbUNAuRVjYklfN2QahsqT3dSoGg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 49604B6008D; Thu, 25 Jan 2024 07:15:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <911c4a6b-83af-46a8-8f7e-250da4f0f1ad@app.fastmail.com>
In-Reply-To: <20240124231120.562f06f3@xps-13>
References: <20240122153442.7250-1-arnd@kernel.org>
 <20240124182256.776c164b@xps-13>
 <1d13250c-e48b-4e31-b449-5b54837a0d40@app.fastmail.com>
 <20240124231120.562f06f3@xps-13>
Date: Thu, 25 Jan 2024 13:15:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 regressions@lists.linux.dev,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 "Chen-Yu Tsai" <wenst@chromium.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, asahi@lists.linux.dev,
 "Sven Peter" <sven@svenpeter.dev>, "Michael Walle" <michael@walle.cc>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Content-Type: text/plain

On Wed, Jan 24, 2024, at 23:11, Miquel Raynal wrote:
> Hi Arnd,
>
> arnd@arndb.de wrote on Wed, 24 Jan 2024 20:49:53 +0100:
>
>> On Wed, Jan 24, 2024, at 18:22, Miquel Raynal wrote:
>> > arnd@kernel.org wrote on Mon, 22 Jan 2024 16:34:10 +0100:
>> >  
>> >> From: Arnd Bergmann <arnd@arndb.de>
>> >> 
>> >> 
>> >> As far as I can tell, this is a problem for any device with multiple cells on
>> >> different bits of the same address. Avoid the issue by changing the file name
>> >> to include the first bit number.  
>> >
>> > There is only one bit number right? We are talking about byte offsets
>> > so this value can only range from 0 to 7? If we understand each other
>> > correctly then why not, I'm fine with the extra ",0" thing.  
>> 
>> On the Apple M1, the nvmem registers are 32 bit wide, so the
>> bit numbers can go up to 31. I can imagine some system using
>> 64-bit registers, but it's unlikely to be higher than that.
>
> In this case we will soon or later have a problem again. Can we include
> the full offset of the bit and not just the first digit?

I thought that is what my patch does, maybe I don't
undestand the problem you are referring to. This is what
I see on my system with the patch applied:

$ cd /sys/devices/platform/soc@200000000/2922bc000.efuse
$ find . -name efuse\*
/apple_efuses_nvmem0/cells/efuse@a24,11
/apple_efuses_nvmem0/cells/efuse@a24,9
/apple_efuses_nvmem0/cells/efuse@a1c,f
/apple_efuses_nvmem0/cells/efuse@a20,17
/apple_efuses_nvmem0/cells/efuse@a20,1e
/apple_efuses_nvmem0/cells/efuse@a18,0
/apple_efuses_nvmem0/cells/efuse@a14,b
/apple_efuses_nvmem0/cells/efuse@a1c,1f
/apple_efuses_nvmem0/cells/efuse@a1c,d
/apple_efuses_nvmem0/cells/efuse@a20,1c
/apple_efuses_nvmem0/cells/efuse@a18,15
/apple_efuses_nvmem0/cells/efuse@a14,0
/apple_efuses_nvmem0/cells/efuse@a1c,14
/apple_efuses_nvmem0/cells/efuse@a24,3
/apple_efuses_nvmem0/cells/efuse@a20,7
/apple_efuses_nvmem0/cells/efuse@a18,5
/apple_efuses_nvmem0/cells/efuse@a10,16
/apple_efuses_nvmem0/cells/efuse@a1c,12
/apple_efuses_nvmem0/cells/efuse@a20,5
/apple_efuses_nvmem0/cells/efuse@a18,3
/apple_efuses_nvmem0/cells/efuse@a18,a
/apple_efuses_nvmem0/cells/efuse@a10,1b
/apple_efuses_nvmem0/cells/efuse@a14,5
/apple_efuses_nvmem0/cells/efuse@a1c,19
/apple_efuses_nvmem0/cells/efuse@a24,f
/apple_efuses_nvmem0/cells/efuse@a18,1d
/apple_efuses_nvmem0/cells/efuse@a14,13
/apple_efuses_nvmem0/cells/efuse@a18,8
/apple_efuses_nvmem0/cells/efuse@a18,f
/apple_efuses_nvmem0/cells/efuse@a20,14
/apple_efuses_nvmem0/cells/efuse@a10,19
/apple_efuses_nvmem0/cells/efuse@a18,1b
/apple_efuses_nvmem0/cells/efuse@a14,11
/apple_efuses_nvmem0/cells/efuse@a1c,a
/apple_efuses_nvmem0/cells/efuse@a10,1e
/apple_efuses_nvmem0/cells/efuse@a20,19

      Arnd

