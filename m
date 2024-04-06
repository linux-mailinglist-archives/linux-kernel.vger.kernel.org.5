Return-Path: <linux-kernel+bounces-133843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D689A9A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185791C2134C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBC322F02;
	Sat,  6 Apr 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZMaRcXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1771EB40
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390809; cv=none; b=bPphZogU60R5vdlU8WS3psvwHPtkYfUlYhnfeIQMfJ442TOuFmQ+sRaREVr4M6Iwjui1nMlvreSGr5BXb2zwyh7mEXjn7hG8IyzRpdnsL29JxA6LK4nO7APB3MLDKnahrACuZtTfgcPBdFoExRyQggit6msWReQs994DIctLQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390809; c=relaxed/simple;
	bh=M87uudLlyUpqSYEX63NZsIYqD2BGh3l0n8hlMS93E4U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Mt4ijT+GgHb7hf0ILV7g7DUM/s2828rGCj8w5gHURlYz3VZPgfRL4X8b8ULVNrDWawn0TXdnFRMFHCNulGENis5nMkFZnU0iacZ/CFbPKccGlgonLKUwkarjYpLp/RkqO4cYMLhEg8BgHnM5cwS9gax2mdgEjGkCLzNY2zACHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZMaRcXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0245EC43390
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712390809;
	bh=M87uudLlyUpqSYEX63NZsIYqD2BGh3l0n8hlMS93E4U=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=DZMaRcXggFxoaTFtgJFZZSIS8FJbGkFVCdMMOawJwkiu0/XSao2jO7OScmYiQmq7E
	 aGIKIRq2Wpb082mBWY5+pOW+ekN0aEVS77gODR6ytHOnMIsWb3+v8HR0T+v7ww3ccN
	 aPJe2MRdVQAKNvwbTQJYpKk8rzGIOnptM40pB+OSecgmRVIbqM7U949gZ50XpOkVCx
	 L4s45kLH5getuGe3e2EmoqmtYZEbLPjW3QnceLq5YgdGeGGo1zdwZqXpqVRFsJHT47
	 crX9A7gPMJCB6wbN1vTAeJcTY1Wbr9lNCOzt5eFRYzaAYPuEnNOwpQbPvu7EmlSDuE
	 38rPvLIibyUog==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0627F1200066;
	Sat,  6 Apr 2024 04:06:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 06 Apr 2024 04:06:48 -0400
X-ME-Sender: <xms:lwIRZhfGxOfrq3GRd6jrUncCIgt1032rvYV3h1tC9BRH1mdw0k1Hdg>
    <xme:lwIRZvMd609QFkaSkldvCzTg-up2jq1WFbigPvZBDkWJTLW4qnfYHQvEUFfbalSQs
    EE5R7uSdyakOwrkKVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeelvefgudeiheefledttedthfffgfekudegkeelffdtiedvgfevieetteekheff
    veenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkh
    gvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lwIRZqhqaJE6nrIv7iq94np4B3clKvBFCWeBms2nHPX9HazvEWFeTg>
    <xmx:lwIRZq_FCwFnKL65wo2I-wHIAMoQPHRvBOrrrjLHZRgbZWcNW2GnlQ>
    <xmx:lwIRZtspNkEHBTzoEnmofoh-Sv4WjWHiPtzHQ_1OgZHh3J6BdujJYw>
    <xmx:lwIRZpEwdW4VCUXgH3ti4aW5vKmRKdP__imCofjIpm3BGO02BZkS5A>
    <xmx:lwIRZrV3vkNe6sCYNq80UxYlG_mr8KktdGBhKrsiuybh1cvNUzd20Qzb>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E64B8B6008D; Sat,  6 Apr 2024 04:06:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e6757c1-10ad-4852-9927-6e0dca100524@app.fastmail.com>
In-Reply-To: <ZhB8MnWSeySAHGXG@black.fi.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <ZhB8MnWSeySAHGXG@black.fi.intel.com>
Date: Sat, 06 Apr 2024 10:06:21 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andy@black.fi.intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tty: Handle HAS_IOPORT dependencies
Content-Type: text/plain

On Sat, Apr 6, 2024, at 00:33, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 05:29:23PM +0200, Niklas Schnelle wrote:
>> Hi Greg, Jiri, Ilpo,
>> 
>> This is a follow up in my ongoing effort of making inb()/outb() and
>> similar I/O port accessors compile-time optional. Previously I sent this
>> as a treewide series titled "treewide: Remove I/O port accessors for
>> HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
>> subset of patches merged I've changed over to per-subsystem series. These
>> series are stand alone and should be merged via the relevant tree such
>> that with all subsystems complete we can follow this up with the final
>> patch that will make the I/O port accessors compile-time optional.
>> 
>> The current state of the full series with changes to the remaining subsystems
>> and the aforementioned final patch can be found for your convenience on my
>> git.kernel.org tree in the has_ioport branch[1]. As for compile-time vs runtime
>> see Linus' reply to my first attempt[2].
>> 
>> The patch was previously acked[3] by Greg but given this was almost
>> a year ago and didn't apply then I didn't carry the Ack over. That said
>> I don't think there were non trivial changes.
>
> Hmm... Can those drivers simply be converted to use ioreadXX/iowriteXX
> instead?

Not 8250, for a couple of reasons:

- the irq autoconfig code uses outb_p(), which has no iowrite()
  equivalent
- the driver is used on machines that cannot implement
  ioport_map() because of the nonlinear address translation,
  e.g. certain early alpha and mips machines.
- it still needs its own I/O abstraction layer to deal with
  different-sized registers, so the result would not be any
  more readable even without the other issues.

     Arnd

