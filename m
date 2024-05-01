Return-Path: <linux-kernel+bounces-165862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D48B9299
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB991C21204
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50767168B1E;
	Wed,  1 May 2024 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gY0nZljl"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384184E15
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714607579; cv=fail; b=DeSabUhAlC77nyxSXKkqzmPumBqQ3DP5MlU7Vv+lE7CYevsAGb60Rt+TPDLs3OMB1+R5lQw3xZ2qDov6MA0lBZAceBNdf/UQkPnAHA3MZilF/R6nrojt1PfNXmlMKTYz0hs9K32ePp4UozQsMiE8BxtlnrNUAQ1WSMGBivoPzjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714607579; c=relaxed/simple;
	bh=zWUomQFDZLAoq+4vzeTJ+gc9fH3bENVXE9eQX+XbcYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g27o+x9rcqx0O/HLdt4ksKD6W89cQBFNaxyegNCEV3ymLnhnnEYzEiQaGmg/bM5bcYFG5hw60r5f1KpMMoYr0mRppAk9tUUoIS0RZ3kAL4KNp5Y2vJvih6Q7mOJcQFhKfysfLEOhaaj1rssIXgo8Fd2+th0h33WKVYoConUq7qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gY0nZljl; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSws57ZIvxs+p6KGRx5Nzizb8mwSjmJ3U5l7RQK6D1oOGImO/NnmtTH2jfQcMK6vM69VAoMVMt19BZ5NNbhqcc7PPoS/E7iXMTinbQmKvE+1uqz4uvFTxoVlT2vcBUL1sDHGyuOULf7oXRBo4FLIaJB60qgaVAAKr+0VIgHCQiY60QcM5CUk2ZbrOYRavXx57JcESHl8hBP98ydbuIInBPhZqAMhBS0KsiHbmTRVe4b6dxGkAw7ihkNGEmvew6Hv1IX/ResphjW8WrcqAd3ei1BbRVsNt/b1hxO6do4pORp44gYwViX9jj/QGuZZwaBwBbyaCPsGTQl8SeIf596mgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U24fNUd/rYvVctY2UgtfGALT5iKvmajKVAn1nInT67M=;
 b=Ji0bcCdLVx1DG2YYO/tMqKBw6rL/L4OCUvJsBJFQF1jkbGhko09fNAtvg/8yI9oRn2vBdqUVEoV2xI0/LBTyQgjky152VE9+Btgk+koJ4f9yHe9AuGPAN9NE06QNdJFg+Z6zzqpT/fy9t0S3ooIWFFheYFYBJ22QyCoj7MmKgahRqQI+lTkKLU4vfxTyFtPFf0qwJroIpWgQZO0Q6DCrRVBU7/qoHNcDr5Erhkn6Pe9tGm+RVs+pfJuUFHsaQbobpEPU2g297vGbSBXbq3LKZjholxDzR6fv+lQ+jqdByz2N/971cDoL3zlvSkakmInjogfVXVXekRgMsG2pdUC9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U24fNUd/rYvVctY2UgtfGALT5iKvmajKVAn1nInT67M=;
 b=gY0nZljlyo3sZOawZrOm5siOeeg/Svap1IG1fLvq+17tKx/KXKBsk6pdZJif6iVA0r4c54QIPJrVFcfRm96QOMqU6s3xpGSe1a5qr/W6Stl+0IFt/GgIt/HyMt5bLMU+qhvzHdOV2Bcs4cGMp2qwrk61NZ6/QBSBZV1OppOmiCM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB10031.eurprd04.prod.outlook.com (2603:10a6:102:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 23:52:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 23:52:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: power_control: support suspend
 command
Thread-Topic: [PATCH V2] firmware: arm_scmi: power_control: support suspend
 command
Thread-Index: AQHamT+2kPkNNu1tdEe0xkM7CL1Pt7GCZrYAgACrLSA=
Date: Wed, 1 May 2024 23:52:52 +0000
Message-ID:
 <DU0PR04MB9417117051682D9BC5B195D988192@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240428075105.2187837-1-peng.fan@oss.nxp.com>
 <ZjJFLag-0ei0a3xM@pluto>
In-Reply-To: <ZjJFLag-0ei0a3xM@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAWPR04MB10031:EE_
x-ms-office365-filtering-correlation-id: 5ebbe1de-7c55-4c66-284e-08dc6a39d0e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?78OB13JTtExCuFMU/Ohs96lZwuS484m39YvEuVDfwX8BuzYpsUhXCug1Crzw?=
 =?us-ascii?Q?pNXKw1UHK7+bd7/BwFtSKnPqR9tINO5xI6Asc9S7V3ZSWPjbMXO6pOLpGnW2?=
 =?us-ascii?Q?vCWNhHGP8VGZhpLbxXWEkVxrrf4JidaYanLOu2+bmsFupO3XSFLknj+Q9CA1?=
 =?us-ascii?Q?59sDzcrRgIVKIMYaG9mTLyfgd6wUcw92N866uAFNs72vZ364CN2+co5LPFEQ?=
 =?us-ascii?Q?A7+3tNEXwavbXCoobduNlpHH/3Ym5q4CcJeg1FeJE3SRNoWfO7arTttTrzV4?=
 =?us-ascii?Q?Yt9RDYgval9rMov3JYMyje3Fb2fm0iA19eKdCOLFblY3hxPgDNJ6+tekjTA0?=
 =?us-ascii?Q?KHrQ7cVMCBrV5z/WqB7J2RwmeSwXuYf7927+PHb25JKP+vea2tkTe+sOhLMR?=
 =?us-ascii?Q?tp65kJoJW0tQkvQfhn3bG0S2PpQ2bb9OojdSuGDz6raraB4ve4E2bArvx8us?=
 =?us-ascii?Q?HhBISND4uqBI1MiA1MszHi//yjICtyVX/j5Z4tviDU29nSldk7n+AAHWKxWa?=
 =?us-ascii?Q?dVXYc8ZwBs2ropTDHIiBen+4UpfUVbDx09zu6iUvEPMjJQ2rhKwDZ31WlLEn?=
 =?us-ascii?Q?bGQCohbsswTzN+Zaz7RUGXeKBhWdSuizUbZTPn5CLHrF1uIqzn5ZCFzb/Zvq?=
 =?us-ascii?Q?xc7bao5cVzMO/tM4A8AJxraHgNFUytzENXk459eFi+gE/H0EVza36ragoKvu?=
 =?us-ascii?Q?dgFlwX7mhleLdtPJhNObLAca3nV3sKM2YN88mw/n2zKhQnPNbXVma8lD3bcM?=
 =?us-ascii?Q?SoLFE2n94dJ+F6vVjMNtZ9Kj682i1uE+G/wBZF8Aw8sKTB+qaYc9LpTSB76i?=
 =?us-ascii?Q?FUMHbvBXpku1qPVOUiSbn2G9MUHDsyNczPTCrd17LuZMFHn5IO59QuGlKmj4?=
 =?us-ascii?Q?KfX8rtHt1X7YOlnEDZoKvWOa3jecqo3Lot1RBUSdqCDNF6RkMUeQStX97Yda?=
 =?us-ascii?Q?qSy3CrLHb+XCtAlIafH5iefDpzYu97E60aQtZ2mO/aUyluDkfJa0DDKg/P2y?=
 =?us-ascii?Q?R3EVzPpd12NOnzk1pyg2sNvRTwi/EX0bca8IS8o7K4MQDIDs+0tJGPgbX0K/?=
 =?us-ascii?Q?egK8D0Q6pF0TPE0Kg/mQxfa/ykdhWZnQ9MA2bwoQ38enSBhcVQaEIAkCo1RG?=
 =?us-ascii?Q?/KkqgFCRCdPSbVR/S3hf+mcHL1HZvxIXo85ts6rzQEF18WsxfNaEs3e/wemD?=
 =?us-ascii?Q?zJrYKSwlne7drc3qEBzJ6GvSCtvNdBXIK+QcfiAYgW4NZjGdBTNIg5l9Xkbu?=
 =?us-ascii?Q?fsvdAgm6u3K4BvxJkj5pGMLL3vviJkNlYWhr8Uq7S/xUEDPzbe0svHGz7B1O?=
 =?us-ascii?Q?UN5SO8WbDI7YjWKp1YD3bVu66x0Jn770AUnKCt5bq+OrVg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OXCgMstgoQHMX3zzrLGNq3I5yeHUr0KZAL2jQfSeL2BoamI61f9rrccx8JSi?=
 =?us-ascii?Q?xeWl0d0MIVXKJJt44Sv1Z0fcpJNLvcoMV0QZbXvS0VzmTEsxOdbelAzOAYPk?=
 =?us-ascii?Q?rscR1B31Tc2RIZrvQOa5Y8kXuGX1Q0NoVlf89qsxq3GDtYS7Uga04Rhe7wbi?=
 =?us-ascii?Q?ZrsNc6JnARnn1qbxuvUSyRjO8+SmXgZSvGL+VFGqUKx/qDjeXfPEkLriZ49b?=
 =?us-ascii?Q?jK71D7Uo59/ZxUeAzVYmkjOk1tBL5bdnm1iX0YTeq2bH0S02Ka3SnPve9ikX?=
 =?us-ascii?Q?0z9UbExu/ljK+bs9UptKgSxHOtL8KVmfAr/iYYtxOFCIYmKHcxxE5t8u+oDJ?=
 =?us-ascii?Q?CUoPe+wL8U4+e40Uc69ehNO7YNAHmJIjumevcrrTu+qZP1NOXGIqjoCl3i/8?=
 =?us-ascii?Q?d013qDKdm+qQQJnB6151WwvyWfN3gH4VNHYDTgTwsZ2RPse3pPUI7xNe4shR?=
 =?us-ascii?Q?NImBUAzyaEleJ3exU2jJBzOhNPlb5OnvTk5qJfsaOPk9Wa5MID8D3SyOM8yX?=
 =?us-ascii?Q?oci3AkVrKqvE0+ljmYq+q9/RhSJ62uRrfcxDWrRyTyoxNjzyfEiI7qHTotB/?=
 =?us-ascii?Q?0ZvXhbdTbhLumIbxiTA4Vcf9or5fHj/AzQQirS5LXdCI3oB0ORlZly4eJpJs?=
 =?us-ascii?Q?tfKxwIwyy7jLX9kDvOZCPP+aR/MOVoYxc9sfO/aKfDQJ1hdJAlqGIxFyp1OW?=
 =?us-ascii?Q?V9uymnWAYp8rmSKyo/TL2eIyNsJsSFApzdanF1uZnlJrh3slox/uuQr1myYB?=
 =?us-ascii?Q?MiI6nprKP0IaaFp+xdS3/W2HRFdyTgLRKSJSZPuViT3kF8qb1XuG09DG6bRb?=
 =?us-ascii?Q?cWmgICuJCwOuJlWfuHDPvkqdUeuEiE7e9H+nVljfOBNMJBLc7boSJQytqzu4?=
 =?us-ascii?Q?NTA1vR654thYR7ede3Iz/omOTJp5Tw8ZgP+29oxLX73P8Nzci23DZcVmLRb3?=
 =?us-ascii?Q?w4TQR/Dv+tDLjqtgBgEwa5dG+rhPDuAd0vJANxk3nh4FliEQBmt1fQAXN6Xq?=
 =?us-ascii?Q?qbupPpiJ3HnuX90LOobUP67w5IfFQty6eJHlzxwEVnqPBBrL9U7KrugM+sqA?=
 =?us-ascii?Q?VAf/CaYVDNy7WpV7LPiwMF1J1Z2wMsYwGMlKii8kbl0RShq4jm2yBePLgRHk?=
 =?us-ascii?Q?yHyMoYqquIkX0dykS2DjVmdneBhdDhJcVOb5AwxFHgy7QJZOMD9yp9R9NFJK?=
 =?us-ascii?Q?622YyR0ITi/TGOgBOpyWtMiNNQ9me9CzN8S9Ij2nzwap9Fr98Ix7NL9NOhPN?=
 =?us-ascii?Q?x4kAvUVboj2ipXstXkpu4UtZBL6hL8SEg5bcVs/RdbsxYqpaLIddzcaDOC+1?=
 =?us-ascii?Q?HYEMn4ICI+Tr9FxWC0rBTBCwC07webiY28tQP3H03bX56n2dfARrkIM2Kd5F?=
 =?us-ascii?Q?gkjlqYgltWFHDFXjoGccSE+ERB+BL6X7MD9cXkRPhe89PJl41/8sJG0MLIpE?=
 =?us-ascii?Q?k9ZjRIuWNi81uqgf9xYIezgtHpIeosGB8A96Q7g6fgVKnwZl/fjvUqyg2ImD?=
 =?us-ascii?Q?sOTVUsUq8Khd50WY/A3/qzQNxfDTk1jiO3MbZpaPv0Vzdb1zZLqKtbEgkICm?=
 =?us-ascii?Q?xdJiBpIOYHRAZP8lIz4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebbe1de-7c55-4c66-284e-08dc6a39d0e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 23:52:52.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jY/J64GRrGj7SjtnHWTcq3TEisOrbBEQCNVBS1xi62L+Y1dewuDG5/xC7shBxNjM9/HIOJGMczcVerhsPZ1mdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10031

> Subject: Re: [PATCH V2] firmware: arm_scmi: power_control: support
> suspend command
>=20
> On Sun, Apr 28, 2024 at 03:51:05PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Support System suspend notification. Using a work struct to call
> > pm_suspend. There is no way to pass suspend level to pm_suspend, so
> > use MEM as of now.
> >
> > - The choice of S2R(MEM) by default. The userspace can configure whatev=
er
> >   default behaviour expected as S2R, if issuing suspend from userspace.
> >
> > - The userspace needs to keep the wakeup source enabled, otherwise the
> >   system may never resume back.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
>=20
> Have you tried triggering a suspend with this on your setup ?

Yes, this feature is already in NXP internal git tree and tested.

>=20
> Anyway, LGTM.
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>=20

Thanks,
Peng.
> Thanks,
> Cristian


