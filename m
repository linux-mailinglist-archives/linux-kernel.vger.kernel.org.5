Return-Path: <linux-kernel+bounces-101555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5B87A8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8EEB21543
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519FD4174A;
	Wed, 13 Mar 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=asem.it header.i=@asem.it header.b="ixhrg9BL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD343ADB;
	Wed, 13 Mar 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337508; cv=fail; b=XnN5NNwgCXcCLM061HGzO9BHXIIFAJeESeYBlxFfbiyU1KwCyAckAJycJdAb956WO9KvuceH4kH8d+Kp5GzyYFn5L0lW3JL+VtBS6ChmuvctiJl6oIUfp0coyNS5UTU+H0D755Mn4uWtR3lRp7wyhNoq1W6gSeixLkfg7GuIPJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337508; c=relaxed/simple;
	bh=CePFEcr/bImfeuQRPbfNHL59trhBJDXMCG8dHCpzkpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHXE8q/pc2e3mGsAXopOC1bjmQKB0BAVLbV6OubnRlz26uPk77ND9rEfwNigDQzs3GucyWyiYwq4jfukJSlkhu4WYRSz3TsCb/NwTmUk6VgFIV6xp7Fwc0SskWi2/TsjqA5C2E/iMKxLhoE4ytKMQWDQQJ9JrrITQPlvo6IxMq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=ixhrg9BL; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF4CXove8RnqHaKgUFYVpuDo6qp5dkycyUdpvgx5ZI56WFz2aJaKoRdDSAgLaZxPXq2NkYv25M6ok777WOeu0vybO46MHIvvaXx4H14XNcMptTCWKCDeBwel+jUXNyBoQyz6MrZG4iiRlmRqdCMDT8Z8kX/w2Br3xrjTu9QdSB7oRaIGkT6JuChEF6PTzLIU6Bw2A0HCW0XxT6Lu4O5yl7orByWi6ACs3f7ODlz7MxoF+UoMNI9YLSJ6LyWtx4rhfLhiEQ3LeZh5XsVtYcJYpGmOrzy5wAZXeX7ip7TQ1rFHfJSqRRjxNpFVBQJ9a7V1FErMDkVIrZiAi96USLcdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CePFEcr/bImfeuQRPbfNHL59trhBJDXMCG8dHCpzkpw=;
 b=IhdPDY7iWtO5/fJdttgAVqOIoWm+LvxRgbZiE6Un7Dye5hW/4VCnDmXvjFAU+s3y6HgsCQD7e04jIwew1gF/Sz/kjo15/Ti+O686ZDlyV3mn5pOJEP0wYtOG15j68iMNYQtsySD4JHeQC33nDsAmwuXi8xQuJj9t3dA23oRAa6SNwQm+ShCJvm+L6OBAT8wX2eKSmw0xvIgliHxpuRaNdXYlUwpwcjQjoOwXObGNJPrdlIzqqcfa5jCTHdvoBmhXOO/4nOIL0ge/LKKJfeRLFQLFWDDRQyGJSeDJB0dC8KAioNsHVh2XCfb3pwMw1NxqrUI1XVZmh3305es+c2JGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CePFEcr/bImfeuQRPbfNHL59trhBJDXMCG8dHCpzkpw=;
 b=ixhrg9BL8YrcIUy+yv5ntp5uoyXQdoiRtKSXcJd99XJPewytnw/TFdeo3FQrunnNTHoz/HN8rFHyfvQHM1MxQexki3GqSItbAAF/U6ZqJzEAUGkfV83/gFVg33RjIRjrmbFSfezdYXJDlQl0fSVGsmbywNukrOZOcfcp4bfNbwLitfF4bryKhxwJLsucHykXAlZEUgTRw/ZoMTwRrbwPT9SX4NeGqUZHsX9xH8+Wwtd6GEGXcyEAP46VGa6bwHCSnsOGuQvM8kXcEvjNa9F49xnC48RF2mX1Smn720gHYUAV9CDOaaKcDbVKO+9U5tnRsarr0Z8ZWCSaGefaT6kE5g==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by IA2PR22MB5529.namprd22.prod.outlook.com (2603:10b6:208:4ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 13:45:03 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7%7]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 13:45:02 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: FLAVIO SULIGOI <f.suligoi@asem.it>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: EXTERNAL: [PATCH] thermal: qoriq: remove redundant TMTMIR_DEFAULT
Thread-Topic: EXTERNAL: [PATCH] thermal: qoriq: remove redundant
 TMTMIR_DEFAULT
Thread-Index: AQHadUPN3hgfncjQXkGCBoWLv468qLE1rieQ
Date: Wed, 13 Mar 2024 13:45:02 +0000
Message-ID:
 <PH0PR22MB378914E9CAE71BDB53E95D4BF92A2@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240313124117.3224601-1-f.suligoi@asem.it>
In-Reply-To: <20240313124117.3224601-1-f.suligoi@asem.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|IA2PR22MB5529:EE_
x-ms-office365-filtering-correlation-id: 64716df4-03c5-41c8-2eb1-08dc4363c861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S1vqBeY0iMoqjNCCVhg56LDMIHH7halhPcz//O2yT+0m6SoQWWeHEfes5y/9YiLcyUksqjrAwxuoPn/KHv46h7fQ+L5/Q/EBze9beuscF2pPgF/JfulpY3mNzo+imCLr+1pCBZFM9/Qax56sYnnLNo5ztWH3wZhYOi5AHdetR0hWMeB+Hktc5npHMybKjk25Awqo2HNSWZny8jgJ7/iKzLoMqjwK9exm1eksWmb3oJLAteTSZxMVQ2N+aE2g28sliCkebm3l3BS96Vud9nLRGyQDx1QPSvHGCwITsuq5/IVPn2QqSbZzUuf5qT07GsffI9wB1pG4MUgDp8hUxGS+F9u/ifS0wdHTtwWkqSP27l0TxtXDQOyPKhXGPsxS0EEUge1mcNTcIJUnIzxd5244Mf3Lr+1Szk7U3mSq46GyZ4IeiAJb/XeUD9GKLKnGIRg2vf+ukXcSv16smQnBW6Ufg2rHO2KNpJzhoSjZvKiZjGqsK45s7Bg7McdY5OVY4iZ5E0IZbEh0R2xqXUiMQ8p3P5nIDOsBzkHSRMqlt+OLOtaocECzQ5iTQrH/KcToooN4Cwi1twCO6wbBNY6200/j34PeTOx3TrUrTJWHv7pj05LpXpzAI1PP2RM/kX/1kW60d/bc0QodKALXhrH6zvIVQ3qfKHezHY6sjUWcA1n6Qz1Nln+/mqUX0+uR1YW6ivzXuCv1wDFJtzKxYDSUa6PEKg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hv6rjQoAPD6L+bGPjm/Sd5pHn9rZjK+PVjrHjqtt1SNvdoGhBt/enrHd1nww?=
 =?us-ascii?Q?vycgHHdCyaoGFLy5z+FjKk/WYrP3uPNJsAlx0tHDjE8EEUZXZJ9gVnD2zs6g?=
 =?us-ascii?Q?tBRMXu4ErFaH8u9Vu3/EKRV6CqPlP4oMUh5G+Ky89M9NOklSU66jmAs0UPEZ?=
 =?us-ascii?Q?rwQOHV4Xf22b6yeYtQgP2HV/d8N/E1YwIhi47uEuGEN+yh7WGWpGZ6xwOjVM?=
 =?us-ascii?Q?pVWQrcgJYhN6/UMC4ZzTmYEiZKH0UXq9/DoJasTswWdjNOSX/vR320KzaL/9?=
 =?us-ascii?Q?+f1Nz5sxgdieYqImNE8M3aLTjGGfRbb/CjgyaQLVxRMB5cxMKxMkStAlGlbe?=
 =?us-ascii?Q?Tgd6BY6OxuEpDV6W09Yl/vQjBiZ41GqrMZlASqIr4SXe3YO7sGXr4HT3vllo?=
 =?us-ascii?Q?o9DfgN0uvrXm+kPC7nJviCBh6EQTO4qAVoHE8UJzarTkVMneCMCu3C9VLtrl?=
 =?us-ascii?Q?0BTfAWlnkGY2S2KdQ2p0h0tZfvhcVtb4Fz8dXWjG/XET7UopnVLtpJ9Blr5V?=
 =?us-ascii?Q?DEvjjyiIju7fes3H9OdfLsx7cNIOZ4yIznWEsjZjPk9jTbwkIAuG8soqHP44?=
 =?us-ascii?Q?189TNf365H8XqdbBnZZtzfd7wfafiA9FVfdC+8zlF4XP0kSEFVokzMzSskFt?=
 =?us-ascii?Q?rivZsD5K6yYBBaDFjm7uudmeAUMmTFMC6dZ1cXRc1MzAJ4uy54vrsI4wDRpt?=
 =?us-ascii?Q?ocUylbBgD2DWLUzaeaVQm6qqztvXxifZVWoz1wQqaw9fzMqRQvXYwXx3DEqX?=
 =?us-ascii?Q?8QU3As6W3/y1KFL2MwOFg5EzjlZ/ANVKfWTegWfMRo4LIMs1HdXiiI1dp4PS?=
 =?us-ascii?Q?O+wwQCyckdQhJ9VMcD7bSqKvTbt9Nf7xfkUs+scQ2XaD+hwzImLjKN8y1yZk?=
 =?us-ascii?Q?x4D/HON93M4XnHP+I3DsSCzbEhl6+eKs/PcbOEyQD/OICIe+wZBWpXpbXBuL?=
 =?us-ascii?Q?qU/evDNWw348RZS40kjhZsAv/FhfVsL8dKlkPP1o8NOlPtpgQSazaFTLyajw?=
 =?us-ascii?Q?snTT1+hbHQ6yrOI3LTRhPNvmgEOb6NxVd2AhR48tSPYhdlb4uYrWpIVtnr9c?=
 =?us-ascii?Q?Hm/DclWKPlxC/cyL74DeShbcMpJ1JD3EoB/bVdMKWv4ZR4lUDOBXPSQ/hhlq?=
 =?us-ascii?Q?Ieg8WtL6VcvQwZQPYuTtMQguLLS4OWmcgITDvO0XZY4c0yxijbH2sOxlOhFl?=
 =?us-ascii?Q?3hMlxxNb/j+u+GJuZZKwavm6AMNw7uNt9hbddddyGwjbfunzQwiqDK+XqL/0?=
 =?us-ascii?Q?Gxo7jHzSZOorTJ/o0lKNHjeGOk02BEIfmq+nv+bKEy77YHKj6RcZecHwrrKC?=
 =?us-ascii?Q?Uap85++IxqQgRJCK3SdyNffYl9FbLOTy6rYjvjn/fdBzl2IBYZxKREv1VoyO?=
 =?us-ascii?Q?81YqyncWuDlrZKkNR6WtjLd1J7/Yaumo5+ceb12ln/0Fj4dqgr518+YeMp5w?=
 =?us-ascii?Q?nJm2EeKe7YquWSLLYjOI8jgEmMZZCQBspNto07R6FjutC4qFe+/R9Ldf934C?=
 =?us-ascii?Q?xl9VB7HriK3YOIsIOZSILRSrBy3rJcwrF45fWM4IehWomp/l92moWC8IIRWS?=
 =?us-ascii?Q?qv/ZLa8yCUTpso/wSHsEQOlymkVRUsUmKRGYeevHz1e6h4JiZPdHiv4job+F?=
 =?us-ascii?Q?Fs8nUhKHOMKyAkrkmY2pjOI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3789.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64716df4-03c5-41c8-2eb1-08dc4363c861
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 13:45:02.2295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8LfEMfMYwjvXSJLPJBmFgsaZsM9Q71NmVhyn/iTPjvrsW5woUpcT+cA4fClCDVBfTynB8QPHz4h0pyw3JBKfiyIIt759X7y5fAbZjXyac0pRyKvkGZBFqtgXLV7+adi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR22MB5529

Hi all,

..
> The definition of TMTMIR_DEFAULT is repeated two times in the code.
> The first time is useless.
> It makes more sense to leave this definition after the correspondent
> REGS_TMTMIR register definition:
>=20
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

there are also other double macro definitions, such as:

TMR_DISABLE
TMR_ME
TMR_ALPF
TIER_DISABLE

Would you like me to put some order?

regards,
Flavio




