Return-Path: <linux-kernel+bounces-15279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7848F822990
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731B41C23087
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F1182B6;
	Wed,  3 Jan 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nvgg47S+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF131182AA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id BB6F8C0D08
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:40:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5E1520008;
	Wed,  3 Jan 2024 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704271215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lyUsZ8m/m/XU7LloNWRnBK4bo48BWenHAUyrZ2CkB8=;
	b=nvgg47S+KHKs2CvfP/OlPxSyGngZQQAfT28UO6/YfYvX8rWmk7Z7Ky5jQcw6Kc/XaLR/87
	hMOAs+Y0lsvgiW3Qvayq8CO03c0gzGqbXpeKWJfDkTF4BUB/GVAGnLrR0dBXObvprv9mCL
	jALthvIiZieUdf9RfB8s+ot5JCT6ADJd4cMRTDvVSP+31sLrKS05hYCsqmAXc6x2orQRR4
	zhUxg3wS0pxso5QFy91c8k0aMx1T5S8WiicbXSr+r6XL+K7qn5/0+tY5o3iVO3dOH0gzVa
	thsoHilpUuNfeyI3KuHxkI1nEUXN5oO/fDwJxyK0rhJZg5wJbcHhu4FW8HV7fg==
Date: Wed, 3 Jan 2024 09:40:13 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "michael@walle.cc" <michael@walle.cc>, "rafal@milecki.pl"
 <rafal@milecki.pl>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] nvmem: fix issue within nvmem_register with
 fixed-layout.
Message-ID: <20240103094013.2672cb7d@xps-13>
In-Reply-To: <20231205100502.623863ff@xps-13>
References: <20231130162922.2989774-1-catalin.popescu@leica-geosystems.com>
	<16c4c272-1a19-4fb8-8a2d-b2cf61ba37f2@leica-geosystems.com>
	<20231205100502.623863ff@xps-13>
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

Hi Catalin,

miquel.raynal@bootlin.com wrote on Tue, 5 Dec 2023 10:05:02 +0100:

> Hi Catalin,
>=20
> + GKH
> + Luca (who initially reported this issue)
>=20
> catalin.popescu@leica-geosystems.com wrote on Tue, 5 Dec 2023 08:48:27
> +0000:
>=20
> > Adding more people.
> >=20
> > On 30.11.23 17:29, Catalin Popescu wrote:
> > > fixed-layout is natively supported by NVMEM framework.
> > > Yet, it's not been declared as a supported layout. As a
> > > result, nvmem_register always returns -EPROBE_DEFER if
> > > configuration has no layout and the NVMEM provider DT
> > > uses a fixed layout.
> > >
> > > As a fix, declare fixed-layout as a supported layout
> > > and use add_cells callback to parse the cells. This adds
> > > consistency over layouts parsing as fixed-layout parsing
> > > is handled in the same way than others nvmem layouts.
>=20
> I believe this patch (not taken yet) should fix your issue and should be
> queued to fixes.
>=20
> Link: https://lore.kernel.org/lkml/20231124193814.360552-1-miquel.raynal@=
bootlin.com/
>=20
> However I like your approach which should probably be taken into
> consideration for the next cycle, as I think it fits Rafal's
> original idea pretty well.

Do you plan on updating this patch at -rc1? I think it would be
interesting to follow your idea.

Thanks,
Miqu=C3=A8l

