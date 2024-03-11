Return-Path: <linux-kernel+bounces-98991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B810878200
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3791C21027
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624A4206E;
	Mon, 11 Mar 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nSwfDdDt"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA841C7C;
	Mon, 11 Mar 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168520; cv=none; b=GBHDoFAVzJbYRFknh0nEBxYX5oMrexfD2S+msRhdGqacmmQZ13zTpWYU1ivC4pUnF560s+vQYPW53cZyBLg5FgqO3B2AIyP0dR7XgsiS8r9Ax6X64b8IwBY6m1VYBUIyeoZksNCee3/h3dfAfgigB03LGV16j15c2gQ0kqYVZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168520; c=relaxed/simple;
	bh=523jfBI1xIENsUirvelfVlDKtMZSRfA3IrXt++11hTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqzpGIUWypoYjDRHo38sU9G5qNBVH/Hk44UeJJxn9NIIv1F8vESLE5XJ1xxdYNG4mTbcHRDVJKHJM7cIkI52TMXdyoh6m0fmi+gvwnF1+OIldMuqIaB2AZnYQiXQbsE22OCqm7BbM/AKJlecbtEPtE9/WDk0aacPcBtmBkNyY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nSwfDdDt; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2607820010;
	Mon, 11 Mar 2024 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710168516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHkB9NZrCsX2vkEuwpPMC3STTmQwvzFReSv12yY2sNs=;
	b=nSwfDdDtzQzgjXbzdlv/a/rtvXf8qlWVrJyV9HKKfLfvwmRbw6cZkQv70TcZYmtvmVCp0g
	nyOYbro5RCPsCnu1Te4uvlA6hUQremIqJGoHI82Ny4zCytYbQi9HRqrQB6Tuia6DL9Aqey
	ZGTU2WBEF9JiEF+qRHcjpgHB1v/KG0bBbiWAO3Ib9fyNlHOxLkynTR4vsIEuRy3AO9QnZi
	KwJIWD+uW+FebkVzPF/IdM8KRsdviA5DQAE6wEG/g5MUtiTD4LxvcYCXgKlk8lnvTEQPWm
	v0uB5otsre3ZnKXNGz8EtH+1A9CMqCdXnThb9VBqISRwtqNuQgFvBWyU4Sk4uQ==
Date: Mon, 11 Mar 2024 15:48:35 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <thomas.petazzoni@bootlin.com>, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v3 net-next] ptp: Move from simple ida to xarray
Message-ID: <20240311154835.23679b89@kmaincent-XPS-13-7390>
In-Reply-To: <43b0b4ad-69ac-450f-8b39-ae264355622e@intel.com>
References: <20240311135949.1180157-1-kory.maincent@bootlin.com>
	<43b0b4ad-69ac-450f-8b39-ae264355622e@intel.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 11 Mar 2024 15:17:15 +0100
Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:

> On 3/11/24 14:59, Kory Maincent wrote:
> > Move from simple ida to xarray for storing and loading the ptp_clock
> > pointer. This prepares support for future hardware timestamp selection =
by
> > being able to link the ptp clock index to its pointer.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >=20
> > Change in v2:
> > - Update an err value missing.
> >=20
> > Change in v3:
> > - Refactor err management.
> > ---
> >   drivers/ptp/ptp_clock.c | 28 ++++++++++++++++------------
> >   1 file changed, 16 insertions(+), 12 deletions(-)
> >  =20
>=20
> sorry for not commenting more on v2 :/

No worry, thanks for your review!!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

