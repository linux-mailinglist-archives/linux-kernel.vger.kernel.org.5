Return-Path: <linux-kernel+bounces-126070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1038931B5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187061F2140D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86790144D21;
	Sun, 31 Mar 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZAcQoKbt"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2099.outbound.protection.outlook.com [40.107.15.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0C1448FF;
	Sun, 31 Mar 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711891716; cv=fail; b=ZoNkargavxBXKL/MZYrpmVtsr/XH5t2Xz/CCukFo1nszXy/mW4L4NngQZ+MnIDT754MomCe1Q6kngW5LVj2zhDP6EzgJIQWOib/ivAzt7g/hAbWeaDoNO5Zy8vlwQfEeb4u3d+ZH8pIrdDlDOnLrMUv3qJjuBgowLp9WMsHJ2cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711891716; c=relaxed/simple;
	bh=Dj+2c+4EoxS/ZIcxCOr+MfSIGDHToIta6D6yitIh+io=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Im2Rmdpi2WzozmJZtXZZHHULVguTTi3Sj6+rYKcHYtH3XWX1h0r7N1zAUJwsy9nM3mYEDWZdTpFOh/Qp1muO8Rbz6c12dxZmM1oQoczAnAdVIpL4Y0jNDK1pkl8xfiyAMZpHXBL1c0TfnqAR4LEHrSLbCQ+5nONeBbyXqBKKWfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZAcQoKbt; arc=fail smtp.client-ip=40.107.15.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADL1JZkxNfCbtx9USbib4/hnW+UKNqAk1iX6nnPSLzfZxIbtAWxqMM4c18JmjXwIX/bEpbdzkWES3sS/KkX3kxNUoK4DHLp/4JBhZ2A7yyp/ZTztpzHU/5CAb2YUEGL4RcVfNT1whacnzzwCyYNpSdVTUSKq7ZALG2vB05PjxYgYAYQQiH9kHYgsQgmnPPNsaDLHesgewNyHFcVE7IaE783EBOUr6D5pvFwBBS2Qw3pA6emPpkOazbx3Gy5bcNoKdLqm8f+ENyEhgE5Lv9K0iKQhDG+4z0/JiKKhBJaUw4FQ1PEkvupfO6FhiEURJACVUNJSwzP4PlDQeFuqMTzDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmjS8TheTXy1A9t5v0+NfsWVqXZkqlxffplJ8QS/2ms=;
 b=J09PZjQTFq4owi/Xx4J6V2dfKbfA3gW3wKSa26LCW8PdpvZtHRGrfe+4GMiLKtP3Dj+d59yXTui57dAid08602/CvUkD1JV9en2Z3iEDHFBs5ICSxjzTlF+fS6Ixh5QhBm/zLDUO413Wwp5VIeiq3eSvC3rOwIXitKH1PlrleOi8YjDwkh4RE6SmrfH0wqE3dFMCWRY5wq5+806gEs2i0ZwRHeY4K5l5fT58ZjbR2ckyNQADOw4AO8kzRwartCSidTWv0rFlfN74OVvWpt8fMpNoCP8NVIDG7QqttWbqOyr16HLtqGECnkHtrlcssjNSROGVAsPWrnYo7r8n+/Yugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmjS8TheTXy1A9t5v0+NfsWVqXZkqlxffplJ8QS/2ms=;
 b=ZAcQoKbtzeZSx4tmkPQsozYCUm2HChwlF68bdZ17xTy3xYfB+TDn/uUNK5olTSHocmwceaga9f2GxcBzxhnEhor3ocRGPmIZ+IRZAVRi4BdatOQmL1Xw9bLYiK49QiuORxVLVbM830Vtc1OpjgNyItMNjvMqw8ZYrjkp6ZrfXu8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9574.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sun, 31 Mar
 2024 13:28:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 31 Mar 2024
 13:28:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHafRqyofu9Mu9OLUiaociI+9q/i7FNVDSAgASFEaA=
Date: Sun, 31 Mar 2024 13:28:29 +0000
Message-ID:
 <DU0PR04MB9417A207075904F8AFBFBDD288382@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com> <ZgWRA2V3PF_q9yRM@pluto>
In-Reply-To: <ZgWRA2V3PF_q9yRM@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9574:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ts7OBr7qUqARfuhQrXR9U/2zDDuEVRc0YaGodRp1qUGB3QCemMJL5LNL+z3MI/4LPpgXahfxAyd1gcRIIEmNzmHbf0PSFp8xg338EDYI6RxkPDYU14HINIvpPo9Hz39Co8w+lbrPawekLpbaj/F1akhLUhzE9FHh/takyEmxmJSl+UE2I8by/D98hDSCQdZCCuK639BGULwR3Nnu+D9tuIoBRC8IoURZGnG6HUxtJNzaEfrKD5euW4iI+/AZwcs1GMOv4Po5ts+XkZaxnDQkAEJugsF3DxSXsExvracdhJFf3C2YAOly9mAMUGk9T5I9A54tRiK5rW9uz3vOCXHTOeOCMwNNcxFbq9QxJZhyuKzBY1ftPLDECL22AXbT8c60qHpEoPb5LzO/pN1OrmD9YFYobkeJcBEYonqm2U38i5bDOv3u3A4Se+KpXtIGfdPOufA7uwXLQ5Mc2gKt38XjPIDzDwE9fI+J8vG9zSAy1tBUdj3FIYjMAKomZrKpQA5fMak4BnOFCBdZeRqYifABXNpOhSXSXkI0XqgZ7cnUpDbm2y8pIlxgzJ6CGI3WQW04MI0INiAVZpnISIKBmYEtTVTNt2BoEoszlXxIXMTpwUOFjaAusO01fmTkTyyKZa7nKxUYiPEv2xiAh5GeWw0hi2l2MUac5yPDnNJx+HEIu+M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P+8X2v4ja3nZX51UG5tffB4Mfv6VsizRRoVehUdBwp+Ro/xTiDMyg+QcEZP7?=
 =?us-ascii?Q?7molYaE4zRK1Ht1DZbfX2cWSKiXm6c2eTr4sYBULOsEmaTgFEPigVwAjWKNN?=
 =?us-ascii?Q?4XajzyfLk7SaFmtcviakXIlyAg0uSeKSUsZt3I+1tj0HeV+ArIlgJQKdIT2S?=
 =?us-ascii?Q?SVq4FRpa3cc+w6fSHQTn1uy6L5oLeOPCuXeWfJcUiUSZYfLglpEM4qyr/00j?=
 =?us-ascii?Q?NjDdsf6W5LEIQWOOETjKsmbpWTyOl95aRFHAbKn2Rb3S75P+LxGG6N0KhxTF?=
 =?us-ascii?Q?lv0gUbfq5Kr7D8gXZmnKadHwCmrbaOMJmFobi0ut/WL7fc0OMeXRGHtj6BMz?=
 =?us-ascii?Q?ncJocAmeRezg0J2AkUDCW+3jFyvTDfeRoQ1n0YeIemgB3+v+4f9jRkA4gfcB?=
 =?us-ascii?Q?px5fYZhkruULyS++ibjlZ0s/kF4exTpFMso2Q0LC1lXx5OTZuqnYwKMfrBJe?=
 =?us-ascii?Q?I5xQ3aey6W2fHkNH4bgrL6NDSpiZldXae/+Ss1cP2IUGV+xjqaiqWdm7teXG?=
 =?us-ascii?Q?soXs0i9dE1Uxeoep8t2yRnZVfAvkCK4e6dkTgI2jfSoTalzDkESNjahbbCOL?=
 =?us-ascii?Q?xJ3MMeObfhEMA08S5JFwv5wEl86I9oSE1tLIEemnJvzOaDOzMFsmC6F6XKcQ?=
 =?us-ascii?Q?BAZGBjuXcKUxwUa0+TbBcKW/sFbhIV8ZEQwXAt+S2+0L1Exs0Dii0gSVhz3S?=
 =?us-ascii?Q?/30SOpT/n4tQdxzk36Y5Rl2PYxcYiEjX0uPQOTjQRspYGWdh+cVvcMeTXXNm?=
 =?us-ascii?Q?RvHYic9f9SvSUzQM+j/mO6z26DVBH6XWk/KHBo87YAZXlfPhhGHhe7iaJqrL?=
 =?us-ascii?Q?ecoSlp3mCsRWmUpup2OTPD7RO4loiuZHskkVpsO0sDDQFgpasgKe9guru1N/?=
 =?us-ascii?Q?edcNp+TXO4UQLH+atbEbKr29D54ojrrw5s8uMFo8utSlOU+X0SX9vk+nWbIL?=
 =?us-ascii?Q?jld8HqqFWcPGPLWvsHq58GWaNUXQNPnpw070dA+I7B67ziWQ+tKHB19z1P1s?=
 =?us-ascii?Q?VaidLE3KIdNd5dVwrkNvvtH8pOg5HYgfA51pDTdtLzKfaKNohIA32/jrBIv7?=
 =?us-ascii?Q?ocuX8I9X0aX1sbhfJpv8HN9wpsMKzNCPppwQTMY/ioCph1WlqIg0Voa1HEYe?=
 =?us-ascii?Q?5jE3Ij1mDIUiH5TFYvUqwURC/Su8llsvXTC9Hz7EBvZSk839+zisiPlJf+ef?=
 =?us-ascii?Q?v/eu+8QLOh1JlN7E4nLawCgPJ8XP9l/YiVu2L26difqSeBltkT7SoZcEKU+l?=
 =?us-ascii?Q?aKJIsp5MfLtHHyZXCa5cCF1FSZHhw1UZtrJWVLW3Uh5ofOQwcNTlfEdwBuXD?=
 =?us-ascii?Q?KA2rOeSEmjgz5FWbBS6Ig41rlJUsrAZeBxDUQac5pRl4RPLi0J4UuFnlqG/l?=
 =?us-ascii?Q?6oMtBtoNy4og1l51Jup0ErcDZtUFHwdKms68QNjwIDSKhGgOBXqy5rSLjCGP?=
 =?us-ascii?Q?Hsq61Hw6hBWNgsGml6wtQgJsRkObtzOOBDwhWSPAOvG9o2DTqF8oWVQU4ZTZ?=
 =?us-ascii?Q?G3aDDx9iiMKjYb4ZUaRGMYnGQ4zQEzaFPxni1VQQuiYl3mzQQkhIXL+dt/8e?=
 =?us-ascii?Q?zCkfueefwNEU5qM/Ae4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15c1f5d-4cb2-40df-3248-08dc51867439
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 13:28:29.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJIHm81LJtNK1gw5YotmyJhuDJYabTG/nVgwU4SA/NDoJa7bF26YsY1aLZl8L3hn1NaTk1c44amw5gTVsNLEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9574

Hi Cristian,

> Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> On Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add basic implementation of the SCMI v3.2 pincontrol protocol.
> >
>=20
> Hi,
>=20
> a few more comments down below...
>=20
> > Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/Makefile    |   1 +
> >  drivers/firmware/arm_scmi/driver.c    |   2 +
> >  drivers/firmware/arm_scmi/pinctrl.c   | 921
> ++++++++++++++++++++++++++++++++++
> >  drivers/firmware/arm_scmi/protocols.h |   1 +
> >  include/linux/scmi_protocol.h         |  75 +++
> >  5 files changed, 1000 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/Makefile
> > b/drivers/firmware/arm_scmi/Makefile
> > index a7bc4796519c..8e3874ff1544 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) +=3D
> msg.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) +=3D virtio.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> > scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o
> > system.o voltage.o powercap.o
> > +scmi-protocols-y +=3D pinctrl.o
> >  scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y)
> > $(scmi-transport-y)
> >
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o diff --git
> > a/drivers/firmware/arm_scmi/driver.c
> > b/drivers/firmware/arm_scmi/driver.c
> > index 415e6f510057..ac2d4b19727c 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -3142,6 +3142,7 @@ static int __init scmi_driver_init(void)
> >  	scmi_voltage_register();
> >  	scmi_system_register();
> >  	scmi_powercap_register();
> > +	scmi_pinctrl_register();
> >
> >  	return platform_driver_register(&scmi_driver);
> >  }
> > @@ -3159,6 +3160,7 @@ static void __exit scmi_driver_exit(void)
> >  	scmi_voltage_unregister();
> >  	scmi_system_unregister();
> >  	scmi_powercap_unregister();
> > +	scmi_pinctrl_unregister();
> >
> >  	scmi_transports_exit();
> >
> > diff --git a/drivers/firmware/arm_scmi/pinctrl.c
> > b/drivers/firmware/arm_scmi/pinctrl.c
> > new file mode 100644
> > index 000000000000..87d9b89cab13
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/pinctrl.c
> > @@ -0,0 +1,921 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * System Control and Management Interface (SCMI) Pinctrl Protocol
> > + *
> > + * Copyright (C) 2024 EPAM
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
> > +
> > +#include "common.h"
> > +#include "protocols.h"
> > +
> > +/* Updated only after ALL the mandatory features for that version are
> merged */
> > +#define SCMI_PROTOCOL_SUPPORTED_VERSION                0x0
> > +
>=20
> AFAICS, the only missing things are PINCTRL_SET_PERMISSIONS (optional
> command)=20

I not see users as of now, could we add it until we need it?

and the multiple-configs on SETTINGS_GET, but this latter is
> something really that we have to ask for in the request AND we did not as=
 of
> now since we dont need it...so I would say to bump the version to 0x10000

ok.

> just to avoid needless warning as soon as a server supporting Pinctrl is =
met.
>=20
> > +#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
> > +#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
> > +#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> > +
> > +#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
> > +#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
> > +
> > +#define REMAINING(x)		le32_get_bits((x), GENMASK(31,
> 16))
> > +#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
> > +
> > +#define CONFIG_FLAG_MASK	GENMASK(19, 18)
> > +#define SELECTOR_MASK		GENMASK(17, 16)
> > +#define SKIP_CONFIGS_MASK	GENMASK(15, 8)
> > +#define CONFIG_TYPE_MASK	GENMASK(7, 0)
> > +
> > +enum scmi_pinctrl_protocol_cmd {
> > +	PINCTRL_ATTRIBUTES =3D 0x3,
> > +	PINCTRL_LIST_ASSOCIATIONS =3D 0x4,
> > +	PINCTRL_SETTINGS_GET =3D 0x5,
> > +	PINCTRL_SETTINGS_CONFIGURE =3D 0x6,
> > +	PINCTRL_REQUEST =3D 0x7,
> > +	PINCTRL_RELEASE =3D 0x8,
> > +	PINCTRL_NAME_GET =3D 0x9,
> > +	PINCTRL_SET_PERMISSIONS =3D 0xa
> > +};
> > +
> > +struct scmi_msg_settings_conf {
> > +	__le32 identifier;
> > +	__le32 function_id;
> > +	__le32 attributes;
> > +	__le32 configs[];
> > +};
> > +
> > +struct scmi_msg_settings_get {
> > +	__le32 identifier;
> > +	__le32 attributes;
> > +};
> > +
> > +struct scmi_resp_settings_get {
> > +	__le32 function_selected;
> > +	__le32 num_configs;
> > +	__le32 configs[];
> > +};
> > +
> > +struct scmi_msg_pinctrl_protocol_attributes {
> > +	__le32 attributes_low;
> > +	__le32 attributes_high;
> > +};
> > +
> > +struct scmi_msg_pinctrl_attributes {
> > +	__le32 identifier;
> > +	__le32 flags;
> > +};
> > +
> > +struct scmi_resp_pinctrl_attributes {
> > +	__le32 attributes;
> > +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> > +};
> > +
> > +struct scmi_msg_pinctrl_list_assoc {
> > +	__le32 identifier;
> > +	__le32 flags;
> > +	__le32 index;
> > +};
> > +
> > +struct scmi_resp_pinctrl_list_assoc {
> > +	__le32 flags;
> > +	__le16 array[];
> > +};
> > +
> > +struct scmi_msg_func_set {
> > +	__le32 identifier;
> > +	__le32 function_id;
> > +	__le32 flags;
> > +};
> > +
>=20
> As said by Dan...drop this.
>=20
> > +struct scmi_msg_request {
> > +	__le32 identifier;
> > +	__le32 flags;
> > +};
> > +
> > +struct scmi_group_info {
> > +	char name[SCMI_MAX_STR_SIZE];
> > +	bool present;
> > +	u32 *group_pins;
> > +	u32 nr_pins;
> > +};
> > +
> > +struct scmi_function_info {
> > +	char name[SCMI_MAX_STR_SIZE];
> > +	bool present;
> > +	u32 *groups;
> > +	u32 nr_groups;
> > +};
> > +
> > +struct scmi_pin_info {
> > +	char name[SCMI_MAX_STR_SIZE];
> > +	bool present;
> > +};
> > +
> > +struct scmi_pinctrl_info {
> > +	u32 version;
> > +	int nr_groups;
> > +	int nr_functions;
> > +	int nr_pins;
> > +	struct scmi_group_info *groups;
> > +	struct scmi_function_info *functions;
> > +	struct scmi_pin_info *pins;
> > +};
> > +
> > +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_hand=
le
> *ph,
> > +				       struct scmi_pinctrl_info *pi) {
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> sizeof(*attr),
> > +				      &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr =3D t->rx.buf;
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		pi->nr_functions =3D GET_FUNCTIONS_NR(attr-
> >attributes_high);
> > +		pi->nr_groups =3D GET_GROUPS_NR(attr->attributes_low);
> > +		pi->nr_pins =3D GET_PINS_NR(attr->attributes_low);
>=20
> I was thinking, does make sense to allow a nr_pins =3D=3D 0 setup to prob=
e
> successfully ? Becasuse is legit for the platform to return zero groups o=
r zero
> functions BUT zero pins is just useless (spec does not say
> anything)
>=20
> Maybe you could just put a dev_warn() here on if (nr_pins =3D=3D 0) and b=
ail out
> with -EINVAL...

ok, fix in v7.

>=20
> On the other side looking at the zero groups/function case, that is plaus=
ible
> and handled properly by the driver since a 0-bytes devm_kcalloc will retu=
rn
> ZERO_SIZE_PTR (not NULL) and all the remaining references to pinfo->group=
s
> and pinfo->functions are guarded by a check on selector >=3D nr_groups (o=
r >=3D
> nr_functions), and by scmi_pinctrl_validate_id() so the zero grouyps/fuct=
ions
> scenarios should be safely handled.
>=20
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +	return ret;
> > +}
> > +
> > +static int scmi_pinctrl_count_get(const struct scmi_protocol_handle *p=
h,
> > +				  enum scmi_pinctrl_selector_type type) {
> > +	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
> > +
> > +	switch (type) {
> > +	case PIN_TYPE:
> > +		return pi->nr_pins;
> > +	case GROUP_TYPE:
> > +		return pi->nr_groups;
> > +	case FUNCTION_TYPE:
> > +		return pi->nr_functions;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle =
*ph,
> > +				    u32 identifier,
> > +				    enum scmi_pinctrl_selector_type type) {
> > +	int value;
> > +
> > +	value =3D scmi_pinctrl_count_get(ph, type);
> > +	if (value < 0)
> > +		return value;
> > +
> > +	if (identifier >=3D value)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *=
ph,
> > +				   enum scmi_pinctrl_selector_type type,
> > +				   u32 selector, char *name,
> > +				   u32 *n_elems)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_pinctrl_attributes *tx;
> > +	struct scmi_resp_pinctrl_attributes *rx;
> > +	u32 ext_name_flag;
>=20
> what about a bool
>=20
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
> > +				      sizeof(*rx), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tx =3D t->tx.buf;
> > +	rx =3D t->rx.buf;
> > +	tx->identifier =3D cpu_to_le32(selector);
> > +	tx->flags =3D cpu_to_le32(type);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		if (n_elems)
> > +			*n_elems =3D NUM_ELEMS(rx->attributes);
> > +
> > +		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
> > +
> > +		ext_name_flag =3D EXT_NAME_FLAG(rx->attributes);
> > +	} else
> > +		ext_name_flag =3D 0;
>=20
> and you dont need this else branch to set ext_name_flag to false, since d=
own
> below you will check ext_flag ONLY if !ret, so it will have surely been s=
et if the
> do_xfer did not fail.
>=20
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	/*
> > +	 * If supported overwrite short name with the extended one;
> > +	 * on error just carry on and use already provided short name.
> > +	 */
> > +	if (!ret && ext_name_flag)
> > +		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET,
> selector,
> > +					    (u32 *)&type, name,
> > +					    SCMI_MAX_STR_SIZE);
> > +	return ret;
> > +}
> > +
> > +struct scmi_pinctrl_ipriv {
> > +	u32 selector;
> > +	enum scmi_pinctrl_selector_type type;
> > +	u32 *array;
> > +};
> > +
> > +static void iter_pinctrl_assoc_prepare_message(void *message,
> > +					       u32 desc_index,
> > +					       const void *priv)
> > +{
> > +	struct scmi_msg_pinctrl_list_assoc *msg =3D message;
> > +	const struct scmi_pinctrl_ipriv *p =3D priv;
> > +
> > +	msg->identifier =3D cpu_to_le32(p->selector);
> > +	msg->flags =3D cpu_to_le32(p->type);
> > +	/* Set the number of OPPs to be skipped/already read */
>=20
> OPP ? .. maybe drop this comment that was cut/pasted from somewhere
> else :D
>=20
> > +	msg->index =3D cpu_to_le32(desc_index); }
> > +
> > +static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state =
*st,
> > +					   const void *response, void *priv)
> {
> > +	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
> > +
> > +	st->num_returned =3D RETURNED(r->flags);
> > +	st->num_remaining =3D REMAINING(r->flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle
> *ph,
> > +				    const void *response,
> > +				    struct scmi_iterator_state *st, void *priv)
> {
> > +	const struct scmi_resp_pinctrl_list_assoc *r =3D response;
> > +	struct scmi_pinctrl_ipriv *p =3D priv;
> > +
> > +	p->array[st->desc_index + st->loop_idx] =3D
> > +		le16_to_cpu(r->array[st->loop_idx]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_list_associations(const struct scmi_protocol_h=
andle
> *ph,
> > +					  u32 selector,
> > +					  enum scmi_pinctrl_selector_type
> type,
> > +					  u16 size, u32 *array)
> > +{
> > +	int ret;
> > +	void *iter;
> > +	struct scmi_iterator_ops ops =3D {
> > +		.prepare_message =3D iter_pinctrl_assoc_prepare_message,
> > +		.update_state =3D iter_pinctrl_assoc_update_state,
> > +		.process_response =3D iter_pinctrl_assoc_process_response,
> > +	};
> > +	struct scmi_pinctrl_ipriv ipriv =3D {
> > +		.selector =3D selector,
> > +		.type =3D type,
> > +		.array =3D array,
> > +	};
> > +
> > +	if (!array || !size || type =3D=3D PIN_TYPE)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	iter =3D ph->hops->iter_response_init(ph, &ops, size,
> > +					    PINCTRL_LIST_ASSOCIATIONS,
> > +					    sizeof(struct
> scmi_msg_pinctrl_list_assoc),
> > +					    &ipriv);
> > +
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	return ph->hops->iter_response_run(iter);
> > +}
> > +
> > +struct scmi_settings_get_ipriv {
> > +	u32 selector;
> > +	enum scmi_pinctrl_selector_type type;
> > +	u32 flag;
> > +	enum scmi_pinctrl_conf_type *config_types;
> > +	u32 *config_values;
> > +};
> > +
> > +static void
> > +iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_inde=
x,
> > +					  const void *priv)
> > +{
> > +	struct scmi_msg_settings_get *msg =3D message;
> > +	const struct scmi_settings_get_ipriv *p =3D priv;
> > +	u32 attributes;
> > +
> > +	attributes =3D FIELD_PREP(CONFIG_FLAG_MASK, p->flag) |
> > +		     FIELD_PREP(SELECTOR_MASK, p->type);
> > +
> > +	if (p->flag =3D=3D 1)
>=20
> A boolean like .get_all would be more clear..see down below why you dont
> need a flag 0|1|2
>=20
> > +		attributes |=3D FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> > +	else if (!p->flag)
> > +		attributes |=3D FIELD_PREP(CONFIG_TYPE_MASK, p-
> >config_types[0]);
> > +
> > +	msg->attributes =3D cpu_to_le32(attributes);
> > +	msg->identifier =3D cpu_to_le32(p->selector); }
> > +
> > +static int
> > +iter_pinctrl_settings_get_update_state(struct scmi_iterator_state *st,
> > +				       const void *response, void *priv) {
> > +	const struct scmi_resp_settings_get *r =3D response;
> > +	struct scmi_settings_get_ipriv *p =3D priv;
> > +
> > +	if (p->flag =3D=3D 1) {
>=20
> Ditto... see below the explanation
>=20
> > +		st->num_returned =3D le32_get_bits(r->num_configs,
> GENMASK(7, 0));
> > +		st->num_remaining =3D le32_get_bits(r->num_configs,
> > +						  GENMASK(31, 24));
> > +	} else {
> > +		st->num_returned =3D 1;
> > +		st->num_remaining =3D 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +iter_pinctrl_settings_get_process_response(const struct
> scmi_protocol_handle *ph,
> > +				       const void *response,
> > +				       struct scmi_iterator_state *st,
> > +				       void *priv)
> > +{
> > +	const struct scmi_resp_settings_get *r =3D response;
> > +	struct scmi_settings_get_ipriv *p =3D priv;
> > +
> > +	if (!p->flag) {
> > +		if (p->config_types[0] !=3D
> > +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> > +			return -EINVAL;
> > +	} else if (p->flag =3D=3D 1) {
> > +		p->config_types[st->desc_index + st->loop_idx] =3D
> > +			le32_get_bits(r->configs[st->loop_idx * 2],
> > +				      GENMASK(7, 0));
> > +	} else if (p->flag =3D=3D 2) {
> > +		return 0;
> > +	}
>=20
> Unneeded...see down below for explanation
>=20
> > +
> > +	p->config_values[st->desc_index + st->loop_idx] =3D
> > +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32
> selector,
> > +			  enum scmi_pinctrl_selector_type type,
> > +			  enum scmi_pinctrl_conf_type config_type,
> > +			  u32 *config_value)
> > +{
> > +	int ret;
> > +	void *iter;
> > +	struct scmi_iterator_ops ops =3D {
> > +		.prepare_message =3D
> iter_pinctrl_settings_get_prepare_message,
> > +		.update_state =3D iter_pinctrl_settings_get_update_state,
> > +		.process_response =3D
> iter_pinctrl_settings_get_process_response,
> > +	};
> > +	struct scmi_settings_get_ipriv ipriv =3D {
> > +		.selector =3D selector,
> > +		.type =3D type,
> > +		.flag =3D 0,
> > +		.config_types =3D &config_type,
> > +		.config_values =3D config_value,
> > +	};
> > +
>=20
> So this function is used to retrieve configs; as of now, just one, then i=
t could
> be extended to fetch all the configs, and for this it uses the iterators =
helpers,
> BUT it is not and will not be used to just fetch the selected_function wi=
th
> flag_2 (even though is always provided), since in that case you wont get =
back
> a multi-part SCMI response and so there is no need to use iterators...
>=20
> IOW... no need here to handle flag_2 scenario and as a consequence I woul=
d
> change the ipriv flag to be be a boolean .get_all, like it was, since it =
is more
> readable (and so you wont need to add any comment..)


ok, so your suggestion is drop the iterators, and only support  one config,
right?

Or keep iterators with get_all be passed as a function parameter?

>=20
> In the future could make sense to add here also a *selected_function outp=
ut
> param to this function since you will always get it back for free when
> retrieving configs ... BUT for now is just not needed really...no users f=
or this
> case till now...
>=20
> ...when the time will come that we will need a function_selected_get to b=
e
> issued without retrieveing also the configs I would add a distinct routin=
e that
> crafts properly a SETTINGS_GET with flag_2 without worrying about multi-
> part responses (and with no need for iterators support)
>=20
> Trying to handle all in here just complicates stuff...
>=20
> > +	if (!config_value || type =3D=3D FUNCTION_TYPE)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	iter =3D ph->hops->iter_response_init(ph, &ops, 1,
> PINCTRL_SETTINGS_GET,
> > +					    sizeof(struct
> scmi_msg_settings_get),
> > +					    &ipriv);
> > +
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	return ph->hops->iter_response_run(iter);
> > +}
> > +
> > +static int
> > +scmi_pinctrl_settings_conf(const struct scmi_protocol_handle *ph,
> > +			   u32 selector,
> > +			   enum scmi_pinctrl_selector_type type,
> > +			   u32 nr_configs,
> > +			   enum scmi_pinctrl_conf_type *config_type,
> > +			   u32 *config_value)
> > +{
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_settings_conf *tx;
> > +	u32 attributes;
> > +	int ret, i;
> > +	u32 configs_in_chunk, conf_num =3D 0;
> > +	u32 chunk;
> > +	int max_msg_size =3D ph->hops->get_max_msg_size(ph);
> > +
> > +	if (!config_type || !config_value || type =3D=3D FUNCTION_TYPE)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, selector, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	configs_in_chunk =3D (max_msg_size - sizeof(*tx)) / (sizeof(__le32) *=
 2);
> > +	while (conf_num < nr_configs) {
> > +		chunk =3D (nr_configs - conf_num > configs_in_chunk) ?
> > +			configs_in_chunk : nr_configs - conf_num;
> > +
> > +		ret =3D ph->xops->xfer_get_init(ph,
> PINCTRL_SETTINGS_CONFIGURE,
> > +					      sizeof(*tx) +
> > +					      chunk * 2 * sizeof(__le32),
> > +					      0, &t);
> > +		if (ret)
> > +			return ret;
>  for consistency I would
> 			break;
>=20
> like below and you will exit always from the last return ret;
>=20
> > +
> > +		tx =3D t->tx.buf;
> > +		tx->identifier =3D cpu_to_le32(selector);
> > +		attributes =3D FIELD_PREP(GENMASK(1, 0), type) |
> > +			FIELD_PREP(GENMASK(9, 2), chunk);
> > +		tx->attributes =3D cpu_to_le32(attributes);
> > +
> > +		for (i =3D 0; i < chunk; i++) {
> > +			tx->configs[i * 2] =3D
> > +				cpu_to_le32(config_type[conf_num + i]);
> > +			tx->configs[i * 2 + 1] =3D
> > +				cpu_to_le32(config_value[conf_num + i]);
> > +		}
> > +
> > +		ret =3D ph->xops->do_xfer(ph, t);
> > +
> > +		ph->xops->xfer_put(ph, t);
> > +
> > +		if (ret)
> > +			break;
> > +
> > +		conf_num +=3D chunk;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_pinctrl_function_select(const struct scmi_protocol_han=
dle
> *ph,
> > +					u32 group,
> > +					enum scmi_pinctrl_selector_type
> type,
> > +					u32 function_id)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_settings_conf *tx;
> > +	u32 attributes;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, group, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_SETTINGS_CONFIGURE,
> > +				      sizeof(*tx), 0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tx =3D t->tx.buf;
> > +	tx->identifier =3D cpu_to_le32(group);
> > +	tx->function_id =3D cpu_to_le32(function_id);
> > +	attributes =3D FIELD_PREP(GENMASK(1, 0), type) | BIT(10);
> > +	tx->attributes =3D cpu_to_le32(attributes);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
> > +				u32 identifier,
> > +				enum scmi_pinctrl_selector_type type) {
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_request *tx;
> > +
> > +	if (type =3D=3D FUNCTION_TYPE)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx), 0,
> &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tx =3D t->tx.buf;
> > +	tx->identifier =3D cpu_to_le32(identifier);
> > +	tx->flags =3D cpu_to_le32(type);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
>=20
> ..this function ...
>=20
> > +static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle =
*ph,
> > +				    u32 pin)
> > +{
> > +	return scmi_pinctrl_request(ph, pin, PIN_TYPE); }
> > +
> > +static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
> > +			     u32 identifier,
> > +			     enum scmi_pinctrl_selector_type type) {
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_request *tx;
> > +
> > +	if (type =3D=3D FUNCTION_TYPE)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_validate_id(ph, identifier, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PINCTRL_RELEASE, sizeof(*tx), 0, =
&t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tx =3D t->tx.buf;
> > +	tx->identifier =3D cpu_to_le32(identifier);
> > +	tx->flags =3D cpu_to_le32(type);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
>=20
> ...and this are completely identical, beside the used command msg_id...pl=
ease
> make it a common workhorse function by adding a param for the command...
>=20
> > +static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle
> > +*ph, u32 pin) {
> > +	return scmi_pinctrl_free(ph, pin, PIN_TYPE); }
> > +
>=20
> ...and convert these _request/_free functions into a pair odf simple wrap=
per
> invoking the common workhorse...
>=20
> > +static int scmi_pinctrl_get_group_info(const struct scmi_protocol_hand=
le
> *ph,
> > +				       u32 selector,
> > +				       struct scmi_group_info *group) {
> > +	int ret;
> > +
> > +	if (!group)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
> > +				      group->name,
> > +				      &group->nr_pins);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!group->nr_pins) {
> > +		dev_err(ph->dev, "Group %d has 0 elements", selector);
> > +		return -ENODATA;
> > +	}
> > +
> > +	group->group_pins =3D kmalloc_array(group->nr_pins,
> > +					  sizeof(*group->group_pins),
> > +					  GFP_KERNEL);
> > +	if (!group->group_pins)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
> > +					     group->nr_pins, group-
> >group_pins);
> > +	if (ret) {
> > +		kfree(group->group_pins);
> > +		return ret;
> > +	}
> > +
> > +	group->present =3D true;
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_group_name(const struct scmi_protocol_hand=
le
> *ph,
> > +				       u32 selector, const char **name) {
> > +	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	if (selector >=3D pi->nr_groups)
> > +		return -EINVAL;
> > +
> > +	if (!pi->groups[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_group_info(ph, selector,
> > +						  &pi->groups[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*name =3D pi->groups[selector].name;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_hand=
le
> *ph,
> > +				       u32 selector, const u32 **pins,
> > +				       u32 *nr_pins)
> > +{
> > +	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
> > +
> > +	if (!pins || !nr_pins)
> > +		return -EINVAL;
> > +
> > +	if (selector >=3D pi->nr_groups)
> > +		return -EINVAL;
> > +
> > +	if (!pi->groups[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_group_info(ph, selector,
> > +						  &pi->groups[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*pins =3D pi->groups[selector].group_pins;
> > +	*nr_pins =3D pi->groups[selector].nr_pins;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_function_info(const struct
> scmi_protocol_handle *ph,
> > +					  u32 selector,
> > +					  struct scmi_function_info *func) {
> > +	int ret;
> > +
> > +	if (!func)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
> > +				      func->name,
> > +				      &func->nr_groups);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!func->nr_groups) {
> > +		dev_err(ph->dev, "Function %d has 0 elements", selector);
> > +		return -ENODATA;
> > +	}
> > +
> > +	func->groups =3D kmalloc_array(func->nr_groups, sizeof(*func->groups)=
,
> > +				     GFP_KERNEL);
> > +	if (!func->groups)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
> > +					     func->nr_groups, func->groups);
> > +	if (ret) {
> > +		kfree(func->groups);
> > +		return ret;
> > +	}
> > +
> > +	func->present =3D true;
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_function_name(const struct
> scmi_protocol_handle *ph,
> > +					  u32 selector, const char **name) {
> > +	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	if (selector >=3D pi->nr_functions)
> > +		return -EINVAL;
> > +
> > +	if (!pi->functions[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_function_info(ph, selector,
> > +						     &pi-
> >functions[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*name =3D pi->functions[selector].name;
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_pinctrl_function_groups_get(const struct scmi_protocol_handle *ph=
,
> > +				 u32 selector, u32 *nr_groups,
> > +				 const u32 **groups)
> > +{
> > +	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
> > +
> > +	if (!groups || !nr_groups)
> > +		return -EINVAL;
> > +
> > +	if (selector >=3D pi->nr_functions)
> > +		return -EINVAL;
> > +
> > +	if (!pi->functions[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_function_info(ph, selector,
> > +						     &pi-
> >functions[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*groups =3D pi->functions[selector].groups;
> > +	*nr_groups =3D pi->functions[selector].nr_groups;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
> > +				u32 selector, u32 group)
> > +{
> > +	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE,
> > +selector); }
> > +
> > +static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle=
 *ph,
> > +				     u32 selector, struct scmi_pin_info *pin) {
> > +	int ret;
> > +
> > +	if (!pin)
> > +		return -EINVAL;
> > +
> > +	ret =3D scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
> > +				      pin->name, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pin->present =3D true;
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle
> *ph,
> > +				     u32 selector, const char **name) {
> > +	struct scmi_pinctrl_info *pi =3D ph->get_priv(ph);
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	if (selector >=3D pi->nr_pins)
> > +		return -EINVAL;
> > +
> > +	if (!pi->pins[selector].present) {
> > +		int ret;
> > +
> > +		ret =3D scmi_pinctrl_get_pin_info(ph, selector,
> > +						&pi->pins[selector]);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	*name =3D pi->pins[selector].name;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph=
,
> > +				 u32 selector,
> > +				 enum scmi_pinctrl_selector_type type,
> > +				 const char **name)
> > +{
> > +	switch (type) {
> > +	case PIN_TYPE:
> > +		return scmi_pinctrl_get_pin_name(ph, selector, name);
> > +	case GROUP_TYPE:
> > +		return scmi_pinctrl_get_group_name(ph, selector, name);
> > +	case FUNCTION_TYPE:
> > +		return scmi_pinctrl_get_function_name(ph, selector, name);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops =3D {
> > +	.count_get =3D scmi_pinctrl_count_get,
> > +	.name_get =3D scmi_pinctrl_name_get,
> > +	.group_pins_get =3D scmi_pinctrl_group_pins_get,
> > +	.function_groups_get =3D scmi_pinctrl_function_groups_get,
> > +	.mux_set =3D scmi_pinctrl_mux_set,
> > +	.settings_get =3D scmi_pinctrl_settings_get,
> > +	.settings_conf =3D scmi_pinctrl_settings_conf,
> > +	.pin_request =3D scmi_pinctrl_pin_request,
> > +	.pin_free =3D scmi_pinctrl_pin_free,
> > +};
> > +
> > +static int scmi_pinctrl_protocol_init(const struct
> > +scmi_protocol_handle *ph) {
> > +	int ret;
> > +	u32 version;
> > +	struct scmi_pinctrl_info *pinfo;
> > +
> > +	ret =3D ph->xops->version_get(ph, &version);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
> > +		PROTOCOL_REV_MAJOR(version),
> PROTOCOL_REV_MINOR(version));
> > +
> > +	pinfo =3D devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
> > +	if (!pinfo)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_pinctrl_attributes_get(ph, pinfo);
> > +	if (ret)
> > +		return ret;
>=20
> ..as a I was saying is nr_pins =3D=3D 0 the scmi_pinctrl_attributes_get c=
ould return
> -EINVAL here and bail out....not sure that a running setup with zero pins=
 has
> any values (even for testing...) BUT, as said above, I wuld certainly add=
 a
> dev_warn in scmi_pinctrl_attributes_get() when nr_pins =3D=3D 0

Fix it in v7.

Thanks,
Peng.
>=20
> Thanks,
> Cristian

