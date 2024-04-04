Return-Path: <linux-kernel+bounces-132097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD5898F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7B11F235E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68A137C37;
	Thu,  4 Apr 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JmfBpIwt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845696D1AB;
	Thu,  4 Apr 2024 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262343; cv=fail; b=CehS58Bi9mP+FD5jMYQG0/QRsyirLlPmmUTlQsMrHZtK8uelm/u3A8L8X5COANOTr0/M6jJKe22P5KItVJzSR5A+fxkR4HJysXr5awOGVzOif9ifvzozdMTIltD/QrYutpYQvTs8jG3G7iqlk4VtKFqh6Yyp1I4oBW13CUkNNgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262343; c=relaxed/simple;
	bh=kDrO1K7tzw7hbaPvG2KM1fEdkisN4mEETTpZWjriWHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iFkhzhGDSC6g+E1+nBjxI/1qRr8bSI/MsSISZ3M3tL1mgHX0KPTMYarUOR8oshfazTBSTGS46ebJGX2WrekOMKG5BWTtv2obHfEU0emrf5oCVxWIv3TvcnkPK6m3wXqEapo8s8/piWK40TANmwIF7O1SlfSUC9y4W6Zwf+Gxi3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JmfBpIwt; arc=fail smtp.client-ip=40.107.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAqcMNyQXqa7p6UPLJGgBUxIU6bwFKq6eKttWruxcL77MXSpyV5QTv4Xm64L9JVTOZOlWdm2n96scniUM5WUrFwf/QtMyqUji/EaFSqqAZLd08TEPsm3Y6xJ6bZTXCC/wwhhRsXzTMODu/+eTr98vWvkwCfONm3HMkRJit/q6kd8F7LJLLHcI3c8SUTfeTuFVNgT6Izeh5DHrjIWYhQmYiaq+Ye3U5sn+GUqZ+8D/r1TnCmRrL/IT7Mnnc7wkZMvgL5Ph5V5S62qa4N2JGMgV0a3S1j6YVTB6/Ag/tnlXN6qVrcN9U/RM7wwJGrGIgn9ZpdqB6NWjN3xZX3+CrDNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzJoH4VJsZGMb1C9e1Mm/SfimQ4rqUcWx8t44TvMAPk=;
 b=ZjU5XDRJoP3lF1xEfeWyfwsuMUf087WnLF3YhntiwbLelBIokXzvuW2uboILB+D7NHQlZQIm10KS/P+Mp0NPjGatB/JlzcNNEgF/dpqQhBeqVV1AaFuBy/oD5yOL8NhSACO/a0Wd3wipDbf39WgNF6dGkuQ2Aukg256mbVyxrwDt594A3gbL9JLiqDhGO7TjArPnCPCWIyrS4cSLObL6lgn0W59lfMo2n3t1/hG1qFvr+CdyeoYuVhZTon9G4s3Bm7vh2iZsbMHc3XQIa9br2WOOKOOHPiVFNbZDJ2D4e6X5uBKLQHbuN3DR0bX/Uu/nOwu18fODiHCXYEh3Jwi7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzJoH4VJsZGMb1C9e1Mm/SfimQ4rqUcWx8t44TvMAPk=;
 b=JmfBpIwt65sLlwncQNGhXg2E1UTdZSoItncwgz6R/eCz+sN2bLaZGZYpA2GyCOafCkj1tKUldeI5ATZZLBDzPiS/OxUSugDGVRdM9ea3pmzCrgB6ZewLaoP6FeZlDxNzYWAhB4rQY19L843IlFKfiI5SKhviH9iAyzEesSEHnWbqNWhfXFeWrAv05cyxuuY2u5gD6oDxRQByeUtpS0OzTEkYYtB7m03fivEq7ImS3rKIyCazTxpj0ZQkL6S2+U/ekMSkbw3peKdp75YPD+iNVZy1JP3o5W3WYyxN13la8nlAZk7lRiGNhjBIwti53ZQ3LE0dyXG5d01umAOQE8R7qg==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 20:25:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 20:25:38 +0000
Date: Thu, 4 Apr 2024 17:25:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Edward Cree <ecree.xilinx@gmail.com>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240404202536.GN1723999@nvidia.com>
References: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <b8f2f824-e8da-4767-a378-b20bc42d4e8f@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f2f824-e8da-4767-a378-b20bc42d4e8f@lunn.ch>
X-ClientProxiedBy: SA1PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8181:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hbqz3MoTgzcxT48Kxd258WQoXFiq+PU/bzaCrgz8MhphpZ4IkTlrz5gR0kfmW8QKOJhIuu4AW0cZ8BrQmVtbrG7kUlsBf1zOf+9i2LnWcgrc/gmgEyfqC+EFFDAgGOe8fYy3O9Kh52oXj115UXokV/uetPazGx1V4vmMg/xlwfvofoC4EbiTomvwGYZO1azLzlX8QhoF8GatnpWU/8QnTF7Qty4Syiu8qtD/BJBUJkDVxmPkupIYnq+MZwqWzRJxBHuCv4NKVMn2IZuQ55Jq26r2UFRwSKaiHUKGoeRB1mHQLwIyBbQn8ljva9DlWYt11gGgVb3MhwHBdysqxJwFg1/FDaZh/0p2xiepyoBPmi+Nwd6HqeqoG+tVuGeiDdWtLRgSF8XsmIJOtQYtsIEqciWhUHWxok7eYuu/T8bHGbtVYi33be04byLe3/34eESYjK+vETXHGVj7BDwybhiRfwp5HNcGKMkFZ9gGiTYwwZFNkWuGSLk4pTWrMudr8GeD8T2bJvyCSi5A6auzpm8mdcNeKDmzTFiLyZYGG1U7rq9gLv5CiNlKQx0tkP8Xa5hs0tNPD2p2R54n0aR7Bp92DSOjPLCiKhZUc/R2pR2xw86DzhsnziFY4JaEA1u93OnLxZiRZP5DJJqVUE1kWgzW2sLO/MbSjSoTudFVIKrfGLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XMihB1DVFi4oCLgzYtRZCjK1wd8enYy/XvZNvp71Lqcabm8Rz3iCkv98MOPD?=
 =?us-ascii?Q?dAHE01edfm5/o/+bW3epPIbFJ60iO4HhUUddSR0pVnieVlakPNE/7oaNY8ok?=
 =?us-ascii?Q?AtGcNFgN1eVeBH+19upR8vdVByT+l79G/0fxwcq+itQCbrJptvnubzmIXwvq?=
 =?us-ascii?Q?LWBak4fdSQazvHgZMJWWS34mkNfhahaWmC9x/k8NgdTL6HrN+8gz6wp3NDVF?=
 =?us-ascii?Q?LIldNxOL6tl+Zb2UqDPXTrpSjgGT//EML8tcHiVhdwgw/l3W8vk3MydTjAhV?=
 =?us-ascii?Q?dgwFUe9aj+ftxgAGJoE254KVrKa9EELZDsrE0nWYWLk1TftOgNpoz55mxKmB?=
 =?us-ascii?Q?iogtEE6VBAZf9nuv7r8E6XH6KLm83n+Vriga6p2XzFSGliXBAUOD+LcZfq/s?=
 =?us-ascii?Q?UunOLTgQqsUnVKUwMTOY5y5hZE+qSy4GkGD9YGTL9PjZEmhZZuiT51D9xH0H?=
 =?us-ascii?Q?EHz6FDJsncENKJCS48DJ4UN/SvmnozsNLe+6n2Rj/tQRLjVQ3iMyk8L4KgUv?=
 =?us-ascii?Q?rnDYVbKG9MHLxmAXyNRDpIVNBgJd0PLJ2AU/xO1JhQxTOpiqDgpB/0ZsBpuk?=
 =?us-ascii?Q?W9vQ9n5M2Y5TVsXWVrpjJfiO8EqcMuMQ5ucIQi9d3BYgO7Cl4P262s1lRH2N?=
 =?us-ascii?Q?sz3oHFJs8M1AMX8YtoAJtJmqlQpnoGiAi5QunY+ZdA1xsNFUGGzLxGVrb8My?=
 =?us-ascii?Q?pQrXwzSOlvY9R2XV9Wn3Si4p8//JpYbGuVMKw/PBykVfuyJ92Senndb8l3Tn?=
 =?us-ascii?Q?69kybnXBJT+OBb6io/vARvQ6Pt+juAOCa76hqSMQxAoql/N64zrqVnYtaiPT?=
 =?us-ascii?Q?LmSJgOUGJSadAE41wDfA3r99ts5reCiy4uBJxgk8KHGInb1LKTXynXfHYTUX?=
 =?us-ascii?Q?vdWn6p+RyNcSnNCTDx4iMFn31hNooNmX+dVz6Oed+fpCLkVFyCnvEsCJgFtp?=
 =?us-ascii?Q?2YdxJX36KepuUHiFJAZPsVHW0qGFz1XP3iNPxTiJcBs7RmS/mR4AZNB4IxWD?=
 =?us-ascii?Q?T3bQpoqRoY3a8yYT7rOoYd3MeN8YhEveZdre6mE/wYxBj7Yvn9gIxYYmxVja?=
 =?us-ascii?Q?WODOazNmwiK05egcqHlwuKQA+fUqsbApmfXURpTosL+rPj3MdXrLk4QkD36M?=
 =?us-ascii?Q?2WFRX02akcHVYPzLsGnKeh1GuM7YBIw2Zrp93DIy5Y6SvvVuwqSxaT94x2lr?=
 =?us-ascii?Q?3S9KUCRjtpVaFxuLyPGuLXEWlbkNcKeRII5t1vGRQA2FP0QY6gK4exFuvAfX?=
 =?us-ascii?Q?U7UgrYCJlvO//vBvdNtDFpndHkeGnaNUg5LDF16G5ID6FUQEhlfEmtIbqJ5C?=
 =?us-ascii?Q?YU3PQU9jeylvOn5mUXKC84Vu9U7+v2yn+huuyWu1yjCeaIZzLzGufY4yVm6t?=
 =?us-ascii?Q?78hUdCpQl+m/E4+MT05mGIC0k9PLB4c9LntH1BhmHIykU66PPTatLhgb4Zb4?=
 =?us-ascii?Q?iODdMEA27nrogRnIltYqurii6KdXo47GL0t/dS6YPaKMQjYX7zg+B674hCdP?=
 =?us-ascii?Q?15/smVfWzL8CC3TM6LmBb0TVi/1vhXbNsmAAM+sw5vPGX3CWQ786BslNVEtz?=
 =?us-ascii?Q?OUxXI3gJ5FMBYWfn/nYbzYnKXXEoq8GeMboPp2E2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61d2b6a-03dd-4b6c-84ed-08dc54e563d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 20:25:38.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8WDqKU9/8K/uCefqe4VgeXrr2nBe0x/2qsDCdXwTI5OyPVrdex/x24JzztEw3Yw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

On Thu, Apr 04, 2024 at 08:44:56PM +0200, Andrew Lunn wrote:
> > > There are something like 600-800 configurables in mlx5
> 
> I keep seeing that 600-800, and thinking that 2 to the power 600 is a
> very big number, assuming they are simple on/off configurations.
> 
> Does any user actually have the 'optimal' configuration? How can they
> even know?

First, the big number is the union of all configurables on all devices
released over the past 20 years that work with the mlx5
driver. Looking at a single device will see a much smaller number of
configurable.

Second, much of it is not performance tuning. The site has a
functional workload they need to run and configurations need to be
adjusted to match.

For instance there is a bunch that configure the UEFI option
rom. Various devices can PXE boot, iSCSI boot and so on.

There is other stuff to turn on/off functional features which can be
quite often because stuff just needs to be known at FLR time.

I'm sure there are things in a more classical tunable space but it
going to be a more workably small number than 600..

Jason

