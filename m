Return-Path: <linux-kernel+bounces-72770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9685B887
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACAF4B299B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107360DF0;
	Tue, 20 Feb 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fnWbcsa3"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1B5D725;
	Tue, 20 Feb 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423490; cv=none; b=luTCn5X6Cv6pJ6TkqhdJaysN2xR3DX6KP2ON2u38eswdm21d/PnFp0YThYCXTsQAStfdePqe6QGE/je7QwR4a/oE19H33xuRENNMPd8a/7JiERhHni4k7XJ2pfYMfkyxAVty4BJJ9KI/EN6Qr0Z2s9+3OJC80pj2aonBABBeAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423490; c=relaxed/simple;
	bh=g150G+kg+E+6/Sxn9+hi28SRHRZCgESL7xat3l+beq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSBa4WB9uz6hhxMb2RGkh9uiPQsm7Ub60rqhU1/W+x8wkliparekNRSavf+8CC5A/OG95633mFlBNd0FrA7bXvTfKuHCK5uesQ9wnO+qMtFFDsoDTES02Lq/2qoQmxxSlLiXTT2WevMMlHFhPpFsDgcNMKc2fKT/NGHGGYQ81ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fnWbcsa3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EBC9FF804;
	Tue, 20 Feb 2024 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708423480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g150G+kg+E+6/Sxn9+hi28SRHRZCgESL7xat3l+beq0=;
	b=fnWbcsa3/8NtmxWPQLq/Zl+v1rrd5cYZROyVextY4szpev01ATeoNkpx5PW1glxlT0YyPn
	BQgiLJJ8PcPopuznTvsy2KFJJ+ilzLse1Li1Q1YF/RdshpBRtCAt43bwSSLdSWCG1nDOjA
	Uu1xigF3ORVHMkiWwpEp9R6HbWNk0VeI+Pg5q4S9D0d6FrmgxdBay3WgfSRr4G1et8fwYE
	xn8rLL+m1PGZ8qBkUv940jJ+EACbNAifiPB/6x7JS0bgnm6aIrGkR3uZJEdRyAKsrgxO6+
	11Y7T7+pKRDZy+AuObr3XMg1CRVzG2D8Z8OMKwkqm4WnIZk35lQXcY3oV/t14w==
Date: Tue, 20 Feb 2024 11:04:38 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Bo Liu <liubo03@inspur.com>, alex.aring@gmail.com,
 stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ieee802154: at86rf230: convert to use maple tree
 register cache
Message-ID: <20240220110438.247e2746@xps-13>
In-Reply-To: <CAK-6q+jnZOkSAM8_BQH=CaQhfCQwm0P+segZ+0E6oLeX=BhLHQ@mail.gmail.com>
References: <20240202064512.39259-1-liubo03@inspur.com>
	<20240202085547.46c81c96@xps-13>
	<CAK-6q+jnZOkSAM8_BQH=CaQhfCQwm0P+segZ+0E6oLeX=BhLHQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

aahringo@redhat.com wrote on Mon, 5 Feb 2024 14:42:09 -0500:

> Hi,
>=20
> On Fri, Feb 2, 2024 at 2:56=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
> >
> > Hi Bo,
> >
> > liubo03@inspur.com wrote on Fri, 2 Feb 2024 01:45:12 -0500:
> > =20
> > > The maple tree register cache is based on a much more modern data str=
ucture
> > > than the rbtree cache and makes optimisation choices which are probab=
ly
> > > more appropriate for modern systems than those made by the rbtree cac=
he. =20
> >
> > What are the real intended benefits? Shall we expect any drawbacks?
> > =20
>=20
> I doubt it has really any benefits, only the slowpath is using regmap
> to set some registers. Maybe if you change phy setting frequently it
> might have an impact, but this isn't even a path considered to run
> fast.

Ok, then let's take the series I guess. For the three patches:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

