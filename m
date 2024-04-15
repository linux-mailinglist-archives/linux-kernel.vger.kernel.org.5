Return-Path: <linux-kernel+bounces-145490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38C8A56D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD56028286A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C587F47B;
	Mon, 15 Apr 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fot2Tnww"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E476033;
	Mon, 15 Apr 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196609; cv=fail; b=mLQdYpq78VsnTVil03lnNaUoiLTpZTpWQrLvQ9b0ZqLOqN3/Q6qtBRQIfzOL0KYwhE1uVPISpT6AASDLEkKl+y+uEEofKRuY1PoHnX2u8JTp++eNL5qjlBnlaGyFQH0vum2GZtLpOtraPaDcND76MWKKO7AQGokJ+g1H8VAPoIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196609; c=relaxed/simple;
	bh=A8gJJDK3ckNQwCmJtScOGM3iM6/mij226aCgzpddLbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lpswz4EJuThpYTTIKJwU6E0TbN+0NMQle1ck8IKjomk+lDQW0Y1KW1tHTL9SnZBoBjgU76uY9CThXN2fbg+ucceZ+hdbbBqDc+PWbRwom+EPNsa2nTz+XlnHZqx7JPfo0OMUzGfT/Ea9haHgqOj40m1XwoFqSkeRmMpZGSZOGFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fot2Tnww; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYplT16kLBjUrLt1PUOaeTBFXqAvxRkzuRbFk2z2blWxafz/iICEHFR1h4t8g/9VRwg4g4wPZBbzfRecMVvOdVB/UO1mQriMCs2u0ZtPpbZNuR/yFCANoHdihKIJgP0bZRfgrUgHpD6IaDokGWvhv6Ef6XKAy6HYqkjgaRXLwhZvCLJNUa9vZMaQAIFyMvqgHmLDusW6yeLqIgC7LIEOtZyR9KJYirnGvx4tHee8umLA+CrrszjI1vKIjuR23tCiXuf/gy2gxf8bwfu47ZhW/DLNvMcmrRWzmJ44juTdUlZbzPXGAowCYJatfbDbAEALEIh8CSV5BZmTQ0FQ56y33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr0NpQlpHEnXf3Igwg/UIz7DZlyLpFtioMokxC6G9jo=;
 b=QFuAQIIESo6MFJR+eNugN/0HVT+OY9PUpf2cmb3BPT3LScvtbqGSS9fI7Txy/ORdPPuAp/xbSXCVHKYOijT77xmpjgobvKNlQk7ZVeAVlWvQRhtQ2vFLaIFoZSGDs96Ef7NO9uMuMcvJrPwHVZkaDkoVdTHxpe7pnyWn+3yTGU9HpclbI5Zch1grdBm8Wb5ajocDRAgszekk0rF/l105cnqYMWRImfEAzIOcBvFVeu/OJzutanBsvQqapzMMQdml53GZkm600xdb4HqvrSnkRTdIxb/yYi8arhzgrGMCj0NqMO1SVg1QpIpqhKKF2JAJsRpX7a8E4wxFfzT8AW6nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr0NpQlpHEnXf3Igwg/UIz7DZlyLpFtioMokxC6G9jo=;
 b=fot2TnwwRb1+ScgMc3PYHP3/v+9yXXZ3Zle4NqgXNPOwdhU+JdeOZnHX5xShHjoVY7dgD95+VzyCG5LL8KFt3IFiu6SqYNSos2C5ZMpsxkqIIvLuF9l+5hnb+xzrmbnkqGbsVuMdCTo4L2KXNWmwmboTkcxJyM1P6kxbgQOAdrmraTn5JOWeo5/cB/g7QYKrhsw6gI0q2RoF2xwk5TbfvL6AJzsvq46iCiabFiz8dsSG2eO4x+CHXqGpkkipLrafd6QJGvjfEGwdkOAxD5EpKGjEPbnuTwyj4v+zp6DFhevDXgSxzhZXA91x7ngkq4aHX5WzJ560V1IcsJWWQ4RFMw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 15:56:39 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::abdb:7990:cc95:89ce]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::abdb:7990:cc95:89ce%7]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 15:56:38 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: "acme@redhat.com" <acme@redhat.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "james.clark@arm.com"
	<james.clark@arm.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"alisaidi@amazon.com" <alisaidi@amazon.com>, Vikram Sethi
	<vsethi@nvidia.com>, Rich Wiley <rwiley@nvidia.com>, Yifei Wan
	<YWan@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Jon
 Hunter <jonathanh@nvidia.com>, Sean Kelley <skelley@nvidia.com>
Subject: RE: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Thread-Topic: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Thread-Index: AQHaQzFqj8OB2Vjf/EipAzIhMbFp+bFqE+Dg
Date: Mon, 15 Apr 2024 15:56:38 +0000
Message-ID:
 <SJ0PR12MB5676F0DC2CFBBC96534CDD65A0092@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
In-Reply-To: <20240109192310.16234-1-bwicaksono@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|SJ0PR12MB5611:EE_
x-ms-office365-filtering-correlation-id: 13358152-cac0-40d1-9435-08dc5d64a2ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Vu+bDQxIIkXHKjIJuH3GixMiOBVPVfl1ZmdLoQVNb/85n7q9p4Rw8E57W4D3lxZvtOE4b7G/YX1g23o9BiBh27CjXHERyrMSDF03Xw+WGk69amtSgXC3HroZw0JoUQ2naYJFUTsBQr9zRmylhcLpKDBzROTFUQxiEGRogDrz8JWzry7BL/sxL43VNBQMvLBYOGQfYyVQ1QHYYQY9pJ3aXpUGaxM64CMLEs/d3T8+BFXBKcRffNVkfeyLvx7Cmj5fuA2IwwGbER6g9tcHhv8/S0Oi/iV/m04185DCo4D952xX4fgHTLfN2Iq+8j1pDFzysRAkSqU8+mFA+khCWk0HxKrYu23tHPUcISmLl2jx2tInyz8S5wh+WYSLGHXjiZNldD9ABPcfDo7lOnUWYAxr6fJ4L8+2cvoeZ7DhT3YAiDCcI9tMSKJw7lyFWqsdVGjoOvgkp6Ar+KD5Ykai4L1ymUom07ILs4SR6irCKqHum90ZCSFOu2E7Hk8YRiVjYdNeKG8bJ4yiRSNettUxHUKxc2cmW63NkZJ5tYx8bZfaXeKBQjTXpZ/vT4/GFVRcTcidQaG3eKkXmW9R8yq9mVGORlt6qFdOfvg7+Mvh8p17coQ5izRKhAQFrut914hD3sv0zQa2cmC6jG1TqrJxtt281LLqcqBxSQMnbX5VR9bsR51Xo8V9/0KG3ZGwFS0E8E2A7nTgoQjz46BnssNp3pHDWsqoEiajH6zMOJHudGTm910=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bQecxJLuw78T7VM+EHRZEMV8Jp93XV1r2wawlVEmL8cdGp2VvO3ydKuA/vu/?=
 =?us-ascii?Q?Sx3iuiZK5ExaN36aySdcIdNV8oUiLSP0IbhOD0zEEwRlYPL0isK1R9IUAnKK?=
 =?us-ascii?Q?eLp1Tm8CjgFQrhzlS/J/+AzMv6tSHISEEVh4tWRidT99/+JnRZ7QdEgOwZfR?=
 =?us-ascii?Q?lbVAfeKJhgLwOvvYfK0JSEfOrthblL+hnuScgxtpgriX/IM5ab68/sczJHG7?=
 =?us-ascii?Q?byUiTHIwomrRzRMFRpP6CIwpitgAXGIURQ5RYI1yFzHx7MzQHUSvIONKATUt?=
 =?us-ascii?Q?Uen2geBb1V9cPJH3qXPOtHDVKvKEr84Ig//+vmddvi0PvTWoD4+3S08t2yZJ?=
 =?us-ascii?Q?l2RePbRiMbwRdSyqJf4bVndpoJD6CQ2UXJhGSOupa/rV+zRrVgwSVLk63S/9?=
 =?us-ascii?Q?92RJ/3lgQ/ok73g0ymC5PKktBc4Rdu2ka2ONkUpllAUIliFP4vm9KcjrhoqM?=
 =?us-ascii?Q?LobxQdrBD9TOQsLZHjopzZ9fNOUirq/DSbPxURDam5QU+H3F1HPlyK2rqZU7?=
 =?us-ascii?Q?HbQhMLupo0yutg0V9cLJuWXUDJx6tlQJcel2G9z5vq6u5VBdKtTIb5FNeOt2?=
 =?us-ascii?Q?JvRL93qdn6WD765Z5owyULLu7jqxbmb5tLCdOG7s4+uSOBukXRiENYCedyH3?=
 =?us-ascii?Q?m87+U+FFdGznHCqItauVpyF92T8yVzITRtS//EXMKfSvPmgD6MOaf2ouKaBk?=
 =?us-ascii?Q?t1dsx8fUxR1Z16lVj29p30dgcZOKSFue0EJ+pmEUF1cIHN41SOQlh1YqBMc/?=
 =?us-ascii?Q?1g4BkbaoAZTJ3mHyzB12mxxHAH0SRPyH98uJrtWHHNJgFe4fFO9yICPb7PIK?=
 =?us-ascii?Q?IE/FXRZnAIU1Mzy/g+QmLDvZOvv3ZJyRUVRWhb65RtWjzV1Zs2UFb9SBhlAG?=
 =?us-ascii?Q?5Lr5GwXJFWDhbYZ1PTCOGDi6pZgU/y5HPCYURiEFX7tHyaR4xm6S/owe0vxh?=
 =?us-ascii?Q?zbhukQnTm8H/gHqtpGUMRO/LKA6FWSxfh8D1M4D02r/lvk8GjcLk9BONebzm?=
 =?us-ascii?Q?V0aIyi7DNsIFMbJjHjgAKcHx6BYtNCTj//LgCeGDmGmsSYWtxfg1uzE9LEYl?=
 =?us-ascii?Q?I+bQsqNr0HMX9bPX2lDxlBuHqUaWRO2qnjNUoIBqfqwaQlyaqEnoz6PS9K9b?=
 =?us-ascii?Q?rjzIEBTXQyZb/dRd0D4WTpVN8qauIQxuYZd16gWXsN1ZtVvE/Mpjo5O/GpFg?=
 =?us-ascii?Q?tVorEfVYttjZzQ0veSI+Fatk3G4be4jgjp5Rr5H2qfsuir7gxpNquqYsZmf0?=
 =?us-ascii?Q?irDOxu8N2p8F9GVI8q2JSjC0TX+kW9hTaHDaI2P8nnL/MaVDCK16xEACS8AC?=
 =?us-ascii?Q?PRpM0kSp3zYIVxYk7XEbX4I1rFIdg0Rqp/oiTT04Xr3LtxhtjOv2BeFwtA6D?=
 =?us-ascii?Q?SgFwZI4KtJY8adR/qW/ckeDr4jytGwlUAyfs8ew95FNcZNb/cNSQj02vqvOu?=
 =?us-ascii?Q?/ap3IHvdWztR0s8mHDbKbI/a+j/Q5W3kSRovgeP1YWs5HIcJtPaTDUjUzlYf?=
 =?us-ascii?Q?g9Dzk/tZaKYHDAi0Rguf+LoetYZ2pUi9QN+j4mZcR65Z99q5SOw+k0JZbm/F?=
 =?us-ascii?Q?gt2jtGpGI348ZFxlLA6rN7xPV4H0vHZcxnbmm57E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13358152-cac0-40d1-9435-08dc5d64a2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 15:56:38.8509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqxZ7ll2wRfEfsjIQoH932ALF0SsnO12Bzb0aSIT9my8WzsnBqqk8aaXODIkuMkwamlzWe5xnjuMwaFd/LBkrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611

Hi,

Do we need any more feedback to this series?

Thanks,
Besar

> -----Original Message-----
> From: Besar Wicaksono <bwicaksono@nvidia.com>
> Sent: Tuesday, January 9, 2024 1:23 PM
> To: acme@redhat.com; catalin.marinas@arm.com; will@kernel.org;
> john.g.garry@oracle.com; james.clark@arm.com; mike.leach@linaro.org;
> peterz@infradead.org; mingo@redhat.com; mark.rutland@arm.com;
> alexander.shishkin@linux.intel.com; jolsa@kernel.org; namhyung@kernel.org=
;
> irogers@google.com; alisaidi@amazon.com; Vikram Sethi
> <vsethi@nvidia.com>; Richard Wiley <rwiley@nvidia.com>; Yifei Wan
> <ywan@nvidia.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; l=
inux-
> perf-users@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Besar
> Wicaksono <bwicaksono@nvidia.com>
> Subject: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
>=20
> This series support Neoverse-V2 CPU in Perf Arm SPE.
> The first patch adds the Neoverse-V2 part number in kernel header.
> The second patch syncs the kernel change to the tools header.
> The third patch adds Neoverse-V2 into perf's Neoverse SPE data source lis=
t.
>=20
> Besar Wicaksono (3):
>   arm64: Add Neoverse-V2 part
>   tools headers arm64: Add Neoverse-V2 part
>   perf arm-spe: Add Neoverse-V2 to neoverse list
>=20
>  arch/arm64/include/asm/cputype.h       | 2 ++
>  tools/arch/arm64/include/asm/cputype.h | 2 ++
>  tools/perf/util/arm-spe.c              | 1 +
>  3 files changed, 5 insertions(+)
>=20
>=20
> base-commit: d988c9f511af71a3445b6a4f3a2c67208ff8e480
> --
> 2.17.1


