Return-Path: <linux-kernel+bounces-108820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52C5881075
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EE8283A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF83C485;
	Wed, 20 Mar 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ftymLtIp"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2048.outbound.protection.outlook.com [40.107.114.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26153B29D;
	Wed, 20 Mar 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932931; cv=fail; b=X6clixPAczAO56U4HybnMQ1AC6F43Ar0ifQ/kk0YK8Ve3Y/BaNxAkmMTpMxsuqzaA8xwVFCs7MyXXPwQJPRVNCJfftmNRfDiC27oL9oKGqCV+S6QGhMpHRargyrzOdeyeXjR+nrbhzFcgkmnc42nlwiZ1R4Wk9cF/2jliOgloQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932931; c=relaxed/simple;
	bh=rghTEz2dLzxvxMvhumjWOUBNLbjoIycKVlzIzi+OH40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C51F5xt82oGYkcxBvSYwxF1mkt3rMRwMhw6FY2dmO4BfgEwWkUHgFnIKl28M08jZf7ZvpK5MKSVqx5RT6X4zIJ4Xt9HHjJ3dg0AMcPjTnzn+fmPItLHKPvneTXDK3TDnyE56zyYoYfw45sdNmBR+AyNz83BcZSxqgHJBohIAAnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ftymLtIp; arc=fail smtp.client-ip=40.107.114.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrzHbdSjMlENoobwnCQhy32KM7uwa1gBD7Mc0ExxE42GkUk506FRjRBGr//Y3IqLhUwe5syZCeMNFxRZ6WQZUx3klwYidMOSMZcDJq6qKArYugNh7MHcqayYqzxZQj8q3xLUWZQD2fMyxKu1bn9u/SStGiL9DzCie1BUYGvb1p67drotSBREMlr8DIL7EdEcelsXjBjTEtNs4L0KQ5Twx9J3M0yB0X5azKM32T/TRx2N8bzZNXJ4VDFAmRt4uPWSRrmfg0dTjDOwipXyHSOLsSzbvlV0fB0kh85UXndEW8nK3Owc6Ht4K9VRYha+apUS6evE1blsIQi3/YawV+1QuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soc0oHZ8SKDw+I107LtdNF4XgP+xrn+S/XbP+sXleF8=;
 b=DvEeTxBpFMIgTreVutv9ZVI+5ThMZ4JpDdh1Ta3l3+7ra7iCrTUjHaLw5UTmu81atMvoak5OfgwY7L5mA9qY+MblHECOeqwpAl1hIUPqdbjxdYsCnSGXfp/sWGngcTzD6pmmkUpPRf2zxQ4WV7OMOM+YaIM72d9Fs1nTO0zJ4ss0a+gVWBRe1ioHszRTfYuSgJq8TOd5P+Eft4vvISlBgWLUDGd6ft8LKZoRl2aU6l3omWzCluI5/SLTwEtfs5WqKEIzGrk3wtOVoXY29aZmxVSnF8XnemkCeX96PZP+rrzvJ4K/8JgpiQE1UDqEG9dDwx+9ndk6vf7oVneQaLLSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soc0oHZ8SKDw+I107LtdNF4XgP+xrn+S/XbP+sXleF8=;
 b=ftymLtIpj3YNrf1BQcWzbSQAnsZnsAQyNoYm2z6dAWkO7rt1dgQHkc23FWjzUyJm8KvrhORNW8Oc52t4r1uu/BW3bZArCWHoyIW/sDxFopVRvOKGU9/76gmqmek/0rb3iVS4ACTFsQIylPdipaKu7/NZ/Vp9UNwsuD2qLXgZy7c=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by TYWPR01MB8284.jpnprd01.prod.outlook.com (2603:1096:400:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 11:08:39 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f%5]) with mapi id 15.20.7386.023; Wed, 20 Mar 2024
 11:08:38 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt
 type on resume
Thread-Topic: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt
 type on resume
Thread-Index: AQHaerN1t0zmC78ia0+OQ9W2eqNy9bFAd/ZQ
Date: Wed, 20 Mar 2024 11:08:38 +0000
Message-ID:
 <OSAPR01MB158778802C8AAF3F9230259286332@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
 <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|TYWPR01MB8284:EE_
x-ms-office365-filtering-correlation-id: bba50b02-c10f-4264-299c-08dc48ce1849
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hRwUuIObCn+akznxPjlAzuYl06ayWG9m2mgI7pRbufnmnBzqYU7ryGnsaDNJ2KINEoVQS8jNF7EXOYp9QrvkjhZ31RBc7RSJQVU0hjGXQ9/48QHyWnL7bYaCprlVoOuBlVWiknHm/94ZS7dcScfURGUNATcjvX4LxN2ED/ASPK1CyUbaQDhUCCgddlsiE3ELsobCG+qnYUp13TzvuMLopWk5I/AedAB+qzH4P5f+vFW4dqx8RAeBjwBuOjnhKRPQKMCfdvfcB1ZXSEc5hU8ez8YXBdtEbBWG6g3OuzmPJQXH7nsAzlIDEcB6pQZ+JRHkBcokW3/mOwLm4mKn4LIbXL/STSd1+dZUk6m/xqNZcq5ANMn6gczmDxn8DlG0+e8tSn3pkiWooO8ft/Rk4pLeqMNUOkghdwnYCbrOqprO502heLghHKoUgAHBd1ODXgzXbpyQ0S70sUnpqAdmYOk+ZMNNYfmGdao+cH8x0/lnJdD0i1whSuzs929FUB9r5HPyhhXupIZRMFAvqDrbrsRgErUiCadCOg+cf2Cx6KdUFM6SwFW6j4j2xFlmX5jxij/maW/j9xVlj97I7V9cKUXPzP6S1C3uQc26wzY+KGK2uJ4/jKPVzpKjoKbSITr7v8qmYB6/5T4Xf4bFlaqUF14PlwPYtS9ozx+4evdfWAwI+pd3mH/YFnrh7LGbtLOhXIEnNDyarrob0fxAjd2n90RoQRYrT5dEeX8H4vqIMn36pOA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zp4ZqC50Qarv3BFO8Y/r6PFhKJflVhXUYK4erg3z/9nehJMi6q7Je/BDO5+w?=
 =?us-ascii?Q?EftNHz2fFan3O+m047ifnHPujHZa6RGSiHdMW2E6sIkQSoeQmYz4s7aTKV24?=
 =?us-ascii?Q?av0Pzt72jqIc+64MAOTpYg2zPdwTAMtC7QIwpP4jQdXXG1EpWitH2qEx5jNP?=
 =?us-ascii?Q?cezfDK16YiASef5aj9HYOXKV+0aT0F+R91+1xIlM2qOgGNUieQKhgmXgZwhS?=
 =?us-ascii?Q?LhtUPsOwL23cRUROvfm6dnqH6NV4v+2ffIAQUQmPfjTUGx1jjb0zo4s0RszS?=
 =?us-ascii?Q?rSU2k/41CEMB7/+zoZHlQv7sjVKQbz020fZRoYCZnlnEQE9wDYcb5CqjSQOb?=
 =?us-ascii?Q?XlvyoUdKCLtout4l4X51ALHw35Auistg23jyEJrjcaI1FRB/VCawTmXz9L8x?=
 =?us-ascii?Q?XWb6gsOsaoYq5la/8qplXybPKvhPaH39miSsT3eOXLSjfCByxCNd0ptTnThT?=
 =?us-ascii?Q?ht2YSsuP/CzwlKutmggPICIqMrotXRI1Awk6CZLakyqjs8IcGV7U7+eMgeIg?=
 =?us-ascii?Q?pC57DF19U6nvq7NsNrnGinUiHKJdbpXvabyxXpAlKiNEmKvXQgB+C3mRTeuH?=
 =?us-ascii?Q?wxKOu2V/yFzzoDokY+Ak2z4kaWAsd9Q2PNCUuS0UiqDrkUfaD+prec3E++cU?=
 =?us-ascii?Q?Y+wkOEsth/GE66GzOT5DWHvHwP3i95CR8buKSnZWO7guVCuYwFAIoNfy8xE3?=
 =?us-ascii?Q?v3wf0rD6HvPqzEaSoA6BWfYDcUXhzToiAOBtsrrRad9C6vqAUpNWcjN++gCt?=
 =?us-ascii?Q?sg2q4UZG5SwqeExmrZ15wVSGG2iKxGeyPXGfQj1AX6GNoFDKnd9MsjfJs9bE?=
 =?us-ascii?Q?y3QqcxzmRYor3myVrVCUgbxm2EMw4LEWI3mX5lmpssxa4Z0OjoplD/41UTGL?=
 =?us-ascii?Q?OM0uRl68Orw8l10UhaV5KLxlQQOkOQpD1uJlhPRiO7R/0PPdqM/Ert73o0po?=
 =?us-ascii?Q?5Ds5tzujSaBCqc6MHy/HBvkW2z0HdbPWJDpQafMB0RcKAzNUtojnd3HteJbz?=
 =?us-ascii?Q?+q5F89GY4r40oRrFunT4EMTEJAfVXYngcUqmLwWVgt4RPFHfNIE4+R497p01?=
 =?us-ascii?Q?hiMy+/m8bQwe5UW9HLb7DucUFl2x7rNNEgtLo2kg2z3hBcIgpUDKfvr0ONgU?=
 =?us-ascii?Q?cz/UIpRZpuf3f9o7R2l99kumSwnyW0VCC8oxhOcaUeUh7QDQQslWPvOT4pez?=
 =?us-ascii?Q?6fxyrLUbbgLZ5wRiGWDb9jZHlKONTZ4NpyqoaLlWg6rr/ZbAFJO0Wua78is5?=
 =?us-ascii?Q?egPn3bdv7aVxAcRkEUYYgdNijYURrgAlQEowKuL16/54TkoUzWWvdgFLWjXl?=
 =?us-ascii?Q?yLt/sps6wQNRpdjlySdfG8Jx4i1i6S51X8R/zH5GoWmEtZjD4B4nGaeOghf9?=
 =?us-ascii?Q?byRJ/9NDfKk1sgi0qLEUTG1+5mT1zSB1qcm8gG+HgBreF4HQwiGDBb+qUxw9?=
 =?us-ascii?Q?+/s3O1J/pMYQ8YJGKotaKSfx/YA3YqSIJExmEjMJ+5vWh+IJkgKYYmhAPhr9?=
 =?us-ascii?Q?jRk9ypAoSd6NelT1nLg6L+GUwl+ElhXcS9BfEu1FyocHubGuc7sTrvYZl+B0?=
 =?us-ascii?Q?39PDQKs5gtMmUF5fxF3+KaMgXlBSg/hEEwCZOWUYNFE2kuGgYH+JcxmVYTe5?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1587.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba50b02-c10f-4264-299c-08dc48ce1849
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 11:08:38.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mq+IRZ8vMJ9hG9dhghj/q/7ydAaisTJwG1oQqfkNlCFb+pCIhtXDbnOFzfNbWhyRCuCDclPj9exqfxRlQ8KAZwRi3iekSItz/2/DwcX2WJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8284

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, March 20, 2024 10:43 AM
> Subject: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt =
type on resume
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT sou=
rce at the same time") removed
> the setup of TINT from rzg2l_irqc_irq_enable(). To address the spourious =
interrupt issue the setup of
> TINT has been moved in rzg2l_tint_set_edge() though rzg2l_disable_tint_an=
d_set_tint_source(). With
> this, the interrupts are not properly re-configured after a suspend-to-RA=
M cycle. To address this issue
> and avoid spurious interrupts while resumming set the interrupt type befo=
re enabling it.

Just a question,

Previously you don't save/restore irq_type() register during suspend/resume=
()??
After STR, any way we will lose that information.

Cheers,
Biju



>=20
> Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT sou=
rce at the same time")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/re=
nesas/pinctrl-rzg2l.c
> index 93916553bcc7..4fee3b0e6c5e 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2045,7 +2045,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pin=
ctrl *pctrl)
>=20
>  	for (unsigned int i =3D 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
>  		struct irq_data *data;
> +		unsigned long flags;
>  		unsigned int virq;
> +		int ret;
>=20
>  		if (!pctrl->hwirq[i])
>  			continue;
> @@ -2063,17 +2065,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_p=
inctrl *pctrl)
>  			continue;
>  		}
>=20
> -		if (!irqd_irq_disabled(data)) {
> -			unsigned long flags;
> -
> -			/*
> -			 * This has to be atomically executed to protect against a concurrent
> -			 * interrupt.
> -			 */
> -			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
> +		/*
> +		 * This has to be atomically executed to protect against a concurrent
> +		 * interrupt.
> +		 */
> +		raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
> +		ret =3D rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
> +		if (ret)
> +			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=3D%u\n", virq);
> +		else if (!irqd_irq_disabled(data))
>  			rzg2l_gpio_irq_enable(data);
> -			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
> -		}
> +		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
>  	}
>  }
>=20
> --
> 2.39.2


