Return-Path: <linux-kernel+bounces-52883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5430A849DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E605E1F21B72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266822C84F;
	Mon,  5 Feb 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OqKMP23s"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8572C6A7;
	Mon,  5 Feb 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146269; cv=none; b=jzhyzH/PgHBCwqPNAo52flF7jpPg3t5lv3DyiHID2/VgC8/bTTQeJhWjCXAk3PdGk9/oC3X/AaaNMLLUNzxpzX8JgfJPKC0MtlpFjDvuJIZqSwWTMW3/7OTWkJJO8g1B52pqpeV5GoE1hqSZ3V5FvBzlvFBzfN8yBlGLPkkEW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146269; c=relaxed/simple;
	bh=J5h136Z6o5MpC5NtPS2K7viSPN8N5yI9efnCDUsJ24c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuFtUfL8GhP5GFkcBGHG8dzfVHKsiBSpraIDwUU9nZJlmN3chuqlyBmDwZsVB+K9lMmQn7yIU2bTJ1cwM22c55rtJbkJpAddf+A0TrKE7PCxO/x+0S23GctZHSvqH5JgNi33N3wEvCPm771C9CBGOeiWBB9UvtFfIg8NTHHqmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OqKMP23s; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1425FF80A;
	Mon,  5 Feb 2024 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707146265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5h136Z6o5MpC5NtPS2K7viSPN8N5yI9efnCDUsJ24c=;
	b=OqKMP23sJ9USNkvLnB89vcAw/4g9Gdwip5r7ovmTsI5T+DtcK/6Y6dpojmZXiqQ+xgRgVR
	xzRqfeqRW9Gtf28YycKhbuRFbApbvHgAHKNfprDL0Vte8aRZeodL5nLkuWz+d/NUFofC1h
	ggbeIiWBk3WzyViPQhfQkoOh7/MIrpW26ISw9GYLLZGiHFYAmbrYH27H6gOj6E0XBJuql5
	EgV7+HEoGQOCh0LBIGEZyN38huOE6C0PMqC5LhYk82Sz+Il8AFlZF1frq0bEJS5SNK/teq
	4NroVxu2s/ixdVIpx3RoRLADUNBrZRs6dM4pCcdUIldHfSIuTfUnART0nLgUbg==
Date: Mon, 5 Feb 2024 16:17:43 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: <richard@nod.at>, <vigneshr@ti.com>, <vadym.kochan@plvision.eu>,
 <aviramd@marvell.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: rawnand: marvell: fix layouts
Message-ID: <20240205161743.6c13af7b@xps-13>
In-Reply-To: <20240205134435.2769452-1-enachman@marvell.com>
References: <20240205134435.2769452-1-enachman@marvell.com>
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

Hi Elad,

enachman@marvell.com wrote on Mon, 5 Feb 2024 15:44:35 +0200:

> From: Elad Nachman <enachman@marvell.com>
>=20
> The check in nand_base.c, nand_scan_tail() : has the following code:
> (ecc->steps * ecc->size !=3D mtd->writesize) which fails for some NAND ch=
ips.
> Remove ECC entries in this driver which are not integral multiplications,
> and adjust the number of chunks for entries which fails the above
> calculation so it will calculate correctly (this was previously done
> automatically before the check and was removed in a later commit).

I don't know why linux-mtd does not collect your patches, for this time
I applied it manually to mtd/fixes.

See, linux-mtd lore link is broken, but linux-stable collected
correctly:
https://lore.kernel.org/linux-mtd/20240205134435.2769452-1-enachman@marvell=
com/

Thanks,
Miqu=C3=A8l

