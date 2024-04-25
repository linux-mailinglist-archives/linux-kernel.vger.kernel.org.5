Return-Path: <linux-kernel+bounces-158749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDCB8B2472
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748301F213A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8F14A600;
	Thu, 25 Apr 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dTuTsP+I"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05C1494BC;
	Thu, 25 Apr 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057036; cv=none; b=el0mm4IMxyACvVO1e14QaDCP90x91E1hWVGHZ3od08g2zi0j2xFEFQX9A1lgiUWr6mEwYiRvQtcUSQx4CEUP0mbrc8x6xktPk6GTsMvqMZW4S+MzN7YJX/kB9RZQibg51pjQ8rzBXt3vl0K+lRAC902AfevU1zNFxHPsMvrO7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057036; c=relaxed/simple;
	bh=C+itTDL3A8PImRFwW+2p6GQPM8DKabS7q7T2fAZamHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/doet/D29p/5iGs60yYNX4g2k/gNJLqmX004Z+ZqAahNN2e9Jrb5UwANUIWB4fL7Fmh2sXHq4eVoHw6TwbZTZOdXJllgNhFhWob8eD4i19/tKh2lQrjldNRaWfLHy9R07324O71k8ddiy3S5pGN4BZtUt+oumXcVni5mtAQ/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dTuTsP+I; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1A4DC000E;
	Thu, 25 Apr 2024 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714057031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLXxiz1Ky5nDojL/VVZQzWe2VuDpGkCwUW5hLfQwjTQ=;
	b=dTuTsP+IJ5VW2lbM1ddRFj2We5xV5pmpubZYOL40eP5CzdUdw4HK5hI/TwjkkNGitqI+V7
	EHOb4rX02VdKbmDDCzSRX1vu9J/lThB2MJ6N70EWe7YgWaaAEv405hgbnVa6wwCnwuxiTt
	GvhRuv8tcGdo0UgWKU2YH9VbpOWAhRQnTW6ENgMphNngVpxIaGXKVZgw7evXyYNY1WYuiV
	h6OPRKqksC7aSKUsrcHlDBh9GI0+dPtOt3txV1HaeyAdNf4XIdzNwrF+rcrOmx6fgRq3X0
	P78gjr4+e+1X5wHYQaicz7vR4RECbCk06gHgHwtKf5oCSo0YhJHRp8wFj1+0SQ==
Date: Thu, 25 Apr 2024 16:57:08 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425165708.62637485@kmaincent-XPS-13-7390>
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

Does this patch series is on the same state?
https://lore.kernel.org/netdev/20240422-feature_ptp_netnext-v11-0-f14441f2a=
1d8@bootlin.com/

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

