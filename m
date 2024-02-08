Return-Path: <linux-kernel+bounces-57535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD084DA58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E20284942
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D346930C;
	Thu,  8 Feb 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZS+wCJ46"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB467E8D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374880; cv=fail; b=Adbe4TejzdoBBn4LTzcMj4/vvym3sTtdTALMR1wPdxwiwVSsPdRpL7Dxr2NJO6NlKRn4XmfGqoN6l8SFiHsd75B31CPECt1uNvuZi6iRW5TbpJbp1x5TjUTGfee4vpszrDb9FvbXd3Wpmum/Su2eGTAqZHDesYWxbwXmnMMGSLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374880; c=relaxed/simple;
	bh=Vyx93cBvpI9UUB/YyzY6XSTzecyIl3zlaNkmP6ZGSZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eW9OhHXa0LTEpcpIRMWLhKeeGmI+Vv8FzmVDygX49GJ/+Tbp27HEcFJ7zH8j/uZB39a/q20MMz+wXfqhq5X0FpokLbsfEoAirPreaJUKHw3Ao5fuaMs5D6EuCt6tCYBSa2IeYIugKP5iM6SvBEh8tQo1vevrQ1tPGLTSuO8qbnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZS+wCJ46; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2hniwpRv9af1n5/DXoxvSXSS0YrqSs6YEVZnFyuMxXDNjY2bgc+YfBHeQbEpA1Tufgld3hlbRGsIKlm2IN1ACM7IXYkxk2iTiaLq14A/AMScOgpKPzmQZXZy30jls/q3Sgtr46ej+MpUuIZIDGu3qiBtCQvi2nMhdQKSqTmCEnkJLBwZxpeT+Lk7OYWNERjgq5Rd9FTaxTBylI3QUnHSwypLTTcCPWBxmIO6fffn9x7J8GhAZPu6fR+e8Z+/KoeRaQ6qpVa8KTl4qhyhgp94y5h0DFsrqackb6B6OSJHyOHQojLatFEonVeRXbc4GC0l3NR7BSxV3Z6Ot4ik9pBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQMnwOfRqqaL1FLlQOUpenHu7jpuhbfew2TSH98dj2g=;
 b=h/BQtILPQLSV+6V1yggsLlFg31JiLngkKpFt3x6dfgkkvY5WCryFNeYGwUiNlhJDxmbnGzVxtctpnfRTaB7GwLTbYOya5nLarydRAXiymZzjEOh7Z5Fl2exbDtKCq+FbCibcbss9IscJJ0wUyPDAxINbr8qenELWwKZ+IgsgwW0vUBngGvN+0/6g1FhbIVbTzjzGPmPUsNhuVOUkTQATkvwafYafcOULpx6dN5H7ew/TC7BE0itRR6IZRHjKgFNeaoWfzK4d63/qQ9FRtaHurjwEmT+/1DSNYjzeSgKhp+D/knGzGSvP2ChorzQp8qHex9f/vNYRyeKTQA30YRMjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQMnwOfRqqaL1FLlQOUpenHu7jpuhbfew2TSH98dj2g=;
 b=ZS+wCJ46Xhm3fy8JOPcJ2MDMq2dkdghh9XWKMNUNNwDX0pmn/3OIb6/QQZpi5CM7BMCd9SAYzyXVGcLoJM7iabnw+foXL4fJTV0k2k5K5GysbPoNih2nhMIXUycR4GpRIPMsekl3i6Upq3BReYH38kS/pvUng1cBnGnMMVEaZu8=
Received: from DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Thu, 8 Feb
 2024 06:47:52 +0000
Received: from DM6PR12MB4154.namprd12.prod.outlook.com
 ([fe80::6b2d:9a4b:4c75:9c89]) by DM6PR12MB4154.namprd12.prod.outlook.com
 ([fe80::6b2d:9a4b:4c75:9c89%4]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 06:47:52 +0000
From: "Akula, Kalyani" <kalyani.akula@amd.com>
To: "Kundanala, Praveen Teja" <praveen.teja.kundanala@amd.com>,
	"srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Kundanala, Praveen Teja"
	<praveen.teja.kundanala@amd.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 2/4] nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup
Thread-Topic: [PATCH V4 2/4] nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup
Thread-Index: AQHaVcyCbGHMLh2EZUCTdZNZkpMnyrEACV4A
Date: Thu, 8 Feb 2024 06:47:52 +0000
Message-ID:
 <DM6PR12MB41547758296EEDAF2B5DFFF3F8442@DM6PR12MB4154.namprd12.prod.outlook.com>
References: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
 <20240202113843.17999-3-praveen.teja.kundanala@amd.com>
In-Reply-To: <20240202113843.17999-3-praveen.teja.kundanala@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4154:EE_|BY5PR12MB5509:EE_
x-ms-office365-filtering-correlation-id: 8a96e4a6-eff4-4746-071d-08dc2871df57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 it2Lbe0tTOa58yhWqXOlxOulVxl7kFtgmVGhP1mO5jXDROVl/d/xVOHjiZAaQ+Si8zLaCpe6VtJLiC7QM12UHYq1HuJrSgyuBH5KICkYzoDZDbcvVgatJZzey72zaZt3Ny1qIK1YGl9v3dY7XO2C5Z4Ey5nyWQwqYt8Kh3ad3n4SfM9CzBWI6BCKyIEjwbSTk1p/r1Pz4EG9WAgYWibqWDhOCDGBL7ZmmTFZvYMJz/0TPgeyxtQ6+A0eHbFJ2AM/NAd5HlLTn2yBlshinpdZSoqOcBrCqpmfDu4PV+stE+oIlP7qh3mId2KHFZbuMFCfAhwa2I4efh1qi7ll3eWUnyQynNPUnhCK9njaP/33TSTEvSJq5e70YzqPNcR03TUGaBGAfzkwQLa/xhW/PsIZffR5cCvk9WmRJIdd0+zxbyWSYrqo1oJtu9mEgoeABx/C5Tl/xjoeOtUDmezatAM3QmS2JolPrNfLLR0Q0fKRchRCZs5tjEHAC+XJn1x6Gd6EHMCFbErHZcF4awCl/5Ht7wcwvaAyFDJz5aiPsYGrgg80m1tqaS6axzt4gEK4q7eDmPSSuGTnlDRmb+DbjYIugELQYWOc2nI3TdwS5fidXGuc23vjNcvjMGwfJCieJ5WS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4154.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(110136005)(316002)(52536014)(41300700001)(2906002)(83380400001)(38070700009)(26005)(33656002)(122000001)(86362001)(38100700002)(4326008)(8676002)(8936002)(66556008)(66476007)(66446008)(66946007)(64756008)(76116006)(9686003)(6506007)(478600001)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DixjFRpJtIFcmVeB+G85smFwfqMiVVTthLALrta+Dkq9LdPak6ryejxPIM6V?=
 =?us-ascii?Q?lOB2flBPVGh0Dvone/Kddv0e1xO5PAN9e9qbv8cx1ds0yVHzGZ2JE78ZcvvK?=
 =?us-ascii?Q?KDNHpg8Inq4nAGGe7bCgL132BYtLG9kxVsjmkGmAWJNSQx6rQ/vDy0lXuifa?=
 =?us-ascii?Q?mqDZOpQpoUYCEEwzr/40iYKAGbgCOkRKiBxHKk3fxP1NsLZrDxkOVm1kcVjx?=
 =?us-ascii?Q?xsUkXFTXAtSTBaCLGjxydtVovt6EZTCUVHaIqcqB3mkwDOWRPzIsvT+D6kyW?=
 =?us-ascii?Q?Ml4OQicSbM5E1k4MSbQ3ic/HaLjAxD0SFZiWFu4BZyj7RZKXUVIQ8knykyov?=
 =?us-ascii?Q?jkDc0zu6Ki4nu9e7PbsK8ZpHElbmCYLH0dBKKLG1RgWrh7AtXA7jUWjdPeUP?=
 =?us-ascii?Q?CJVNLVzOXyVCVcTjifbVrh/MoDE8g2wbXndoli9RhrdnBtrQMTB/tBwRno9B?=
 =?us-ascii?Q?ccZ1Nk+wM3tKETc3bslogGurfJJwacOQULjWeZw6db0m4yMi/fltYcwDjC+L?=
 =?us-ascii?Q?10zv7Cs3B1vwVqnxrTmALFgiJkFd60xkPO702YnX99SumrfMKio3hrYRdzuo?=
 =?us-ascii?Q?/zpvV0a8EN+kt7Qhq4XGIQRfcF2WDhq4CQhnwKnkt78R0/kfqr0QEjvLfeqS?=
 =?us-ascii?Q?mSeTlxaUqMaPlmmrNVOhv63pl7YKCAt9LSwezQrCH8mfO5fotevXnoeMlBTp?=
 =?us-ascii?Q?TxVRrmG9vGluWnWwfmONztQVM12Taro/H3nviJfR/OyJSIvFQJzFG1NySnBB?=
 =?us-ascii?Q?qKZEzfevWcpQBCcxY/TRy15ryZBI46I80GlIWjZNJTTak1FsgcpOv1jQeDA6?=
 =?us-ascii?Q?ibP/Bazpn/xewPFqM3+zN4TjLTeU/GHMKeJbz59YdbGq+IP53agQhQ2R08Pk?=
 =?us-ascii?Q?YChpwUzuIWshGthtLBqx8JZogj1dwLtT4ilbpGeOit+OBTl59466eOyGFRrg?=
 =?us-ascii?Q?l6Zc9glJigDyCuz62s6KBlxoPGPLRb3zRuGEF9LMGvpewI09tEGLRIUcbChJ?=
 =?us-ascii?Q?8AkCpP3wmBcHdjrqehijKxHdARmdenOHLVeipId1ExBazMnCcKBjiVgscq5M?=
 =?us-ascii?Q?jRVRsLNKYVmpjcnKeWm+Zw8gY0S1N5DChu/sKayPnfruHykIn2KdIARuWulI?=
 =?us-ascii?Q?hXHA9cvTRXY5vROJr3Uth22WTgaSdlu8AIkDFZvKfbUQfzatGAXHGygY6gyu?=
 =?us-ascii?Q?ws0hvqj1qLH/0pq/+9b3fc49hnTf4Ifo1OYn7arjyJQ2OVVmsyZTMjmHf5un?=
 =?us-ascii?Q?2ezHzsVtYv37zdQ0uOmQirBEt97rHg5LI9rvHdHPQthbY5mnxxlSdilchiJt?=
 =?us-ascii?Q?kFoTvDrI5GLi4qR6Ftov3yCHWXvl3ZNWs+CgckzhynGbDgPnFViDM2gDTo4s?=
 =?us-ascii?Q?gXJct8e1xxEtnfvKLDWR+8JMah1HWGHhKhs0uEFZmswLBToVPWfGWOyhJxbF?=
 =?us-ascii?Q?qpB7DKga0fZq0tIj2OodAizdWsWfq4ORpzm0rDxYTxeamQBUS5Odl1nIBXlp?=
 =?us-ascii?Q?AgSLqBpna7hEnwhIXXoxJdaHvN/AvLrqoWdZ4Xp7qXI85PHLjEHgWtEOHEIq?=
 =?us-ascii?Q?0wAAmwSWyfw6L4qmVWo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4154.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a96e4a6-eff4-4746-071d-08dc2871df57
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 06:47:52.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hk9zRfqIaN08kN8140lwHC8GklMHM0j6KCr7UtqR/G7ogBm3bKCuldmkbgKsV2jxcrCQCWyt+mQHwfQk2m/ITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509



>-----Original Message-----
>From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>Sent: Friday, February 2, 2024 5:09 PM
>To: srinivas.kandagatla@linaro.org; Simek, Michal <michal.simek@amd.com>;
>Akula, Kalyani <kalyani.akula@amd.com>; Kundanala, Praveen Teja
><praveen.teja.kundanala@amd.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org
>Cc: linux-kernel@vger.kernel.org
>Subject: [PATCH V4 2/4] nvmem: zynqmp_nvmem: zynqmp_nvmem_probe
>cleanup
>
>- Remove static nvmem_config declaration
>- Remove zynqmp_nvmem_data
>
>Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>---
> drivers/nvmem/zynqmp_nvmem.c | 37 ++++++++++++------------------------
> 1 file changed, 12 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/nvmem/zynqmp_nvmem.c
>b/drivers/nvmem/zynqmp_nvmem.c index 7f15aa89a9d0..391d8e88b270
>100644
>--- a/drivers/nvmem/zynqmp_nvmem.c
>+++ b/drivers/nvmem/zynqmp_nvmem.c
>@@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0+
> /*
>  * Copyright (C) 2019 Xilinx, Inc.
>+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
>  */
>
> #include <linux/module.h>
>@@ -11,36 +12,25 @@
>
> #define SILICON_REVISION_MASK 0xF
>
>-struct zynqmp_nvmem_data {
>-	struct device *dev;
>-	struct nvmem_device *nvmem;
>-};
>
> static int zynqmp_nvmem_read(void *context, unsigned int offset,
> 			     void *val, size_t bytes)
> {
>+	struct device *dev =3D context;
> 	int ret;
>-	int idcode, version;
>-	struct zynqmp_nvmem_data *priv =3D context;
>+	int idcode;
>+	int version;
>
> 	ret =3D zynqmp_pm_get_chipid(&idcode, &version);
> 	if (ret < 0)
> 		return ret;
>
>-	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
>+	dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
> 	*(int *)val =3D version & SILICON_REVISION_MASK;
>
> 	return 0;
> }
>
>-static struct nvmem_config econfig =3D {
>-	.name =3D "zynqmp-nvmem",
>-	.owner =3D THIS_MODULE,
>-	.word_size =3D 1,
>-	.size =3D 1,
>-	.read_only =3D true,
>-};
>-
> static const struct of_device_id zynqmp_nvmem_match[] =3D {
> 	{ .compatible =3D "xlnx,zynqmp-nvmem-fw", },
> 	{ /* sentinel */ },
>@@ -50,21 +40,18 @@ MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
>static int zynqmp_nvmem_probe(struct platform_device *pdev)  {
> 	struct device *dev =3D &pdev->dev;
>-	struct zynqmp_nvmem_data *priv;
>+	struct nvmem_config econfig =3D {};
>
>-	priv =3D devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data),
>GFP_KERNEL);
>-	if (!priv)
>-		return -ENOMEM;
>-
>-	priv->dev =3D dev;
>+	econfig.name =3D "zynqmp-nvmem";
>+	econfig.owner =3D THIS_MODULE;
>+	econfig.word_size =3D 1;
>+	econfig.size =3D 1;
> 	econfig.dev =3D dev;
> 	econfig.add_legacy_fixed_of_cells =3D true;
>+	econfig.read_only =3D true;
> 	econfig.reg_read =3D zynqmp_nvmem_read;
>-	econfig.priv =3D priv;
>-
>-	priv->nvmem =3D devm_nvmem_register(dev, &econfig);
>
>-	return PTR_ERR_OR_ZERO(priv->nvmem);
>+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));
> }
>
> static struct platform_driver zynqmp_nvmem_driver =3D {
>--
>2.37.6

Acked-by: Kalyani Akula <Kalyani.akula@amd.com>
=20
Regards,
Kalyani

