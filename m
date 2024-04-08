Return-Path: <linux-kernel+bounces-135215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5689BCD8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549561F22135
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A65339B;
	Mon,  8 Apr 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvKU2GoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A3524AD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571462; cv=none; b=qIEyZmoatXd0654MHfNtOn9th3RtMAL/8sIdb441EGcL543CTF8rzq5Qou+K/PuW0N/vaYniEAaJmphpnpisn8U/UZrXykXz4KAJrmLbiY6+uCTSDYkCtX9CYz+LsaugfrV1Q4enDedwGMJpGtnNdWSW0AVrmEZOHv2kjwpTCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571462; c=relaxed/simple;
	bh=OG9cNKuW5LqEoaNK3TpF1vRBrzAoC6dHxwMeVlrmYwk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=M1SDkOaGURqkwzX/K18g7skwep3LLFe69sRLFUnxU8HypHk29Tj4vtfl4GXDNHggMmBu7fTCNPfnD5+eFxs1vqmiLK53AWFkf+2i1XcDmeuqMdi0YL91yecnLyToOE6vLBehWflDXcm6DNsjKReBrphQanO/QUJjr3O6quamSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvKU2GoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66E9C43399;
	Mon,  8 Apr 2024 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571462;
	bh=OG9cNKuW5LqEoaNK3TpF1vRBrzAoC6dHxwMeVlrmYwk=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=rvKU2GoZyRcnmUQC6I5QcNLol4ltbN43mN908IkVPTkRzrbhzbMCk23uo9Ggd4N6Z
	 5J3ny7gOZmeOGpWDXUXiKl72V0qUBosunju6XK7c7xCAfrsnYUI/mv6LoWfEbclkrB
	 CabtOpETgsDZ1Ty+xrCI7O09f+54S/H1Gg5OUSVXj7y6EarRWRZzerfnK/FgzmmBF6
	 EotvhUS9LO+z74cEVHbOi+MvNM+13oMn8Fdp5Xbpi2d6RDTk0aw7+cRhGswBYgtYa1
	 z5yhslDnxNU81okjLWme3mGQZUOXPxycLAkO8UcSVvs2xEZZmm1KoCkuqXfSgYpS7Y
	 d2D6PftNbxQqA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id DE6371200032;
	Mon,  8 Apr 2024 06:17:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 06:17:40 -0400
X-ME-Sender: <xms:RMQTZhvjfL83qhCd2GU_ETsiMg40OoKqUFwstf1AW8Ut7xLxONl59A>
    <xme:RMQTZqcQEcuQtDs_bJGOEqNoBwfsKvPxQdcZz-XIY7TtvOlxCaVemOcxYaFxG6Eop
    oBczHKsS7PcWAfUqnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:RMQTZkx5ju5gpobZgFR8FVpj5E41Gdvwap84jlBI0D2r0A3jAsCQoQ>
    <xmx:RMQTZoNZl5IuWlGdOZTq1LEe75nV_jMa7w2oRRj161m9WXyBw7H-2A>
    <xmx:RMQTZh-T5L8NzLGr69g-BX6dDea3rOXCIjbLAr5rFOxLfDwHCVVbnw>
    <xmx:RMQTZoUa-xMGeRHODc5ituxuH9M5NJDS8kjIxaZYlbkoEBdXPXCayw>
    <xmx:RMQTZida91ZjUK0cXg1N6T1yaIQnrzUXPzzGJtpwkFEMHrRf3pjcK5Fj>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97B6BB6008D; Mon,  8 Apr 2024 06:17:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80c20c7b-4e7a-43af-8b59-7f2a98272e99@app.fastmail.com>
In-Reply-To: <1a14ac6e-30e9-048e-50cc-c1c3aacc2118@linux.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <1a14ac6e-30e9-048e-50cc-c1c3aacc2118@linux.intel.com>
Date: Mon, 08 Apr 2024 12:17:19 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024, at 11:54, Ilpo J=C3=A4rvinen wrote:
> On Fri, 5 Apr 2024, Niklas Schnelle wrote:

>>  config SERIAL_8250_CS
>>  	tristate "8250/16550 PCMCIA device support"
>> -	depends on PCMCIA && SERIAL_8250
>> +	depends on PCMCIA && SERIAL_8250 && HAS_IOPORT
>>  	help
>>  	  Say Y here to enable support for 16-bit PCMCIA serial devices,
>>  	  including serial port cards, modems, and the modem functions of
>
> What about drivers that use SERIAL8250_PORT()?

It probably makes sense to hide these, since they won't ever
work. I probably missed them in my initial series because they
don't cause a compile-time error, but I agree that there is no
use in showing the options here.

> Also port provided in 8250_PNP might expect it I think.

I don't think these need any change: 8250_pnp.c supports
both IORESOURCE_IO and IORESOURCE_MEM based ports. It will
still create a 8250 port for the I/O based ones but they
will now correctly fail to probe in the main driver rather
than crashing the kernel. PNP devices that only use
memory BARs will keep working as before, on both machines
with and without CONFIG_HAS_IOPORT.

I think that most 8250_pnp variants are probably used only
with ISAPNP or PNPBIOS, neither of which exists without
HAS_IOPORT, but you could certainly have PNPACPI on arm
or riscv machines that don't have port I/O but come with
a memory-mapped 8250 port described by firmware.

    Arnd

