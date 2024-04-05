Return-Path: <linux-kernel+bounces-133286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580589A1BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF6B281DAE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120916FF47;
	Fri,  5 Apr 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXve/qOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E816FF33
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332067; cv=none; b=c4ofm/elaRtEd3BB49eA1saTMEBPplr2pgn0XQq9LIFsiH/mG1FDgDMuUhjlTxROqfGd4QAC/VDGYl/G/vGcgzzDD7XjiwWLUGoawSh5Tpz4tVaYPWREFls8vdj1LjUflFBnnJwiza3J4KJNeekArvUVf/UjdiLXyxNFHoq9iAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332067; c=relaxed/simple;
	bh=Qz4VZK/ytP0/9s88wplqYqEn1ox2CjHWrrOC2AmtCjQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ko7fQFNyqbWUX/wtooI0WghKkn6MeVOjZv8ncU3dQWGzCd5Qg+3ijhtzM3lBLxRA8GUK2sAmpEFUHRF0anYvCO6zkbMBRKh/UZAKu8yockeL3Ej9BXyNN0d06pzYigZBLVz6QtfiEdKHAVdoC4AUdWh6SzdrZxOnfRa11ayQ0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXve/qOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAF7C433F1;
	Fri,  5 Apr 2024 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712332066;
	bh=Qz4VZK/ytP0/9s88wplqYqEn1ox2CjHWrrOC2AmtCjQ=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=gXve/qOJy2MI9o2c1q8zE5qlqxTpZYzEYcG/lAXMV1wnWf77yf+abI4hYQIkNCQ1P
	 2rvdYUB+C0PkMh/12FhQy5yNqJpePutP7GfebB9NIf6n4RiIJtZVLS5SrZ9XU0cYe7
	 gmCuZyiDyj/PyqaWGMKMza6iuy8yHDp8XwdWxU8Sz4MSibWanxfQmFwttwR26kSkRN
	 NWpqsZkWOm7exLt4mS1f/qCTQ+SWNxcJG9on95EV/hxkscgZ963H2VccMxN+uHDG2u
	 CvdKb6HwBaMZWLwALCO6CvzTfVweSyS34AXaqNPFJqo1Ea7a6MHS69Sq1SCTnonWdz
	 mUgEb2s6nzFHg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 930A6120008F;
	Fri,  5 Apr 2024 11:47:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Apr 2024 11:47:45 -0400
X-ME-Sender: <xms:IR0QZsplW-_ktFdGPCKuRLqTT2VHn6agD75T3GCa1r47_H5Qp4ODvw>
    <xme:IR0QZirvi1FFsSTamDsCKMwp6-7MWDlywyUIBDcA-Au6hQHbQVlOEko6f-vO8s4AQ
    yQ5HsMC4_txRe7NeHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:IR0QZhPpjE8I7K1OMB6CwkGjmhikvFd6jidJ1RjWl_QWmGlpac1slg>
    <xmx:IR0QZj67zRQv4RABBN40awWEN1AXIM2_iUYq0rNGb0gSwhsQUAEcMw>
    <xmx:IR0QZr4xPk9YIh4SbMtGBl9860p4KsymijgELnXyVHEUjGRgpkgwTA>
    <xmx:IR0QZjh-Or6AWnDSXBDsIqK4xP5vFffeTflerfFNOcnAFIzi85h4fg>
    <xmx:IR0QZu17grOZ_OQZ5kWkV_OkGa2CfvsdBd4y6bH8NwouFprJzflcdmuM>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 473E1B6008D; Fri,  5 Apr 2024 11:47:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8287be1d-06d7-4ce8-806a-de4e764fdda3@app.fastmail.com>
In-Reply-To: <20240405154331.292421-2-schnelle@linux.ibm.com>
References: <20240405154331.292421-1-schnelle@linux.ibm.com>
 <20240405154331.292421-2-schnelle@linux.ibm.com>
Date: Fri, 05 Apr 2024 17:47:24 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Helge Deller" <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] vgacon: add HAS_IOPORT dependencies
Content-Type: text/plain

On Fri, Apr 5, 2024, at 17:43, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
> and may be merged via subsystem specific trees at your earliest
> convenience.

I think this patch can just get dropped now, no need to merge
it because it's already handled by e9e3300b6e77 ("vgacon:
rework Kconfig dependencies").

     Arnd

