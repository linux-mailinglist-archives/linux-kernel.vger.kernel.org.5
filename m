Return-Path: <linux-kernel+bounces-98775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B427877F37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D11C217AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2E03BBC6;
	Mon, 11 Mar 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lYvI4ilx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBmUmFXC"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDC3BBCC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157384; cv=none; b=d8mGuHGu0R1ujEu3I3z2D+THi9bp8yhKV9XHTjXfj95hR0aT21XRLJ5czNMrCpw2rbcOqbN1pMr40zGH6zHEs9Oh4l82+Pr537l+gJ/roZQ87Ok2dvl4Pl4PyhYe2SE3UyoK+FJJo14v0e2CltPhQyoXJaeqccBJsjBoQXzGec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157384; c=relaxed/simple;
	bh=dUSSVd4bpD7Wuj2qhYTInbXUYg3ivnsEF0eKLdqsxz4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LRvseevqvLB3euzMA5MiFWFIF07+pYjb1qdG1y1yj8bglRgjY7c/QkgKWLzReS4mT+USi9Z+RaxKpOpEoXO8Ha0k13khijnN8UAoKuT+qsR4OwixwUJ5BiF8NuzT9vN3S1XVvjrOMJ8potX0I87oqNO2LFit+cSjAt+XijspTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lYvI4ilx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CBmUmFXC; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0E0C11C00098;
	Mon, 11 Mar 2024 07:42:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 07:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710157379;
	 x=1710243779; bh=ek5xhz1iNDGVCreLe4BeP1Rp355S8inPd2lUjGag3sQ=; b=
	lYvI4ilxMDHu3f8uLA/epJDnCCDPz+/FsOwHvgEzR7DpDP3TJhuuT+KR0I1GWUFa
	HU+PinzyoxuHns8sMbIWnUSJbnWuybz6tpb3ibWECvzIWuQLK8XN4FmMBBpS0bLB
	xVMuotpKB6MCCQobK1MmMO3Wg/UyOHSPzIp+8oGbZ3beJta/ZJyn9xw7by/MY7HA
	u/Vj1nCv1T+qIeig5QA9WivYEB5yndDSrgGxdK2ZtGNcMX+0F0lHhk7e8bTUbw3Z
	trsfVTwHn4M6qRFxsFi1pZ/HSjiLxJV36r7q8FP2BwSKyQp7UWtIs9/4fDfVhutG
	5kwxeld6pJvCvpO/flVdYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710157379; x=
	1710243779; bh=ek5xhz1iNDGVCreLe4BeP1Rp355S8inPd2lUjGag3sQ=; b=C
	BmUmFXCIcSfZoH0CldL2Jyba7Zkzdxo7VH3a3m1+2XCwcyLmUL1AQfDUwDW8u0uQ
	20HhBSDAg0muWHYU8c6Z7AbU5jS7ifk/egO8fFl0LKlObAyYNfJRN6U4bRZwTclI
	tbtyzkaNGXoGejASOTW56O4ay2WR6SegjBgRHCaouGYI9cUQv99m8U1tyzAruFNU
	9POAoOXPlQMfwhnhP4WKLpvw21J5n0NwA4qJAeZ8RPv8SxLmqkuM5uax5WquaDhM
	qNO2vx8NJjJW5ViPdKcqar/okRyMKr69vtxb8jbXGBO475S2sgBXJRc9D8rtXOFw
	QHVRnSQxhCiK99WD7ok5Q==
X-ME-Sender: <xms:Qu7uZSTdHjnpaOh7DchdMURwDJXvGQfMCAkgP4kkqZVyMTJmglixhw>
    <xme:Qu7uZXyc-Gm0qgx0JGQKQFuHn_P53o9eW-7TGxzAEg0XeRUKdYzLo3rg4aL015G4I
    ixzeOhBXkM50vFLWnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeufeef
    ieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Qu7uZf1gIj2FJDuy544F3jtBsu_Qth4W_Jh_-ipEphFZz6JUjNVujg>
    <xmx:Qu7uZeAF5v4tX6wVWgpehmnjRN1Jk0pFZtTYtAyE0AK4leCNKXr8mA>
    <xmx:Qu7uZbiE-xc7Y821oNFfr4Ze0eLlg6Q4ZHwpBZS4rOUOqHjcL2uNxg>
    <xmx:Q-7uZaSgF_RydoV_4eSDB8Uh_zb76rDYUZ9Zck3FU5oSl46PDAr3KC9sxe8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BDFDBB6008D; Mon, 11 Mar 2024 07:42:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d3a7a06c-e82f-4e5e-9ceb-6c659a228bbe@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdXKk9S9voKVPvO+xvn1zFW3FnKyVHQGDkC7b9Ynkcnvmw@mail.gmail.com>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
 <42892794-7668-4eb0-8d2f-c78ca0daf370@huawei.com>
 <2a90581c-f1df-4d6b-8f0b-8e7cbf150ed9@app.fastmail.com>
 <346e15e5-49e9-4a7f-b163-c3316225baab@huawei.com>
 <CAMuHMdXKk9S9voKVPvO+xvn1zFW3FnKyVHQGDkC7b9Ynkcnvmw@mail.gmail.com>
Date: Mon, 11 Mar 2024 12:41:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Yuntao Liu" <liuyuntao12@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Ard Biesheuvel" <ardb@kernel.org>, "Fangrui Song" <maskray@google.com>,
 "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024, at 10:14, Geert Uytterhoeven wrote:
> On Sat, Mar 9, 2024 at 2:24=E2=80=AFPM liuyuntao (F) <liuyuntao12@huaw=
ei.com> wrote:
>> On 2024/3/9 16:20, Arnd Bergmann wrote:
>>
>> I tested this patch, the size improvement was only about one
>> ten-thousandth, and the compilation time had increased by about a qua=
rter,
>> and the kernel did not boot.
>>
>> Strangely, LTO has actually increased the compilation time
>> significantly, which seems contrary to its purpose.
>
> The purpose of LTO is to reduce code size. Doing so requires more
> processing, hence the total build time increases.

I think llvm treats it purely as a performance optimization of
the resulting binary, allowing cross-unit inlining and constant
folding, but I don't think it actually tries or succeeds to make
the output smaller. I do remember seeing size improvements with
LTO using gcc in the past, but this never made it into the
mainline kernel. The last time someone tried to add it was 2022[1],
not sure why there was no follow-up.

     Arnd

[1] https://lore.kernel.org/lkml/20221114114344.18650-1-jirislaby@kernel=
org/

