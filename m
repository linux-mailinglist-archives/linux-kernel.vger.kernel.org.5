Return-Path: <linux-kernel+bounces-128312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FA4895936
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9A91F236F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F813342C;
	Tue,  2 Apr 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FHeCl4Ye"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911113329D;
	Tue,  2 Apr 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073831; cv=none; b=NtcW4SrRk60GbhghHUuxb2x9jq2ym1ZkT5aaHYjekxdov6/1KGBOSI4nY3wkDOHFAIHnO4eBUTuDF0iluOaDF1s99+n54IhJqHlAyeRLYZhmDzFRb+JyhzEXsoHVRf7r//Pel6b2eBibpOwNd8GeCvFwf1dOucznuvHmTif6Y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073831; c=relaxed/simple;
	bh=+yb9QZnkwSHjba8DSoLfJzX4aYjxaHV4oVtCa/UzPVg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kk2blaEVE5kyJRofMPn6r0gpH5qWOgUbIqwqYEoYMNn7evbje1RSfsps1ZlsnYPceTdLudNyiy3SoIC0D3W75z/TMkORtIfB6Muq63TfEAdKBCOl5LsjV+jDuMhfmlhw3x6Eav+luqdN8N0aTMeZpzm+gWJWyH1C2B+VeO7CcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FHeCl4Ye; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06BC9FF805;
	Tue,  2 Apr 2024 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712073826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lB0l3EgmoR6B4x67AYdVJyikUkYe+1vfYgUCVxFlTi4=;
	b=FHeCl4Ye91VysIY97+9CuN2lZTq+z+sDUDrrKaLQ6WGxlD7jJDCWWe6Qzyn1LiOuvTirKv
	DtUTV0DNxOUroUmyrf3CRGsIojegvluEPLIK6r8qOKjh10BVGyz3rQcJhtTbf3MBOPoe/G
	8bkNo07L7FF0ygnG9Oo4FJsXUvwIGsuPgZxDhtwyPL0O8XxbVD9JMdk0lXIC5OvPa+32V3
	uPqqLiaMMQEbHn9p2xMcQthSudzmC7GgSufy2qdZvrgib5PA8gRHJjBiuRno61pjz2+iY+
	6m/MTNKSS6ioZaOUtCrqL8ZuuQjPGwFBo05f2btGBm9974bd/xuHiyUJISF53g==
Date: Tue, 2 Apr 2024 18:04:20 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
cc: Romain Gantois <romain.gantois@bootlin.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Magnus Damm <magnus.damm@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    =?ISO-8859-15?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-renesas-soc@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 2/3] net: stmmac: add support for RZ/N1 GMAC
In-Reply-To: <ZgwoygldsA1V8fs9@shell.armlinux.org.uk>
Message-ID: <36a4a94f-494f-2fef-11e1-8b45011c1263@bootlin.com>
References: <20240402-rzn1-gmac1-v1-0-5be2b2894d8c@bootlin.com> <20240402-rzn1-gmac1-v1-2-5be2b2894d8c@bootlin.com> <ZgwM/FIKTuN4vkQA@shell.armlinux.org.uk> <ZgwoygldsA1V8fs9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hello Russell,

On Tue, 2 Apr 2024, Russell King (Oracle) wrote:

> > I'm afraid that this fails at one of the most basic principles of kernel
> > multi-threaded programming. stmmac_dvr_probe() as part of its work calls
> > register_netdev() which publishes to userspace the network device.
> > 
> > Everything that is required must be setup _prior_ to publication to
> > userspace to avoid races, because as soon as the network device is
> > published, userspace can decide to bring that interface up. If one
> > hasn't finished the initialisation, the interface can be brought up
> > before that initialisation is complete.
..
> 
> I'm not going to say that the two patches threaded to this email are
> "sane" but at least it avoids the problem. socfpga still has issues
> with initialisation done after register_netdev() though.

Thanks a lot for providing a fix to this issue, introducing new pcs_init/exit() 
hooks seems like the best solution at this time, I'll make sure to integrate 
those patches in the v2 for this series.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

