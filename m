Return-Path: <linux-kernel+bounces-80976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5DB866E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA0D28392A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2934062813;
	Mon, 26 Feb 2024 08:51:50 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771962807
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937509; cv=none; b=M1ssYt1Ac7YZBYJ0lvEvnTaV72JoRL877m2v1uUuq8cKPKSQA/Wze9IdGwvBeQlG+qCw+5Zm/ne1MBb4gb8JVFsvE7fhAhG07xuCzZGEzeNkyJY7pv6FLNI55AaM5UJATgYj/pFS3n3+5Hy1tOfFDKL/DEsHgl9PhSOzCfJTYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937509; c=relaxed/simple;
	bh=qvkyMyPAHlamB48t1aY7pfFxnpypRPDLStJrvNeBPZs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=b0WA5Z4WQ3cKuZBAmiIHzubKghRe0u/Ll/FvOcy1h/JoVYFlaEHdrw4NG3TsU1UxCcuDraqOwu0l5/T7G4O39V0sq0umks3H2hZm9zFV2Foytt2iHW1wJRP+dR0VbvYk8FFjeWaCDciZ8PDtEr5NCmLjSDeyC1EUSt4JDeVFyDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 7A1DBA59;
	Mon, 26 Feb 2024 09:51:39 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 09:51:39 +0100
Message-Id: <CZEVS9033HET.1NPH0K6PQLR87@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Christian Marangi" <ansuelsmth@gmail.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for BoHong bh25q128as
Cc: "Pratyush Yadav" <pratyush@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, "David Bauer" <mail@david-bauer.net>
X-Mailer: aerc 0.16.0
References: <20240220200325.19089-1-ansuelsmth@gmail.com>
 <f7c45e7b-993c-444b-8710-042da7512bbf@linaro.org>
 <65d9d08f.df0a0220.988bb.3177@mx.google.com>
In-Reply-To: <65d9d08f.df0a0220.988bb.3177@mx.google.com>

Hi,

On Sat Feb 24, 2024 at 12:18 PM CET, Christian Marangi wrote:
> The user just tested this and It seems there is a problem in JEDEC id?
>
> [    0.726451] spi spi0.0: setup: ignoring unsupported mode bits a00

What SPI controller is used in this case?

> [    0.732850] spi-nor spi0.0: unrecognized JEDEC id bytes: 68 40 18 68 4=
0 18
> [    0.739725] spi-nor: probe of spi0.0 failed with error -2

And what kernel version is this? This should only happen if the SFDP
header is wrong, but according to your dump, it is correct.

-michael

