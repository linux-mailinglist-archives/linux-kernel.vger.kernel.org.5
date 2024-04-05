Return-Path: <linux-kernel+bounces-132872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C884A899B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4075D1F23572
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E251916C423;
	Fri,  5 Apr 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j8WQOId5"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2105.outbound.protection.outlook.com [40.107.223.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08FF14F9D3;
	Fri,  5 Apr 2024 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314867; cv=fail; b=tzZYxhLhp/TpMD2/H/1t2knSnfxJHSx8Uav4Jnu0kabPRHB289+0Stc2XWlttXGCQLcOd8mFZr/aASrONlYufmS6CztiGrRT3pIpAKOKRL6zRPCBSdRveuLePgA6CdNXROkUBq6g0qX7ueHf9Z1mduhnaVcxXf38ddoXayi4BDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314867; c=relaxed/simple;
	bh=tYm5nfBuirI52SKwDM1T9VTde34tC84754rYA8rMTJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GvhKZxW/D3395IN8SyaghJGGIzH5rt31Ovy2MfFaGi49y1N73uhstHT30co1Wn+Tg1xkM3zhY0Nc/0JEDGRn3J1ezBBbGiKCChd7HEbNzKr6cWAbP+/4aDesr+RNG9Lef89yn1oc39wqNdscPHxIHD6a/sH2QVFdSfHeU+cOlbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j8WQOId5; arc=fail smtp.client-ip=40.107.223.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0547+APvMWh91FhmANWu4jBS7m9Esmq5i48IwUl2vvKBk5bl9g2dsxtu635mVA6UA3nq6hnP/i/zASohzcbFAcyaDgZD0oETHapuWPnlI1WhJiFPozoAVDkMGEewRRnNzRdY+9Zp36q/fYw3Fb2LpsI6ymbYz4oKLHUve2y4Zfn9HPzVYdT71tJaJCjmUXmcykn1jETO9mNRYRXr7+ih+FITJmI8myEbYPvBrj/f5NQRnd0AIhCBSSgo3k9QHAcAGck/vdiB8AREdHkZBwsox382vHkOvvXeGYWoWyb0S62RCA2cr6LacBN6PZ3/orNCAlZTgskm3Gcpl3agiOHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpdbH0RcN/z19qt39hF45h8w2aTHabcRh0LtK9mgnu8=;
 b=MzMWOO9jjINjyicDBcmmwCnXMeDsy6iqp+wYRecapzEHuVum9e62k5KYUkE8WpR8ax6L+BpRy0rJPb/9vA3py1RdFRT7puS0DrD5jhmGNV9MuUeQsep3yYK+AbOwfYeMVCSISrDCEOL6frM6bSRk7crv5/xdmoqKmL6OO8Up/eGFFAlB+gfp6knwY3S+RH9NHI58Ce/JP+7gA+gcczIdg3NuurxvMOIRdB+MH3ZHLxeSwZzzX8/e2LCD0sw4ON7T9Lu43s6xav72hTVkZ+UWEldqmqrjmEckD90wLqigquE0VtTDXkGf6T2a4J3mxLz58+95sHDBU+L0iupTXVe09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpdbH0RcN/z19qt39hF45h8w2aTHabcRh0LtK9mgnu8=;
 b=j8WQOId5J7jM9dr+ipvu105JEsnL5RinMjHo4noxt4KuhoCKsZWw6vTTAHayhpqTWEf6jTqlkFCqEwoI02GTb8INkL+mGM0FCJ7IpUOKfySKzVj1tgEeShABVm17B2fusVBT+1/z1bqKlNga9jIaYmbFOjZIbeUa1uZgPWag13VDFkLsYq5cDg8jzZys74bCiaDRh8xSaBizeKJDO7SiOYon26IJiSI0koJsBsgofNzjmKenhMKJlYwqFFfKIFEOt6kp2To7Na+qzw0/WQDLj4R0w4pvqThULad3ahGd7PhJVgWpDNdbHFylLWVX/JFZS/2LLsd2Z2gcGLHctXG+Mw==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 11:01:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 11:00:59 +0000
Date: Fri, 5 Apr 2024 08:00:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@kernel.org>,
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
Message-ID: <20240405110058.GA5383@nvidia.com>
References: <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <b8f2f824-e8da-4767-a378-b20bc42d4e8f@lunn.ch>
 <20240404202536.GN1723999@nvidia.com>
 <f1110157-868e-3e2f-6593-6a219ac5e96b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1110157-868e-3e2f-6593-6a219ac5e96b@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0036.prod.exchangelabs.com
 (2603:10b6:207:18::49) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6609:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UN9TwjCIiHj5EFR55Czdg7nNSzf6pgB98PGD/D3wqe/SbL+hqxqMJipHr1BPgWopcI/3unqDlLcwPUnDM/+aRLPYbPxNw/GZWwa3F+p6aTg3f1dPE+1zkUglwz/4o+2JHIvhzb9y5fUXKAIkHtUtZEnBKHVPTK48gIEvwddNuF9l2uvyElDIXAf8YBecndFFmb88JiZ+TkcyxQUFzuz/bm3w6tDrutZnIxWSimm8cfHFX7TWtFyiJS+pY7k0Jb2+GnlFeiKWg68FMWqNxrE9uZfZqchq9veNWZRlNtLu8SuYSc4BXrTBnNaCfdg0G8UTLESRfiimi1fzzYGm4bDCGdq5+YD8meRh6/vVrFS23g2jd3ki0/lDyDh7XLaFrxJ83OhKDFBLK15rXmEQwf2+0OImzBRwKxZ2AUMtn+oTC8HUFWVE3zFK/xU0J8LxWANQ7+UmzaZ6nRjTcZmTThxtn+m/FaeKXTCV5jEJWNNAVBYwfZSQWs0yAKEPC/tfnwQwy+UrxvrZKgvn6rWprRwkkSX4qdw8sEaVm4aDPl3hLLw4Z38bsD30eBCYS3sc4YkzVb3kOj2rj/EzzoAGGfyTsbzup+naObm1ZmvUZSwxQizjX3wf4Spb5+mkfjPJrRAzakV1op5YN+MiUu12R4TZ7zx9C5KmhUfEp/WBv+YyNsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j4XhjDgSdeI/eZBjmh2LYvZv4ml3Lplj9t+Z/OYStOmHNTag6VYxAEICVjLj?=
 =?us-ascii?Q?Wudrh3VPgLm5B6QghshYtb/BhfnPxAGpFalDXb7/QsIHXMXktzPLj0oRUBed?=
 =?us-ascii?Q?b5KwDcJlyuP7KgxKUyqcOEe/k6kha+8HUZ5JQoL4zgb7egycxmUE2B0okQ2W?=
 =?us-ascii?Q?nY25lCbm3e3aNb3FXcFUk2FASqs8vZNdh3PDzW0bWJCAwsJ2dBGqI7EYGDYI?=
 =?us-ascii?Q?oRXvo4uiREwwZbajsK+UI2d/pXmQ670fiTkEpek/gYEZc3E57Vb3mV1zO2o5?=
 =?us-ascii?Q?6De4l0n+nqPL+0fsFhIwIRxlYSAAlvnPbNerZN+erLrZxMmPQMHt4FoF9hB1?=
 =?us-ascii?Q?VL1bnIrXGe7vKUemuXDU8PndWYP7rz32n2LiUwNWWcqpK/MO82VMPvVibDN+?=
 =?us-ascii?Q?DDijyzry6SN3KEI6OS6geCgEeWXEvsksX989y2rXivjXMd2KsAw8fFabUrMu?=
 =?us-ascii?Q?NRbz67TnLa8T3ELght7AR2lUt6QwglhcrO0d13zdhNt1p2fYHCRfry+1dUxN?=
 =?us-ascii?Q?k1/N41V5zV/Qv9uIMnIQnt6sMg6oYdlxEB5tw/j2H/wysGxTIr/HAUHtioou?=
 =?us-ascii?Q?OppVHKu6hb7uT6e6jwvRM3dD1R6EqtdwsABbaooOgn4GoxbHnLT/ngUSDNKw?=
 =?us-ascii?Q?xIQKYn6iJF0jhA91CfHhJ4H2bKw93xSMs6lfNaIsE0X6EgQQc5GIbeUHf8jL?=
 =?us-ascii?Q?N6roHCiwrRG9FsCTq1lbtcjNkkLexjX961fWfBSn8jOIrZrftlqEwNAbMkOh?=
 =?us-ascii?Q?eMVB5Ql5gqsfetkvu7MeJkhI6Yav1As4TfD4KyFdHcY00zpCUVOB0YNfgC/0?=
 =?us-ascii?Q?pqU0m0D21Hur36MRYzHesK2sm9jthoS4se7VM5BvOGJFflcBT79HOz6GRgRR?=
 =?us-ascii?Q?YzRzRKs2rHvjNjN30qswOlWjHOYeVBJBPOLp3QJEl0QCj7ETsx7JxAzC+vRW?=
 =?us-ascii?Q?AgVvELzBb5DJORDi+Lg/3xngsJPP7Fxcmsc0UEfe8QCkfuC+gyZUkzepOoMC?=
 =?us-ascii?Q?1mQm9NXiCcVFfTaSBm7o/JXR0yGjBuqO0o7dUfiSryjsRxYFJcO+p8oy/LkA?=
 =?us-ascii?Q?hi6/XS4oKdQoklNSJJJdP59UfebtpzG6t8Xdskua6PXRgb2Py0Q/efhqcqS1?=
 =?us-ascii?Q?XzWSvxEGJZXKunGM2cHL0wFxjGWRK2sIBdPZ6Fvojj97KR5uCiaZg5cb6Ah/?=
 =?us-ascii?Q?nTTtSNQm3dtwjoTcmxmfAS25CrPO/x67f3RFHg9EBIEMs+5Yog3v5Z7DIrgu?=
 =?us-ascii?Q?JuKoTS9Ntbt1DyGIdcBNPvdU0r0L29woQtOTFpynpDXB69NFPyqvwqUgPpb0?=
 =?us-ascii?Q?l+Dv5XoB/4oEfW7ukNeHD/qCnAkQGOcXrBRG1RT0DK20EQPWKbOvkD/ZPtec?=
 =?us-ascii?Q?9DfBCXW7buiRjPLHOwzzBKTnkyvrOwKJE8Zi25LPYb51vdn1LtmFCmBAw/EA?=
 =?us-ascii?Q?BIbuWQkVIeFz4JaehVXUsrhRTdu9yJC6bYeIYGzs3k/Ob2BA9qsIxJwBjcW7?=
 =?us-ascii?Q?BOb/94mLb0RekDs1/SPKgyl8bCzcZSl9NSs9aAnuuuX7842qsR6oPQMQewYz?=
 =?us-ascii?Q?Bf7m45Puq8W449f0JwbVj5QmfR+2JJhUprikCkn/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b563c84e-a327-4a7e-2f50-08dc555fad3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 11:00:59.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG6uS0XRhpAVEUKex+2b9NAmElUFDFDJq5htsaWBcW34HI9K3pgyn8IhqTSXC3tB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609

On Thu, Apr 04, 2024 at 09:53:14PM +0100, Edward Cree wrote:
> On 04/04/2024 21:25, Jason Gunthorpe wrote:
> > For instance there is a bunch that configure the UEFI option
> > rom. Various devices can PXE boot, iSCSI boot and so on.
> 
> Sounds like a perfect example of something that should have a
>  standardised cross-vendor configuration mechanism, rather than
>  every vendor having its own special tool as is sadly the case
>  today.

Sure, I imagine exploring this kind of commonality in userspace with a
fwctl based tool. The kernel is the wrong layer to do it.

Jason

