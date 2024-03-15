Return-Path: <linux-kernel+bounces-104384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372CD87CD15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F86DB2284B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5BE1C28B;
	Fri, 15 Mar 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QEcHXLpj"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F21BF3C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504862; cv=none; b=c3v7sKcVn+eYSw1v2zLdSHqmu69QWUJLnq3HacMfJifzX4DEnFtP4CdHURaMECdoEVvYtab0uBS9cTCddr5wy2CKh0hna3Jl809Z1ns/Rc3GyndDF3I8gNHNsc/6izQ/Vz9ba0n9KB4cJwZiVQh6WFFW09C0/tkz/OKmDaYl1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504862; c=relaxed/simple;
	bh=Dqc2eeavMmTzOc0YPipc0us70b4n2nkR8oz6yKvom0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTjLP5ANpjLxWDfqBpvOBKKwEnBv73ZLoTBnKIqd532Neg4dT3fqbCoRqxVDQm+/rD3WBnIdQg0qBsnLCt67NSEJOP+Q2mMdXIRT3LHWWz5j20uwLShPYUgL2G/M0igohFaMcsOL8oEwwq/J6qTPa29b0TQEfGhg5uXy42s01+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QEcHXLpj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A999FE000A;
	Fri, 15 Mar 2024 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710504853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ys6zmTNnRRaNwkqda5/UM+chtWuSEH0RXOVuVZYrg58=;
	b=QEcHXLpj7xesh3WJZz+kKm0Su5uv/szxg1thn5Thka2YeoIfbkGozq3Ro+EW+61Yo4wmCz
	tNTlZDDHZgHN8WE/eKGD/cV9ebjBn/YWIULQbbjluIi3ceM5kv/YZTt6bPN8r1BaArydy0
	8kwsT5wZHxj+fyLnd8N1L3q9p01AqD8O/+WIgJSMaaw+x2QETDaFg85LYvz86BgK0iY6Oq
	Otq9YscJTeC+QfWDdaGvMMDCTmPOU4w3xbKto01Q4FPF8gr6DI2fq+QictEQIoOmNThUW+
	HT155BeK2V/mFdVRrMlQxQW3psqHYKestGmMWZTkyDTaW/oVGrj4aWJrQUlZ/A==
Date: Fri, 15 Mar 2024 13:14:12 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Hector Palacios
 <hector.palacios@digi.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mtd: rawnand: hynix: fixed typo
Message-ID: <20240315131412.488167c1@xps-13>
In-Reply-To: <529774b9-20be-485d-b218-2452ce536770@gmail.com>
References: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
	<20240315122314.10c88c2e@xps-13>
	<529774b9-20be-485d-b218-2452ce536770@gmail.com>
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

Hi Maxim,

korotkov.maxim.s@gmail.com wrote on Fri, 15 Mar 2024 14:45:47 +0300:

> Hi,
>=20
> On 15.03.2024 14:23, Miquel Raynal wrote:
> > Isn't it done like that on purpose? Read-retry is not a mandatory
> > feature. =20
>=20
> Works it as designed? I'm not sure about it.
> I wouldn't rule it out, but it's a little weird that the hynix_nand_rr_in=
it() function
> is used as if it can return an error but never returns.
>=20
> Probably  checking  of value returned from hynix_nand_rr_init()
> should be removed in hynix_nand_init()

It is indeed confusing. I'll take it.

Thanks,
Miqu=C3=A8l

