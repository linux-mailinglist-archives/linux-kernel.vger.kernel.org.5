Return-Path: <linux-kernel+bounces-116737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2788A31E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BC31C39BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D11422CC;
	Mon, 25 Mar 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="enHZmhgK"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DF170A3F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357777; cv=none; b=gJZpWbRdEIFFQLF/sNicDAQ4d7Uyrq1aoM4ltu3vTelj85AoVRljKdZNyp/HJxgKPRzvOfL+g2ItmpKMbk12OvGdK+j4ZO0hfPnXcQdyxsJVWocvAbKtkxpYKtiWhuKy0jWBFbzlpG44gCn34mTdUp6Fio0o2KTgBm0OIItKLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357777; c=relaxed/simple;
	bh=myK+VAmTaTPxdQF4/X8FLBK790KZzA6ht2Keg01FX9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4q9jueYfuBFORlJ4XVRE481dLaT56zC7DlI8xHKpjk0og0qdvbO14ki9qAIyyd+YTqknhPNYPGIZftoZVjjVW/mrAz+Q8FCIL8iebQfiRiEvRBBCgAG55/08nZdt1ghGfivrDT3lBcpW6qzr13QytcrHj0+OIZtyx+c4jLk9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=enHZmhgK; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id E80C7C5444
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:09:26 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0770E6000C;
	Mon, 25 Mar 2024 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711357759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7SMZhAf4Am0rTnm/eARUporpv8JgZVnopqWzBN3xYo=;
	b=enHZmhgK7R2eEv2n80yLDfGotfc2qlr6jstwvnMzsZFNaSDo2gaooBLPB2v/FyK+o4h0m1
	cEgWXNpRUW3UWMFUzE0GcWPhuc2m4hGwUrViLbf8l9jLlrLOUiO6SBpEBtbzPgB6z2yoZB
	7zR5b0hQQhhCZ39hqL4yLow+YFQ546UeIsdwi1vA4++SOAfGe9uesYToBfwqG0G7rL8kg5
	ZmaopkO3vG99dpOiw45LCOfJMzmB+hkb97DOi7OfwAXrMsay0OtSmi4pUk29OBOshgcA2U
	mqhZRUdvyho23ubWuD3o7WzcLT5mO5xmCrw9K5VtZO4Eky11/HA1k7XfQbgAgA==
Date: Mon, 25 Mar 2024 10:09:16 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: mtd: nand: raw: Possible bug in nand_onfi_detect()?
Message-ID: <20240325100917.502c75b7@xps-13>
In-Reply-To: <20240307181931.440c9c3f@xps-13>
References: <20240306-shaky-bunion-d28b65ea97d7@thorsis.com>
	<20240306164831.29eed907@xps-13>
	<20240307-pantry-deceit-78ce20f47899@thorsis.com>
	<20240307181931.440c9c3f@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Alexander,

> > > > The condition is true and nand_change_read_column_op() returns with
> > > > -EINVAL, because mtd->writesize and mtd->oobsize are not set yet in
> > > > that code path.  Those are probably initialized later, maybe with
> > > > parameters read from that ONFI param page?
> > > >=20
> > > > Returning with error from nand_change_read_column_op() leads to
> > > > jumping out of nand_onfi_detect() early, and no ONFI param page is
> > > > evaluated at all, although the second or third page could be intact.
> > > >=20
> > > > I guess this would also fail with any other reason for not matching
> > > > CRCs in the first page, but I have not faulty NAND flash chip to
> > > > confirm that.   =20
> > >=20
> > > Thanks for the whole report, it is interesting and should lead to fix=
es:
> > > - why does the controller refuses the datain op?   =20
> >=20
> > See above.
> >  =20
> > > - why nand_soft_waitrdy is not enough?   =20
> >=20
> > I don't know.  That's one reason I asked here.
> >  =20
> > > - changing the condition in nand_change_read_column_op()
> > >=20
> > > Can you take care of these?   =20

Now would be a perfect time to send these fixes. Could you work on them?

Thanks!
Miqu=C3=A8l

