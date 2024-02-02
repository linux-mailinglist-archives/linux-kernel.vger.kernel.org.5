Return-Path: <linux-kernel+bounces-49451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92C846A85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7ED1F22C21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F99487BE;
	Fri,  2 Feb 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="S1h4odOT"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C64879B;
	Fri,  2 Feb 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861694; cv=fail; b=HA5L+eAry6sxL9qqth44sA06/xV/vn/LQeHgIKr9KEJvCPVzQqwq7Xorniod6rzeYpdo8ZTu9syOWFZ4x3Yty359HboGxZl/rS52Udas85P4+hDmBI4A1gLRLlxb1m0YBXmh5+CGsgsNNgYDL7zwHT3PP7VICXt+4vywt7/E8pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861694; c=relaxed/simple;
	bh=cDbGRujZsdur97s9/4MCnRfSfL7d2RDgrvRdliucWRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gDXFZPxZkBubSKi/v/cCXKL+iryP3bKVY6LIQ8hLrIMqbvnwBJimOLlBeNyfzyY6Pb41pg2vaG5Hj3AgDo09L+YB3kJAZBBZh7dhoCrexMKHgQdYFT3EJExxNNpf2LvmbrSvzXkAgYTsVguFpK7rsEz6KHsaOn5Sc2Cma5/aiV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=S1h4odOT; arc=fail smtp.client-ip=40.107.113.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6QtXrRp5P0IOXNX1TfhI7dG0ZgU3MmwjyL0XwKXcTDi5n93Km5D4qPpnt0Z8WqfQq4e+Y8PQmYQCYGr+EeRLv7ZLRsVGNRWWbi4C+jDo4qGoCIJqji89ZtmBeoEpzKguOsAb4b0GJmCGtxR18JIO0ztXowWIB4k1ut3Ct8Zscf5Z/uCYNpgc9SpZRQRAMWjOWhoq41rR3/0IGNp5bPW/1sNw/OCrE3G/CDPhq3k1Nf5s1Rc8s0JAIaqyB2a080nqS6qWRBNOfR6qwiav0YpevDWwCf5z5brAebcobf5rM/ACBjObto6oMEVthxy6aAD8OQRxb4WyawhY+TZKXOF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/67K8zyb6xg9h5Qj9JIgNd/2e5sRfzUWRiiiOHR1SpM=;
 b=Rt7rnQdOYA9FKV3HIT2MEV4KRXV+V7Jq4DMztcuOPN2esO+asqV/4dqSiIF/1u9loNfqkJ0u+S28vDpVlEqTtqWW9/7X5tVhMjh5ZCFbNiOd+kxkuURdfS2tc6UrCfJRLNuTEII8W7bUWgsfpdKgUguodxBGUpYpdtHhwyIPswZ0JS2I7DYuRG9ffoaX5hWisX2ZxkM0XQmFVbig1DuSaF5WESqELD3DR5cbIz2nVzx3uC8ahh7rLnOw1/udnUnksa9ArUbUtMKg22kIFNME4RdZnrvCyr0A73pexRE4yZojrzTz/tq/NiV6CbTHrPlLsmMckCLvBPz98xaZQqROWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/67K8zyb6xg9h5Qj9JIgNd/2e5sRfzUWRiiiOHR1SpM=;
 b=S1h4odOTavc8qYXdFoE6VLnLh9N1Gd5OVonqO4kXZSu4c5eLorixR32O23SAh1mEd+Nub9fDKRWQ2K41IT9tMQpQad2Q2bSmjMY+eygDnmdsA2963n+YXWsJG9CRw8JGCKfCCfud5bIuvF4YK9en303dZXN3EUdJnqreg1zj4wA=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYAPR01MB5626.jpnprd01.prod.outlook.com
 (2603:1096:404:8054::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 08:14:43 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 08:14:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
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
Thread-Index: AQHaVa2xeucsotW+XUyR5O7FIAVIxLD2sMaAgAADP+A=
Date: Fri, 2 Feb 2024 08:14:43 +0000
Message-ID:
 <TYCPR01MB11269B343C70AA99CBDB3BD8586422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
 <20240202075849.3422380-2-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB112694BA3A47579AE8BC1752B86422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB112694BA3A47579AE8BC1752B86422@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYAPR01MB5626:EE_
x-ms-office365-filtering-correlation-id: 03e52585-48ba-47a2-c174-08dc23c702ed
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bPZmtJz/NBVEh80OWKnj3jWY2k6mez3qwJGCUM6CjDBnugNHlukU6ud2vvMkGxb9CLAK7BlYw7KhAZv0CTyOf6lH0hgniSQq8KstElbZKF1rby9HIbnlIcxWVbsa45BNzO7h22c1VNA0omoVzKUJcRvsI9IXegCKzIPnbnMLZfQBXuLXF6XjSKtGLG/XLARfMq0ClVwyNk2xl7U2d5nIY7m9uTMRW3Hf1wWFAX6Wkyf364HHT6aKjc7r2XIVkAMkDe8f5I9XozmPCoAtwA2hQp3JumRgi71YO8KPzUb2MbyhtRlmpsQOkHSIfx6bJRbnE74Fn2uNCAR8UZDvzdI4G/EVL7vbH/RQWVT6nA6MOmW/FsczCJSrhFJ0s7oluI8UVhI+HLWScl9/MmPQitnvOVVVwvmNIJqF0eZ0TO5ah3x27tJVd3foJ+Nw7PrW2HpOdxH+VkLx8hb6utV4mFfElLvbe5j44vbVVxWX22WkSMTIvwRT5H9mUkMKv+G5nOuApKo38/1xV47v5FU6xPoNn0YrNWUhI4EvKAJxYBLDkp5FU65IWL5KTG/YwGNsWzg88RdRrwLWf/TMAlcEcKjyY7RAf1UgeFcbH01rGQ2H5JQk+eTS84MIwcNld1kUbhDG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(41300700001)(122000001)(76116006)(8676002)(8936002)(55016003)(52536014)(4326008)(478600001)(316002)(110136005)(33656002)(38100700002)(38070700009)(71200400001)(7696005)(9686003)(7416002)(53546011)(66476007)(66446008)(66556008)(66946007)(54906003)(64756008)(2940100002)(6506007)(5660300002)(107886003)(83380400001)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UH0MyvoNW3cXixdvo9dqJmN3cfyPdsSoReSTFLHOZvzjH7o79tdcRm5oSSMA?=
 =?us-ascii?Q?SG1HQ8Pdt755xjzvt6gaizrVP3tWyTa8xoUufVVhwRNHP/iRarxAM9aYuv98?=
 =?us-ascii?Q?+ivQ0gL2dmQDpDDtbXrDUZgy1+jMGCYLXjmQQ2tBoAx7eppUF9t3KwODr8H8?=
 =?us-ascii?Q?T+f/EZiMjKhMtMx3rLmVoiGEZ0sJbT6RpcHuk51mK9TqBd0KGBoxPGCoF9C+?=
 =?us-ascii?Q?XsJjqbVpvk0OtY1x1Jae92lJxLtuQJ2IoYpVT5HAOzvM2vpv9XYBhzVEbKM6?=
 =?us-ascii?Q?MOWQHWsF6VHCJmycKYB1Lz4lgJ01Gg0lhyH4djMo3enrIIs6eQY6ouZpNxMT?=
 =?us-ascii?Q?MF4wBhOVPvkmW1CI5ylif8wUTyTP4hvcwIZ7VD3XBMLw6zT3wKQJW2/LImec?=
 =?us-ascii?Q?nvyOai9fnyHZpfg49aLUr1IjWE1xjLQEBfA560zdjAFGIDBrGZy0gbzOTU63?=
 =?us-ascii?Q?dQQiMeCDlcGt92nsB/Le4jE5HH2d8DRM9jZG7x5fV++INK5uKDhFo02MErCn?=
 =?us-ascii?Q?xc2qfQDUndavSD+auu2fljprIdk+vRP1wPj1g+gdqzBoXrcF8RXn+z4oT4Rl?=
 =?us-ascii?Q?jHaseS8JtJMZYgJ5DMsMVpfjZ5JLXi+SyGffMqjf3yDVwhBfnw93AIWt/X+l?=
 =?us-ascii?Q?Hmo5VvjcCi0XxFzOxsf2RoIf0cRLUcsyVACYanfXtduAeQNhUOTlFPuy0XeW?=
 =?us-ascii?Q?nWXhZkiwBUCz90Qcl0AN4j928pYBQYAc2JA652blTmX1au4vbHYY0HuF++p1?=
 =?us-ascii?Q?/nOrqmXtTD05im0/S7LanJKw7G7OMMz2JU7v0sCbxeD0I2jLRg8HnAG5iqUO?=
 =?us-ascii?Q?RcBeHW3Pp5TUe9Ll/GqOqxQgWcoZUOKKanKT8gumf35NCDgyttu8pDdz+l05?=
 =?us-ascii?Q?ualeQTH+ZZEdO5lxbn1zUO0Wa7PzuDv9j8F3dlyZ2BKYAe74qldIW0P9ROxS?=
 =?us-ascii?Q?xj/tohp4Dx1Y93sXG2UeqVZiYw8AZ3qwQnuLKIrpdmGg5u8KsPSU7sgl5Iga?=
 =?us-ascii?Q?EIu8RaPv4/puvzHrQ078FIZGMNItTPniw9VUgLN6fjtjGUoqRxOtiwRqxM0K?=
 =?us-ascii?Q?E0qKK1GBhF6s2eagyz9Y6j+KOKGcjRKZf9G4/12kDwWGi0QQXXG9hWwcxdIi?=
 =?us-ascii?Q?Sk4peKwTSDoJIUsXiyqJR3PMVdB6CZ3K3z5wtCyQqsdM2Uo2ROFo+Lnfnxey?=
 =?us-ascii?Q?eKQAXvf/2XfvveBGVZBY/JDFdM8yp0sSOt/CF4LZSVFL3YJ3nXigv/FZfpZl?=
 =?us-ascii?Q?aEfRcl73rP54YSCTihtemhp9GinVAdJjZQ5nPCiMl0IGTmtwIRQGEjl+ASNo?=
 =?us-ascii?Q?fcP2L5425gDsz1LjhEXXKLxckzlYyGS/HGAFD82y371lhmTeq9OYjlEUYLKs?=
 =?us-ascii?Q?/zXJYKsek50QuMplgZle+yr/dObg4PfIhPN9WHuiS9GTsceGsQESZ1Bv/ajM?=
 =?us-ascii?Q?VlMY+xnsIQh8MDD6151RBsK/XSEEGyUj07pp8fcolNBfZMlPx9qumVHKiweP?=
 =?us-ascii?Q?EAfvmiTQlz2WwoZgGQ539ZHlNvSnUUWbL6N5dEmTVGMWqNMSIYCWNmqdkWWg?=
 =?us-ascii?Q?0h14Bd2nLjZyTA9P6CvZySSAw193RYSyk8JC59dn+B8M+LabZLXv9ctJY9Zt?=
 =?us-ascii?Q?fQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e52585-48ba-47a2-c174-08dc23c702ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 08:14:43.4287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xrx2l3A9J019BE+aSGl077HIKocVoLj5CSqPLtaZxA3IpjeGvyZCZesH9qYn44W1BzTYIDWWq7UTfea6Dzxd8jHjACtbwLoo76HQGXA1UO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5626



> -----Original Message-----
> From: Biju Das
> Sent: Friday, February 2, 2024 8:03 AM
> Subject: RE: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
>=20
> Hi Claudiu Beznea,
>=20
> > -----Original Message-----
> > From: Claudiu <claudiu.beznea@tuxon.dev>
> > Sent: Friday, February 2, 2024 7:59 AM
> > Subject: [PATCH v3 1/8] watchdog: rzg2l_wdt: Select PM
> >
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> > clocks are enabled though pm_runtime_* specific APIs). To avoid
> > building a driver that doesn't work make it depend on CONFIG_PM.
> >
> > Suggested-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >
> > Changes in v3:
> > - make driver depend on PM; with that the "unmet direct dependency"
> >   Reported-by: kernel test robot <lkp@intel.com>
> >   was also fixed
> > - adapt commit message
> >
> > Changes in v2:
> > - this patch is new
> >
> >  drivers/watchdog/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > 7d22051b15a2..c9abe8f307bb 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -910,7 +910,7 @@ config RENESAS_RZN1WDT
> >
> >  config RENESAS_RZG2LWDT
> >  	tristate "Renesas RZ/G2L WDT Watchdog"
> > -	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on (ARCH_RENESAS && PM) || COMPILE_TEST
>=20
> Since you are touching here, maybe ARCH_RZG2L?? like other RZ/G2L drivers=
.

Also RZ/V2M "ARCH_R9A09G011" as both these families using same driver.

Cheers,
Biju

