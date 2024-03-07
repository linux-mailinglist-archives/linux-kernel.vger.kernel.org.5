Return-Path: <linux-kernel+bounces-96160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF88757EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F5BB24C28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C913848C;
	Thu,  7 Mar 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLKfRRvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72A1369B9;
	Thu,  7 Mar 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841950; cv=none; b=L4sDlatTZUSPuB78uKD8O5kET++yD5AKVlXvX70MRLFr+05kUmCEigt4RXuQ3l607Wsf7jt9yb7WVdZIQ1blmqhp0tqek7jR+Z3FJxldyCDiiauIajpzLKMbgXGv0+jQjfih5bsB0dZxkFHioxxMoJ/F3aw1z2vtx23r1TdV8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841950; c=relaxed/simple;
	bh=78Rsj3O/7ufaekATx69zosteYwT6oeClJL8QONwmeTE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Or+yr7mN76eyfvpDRZJtd2vuTfwWlA9UVezZEQ9dGnfG+yE/EDZpzdvIYWyjLRkktK1gMzdZkug6sU7eGy28SDSdBxzPCPE7MiM4XE3oGl4IxEvaMkWyPgXJvRLxXZfzR5HF8Jy5+LQqQdGq+r1nuCwxCfhZFFKEQrnEZMQYRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLKfRRvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F44C433C7;
	Thu,  7 Mar 2024 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841950;
	bh=78Rsj3O/7ufaekATx69zosteYwT6oeClJL8QONwmeTE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FLKfRRvo1oaqVmm36Ci4l/y+mhDJg2A7ME0Dvc2Lr4Vzr5i1i/EtQhRsHG+18jAIj
	 rvG97J3ZSzhlgBLxNPyqlmEoLSRAtgyOAsoyBBX593XX3XsMnfKMc/A4iJmaXdAiCd
	 AhaqCOHmB0WfvTwNXEMCiwEHw2laOSaY5mduW5GGDuR+6XOG/CvXhHSNoy99snTzSR
	 uAC0xy9XWijo6rbgHMyhoK6YQYokkscw96oG/We7m2+kNq9a3nRCWcptWmyYYndU3B
	 wx+hGU92xPgcifhXHZNnvUvlpS6127tTgb5tpb9vlfheiDq2RgYjztgLKYBV33ILKD
	 0OjpLYYxwyOiw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 22:05:46 +0200
Message-Id: <CZNSDUEJ4P9S.235D7ZCOV738N@kernel.org>
Cc: <peterhuewe@gmx.de>, <LinoSanfilippo@gmx.de>,
 <p.rosenberger@kunbus.com>, <lukas@wunner.de>, <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>
X-Mailer: aerc 0.17.0
References: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
 <84dd5c01-906c-4e13-9d8c-e5350f718d56@molgen.mpg.de>
In-Reply-To: <84dd5c01-906c-4e13-9d8c-e5350f718d56@molgen.mpg.de>

On Tue Mar 5, 2024 at 5:43 PM EET, Paul Menzel wrote:
> Dear Lino,
>
>
> Thank you for the patch.
>
> Am 01.02.24 um 12:36 schrieb Lino Sanfilippo:
> > If interrupts are not activated the work struct 'free_irq_work' is not
> > initialized. This results in a warning splat at module shutdown.
> >=20
> > Fix this by always initializing the work regardless of whether interrup=
ts
> > are activated or not.
> >=20
> > cc: stable@vger.kernel.org
> > Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhand=
led IRQs")
> > Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Closes: https://lore.kernel.org/all/CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.o=
rg/
> > Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > ---
> >   drivers/char/tpm/tpm_tis_core.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
> > index 1b350412d8a6..64c875657687 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -919,8 +919,6 @@ static int tpm_tis_probe_irq_single(struct tpm_chip=
 *chip, u32 intmask,
> >   	int rc;
> >   	u32 int_status;
> >  =20
> > -	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> > -
> >   	rc =3D devm_request_threaded_irq(chip->dev.parent, irq, NULL,
> >   				       tis_int_handler, IRQF_ONESHOT | flags,
> >   				       dev_name(&chip->dev), chip);
> > @@ -1132,6 +1130,7 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
> >   	priv->phy_ops =3D phy_ops;
> >   	priv->locality_count =3D 0;
> >   	mutex_init(&priv->locality_count_mutex);
> > +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> >  =20
> >   	dev_set_drvdata(&chip->dev, priv);
>
> This is commit d6fb14208e22 in jarkko/next.
>
> I tested this patch on top of Linux 6.8-rc7 on a Dell OptiPlex 5055 [1]=
=20
> and it fixes the issue there too.

Thanks!

If you don't mind I'll add your tested-by to the commit before I send
my next pull request to Linus?

BR, Jarkko

