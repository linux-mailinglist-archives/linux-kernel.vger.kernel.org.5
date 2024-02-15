Return-Path: <linux-kernel+bounces-66216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A5855898
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFB91F2A0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EDC1361;
	Thu, 15 Feb 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rsfNA2qy"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2AECF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959401; cv=none; b=ovaiKYezkq3sfxQ/xydn8VxfPiKYF/Rn8qQFbj8L7SMkvhq7GBgOsm1vq09cOdONDEPWGpH7CqybS2PFo71hSY4a3ywFqTGxp8WIzHNJSPHu7DE7MqqXO9IUEyJ2TTnCPYdLNs5mSnhepPee05LpQxFWmdumbw6unlTA2hxd67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959401; c=relaxed/simple;
	bh=2PVDH6jW0109s6p6kGyOYOQuv8W+sRln84nZu3PAMBo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=p9AqWI5RNitqbKeoFhjbWcpLP7i8/TGB8XJVGxLrBRvEZIYxW1ozjsEtLsEMmG+Ai3gq1SUstOYq7887CUIEXUapcJc3h9YNfD209NlNlZtzV5QNSsr+2CcopvvTCz8bPrcvIllaHQRu0psXTOmBtSY0l9pOkyxkz1qZHKPCtDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rsfNA2qy; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240215010347epoutp03d9fe892383f364d268b10afa31d352da~z46_a6ZIe2063720637epoutp034
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:03:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240215010347epoutp03d9fe892383f364d268b10afa31d352da~z46_a6ZIe2063720637epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707959027;
	bh=SEaTKZVMNZqX4WbPCSUwFOp2DSCqBOpjBL0zAanhWyc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rsfNA2qynn8zy7yk7YHdIS3bHkaAydzkTvXmCSj6RPqXyEbTeNGhDvenFEgo74A3i
	 df1iPvmn27hkHBFmrKAyP3wpwiJDyneVCvI9mThmCRkE8lVSJ9iDrLU7eORtkyw6on
	 EdgHtlW+mUEnWJBqRSjLvdimHgSJJrko4dn9uelo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240215010346epcas1p2d2d249043eff7da2ecdc06ef53b3f7bb~z4699Wg281073610736epcas1p2L;
	Thu, 15 Feb 2024 01:03:46 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.227]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TZxdt1KSnz4x9Pp; Thu, 15 Feb
	2024 01:03:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.F0.19104.2F26DC56; Thu, 15 Feb 2024 10:03:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240215010345epcas1p2948d76b10a1f990b50f14aed7a9322f0~z469Knguh1073610736epcas1p2H;
	Thu, 15 Feb 2024 01:03:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240215010345epsmtrp26032de40800c2a6180a3c7a8f1efdf9f~z469J0Kd-3119431194epsmtrp2z;
	Thu, 15 Feb 2024 01:03:45 +0000 (GMT)
X-AuditID: b6c32a4c-e146fa8000004aa0-2e-65cd62f28616
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.C7.07368.1F26DC56; Thu, 15 Feb 2024 10:03:45 +0900 (KST)
Received: from sh043lee04 (unknown [10.253.101.72]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240215010345epsmtip25e225f6a45a8c1ce77db93f481f97359~z4686cTEH2952629526epsmtip2k;
	Thu, 15 Feb 2024 01:03:45 +0000 (GMT)
From: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
To: "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <avri.altman@wdc.com>,
	<grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
	<jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>, <sh043.lee@samsung.com>
In-Reply-To: <CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
Date: Thu, 15 Feb 2024 10:03:45 +0900
Message-ID: <000001da5faa$d34e1600$79ea4200$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI2QrZr/hQwBfLmGOt++EZEApv72gJjevE2AeL7/EiwMJcOEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmge6npLOpBvd2sVu8/HmVzWLGqTZW
	i33XTrJb/Pq7nt2iefF6NouOrZOZLHY8P8NusetvM5PF5V1z2CyO/O9ntGj6s4/F4tqZE6wW
	x9eGW2y+9I3Fgc/jzrU9bB77565h9+jbsorR4/MmOY/2A91MAaxR2TYZqYkpqUUKqXnJ+SmZ
	eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
	S1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzTr5TKziqUfH67HaWBsYW
	+S5GTg4JAROJ9yeus3UxcnEICexhlJjx8SAzhPOJUaLj5jsmCOcbo8TCL4dYYVrmz58FldjL
	KLG8aT4LhPOCUeJYw2Wgfg4ONgEzied3gkAaRAR0JGa8aWYFqWEWeMkk8efDOxaQBKdAoMSb
	3weYQWxhAVeJ02fWg9ksAqoSF9Y8YgSxeQUsJfp729khbEGJkzOfgPUyC2hLLFv4mhniIgWJ
	n0+XsUIsc5LoebyZFaJGRGJ2ZxvYPxICJzgkDt46B9XgIrH/31UmCFtY4tXxLewQtpTE53d7
	2SAamhkl2hq+skA4ExglXix4BdVhL9Hc2swG8iazgKbE+l36ENv4JN597WEFCUsI8Ep0tAlB
	VCtLvHy0DKpTUmJJ+y2oGzwkLq/vZZvAqDgLyW+zkPw2C8kPsxCWLWBkWcUolVpQnJuemmxY
	YKibl1oOj/Lk/NxNjOCUrOWzg/H7+r96hxiZOBgPMUpwMCuJ8E7qPZMqxJuSWFmVWpQfX1Sa
	k1p8iNEUGOITmaVEk/OBWSGvJN7QxNLAxMzIxMLY0thMSZz3zJWyVCGB9MSS1OzU1ILUIpg+
	Jg5OqQamknOObkL1YYrHRea9Xu0pPzvP9Pcv6ySb5UsqWhM8A5aYn0iXEzu1UDX2ytu0z0e6
	VecnRTZXpc3trjj9+lwu2+VL2kU9LEYNzVcY3ij8q6nPap4Rel3Y03lh3DGbsOnNGWn2vVlR
	B6/a9a+68eBrMvcF0aanxfvF9VyZUh55zA67I5Tkll8/7S7Xno6Smfopxt5fxI/VXp/QFv3c
	u6hA4ueDT2oXlQ/uOqS/++V/24vfPu7fXXFkRbtWWODui69qS7mjq44ct/hx6PIy2ybxp2XP
	Fky8yM/hfzXq8cs+tcRTTe8WMKWv2fp9M1dQjd+zyb3lPVczEq2SCxX15jQ3SuUKzEz4Y70h
	au3hg4lKLMUZiYZazEXFiQDDMXrXUgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvO7HpLOpBp9mq1i8/HmVzWLGqTZW
	i33XTrJb/Pq7nt2iefF6NouOrZOZLHY8P8NusetvM5PF5V1z2CyO/O9ntGj6s4/F4tqZE6wW
	x9eGW2y+9I3Fgc/jzrU9bB77565h9+jbsorR4/MmOY/2A91MAaxRXDYpqTmZZalF+nYJXBl3
	/y5lLHikXrHlVjtLA+NsuS5GTg4JAROJ+fNnMXUxcnEICexmlLjZe5ARIiEpsfjRQ7YuRg4g
	W1ji8OFiiJpnjBLHZ01gBYmzCZhJPL8TBFIuIqAjMeNNMytIDbPAdyaJnhV3oIZeYJSYf+MK
	O0gVp0CgxJvfB5hBbGEBV4nTZ9aD2SwCqhIX1jwCW8wrYCnR39vODmELSpyc+YQFxGYW0JZ4
	evMpnL1s4WtmiEMVJH4+XcYKcYWTRM/jzawQNSISszvbmCcwCs9CMmoWklGzkIyahaRlASPL
	KkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4JjU0tjBeG/+P71DjEwcjIcYJTiYlUR4
	J/WeSRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qBaaXa
	Kq/vjVb+P86fyV3WnHhxXoxDxppJuXVVCxv/ViftWKph4pXFUDjDXCto5sbvm0wlPrK/P7dn
	R4y8B/8L7/Ld7icO3HE9muqVKCeeLtOulvfwwdadrDsWt5w6I99u56vKLX3hyvW/bcoGjh3S
	u55q9NZ3nwi6cfH4u4sCO4/On9Vf4/Ul7UEXw6k1S4+ntdt5qH7cyrPzru706i/aPb+nJv57
	fksrNuzUsZxU9kU3rm+KPdw7x3LhrK7ynNkTxPgybO+L+sduLQoz4LLa/VWDZ5fj4+1Mh+UT
	p5SonvU/fbUoY3G2jOSVFZ3MPsyibNPDwn9c3cGmXH9yjd5F4ZBD8StuqxZ0bOlz1/p1Uoml
	OCPRUIu5qDgRALv5SLY4AwAA
X-CMS-MailID: 20240215010345epcas1p2948d76b10a1f990b50f14aed7a9322f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
	<20240213051716.6596-1-sh043.lee@samsung.com>
	<CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>

> -----Original Message-----
> From: Ulf Hansson <ulf.hansson=40linaro.org>
> Sent: Wednesday, February 14, 2024 8:27 PM
> To: Seunghui Lee <sh043.lee=40samsung.com>
> Cc: linux-mmc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> gregkh=40linuxfoundation.org; avri.altman=40wdc.com; grant.jung=40samsung=
com;
> jt77.jang=40samsung.com; dh0421.hwang=40samsung.com; junwoo80.lee=40samsu=
ng.com;
> jangsub.yi=40samsung.com; cw9316.lee=40samsung.com; sh8267.baek=40samsung=
com;
> wkon.kim=40samsung.com
> Subject: Re: =5BPATCH=5D mmc: sd: Add a variable to check a faulty device
>=20
> On Tue, 13 Feb 2024 at 06:13, Seunghui Lee <sh043.lee=40samsung.com> wrot=
e:
> >
> > In mobile devices, suspend/resume situations are frequent.
> > In the case of a defective SD card in which initialization fails,
> > unnecessary initialization time is consumed for each resume.
> > A field is needed to check that SD card initialization has failed on
> > the host. It could be used to remove unnecessary initialization.
>=20
> It's not clear to me, under what circumstance you want to optimize for.
>=20
> Is the SD card ever getting properly initialized during boot?
>=20
> Kind regards
> Uffe
>=20
We receive a lot of reports about SD card issues in the market.
There was no problem with the first time at the time of use, and there are =
many cases where people recognize that it is not recognized later on. In mo=
st cases, this is a problem with the SD card itself.

SD card users cannot determine whether or not an SD card is a problem, so t=
hey should be guided in this regard.
It is necessary to distinguish whether the SD card is inserted but unrecogn=
ized or the SD card itself is not inserted, and if there is a field that ca=
n check for initialization failure, it will facilitate guidance, so we cons=
idered the patch.

The variable's usage is expected to be used through the sysfs node in the v=
endor module.
> >
> > Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
> > ---
> >  drivers/mmc/core/sd.c        =7C 12 +++++++++++-
> >  drivers/mmc/core/slot-gpio.c =7C  1 +
> >  include/linux/mmc/host.h     =7C  1 +
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> > c3e554344c99..f0eb3864dc24 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > =40=40 -1410,6 +1410,7 =40=40 static int mmc_sd_init_card(struct mmc_ho=
st *host,
> u32 ocr,
> >         bool v18_fixup_failed =3D false;
> >
> >         WARN_ON(=21host->claimed);
> > +       host->init_failed =3D false;
> >  retry:
> >         err =3D mmc_sd_get_cid(host, ocr, cid, &rocr);
> >         if (err)
> > =40=40 -1752,6 +1753,8 =40=40 static int _mmc_sd_resume(struct mmc_host=
 *host)
> >
> >         mmc_power_up(host, host->card->ocr);
> >         err =3D mmc_sd_init_card(host, host->card->ocr, host->card);
> > +       if (err)
> > +               host->init_failed =3D true;
> >         mmc_card_clr_suspended(host->card);
> >
> >  out:
> > =40=40 -1803,8 +1806,12 =40=40 static int mmc_sd_runtime_resume(struct
> > mmc_host *host)
> >
> >  static int mmc_sd_hw_reset(struct mmc_host *host)  =7B
> > +       int err;
> >         mmc_power_cycle(host, host->card->ocr);
> > -       return mmc_sd_init_card(host, host->card->ocr, host->card);
> > +       err =3D mmc_sd_init_card(host, host->card->ocr, host->card);
> > +       if (err)
> > +               host->init_failed =3D true;
> > +       return err;
> >  =7D
> >
> >  static const struct mmc_bus_ops mmc_sd_ops =3D =7B =40=40 -1891,5 +189=
8,8 =40=40
> > int mmc_attach_sd(struct mmc_host *host)
> >         pr_err(=22%s: error %d whilst initialising SD card=5Cn=22,
> >                 mmc_hostname(host), err);
> >
> > +       if (err)
> > +               host->init_failed =3D true;
> > +
> >         return err;
> >  =7D
> > diff --git a/drivers/mmc/core/slot-gpio.c
> > b/drivers/mmc/core/slot-gpio.c index 2a2d949a9344..93d081c7dd53 100644
> > --- a/drivers/mmc/core/slot-gpio.c
> > +++ b/drivers/mmc/core/slot-gpio.c
> > =40=40 -33,6 +33,7 =40=40 static irqreturn_t mmc_gpio_cd_irqt(int irq, =
void
> *dev_id)
> >         struct mmc_gpio *ctx =3D host->slot.handler_priv;
> >
> >         host->trigger_card_event =3D true;
> > +       host->init_failed =3D false;
> >         mmc_detect_change(host,
> > msecs_to_jiffies(ctx->cd_debounce_delay_ms));
> >
> >         return IRQ_HANDLED;
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> > 2f445c651742..1d75cfdbf981 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > =40=40 -467,6 +467,7 =40=40 struct mmc_host =7B
> >         struct timer_list       retune_timer;   /* for periodic re-tuni=
ng */
> >
> >         bool                    trigger_card_event; /* card_event neces=
sary */
> > +       bool                    init_failed;    /* check if failed to
> initialize */
> >
> >         struct mmc_card         *card;          /* device attached to t=
his host
> */
> >
> > --
> > 2.29.0
> >


