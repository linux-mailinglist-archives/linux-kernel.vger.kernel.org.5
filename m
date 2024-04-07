Return-Path: <linux-kernel+bounces-134116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB90489ADCC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365B61F215EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59461F4E7;
	Sun,  7 Apr 2024 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SW2iE53c"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2121.outbound.protection.outlook.com [40.107.21.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AABA42;
	Sun,  7 Apr 2024 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451845; cv=fail; b=aPw8mdVQt8MT1j3EAah6nO3JTqjK1JPjq3OddJrk561RJ1d/cXlASrvBhVKEDxm/9OxzGCv3ozl23uILV/DRUxUN6sPzlC050BfhFzvLupEXItOQaXNStVCPV8WP+FlcTJp3hsTHGusXj++/X1g3fE9o8P5e5ehF0ur7kqSUvls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451845; c=relaxed/simple;
	bh=71oaXevOXJlO/fAm4WwNuWJAXirOVtejOp8dp5j8H38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MdROIHHZkKgskvv2ykM5xOUpftgUu6mNLrPrmx7iPVW/QfYt8/a4hXtxibslknQhOFNDudUd9zmc9JHD5e9yfzK7eksWJgYg63bZWZKacM9nDOCWhugK7wAv4qCABXg+dhbvDYBv79AUI4SaTMM0fwBF6bJCcU2P7kgOn7Z+uXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SW2iE53c; arc=fail smtp.client-ip=40.107.21.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2aMGrN92P6QIXc+dtPx+7cmlLErb+G6f4FquPOrDq2JXnsFvnsvUBSy6GglaJLIT5nHSNi+GJiD6bG5+K+eREgg4awUjFA4wB1XSrHnlRV1rkkkW7KbPUQ6cT4awTvsx2wVUBSVT8CmT40YOW+DeGEN5HKdE6xXfz7yrupFQkhjM7ahl5VYj7+KkfhhCL0jB4dYjJIPuc524Wr8yHsukxgYJm+W8X8oD1u2OR1QWULozxh6SeZCTuyNB8j9vfa1tHoepja+j119Y+ecoNeIyCSMu2WlYYhPG1yDaQH46eIycWfjEo/DvNozik1c/KN87H1+VDdl8AOoyuVWgGRyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ft/Hh9+QtDl7Rtxu9oMc+9YGhgZCAlm6OCjoEU9qoRc=;
 b=c9pkaG0rjzMUe44ghnqWwyRFT8OY6jWMHVSb42UK3tGtA5nl2H96NF70Ksy/QqtVG9Lz6z4RWRNcFME73pRnruYpzGqyIZde+UhdziQg60k0dfF2PTxiKfztq9Ghg9bLpF2LcNlnxfZew3iW0Ab2JMGjQTZJb8JGXZrMtsPYLmTRJ4GbX+LwsECUrqh6duBzJCuPwGjwZYJnHGePF9onwtg2tOZbgg1bmVE3Jt9A3lDCtjEz+3B+FUG0Z8pY7GdSl+/gVVzZIcPs2yoPeaWW9rBUajO0BtLXxd5rNGnRa/HAR3QPNt/1A7/egQi0kR6bAkLM6bSwg4GQ8I4qGKnzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ft/Hh9+QtDl7Rtxu9oMc+9YGhgZCAlm6OCjoEU9qoRc=;
 b=SW2iE53czaXJ/X6UyGNJcRE8VCNsYUescVggE9n8cFyT5zVEVBOAl8I9FYZR3UcIqRH7TfQGATAoGv6di/zEjS6TzK1fPPGOWDjs3CxZPdpz7N068UHEpHYtYhQtVfnv/5/UZJNzRhvyMawnQ4yi9kyja5Zjpbyxs3s9t9nPe5g=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 01:03:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 01:03:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Thread-Topic: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Thread-Index: AQHah1U+Ouni2yxGIkadGTHqoE9cS7FZ4lEAgAIamiA=
Date: Sun, 7 Apr 2024 01:03:55 +0000
Message-ID:
 <DU0PR04MB9417A07F56B7E14DAB3DCE2188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-4-9fc9186856c2@nxp.com>
 <20240405164414.t3fqhnwudxxt2ozv@pengutronix.de>
In-Reply-To: <20240405164414.t3fqhnwudxxt2ozv@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB7141:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +iqLESbyt9/a3IJikbcxLw3kMwgihTMOPlWwT2XImqIwH3c3gbqCit+IXetQq+Qphuabp9nqMouHXbt6s8Dj0Tx9rStKJpLMzD2p4vAsTQtNIhc5HHml29eodzCX0GrfBMBrM9hPC7+QhSAuLoO1iLFaiWg5lQ7Il2o0+2VB/yc0wl0Gh9q2f9p/TejCT9amuzRBzlLr+aeZP1X8Ei3mHF5+tfVnF9Y/LuR3pOaFR8FDdHQ1WYRazJCUSVWUvkGyhx6qGIxJWIV4aJtfMoGK6lB2xNvVFUHx228hALhsZzAZ9s38FRx9PzCz6Xncyj9vTlL9PSG/Smt+TdP8glQ3WR1z4ExEd8mRM2ESDGQaPU/szueNo46fjRE0s9mtbJYLSTRzo3J5qWjDtGUFYELkyPuRDUrB4Csp2qUMD3MJfLciUGb3zdVTX35pxzfZbe6wRhL9oKoqY4unKhk+3+zRBCywm0f5XcWQ7skyegZ3lCNL03GZyz22VF0HQCaTzkR4y8aA2otMSgE2JfpSQp2c+SAiRckRvliox/fUnHETkfEiB7PN1bsdVtiap03LfQmnvtMgrCqayvtK+eYHO4UE3zr0lXt0mJE+2zwa8P+3lZlOWsRw0mLxAbCGkqTtDWVVFtAfmOIxB37t+XopGe2AGQ7S7I9gyR0EOppLtSEL0B0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qEBxaDubDda93aj8damHYOjCVlkOSERdUbzirhrDQ9P4e5cQDUd6Oc8cWlR5?=
 =?us-ascii?Q?I8qMwbK1NhXrxwsAkZwxuB6BC1fBoXHg5o52iZPSIXCCW1QKRpgaxRDx6OyY?=
 =?us-ascii?Q?hCPLl/AiFJ/VgNuZQ9UmyAzqFY/EAWnK99d/GUp1VXB68gpbZcwTdeniRnvd?=
 =?us-ascii?Q?Y/sc3NqQN9sriKotjhAXmOP8nxnQppz1uv/mP7CQNg6zBoL0DQpAXFmU8f0t?=
 =?us-ascii?Q?lwdxU2LayXN8y4JsWdEHlSBo9tKb8Xw3tybz4fhUp6BGY90hy3pIgtszpsIf?=
 =?us-ascii?Q?UypMrdaa6UEs2dJED5/PJreHRmY7Sr7IlP/dS84Mr0cuvkhg7wFYcQQFCmTI?=
 =?us-ascii?Q?bRj69D1YomtoWNQhMuYweBky+If2XtOGLY3QdUmwSke49yZAAvZXs+x+wqKL?=
 =?us-ascii?Q?EdRutQNoUmhL+8zvmxroxWYCN0a97VYxUGbzBEip/SRLBxkfKfXoG2oxGOBg?=
 =?us-ascii?Q?j8rGnWI6PaICMJAbZN1a0BYy/7pza5WUv3UNoRyj5SvbNJnYElKnK/0m+fZV?=
 =?us-ascii?Q?raP5IO/XezfIoR7Gv4BBhnM+Z4fjWJJnjq1mzyNKBMIe7rtZ6uf7FrK99vEl?=
 =?us-ascii?Q?ext58aWpowbjqYQCGKSwSY9ZDIzEundjmwCwbzNXneoFiT74K80+JsAvG4am?=
 =?us-ascii?Q?gVW7ad4eL3j/gNyjVsZo4sPIburkv8D7BEp+Fr1EYkhpQJ6Ds9VPyL6fSOwB?=
 =?us-ascii?Q?39LaWE1DgNu0+n8rep4XeuwCTyNY10ScyxQ24qumTiqqDfntH+fZ+97r8o8b?=
 =?us-ascii?Q?NMOK+jGDtS5O52oTdg7sqJBnHpWJsgwjNrbketbIxToqvKKsuywhxDrW4jVl?=
 =?us-ascii?Q?kJTVaOymnnWz2oLWqkWOHa0dcKQHze6Jc//vGvveXQlJfN2dNPG09NwYcHDp?=
 =?us-ascii?Q?ReGC8OKqBy1uN7Cd8ifuQ9kZjWAp1w59hTyaZUmKquamdUCLbX4XwrjNpoqB?=
 =?us-ascii?Q?Q5zuououPYxgg15jG+ohsxgzXVNOV7u0W2Ce0+2uSTJx8ybdjdUCml+lhYLx?=
 =?us-ascii?Q?NYvJKBgx64q9zYphtm3p0wVMlL1+jJzR0rQKN7Xu1NfUKW0X3aTyJb8Oro/x?=
 =?us-ascii?Q?8axDcl1ea7/vmNlWn42ScpGzuIeQoa69EzP2D8rv6elmfoxP+CSdjg2OyyKM?=
 =?us-ascii?Q?kLTuWxPxk18yTZmtDYnqQhchaq1s5JGuMoVZVbjkhY4vN9jnEMZ61qBayVJy?=
 =?us-ascii?Q?V8fw2OgYBHuq38CDJjbdjbynaRpYipa7aVLZo5LTeBJpcSzE/A2WjU7hlMRb?=
 =?us-ascii?Q?2hU+9ftgc7ni2sKDS4wgew3mdnKWXiA4AFWG5TPI54Um/nMcg4nLA7iIrs+o?=
 =?us-ascii?Q?0u8Crve2QSTgELwsCg69kQ2uXDxNNRT8wAVw/RbPfm5X+1kMaB19IK5XyWOo?=
 =?us-ascii?Q?RvoXEbjlrpT9gmnwHRm98IMHaV3gYc4BJ9ucd5PKTPAOIJ+mahVpKKnrKpFf?=
 =?us-ascii?Q?thEMTO8OYbnAk4YnX6K8PAo8h+IjDujTgnWP9HAddfGhe7W5mX0EoR3QijkH?=
 =?us-ascii?Q?WrfUSEtXmwuedxhqdc+//oeObtC0Kc1fdvmRHdLyuNWkqkIUmmKgRySn09Jg?=
 =?us-ascii?Q?FpTgql56cSOxEYYFmx8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dc1fd2-3b0a-4d6d-624e-08dc569e997f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 01:03:55.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bh7zcQLaSkYinuobciE/8Tmv75pfqBS6+16TPfZoAlHwJ+RzTl30DRAiv+ZLzWr9wV/zs6m5Jfxe0fbt0H/tXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141

> Subject: Re: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i=
MX
> MISC protocol
>=20
> Hi Peng,
>=20
> On 24-04-05, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX MISC protocol is for misc settings, such as gpio expander
> > wakeup.
>=20
> Can you elaborate a bit more please?

The gpio expander is under M33(SCMI firmware used core) I2C control,
But the gpio expander supports board function such as PCIE_WAKEUP,
BTN_WAKEUP. So these are managed by MISC protocol.

SAI_CLK_MSEL in WAKEUP BLK CTRL is also managed by MISC Protocol.

And etc...

I will add more info in commit log in next version later, after I get more
reviews on the patchset.

Thanks,
Peng.

>=20
> Regards,
>   Marco
>=20
>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/Kconfig       |  10 ++
> >  drivers/firmware/arm_scmi/Makefile      |   1 +
> >  drivers/firmware/arm_scmi/imx-sm-misc.c | 305
> ++++++++++++++++++++++++++++++++
> >  include/linux/scmi_imx_protocol.h       |  17 ++
> >  4 files changed, 333 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/Kconfig
> > b/drivers/firmware/arm_scmi/Kconfig
> > index 56d11c9d9f47..bfeae92f6420 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -191,3 +191,13 @@ config IMX_SCMI_BBM_EXT
> >  	  and BUTTON.
> >
> >  	  This driver can also be built as a module.
> > +
> > +config IMX_SCMI_MISC_EXT
> > +	tristate "i.MX SCMI MISC EXTENSION"
> > +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> > +	default y if ARCH_MXC
> > +	help
> > +	  This enables i.MX System MISC control logic such as gpio expander
> > +	  wakeup
> > +
> > +	  This driver can also be built as a module.
> > diff --git a/drivers/firmware/arm_scmi/Makefile
> > b/drivers/firmware/arm_scmi/Makefile
> > index 327687acf857..a23fde721222 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -12,6 +12,7 @@ scmi-transport-
> $(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO)
> > +=3D virtio.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> > scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o
> > system.o voltage.o powercap.o
> >  scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) +=3D imx-sm-bbm.o
> > +scmi-protocols-$(CONFIG_IMX_SCMI_MISC_EXT) +=3D imx-sm-misc.o
> >  scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y)
> > $(scmi-transport-y)
> >
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o diff --git
> > a/drivers/firmware/arm_scmi/imx-sm-misc.c
> > b/drivers/firmware/arm_scmi/imx-sm-misc.c
> > new file mode 100644
> > index 000000000000..1b0ec2281518
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/imx-sm-misc.c
> > @@ -0,0 +1,305 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * System control and Management Interface (SCMI) NXP MISC Protocol
> > + *
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
> > +
> > +#include <linux/bits.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/scmi_imx_protocol.h>
> > +
> > +#include "protocols.h"
> > +#include "notify.h"
> > +
> > +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> > +
> > +enum scmi_imx_misc_protocol_cmd {
> > +	SCMI_IMX_MISC_CTRL_SET	=3D 0x3,
> > +	SCMI_IMX_MISC_CTRL_GET	=3D 0x4,
> > +	SCMI_IMX_MISC_CTRL_NOTIFY =3D 0x8,
> > +};
> > +
> > +struct scmi_imx_misc_info {
> > +	u32 version;
> > +	u32 nr_dev_ctrl;
> > +	u32 nr_brd_ctrl;
> > +	u32 nr_reason;
> > +};
> > +
> > +struct scmi_msg_imx_misc_protocol_attributes {
> > +	__le32 attributes;
> > +};
> > +
> > +#define GET_BRD_CTRLS_NR(x)	le32_get_bits((x), GENMASK(31,
> 24))
> > +#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23, 16))
> > +#define GET_DEV_CTRLS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> > +#define BRD_CTRL_START_ID	BIT(15)
> > +
> > +struct scmi_imx_misc_ctrl_set_in {
> > +	__le32 id;
> > +	__le32 num;
> > +	__le32 value[MISC_MAX_VAL];
> > +};
> > +
> > +struct scmi_imx_misc_ctrl_notify_in {
> > +	__le32 ctrl_id;
> > +	__le32 flags;
> > +};
> > +
> > +struct scmi_imx_misc_ctrl_notify_payld {
> > +	__le32 ctrl_id;
> > +	__le32 flags;
> > +};
> > +
> > +struct scmi_imx_misc_ctrl_get_out {
> > +	__le32 num;
> > +	__le32 *val;
> > +};
> > +
> > +static int scmi_imx_misc_attributes_get(const struct scmi_protocol_han=
dle
> *ph,
> > +					struct scmi_imx_misc_info *mi)
> > +{
> > +	int ret;
> > +	struct scmi_xfer *t;
> > +	struct scmi_msg_imx_misc_protocol_attributes *attr;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> > +				      sizeof(*attr), &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	attr =3D t->rx.buf;
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		mi->nr_dev_ctrl =3D GET_DEV_CTRLS_NR(attr->attributes);
> > +		mi->nr_brd_ctrl =3D GET_BRD_CTRLS_NR(attr->attributes);
> > +		mi->nr_reason =3D GET_REASONS_NR(attr->attributes);
> > +		dev_info(ph->dev, "i.MX MISC NUM DEV CTRL: %d, NUM
> BRD CTRL: %d,NUM Reason: %d\n",
> > +			 mi->nr_dev_ctrl, mi->nr_brd_ctrl, mi->nr_reason);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_imx_misc_ctrl_validate_id(const struct
> scmi_protocol_handle *ph,
> > +					  u32 ctrl_id)
> > +{
> > +	struct scmi_imx_misc_info *mi =3D ph->get_priv(ph);
> > +
> > +	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi->nr_dev_ctrl))
> > +		return -EINVAL;
> > +	if (ctrl_id >=3D BRD_CTRL_START_ID + mi->nr_brd_ctrl)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_imx_misc_ctrl_notify(const struct scmi_protocol_handle
> *ph,
> > +				     u32 ctrl_id, u32 flags)
> > +{
> > +	struct scmi_imx_misc_ctrl_notify_in *in;
> > +	struct scmi_xfer *t;
> > +	int ret;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
> > +				      sizeof(*in), 0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	in =3D t->tx.buf;
> > +	in->ctrl_id =3D cpu_to_le32(ctrl_id);
> > +	in->flags =3D cpu_to_le32(flags);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +scmi_imx_misc_ctrl_set_notify_enabled(const struct
> scmi_protocol_handle *ph,
> > +				      u8 evt_id, u32 src_id, bool enable) {
> > +	int ret;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_notify(ph, src_id, enable ? evt_id : 0);
> > +	if (ret)
> > +		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] -
> ret:%d\n",
> > +			evt_id, src_id, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_imx_misc_ctrl_get_num_sources(const struct
> > +scmi_protocol_handle *ph) {
> > +	return GENMASK(15, 0);
> > +}
> > +
> > +static void *
> > +scmi_imx_misc_ctrl_fill_custom_report(const struct scmi_protocol_handl=
e
> *ph,
> > +				      u8 evt_id, ktime_t timestamp,
> > +				      const void *payld, size_t payld_sz,
> > +				      void *report, u32 *src_id)
> > +{
> > +	const struct scmi_imx_misc_ctrl_notify_payld *p =3D payld;
> > +	struct scmi_imx_misc_ctrl_notify_report *r =3D report;
> > +
> > +	if (sizeof(*p) !=3D payld_sz)
> > +		return NULL;
> > +
> > +	r->timestamp =3D timestamp;
> > +	r->ctrl_id =3D p->ctrl_id;
> > +	r->flags =3D p->flags;
> > +	*src_id =3D r->ctrl_id;
> > +	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
> > +		r->ctrl_id, r->flags);
> > +
> > +	return r;
> > +}
> > +
> > +static const struct scmi_event_ops scmi_imx_misc_event_ops =3D {
> > +	.get_num_sources =3D scmi_imx_misc_ctrl_get_num_sources,
> > +	.set_notify_enabled =3D scmi_imx_misc_ctrl_set_notify_enabled,
> > +	.fill_custom_report =3D scmi_imx_misc_ctrl_fill_custom_report,
> > +};
> > +
> > +static const struct scmi_event scmi_imx_misc_events[] =3D {
> > +	{
> > +		.id =3D SCMI_EVENT_IMX_MISC_CONTROL_DISABLED,
> > +		.max_payld_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_payld),
> > +		.max_report_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_report),
> > +	},
> > +	{
> > +		.id =3D SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE,
> > +		.max_payld_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_payld),
> > +		.max_report_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_report),
> > +	},
> > +	{
> > +		.id =3D SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE,
> > +		.max_payld_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_payld),
> > +		.max_report_sz =3D sizeof(struct
> scmi_imx_misc_ctrl_notify_report),
> > +	}
> > +};
> > +
> > +static struct scmi_protocol_events scmi_imx_misc_protocol_events =3D {
> > +	.queue_sz =3D SCMI_PROTO_QUEUE_SZ,
> > +	.ops =3D &scmi_imx_misc_event_ops,
> > +	.evts =3D scmi_imx_misc_events,
> > +	.num_events =3D ARRAY_SIZE(scmi_imx_misc_events), };
> > +
> > +static int scmi_imx_misc_protocol_init(const struct
> > +scmi_protocol_handle *ph) {
> > +	struct scmi_imx_misc_info *minfo;
> > +	u32 version;
> > +	int ret;
> > +
> > +	ret =3D ph->xops->version_get(ph, &version);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
> > +		 PROTOCOL_REV_MAJOR(version),
> PROTOCOL_REV_MINOR(version));
> > +
> > +	minfo =3D devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
> > +	if (!minfo)
> > +		return -ENOMEM;
> > +
> > +	ret =3D scmi_imx_misc_attributes_get(ph, minfo);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ph->set_priv(ph, minfo, version); }
> > +
> > +static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handle *p=
h,
> > +				  u32 ctrl_id, u32 *num, u32 *val) {
> > +	struct scmi_imx_misc_ctrl_get_out *out;
> > +	struct scmi_xfer *t;
> > +	int ret, i;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET,
> sizeof(u32),
> > +				      0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	put_unaligned_le32(ctrl_id, t->tx.buf);
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +	if (!ret) {
> > +		out =3D t->rx.buf;
> > +		*num =3D le32_to_cpu(out->num);
> > +		for (i =3D 0; i < *num && i < MISC_MAX_VAL; i++)
> > +			val[i] =3D le32_to_cpu(out->val[i]);
> > +	}
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *p=
h,
> > +				  u32 ctrl_id, u32 num, u32 *val) {
> > +	struct scmi_imx_misc_ctrl_set_in *in;
> > +	struct scmi_xfer *t;
> > +	int ret, i;
> > +
> > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (num > MISC_MAX_VAL)
> > +		return -EINVAL;
> > +
> > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET,
> sizeof(*in),
> > +				      0, &t);
> > +	if (ret)
> > +		return ret;
> > +
> > +	in =3D t->tx.buf;
> > +	in->id =3D cpu_to_le32(ctrl_id);
> > +	in->num =3D cpu_to_le32(num);
> > +	for (i =3D 0; i < num; i++)
> > +		in->value[i] =3D cpu_to_le32(val[i]);
> > +
> > +	ret =3D ph->xops->do_xfer(ph, t);
> > +
> > +	ph->xops->xfer_put(ph, t);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops =
=3D
> {
> > +	.misc_ctrl_set =3D scmi_imx_misc_ctrl_set,
> > +	.misc_ctrl_get =3D scmi_imx_misc_ctrl_get, };
> > +
> > +static const struct scmi_protocol scmi_imx_misc =3D {
> > +	.id =3D SCMI_PROTOCOL_IMX_MISC,
> > +	.owner =3D THIS_MODULE,
> > +	.instance_init =3D &scmi_imx_misc_protocol_init,
> > +	.ops =3D &scmi_imx_misc_proto_ops,
> > +	.events =3D &scmi_imx_misc_protocol_events,
> > +	.supported_version =3D SCMI_PROTOCOL_SUPPORTED_VERSION, };
> > +module_scmi_protocol(scmi_imx_misc);
> > diff --git a/include/linux/scmi_imx_protocol.h
> > b/include/linux/scmi_imx_protocol.h
> > index 90ce011a4429..a69bd4a20f0f 100644
> > --- a/include/linux/scmi_imx_protocol.h
> > +++ b/include/linux/scmi_imx_protocol.h
> > @@ -13,8 +13,14 @@
> >  #include <linux/notifier.h>
> >  #include <linux/types.h>
> >
> > +#define SCMI_PAYLOAD_LEN	100
> > +
> > +#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
> > +#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
> > +
> >  enum scmi_nxp_protocol {
> >  	SCMI_PROTOCOL_IMX_BBM =3D 0x81,
> > +	SCMI_PROTOCOL_IMX_MISC =3D 0x84,
> >  };
> >
> >  struct scmi_imx_bbm_proto_ops {
> > @@ -42,4 +48,15 @@ struct scmi_imx_bbm_notif_report {
> >  	unsigned int		rtc_id;
> >  	unsigned int		rtc_evt;
> >  };
> > +
> > +struct scmi_imx_misc_ctrl_notify_report {
> > +	ktime_t			timestamp;
> > +	unsigned int		ctrl_id;
> > +	unsigned int		flags;
> > +};
> > +
> > +struct scmi_imx_misc_proto_ops {
> > +	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id,
> u32 num, u32 *val);
> > +	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32 id,
> > +u32 *num, u32 *val); };
> >  #endif
> >
> > --
> > 2.37.1
> >
> >
> >

