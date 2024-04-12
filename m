Return-Path: <linux-kernel+bounces-142788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33D8A3019
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8C1F22D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247185948;
	Fri, 12 Apr 2024 14:01:55 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8F8594A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930514; cv=none; b=dHqSz9rT9w3WT+qmOwX7R7VwMLhfW9T6IFUW2bn8oR0Go3QwHuJEjWu+OiXpNG5qQAhV0t1Izaz5YBMTVvgj8hB4qUjROKCWUf0gLmxgm6/qr/RjiJCkec/vxEw1w15lnAJlZkVoOLLfBBuyABXTKJmIJ3pKcZfpqSqEQ1qzMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930514; c=relaxed/simple;
	bh=VopjSTdEORUJEpTy123tr1f7hCSDlpM+rNaONcUqCc8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=sE0kmMvD+areiG7nRgE3K5ritvVj8JnZjyBQablrKayPIqiVjdF0Hq1PLYJAd2zl4speyEnLINTokKTXEc8xksBMfyzFBEP4M1+lcuMlSr1ar5Tny34XvzDx1mD/Yoa3cZnIsJhsSR6VR00dcnl/2sHHHOUd/GGQTDinRX77OvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 5E5505D4;
	Fri, 12 Apr 2024 16:01:43 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 16:01:43 +0200
Message-Id: <D0I76PPKBWF9.X2XFZAO5OE7S@kernel.org>
Subject: Re: [PATCH v1 1/6] mtd: spi-nor: Remove support for Xilinx S3AN
 flashes
Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-2-mwalle@kernel.org>
 <7b2fc5cb-d1ab-4e9d-b955-b88698322057@linaro.org>
In-Reply-To: <7b2fc5cb-d1ab-4e9d-b955-b88698322057@linaro.org>

On Fri Apr 12, 2024 at 3:53 PM CEST, Tudor Ambarus wrote:
>
>
> On 4/12/24 14:44, Michael Walle wrote:
> > These flashes are kind of an oddball for the very old Xilinx Spartan 3
> > FPGAs to store their bitstream. More importantly, they reuse the Atmel
> > JEDEC manufacturer ID and in fact the at45db081d already blocks the use
> > of the 3S700AN flash chip. It's time to sunset support for these
> > flashes.
> >=20
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> Good, I'll let Pratyush review the details:
>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>
> Please resend once you get enough feedback and include in To: all the
> contributors to this driver.


For my future reference: This seem so be the only interesting
commit:

commit e99ca98f1d7190c16601b00d0c96212d7c00577d
Author: Ricardo Ribalda <ribalda@kernel.org>
Date:   Fri Dec 2 12:31:44 2016 +0100

    mtd: spi-nor: Add support for S3AN spi-nor devices

-michael

