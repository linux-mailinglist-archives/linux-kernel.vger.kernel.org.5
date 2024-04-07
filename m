Return-Path: <linux-kernel+bounces-134350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADD89B08E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D491C2132C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C318C1F;
	Sun,  7 Apr 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rUfy+o83"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2134.outbound.protection.outlook.com [40.107.7.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515D199BC;
	Sun,  7 Apr 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712488605; cv=fail; b=MIYJlytXLyA1Ckt/fTCmD//e7R4SLWt/dQPi1SFI+fLIccRNw0hFPwtahepAy/fsmznrq1hb/2niID4UOI6uPbvgDrMXFPUwPzCa8WM5oxFYVW9NadrGNEZiD2FssZN9THx9SACJ9sXze/M4OS4fieZrTpN7+YkB2fRNSwa+91g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712488605; c=relaxed/simple;
	bh=fvWW0JqNiUg6RafmKvaeTb1VzqnDCM1DK7tTku48ElQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MYooUdhUigiWlyxfzZSiLnRAcSp9R/T/lMZiyD4S8EDLp2o6otjp5B0MaZBGXIl1PfnNEp3R+/8UbpvLEGVKKiOLIdS8TKwhmIkt/+M0e9EYyE31u/hqt4Eyf9OZcPDEz3KkwDGunxEe/Qvl1oQo/YS9+JmFpqpDV+nvdMw72P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rUfy+o83; arc=fail smtp.client-ip=40.107.7.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWWlqqNd6EFCz4yW6x7xaPOs7LiHH+mX5GfqGcuwGdzhJxFe43kf1tOPPn4tlWsk/m8mDWIZ9qgqz4X0ZUXpyaVK+7qFhfyZillCeX0mD+o56mVFfJCwf1n1psRgSuUphrWtq8oeTeB6eoPTn4zDfCRmYFOgVlXKhdVF446FqaFDxPdBE5Se1xpPgkJaKrDirhoG7k1bhdmFr6q0S2SP077AGjHI5aUFAaMz6BJsk2hygC72IjeXMxn5QmD6nIAAJhMI0uApNfhVV4pLTkEqv24y7iVZSar8443tycYiTuHSLKIJ6RQP5j3sAivhFT0tinXGdDhbp5YcQKQLSF/2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS7hGFR+XMsfk3AN/BdJFTCetrFqxDvYbgamdIUv4+M=;
 b=NwvDaP2cAaR3cBe/Yts1puytk5OxH7OFXft5ObNasy4d5ebK1EX5PTMo0+lGxeVoco0JQfvO3HCRtW2oPJiDf/g7Plm3Jm2QFb80tbJhyZXEoxXRmzprsHwnTshzhl6x6KBNx2bmqA4evDYgz95dboDxYGk4buMh/1K7vCvD5zuiYcd4ap38stA975er69V8ULVuXWEuLHhQVVhshWVPMPwzm1vWpRBQJffcgSEQF3QJ9OdEv6wwV+n/CdhWbJ14sBAp+sJTGMttISBm51eJVuTJ8vINP0N2CkcIlhuLJ/vrswUWUwaIQhQw48z47l19n/LgStNqjvBqKCl3RLg1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS7hGFR+XMsfk3AN/BdJFTCetrFqxDvYbgamdIUv4+M=;
 b=rUfy+o83jgwYe9Ur0y5iGvzGjY3t9LwVHaFVkOgercufKmI5llV6eXkGkrVtZBDc52qcUscrg6EOcw/tdjmJaxkiLjufCP938z0K6xWdBFKRQCSS+mq9bYT1f+ZhNlhLeCt3KZ7HNF6YScD2rjeRAghjKD2NpOsVhNGoQgu2vn8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7389.eurprd04.prod.outlook.com (2603:10a6:800:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sun, 7 Apr
 2024 11:16:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 11:16:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Thread-Topic: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i.MX
 MISC protocol
Thread-Index: AQHah1U+Ouni2yxGIkadGTHqoE9cS7FZ4lEAgAIamiCAAKp7AIAAAzXw
Date: Sun, 7 Apr 2024 11:16:37 +0000
Message-ID:
 <DU0PR04MB9417B68CB792296285436B4988012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-4-9fc9186856c2@nxp.com>
 <20240405164414.t3fqhnwudxxt2ozv@pengutronix.de>
 <DU0PR04MB9417A07F56B7E14DAB3DCE2188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240407110208.4huirwif7as3dsps@pengutronix.de>
In-Reply-To: <20240407110208.4huirwif7as3dsps@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VE1PR04MB7389:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yT5laPZK5KllMldPn3hBcFJZ8MKXkzMM7b82Wv5nzUZECWtbXeAyE5291/9vIdILuWPZq2h+Yy/7evp/d8L4lJ75OXoP4oZP8oqGIlagEgiMYI4RgleLm+Twh6dQCzz3fHUFpXDP1p023kH6YPX7wfyntlJbj3AxvS2vqhvCvk8FLwJOzgKWoxJIj/mz/iD178QIEtezjlPM7xxHuGmOIfZyo3qXK2bco48tPFisrd1be3C3KflDpf5dnS3iAwD09oRrkJpD0uMErvx/Mh1xS+ue1ulGZiI5KGe7DnnNFVD/87eNDPsugf9vUGmAIcaYjJtY3GYgGHhV99RG8UakUwrm94+h03NUigMP03o63su6T6030hlA7HwBbMNwp+p/FVWCALBQx5oHcz2ABfwd67D8vSbadVkK+6qIt7BDHOGkUvKqVjOdKxD2aSgKRU6NGDdgBbkaohoSEes+E0VLDHkBXRz507zqO+Wi/5JHsNL5rs6i58jgZjfuHdiwqUj2bEk1/1aUF++ZY8xc/i69YbscQyu//0+7f1jiq6peRf235bB5J4YHoWYRzrJ97VfdziAIahWc4914JO80RVrkosigFX2bSk5iYNzvTbaM0ts2xgtY/O7r2vY7IxzaNuTF6GwyXxSc8ZYnbIO1mQjwygycEuhpIJ97nv8yU8TaIwY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kCvrOmLLgWdk9crA1oBk3JSw5sqpvF3PHINtlrzbIhZf9i5ZalkF5elex+w6?=
 =?us-ascii?Q?i/Jn6yb/4w+/9b+TVfWXHTOhr7jMa5fZqLln8rB9OsBdVhZfOfy6A1f6QEaJ?=
 =?us-ascii?Q?pFpvn5lj4fWhUSCNfSjWvScfVye8EENYW4ynm2FvZOpf2/lkTGbfV4Iv2oK1?=
 =?us-ascii?Q?xfAJftYxQU1MzjfQepwXki/1zkrXIF/kB89E0SS1GvIgryuPWCc13to8NJKZ?=
 =?us-ascii?Q?Z5NjwtI/FOT2XVXbd0jKaDRqpvUPSGR8mgi/ZnQQUZBrGIrLqmbYCPKywTSh?=
 =?us-ascii?Q?RYin/0vkG21OIMe96K0V9rKbItggqo6sIafOYjDYJP5BADRAsGNXarrG+/aQ?=
 =?us-ascii?Q?kdp3gcc9dQtpOuPsYniN7ZaXnF9zidWD+FuUWXzLiJakrAvKj3Hs8srVCxqH?=
 =?us-ascii?Q?kS/DCGCiud33jjHsVEypAHmnG67aGMwHbnyCE8DK+RjyiKb8nLtdqzoHrr9B?=
 =?us-ascii?Q?B3Mp73HPIoZOtbxMIF4EaYNsx7FQyKFOTICZ0TqEpjZM0wFqQHVfy+ieYN+B?=
 =?us-ascii?Q?nFG2egYg1NSWPE6WOmLlrZQrPCcYL7um/Sa3CDAl3QagdX13gBnDQbd6souk?=
 =?us-ascii?Q?sCaLaMoYG3yolwFc+vWpzPHZUaJKkZcSpY0hQZq8FQACyLMZ/Eb8fk7W7pSW?=
 =?us-ascii?Q?yiHOzMa8dbsiqFqMLpaMB7lg+6yyv++Ib1WRSrRgNAp6EsD/4UtCT79OEJ4i?=
 =?us-ascii?Q?OYmmjuB3URNjoxxzHXtfq2Zlv2qdQmyqLfuAv3Ro/GNs3J2Kqj2ztJ+yKwLx?=
 =?us-ascii?Q?8QFf6e1VnvZtz2YRfK4DTYgKoZ64z1bVjkXGruWClG8sGjaxA570pw/Dk9l5?=
 =?us-ascii?Q?iqaeIZOPIaojCgU4hti8Ak6BfM97tz6/GIlb81ZHWO94DxjbCye97LzjEMbB?=
 =?us-ascii?Q?dgQq6NRiN8tUYakoWNXxp8KHx6fVEOvAzcoKR9lf49FGGmSR8NnPRGHwhCs6?=
 =?us-ascii?Q?Vg/5Db3OiVJlORFsY1eSUU/2BRHEJuiLg/qJiOBYHCupQJI7mnGc3NF5Q92x?=
 =?us-ascii?Q?wHtpLtYkVXGIRQIVxi+MdXQXihMgqrl33ORdpalz/Lwy9kVy1FGoBIIwOPHW?=
 =?us-ascii?Q?M8gYQd6miSqGjHYBDvCgKfq1kj4CoyMcpRxyK2DGjIdycCx2gEzqF+aTrPT6?=
 =?us-ascii?Q?AMxYcHcdw4gpc9dpCQen6UI5u4yKoQg/ax5nFxHK0yo8sITcOTRWbaEYq/XF?=
 =?us-ascii?Q?HBARDLQdr6JR1d1Zn+wrW7bFd5U26iP8fMZUE9dSkbUk9bxXKpkKAvYZJYhe?=
 =?us-ascii?Q?pyEc2Hu38nPcy7C9UlDl9TpgECOcLGNMC2tSrr1HBAU5sYhjL3EaC4I3kdCp?=
 =?us-ascii?Q?OMh/6oSt4RcJO7iXJ/PHRN6hdyEkjBX+sfohu5meS2W2Dzs4aZ2uR2nQ/wjb?=
 =?us-ascii?Q?hZqFm0Ba9jD9rydGFLMbOvuPzj7HrM0RD8u7SmCfbP0XLvEUq5pfH+iYbB3L?=
 =?us-ascii?Q?gST4g7JCvudc/muzz7ho54j+LsxZd7QtXmqNG3gNbGIGyjWH53xd0T1OE3GV?=
 =?us-ascii?Q?VIa36uSUcfeYNDVbg1cWWeNHID9HhzxVtSOimItLqcfp+k32ObUyjanQn3Am?=
 =?us-ascii?Q?Yqy7iamJNZG7HWZzCRw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa766f3-dcd1-4c4d-cad3-08dc56f430f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 11:16:37.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w69Xkniq3Y36P3mNPeAkaY4A5z93nx+8jJSL+aePfWirkh1kaEm5WV1WR6pNtJ4bEBefXziqH0cTOhbvAGTKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7389

> Subject: Re: [PATCH v2 4/6] firmware: arm_scmi: add initial support for i=
MX
> MISC protocol
>=20
> Hi Peng,
>=20
> On 24-04-07, Peng Fan wrote:
> > > Subject: Re: [PATCH v2 4/6] firmware: arm_scmi: add initial support
> > > for i.MX MISC protocol
> > >
> > > Hi Peng,
> > >
> > > On 24-04-05, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > The i.MX MISC protocol is for misc settings, such as gpio expander
> > > > wakeup.
> > >
> > > Can you elaborate a bit more please?
> >
> > The gpio expander is under M33(SCMI firmware used core) I2C control,
>=20
> Due to missing technical references I guess that your specific EVK has an=
 i2c-
> expander connected to the system-critical-i2c bus? The system-critical-i2=
c
> should be only used for system critical topics like PMIC control.

Right.

>=20
> > But the gpio expander supports board function such as PCIE_WAKEUP,
> > BTN_WAKEUP. So these are managed by MISC protocol.
>=20
> This seems more like an specific i.MX95-EVK problem too me since you have
> conneccted the i2c-gpio-expander to the system-critical-i2c bus instead o=
f
> using an bus available within Linux. Also can you please provide me a lin=
k
> with the propsoal for the MISC protocol? I can't find any references with=
in the
> SCMI v3.2

It is i.MX VENDOR Extension, not a standard one in Spec.

> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdevel=
o
> per.arm.com%2Fdocumentation%2Fden0056%2Fe%2F&data=3D05%7C02%7Cp
> eng.fan%40nxp.com%7C6120357a772045a0618808dc56f22c95%7C686ea1d
> 3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638480845336536607%7CUnk
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> 1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DNI%2F8WMPuGzJwD74
> 1jcuknHZUR5uI2me9iEeWbeDKshE%3D&reserved=3D0 nor within the SCP
> firmware git:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2FARM-software%2FSCP-
> firmware&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C6120357a772045a06
> 18808dc56f22c95%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> 638480845336550459%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C
> &sdata=3DN3bT9ItgvL4Z9xP1oxlmDTG%2FFjsXkuhJIA9wooJWfcM%3D&reserve
> d=3D0.
>=20
> > SAI_CLK_MSEL in WAKEUP BLK CTRL is also managed by MISC Protocol.
>=20
> You recently said that we need blk-ctrl drivers for managing/controlling =
the
> GPR stuff within Linux since the SCMI firmware does not support this. Now
> blk-ctrl GPR control is supported by the firmware?

AONMIX/WAKEUPMIX BLK CTRL is managed by SCMI firmware, for other
non system critical BLK CTRLs, they are managed by Linux directly, such as
GPU/VPU BLK CTRL and etc.

Regards,
Peng.
>=20
> Regards,
>   Marco
>=20
> >
> > And etc...
> >
> > I will add more info in commit log in next version later, after I get
> > more reviews on the patchset.
> >
> > Thanks,
> > Peng.
> >
> > >
> > > Regards,
> > >   Marco
> > >
> > >
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/firmware/arm_scmi/Kconfig       |  10 ++
> > > >  drivers/firmware/arm_scmi/Makefile      |   1 +
> > > >  drivers/firmware/arm_scmi/imx-sm-misc.c | 305
> > > ++++++++++++++++++++++++++++++++
> > > >  include/linux/scmi_imx_protocol.h       |  17 ++
> > > >  4 files changed, 333 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/arm_scmi/Kconfig
> > > > b/drivers/firmware/arm_scmi/Kconfig
> > > > index 56d11c9d9f47..bfeae92f6420 100644
> > > > --- a/drivers/firmware/arm_scmi/Kconfig
> > > > +++ b/drivers/firmware/arm_scmi/Kconfig
> > > > @@ -191,3 +191,13 @@ config IMX_SCMI_BBM_EXT
> > > >  	  and BUTTON.
> > > >
> > > >  	  This driver can also be built as a module.
> > > > +
> > > > +config IMX_SCMI_MISC_EXT
> > > > +	tristate "i.MX SCMI MISC EXTENSION"
> > > > +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> > > > +	default y if ARCH_MXC
> > > > +	help
> > > > +	  This enables i.MX System MISC control logic such as gpio expand=
er
> > > > +	  wakeup
> > > > +
> > > > +	  This driver can also be built as a module.
> > > > diff --git a/drivers/firmware/arm_scmi/Makefile
> > > > b/drivers/firmware/arm_scmi/Makefile
> > > > index 327687acf857..a23fde721222 100644
> > > > --- a/drivers/firmware/arm_scmi/Makefile
> > > > +++ b/drivers/firmware/arm_scmi/Makefile
> > > > @@ -12,6 +12,7 @@ scmi-transport-
> > > $(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO)
> > > > +=3D virtio.o
> > > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=3D optee.o
> > > > scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.=
o
> > > > system.o voltage.o powercap.o
> > > >  scmi-protocols-$(CONFIG_IMX_SCMI_BBM_EXT) +=3D imx-sm-bbm.o
> > > > +scmi-protocols-$(CONFIG_IMX_SCMI_MISC_EXT) +=3D imx-sm-misc.o
> > > >  scmi-module-objs :=3D $(scmi-driver-y) $(scmi-protocols-y)
> > > > $(scmi-transport-y)
> > > >
> > > >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) +=3D scmi-core.o diff --git
> > > > a/drivers/firmware/arm_scmi/imx-sm-misc.c
> > > > b/drivers/firmware/arm_scmi/imx-sm-misc.c
> > > > new file mode 100644
> > > > index 000000000000..1b0ec2281518
> > > > --- /dev/null
> > > > +++ b/drivers/firmware/arm_scmi/imx-sm-misc.c
> > > > @@ -0,0 +1,305 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * System control and Management Interface (SCMI) NXP MISC
> > > > +Protocol
> > > > + *
> > > > + * Copyright 2024 NXP
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) "SCMI Notifications MISC - " fmt
> > > > +
> > > > +#include <linux/bits.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/platform_device.h> #include
> > > > +<linux/scmi_protocol.h> #include <linux/scmi_imx_protocol.h>
> > > > +
> > > > +#include "protocols.h"
> > > > +#include "notify.h"
> > > > +
> > > > +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
> > > > +
> > > > +enum scmi_imx_misc_protocol_cmd {
> > > > +	SCMI_IMX_MISC_CTRL_SET	=3D 0x3,
> > > > +	SCMI_IMX_MISC_CTRL_GET	=3D 0x4,
> > > > +	SCMI_IMX_MISC_CTRL_NOTIFY =3D 0x8, };
> > > > +
> > > > +struct scmi_imx_misc_info {
> > > > +	u32 version;
> > > > +	u32 nr_dev_ctrl;
> > > > +	u32 nr_brd_ctrl;
> > > > +	u32 nr_reason;
> > > > +};
> > > > +
> > > > +struct scmi_msg_imx_misc_protocol_attributes {
> > > > +	__le32 attributes;
> > > > +};
> > > > +
> > > > +#define GET_BRD_CTRLS_NR(x)	le32_get_bits((x), GENMASK(31,
> > > 24))
> > > > +#define GET_REASONS_NR(x)	le32_get_bits((x), GENMASK(23,
> 16))
> > > > +#define GET_DEV_CTRLS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> > > > +#define BRD_CTRL_START_ID	BIT(15)
> > > > +
> > > > +struct scmi_imx_misc_ctrl_set_in {
> > > > +	__le32 id;
> > > > +	__le32 num;
> > > > +	__le32 value[MISC_MAX_VAL];
> > > > +};
> > > > +
> > > > +struct scmi_imx_misc_ctrl_notify_in {
> > > > +	__le32 ctrl_id;
> > > > +	__le32 flags;
> > > > +};
> > > > +
> > > > +struct scmi_imx_misc_ctrl_notify_payld {
> > > > +	__le32 ctrl_id;
> > > > +	__le32 flags;
> > > > +};
> > > > +
> > > > +struct scmi_imx_misc_ctrl_get_out {
> > > > +	__le32 num;
> > > > +	__le32 *val;
> > > > +};
> > > > +
> > > > +static int scmi_imx_misc_attributes_get(const struct
> > > > +scmi_protocol_handle
> > > *ph,
> > > > +					struct scmi_imx_misc_info *mi) {
> > > > +	int ret;
> > > > +	struct scmi_xfer *t;
> > > > +	struct scmi_msg_imx_misc_protocol_attributes *attr;
> > > > +
> > > > +	ret =3D ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
> > > > +				      sizeof(*attr), &t);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	attr =3D t->rx.buf;
> > > > +
> > > > +	ret =3D ph->xops->do_xfer(ph, t);
> > > > +	if (!ret) {
> > > > +		mi->nr_dev_ctrl =3D GET_DEV_CTRLS_NR(attr->attributes);
> > > > +		mi->nr_brd_ctrl =3D GET_BRD_CTRLS_NR(attr->attributes);
> > > > +		mi->nr_reason =3D GET_REASONS_NR(attr->attributes);
> > > > +		dev_info(ph->dev, "i.MX MISC NUM DEV CTRL: %d, NUM
> > > BRD CTRL: %d,NUM Reason: %d\n",
> > > > +			 mi->nr_dev_ctrl, mi->nr_brd_ctrl, mi->nr_reason);
> > > > +	}
> > > > +
> > > > +	ph->xops->xfer_put(ph, t);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int scmi_imx_misc_ctrl_validate_id(const struct
> > > scmi_protocol_handle *ph,
> > > > +					  u32 ctrl_id)
> > > > +{
> > > > +	struct scmi_imx_misc_info *mi =3D ph->get_priv(ph);
> > > > +
> > > > +	if ((ctrl_id < BRD_CTRL_START_ID) && (ctrl_id > mi->nr_dev_ctrl))
> > > > +		return -EINVAL;
> > > > +	if (ctrl_id >=3D BRD_CTRL_START_ID + mi->nr_brd_ctrl)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int scmi_imx_misc_ctrl_notify(const struct
> > > > +scmi_protocol_handle
> > > *ph,
> > > > +				     u32 ctrl_id, u32 flags)
> > > > +{
> > > > +	struct scmi_imx_misc_ctrl_notify_in *in;
> > > > +	struct scmi_xfer *t;
> > > > +	int ret;
> > > > +
> > > > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_NOTIFY,
> > > > +				      sizeof(*in), 0, &t);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	in =3D t->tx.buf;
> > > > +	in->ctrl_id =3D cpu_to_le32(ctrl_id);
> > > > +	in->flags =3D cpu_to_le32(flags);
> > > > +
> > > > +	ret =3D ph->xops->do_xfer(ph, t);
> > > > +
> > > > +	ph->xops->xfer_put(ph, t);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int
> > > > +scmi_imx_misc_ctrl_set_notify_enabled(const struct
> > > scmi_protocol_handle *ph,
> > > > +				      u8 evt_id, u32 src_id, bool enable) {
> > > > +	int ret;
> > > > +
> > > > +	ret =3D scmi_imx_misc_ctrl_notify(ph, src_id, enable ? evt_id : 0=
);
> > > > +	if (ret)
> > > > +		dev_err(ph->dev, "FAIL_ENABLED - evt[%X] src[%d] -
> > > ret:%d\n",
> > > > +			evt_id, src_id, ret);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int scmi_imx_misc_ctrl_get_num_sources(const struct
> > > > +scmi_protocol_handle *ph) {
> > > > +	return GENMASK(15, 0);
> > > > +}
> > > > +
> > > > +static void *
> > > > +scmi_imx_misc_ctrl_fill_custom_report(const struct
> > > > +scmi_protocol_handle
> > > *ph,
> > > > +				      u8 evt_id, ktime_t timestamp,
> > > > +				      const void *payld, size_t payld_sz,
> > > > +				      void *report, u32 *src_id) {
> > > > +	const struct scmi_imx_misc_ctrl_notify_payld *p =3D payld;
> > > > +	struct scmi_imx_misc_ctrl_notify_report *r =3D report;
> > > > +
> > > > +	if (sizeof(*p) !=3D payld_sz)
> > > > +		return NULL;
> > > > +
> > > > +	r->timestamp =3D timestamp;
> > > > +	r->ctrl_id =3D p->ctrl_id;
> > > > +	r->flags =3D p->flags;
> > > > +	*src_id =3D r->ctrl_id;
> > > > +	dev_dbg(ph->dev, "%s: ctrl_id: %d flags: %d\n", __func__,
> > > > +		r->ctrl_id, r->flags);
> > > > +
> > > > +	return r;
> > > > +}
> > > > +
> > > > +static const struct scmi_event_ops scmi_imx_misc_event_ops =3D {
> > > > +	.get_num_sources =3D scmi_imx_misc_ctrl_get_num_sources,
> > > > +	.set_notify_enabled =3D scmi_imx_misc_ctrl_set_notify_enabled,
> > > > +	.fill_custom_report =3D scmi_imx_misc_ctrl_fill_custom_report,
> > > > +};
> > > > +
> > > > +static const struct scmi_event scmi_imx_misc_events[] =3D {
> > > > +	{
> > > > +		.id =3D SCMI_EVENT_IMX_MISC_CONTROL_DISABLED,
> > > > +		.max_payld_sz =3D sizeof(struct
> > > scmi_imx_misc_ctrl_notify_payld),
> > > > +		.max_report_sz =3D sizeof(struct
> > > scmi_imx_misc_ctrl_notify_report),
> > > > +	},
> > > > +	{
> > > > +		.id =3D SCMI_EVENT_IMX_MISC_CONTROL_FALLING_EDGE,
> > > > +		.max_payld_sz =3D sizeof(struct
> > > scmi_imx_misc_ctrl_notify_payld),
> > > > +		.max_report_sz =3D sizeof(struct
> > > scmi_imx_misc_ctrl_notify_report),
> > > > +	},
> > > > +	{
> > > > +		.id =3D SCMI_EVENT_IMX_MISC_CONTROL_RISING_EDGE,
> > > > +		.max_payld_sz =3D sizeof(struct
> > > scmi_imx_misc_ctrl_notify_payld),
> > > > +		.max_report_sz =3D sizeof(struct
> > > scmi_imx_misc_ctrl_notify_report),
> > > > +	}
> > > > +};
> > > > +
> > > > +static struct scmi_protocol_events scmi_imx_misc_protocol_events =
=3D {
> > > > +	.queue_sz =3D SCMI_PROTO_QUEUE_SZ,
> > > > +	.ops =3D &scmi_imx_misc_event_ops,
> > > > +	.evts =3D scmi_imx_misc_events,
> > > > +	.num_events =3D ARRAY_SIZE(scmi_imx_misc_events), };
> > > > +
> > > > +static int scmi_imx_misc_protocol_init(const struct
> > > > +scmi_protocol_handle *ph) {
> > > > +	struct scmi_imx_misc_info *minfo;
> > > > +	u32 version;
> > > > +	int ret;
> > > > +
> > > > +	ret =3D ph->xops->version_get(ph, &version);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	dev_info(ph->dev, "NXP SM MISC Version %d.%d\n",
> > > > +		 PROTOCOL_REV_MAJOR(version),
> > > PROTOCOL_REV_MINOR(version));
> > > > +
> > > > +	minfo =3D devm_kzalloc(ph->dev, sizeof(*minfo), GFP_KERNEL);
> > > > +	if (!minfo)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ret =3D scmi_imx_misc_attributes_get(ph, minfo);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return ph->set_priv(ph, minfo, version); }
> > > > +
> > > > +static int scmi_imx_misc_ctrl_get(const struct scmi_protocol_handl=
e
> *ph,
> > > > +				  u32 ctrl_id, u32 *num, u32 *val) {
> > > > +	struct scmi_imx_misc_ctrl_get_out *out;
> > > > +	struct scmi_xfer *t;
> > > > +	int ret, i;
> > > > +
> > > > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_GET,
> > > sizeof(u32),
> > > > +				      0, &t);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	put_unaligned_le32(ctrl_id, t->tx.buf);
> > > > +	ret =3D ph->xops->do_xfer(ph, t);
> > > > +	if (!ret) {
> > > > +		out =3D t->rx.buf;
> > > > +		*num =3D le32_to_cpu(out->num);
> > > > +		for (i =3D 0; i < *num && i < MISC_MAX_VAL; i++)
> > > > +			val[i] =3D le32_to_cpu(out->val[i]);
> > > > +	}
> > > > +
> > > > +	ph->xops->xfer_put(ph, t);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handl=
e
> *ph,
> > > > +				  u32 ctrl_id, u32 num, u32 *val) {
> > > > +	struct scmi_imx_misc_ctrl_set_in *in;
> > > > +	struct scmi_xfer *t;
> > > > +	int ret, i;
> > > > +
> > > > +	ret =3D scmi_imx_misc_ctrl_validate_id(ph, ctrl_id);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (num > MISC_MAX_VAL)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret =3D ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CTRL_SET,
> > > sizeof(*in),
> > > > +				      0, &t);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	in =3D t->tx.buf;
> > > > +	in->id =3D cpu_to_le32(ctrl_id);
> > > > +	in->num =3D cpu_to_le32(num);
> > > > +	for (i =3D 0; i < num; i++)
> > > > +		in->value[i] =3D cpu_to_le32(val[i]);
> > > > +
> > > > +	ret =3D ph->xops->do_xfer(ph, t);
> > > > +
> > > > +	ph->xops->xfer_put(ph, t);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static const struct scmi_imx_misc_proto_ops
> > > > +scmi_imx_misc_proto_ops =3D
> > > {
> > > > +	.misc_ctrl_set =3D scmi_imx_misc_ctrl_set,
> > > > +	.misc_ctrl_get =3D scmi_imx_misc_ctrl_get, };
> > > > +
> > > > +static const struct scmi_protocol scmi_imx_misc =3D {
> > > > +	.id =3D SCMI_PROTOCOL_IMX_MISC,
> > > > +	.owner =3D THIS_MODULE,
> > > > +	.instance_init =3D &scmi_imx_misc_protocol_init,
> > > > +	.ops =3D &scmi_imx_misc_proto_ops,
> > > > +	.events =3D &scmi_imx_misc_protocol_events,
> > > > +	.supported_version =3D SCMI_PROTOCOL_SUPPORTED_VERSION, };
> > > > +module_scmi_protocol(scmi_imx_misc);
> > > > diff --git a/include/linux/scmi_imx_protocol.h
> > > > b/include/linux/scmi_imx_protocol.h
> > > > index 90ce011a4429..a69bd4a20f0f 100644
> > > > --- a/include/linux/scmi_imx_protocol.h
> > > > +++ b/include/linux/scmi_imx_protocol.h
> > > > @@ -13,8 +13,14 @@
> > > >  #include <linux/notifier.h>
> > > >  #include <linux/types.h>
> > > >
> > > > +#define SCMI_PAYLOAD_LEN	100
> > > > +
> > > > +#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
> > > > +#define MISC_MAX_VAL		SCMI_ARRAY(8, uint32_t)
> > > > +
> > > >  enum scmi_nxp_protocol {
> > > >  	SCMI_PROTOCOL_IMX_BBM =3D 0x81,
> > > > +	SCMI_PROTOCOL_IMX_MISC =3D 0x84,
> > > >  };
> > > >
> > > >  struct scmi_imx_bbm_proto_ops {
> > > > @@ -42,4 +48,15 @@ struct scmi_imx_bbm_notif_report {
> > > >  	unsigned int		rtc_id;
> > > >  	unsigned int		rtc_evt;
> > > >  };
> > > > +
> > > > +struct scmi_imx_misc_ctrl_notify_report {
> > > > +	ktime_t			timestamp;
> > > > +	unsigned int		ctrl_id;
> > > > +	unsigned int		flags;
> > > > +};
> > > > +
> > > > +struct scmi_imx_misc_proto_ops {
> > > > +	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32
> > > > +id,
> > > u32 num, u32 *val);
> > > > +	int (*misc_ctrl_get)(const struct scmi_protocol_handle *ph, u32
> > > > +id,
> > > > +u32 *num, u32 *val); };
> > > >  #endif
> > > >
> > > > --
> > > > 2.37.1
> > > >
> > > >
> > > >
> >

