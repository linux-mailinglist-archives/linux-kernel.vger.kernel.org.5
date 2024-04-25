Return-Path: <linux-kernel+bounces-158747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC68B246B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B376A1F21706
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FDF14A4FC;
	Thu, 25 Apr 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A22w9+DW"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192613328D;
	Thu, 25 Apr 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056892; cv=none; b=D/pceD9CyudXCLkexUxQiJy72wnEp1DxSsivJ8K5enMrnPS6Bc+HBGJsMuirQBuBLC2WKaueQ9J+mCM8QS+deS/P60UwnWxbk7QvXnDXMAtyCc7E9zv5vLZ7PdQs9sRuNGC6Kw4h9zEDN+5gDKBS3AbjF3tANmfJspjV9mQnVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056892; c=relaxed/simple;
	bh=VlYgaZ8GrcH/Rr/2IGTRZlH1ZOcJxWZyvjJ0czF+Fx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9CyjWhEEeXG10X1hf1/oOpoUEeYklJhKuPyeXbRg6Zjf8uDbKrhZvDvGulQfFHEEqaVBWxmUUpqxpc5hRZ7VrHJjh4iubFDg9wEAiHIK16hJ6xUQ6yAWreKcUBGjY5UDGj9/ML31Inr9aW2rsrUJove6hagG5ZxMFmYs8yQQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A22w9+DW; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0CA12000A;
	Thu, 25 Apr 2024 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714056881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuZ1u0XPoODtQKgA1bNoifGDi9IVoIWwmQloQXtBNSg=;
	b=A22w9+DWR9N0noMUVe4uc1+se890e9j+oeoTLKqEZ61nbmpGKm7C0v442+nj+BJ3oYcRGT
	1XNhtUU+eFeuCOm38ERNf/1wuGGXeDqLiC0FyBptbviekS0M9G2JzxeejeteW91MQmHYsJ
	i9LKAhoeHakp1bD/Z9I+StOGh7VIeQphsTSHsI1VFMtY9U/bBkv+X3uPD9IsAFn339PjxO
	+SCFMs2oxJhBRYEHDWIQrZTY3TTxCUAuYsQxgQ9Owa4PEwyQP3csqT+O+UHHpa14rlet8l
	c1RYuIdj56LjFpToUPxNAEkmQcsMtDU+MAKZ1Un5TkvOj+q7Y2B1JKCX5E7uQg==
Date: Thu, 25 Apr 2024 16:54:40 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425165440.0a25c8da@kmaincent-XPS-13-7390>
In-Reply-To: <20240425074205.28677540@kernel.org>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
	<20240425070619.601d5e40@kernel.org>
	<20240425163002.5894c5e5@kmaincent-XPS-13-7390>
	<20240425074205.28677540@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 25 Apr 2024 07:42:05 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 25 Apr 2024 16:30:02 +0200 Kory Maincent wrote:
> > > Could you experiment with tweaking the posting?
> > > Maybe we can "bisect" the problem.   =20
> >=20
> > Do you want me to like post a v5 with the "pw-bot: cr" tag? But if I pu=
t the
> > tag only on the cover letter it won't work then.
> > Maybe on all patches? =20
>=20
> Probably not worth posting for a test. I'll try to be more careful when
> applying in the future, we can experiment with real postings.
>=20
> > Was it the same for the PoE support patch series? =20
>=20
> Yeah, I had to apply that one manually.

Mmh that's annoying.
Thanks for the information.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

