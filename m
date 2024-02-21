Return-Path: <linux-kernel+bounces-74672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C585D788
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15401C214A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B74D13B;
	Wed, 21 Feb 2024 12:00:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8E4CB28
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516845; cv=none; b=Y+iYHprwQilHwrzGNJe/qkAAU70UrNASIcZJ+UYEGCrvy4xlVJ/z0ReosRvlk1BYWoE35iqEWKXIzbxu3Ngz6M8yl69VLtX9M/Edo5EzCuxGxfbBT8nx18F7UBva7q6q2novToYB44s3hMsBGQJGg4xmehxVlF1WlYbe+3wtJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516845; c=relaxed/simple;
	bh=2+UX+kaYx6D1K2QYMIDl553xTn5OQ0uFsYztVdwDLLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJz0DzoSeDTt40332Dn1/HsphqjYGaCVLODG5upy8mI4quNWfrJfppUpgynVt6e3kDIrTLloZQRIv27uEhXbHjuK2QjT+Tm39itxQcJxaDg65Z5PvJmCEFfyzF2e5f29zKjbaF98aZ7Ki/kDYoddbxsvgN8OGPScaR8zovUOmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rclHD-0005u4-DT; Wed, 21 Feb 2024 13:00:39 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rclHC-0021xW-JH; Wed, 21 Feb 2024 13:00:38 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rclHC-0006a8-1i;
	Wed, 21 Feb 2024 13:00:38 +0100
Message-ID: <ddecea158d5ea0cd2d682f8f9577ee0c78a755d9.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] watchdog: sp805_wdt: deassert the reset if
 available
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yang Xiwen <forbidden405@outlook.com>, Christophe JAILLET
	 <christophe.jaillet@wanadoo.fr>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux@roeck-us.net, robh+dt@kernel.org, 
	vireshk@kernel.org, wim@linux-watchdog.org
Date: Wed, 21 Feb 2024 13:00:38 +0100
In-Reply-To: <SEZPR06MB6959D4BEC90745D94BF02BF596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
References: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
	 <20240220-hisi-wdt-v2-1-63edc4965b4c@outlook.com>
	 <534b62dc-3874-407f-a5c9-f67d366107dc@wanadoo.fr>
	 <SEZPR06MB6959D4BEC90745D94BF02BF596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-02-20 at 03:00 +0800, Yang Xiwen wrote:
> On 2/20/2024 2:22 AM, Christophe JAILLET wrote:
> > Le 19/02/2024 =C3=A0 19:14, Yang Xiwen via B4 Relay a =C3=A9crit=C2=A0:
> > > From: Yang Xiwen <forbidden405-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.or=
g>
> > >=20
> > > According to the datasheet, the core has an WDOGRESn input signal tha=
t
> > > needs to be deasserted before being operational. Implement it in the
> > > driver.
> > >=20
> > > Signed-off-by: Yang Xiwen=20
> > > <forbidden405-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > > =C2=A0 drivers/watchdog/sp805_wdt.c | 9 +++++++++
> > > =C2=A0 1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wd=
t.c
> > > index 2756ed54ca3d..b4bcfdeb39e6 100644
> > > --- a/drivers/watchdog/sp805_wdt.c
> > > +++ b/drivers/watchdog/sp805_wdt.c
> > > @@ -25,6 +25,7 @@
> > > =C2=A0 #include <linux/moduleparam.h>
> > > =C2=A0 #include <linux/pm.h>
> > > =C2=A0 #include <linux/property.h>
> > > +#include <linux/reset.h>
> > > =C2=A0 #include <linux/slab.h>
> > > =C2=A0 #include <linux/spinlock.h>
> > > =C2=A0 #include <linux/types.h>
> > > @@ -59,6 +60,7 @@
> > > =C2=A0=C2=A0 * @lock: spin lock protecting dev structure and io acces=
s
> > > =C2=A0=C2=A0 * @base: base address of wdt
> > > =C2=A0=C2=A0 * @clk: (optional) clock structure of wdt
> > > + * @rst: (optional) reset control signal of wdt
> > > =C2=A0=C2=A0 * @rate: (optional) clock rate when provided via propert=
ies
> > > =C2=A0=C2=A0 * @adev: amba device structure of wdt
> > > =C2=A0=C2=A0 * @status: current status of wdt
> > > @@ -69,6 +71,7 @@ struct sp805_wdt {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *base;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *clk;
> > > +=C2=A0=C2=A0=C2=A0 struct reset_control=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *rst;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rate;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amba_device=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *adev;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_val;
> > > @@ -264,6 +267,12 @@ sp805_wdt_probe(struct amba_device *adev, const=
=20
> > > struct amba_id *id)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV=
;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0 +=C2=A0=C2=A0=C2=A0 wdt->rst =3D devm_reset_control_get_option=
al(&adev->dev, NULL);
> > > +=C2=A0=C2=A0=C2=A0 if (IS_ERR(wdt->rst))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(&ade=
v->dev, PTR_ERR(wdt->rst), "Can not=20
> > > get reset\n");
> > > +
> > > +=C2=A0=C2=A0=C2=A0 reset_control_deassert(wdt->rst);
> > > +
> >=20
> > Hi,
> >=20
> > Is a corresponding reset_control_assert() needed in the remove function=
?
>=20
> I don't think it makes much sense. Many drivers in kernel does not=20
> reassert the resets in their driver's remove callback too.

In general, balancing deassert/assert is only required for shared reset
controls.

For exclusive reset controls, it depends on whether the driver has any
expectations that the reset was asserted at some point before deassert
is called, possibly to reset registers or some internal state.
E.g., if this driver is unbound and then bound again, the deassert
during second probe is a no-op.

regards
Philipp

