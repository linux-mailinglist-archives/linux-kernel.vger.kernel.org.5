Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75E7C842A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjJMLOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJMLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:14:01 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CDCBE;
        Fri, 13 Oct 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697195638; x=1728731638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=08noC20/kxWHv/qWQMeDlKc4iIh5pIHQn6/p+atWwZ8=;
  b=SCaS/jkoB6Cal7Go2uK+MKqa2s8A+ym0ZqmF77T9XPCGx781dYxeLIe/
   nCtm7SBgRTqA5sXHCgIxlgm+ceLqhu5tNS3NqYSpjh4yQx7jHHpwG5EoK
   GK28W8qpbwCHlg/LWBD8ixQwx2n3pVnr0/DHzPNO8ocPx838fwxB73cWT
   q2zNbbZbmYzsqDAEDandK20RNE2nJMe1rLEdEFjs4bV+tFVwabqomgmxd
   WkMMDnPcbKKVwEx7B9OPgqL46/hhZ1y0YsV2lUZFBa/6gYLZZUKpyxpY6
   Ghu1sF2QC4HxjMC/vemBWBDM2ybM0LG5vlRof+xkPeaX9fKQu1xEdGT8Q
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,222,1694728800"; 
   d="scan'208";a="33452337"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2023 13:13:55 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B1314280082;
        Fri, 13 Oct 2023 13:13:49 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>
Cc:     linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: bcm2835: allow pwm driver to be used in atomic context
Date:   Fri, 13 Oct 2023 13:13:50 +0200
Message-ID: <5203415.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <84429d39-aa54-462d-85cd-c5d06a614a0e@gmx.net>
References: <cover.1697193646.git.sean@mess.org> <6ce73b2688f059e7169935699044104cf37b2425.1697193646.git.sean@mess.org> <84429d39-aa54-462d-85cd-c5d06a614a0e@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 13. Oktober 2023, 13:04:48 CEST schrieb Stefan Wahren:
> Hi Sean,
>=20
> Am 13.10.23 um 12:46 schrieb Sean Young:
> > clk_get_rate() may do a mutex lock. Since the clock rate cannot change =
on
> > an rpi, simply fetch it once.
>=20
> does it mean you checked all possible SoCs (BCM2835, BCM2836, BCM2837,
> BCM2711, BCM2712) for this change?
>=20
> Is it impossible that the real clock can never be influenced by turbo
> mode like SPI?

Assuming the clock can change, which I would, then a clock notifier seems=20
appropriate. See [1] for an example.

Best regards,
Alexander

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
commit/?id=3D90ad2cbe88c22d0215225ab9594eeead0eb24fde

> Best regards
>=20
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >=20
> >   drivers/pwm/pwm-bcm2835.c | 21 ++++++++++++---------
> >   1 file changed, 12 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> > index bdfc2a5ec0d6..59ea154dd657 100644
> > --- a/drivers/pwm/pwm-bcm2835.c
> > +++ b/drivers/pwm/pwm-bcm2835.c
> > @@ -28,6 +28,7 @@ struct bcm2835_pwm {
> >=20
> >   	struct device *dev;
> >   	void __iomem *base;
> >   	struct clk *clk;
> >=20
> > +	unsigned long rate;
> >=20
> >   };
> >  =20
> >   static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chi=
p)
> >=20
> > @@ -63,17 +64,11 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,>=20
> >   {
> >  =20
> >   	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
> >=20
> > -	unsigned long rate =3D clk_get_rate(pc->clk);
> >=20
> >   	unsigned long long period_cycles;
> >   	u64 max_period;
> >   =09
> >   	u32 val;
> >=20
> > -	if (!rate) {
> > -		dev_err(pc->dev, "failed to get clock rate\n");
> > -		return -EINVAL;
> > -	}
> > -
> >=20
> >   	/*
> >   =09
> >   	 * period_cycles must be a 32 bit value, so period * rate /
> >   	 NSEC_PER_SEC
> >   	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
> >=20
> > @@ -88,13 +83,13 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,>=20
> >   	 * <=3D> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
> >   	 * <=3D> period <=3D ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) =
/=20
rate)
> >   	 - 1
> >   	 */
> >=20
> > -	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC +=20
NSEC_PER_SEC
> > / 2, rate) - 1; +	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX *
> > NSEC_PER_SEC + NSEC_PER_SEC / 2, pc->rate) - 1;>=20
> >   	if (state->period > max_period)
> >   =09
> >   		return -EINVAL;
> >   =09
> >   	/* set period */
> >=20
> > -	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * rate,
> > NSEC_PER_SEC); +	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period *
> > pc->rate, NSEC_PER_SEC);>=20
> >   	/* don't accept a period that is too small */
> >   	if (period_cycles < PERIOD_MIN)
> >=20
> > @@ -103,7 +98,7 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,>=20
> >   	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
> >   =09
> >   	/* set duty cycle */
> >=20
> > -	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC);
> > +	val =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pc->rate,=20
NSEC_PER_SEC);
> >=20
> >   	writel(val, pc->base + DUTY(pwm->hwpwm));
> >   =09
> >   	/* set polarity */
> >=20
> > @@ -129,6 +124,7 @@ static const struct pwm_ops bcm2835_pwm_ops =3D {
> >=20
> >   	.request =3D bcm2835_pwm_request,
> >   	.free =3D bcm2835_pwm_free,
> >   	.apply =3D bcm2835_pwm_apply,
> >=20
> > +	.atomic =3D true,
> >=20
> >   	.owner =3D THIS_MODULE,
> >  =20
> >   };
> >=20
> > @@ -156,6 +152,13 @@ static int bcm2835_pwm_probe(struct platform_device
> > *pdev)>=20
> >   	if (ret)
> >   =09
> >   		return ret;
> >=20
> > +	pc->rate =3D clk_get_rate(pc->clk);
> > +	if (!pc->rate) {
> > +		dev_err(pc->dev, "failed to get clock rate\n");
> > +		ret =3D -EINVAL;
> > +		goto add_fail;
> > +	}
> > +
> >=20
> >   	pc->chip.dev =3D &pdev->dev;
> >   	pc->chip.ops =3D &bcm2835_pwm_ops;
> >   	pc->chip.npwm =3D 2;


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


