Return-Path: <linux-kernel+bounces-87650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDAB86D6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E7D2878E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E3B38DD7;
	Thu, 29 Feb 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="QyGC1Cd+"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2087.outbound.protection.outlook.com [40.107.113.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161622318;
	Thu, 29 Feb 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246709; cv=fail; b=pyV4g2QjsmQ5R+dfEYBfGvJLBKhDP+FPNcZ0TNAHX9GlRIhbwsUlCiyk/VMa2heY/CBGRgCmwP/lXR9PH/5GuPI5sCka18dNvOAjQGANZ4RdcDywqXvPKonq7bcJ+zXrFNpxVJDKfH1JCXEzOGLeo1xqIIKG0EvR4nQRABCQxDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246709; c=relaxed/simple;
	bh=c6t5rlznv4J5koZcFY8UFMkFcMSuytffiXuMYMLXU3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYEwf8DoyV9KzX+JcpV3ZoOTwWcu1UxPs30WnQb7K3pHKbrCFbrJadV525YvzH0MLalQ9+xDqQxI0YLckFXHRE68WVUVv0hrAZaDChDz4wOGTmD5Hxemk2B1N4EU7xaaXmf3uel6ye6VZz7xunYxnZbOBvVFuZFmAklbKtplNBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=QyGC1Cd+; arc=fail smtp.client-ip=40.107.113.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9HM0hXIQXaG/Xe+oyGwEI5hoz5My4oTQR6dlNuC+oXuhCJfgvpSty8NXiHIDnp8k8u+gTdZ38JZs5/3BDLyP+Z/4vZtrrSx697DSzOQtYh8rA1SqvUgy0SETRi1R/iyo+kchsC02JXq10tZ55zTyieFM5wB6a6UJkjW9SOXjVcJ8PjqWpSKPQnVkx/ONTY6OlJVVwYSiWVh4i1CcEQSNWZb68T2zu1IxNfyS5Gn1A3Qbh3cGmZLwguGTTxMryf9K3YGXB0ko5AVLGBq9kp0Gs3fE1ETJSV/XEEIa79ZyYa8diiAVNnkjRmNFxl3L3llEK5fMiZOVtI258OTOzRs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9y7j170pcLMFNgRRnqDwunK+XFw37+zpUbVCYwYI+I=;
 b=h/ZxqQeDxxc/eqO2Crv4siGrKNUIqnVUAgD+dblSEQfsXHAb06pgUqW/4cmyrnOVa61940WWx7zN3OXxVv12P8wa3JfW9ha+6lGgVDPIkwto1vBuA0Y8n8jn1UJWXJZZ5iqqHo5Daoor/YcMKlOOfz5GFnfILzXI1pwC7YDsdSNk5H/+pN47Mu/o8+D3z/ZPYyuFKya+XtjZw6y2tnJ4eesCxxX6W0yBKzILwcXVoLF0i13iu8KO8ipjmOwGFUkgIApn1FbbVGZ1Bej+aziaipTo1NJJllPqL46H32S6m3sTqcMj8QnjqnIBOFoSE6FkFK3sX5qmhpwkdSndMCyyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9y7j170pcLMFNgRRnqDwunK+XFw37+zpUbVCYwYI+I=;
 b=QyGC1Cd+Gu+hmrdPPoXfQMhbkxLJBInnTcNN+/KvvdsAEL0nH4KOaTsb1O1r2qFwIX+Ms41hcfva4QAQXqRUoybsz3OdYT1HtwAxdQReD/WRPlNDv86zLFHnjGo4q3eevi0c8rY8SkLWruLmWq6u6BVIwhXGANNkFyihphygY8s=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OS7PR01MB11979.jpnprd01.prod.outlook.com (2603:1096:604:239::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Thu, 29 Feb
 2024 22:45:01 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::675c:58ac:9054:36c0]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::675c:58ac:9054:36c0%7]) with mapi id 15.20.7339.031; Thu, 29 Feb 2024
 22:45:01 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHaXfdzv+U6vrQ6NUaz4vTtuVxRF7EhoJIAgABVclA=
Date: Thu, 29 Feb 2024 22:45:01 +0000
Message-ID:
 <TYCPR01MB12093649FED62A25C3504E4D2C25F2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20240212210652.368680-1-fabrizio.castro.jz@renesas.com>
 <20240212210652.368680-3-fabrizio.castro.jz@renesas.com>
 <wwkzprliai3vge53fcveosfkixmri4hoyfjeulbzoezmaayoci@6hor5uwwdag4>
In-Reply-To: <wwkzprliai3vge53fcveosfkixmri4hoyfjeulbzoezmaayoci@6hor5uwwdag4>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OS7PR01MB11979:EE_
x-ms-office365-filtering-correlation-id: e5f0a3bc-bf80-4383-c873-08dc3978107d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MwAlbdrKSnFyBZltFfkIplp5qf3+xA7VWVNFkiCfAAAkiao9xhGM86Yvp1LGqs9th2eyDZS6cQfdINScXKH6rHbZ/GMKgUia2NJChdPGF1mdJG6frFRUVpH1os/ytNB5MibUeV/gvrqB36tTx4BHTWIcmkFMiZtlRMtd89krGZ6tsQdN1/1ye9z3HeGznLuB4D5ATUTdiifxuEyCGuCuuqLmyWndNq/Pxs177vj2AM65Kjk6cQG77LH/p832EvU3P3Q7TCh5mlrYZGEx9kaWS47sA4D/S51tXHFlVVwthd33E13LV//fiVQe1RECAaIOaIKv6LTmCNhkEIQk70y25vEUZlZDBtLcfOMlmOdLRjtCoik3n6XuozChsuUXN3iB3g9co6800BAo/TV+9JHzoxYPKdIpNovi0VN+88jrcWWhjtIirP7Rgf4UNIPqin7GDWgf9v6tQkVoG2/MX2Dw8ShOvzqsZt5lwRP2RDNu5yYKCF1iOu7BDs+mppJyuLOsjsnK+l+w5Gx3CxZjrWZbqDQ4hhp+u5qX6qjc5eC7sy+4S6tGlwn9QQqEoYSe4ToM52X7mji3352vphcqG91nGSceB+OOaezRE9AQ1/x/kR3ezyrwlnScSscpFLXg+CtDaoWqcuV5RyH4jDmcCXtYgTmjJvp2ROEIABFOTgLEr/E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?r7UH4JzNz4rfaouILfpPB7e6ZwFgJ0zsePq3VP9oCZJKkpMJfwmvbaygfW?=
 =?iso-8859-1?Q?TYc+YnY/fww4BwzXhWA8BuulObx8/cP6+KU4kDAB/Z9uvnkl7tLHc7SMaQ?=
 =?iso-8859-1?Q?2+ngZBjoy+v0C43ZlJ/Wcn1V/eX/w1eIcH0HBGdUG6rZWhUt9cI5LNPvH6?=
 =?iso-8859-1?Q?kGSpt4Lv1jkRhvVyk1jK9vlTcOCuyIviTcmDPN/QmG66ER9pz+f0HmjUBn?=
 =?iso-8859-1?Q?ByUj9B4ZhM2Eav6Hd+7B55rcsodfzBXm5UdLkNTpzrAFmBJEm79HU5sNS/?=
 =?iso-8859-1?Q?4BnuHSzGZmqm0/l8Rf1Kl+MxsVJ7FLlU5P0+uSYdTrdgE/nM2OGOxzeRKC?=
 =?iso-8859-1?Q?Zw8lXy9xCu6nf2J9/FlKmIV+y/v1WjWoBFl2vt9UvrdFIcKpSzFcziEg0Q?=
 =?iso-8859-1?Q?xZblqC2/jto3YazmSR3Asj7++xKx4LnazZlbY8f4HdkyZDxG8j4YJDoJit?=
 =?iso-8859-1?Q?I+rzyTYR6LON0+i2QsdgWfi56MNuU0g9ITvrzWrMxSFyDn3DkainBeTCvR?=
 =?iso-8859-1?Q?awJ04/+Uy/Iukrsr5h4VmpAGYVJFbImBYJgL7ou0uE7fSUHlBvs+9C3ma1?=
 =?iso-8859-1?Q?GKsS49qLXC46Z/GIlUsOeC6jys+2wvHyFouu+EuM4pfwXPANAkkwQKO/lv?=
 =?iso-8859-1?Q?gp8XCfrg20BnJab9oIY7J01KcBpiVaMRbnQ0CJYh1DDd8kFJ2ukP6Q0y3p?=
 =?iso-8859-1?Q?v5XC8Yu2wCEu8yhtCgPoAA0+6eJ21EQAjp3gpw7b1cjJmjtlNWvGIMEUFD?=
 =?iso-8859-1?Q?r64oY3Opmmm11zRoKMSvzgx1Qta0fnpAb+n6LS6jQBv+nafUYj2D82PnsM?=
 =?iso-8859-1?Q?5OnOQzqWAtJ8KsYmaiPVyHGCXbgYdAWJDSG8G06pvpxkizWCo1UsyyfEFz?=
 =?iso-8859-1?Q?xsW3f08Wmb3IvJjBiiwxxETcCBor+D4FSvwvLNu3WFc+TJMFXuEhtyRmi3?=
 =?iso-8859-1?Q?IoGrbf2EOHcBvsrcEoNguwHtLea9Of6eRqGn0rFgBTjZEJjndTCrF7cL5h?=
 =?iso-8859-1?Q?CtZM8Z3WEvmv38571/oXoBwx7wX96PYd6SnOr1zFbg7U8VAJyjYfGm4L0p?=
 =?iso-8859-1?Q?LoQ3YLMoPf5QRfPoXR+U1BvIRYDwj7SH0D78G44+kYu+wkkvZ/VhlaaFao?=
 =?iso-8859-1?Q?pt48kjExZ/GSKUwKkOHqSzhgnPOJyRcXF3EnJj0i63E7k7XUxsmdK36EPo?=
 =?iso-8859-1?Q?d8Bj1XYraRgiYRiqUKAkjf4JVUunWykoWU1TezgyGWG3m14stkPsDhp6jq?=
 =?iso-8859-1?Q?A+T4MsYWIpaOVgGuwkd/uDyEpriPoZlxOAvDpORfZWj3M4DrHCv5wA1Bj8?=
 =?iso-8859-1?Q?13IRRCtIg9jRUUjL+AI5jn//GkEEAi6TvaRmSWVe4nzr0I2utv3NpouM9L?=
 =?iso-8859-1?Q?ejvflCVR4iZBhwzvIvFebuTvdfMOUcTOBxy3eLiJ5Z4PcpXkwYLPXHXyct?=
 =?iso-8859-1?Q?5XLoVQshyNFua0POqt8tT9Je50zbVqlCZMtfJGjR99R3CvcBXl2MFGeNNa?=
 =?iso-8859-1?Q?3QrR8L1YZzhxKk+VHEb8J60WsYZTRXdyDTfThU60SmuWMfxXoK2A6WjUIk?=
 =?iso-8859-1?Q?G4oukMS7UrY1qadupRH5+m0dvKvoQvkqEz9HygxxoxLCI7qvmaQ338p4A+?=
 =?iso-8859-1?Q?HeFA82J7w6ZuskLkDKu2wTKm1xDOVD7DqY9jZI44eFVkju+5nI+y/sHQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f0a3bc-bf80-4383-c873-08dc3978107d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 22:45:01.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeZ7m2vKbgFy8vzUoI0QLO5f40Evp5vhIfNIZfTzbnLIgvpOgPmA7zAqvJdc1YqkFh6IwYY9hxfqozaDTK96kuOnMyTMOnYAe2CkuRktAko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11979

Hi Uwe,

Thanks for your feedback!

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Thursday, February 29, 2024 4:42 PM
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH v7 2/4] pwm: Add support for RZ/V2M PWM driver
>=20
> On Mon, Feb 12, 2024 at 09:06:50PM +0000, Fabrizio Castro wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > The RZ/V2{M, MA} PWM Timer supports the following functions:
> >
> >  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
> >  * The frequency division ratio for internal counter operation is
> >    selectable as PWM_CLK divided by 1, 16, 256, or 2048.
> >  * The period as well as the duty cycle is adjustable.
> >  * The low-level and high-level order of the PWM signals can be
> >    inverted.
> >  * The duty cycle of the PWM signal is selectable in the range from
> >    0 to 100%.
> >  * The minimum resolution is 20.83 ns.
> >  * Three interrupt sources: Rising and falling edges of the PWM signal
> >    and clearing of the counter
> >  * Counter operation and the bus interface are asynchronous and both
> >    can operate independently of the magnitude relationship of the
> >    respective clock periods.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >
> > v6->v7:
> >  * Addressed the build issue reported by the kernel test robot.
> >  * Added include math64.h.
> >  * Reworked rzv2m_pwm_mul_u64_u64_div_u64_roundup to make use of
> >    div64_u64 and to get rid of % while keeping the same formula.
> >  * Added rzv2m_pwm_mul_u64_u64_div_u64_rounddown.
> >  * Replaced / with div64_u64 wherever necessary.
> > v5->v6:
> >  * Added Fab's Signed-off-by.
> >  * Updated copyright year to 2024.
> >  * Added include of limits.h.
> >  * Added variable max_period to rzv2m_pwm_chip.
> >  * Simplified the calculations by calculating max_period during probe,
> >    based on the numerical limits of the formula and the u64 data type.
> >  * Added rzv2m_pwm_mul_u64_u64_div_u64_roundup.
> >  * Added rzv2m_pwm_prescale_to_shift to fix the calculation of the
> >    frequency divider.
> >  * Improved the calculations and the variable names of
> >    rzv2m_pwm_get_state.
> >  * Improved the calculations of rzv2m_pwm_config.
> >  * Removed .owner from rzv2m_pwm_ops.
> >  * Improved rzv2m_pwm_pm_runtime_resume and renamed its err variable to
> >    ret.
> >  * Removed of_match_ptr.
> >  * Added Fab as module author.
> > v4->v5:
> >  * Sorted KConfig file
> >  * Sorted Make file
> >  * Updated copyright header 2022->2023.
> >  * Updated limitation section.
> >  * Replaced the variable chip->rzv2m_pwm in rzv2m_pwm_wait_delay()
> >  * Replaced polarity logic as per HW manual dutycycle =3D Ton/Ton+Toff,=
 so
> >    eventhough native polarity is inverted from period point of view it
> >    is correct.
> >  * Added logic for supporting 0% , 100% and remaining duty cycle.
> >  * On config() replaced
> >    pm_runtime_resume_and_get()->pm_runtime_get_sync()
> >  * Counter is stopped while updating period/polarity to avoid glitches.
> >  * Added error check for clk_prepare_enable()
> >  * Introduced is_ch_enabled variable to cache channel enable status.
> >  * clk_get_rate is called after enabling the clock and
> >    clk_rate_exclusive_get()
> >  * Added comment for delay
> >  * Replaced 1000000000UL->NSEC_PER_SEC.
> >  * Improved error handling in probe().
> > v3->v4:
> >  * Documented the hardware properties in "Limitations" section
> >  * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
> >  * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
> >  * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i)
> >    for calculating divider as it is power of 16.
> >  * Reordered the functions to have rzv2m_pwm_config() directly before
> >    rzv2m_pwm_apply().
> >  * Improved the logic for calculating period and duty cycle in config()
> >  * Merged multiple RZV2M_PWMCTR register writes to a single write in
> >  * config()
> >  * replaced pwm_is_enabled()->pwm->state.enabled
> >  * Avoided assigning bit value as enum pwm_polarity instead used enum
> >  * constant.
> >  * Fixed various issues in probe error path.
> >  * Updated the logic for PWM cycle setting register
> >  * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So
> >    restricting PWMCYC values < 0xffffff
> >  * The native polarity of the hardware is inverted (i.e. it starts with
> >    the low part). So switched the inversion bit handling.
> > v2->v3:
> >  * Added return code for rzv2m_pwm_get_state()
> >  * Added comment in rzv2m_pwm_reset_assert_pm_disable()
> > v1->v2:
> >  * Replaced
> >    devm_reset_control_get_optional_shared->devm_reset_control_get_share=
d
> >
> >  drivers/pwm/Kconfig     |  11 +
> >  drivers/pwm/Makefile    |   1 +
> >  drivers/pwm/pwm-rzv2m.c | 480 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 492 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rzv2m.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 4b956d661755..55d46e6183a2 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -524,6 +524,17 @@ config PWM_RZ_MTU3
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-rz-mtu3.
> >
> > +config PWM_RZV2M
> > +       tristate "Renesas RZ/V2M PWM support"
> > +       depends on ARCH_R9A09G011 || COMPILE_TEST
> > +       depends on HAS_IOMEM
> > +       help
> > +         This driver exposes the PWM controller found in Renesas
> > +         RZ/V2M like chips through the PWM API.
> > +
> > +         To compile this driver as a module, choose M here: the module
> > +         will be called pwm-rzv2m.
> > +
> >  config PWM_SAMSUNG
> >  	tristate "Samsung PWM support"
> >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index c5ec9e168ee7..cf5a4a1c3b1a 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> > +obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rzv2m.c b/drivers/pwm/pwm-rzv2m.c
> > new file mode 100644
> > index 000000000000..eb9062293590
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rzv2m.c
> > @@ -0,0 +1,480 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/V2M PWM Timer (PWM) driver
> > + *
> > + * Copyright (C) 2024 Renesas Electronics Corporation
> > + *
> > + * Hardware manual for this IP can be found here
> > + * https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-
> hardware?language=3Den
> > + *
> > + * Limitations:
> > + * - Changes to the duty cycle configuration get effective only after
> the next
> > + *   period end.
> > +=A0* - The duty cycle can be changed only by modifying the PWMLOW regi=
ster
> > +=A0* =A0 value and changing the pulse width at low level. The duty cyc=
le
> becomes
> > +=A0* =A0 0% for the low width when the value of the PWMLOW register is=
 0x0h
> > +=A0* =A0 and 100% for the low width when the value of the PWMLOW > PWM=
CYC.
>=20
> If polarity or period is changed, the hardware has to be stopped, to
> this yields glitches.

Thanks for the suggestion, I'll add it.

>=20
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/limits.h>
> > +#include <linux/math64.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pwm.h>
> > +#include <linux/reset.h>
> > +#include <linux/time.h>
> > +
> > +#define RZV2M_PWMCTR	0x0
> > +#define RZV2M_PWMCYC	0x4
> > +#define RZV2M_PWMLOW	0x8
> > +#define RZV2M_PWMCNT	0xc
> > +
> > +#define RZV2M_PWMCTR_PWMPS	GENMASK(17, 16)
> > +#define RZV2M_PWMCTR_PWMHL	BIT(3)
> > +#define RZV2M_PWMCTR_PWMTM	BIT(2)
> > +#define RZV2M_PWMCTR_PWME	BIT(1)
> > +
> > +#define RZV2M_PWMCYC_PERIOD	GENMASK(23, 0)
> > +#define RZV2M_PWMLOW_PERIOD	GENMASK(23, 0)
> > +
> > +struct rzv2m_pwm_chip {
> > +	u64 max_period;
> > +	struct pwm_chip chip;
> > +	void __iomem *mmio;
> > +	struct reset_control *rstc;
> > +	struct clk *apb_clk;
> > +	struct clk *pwm_clk;
> > +	unsigned long rate;
> > +	unsigned long delay;
> > +	unsigned long pwm_cyc;
> > +	enum pwm_polarity polarity;
> > +	bool is_ch_enabled;
> > +};
> > +
> > +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b,
> u64 c)
> > +{
> > +	u64 ab =3D a * b;
>=20
> a * b might overflow?!

In the context of this driver, this cannot overflow.
The 2 formulas the above is needed for are:
1) period =3D (cyc + 1)*(NSEC_PER_SEC * frequency_divisor)/rate
2) duty_cycle =3D (cyc + 1 - low)*(NSEC_PER_SEC * frequency_divisor)/rate

With respect to 1), the dividend overflows when period * rate also
overflows (its product is calculated in rzv2m_pwm_config).
However, limiting the period to a maximum value of U64_MAX / rate
prevents the calculations from overflowing (in both directions, from period=
 to cyc, and from cyc to period). v6 introduced max_period for this.
The situation for 2) is very similar to 1), with duty_cycle<=3Dperiod,
therefore limiting period to a max value (and clamping the duty cycle
accordingly) will ensure that the calculation for duty_cycle won't
overflow, either.

>=20
> > +	u64 d =3D div64_u64(ab, c);
> > +	u64 e =3D d * c;
> > +
> > +	return d + ((ab - e) ? 1 : 0);
> > +}
> > +
> > +static inline u64 rzv2m_pwm_mul_u64_u64_div_u64_rounddown(u64 a, u64 b=
,
> u64 c)
> > +{
> > +	return div64_u64(a * b, c);
>=20
> ditto. This is the same function as mul_u64_u64_div_u64() isn't it?

Since a * b cannot overflow in the case of this driver, I believe the
above to be a better option than mul_u64_u64_div_u64.

>=20
> > +}
> > +
> > +static inline struct rzv2m_pwm_chip *to_rzv2m_pwm_chip(struct pwm_chip
> *chip)
> > +{
> > +	return container_of(chip, struct rzv2m_pwm_chip, chip);
> > +}
> > +
> > +static void rzv2m_pwm_wait_delay(struct rzv2m_pwm_chip *rzv2m_pwm)
> > +{
> > +	/* delay timer when change the setting register */
> > +	ndelay(rzv2m_pwm->delay);
> > +}
> > +
> > +static void rzv2m_pwm_write(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg,
> u32 data)
> > +{
> > +	writel(data, rzv2m_pwm->mmio + reg);
> > +}
> > +
> > +static u32 rzv2m_pwm_read(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg)
> > +{
> > +	return readl(rzv2m_pwm->mmio + reg);
> > +}
> > +
> > +static void rzv2m_pwm_modify(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg=
,
> u32 clr,
> > +			     u32 set)
> > +{
> > +	rzv2m_pwm_write(rzv2m_pwm, reg,
> > +			(rzv2m_pwm_read(rzv2m_pwm, reg) & ~clr) | set);
> > +}
> > +
> > +static u8 rzv2m_pwm_calculate_prescale(struct rzv2m_pwm_chip *rzv2m_pw=
m,
> > +				       u64 period_cycles)
> > +{
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 24;
> > +	if (prescaled_period_cycles >=3D 256)
> > +		prescale =3D 3;
> > +	else
> > +		prescale =3D (fls(prescaled_period_cycles) + 3) / 4;
> > +
> > +	return prescale;
> > +}
> > +
> > +static inline int rzv2m_pwm_prescale_to_shift(u8 prescale)
> > +{
> > +	return prescale =3D=3D 3 ? 11 : prescale * 4;
> > +}
> > +
> > +static int rzv2m_pwm_enable(struct rzv2m_pwm_chip *rzv2m_pwm)
> > +{
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> > +			 RZV2M_PWMCTR_PWME);
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +	rzv2m_pwm->is_ch_enabled =3D true;
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzv2m_pwm_disable(struct rzv2m_pwm_chip *rzv2m_pwm)
> > +{
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +	pm_runtime_put_sync(rzv2m_pwm->chip.dev);
> > +	rzv2m_pwm->is_ch_enabled =3D false;
> > +}
> > +
> > +static int rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e
> *pwm,
> > +			       struct pwm_state *state)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> > +	u16 frequency_divisor;
> > +	u32 ctr, cyc, low;
> > +	u8 prescale;
> > +
> > +	pm_runtime_get_sync(chip->dev);
> > +	ctr =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
> > +	state->enabled =3D FIELD_GET(RZV2M_PWMCTR_PWME, ctr);
> > +	state->polarity =3D FIELD_GET(RZV2M_PWMCTR_PWMHL, ctr) ?
> > +		PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	prescale =3D FIELD_GET(RZV2M_PWMCTR_PWMPS, ctr);
> > +	frequency_divisor =3D 1 << rzv2m_pwm_prescale_to_shift(prescale);
>=20
> Giving a shift is cheaper than a multiplication, I suggest to do
>=20
> 	frequency_divisor =3D rzv2m_pwm_prescale_to_shift(prescale);
>=20
> and instead of multiply by frequency_divisor, use a left-shift
> operation.

Will do, thanks for the suggestion.

>=20
> > +	cyc =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
> > +	state->period =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc + 1,
> > +				NSEC_PER_SEC * frequency_divisor,
> > +				rzv2m_pwm->rate);
> > +
> > +	low =3D rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
> > +	state->duty_cycle =3D rzv2m_pwm_mul_u64_u64_div_u64_roundup(cyc + 1 -
> low,
> > +				NSEC_PER_SEC * frequency_divisor,
> > +				rzv2m_pwm->rate);
>=20
> The register semantic makes me wonder if each period starts with the low
> part. In that case the hardware called "normal" what is called inverted
> in the pwm framework?!

My understanding is that the PWM framework defines "normal" polarity a
signal that starts high (and stays high) for the duration of the duty cycle=
,
and goes low for the remainder of the period. Conversely, a signal with
"inversed" polarity starts low (and stays low) for the duration of the duty
cycle and goes high for the remainder of the period.

This IP _does_ start low, but it _doesn't_ stay low for the duration of the
duty cycle, as it then goes high for the duration of the duty cycle,
therefore this IP doesn't perfectly fit either ("normal" or "inverted")
definitions.
I think you can say that the "normal" signal is _shifted_ in phase for this
IP, rather than being "inverted".

>=20
> > +	return pm_runtime_put(chip->dev);
>=20
> If you evaluate the return value of pm_runtime_put() maybe check
> pm_runtime_get_sync() for symmetry, too?

Or I could just discard it and return 0?
I am fine with either, what's your preference?

>=20
> > +}
> > +
> > +static int rzv2m_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> > +	u64 period =3D state->period, duty_cycle =3D state->duty_cycle;
> > +	u16 frequency_divisor;
> > +	u64 pwm_cyc, pwm_low;
> > +	u8 prescale;
> > +	u32 pwm_ctr;
> > +
> > +	/*
> > +	 * Clamp period and duty cycle to their maximum values for our
> current
> > +	 * configuration rather than letting our calculations overflow.
> > +	 */
> > +	if (period > rzv2m_pwm->max_period) {
> > +		period =3D rzv2m_pwm->max_period;
> > +		if (duty_cycle > rzv2m_pwm->max_period)
> > +			duty_cycle =3D period;
> > +	}
> > +
> > +	/*
> > +	 * Formula for calculating PWM Cycle Setting Register:
> > +	 * PWM cycle =3D (PWM period(ns) / (PWM_CLK period(ns) =D7 Div ratio)=
) -
> 1
> > +	 */
> > +	pwm_cyc =3D rzv2m_pwm_mul_u64_u64_div_u64_rounddown(period,
> > +							  rzv2m_pwm->rate,
> > +							  NSEC_PER_SEC);
> > +	pwm_cyc =3D pwm_cyc ? pwm_cyc : 1;
>=20
> if pwm_cyc is 0 here, the period is too short to be realized, right?
> That's an error condition.

I will return an error instead.

>=20
> > +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pwm_cyc - 1);
> > +	frequency_divisor =3D 1 << rzv2m_pwm_prescale_to_shift(prescale);
> > +	if (frequency_divisor > 1) {
> > +		pwm_cyc =3D rzv2m_pwm_mul_u64_u64_div_u64_rounddown(period,
> > +				rzv2m_pwm->rate,
> > +				NSEC_PER_SEC * frequency_divisor);
> > +		pwm_cyc =3D pwm_cyc ? pwm_cyc : 1;
> > +	}
> > +
> > +	if (pwm_cyc && !FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc - 1))
> > +		pwm_cyc =3D RZV2M_PWMCYC_PERIOD + 1;
>=20
> I don't understand the relevance of FIELD_FIT(RZV2M_PWMCYC_PERIOD,
> pwm_cyc - 1).

CYC is only made of 24 bits, therefore this is to make sure we don't
go beyond a 24-bit representation.

>=20
> > +
> > +	/*
> > +	 * Formula for calculating PWMLOW register:
> > +	 * PWMLOW register =3D PWM cycle * Low pulse width ratio (%)
> > +	 */
> > +	pwm_low =3D rzv2m_pwm_mul_u64_u64_div_u64_rounddown(duty_cycle,
> > +			rzv2m_pwm->rate, NSEC_PER_SEC * frequency_divisor);
> > +
> > +	pwm_low =3D pwm_cyc - pwm_low;
>=20
> Either the old or the new value of pwm_low doesn't match the variable's
> name. Please add another variable for the wrong one. The compiler should
> optimize that out and the reader can more easily understand the code.

You are right, I'll use an intermediate variable rather than leveraging
pwm_low, as it's confusing.

>=20
> > +	if (!FIELD_FIT(RZV2M_PWMLOW_PERIOD, pwm_low))
> > +		pwm_low =3D RZV2M_PWMLOW_PERIOD;
> > +
> > +	pwm_cyc--;
> > +
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_get_sync(rzv2m_pwm->chip.dev);
> > +
> > +	/*
> > +	 * To change the setting value of the PWM cycle setting register
> > +	 * (PWMm_PWMCYC) or polarity, set the PWME bit of the PWM control
> > +	 * register (PWMm_PWMCTR) to 0b and stop the counter operation.
> > +	 */
> > +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=
=3D
> pwm_cyc) {
> > +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> 0);
> > +		rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +	}
> > +
> > +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
> > +	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
> > +
> > +	pwm_ctr =3D FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale);
> > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > +		pwm_ctr |=3D RZV2M_PWMCTR_PWMHL;
> > +
> > +	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM |
> > +			 RZV2M_PWMCTR_PWMPS | RZV2M_PWMCTR_PWMHL, pwm_ctr);
> > +
> > +	if (rzv2m_pwm->polarity !=3D state->polarity || rzv2m_pwm->pwm_cyc !=
=3D
> pwm_cyc) {
> > +		rzv2m_pwm->polarity =3D state->polarity;
> > +		rzv2m_pwm->pwm_cyc =3D pwm_cyc;
> > +		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
> > +				 RZV2M_PWMCTR_PWME);
> > +	}
> > +
> > +	rzv2m_pwm_wait_delay(rzv2m_pwm);
> > +
> > +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_put(rzv2m_pwm->chip.dev);
> > +
> > +	return 0;
> > +}
> > [...]
> > +static int rzv2m_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm;
> > +	unsigned long apb_clk_rate;
> > +	int ret;
> > +
> > +	rzv2m_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2m_pwm), GFP_KERNEL=
);
> > +	if (!rzv2m_pwm)
> > +		return -ENOMEM;
> > +
> > +	rzv2m_pwm->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rzv2m_pwm->mmio))
> > +		return PTR_ERR(rzv2m_pwm->mmio);
> > +
> > +	rzv2m_pwm->apb_clk =3D devm_clk_get(&pdev->dev, "apb");
> > +	if (IS_ERR(rzv2m_pwm->apb_clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->apb_clk),
> > +				     "cannot get apb clock\n");
> > +
> > +	rzv2m_pwm->pwm_clk =3D devm_clk_get(&pdev->dev, "pwm");
> > +	if (IS_ERR(rzv2m_pwm->pwm_clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->pwm_clk),
> > +				     "cannot get pwm clock\n");
> > +
> > +	rzv2m_pwm->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> > +	if (IS_ERR(rzv2m_pwm->rstc))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->rstc),
> > +				     "get reset failed\n");
> > +
> > +	platform_set_drvdata(pdev, rzv2m_pwm);
> > +	ret =3D reset_control_deassert(rzv2m_pwm->rstc);
> > +	if (ret) {
> > +		return dev_err_probe(&pdev->dev, ret,
> > +			      "cannot deassert reset control\n");
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(rzv2m_pwm->apb_clk);
> > +	if (ret < 0)
> > +		goto err_reset;
> > +
> > +	ret =3D clk_prepare_enable(rzv2m_pwm->pwm_clk);
> > +	if (ret < 0)
> > +		goto disable_apb_clk;
> > +
> > +	clk_rate_exclusive_get(rzv2m_pwm->apb_clk);
>=20
> There is a devm_clk_rate_exclusive_get() in next starting from tomorrow
> I hope. Using it should simplify the driver.

I'll have a look and adjust accordingly.

Thanks!

Cheers,
Fab

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

