Return-Path: <linux-kernel+bounces-43850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A0841986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665A81C24F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D295364DC;
	Tue, 30 Jan 2024 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jMYv7CN6"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DD36133;
	Tue, 30 Jan 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582791; cv=fail; b=q4ABPQgkdkkGne+TrpwZrtk15gN58UrPaFge1cSlpGdr4/i/I/3MGtdVLa6CSeZM/oLHOf6g+R/jhbstcPqjI2db4v9PF3oCmyuLSg6LvCUfFUnT4KOF3Vm5J1S1sB8mrUbjHrJREwrnHro4biBU0g2DEZ+c/Bc+qxnTaCCItJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582791; c=relaxed/simple;
	bh=ziosAooaL4Qgqn/sYKicBbYMQt7FFjPi5JT0uq36fOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NogiTE6ycT8T/2rX1OP0308xOQG+LVaS+qVWRmd3FTYSBx0/X3gpgBaCuF07ACq6UthS61rCLPddejbMyb8cVN0Kz1gANmY20qYMqNnCi4yNxS3P3UH5K2q6seI0HSON6gopZDancOO5viSLVVpuKEm8Wb/ErXU03ntTawQjwbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jMYv7CN6; arc=fail smtp.client-ip=40.107.15.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2MhSQFQHfhlXhHNldBhgH12y5vay34C6E5/2QVN2I2poAe+BUM5ot09UHSe8+dQ2vQ/+qnzDbRq2nRi07cve87dwRzBaZFvN/zsMJsnmqxDowr2WGtTW/odlfSaPW6cqsdjxYW83FTtl/p32FbhUoYcvcraSPpUqZPsXgYSkkDXpSa4C/OoaP5Zf5UVXj0n1k40nqVfYOCj7RCDHfFPS8vXHshIla2sebqrz3VKt6Y8a6+fVhkL9QKW4U4RGwHyCoqOtW/hNVDC45FPHfpCGYM7E2HB9yE+Qch3QRV9RbSmXtTKznRi5dWOmg/PgSxBMyoYE9ovX/b9GwB5IBbBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIZj5jfdVMIK9y4UpWbndaaHa6pbVwUOa+oXP4CVFus=;
 b=R211rwX+TpTR+EVQAFhgeihFIAMqf2pX84tPLXt0PmkCEbtlfP8zNr2a/xExcU1Ptj7yKYhRx4TA1EQSTKE5NkwMwCm69vG/PWb1/hjXZ8oaZMvdHjJ5EpMl/wOogPQk+XE4ZjuxESnA3X2H66IRxvIXy3mFLREEYhIKEbmwwjEBqFCmU/2lBW/MKHorQaBGqX2voKjXXF6wybN2rEs9WViTBi49eGGyF3kmoWpTQAWo33mi9CGGfmPZXlukpntp4UgU/hRvZe6vFGi1YOtvi7td2ulpCCPv4TFoIxTCRwu7g2pmG1FmfxFAVRQTnm/a/9YUD9BFSUEnUGI22cr64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIZj5jfdVMIK9y4UpWbndaaHa6pbVwUOa+oXP4CVFus=;
 b=jMYv7CN6fCH4W4CBemIbbTidtLJKn6qXxtkp4N9VSbVRm3HDEzLC/NJ5vOOxVCjwPceev5fjl5ZktotaPjzyh1NEJ8IVdNXTYI8k2qPWUWYbPb6lvrzQP25eEX2b08pgAoSlD7M5HWPXR3kAD979p27DnixAd/sxmZkvcgCs/6M=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9072.eurprd04.prod.outlook.com (2603:10a6:150:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 02:46:25 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:46:25 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] perf: imx_perf: add support for i.MX95 platform
Thread-Topic: [PATCH v3 2/4] perf: imx_perf: add support for i.MX95 platform
Thread-Index: AQHaUpsSvz1QEFaWfkiniw/FfPKHurDw+yoAgACsHbA=
Date: Tue, 30 Jan 2024 02:46:24 +0000
Message-ID:
 <DU2PR04MB8822D0260340F782F5E7BE998C7D2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
 <20240129101433.2429536-2-xu.yang_2@nxp.com>
 <PAXPR04MB96425D284EC0A7CD29185771887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB96425D284EC0A7CD29185771887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|GV1PR04MB9072:EE_
x-ms-office365-filtering-correlation-id: 28284140-d782-4890-ef0d-08dc213da67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pJC588lJJonvYkB26P9PLi6OOvpvQxQrKhGtC3oS3NJA8DX3mm/kMAL5CnI+SobObQara8lZbJgprH5s5cYsQ3iCs6hWHwJ2H5X20Sb2RreQ8PnR023717XjGV79CCSviCF2t6UVydMxgjv1pijo/czzVqM68nmFHn1NGTo1dDfQbRtrTmTPH60r4eX20E+/mtdkV2zIOK0lasmDUg/gBVL4QkmM2A+t1eUQvTRcGlYSB00tn8TIiFp2nvzB6ZfWXjO3cag4YeIlok0OLJPnJhbxyJNLwrnDHtAcczn+ye9LfeZJ4okgz2plD2yKsII2EAEnhg9PDGsiieLE/3sy0DMpSo4dPXwPlMDiks5n3YSGtBvIHqg0HKYiOrVZ0Jpx0hAbos5WKKUcLswu0u72/ABG5POokevIcKY//Jk+zvJM01WY0CPZho9YxVbKYrFJfhztKSYVEWz09edNDqoxwgY2l1Sb5w7+cNuh13El43hxSSK4fyLmJK/62Qd09/z57qT3jZW4Q+1HroiRxsbUXIiHe1HMIrAuYaPJhWNQivGo7EEiD8CVtX8ErtvVQi++ds8ZRSe4lzshy4rCSfRcQDIIQ5d78Kv5NMNkNg8KYWz8fbtE4ZL+fCDMEy28yy7h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38070700009)(921011)(55016003)(26005)(71200400001)(2906002)(66446008)(6506007)(5660300002)(66556008)(7416002)(66476007)(4326008)(76116006)(110136005)(8676002)(64756008)(316002)(52536014)(66946007)(54906003)(9686003)(8936002)(7696005)(33656002)(86362001)(478600001)(38100700002)(122000001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?26gi3EB14HfgGvYLHWknYfMRIpf9UmPktzrCtkamRfyvBVw6fKAz1a2xQIas?=
 =?us-ascii?Q?MzWZqNU3I3ssnBoM0YGU5f7t/od7pIEl1C1UG42zv/h23gqO8EF5/KCAKAif?=
 =?us-ascii?Q?inytasAnN9OCEsZ4SqmuG3I9sJbxcpTlrXdyPLFgDUtttc9bBGRBReYRYdsm?=
 =?us-ascii?Q?eiMRlUnm17pM7Y53ls1/mr3t6GwCI/L0R/KDt1p2s3OGG3Nz/0FhoeuVAS94?=
 =?us-ascii?Q?KW1NUxoR+/xQPG8pzfHhIR3pEtfACQUNPc05uAZ8Q9kyLAMYh/npDDHN9krs?=
 =?us-ascii?Q?VkoJSvOzE3mD4Zmjb3jw4xyJiprb4F1m6wOwHEe+E6y/083ZkjG6NqA8UDyR?=
 =?us-ascii?Q?5tF3OchQYGzul+N9ThS5HIzS+PAgUAP/E8a8blKxf2HM1x0Qtj7XKKR1UA22?=
 =?us-ascii?Q?5S3BmqauWCJzifgPNAXWqjTAeBvt7qQV0lHs6OuO5eQDg6v3fUcJhKO2XJKQ?=
 =?us-ascii?Q?5NQ7/x1Y53JJBtRpyIa9aIfkZTYQYEEHlchUsRKdoSAdOW4ChT3e/UlxZn/A?=
 =?us-ascii?Q?2a6WGAVgaAuspISPS1AcUjnLL5phXBSFmEiJLFje/ZpHHVJYdkyulxN9TUNk?=
 =?us-ascii?Q?Gwc4GFxkhg6LUKq1BdIZt3URKfXgOlbxPioJU2NeCEJCEcENZjPOeKt0QiYt?=
 =?us-ascii?Q?38rpGJ8RoJm92sjjGmnuoq0h+n6/+k2DWt89CyMNBBx5We4KbYtWz064f3tN?=
 =?us-ascii?Q?4A5nEsHAfZ/wZviLvFAc0K63Fp+o1c9Ji3vLWJLGw4IpeFYyXt4Cnh14uRjs?=
 =?us-ascii?Q?+mXKdb540xcqEh/6AshORuwI1+45KojVC5vBLo+eYCqVCPFD27a+UWgRpQvw?=
 =?us-ascii?Q?5yb2hw8NKHPIhbNfzBfk/neBzsPcwYkc0WmzTVXhlB5SBGemQnpdQH689KJZ?=
 =?us-ascii?Q?AkQB+pJ0KhXA5843W/wVQ85TjnR3+xuPAW2CX9mGiohtjZTu8uiVATohPAQj?=
 =?us-ascii?Q?rL87hA+vatuSsmXtbY2fyMtjVTX/aUlr3dye5hNILcfFjXQIUAN9ikAbVeHv?=
 =?us-ascii?Q?qLnZoPB9pn//+LQd6qQSPow3LuLMZF2Z9a70iwfBfLEnBtfi9bZQJ+FBXRyM?=
 =?us-ascii?Q?dKK3ZCPA4ALxH4J2h8OUycGrhg9i9fbGs3gpq4bCJ9T/OOt6kl2TITOStrzh?=
 =?us-ascii?Q?9pXje9ZmvS+JJfjYGYTewPpvCWDEo1jgYILqXLhgDxrlXtywL+AqIi+Lvfej?=
 =?us-ascii?Q?26yF3sGn42eYL/KQgpNzVJK4kBzvtnZwipjHrLwWsC0FqKNBlHU3tPfruq9i?=
 =?us-ascii?Q?9TXB7gMhqCKKSg1ZKU45z8Kn29TJxCIzP96dvg1h2bzTtV5wTJ5vgx3f5FTD?=
 =?us-ascii?Q?fjSv82MLJDNRzZxWKdvkEwelcmy4+2/xxUQLUmQVGubFp3vHxWuVYuvzFqmo?=
 =?us-ascii?Q?pTJJDQMPJYkeqiXM5PH3PqOZMWB4dJtR24CVEu97ptfcJeH+3Bsw1D78rrQZ?=
 =?us-ascii?Q?/eep5ct+VJpB2bb5U5e9PH/2ZDxz3iE03gvzvFyr8QCcD0aa6j9Y1QarobqE?=
 =?us-ascii?Q?SMUNOm5pPMzjNO9QhQwyhTE2Y/uuBNjPAmcE8x7hZwSLn5Ia6MTzdgoNKPD2?=
 =?us-ascii?Q?X+CMAB8TZCZJ1BV86NM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28284140-d782-4890-ef0d-08dc213da67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 02:46:24.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /n6ylkGXKQSZKIps+B4kFI8gE8vhLlcgpBm/ttBazr8Yn92f1yq5Dm+Iy20P8dsjC0aygmCcWQISsMoJ5pyO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9072


> > Subject: [PATCH v3 2/4] perf: imx_perf: add support for i.MX95 platform
> >
> > i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> > read beat and write beat filter capabilities. This will add support for
> > i.MX95 and enhance the driver to support specific filter handling for i=
t.
> >
> > Usage:
> >
> > For read beat:
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3D3,axi_mask=3DID_MASK,axi_id
> > =3DID/
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=3D4,axi_mask=3DID_MASK,axi_id
> > =3DID/
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3DID_MASK,axi_id
> > =3DID/
> > eg: For edma2: perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3D0x00f,axi_id=
=3D0x0
> > 0c/
> >
> > For write beat:
> > ~# perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3DID_MASK,axi_id=
=3D
> > ID/
> > eg: For edma2: perf stat -a -I 1000 -e
> > imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3D0x00f,axi_id=3D=
0x00
> > c/
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> >
> > ---
> > Changes in v2:
> >  - put soc spefific axi filter events to drvdata according
> >    to franks suggestions.
> >  - adjust pmcfg axi_id and axi_mask config
> > Changes in v3:
> >  - no changes
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 203 +++++++++++++++++++++++++-----
>=20
> I suggest you split this two patch.
> 1st patch rework imx93 only, which prepare for add imx95. All function is=
 equal.
> 2nd patch add imx95.

Okay, I'll do that in next vesion.

Thanks,
Xu Yang

