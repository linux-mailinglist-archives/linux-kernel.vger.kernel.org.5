Return-Path: <linux-kernel+bounces-28357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D124A82FD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B661F26E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C7820B0C;
	Tue, 16 Jan 2024 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ffxdNJuN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N63D7YBR"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE520B02;
	Tue, 16 Jan 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444781; cv=none; b=E11KdpDRsJAca/g2seHxizFVB+VR7SzygW9Bv7JxAYHdkP2hhS3l2mtKIdBdHj89dJnVn3psYe2vRr7kB3787lVaUBfrULgb6d5dxcv3PtxrPJ86WeuoqE7fi/fCaU6+rvq0faNaTgA18ks5VWWDCUuPQfOxTIIzGgsUjDmFD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444781; c=relaxed/simple;
	bh=+0eU185BHaQpFuiRrDOSAIFyikA8TLUt+t0Uoh/cK00=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 User-Agent:MIME-Version:Message-Id:In-Reply-To:References:Date:
	 From:To:Cc:Subject:Content-Type; b=QnVkvQI40MGvaoDtgHkTH005SaGlTRk05VERXr5hOZOXGaN2PVqctMqwm5KI34I5RdY0fUQ2fFd33qRN+odP5f2CWA2nmjgkRidZT8bu9AYUwIMM/s4OiovyWsw1CVE7cZEJfc58pkoBq36RHpPNsg3R+X1TE2J9wxkRhFUBKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ffxdNJuN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N63D7YBR; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id BDC413200B81;
	Tue, 16 Jan 2024 17:39:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Jan 2024 17:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705444777; x=1705531177; bh=uI5ZT8YAtQ
	u/Eoi5hyzYJ2u39RRNNOFIANZZEbK2YO0=; b=ffxdNJuNMPdSFcVjkYzTmp1yFC
	YOi7er1MlNFzacpR2cgMFdHIvfyelax/GsL50+hY7Aiga0CFTXlCxIm919xDC7Ac
	pQd+kKl7ilBnqg3NVWkDg/q3M2t7ZdVQyJWUO1LypmTrx57NmMMGkvYToOKhOwdD
	sn3Puamxd/FSMnhfqQ8o6bPsWXLV378wqs1rNOn+FitJwb/GY6lGA+lFGfyqtIKN
	Sut32U9LxpowNQ/5WkzOhWRVqp5NhlQXt1VQTHe+F49YftqBXdes4WUYBv8zZ5OA
	ZcNa4xYCgyuKwkp8AEz1TIKgKyIO0lbfgY9mxUzwkpJWqOqkxrsQjZ//hhXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705444777; x=1705531177; bh=uI5ZT8YAtQu/Eoi5hyzYJ2u39RRN
	NOFIANZZEbK2YO0=; b=N63D7YBRJsgecge6r9A+dvISVWqivog82i2wDabXFgyU
	/9w6ZYMZK8D3HlwSy+uDC+ObXMivmiqtc+Ajphm3aWn3cX0+//3OftkWrbQIL5XX
	aJrt6ZEhjt7BFY15CFObd/9G0B70jz2R8MHitPkrieg1v9Cgce1/JHQNuqPgV+MT
	E1WnutT5eQLpg6se3inYsPfZRJmgYBRq5uYMB2Vm3CfMCPJW7DB/v1VdMZJnAaVs
	Fz9uNigGb9cVPSZ3VKm3yH7LrplwhpwvlCNYX6H0wLdnbt+9P0f7IB0RAqQj1DXi
	ImoReGNw+hW4eHI54GCbD7jI6LlNPFLaHyG+ZRYDvg==
X-ME-Sender: <xms:qAWnZaWG-RMXB3RBqW7YNZ2eFt6jcMaYat0GHEGRH4e26SX0g9Opig>
    <xme:qAWnZWmuSC6zX8TS6iyWAW2xFiNI0eA00XcRZBbkCXEt1xktPHNa_2yyY_hzp1hSU
    22n3AKhsGEqK1eeXVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qAWnZebw0M_Rcow_Lga5WMlB1uqRsQnFoF6GMObPXuLqpVm-rgwhMA>
    <xmx:qAWnZRWiUAFkevek3uc0xmrV2Zy38RC0BYFHBXK2AfsDMTsOG4dN9g>
    <xmx:qAWnZUmlk95vmMg0apbRcpDbwKagMc3XXkUmS3mHF5U21teMsNbH0g>
    <xmx:qQWnZVBrC2XsAdPF8llO_hvFxi0SX6lyFYZNcJZVYFPA-oZA8k_6Vg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5DC86B6008D; Tue, 16 Jan 2024 17:39:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b2411a9-418e-4134-8ccf-24813797f551@app.fastmail.com>
In-Reply-To: <20240115150200.513531-1-andreas@gaisler.com>
References: <20240115150200.513531-1-andreas@gaisler.com>
Date: Tue, 16 Jan 2024 23:39:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Sam Ravnborg" <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
 software@gaisler.com
Subject: Re: [PATCH] MAINTAINERS: Add Andreas Larsson as co-maintainer for arch/sparc
Content-Type: text/plain

On Mon, Jan 15, 2024, at 16:02, Andreas Larsson wrote:
> Dave has not been very active on arch/sparc for the past two years.
> I have been contributing to the SPARC32 port as well as maintaining
> out-of-tree SPARC32 patches for LEON3/4/5 (SPARCv8 with CAS support)
> since 2012. I am willing to step up as an arch/sparc (co-)maintainer.
>
> For recent discussions on the matter, see [1] and [2].
>
> [1] 
> https://lore.kernel.org/r/20230713075235.2164609-1-u.kleine-koenig@pengutronix.de
> [2] https://lore.kernel.org/r/20231209105816.GA1085691@ravnborg.org/
>
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the follow-up.

Let's give DaveM a few more days to reply, and will merge it through
the asm-generic tree with the Acks it got by then. I think this patch
should be part of the bugfix branch for 6.8, while the series from
Sam and any patches you have in your own tree are probably 6.9
material.

If you like, I can merge any of the 6.9 patches through the
asm-generic tree as well while you get set up with your own
infrastructure.

     Arnd

