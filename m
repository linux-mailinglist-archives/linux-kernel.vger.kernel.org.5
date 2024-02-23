Return-Path: <linux-kernel+bounces-78933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6D861AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BBA1F237CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB24140E53;
	Fri, 23 Feb 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xVYYJoOD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0C13EFFD;
	Fri, 23 Feb 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711052; cv=fail; b=Sk1d/W9aObCgZLgYFhbwmo13CKQ1Efjh4tVPDMir2qArIeTi9uLgoJX71+YFzs0iYnjtGBTA3vzNpOZdS3J8WjlJA5tX5iW62wQQMvKWLtEcppFCHcFztiw7o+NI+Hx+KtIxognSuYsTAfdpk1GwUd+zpE7QQkDhqAyvv0PhHkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711052; c=relaxed/simple;
	bh=9mVWq0yP/9XbO7K+XMDABC5KskEYk2FP2ijw6ykizDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XAtLXMwxYs8MzhKOBxLXWsBQ8Yr4jXnEwN2p4cqwETHCYr9mpXvjlx69RmvLacV/whWrbzgg8YiG9bw0yYC9JcVVhaRruQm84WmHH42UxLSh3NpRXwavv5uT79rFk6wzX6KFvoB1D+UnIgQvoxTJetmq1osfmnn3l4SvAaGqgOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xVYYJoOD; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEKGsJkNodKgdt21U0Jsy+qK4Ua4Nb29WXoyvHxLSu4/RnTbzbdtdXB1CbeUkbRbIsCRKeQsnokfwwrt6Mq4ry+zjhQd/AHpzgg6ck1fZrAlmbMHRTp8Fs0WariM5Jg9DHd9xBN/3GEGgM+M2Zjfw7pE9B4TFKcFRUipQYm/muCAG5muSzb5a6Y/OHsei0m/wP/lxfhD183qdb/FQ32ndO1XDaJ4smIpYEDWnumX1u8Zxkev7nJghWXTorezs52cGvIdSu6rsV/6E4mjoF/nZluMAdEBgtLOITWOno5Cv2djZ3vi0VyeAyIWqjMMxg1dw7j2em4NIwtbUzCAN5a7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqbdCcYyG7TN0L9rOHCSEL0hL5rJfMV5pMgeRcA2kMY=;
 b=SKfpJ2QnSiNX5NRyyj7NrH4b3p/MHjXZymyoypdkFD3FOe7roSgfVCbFlVXNa5+U0rXQJY/izR5XexRz2Ina5f+e16O/uXlhY1fPj7cevVoN+1E6q7Vja3VRYvjmIeI94DcFqrT9X8FbWdEnhjhkPFFEnqyLdAjcWgmam9rZlNUr1DqsOFsoetta/Z+YCL9aVm9C4qcJTQ9PwheRlSQVEY4yYImGY3ZT9e5LWv4m3tnaqL3HXzrTx8SW1ZmOyGGD5hfiM5LqHv8PlFQqA7MQIxzKn6Z060kwcqJvgCyvyT7gaNQP0sPHt2Nqa1gKTAh4yI2T6a6ClRl0IReui2gpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqbdCcYyG7TN0L9rOHCSEL0hL5rJfMV5pMgeRcA2kMY=;
 b=xVYYJoODJVR6iFIhaWp/H3d8kzJt0nbS1fCnROcyO7eobveTIyHexNnJaPR8jRq2Bz33Vucz8Ep3qqqtxYydW8mF2DhIgF+oCDblhvv+vpw5pV/blN+44uo/A1/i5a87ZzuVEB3vLSLI5HgkpzrOpJ47O7RGpY9Xlsg8VXf3DPM=
Received: from BN7PR12MB2644.namprd12.prod.outlook.com (2603:10b6:408:2d::20)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Fri, 23 Feb
 2024 17:57:26 +0000
Received: from BN7PR12MB2644.namprd12.prod.outlook.com
 ([fe80::194d:b908:f3e1:a25d]) by BN7PR12MB2644.namprd12.prod.outlook.com
 ([fe80::194d:b908:f3e1:a25d%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 17:57:26 +0000
From: "Duran, Leo" <leo.duran@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Borislav Petkov
	<bp@alien8.de>
CC: "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Sridharan, Vilas"
	<Vilas.Sridharan@amd.com>, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "Grimm,
 Jon" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"tanxiaofei@huawei.com" <tanxiaofei@huawei.com>, "prime.zeng@hisilicon.com"
	<prime.zeng@hisilicon.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, "wanghuiqiang@huawei.com"
	<wanghuiqiang@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
Thread-Topic: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
Thread-Index: AQHaZm8buLMwjFZAQ0uEYAlft3jKNLEYHRCAgAAZKjA=
Date: Fri, 23 Feb 2024 17:57:26 +0000
Message-ID:
 <BN7PR12MB2644C263D85DBE3DD6431B42F9552@BN7PR12MB2644.namprd12.prod.outlook.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
	<20240223154251.GAZdi8--NPaMAK_ZBp@fat_crate.local>
 <20240223162551.000013ec@Huawei.com>
In-Reply-To: <20240223162551.000013ec@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=799fb89d-1cba-4cae-aed7-d5dd753ca8ab;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-23T17:55:55Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2644:EE_|PH8PR12MB7207:EE_
x-ms-office365-filtering-correlation-id: 2d695d24-1d30-4006-f81c-08dc3498e50d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H7m++3iZ6+EAJrWNGNPx4XfMJiPXjQCylGfSlDSe9YkZhYdiQulRcQTK/iakWScqpvHP53LrHHoQNdLGviS9iD+0j3MRCVAHJqYEuMsp3HUpeztHWolFvV2/NuMwXydDq3goEaF6FmkWg+uKwJF2jJApjqf4l0uU3WOpyHX9UQW8OnPG24oVlolLl2iiGwnoATfJC0QRw2l+O5MGv4yn9T8Rtz8F/70CXZrZ1L8iV0aI5orGOaEhAf5yp1EC3hPiC9TQPrpMeFO0e7BXGSjndCek5E2L4dRhOqf7VMdDdOQv8OBfE2lgM8EC/gyrQ6RXAjVlFLzp4nRq/64tBiARf23zzHYwHeTOd/ft09lib1BRrJ93lHw8JWh2r+ilzqjEeYvhsseXT+BWN4Hrgh9suEFzn5M9Nh5jbNFND1LugtkndGJzstLzYu13r63kRNbnhfSsC0K228qxDeMAbFHN9J77VPktXV39bKBOGdq/NKU2Ym+D/22zwfscN6WDiEHuraHsh4adM5em3q4NfhilL+TqF0kkSTJoyQu0GSc+Nc0/Eef6P1i094CyzOYtTN5O2SO0i6u3cZ5Eiwd56QdJFyMrnsxHhcvPhV3vYNz2A3g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2644.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NuspfxVT3Jd6if5P8DXH81Mj2x1zTl1x2SEjEQkWjT84eascL5XiSP+PnsWh?=
 =?us-ascii?Q?4/c8pQlWKFNNJjX5nTo8blyVdkhcuMIM4Vpvzydo9y5QVsjymUwhu2ttoHli?=
 =?us-ascii?Q?jXqqUxcTRrWsBuM/ZE6fmptWdZfWKvsgvVgru33t2rkWQCsM1d26urYKLpvr?=
 =?us-ascii?Q?n2SvOcjQsdWifUuR2suC4jESx5JD3V5u3e5cgDDeIKbmXIOWzGtKFB20MOIU?=
 =?us-ascii?Q?dMjaWJEsAlOQz6f/d5pGKD3Far2QdLTwINv2s9Twy9SiDvY86lOg9gE2Ev7W?=
 =?us-ascii?Q?pt6lM45LGoUQb6MrhMPoBDAHfCiV+IyfpyhVrvb5CAicb1inajruzpxELmfH?=
 =?us-ascii?Q?ZvVZ70pra8VoR054sOXlcTKTipUJA+1TFxb5vlT6qWxfSllXx8O2XYlGsQ29?=
 =?us-ascii?Q?yiBmvepIdyDwZ8Ve2LHYFshIHUcTR06Z4mtvJm3TWeec1mBrieRoyc3L8wdW?=
 =?us-ascii?Q?sPm4Rpaf7vLHNhVxJAthmbMW9foz2OIwfB2UqpNtMYSYK6W9oLul5+yGnB0e?=
 =?us-ascii?Q?l8OWMeLuKdmgrNAOBH/pr/8pRYSmvZiTky/7Fr5hkjyJ2gnrxB+l2NYSvAK6?=
 =?us-ascii?Q?hgDneohJTSu0hd8QQrDRW+OwSN22hesAuDmCvBP8L8G7ydwaXbL8jzE/hPrA?=
 =?us-ascii?Q?8rHKwBh2CtM4mrKixDuoh3p/NvnlfWzWcXJBxRCVPUMJU+PvcK+PExAI8Exp?=
 =?us-ascii?Q?K3S/YL+Fnbq3nyzt8xvVmiuwt7UK+EX2OLWZR4yEaOk0hkRY0Agdb3tQj8eV?=
 =?us-ascii?Q?5mc5YHG0vkuXUZJVqIRr7W0njuRxQAQbwc/Eb9uLjknTKc99LwDraMZOxhbG?=
 =?us-ascii?Q?haBEdUC6d/9ANr2kIKc98tJzQUVgg2e/OaF/BYKi2tWAW5zYGWyf0Wae6z9i?=
 =?us-ascii?Q?eEVYM0YVHcoDjqdCwITsIKmViG7yN+tli5BjazBc2OavFKHYsbw/YUk90ttT?=
 =?us-ascii?Q?0q8q5BkMhvw+N0ZYXhM8WD3+FIl7yXR+o5SaRxZReGNk7XgnPN7Fp+Ec9flp?=
 =?us-ascii?Q?TsC1BY4SBKAe7Yl4iY6sjsMK1hTnoAuTyIHEQ+0XK0TutxNaWjUtmz1JiCwG?=
 =?us-ascii?Q?0cj1PG1vcfq2glLY3DRrfopNi7gq9Sfpk7kbrjdZDMSSM56RXcu9vsidDNzE?=
 =?us-ascii?Q?mt58jujLZ+h2VPXEMSBnUgn3UZz0zlpBrDPx4dDdLaSOCrdYh8gjSNgWbIrW?=
 =?us-ascii?Q?YB9Zbj1fOq0kZ0cadZ1mzEa7PV9bfmAKnGV55Y7wyeP69cLv3Xkn/3TscEVG?=
 =?us-ascii?Q?9HQ4Aj61GSfpxHQWg5hpaL2AspfhjsiSYRXJeQTP8ZBb8RZUpgrkLgXveCLe?=
 =?us-ascii?Q?egwWd+2Lr9xFSn97EllJ1rTR/agUUcVISFvF885SogFjLZKARoJSKl1j95JJ?=
 =?us-ascii?Q?9hdgrVHdd/q+MtYpOmsw6ISB+FAEYl6BN3n2jZ18eFIV5BC3XZTLmBKtW0jv?=
 =?us-ascii?Q?5SSj5r4dm4PcPgqHmhm2riGl9B5nxIa/AXn5CycvT5pVqkBs9WuF5GDNCfVb?=
 =?us-ascii?Q?LuOU6/NoFB3EqB4TmkzENZt/BDYSZNPgrg52VVJ9Yky0MTtntYd/XB20FKEU?=
 =?us-ascii?Q?mWN+bShdDjfzcRcuy+I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2644.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d695d24-1d30-4006-f81c-08dc3498e50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 17:57:26.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/ACqB4sWgSukp8rtg7f+71xLwjkhsCZ/AgY25k2Ie8vV9NWHguOz8t8y8kCIGMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207

[AMD Official Use Only - General]

BTW, what is the encoding (units) of the 8-bit "scrub rate"?
(the ACPI spec does not seem to define that detail)

Thanks,
Leo.

-----Original Message-----
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Sent: Friday, February 23, 2024 11:26 AM
To: Borislav Petkov <bp@alien8.de>
Cc: shiju.jose@huawei.com; linux-cxl@vger.kernel.org; linux-acpi@vger.kerne=
l.org; linux-mm@kvack.org; dan.j.williams@intel.com; dave@stgolabs.net; dav=
e.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com; ir=
a.weiny@intel.com; linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org=
; david@redhat.com; Sridharan, Vilas <Vilas.Sridharan@amd.com>; Duran, Leo =
<leo.duran@amd.com>; Ghannam, Yazen <Yazen.Ghannam@amd.com>; rientjes@googl=
e.com; jiaqiyan@google.com; tony.luck@intel.com; Grimm, Jon <Jon.Grimm@amd.=
com>; dave.hansen@linux.intel.com; rafael@kernel.org; lenb@kernel.org; naoy=
a.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com; somasundar=
am.a@hpe.com; erdemaktas@google.com; pgonda@google.com; duenwen@google.com;=
 mike.malvestuto@intel.com; gthelen@google.com; wschwartz@amperecomputing.c=
om; dferguson@amperecomputing.com; tanxiaofei@huawei.com; prime.zeng@hisili=
con.com; kangkang.shen@futurewei.com; wanghuiqiang@huawei.com; linuxarm@hua=
wei.com
Subject: Re: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem + CXL/=
ACPI-RAS2 drivers

On Fri, 23 Feb 2024 16:42:51 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Feb 23, 2024 at 10:37:11PM +0800, shiju.jose@huawei.com wrote:
> > CXL patrol scrub and DDR5 ECS and ACPI RAS2 HW based memory patrol
> > scrub features are added as use cases for the scrub subsystem to
> > expose the scrub controls to the user.
>
> WTH is a RAS2 driver and where is the RAS1 driver?
>
Odd ACPI naming.  RASF (which is very limited) was replaced by RAS2.

Both are ACPI tables that describe the Platform Communication Channels
(mailbox) + provide a definition of the protocol that is sent over it in or=
der to control memory scrub.  RAS2 has some other uses this driver isn't to=
uching on.

So in short, it's an ACPI spec defined interface for controlling Memory Scr=
ub engines.

https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#acp=
i-ras2-feature-table-ras2

Jonathan

