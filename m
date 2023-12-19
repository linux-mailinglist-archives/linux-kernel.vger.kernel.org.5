Return-Path: <linux-kernel+bounces-5217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F4F818815
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C5E1C24057
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B26A18C10;
	Tue, 19 Dec 2023 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QKCcZVXa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792918B04
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D9CA1C000E;
	Tue, 19 Dec 2023 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702990557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZ4FFwu75FPNZaoEBUmiGs2Cfmi6sxpqh1/xjHDIrSs=;
	b=QKCcZVXaHhki+uoPYuWE2TI2e3//UYWwasRttEklWVrTsJsfjzy/T/V7J5Hhh7iFJXzbQk
	G+9HgVNzCTtJzyfAQLYukrL4XalJ+Q8j94CAuzKCzonv6Ow0Kh5pXRktmO4npeLAdExtLr
	Cg2URAKPN/eu5hsEOwnsORRLt1NsKnpYJyhCszHbFlC99WSKerbssnzird70zwhJ6E1HOp
	byzJgUnEI+PtE+kSAYH+zeUJccQZksPbJF+tYPgYP6vhQpBtAccGaj/U1aAYk7kM6WtjQ1
	MTXbmAD29boQ34Sd0gOcpT1xfqu2wTIspoGTCXRrA41B+peaEkAfO4ZYily3Qg==
Date: Tue, 19 Dec 2023 13:55:53 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
Subject: Re: [PATCH v6.8 1/2] nvmem: layouts: refactor .add_cells() callback
 arguments
Message-ID: <20231219135553.4e1b74f4@xps-13>
In-Reply-To: <20231219120104.3422-1-zajec5@gmail.com>
References: <20231219120104.3422-1-zajec5@gmail.com>
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

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Tue, 19 Dec 2023 13:01:03 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Simply pass whole "struct nvmem_layout" instead of single variables.
> There is nothing in "struct nvmem_layout" that we have to hide from
> layout drivers. They also access it during .probe() and .remove().
>=20
> Thanks to this change:
>=20
> 1. API gets more consistent
>    All layouts drivers callbacks get the same argument
>=20
> 2. Layouts get correct device
>    Before this change NVMEM core code was passing NVMEM device instead
>    of layout device. That resulted in:
>    * Confusing prints
>    * Calling devm_*() helpers on wrong device
>    * Helpers like of_device_get_match_data() dereferencing NULLs
>=20
> 3. It gets possible to get match data
>    First of all nvmem_layout_get_match_data() requires passing "struct
>    nvmem_layout" which .add_cells() callback didn't have before this. It
>    doesn't matter much as it's rather useless now anyway (and will be
>    dropped).
>    What's more important however is that of_device_get_match_data() can
>    be used now thanks to owning a proper device pointer.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

