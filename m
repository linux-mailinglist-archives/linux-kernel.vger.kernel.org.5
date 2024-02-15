Return-Path: <linux-kernel+bounces-66194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DF85586A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0B128F811
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785010F4;
	Thu, 15 Feb 2024 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQmRreri"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80D623;
	Thu, 15 Feb 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957989; cv=fail; b=l+ZpANYNQn+e+xKEtNZn3QC3B3/U2nPRWDCA7r4VTOZzIEJ/seZQy+I5bGuE6CZY8+FB5FqEm5oa3QjFSvP0oVqprPAxm1u8Onv4cXZC7SIiGxIM98kCd6g2p2oxKtujJLLnukPwUF15fc8iUg+srKJNADgXPPwXh2cDr193ZQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957989; c=relaxed/simple;
	bh=PsYM7RR88t/oZRtuYEHJVdioeuPJHvxi+f0uoRXa7PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T7kcbPPMUVQZ1Sjk1vDfFUA59mog3d64bYwSjHq6gU0AQ8KQvtTiUIoyGJ9ODtGdNJWZ70wUzBMjxCKoe5heKUyk9mh/Ty5pfLm8dWVf3Mfz3lrYQ/k6LL2nF8JTg+A0w82SSiUlfbvfelJBvwjiHYjiZ3DZx7kz2scHGWBZ8RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQmRreri; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPxmdXSnQOIDJe0I+UqR4T7+Jm8weN5taTe/gpiCGr7X5U9Cl1bBiR1Pud+93Pc+hB8gHuwjWkXR4FmAsllNhanwktm7nj+72r45ZtlfSL7aWiSi9KVn/wuNnMo8yS0inuLnr2MmB9dKQudCwv3WjTJFZM3+9OXjiBlJ+7neuxs4OZoWF6yO/BWvuHSlq3e6GupK7TzQwqO5xzcugnDRZ9iyFglJbqfpryrYG/iNfI6+Nc6QZYYtbzAaxdOtL81zw5EFq2iRwIH2LaZSx4mmvw/zvUH1l09PD8+RErtfe/KFA0/FlR/wBh25rG6eR5Ec50Edwy2UF1jFccvwHclJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/v9M+zY5zBVKNKfpT1SScKq12DC3GqoMjkqwuhNvnE=;
 b=ISIbMQJeky3WG2p2Ua6pKanTGptrIEsoHa5dTRv7NyQEMnQup3uzSd2j6OFFLXprszgPMcfYmgeTlYrohoPcsR+FETFWNQzYx7rk6WAEtGbKaKEu9obKs3hd4PmvLASB7/0IVflinckO9dPh6EsIQoC6zJ27bCwma0DrLhoYlO0sBuS83JV4IwzjiLG3h/S7QuXEV6sy/zeZmnOyelIk8WUgZ89n23iV90pz5WZMmVUu7SvzO8pCCT5pN6SEup/YCkdWIElQNBJWJcHKwKEP2+lCbcH//387VU9V0K830s0PNtHMzs81UyFPZ7Wnl1T8/YsJhtjlgZADO3taE7vx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/v9M+zY5zBVKNKfpT1SScKq12DC3GqoMjkqwuhNvnE=;
 b=PQmRreriDwwE9TT9Pt1C//1kdzSVbe3aFNG+21fHDq5YZmuYBPQax06+pXRswwmZVbsyeLNds8u+YQlIXKZJpz18P8m9O05xB6NiS6FLMhY1AT4V91EVvCpdGTFTFe0Haxh4ckr0fWN1IJg3dAXpI3PEVsqeDa+vHdS45j0xwn0CejThVWHtAFLkqHBlYoPE79BaLn91My/Iuu8d+vpSgiq77PshKJ8pjX24sGqbXYHVUQqKwa+k0f6sVSFFRTGlg/MuCh4TvDs6LBtbMJaOJqRra+LYDtUOwvmCSoI3hxSOXcVcK0m0oOcNgkI0nKqnzuYl0bHEFeVmdhepXlXf7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 00:46:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 00:46:22 +0000
Date: Wed, 14 Feb 2024 20:46:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240215004621.GJ1088888@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org>
 <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
 <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
 <20240209145828.30e1d000@kernel.org>
 <df5d7538-52c6-465c-b250-13532b90c6ae@kernel.org>
 <0daa6f37-8c50-4051-873a-4e8cd4e6cc58@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0daa6f37-8c50-4051-873a-4e8cd4e6cc58@kernel.org>
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: afc72857-4a19-4114-33fe-08dc2dbf882c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fnYb7+tHtomJina6tuynpO6QyFpijM2tiXA2KcTB8BHlFvz+6wGqA8eMSwUR4E9WTUsXV3egjdyULy33xYKTyoF9pEj5mNvE0ovrsiCdIckI7tsVMu0KOjUlIGr7lqDCZY+oZX05t0UvRoK+sG8XpzwG3i8CfZS49/sN2Ka8w3pVvyr+hMuunl9IDZxQp9syj8VF1A9B16oWyV8G74TfRoGtj2uZvy+jyXtW5SJ2Idq7xBEpuqdFVZyq4AroGL9Y6SaqYhM7K6MJtzapVFKJeMnBJm6ojhHxE9+/XqwGa4w2D88OOucLSoyPtAND2Hm26Dis2pJicy8/Nx8I5L6a+rRZiHBF2NTEwBfSFz5KpPhj068NB17m49uosv04XnGmlMT277evoCvdo+dUaKLFWl+LrpNoAjRuFHHQYZWarBVVarDWTwhmjlbF5h7Lzzhvp5QBS6gNS+t4CClyAkZJA1wzoNVxzPtVElMLOu8q7dHqpfKqwG98m/CphI1/2wZRBCW6IsZEgEcdBBC074twXs+4PhQ9vMnr7tciPzIzo7AUiavuRMAhlzyG+z8MixfK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(8936002)(6916009)(4326008)(8676002)(7416002)(66946007)(66476007)(66556008)(2906002)(26005)(1076003)(33656002)(38100700002)(36756003)(86362001)(54906003)(316002)(2616005)(41300700001)(6506007)(53546011)(478600001)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+FSgSHdUZrTJ5AljF4PO7G7HzmOLNf0QetBQNLCVT+xoyg0NDSZJOIYedA6?=
 =?us-ascii?Q?yYGp8wvab0MTPUrxhJXfZjd00fj2PPhyy05z2kRB/guTTvoTgC3mXXymoSjm?=
 =?us-ascii?Q?rIGMDNx/KJcInCfrdbJuKu8ZNiOeIJxXqNCCiJzVfKHwogudm4/4k5B+nDNC?=
 =?us-ascii?Q?H3cNtbGW20y9BZEqEapNNH2WmpQMdNrsXPQ/6tulvnZsjqScae2yboTswuUU?=
 =?us-ascii?Q?juot1kd/aGATb+uo6AuQWigQIq8gT4A4dfSiGmrq1gzZwLxPiu+GokgJoo5K?=
 =?us-ascii?Q?yWVEFrtcxMixS/E+wttTAYo/vfgHv6rhA/UaZtTFLImNFpQ4HexFe82xapuR?=
 =?us-ascii?Q?6J/CI//r6VVOwnL5xpSrZ3NUvKB/ypa4fc9I+ZH/DgHAKYHypbCYIuOWogoX?=
 =?us-ascii?Q?JUBgkr4wTOv4hjRv0l8Ujnp3Yy+Q01rx9GgeQlkdBKWlIERJHx+sV0crbK7t?=
 =?us-ascii?Q?lbDsNC2kklCbYaOHJrshFaUMg4GgQDP+FT5a9jtpY5esukAT8233sRVj8/4E?=
 =?us-ascii?Q?MtNJr7K38pYi4m2HiTJpan6QrrhkYX2SASpWsk6F9RlsA8iZvEL5Pil0/34l?=
 =?us-ascii?Q?q19ZF6gdxV6II5sXHhSSRB2a6W2We8yxPjxVGrpmbj8VLUcjq8IbKbES6ljj?=
 =?us-ascii?Q?bZq2HPPKwftSpgBktzS6JoXhK4HExsqe51u947kl1bY1NXzg+YYLgMWFdgrs?=
 =?us-ascii?Q?qdUkj76STl6u12nmxYQeaXKiJpczZACVjtICZQEIXQclillj969Efh3/2bZQ?=
 =?us-ascii?Q?YuWCewl5PY1qUJnWVpepacdVpwQlHuN8f217AlhSCQA+gyYCUlRcPm+3ZHn+?=
 =?us-ascii?Q?vPs1IN3unB3zMFdyZWwmtBipzhJHs8wfnrr7w84cLyCk7GJ81NAvxM0uepFM?=
 =?us-ascii?Q?NTpYjQLllD8nyqRV/xX0FTd1fSStJOBk5BS0sqhsVc6FzQPEXqyt4IyCaqSS?=
 =?us-ascii?Q?dR6WiCfJp9hzZ2FwW8WfGm2VPshybxNHJvOCaCViMhpy8XW8L+QtD/viTcH1?=
 =?us-ascii?Q?mGR8CV3Sike10pcd1mrIgpu8mHfSCnUk4h/mBSQ1nnR7x1Bk5ZhC9lOaNWXt?=
 =?us-ascii?Q?DYJ/GHpd+PIVe3XZISEk496fTUuAqCpfSxLakfvc8a05+UDhR647idN0BMwI?=
 =?us-ascii?Q?lglSK8I76T0jjLA4FdVW/5k+VGm/nlYRKuJ0zTe9WkFhdeMptsa5taJ8S0CI?=
 =?us-ascii?Q?Uo69ItvTGST5xvHARwJmDnYWXPaYpPMx7aNqcSgj/S2RlpMzAruH0XIupqB4?=
 =?us-ascii?Q?KoZPx5VFYqxWEirRbqGLV0XB8pwYnKicP0zDNg6nozPAbKAgWs/9ZC4rNJwO?=
 =?us-ascii?Q?stR3QAscmUBg115bIGuSUZ0ubVOhE4B7Z57pgJacQd4AW2ZlsDcxm49xWuN/?=
 =?us-ascii?Q?dUlZEQCM75unfmC48NHrM48JDXs9rZTJ1PaYyCR2RzsOa1lHX3aZzo2s9JR3?=
 =?us-ascii?Q?innbMkRJ3k/uzbc0kMStDAU3dwgMMygzB1r7fjZkfvKuyVxVybTvoFAcoKy+?=
 =?us-ascii?Q?T2H4O9ds6+Ixj9ycWQ1Cn8tMDI+r8bfboZA6C4dbGmGn+1Hq9ago6pyYp6IO?=
 =?us-ascii?Q?QC5vSIpkGso3WEnylCo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc72857-4a19-4114-33fe-08dc2dbf882c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 00:46:22.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11ijVVXViIIPHSDNCIObyP/a/6XKrQJzw2t7u4TawPukSTxZs0cK2ysMYeqiYSW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434

On Wed, Feb 14, 2024 at 01:31:29PM -0700, David Ahern wrote:
> On 2/9/24 10:01 PM, David Ahern wrote:
> > Maybe my bigger question is should drivers that can do different
> > physical layers, or can operate without a netdev, should they be split
> > into different drivers? drivers/misc for the PCI interface, drivers/net
> > for ethernet interfaces and its APIs and drivers/infiniband for IB and
> > its APIs? Generic capabilities like this debugging interface belong to
> > the PCI device since it is generic to the device hence drivers/misc.
> > 
> 
> I do not recall seeing a response to this line of questions. We are
> considering splitting our driver along these lines to upstream it given
> the independent nature of the capabilities and need to interact with
> different S/W APIs and hence different maintainers. Any reason new
> drivers should not be split along these lines?

I think it is essential to split them up like this, it is why auxbus
was created in the first place. The subsystem specific logic should
live in the subsystem space.

I've had some conversations where we have disagreements about which
functions end up in which directories in these split up drivers, but
the general principle is good.

I like mlx5's split where the core is about booting and communicating
with the FW and some common helpers then every subsystem has its own
FW calls in its own functions. Other people liked the idea that as
much "low level" code was in the core and the subsystems would call
helper functions in the core that invoke the FW functions.

> If the answer is no, then where is the best home for the PCI device
> driver piece of it? drivers/misc or drivers/accel or create a new
> drivers/multifcn/?

I've had conversations about this too, I would vote for a new
directory going forward. drivers/auxbus or something specifically for
these core components of an auxbus based multi-subsystem driver.

We likely need some reasonable rules so that the core driver remains
an in-kernel component and doesn't start growing weird uapi. If you
want uapi it needs to come through an appropriate subsystem specific
thing, even if that is misc.

Jason

