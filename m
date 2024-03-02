Return-Path: <linux-kernel+bounces-89313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394486EE2B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3861F23DE8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998379D0;
	Sat,  2 Mar 2024 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mgqrISUd"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A607489;
	Sat,  2 Mar 2024 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709347456; cv=fail; b=GCTERmXjHwbeQ7ju8jW0njTlyOw8mpSFi/ox6jOfIb+c1y2l5OvKw+FhxuDyizcW/BkHFLWJzKzD1E+s27CqDtcu4P/bOcAs2QLo6NyQeJf0+zOM2RgqqyATYlmORkOA7oG5Iv3gOb5ZBHmNI5LS+XBe2StbZR+VXFFgvkXF0d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709347456; c=relaxed/simple;
	bh=e+Mhn8+65s+E2W6B47W6sFCuClcftgTT2vdhQwG+86g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rN23CogyKf0SrbFM0+wpv4H5NyCC+gNpsI2wwTiB1NPyRoJcMyN0+7XCLrVKcm2un8leYnBdOEHleGnzmubbta8s92qTI0ak8RM70BHNqO2ASYF2Wn5veKeUMej0hESkjtmpFyTsDDmkNdVyfAc6SGY61Shp1t05PRnpjEML80U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mgqrISUd; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQHOlsn1d/bwLh83S0p3854qV1VP+gXugN+syrSyPYqstha65C00Y3wtnI/4EwWJEmVpmE6N93kXsNz33KybbGMaaoae2TW1nsNbuRW2Q5aQP22twKUlqJroid0+PzmgMV3dh4aADOX3P8xBUBDlsmDffHUFf2CxdZo7qAg32q1w18aM0vJRd7b4VZSHhp0Pn0LKfCgWZpYpyVZkPvnR/K1Ixqwdtvk1zhAumtxTSdKEVeevKq1a0Bw2AiBHDuFHSwlxM61vKtU/djxqt4fm1As9L2teVAMZCIiqsbIPffvtQ1NaRu505OnASgzIBKVliOojn1IJaMl/kCkwzB5cDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RG/i2zQXQTxQLSDqG1RiGcj8jgijg4dCpiJMsqguz2A=;
 b=XLPQLHktl/JfVapap/95io/Pk3KxS+UjBfOiM2YJSjSucqq1bIpBob3KIEMWkIwwoMiAshxGnKEkNeFOc30bFMXbYRnz1wHyFEGFvwGvGSabAydQWQOscajGP6KgTMjCKzKfTVoZ1BnZPT37SP00UBlOivnhyLEsKMmR+dbW51eplE0I1//+LCkfhD6t5u59LhqcM/Z6uUIpGPBNXyvIOlBedeFX2xFexOrrcJ0umPDnYB/JXnbCIZKWujYA7HKJSgH0fgJqNJkElzBzE3y/XE+z2eZLo5RUS77d1Rlu0F8cXwn1xRu0i7mg3yKpgqw/S+8k9c1HU6NdC4/aqdMzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG/i2zQXQTxQLSDqG1RiGcj8jgijg4dCpiJMsqguz2A=;
 b=mgqrISUdkOM0WLVFBesHpDIAmP9Nu7f8po1YUVarQF0aFhIX+9rq6WSogThLZGIqBQrphZ6AjjVf1aMm/bJdczXjGPXJqbufrQjgl9NcMp48FigV9dvoy9z43DVpi4xEpFyMrAimnt6ha7G1dgl+Wor/tO29UjaIIgoc+zgdqtSIxfB4P6R1iv1O1jmpimFxTtqSogv6V8QrSPgX096ObQ2B/Hgr51x2PZGf9V4Msllta5El2VJpeqMFvcwtcPDzbcbfp5OWiZG9oYKWeVdMejSBVbERVaE8GdnnYVaZe5dq7y8Noo/2UWm+JNvBh+Iq2UjuQYCNc+Q/mfpTkcyo0A==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Sat, 2 Mar
 2024 02:44:11 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::ae74:c645:b13d:3d8c]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::ae74:c645:b13d:3d8c%7]) with mapi id 15.20.7316.012; Sat, 2 Mar 2024
 02:44:11 +0000
From: Akhil R <akhilrajeev@nvidia.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "davem@davemloft.net" <davem@davemloft.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [PATCH v5 3/5] crypto: tegra: Add Tegra Security Engine driver
Thread-Topic: [PATCH v5 3/5] crypto: tegra: Add Tegra Security Engine driver
Thread-Index: AQHaY1jZwFltH5yLb0OQSiEEFOMbgrEhGKTAgAAIigCAAq5Q8A==
Date: Sat, 2 Mar 2024 02:44:11 +0000
Message-ID:
 <SJ1PR12MB63398B52A8FB2978636FAF8DC05D2@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20240219172530.20517-1-akhilrajeev@nvidia.com>
 <20240219172530.20517-4-akhilrajeev@nvidia.com>
 <SJ1PR12MB63392983F30CA57CBCB69B93C05F2@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <ZeBSEviAw/JVpICl@gondor.apana.org.au>
In-Reply-To: <ZeBSEviAw/JVpICl@gondor.apana.org.au>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|SN7PR12MB8604:EE_
x-ms-office365-filtering-correlation-id: c880b022-389b-41a3-7f7c-08dc3a62a435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YDHy9uoNNg2sOpfQ5xFy6GhdlBrw5a1NMOyayv4W1lRbsOOv/JBkWfCpDVsDdxx4veZ8cpYaMuYbMk52HofxS6IIVOodKkUwXMO4iP95tnFGVpsucfeu1iYUyl1X0p/gvC0emfecTnPkxlXzXenWp/8piBmgcsSQrztOdzXn3DS8Lx56umzt510ii8U2IxHf6n1o8TnfDV5zahqyt+G834BSYS5rHUevmJwbsuLvLiwjCIwxy+V49Q5kEgj6qOZXXzykdktstiOyHtj7ZIDo7gGQWKWDa03yYvf/PfEDBe5tvcZSrmOJUwZQhoYpBOLO55agDUNLHIi8+ZT3ECDwJu+o5qFOT7xLVU1BBctsqg65xapERYZeqRqA6bmcz4aJN+jINsQ19xHIAuhNluGv1/+uXCMfIsOpsi7O4YNQneYwX3WoNk0lFO/HqdRV6ox6Dk71Ka7L7snKtArf0j/BhwVaDrG5kxpoCl6kQOJAAMVgXtfzISipt7kWZ44jzGYK13sSrxdqLF5CNhA/9qfsYrUiQjEDEAbAitZCDnDgFkUHlgNm/iTxJnxWYQO4f71TZOYxecw+meqekSN4YDJRBjK96ORftn5+3gKETkp7Mc/Xusvoc4DX5bQF5oLckA2k3lxuSz6wFH2e1R8xd1aObBytlAsgrEJCKkv0pqq9+8oTeZFT9uZb2blrIfKmLPTgscJBJZ3sxVPXPjlBPHQQzQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gOhxFziD+xt1gEs//TYsFdzQbnbfjG952L5/H+Nb1kPxrOrch3tuse49Ujww?=
 =?us-ascii?Q?qHmgk2phjj54UZJr7cVDW74bcsdH7PTfh5GIh2+HI7EYhZMv4i0U3OnNgeqi?=
 =?us-ascii?Q?b2DjS+rllU5XK9MHQ11XUTvVEURAgVR3HLmFYQ9FS0bV871eb5zSeD1qWY5/?=
 =?us-ascii?Q?mMdSKjToueAExVZKnol0iX9l5qh4nvGF9Lcs+6Ny9xvI8xpCjVrT1DF0Mh6F?=
 =?us-ascii?Q?mObONGvaV1QY3mWNASvn+A2VQIL1klS0ODjBR85Tixfvy0LC5OSF4O6M4SZd?=
 =?us-ascii?Q?S7duroShPH9DRb161o3/trVN4kYw6Q8J6ioS281VaRkXn7+eRJa2tt1cWR7w?=
 =?us-ascii?Q?2jDB7wc6v5afmq4TpWdjvUyehgJXHiOXghC6KO/eTuYaEScOW+oSqYNj3Zsb?=
 =?us-ascii?Q?YdlxawM+49v7u5bvPOcqogrxMSalODZHiYftj64Z6yzs/Sl3WN36Psfs4Lw+?=
 =?us-ascii?Q?cblxJag5jnVZp9lYxYODPzoIJUspy1MU9R7SwTZdbPz09vhcDqr9FMNGrjrb?=
 =?us-ascii?Q?xKnHWxxPz6f+aKuBphbRNgWJ85nax9WGdRu+KBVJIopdz1zymv7s9h9IfvOT?=
 =?us-ascii?Q?26CONm9kHS/wE/SBnqRG42KC5PxX3ethq8UANrFSR3HxVP1ykd7bqhP3hZqD?=
 =?us-ascii?Q?ouY7clv0WNYfEcBF3/Rr61KgHCQ4eEZ/+FH2b3iqhthJvQudCwcJPfT1o5vl?=
 =?us-ascii?Q?RnJgzruiqlwuWT2WbeaF5YDEJpRKsxnPIez8L53Pi678DBhzEr4GZTAU15vY?=
 =?us-ascii?Q?To9+VSD/tLlVYxUQGjlkfr/idh+qgDNNOjXZZf9ihZQOlZIw0y+d3uGPCIIb?=
 =?us-ascii?Q?UrUvGiQed7CRquDRfXStrtjyg9jREA/YpsGvFEZgK53ve/1nYHapPf4QCemw?=
 =?us-ascii?Q?Dj3z5A8V1pJcJTBaIthLpO2YZ1jxYQCaq6+LLqqkT2v7LnftdOmboxua3nYu?=
 =?us-ascii?Q?bhc7N6BHycKdbdPLNkqqgElo0EIxZAMkf7DPwK6A2y1RWWFOFLi9Ewy7QGDV?=
 =?us-ascii?Q?jkuhH/yWjMl6Ev0PuZE4QPKzet6xvYyex1Pgv0Al7s8HyFJ3YddJHjcToKd5?=
 =?us-ascii?Q?bFWWuQSFxTMo1yRJKkYLU2pHiEpEo16ftgiIpXJxQJOEzosaE96sioQnuDNu?=
 =?us-ascii?Q?xD+SK7EM4IGBypyszELzrTNZ0ASNnJbkAco7Vmvfgkpcj7ZtpJgus1QAJUXl?=
 =?us-ascii?Q?vEEtX1McCUtXw1LzakuteY3J2vayijsDZigfZyZBTetCpq0wpwbGZbXkqVfJ?=
 =?us-ascii?Q?nNdqO+0rSJ9eGB94LDKHa1LLee8UQ7ndWZGWDOo+8cmyJIty6zKZNI5rMV/l?=
 =?us-ascii?Q?tiLCciEADt+LOn2awoG6cMtfdsUif254pPsH64LlqTbTuwb10BZL/yFajVun?=
 =?us-ascii?Q?2GYfGdKso4D1yqLSurXfEKwkiHZFsQ7EnPx7GUDnF+93OPoW83cl1g25LZ/m?=
 =?us-ascii?Q?9sXpaHj2+bTwEQ6zwhx5GyXATUx7ulHb7JzsYlKxzbUWEavxTl3DWaKSTAD8?=
 =?us-ascii?Q?P0OfUCjOUPq3/YFlMH6okgn2sgIk7UEnk8V2uOkqc9Zk2QdPCXT0oCHQVMmt?=
 =?us-ascii?Q?AQRAkYxWATgwM9XVIW7p+6GvguxBA0GbMiWvEXXRRHkQi/Rqw65TOL3wYhe6?=
 =?us-ascii?Q?uV8wzMsh66AnUg3hTluRPTawf3Plj+R6fM9EbvXMpmgb?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c880b022-389b-41a3-7f7c-08dc3a62a435
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 02:44:11.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODaZFAU826DqgmyMdh5ZyX5k1C8WfDVQfijaufh+r6MOLbmwRxCDHHIMTekN0FynZhvHpsg3p9QHXLJo4LRRFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

> >
> > Do we have any other concerns with the driver currently, which I can
> > address in the next revision?
>=20
> The sha export/import code looks good now.  Does it pass all the self-tes=
ts,
> including extra fuzzing?
>=20
> The same export/import issue still exists with cmac so please fix that.
>=20
I do see some warnings for some AES algorithms with extra fuzzing.
Will send a new version with the CMAC import/export update and the
extra fuzzing warning fixes.

Thanks,
Akhil

