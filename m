Return-Path: <linux-kernel+bounces-1223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67171814BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2375C28457E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361639FD5;
	Fri, 15 Dec 2023 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cUtNrFUl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41E381C7;
	Fri, 15 Dec 2023 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38FAFE0002;
	Fri, 15 Dec 2023 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702654750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNahJ5sqSJhrwkBDC1RIAjVtG6sff4pIl2AnUrYvSNA=;
	b=cUtNrFUlD/0D/xAiAtOLaWX1JZ+RunFsT68wDPh3WnQ36Z7Brrq8dFphBoHjQWPx+h346I
	Ip9vDdJl49ZoQxFUCiZD8Xf1Zen9RiazHId0K0u8kMZm2L/7SmetLkk3/zbYW63Rp41sEo
	B3ZNnSoqE3OLOyrYGexXUpWyicicjn0/3ngnp1yspHdb8DxtWYih6Lgnkm9/kD7N+/DOSh
	/KVkw/gS7LcNLEpzR2mbt9v1oA1FF/FsDIl5t1HdB8zvJEZcNOojQAafWtgIKHlBxY/MqT
	BZJD+Nh/KEANB3LKcDRBn5BKzXRg3BBLtKkZZc71Ibv5NhRDENDB8xrxaVGzaQ==
Date: Fri, 15 Dec 2023 16:39:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <20231215163907.7dbd5769@device-28.home>
In-Reply-To: <20231215105928.74608001@device-28.home>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
	<20231212153512.67a7a35b@device.home>
	<ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
	<ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
	<ZXn_id6-XWYr2Seo@makrotopia.org>
	<6dd8d8b62d6db979d6c2197a4091ebc768e6610a.camel@redhat.com>
	<ZXsyt+msigtNiLN9@shell.armlinux.org.uk>
	<37a66b85-3980-4553-8447-d040404bbc11@lunn.ch>
	<20231215105928.74608001@device-28.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi all,

On Fri, 15 Dec 2023 10:59:28 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hi Andrew,
> 
> On Fri, 15 Dec 2023 10:46:18 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> > So, if i'm reading this patch correctly, it only affects PHYs within
> > SFPs.
> > 
> > The discussion went off on a tangent and also talked about media
> > converter PHYs, but from my reading of this patch, they are unaffected
> > by this patch. Do they however also suffer from this deadlock? Anybody
> > tested that?  
> 

I gave it a try with lockdep on a macchiatobin, but I couldn't even
reproduce the original issue (tested with the tip of net-next and net),
so I can't tell if the media-converter PHYs are affected as well. I got
no lockdep warnings regarding either paths.

Maxime

