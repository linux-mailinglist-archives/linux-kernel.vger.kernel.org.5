Return-Path: <linux-kernel+bounces-49471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B12846ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9841F27188
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE04182A3;
	Fri,  2 Feb 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OMEc6HZI"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019118C1A;
	Fri,  2 Feb 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862550; cv=fail; b=bPKnvTqgqDafWnAYyL+CRhWIAyhmJBnTxSfPUJAfutMn6IomV199EsU0JeZT1TM0sF5tagHYCa0bI2vF7AvR+29i76mUN/dmuZ++Npt09zQHzgozjIO95VNgh1ssUsw3L4a/u0EbTkiZwSf3V84eIUxyTSF5xwzvNMzCRx9Ovkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862550; c=relaxed/simple;
	bh=ySnEmOQdrjMyVMcXhhvqKPXKWeCVrQP/5LlQVNYqoXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XvGg5IEFz8JRSsldC0qiAu/Ib9K/tqaoWeB9enaQnfPl/w9hKKoRGpqa8FFUFcoCcvqrJxau6amcTKX2fLBTBpWTyB11X3BU/AsBtefbQT6lM9QhAuef/X3zdaa30R0KbzDF0b9E1VXovJZbFl/B2iQSZPrHoEWq+apQRjJO6zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OMEc6HZI; arc=fail smtp.client-ip=40.107.113.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CX3x20/tgOZwNG9uMhwO5FRalBzswKVJnNro914pAEteRjDYWpkPstsX0S8XF2fxcKHZ93RuCb+lAVs/q6jrISD2RR74pnLSURwJLMrbWJ5Y27LySZuhSsKOTCtkHPsPuddrNnd0t1opdm6/MOB7AibuiRN1XYjaGefP/yitsYleBKWljnWrDtEcZKminvAzZjaLOZaYWeTdm/Jd5DP5g7GXblBA9nCGN38aPURwxllG1XXETQIdCKmE7/nNRIZkooKyzJZ1Dad45ie4dC289K+OuzbgfRM4hJGtkG6DwED+XeZp3Kmwm6lubICPprM9JR4/k9cR0nHBEE+rMApNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlsUIyhBf5K/YHxwwAXvp6VVn7XgSKdWL6N+qBi1Opw=;
 b=Jl9D2weUYaLBUL2lA/9Gh1d7bKLjKo0j1FxdQkK3/+2a2LEz6ohIx+X/jpcD07LBkY0IGJGyvHxx8xakVIyqi1/uR2JstHeuwjCSWslCmoYCmCCel4XHuVWVYgZhjB/DBHdIdh4dI/sd9wd2iAULU6s+9tk5NPGTc1j9y4gfew35KYZrmcP2DlyU9yy/UHDSJMTDBocWia5zMv7e05s7CY+rLKEBzGDEM04//6CCIzIAB8vRhWjfTL5F+qOtf2VhOS8Tdc/yw6rM4yv7VqjdqogOzCZQg7EJfTHjJRFcMeB31SY0Hs+poIZ6cS4GZBW+pGsh0FwA9dKmmyemv37tVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlsUIyhBf5K/YHxwwAXvp6VVn7XgSKdWL6N+qBi1Opw=;
 b=OMEc6HZImyrXryWyNTh++6+cmz711Ov8fUyMBtsbhLlkHeiYXMWHVA+NuI6GYGUAJUQvr+sYEv+YiEVtuF1OB45b2FARJCuScgYqiwC8smXd/h8akw4zcJj14MpDYWZAYZkSprIQqqCWmSZ5D1TIXrL/kaKcCtKo0DDklm5lF6s=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB8044.jpnprd01.prod.outlook.com
 (2603:1096:604:177::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 08:29:05 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 08:29:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
Thread-Topic: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
Thread-Index: AQHaVa2xeucsotW+XUyR5O7FIAVIxLD2sMaAgAADP+CAAANJEA==
Date: Fri, 2 Feb 2024 08:29:05 +0000
Message-ID:
 <TYCPR01MB11269FECF0067E0DC7D7CA0C986422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
 <20240202075849.3422380-2-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB112694BA3A47579AE8BC1752B86422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB11269B343C70AA99CBDB3BD8586422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB11269B343C70AA99CBDB3BD8586422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB8044:EE_
x-ms-office365-filtering-correlation-id: 099f7555-c050-4cb3-8846-08dc23c90493
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2rboNst+2pD2GenGkspa+260SqpvZIgkfzjOuFpDsDUcui3xrtD7eiiuMzlVTxPIAMhk9mSsHlcoeOu7M3KQ1a6b3mWfq/otIHMQ7b5rJ9ADVRSvdWGSYxvN4rubBOtBaoJ4nBxdvbhrMEabTQ4N6VS+NEUQ8JHndR3L6/IrDRpzCc9/Znmva537ZQO5vMkSUPZywlSBvCpiTugjfDx7nC5Q6U/3PNTrON3eBptTE45NixhWLFJJ96Q3YDINwJdhxHdLs++wvx88sIGTKaLgjYCANVx6crTFdhFWYwCSKgzZhthl93hI6dyit7k8dK+kyVZqzIqNc0FPt9UMEkl/qNNer/Zl1SDp4TQNCn0nZb6+iH3ssTOu/Bro8iD137qlTfzakQmS0JCjNLODnGjDOn9vwxZCGZ75lC+15BmixzHPmfLEHUpD7IXIvz+FAvDl8WN3TmHEPJpYb+mW8VJ3VaQeHAgD3ZAONWsFvcSMJtx+mL5hdCg/MF8Kk30kLsP+Wkj03SCAi3jZpQdq9/Uv1pPfYLRGwKKMcE6OOqr9559nfJMnvhr785Ozk/DhKibnT1kbw63sL88C3Ubdm6xhHyFAGw+4LE+1tDy6LP35VpGJlqabC8SUJSr+lISdtuXL1ARnLHqUXJxy8mdwUfrz6A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(921011)(33656002)(55016003)(2940100002)(478600001)(53546011)(38070700009)(86362001)(9686003)(83380400001)(107886003)(26005)(41300700001)(6506007)(7696005)(316002)(71200400001)(2906002)(66476007)(5660300002)(54906003)(64756008)(66446008)(52536014)(7416002)(38100700002)(8936002)(122000001)(4326008)(76116006)(66946007)(66556008)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yx8eQfMlve+fKE6IcMKwCZUvgjnkIvV7QYaCYDDx29XvoyAUefQftheevfw6?=
 =?us-ascii?Q?WX5EKjjTuCAYuWIMLBJHuvaYJaEzWSJAG/YcgoUyK6GK5YoPiOdA5cicuSay?=
 =?us-ascii?Q?EPx613Uli50yWou1IC9rBNTyeP7up5g3t38K6QWfKyWuk/yvEKB/ty9AgqOL?=
 =?us-ascii?Q?8CyBVfr5njNofSLdhUIBmjDDNg7YT8R9visEhO7Gi0tiLb+W4fNARHeFELdB?=
 =?us-ascii?Q?TfalYcMISieddsnL66e26zanZsoFJUgAmTpbc8fN276AjBK945ReCjwgnvkj?=
 =?us-ascii?Q?MRKI8xWK2GaRllRfOzRQYCXBXSdlATyl5uNsRlCEFVot4zp458nhu9z8Y3nN?=
 =?us-ascii?Q?nKo7x73y5zXb1stYmiVKv+jwIbllszC9S0JW4MqJi5JAOHe2e93dyht8AFeG?=
 =?us-ascii?Q?pkrdgZ/UGAs4n2wIZmMzS+/UwHCqsAuQ5SWSD5Z58gfO8PDQx8GCHFn5mMDP?=
 =?us-ascii?Q?1sbNeWzvs8VBhq/hGmfoNsnoV11hIoOXJC5Jvyf13icXAi0E6ahXjH+lSO7y?=
 =?us-ascii?Q?XauYRv0XcdNhU0pdmC5hd72ZoZHy+7ap/UMIl8dDN/pD6C/+oseBP54g1KsJ?=
 =?us-ascii?Q?SdTHAjcZq4zscmtP8d4/g77fN5WMtTWRUjtNfu/6S59qhIEM9HIXYj/UQipZ?=
 =?us-ascii?Q?TN4BO9Fml4786I5+QxrPo14B+nQg3mimhrr3j36CjBbSQAC2ZEqeR0UGIZny?=
 =?us-ascii?Q?GbB53UYyymnCC94tnhoFd6IJw1xriJ5WMH9OV5fet0FHc69v+38qqfFG2UAJ?=
 =?us-ascii?Q?Hbv7OVYug8yKslQHX+ujKJeE4Nq3+Z5kY2FcFaHZ2TTB3wO9f9/EFOnPHyzm?=
 =?us-ascii?Q?2ouB/otxZMrL7niMNHaBjVFemM8uZbDA0P+V2i0q3Ymnb/WGxcVgWDC7/H8/?=
 =?us-ascii?Q?6C7gLNhNQlmfAQbCkNjBGbcjbbANQ/KuiKX4BIkfXYi1lUmJEZpNaWd1ZHR2?=
 =?us-ascii?Q?rmIlXhvOMVvOYdNKrhYCHnrGE08DZQSKK4nS5S790r2gS817SyM+go8WigIY?=
 =?us-ascii?Q?EdI4skL1r18LZRPQLyAPRuDAHWyv1Wf8pk1deY7x+6gJ9ZBIajP07wb61ltX?=
 =?us-ascii?Q?PiogTtt8oQbhjOfr8JS1ndgkl91CS9m78d1WBJCFTP9KFRltHinPBPQ/XmzS?=
 =?us-ascii?Q?xB8pSTMwp5uO6CZzXB5dQeSDhilE9yU1Hs6yiGPqbJLzKxJBXLnlVTFMqwsD?=
 =?us-ascii?Q?gniiWES6STatHm4KHzJaQZMAGPM0yTOBIRN8FMaAClXmqkrFaoq1F3sI4bxT?=
 =?us-ascii?Q?yHPRqyiE79QkWrgqvD2hQwoSERaUXYvq4hW3l71QevEPMl6pI4VNE39plBwZ?=
 =?us-ascii?Q?c30eGIEcPp4EjhEGqP5576LlxyN3LZkXFbNQ9ahNtEDHv/IGDe8X2fCQ+fQL?=
 =?us-ascii?Q?izroQOGl+Nz0unnDmXnz8IEAnwmTAkOAo5NUkSt8FWsSsH/OSAe5pr5JHXEp?=
 =?us-ascii?Q?nNP0OneynowmxESPu/mmxmsjpErohZQFJ1Lp7aMqz+VGD2ttRmRHjW0Ot/x/?=
 =?us-ascii?Q?WilwDFnNLtyJfMYoPOVhmh1M+lSKidkNeXDOSUw4/WP9BBaCMwGwvUpWci3U?=
 =?us-ascii?Q?qhgxxoMJS4QbU6II76F++wHuCv34R08YzIR7PMnMRLeHpEed0Zf52DqAmQp3?=
 =?us-ascii?Q?Rg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099f7555-c050-4cb3-8846-08dc23c90493
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 08:29:05.1442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5a3ekIq30UQVn1u0VB1s0AmY+3G6DKj8qAE6GhaGkJF14RFimthiF/hF0YPiJmuQG+1Xv4yPjOdgqntmo+xgvjOLvUmoHNvq8owRYPUKVnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8044

> > -----Original Message-----
> > From: Biju Das
> > Sent: Friday, February 2, 2024 8:03 AM
> > Subject: RE: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
> >
> > Hi Claudiu Beznea,
> >
> > > -----Original Message-----
> > > From: Claudiu <claudiu.beznea@tuxon.dev>
> > > Sent: Friday, February 2, 2024 7:59 AM
> > > Subject: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
> > >
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> > > clocks are enabled though pm_runtime_* specific APIs). To avoid
> > > building a driver that doesn't work make it depend on CONFIG_PM.
> > >
> > > Suggested-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > ---
> > >
> > > Changes in v3:
> > > - make driver depend on PM; with that the "unmet direct dependency"
> > >   Reported-by: kernel test robot <lkp@intel.com>
> > >   was also fixed
> > > - adapt commit message
> > >
> > > Changes in v2:
> > > - this patch is new
> > >
> > >  drivers/watchdog/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > index 7d22051b15a2..c9abe8f307bb 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -910,7 +910,7 @@ config RENESAS_RZN1WDT
> > >
> > >  config RENESAS_RZG2LWDT
> > >  	tristate "Renesas RZ/G2L WDT Watchdog"
> > > -	depends on ARCH_RENESAS || COMPILE_TEST
> > > +	depends on (ARCH_RENESAS && PM) || COMPILE_TEST
> >
> > Since you are touching here, maybe ARCH_RZG2L?? like other RZ/G2L
> drivers.
>=20
> Also RZ/V2M "ARCH_R9A09G011" as both these families using same driver.

Also commit header it is "Depend on" not "Select"?

Cheers,
Biju

