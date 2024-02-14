Return-Path: <linux-kernel+bounces-65816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78A855241
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF98290D80
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE5E13A25E;
	Wed, 14 Feb 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AR+dIK4J"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7721272C4;
	Wed, 14 Feb 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935882; cv=fail; b=J7Ua9ZdifA6nnyti9GIRwa8b0Hm0rskHIXdMa+UWjdOThT1lU1kkc8fR/FlRPMbOTVXQPs4xJewlExT0wIX/hki8JMfUEAlP5MQoQez9JvYtrMgBjfRgqrycMj8dc50s3jPdXYr3ubhGIs3UYC24Ov/mPUlAWV00emTJRlCDk2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935882; c=relaxed/simple;
	bh=0EPXmo0ph7mHSH9T2GIgh9xCRiL8Y+1ze7Eogjdd5zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qNnVZsx5X7Gt3nmHwo+i/DsP51xq/FYOvrf7QhHqQ1peqNaKL7VC24phKyCfgb9SyojQGfthSyjP79aS6VinnrzqoeS4KXuyqpQL9SfSd5kbUxbEeFvQQT7fIYb++bornK2YBx5s0uqxP+Rx0E2pu6T9+sbKQpDpFGVsZ/OpNaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AR+dIK4J; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxPVgwavpDvlfAYyoxeEzFxKav0/wBmQiL3Kkow9wpgGHFzBiWJqSdDC/BcpvN7z7djaEy3OAB2uJTgCNaMVbjsl917ZyXwljwH6lOArKvzkDV3dZB3ZC6x2cNyLJVmxegfzoviRzDkyPVmpEypTbZHADGLeJEkth6FCX8YO+SX6lIUPbB6o3tGvTpaI1oQmzcZV9daU1OAYNLsgD96jaCK5jgAd4dCqkwT0XheV1AvPRDDzk3m8myVVx/KyrcJ2z5symUois4JheS6taoXaYQSc1j+TThXC8rrDmy7XAee18NilHSkVWxASY+HW50GNvxG5TAfZWNimGdyH3EPCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BQl+OMFf9sznWcaCQmxRDvy74/i4iXpG3jSgEoNhkE=;
 b=brQ/61AaDTwqsV/xDfY7Q1Xe9CRJ9k7P340mNv/gKWmBsM9Ss6lXgHRrNN8LxTybf7gcORJeFLvTx5GKS/QwBJhyqpfJANfrak6hfFfv0+gNrHKSj+YUw/s2f4+MOD6IUaXFqzt5EFVlbqPPiENEBnNa5Dwb7YpaFVNa3ip5AyjHdAZjgpMcxhbbSZ/JmJIyWsc44L8XitJZitKlwzPU7LPIrhOjVlGPHhFgk7z0Ny6KEe3ZdF9C0aUKQgAtwWr3t8c5HWNburDrlbt6zcWt8i+BIkBEZFB9hyAkizH2NQEktgVwQqcjkbc0N2zd/IrQLDn2JsPq4bk0Xq94obVk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BQl+OMFf9sznWcaCQmxRDvy74/i4iXpG3jSgEoNhkE=;
 b=AR+dIK4J6m9TdscbysNoNDyYJVJh2Ze/8T8K83/ASEMm+kTREiAmHQktur7f6zXPX9LbCPmXaJZsAdxaw1Dj4amR8ImmCUeROcfjDqMZUixgJqCXTYid2X7K47A8vI5ABKh8MKSykKE8LqDx5mmWItMQbtkwgOIlZSqb616/nu31EKdaO09W/ttVJaduuxq1RRVTFr4F/ymhKn23PU8hyULXNNHHOSn3rQlo3cNLHpYv9VtLyeszbC1uypf7kkBUkO9MRV2N0ZhFW+gElFEdXgnrcQ2iSiZKieDNU0NPKQ6VB3LEvreKDNsQHIKUKU3uryVyEIsvaclOYLcQkz96rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 18:37:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 18:37:56 +0000
Date: Wed, 14 Feb 2024 14:37:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240214183755.GH1088888@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240214101126.0c3681ee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214101126.0c3681ee@kernel.org>
X-ClientProxiedBy: BLAPR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:208:32f::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ec4bb9-63c9-449c-e2f2-08dc2d8c0fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HQpqbPYV7uoA4g44LhHrdK+zxsiA+5lPAepe4e46mKH4UHiDhKI9nxLfBVZGdWVk/dV8ncViyOcQpPIc/L+NIamj1t6Hz8QxIk6eftzKOlPH8oyNXuYL7qr2wcKMT/fbrT1O0fvoGhUcCRIW5/eR4kCMdNqU0wmvUPqDK64zs2ogVd44nM8rzx2WffYkE49GhjXowuUFI57pjLz9Kfw7TsZ4XBuTLZoNs33TgE7sr3PrkJ8ht2+MzS2NOQz+WjpW4v9X0X3O04LJiYsODaXs3jY56ksteuWr1yhOzgZBn02e4pOiGsoINjH2RMcVqi5KljAZYHGQ9XQWo1Ioqt25p/dhBYq3Zcg0GdPY5HphcYegd6DYqSdOE6LSuR76+5SpQ2kqXlTCJrQPkOJZiWbImpPfa3JQ2Dpj75VmqaugmxEUSZUfJI2i/OkKPloanIRxXNyIcjuhuA6qCLQlrN8Yfl2Adf0iuDcEI8oICmyais2FPiqNGqkCnQIdW1GPFdx56hLgl+LFYwzVj7tG7uxOu8IPne7wyyCnQstN2GTbK83BIBfxz0MOcQdpY+T8t/sA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(4326008)(66556008)(8936002)(8676002)(7416002)(5660300002)(6916009)(83380400001)(2616005)(1076003)(26005)(38100700002)(33656002)(36756003)(86362001)(66946007)(66476007)(54906003)(316002)(6506007)(6512007)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YbvtAa8r6pZQ8IoYVn9GsmKlTps31wcBGtUeR/KUgwD4U0oWjwpwWAtjKT8K?=
 =?us-ascii?Q?QkPK2G/az32FtCuUSS+zIDmL51Kq36EVagEEdc6jkMOp/G5jczeo9KuhLM+0?=
 =?us-ascii?Q?Mtdotpcd5Vdsh/J1KDtRjnfBBRy/Ujr5Zc4oLxvGLYx1YwarQ3A0Majuxzn4?=
 =?us-ascii?Q?Uo++Pvknm1GLaKCTeB7Z2/4rTEUCLNdawBitjRk2wl2Iiy637Ar0jxvUUUE+?=
 =?us-ascii?Q?muK71Hnav3ASjgPld93A3NicoO97lIjOGmUmlGED37ZYnIe2qGx6AEzob9xP?=
 =?us-ascii?Q?2bpLwj1rv81uW1JFi932MuutiBJWtheAoxtL8ul6NpeO9unRNZmicdxv5Fdo?=
 =?us-ascii?Q?ociBsRrNKG54iBTgHo3uEEVmGl2VJki13AMQFQXirgK65+Aq3ihpJt/Gu+1Q?=
 =?us-ascii?Q?O7YzGQxAXD0UprjJ9OYYnoDPESdhP+Xo4YQygJ0ANEfqhfnd/+n77KafO20G?=
 =?us-ascii?Q?D6rY9AqnGSv0U3dzt3tH1cq7xzgj+vmtm9AXaGvhQNLQobmgQ1XcXtP1/Y0m?=
 =?us-ascii?Q?RElUDAn1A+j/fRtlFKh1+Ucj9FlEcyzOEkoP/OB6+wZ5aFWTk2lskX6lxK8L?=
 =?us-ascii?Q?KnsQR4msILkISbMdFGgs2uOo5POy89uZXNqa1p54Wufc+Nd2ELX+KrjslQoO?=
 =?us-ascii?Q?1JL17uVJI43uWz+Sd+JQ8wIbPBVRp7XBQZ7607O/r5VP8Zx+Ut6wsRk8TwWW?=
 =?us-ascii?Q?/aR62wYH4mVzPXPLWrc61MWdVhvKWFxz0iw0mMhUtuojAZRgvEo9JU7v1vJp?=
 =?us-ascii?Q?IYrxu1KywPoSjXKyRrACHq6edva4zyRI1JYTBtxsfVLMd8ACJ+RqhBVGcApy?=
 =?us-ascii?Q?U6LNUYwOnY7zECLcoAB6cl7SsYObPmQxH60NHWgl+mDhJV3MxBBC1y9aTm1Z?=
 =?us-ascii?Q?I9f4Mb0bkgvG38Y8SJ/JigcSY5ywYWKP+ns62q0eFArb+oBoKGXX0Wy24G46?=
 =?us-ascii?Q?FH0Jygyyk/q13FPs/jwtsDKenrX5RTMq34nLw48iMOy98JuByjf5VwDX0Wyq?=
 =?us-ascii?Q?7k+B+Dz88DBFXAN8mw6U64gYAR5Bo7gHSlgirk2RmTwN90AB9Qsi6aRt5mjc?=
 =?us-ascii?Q?IdZBShV2EYoJcvnyPGuFFsbbadmg+R0WS8GbLPb9eiXAsTRD7LotEjvKHiJc?=
 =?us-ascii?Q?qyiwgfCV13M4OT+xFZblAGocWiLfcFTXPhm9NXSFRwLfmvmPLqg5G6f0cR0v?=
 =?us-ascii?Q?PlnxqxODDrMAqbuXYnlV7e/VLNXCsrolYcE2FVVKss3uBq40yMpfHuZUSmFW?=
 =?us-ascii?Q?pTFvn9r9C8jqHMlthwW9ptjTLHcMAqxIOzSqJMwadeM/kc1/TBhpM0IKh3aH?=
 =?us-ascii?Q?aq+1Hz050M58n5PiMzL6OlHYLFeP8GNjkaxGoAwfEyPuMarKVgQMiRiDkRDo?=
 =?us-ascii?Q?xlIrsib8XuGmt92DyYi9RZKHF5xwcr7V2tR2bdmdyWf/9nwOZrIaQoFynokk?=
 =?us-ascii?Q?d3wwRl/5vJ+CpJh/YeL1dkqPV1TEe69hsYUfb0VHSd5iiAOmWxCdIc6YwF54?=
 =?us-ascii?Q?NqSxntorJKTkjuw/TVIL+DLpVFNuR7Q7Mi0bNX2IZF8ndjx3+SomSK8MeESA?=
 =?us-ascii?Q?cTtfLB6U53G7OdjekyQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec4bb9-63c9-449c-e2f2-08dc2d8c0fb4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:37:56.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJZe2pJ7ugtqxcByhcJTcGlrE4Jix/hOFt1XgCv0IDTA9WDqReFupj8dTJJrkfvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

On Wed, Feb 14, 2024 at 10:11:26AM -0800, Jakub Kicinski wrote:
> On Wed, 14 Feb 2024 13:57:35 -0400 Jason Gunthorpe wrote:
> > There is a clear split in my mind between:
> >  - inspection debugging
> >  - invasive mutating debugging
> >  - configuration
> 
> Yes there's a clear split, and how are you going to enforce it on 
> an opaque interface? Put an "evil" bit in the common header?

The interface is opaque through a subsystem, it doesn't mean it is
completely opaque to every driver layer in the kernel. There is still a
HW specific kernel driver that delivers the FW command to the actual
HW.

In the mlx5 model the kernel driver stamps the command with "uid"
which is effectively a security scope label. This cannot be avoided by
userspace and is fundamental to why mlx5ctl is secure in a lockdown
kernel.

For example mlx5's FW interface has the concept of security scopes. We
have several defined today:
 - Kernel
 - Userspace rdma
 - Userspace rdma with CAP_NET_RAW
 - Userspace rdma with CAP_SYS_RAWIO

So we trivally add three more for the scopes I listed above. The
mlx5ctl driver as posted already introduced a new scope, for example.

Userspace will ask the kernel for an appropriate security scope after
opening the char-device. If userspace asks for invasive then you get a
taint. Issuing an invasive command without a kernel applied invasive
security label will be rejected by the FW.

We trust the kernel to apply the security label for the origin of the
command. We trust the the device FW to implement security scopes,
because these are RDMA devices and all of RDMA and all of SRIOV
virtualization are totally broken if the device FW cannot be trusted
to maintain security separation between scopes.

Jason

