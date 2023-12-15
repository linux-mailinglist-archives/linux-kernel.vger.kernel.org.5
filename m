Return-Path: <linux-kernel+bounces-714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AD8814501
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EFFB2236D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5D18C18;
	Fri, 15 Dec 2023 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="anZH1k01"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044518AF9;
	Fri, 15 Dec 2023 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06B82240004;
	Fri, 15 Dec 2023 09:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702634372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yExJ2o/kc8OLXIlEOTC2J4B49akJNkoaJGJOI+Bu0FI=;
	b=anZH1k01slCSYKb4V1xZMlexTsV75XZ5Aka0I6oA6yhuAq38LsOora95YD8h0Stu6dgxxN
	1hHFB1NUUAkctIBJ1r7ufRMIfsnAVMoJcUIMTNw4QQN5bVSTamR+BZH+rNsZY7hDmVsbfo
	cPTnLkRcJQS0LeeYKDDU3UH+6gS6dDGIItYCJGd8greNpvep2cUyI3LxSNM+yR7dDqHpnO
	I06jXnrzEmr5Rum39s6+z1V02ZU1J0vapuAtnwFASq4IcbVCPz5qufSgWoqWho24aPM3Of
	l0CH0XnFfo8awZNH9fTI6c8KTSjsjqEX5he9TMpKELzNdTlbQ3lg0k/5OtQ4hw==
Date: Fri, 15 Dec 2023 10:59:28 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <20231215105928.74608001@device-28.home>
In-Reply-To: <37a66b85-3980-4553-8447-d040404bbc11@lunn.ch>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
	<20231212153512.67a7a35b@device.home>
	<ec909d14-e571-4a50-926d-fbef4f4f9e0a@lunn.ch>
	<ZXnNYJer0JrJxOsl@shell.armlinux.org.uk>
	<ZXn_id6-XWYr2Seo@makrotopia.org>
	<6dd8d8b62d6db979d6c2197a4091ebc768e6610a.camel@redhat.com>
	<ZXsyt+msigtNiLN9@shell.armlinux.org.uk>
	<37a66b85-3980-4553-8447-d040404bbc11@lunn.ch>
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

Hi Andrew,

On Fri, 15 Dec 2023 10:46:18 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > I disagree with that - analysing the locking and coming up with a fix
> > is likely going to be a lengthy affair, meanwhile the mainline kernel
> > will deadlock on this. This patch prevents that deadlock at the
> > expense of removing the LED triggers for the PHY-on-SFP which I don't
> > think is a big deal considering the age of the PHY-based LED triggers.
> > 
> > So I personally would prefer this patch to be merged while a
> > different solution (that we have little idea at this point what it
> > would look like) is sought.  

I would agree, I feel bad about delaying it , although as Daniel
mentioned it's indeed the trigger registration that gets skipped.
 
> So, if i'm reading this patch correctly, it only affects PHYs within
> SFPs.
> 
> The discussion went off on a tangent and also talked about media
> converter PHYs, but from my reading of this patch, they are unaffected
> by this patch. Do they however also suffer from this deadlock? Anybody
> tested that?

I can give it a try today (in a few hours probably, I'm experiencing
a power outage right now...) and make sure the issue doesn't occur with
media converter PHYs.

Maxime

>      Andrew


