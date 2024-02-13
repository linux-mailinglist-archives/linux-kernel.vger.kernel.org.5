Return-Path: <linux-kernel+bounces-63266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965C852D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177531F28DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A719376F7;
	Tue, 13 Feb 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="axQdv8k0"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DE374E6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817792; cv=none; b=BlON8VdDM8H1AnByhgLwu3ivRnoes/qlNbUfxITNiyl+1ElseQ/Bo4FSwl09Wmh0J5Qv7TrOqsf0mzLBrQAtbLqjk4ADQmBeObXXrshldKIef27pc8ChvCRROEhXZANsIpZL26+Sdon/uT+iIHJCzMqFr6zFzqDYhMwwqba8kB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817792; c=relaxed/simple;
	bh=vVzCg7yDfIi8wcAXt14nS/HA69puPDLBcZUsahXOlFY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=RcmLnBr7v/vt5fOxRVYOaEZRl4ydwjDe6TlvZIEZb1gNVGzIjUhdXc0sAxrjqTDFnmIn6QlgHmI4RIT++/ClxnTAP/jjgvzLlNuLA/2G4pG5lfxYMvb+EYwXd37/w4p8YfARju7gX6RL3K1WwmEoG1ebUoUFkWEj/85OUwVjj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=axQdv8k0; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240213094947epoutp047420960bc36567fdb3850f61a845aae3~zYzqwvnkW1544215442epoutp04z
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:49:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240213094947epoutp047420960bc36567fdb3850f61a845aae3~zYzqwvnkW1544215442epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707817787;
	bh=LEEJ0dxpj8RLn45vEczYsQL1qTFbolTHn3Lb05kfUsE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=axQdv8k0fbl1TlFEL9IMkzDZTBAI6g5wiM964T9nIdq3D2hsuF4ixj+5sVz+z/giO
	 ZpjYQg4s/E/nc5BWjv2phakPXK9pd8xU8ZCzn8Y9W4rms4bo4z2d0p0xpLdyTXZwod
	 FOc/roK+uRY8r3+JsM0YgN2qS10IRh6Bm580/T6Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240213094946epcas1p25db2c25d24c33900aa809306a9843c87~zYzpy-Dcr1915219152epcas1p2M;
	Tue, 13 Feb 2024 09:49:46 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.250]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TYxPk01xSz4x9Q1; Tue, 13 Feb
	2024 09:49:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.7C.19104.93B3BC56; Tue, 13 Feb 2024 18:49:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240213094945epcas1p1f1368fba9dc127af1f18efab15d270d0~zYzo4bMT01901119011epcas1p13;
	Tue, 13 Feb 2024 09:49:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240213094945epsmtrp1c7b97bb1bf646345cede497f1b2a0103~zYzo2712t2506325063epsmtrp1g;
	Tue, 13 Feb 2024 09:49:45 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-52-65cb3b391d16
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CD.2F.07368.93B3BC56; Tue, 13 Feb 2024 18:49:45 +0900 (KST)
Received: from sh043lee04 (unknown [10.253.101.72]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240213094945epsmtip2f6cd9af44a699b1c9684862f977c2523~zYzolmoEd2205822058epsmtip2P;
	Tue, 13 Feb 2024 09:49:45 +0000 (GMT)
From: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
To: "'Avri Altman'" <Avri.Altman@wdc.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
	<gregkh@linuxfoundation.org>
Cc: <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
	<jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <BL0PR04MB65642D0389544F022A1D2222FC4F2@BL0PR04MB6564.namprd04.prod.outlook.com>
Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
Date: Tue, 13 Feb 2024 18:49:45 +0900
Message-ID: <000101da5e61$f97e8cf0$ec7ba6d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI2QrZr/hQwBfLmGOt++EZEApv72gJjevE2AlTbwFmwKnu8oA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmrq6l9elUg58TzC1e/rzKZjHjVBur
	xb5rJ9ktfv1dz27RvHg9m0XH1slMFjuen2G32PW3mcni8q45bBZH/vczWlw7c4LV4vjacIvN
	l76xOPB63Lm2h81j/9w17B59W1YxenzeJOfRfqCbKYA1KtsmIzUxJbVIITUvOT8lMy/dVsk7
	ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hGJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+
	cYmtUmpBSk6BWYFecWJucWleul5eaomVoYGBkSlQYUJ2xt7V19kL/qhVPNy8mLWB8YFsFyMH
	h4SAicTn6bFdjFwcQgJ7GCVWTL3ADOF8YpR4PusIC4TzjVHi8rsu9i5GTrCOyTt7GUFsIYG9
	jBIX/ipBFL1glFhy5TE7yFg2ATOJ53eCQOIiAosYJSaencAK4jAL3GKU2NR+D2wSp0CsRMeM
	rcwgtrCAq8TpM+vBbBYBVYkLje/AangFLCXa959ghLAFJU7OfMICYjMLaEssW/iaGeIiBYmf
	T5exgtgiAk4SfTPWMkPUiEjM7mwD+0dC4AiHxKxv25ggGlwk7q6cDNUsLPHq+Bao16QkXva3
	sUM0NDNKtDV8ZYFwJjBKvFjwCqrbXqK5tZkN5E9mAU2J9bv0IbbxSbz72sMKCVVeiY42IYhq
	ZYmXj5ZBdUpKLGm/BbXXQ+Ly+l62CYyKs5D8NgvJb7OQ/DALYdkCRpZVjFKpBcW56anJhgWG
	unmp5fAoT87P3cQITsRaPjsYv6//q3eIkYmD8RCjBAezkgjvpRknUoV4UxIrq1KL8uOLSnNS
	iw8xmgJDfCKzlGhyPjAX5JXEG5pYGpiYGZlYGFsamymJ8565UpYqJJCeWJKanZpakFoE08fE
	wSnVwJS164Xv1nB5s5blfMLb86eHxP+cPmf2hpjF657MLNXhsohlkPxTdM+2aKmGYfpfnX9P
	He3i/p84eKr642aTGdpc+xqf+74S91PPv1V5t2LarJP35j3smJVXy7fOYOmuwo3+b76tdFoX
	oPCHt3LSiz41y/fZNUsv63Ide8XOVpfrpXzIp2rrP0mNAMFAt5eObYqt113+i+Zb1L950p3h
	a/htQuLTSbxlW98v4D6vm2pQ3HF80d598UrbmqqmHL12Xcxx780sb5FJVfMfvJjI3zgx4djE
	jQvftj/7vGtXlVq67+dVe861q991qROImLgyfPuie9OufT08y727rue/48ZI08Uc91dIr3ga
	qPIgdeMaJZbijERDLeai4kQA+dNsXU0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvK6l9elUgwe7+Cxe/rzKZjHjVBur
	xb5rJ9ktfv1dz27RvHg9m0XH1slMFjuen2G32PW3mcni8q45bBZH/vczWlw7c4LV4vjacIvN
	l76xOPB63Lm2h81j/9w17B59W1YxenzeJOfRfqCbKYA1issmJTUnsyy1SN8ugSvj7YfvzAV/
	VCuar89na2B8INPFyMkhIWAiMXlnL2MXIxeHkMBuRolj/y+xQiQkJRY/esjWxcgBZAtLHD5c
	DFHzjFHiw6EGVpA4m4CZxPM7QSBxEYFljBLn7h9gAnGYBR4xSvxeNIMFouMOo0RL11ZmkKmc
	ArESHTMgbGEBV4nTZ9aD2SwCqhIXGt+xg9i8ApYS7ftPMELYghInZz5hAbGZBbQlnt58Cmcv
	W/iaGeJSBYmfT5eBXS0i4CTRN2MtM0SNiMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1
	oDg3PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4FrU0djDem/9P7xAjEwfjIUYJDmYlEd5LM06k
	CvGmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbLxMEp1cBUwppdd0Uu
	+GGD70aW2pX9wjs0WG0U5915OsdF77XK7s0Jh6M1V/wTtPxyw8PF7EngfTnXuNke6vuOhm3n
	jFSc824G04zYTfGiBj0/PKZu7g+bPuV5RFLUj5b65juev1q59+jOkVI43dy3ZyuzsZTrzjRm
	168Wd+5Ezb3K6PjcelWOvcHfG0eCjznUvF6z6PYjt3N/Fm96+2GrzIy/rG+ELWat5jzXd/2s
	923ZWmMGv8eMlzeV54ZOP84Xqn3ke8L6hPVN75fEpLrPNZt5+93/K+ZGvG6saspspeo8e6oc
	xE9er3/lI/7mWOfRJdd5AmZXlJY/XSzw5l5jQkv6j6/p/sanF9Z96G1/ffn4728WSizFGYmG
	WsxFxYkA5DnnJDQDAAA=
X-CMS-MailID: 20240213094945epcas1p1f1368fba9dc127af1f18efab15d270d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
	<20240213051716.6596-1-sh043.lee@samsung.com>
	<BL0PR04MB65642D0389544F022A1D2222FC4F2@BL0PR04MB6564.namprd04.prod.outlook.com>



> -----Original Message-----
> From: Avri Altman <Avri.Altman=40wdc.com>
> Sent: Tuesday, February 13, 2024 5:42 PM
> To: Seunghui Lee <sh043.lee=40samsung.com>; linux-mmc=40vger.kernel.org;
> linux-kernel=40vger.kernel.org; ulf.hansson=40linaro.org;
> gregkh=40linuxfoundation.org
> Cc: grant.jung=40samsung.com; jt77.jang=40samsung.com;
> dh0421.hwang=40samsung.com; junwoo80.lee=40samsung.com; jangsub.yi=40sams=
ung.com;
> cw9316.lee=40samsung.com; sh8267.baek=40samsung.com; wkon.kim=40samsung.c=
om
> Subject: RE: =5BPATCH=5D mmc: sd: Add a variable to check a faulty device
>=20
> > In mobile devices, suspend/resume situations are frequent.
> > In the case of a defective SD card in which initialization fails,
> > unnecessary initialization time is consumed for each resume.
> > A field is needed to check that SD card initialization has failed on
> > the host. It could be used to remove unnecessary initialization.
> I don't see where you are using this new init_failed field?
> Maybe instead, elaborate the logic to free_card: to detect a broken sd.
> e.g. instead of just if (=21oldcard), if (=21oldcard =7C=7C =21 mmc_sd_al=
ive(host))
> or something.
>=20
> Thanks,
> Avri
>=20
Thank you for your suggestion.
I'm going to use it in mmc_rescan as below.

e.g.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index a8c17b=
4cd737..461cd75dc7ab 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
=40=40 -2210,7 +2210,7 =40=40 void mmc_rescan(struct work_struct *work)
                container_of(work, struct mmc_host, detect.work);
        int i;
=20
-       if (host->rescan_disable)
+       if (host->rescan_disable =7C=7C host->init_failed)
                return;
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
st
> > *host,
> > u32 ocr,
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
> > b/drivers/mmc/core/slot-gpio.c index
> > 2a2d949a9344..93d081c7dd53 100644
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



