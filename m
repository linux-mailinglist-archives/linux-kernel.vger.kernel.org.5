Return-Path: <linux-kernel+bounces-131409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A376898748
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F27028A31E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FC128368;
	Thu,  4 Apr 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0eGDnu7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2094.outbound.protection.outlook.com [40.107.102.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12285644;
	Thu,  4 Apr 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233426; cv=fail; b=EqHxme1pi+VrCfG4PIES9orCp9svL1BeMYIEmo8cDOD2du+XGjC8fAF0pJky1oNddRtTLyeWExP/DD0EoIMUZWU0ArLIlVOpGR81L3cFGQf3CN8qTr5F6Zu1+BRfVPOoRhZ38eejNoBfTRzDXkjLJo2HV9TptNfr3uzEuEPmDK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233426; c=relaxed/simple;
	bh=DLbsWXOsejH8v9ZDEPodOCjodgxmcbMsE8qMv9QGH5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OYQi2P0jEZDqbAGmUBuXod1NuaxOSm+FOG0PKq8RCij2IKSH7WWHEAD630M6CmIpoYySF3mGkpBt2oy8qsfNVE5eGRde3HO2qp8lsOK8/S/LkRxNzHqdKK+Y2F9UDaX2b0ci2vP9zVGTqOmJbL27jFLCPBkQnBu3zblQ3XldfxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0eGDnu7; arc=fail smtp.client-ip=40.107.102.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7cEozgPaTNQMZuHpC19U5PXEFxiZOzfN4UgOk/WQoSujEEqA/qMNKISnF0CG8hCznkZRTSrRvTyxPHL3D+yA4Iv06uAHALaMPqvqlf3PNMf6KQBIZ5mLZthC4Zv+lEzsoik+ygTMGIVVYS1TNfs8tJemzizgH8kvq2/lEhjn3xYBv0EGHT18m6rkMQXi4x1l4d4JOadjZCBCtcyK+bFwpLiid0C1LRZ+bZ7OAoVfu5W2pHeaz/UnrHOH9WIex5R1wYl5gVNcyqOLWfx9J1ll9Mrlt8MsNd96xafT/a2prstBzoQRmk0KKVZtxv4msDLr1ZfWBBl7loEXWCqE3coDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q+vE9PYQY6ZVpfpCgPaQWRPDcqEs7Dd8ilrCh0VmeM=;
 b=TB6eJmKU8dVHHsH96rd3uiZmqvfH5OZI8DrlqAZNhnjg5cVokmvCO+DB/UEDd7iEXjFLRBFhxl5wksMSMZdK+SMj5/s2KOFHbJG1KJGqEESdKdkIx2FVvQphLfxLvUUPaQM2A6u8RqvShI0ktsqn+/AALLZKCO9hiZLPVm3H6PVSl8wB3TXV0O93q6ox8jG8fCrXflivQ6hFyc74xsqJ3/UAOH4gkeeZ1l+sokIY1SjYvT1wLS12IfrczMnX5UINg+AC/duXq6NxKZbxXc12p6XCfrv/+CKUftdGJtYixsY6SeEQAYJCKcvclnGj6Ku/dcSgG5xk36sPGq1X1N85FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q+vE9PYQY6ZVpfpCgPaQWRPDcqEs7Dd8ilrCh0VmeM=;
 b=j0eGDnu7gF5Wq8hu2tyegGPrcxsHsOUdcYsOI4dxdTyluBkRtQ6B2RsJinKI2MFHO8J4mvG8vUrrhXksL8YEfi0Y72WASzvlVRCatCQzm+lYGx6OkYU/USzVvoBCaFl57AkR5W/JwgAVxrgHcy13Alxy7DtY/CXkLwgST57FHjreTc54jKu42cVgGER857Gs6RcJov8QeLZgqMTfHQWRLYA+PMB2/H0oTvauF2cDZt4O4mt6n8ecqWKfnmtEDMd8qxGxv39vPRC1/CLbxo9LDCsiMEPtLZu5lJUcryAokN73eqvfPxUbyHMJk9ZvZwNbwCN7xraLNcVqZBe6lzCH0w==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:23:40 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:23:40 +0000
Date: Thu, 4 Apr 2024 09:23:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240404122338.GI1723999@nvidia.com>
References: <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403170149.7d2b8f2b@kernel.org>
X-ClientProxiedBy: SA0PR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:806:d2::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB7687:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p2FeZf/rvFZoicezdQuGm9fpK8eC9VPWWxvV9BXDYopB1yBgowBF4g61SJm/tqxe3go3pl2z3kpPznd+fm5T/IR66fx85maYpIWziW9tymhJ0jFXDwUxdjDV8WQYuuic9/m7WtPFuaVqHk/4qHJKkUbXOJs+yHeBTBAIvbLKtIkDx498YsIVq96u+6GuccpkyfzuDntNV954KVGZG7DdI4HxYBOkdBsB8HrQr7OJ6qpEi+tP6zxz2/p0u+N9jfmfGGE3kCl1HOTh7NH+fmofRD8gDorCIQKVA72Z1rP29kWvUVO7AIL7dczdF1VZpYLbtKMjtx7bZvcbSzyEwD/Dd+sBpTb12l+ZBQpwc/WG0e1Ta0ETGxzKm8kzsxdqJ/Da8nsA8vWanfXMFTvGmeQ1QjSz9xQYK55pOHUta346t0vMqZsFaax0lWOpj8yh953tihl7A1UI0VZfjOCH/RVk+yKSVYwIUyKbE+NU2QVt88FpEo3mJbDW5NaEfbzM3a+2JmlhZXCNYZmVaaYjAeZzDkYNJiO7dGovG1maKNBf5zrfgh+Ob1tZ+7DmXEX0hsw3NECvFk50GpNV1hNJrmgSDRpoUGz/1eCK1Ls+pufGqWKL3tGeMePFOc4LaXMPMPQqYEkJfF6GWvsfLyDcMknkKVw10rCHjPnt1jrrag3y1rY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpH93K2uLfGrJevM5/NK60IzO+6p51LrFbq4FS4fux3x6CbcmP/STQns7slG?=
 =?us-ascii?Q?0vBY79C/0iyrDmU+/aqVoFaEbfBSwbKd86i6ScrjxIa0iQZXbD3jOajfv8Zo?=
 =?us-ascii?Q?lFdEGfI9tQRWWlBlUUDMr5dXmP/X+OvdA8iHJxl3siYBy+lOfxUyD5B2k4c+?=
 =?us-ascii?Q?/4r9F4eTVGFwvcIgbRGAr0VK2l1w/ywxLmPreLoxf2kZYK/oJK4Zkv8N/7Qf?=
 =?us-ascii?Q?0eueD0195GfH7fXcpaH3Tl4M/m93/DN9n3HhiDqwD1NJZcV8z8GQ+aoPdRFe?=
 =?us-ascii?Q?ml1guXleYwOUdSE9yiWBw7cLiWCIfvDqPFdCW658h+mjwtQxDXM9SiWC1HO2?=
 =?us-ascii?Q?ieBjdwkJS/+ZeNPZLOtjHCuKjUYXkc1wMAaaQh85rh/i9i8lYgn0rSrvHHCx?=
 =?us-ascii?Q?krg4XDS2jiC/1MD9eyMEBlp8tQdHYt4XUEOdfJmYW5WJbswyd8KCkyfZA5yP?=
 =?us-ascii?Q?ch6nne8ycNaSjyft47YMcTq9mTkdOx3UeeNKja90xtKkMPjQQ7jFcGf5hwMX?=
 =?us-ascii?Q?peM1d9v/UYp0lKn44kEFqgfGPn6FWyQBuX9HW1v/gqle7JYckdUBmR7k/CV0?=
 =?us-ascii?Q?6JLAoDpg9ROfnslu8HWjBw6YDhy8LydMzTbcPr1Jvcl8VKrE1sffnA4JGwqO?=
 =?us-ascii?Q?+3+Xv30xqH4g0dLXOWuBmL2msNMnDyD3p2hITmFSndlCgfQ4V4hsA1AHAqZw?=
 =?us-ascii?Q?lynjcALkELF4CpOkrzuBZN5pJO1vYbLSg2kmpjDK+NHIG/urhkzYP/ITdrHv?=
 =?us-ascii?Q?9YYMq5NfAwyy1InSFUiDsr5J7whn8B41unXUm06YEZJTMqto8+NVD+1k8iRs?=
 =?us-ascii?Q?pI2+Ac8luZIHVNBxQHxwJe3GkOpEV4MzSCSBIVsD0HL3lJyqdbQ3vti2fY6f?=
 =?us-ascii?Q?vBqHF8d45UC/MxwlFFAHAaMsI/JqUC+HY0Gnvv2QE6yH0keoS0u+Aj/YR8IC?=
 =?us-ascii?Q?qW0WhC2mhFHpXYKGDN1E68rXDxt5RPNA8GPqTey87cEtboxtS6rGu2BlezG2?=
 =?us-ascii?Q?HgWDfNiK/OhJw8NHye/KgU+lvYImx3qAIAOsfAUTCpe8ZL7xsrnAT33oVDFd?=
 =?us-ascii?Q?PN/1DpjTug6gueEdtGWSrQ1Pr4okPg39yEbMC3pwNGZJkMEaBUXmBNfBZ2Er?=
 =?us-ascii?Q?nmQo+oNwKhzdssSWfasnetH/UXIdL7FEuiixIQp3xzBWLhO49zX8OPn96xAL?=
 =?us-ascii?Q?notSnsn0NCrDK1oqNSS9As/PdHXtlPn0nHpm2mxeKhh6aH5NdpzAzVURPKgk?=
 =?us-ascii?Q?koJ7v2AWNDsyoLpxzazcTydEEWNkZsMb7yVOIdls492OYi4HlfmJr+5jv2Cd?=
 =?us-ascii?Q?gVsfLHjOEwp/6DPASRPGUmfX4TExo31zb5NWgpLCgOY7lzdi/PegE+CLLLN3?=
 =?us-ascii?Q?ZhGeRg7x6925Vh4dXGH/J1FuUEClflzSBFBsiTsIJgta1PdKHbixqeFsl2cb?=
 =?us-ascii?Q?WoVK3xxEqF8C+xBnVFjTlDvczbSrfH1N8Ukmwh5TZo4V1vrVQ+pq9an5sr9Y?=
 =?us-ascii?Q?ErsoVMAgs5vFeJVY6VK75x6B5l4ge/6iCEi2Wr+v6+N/iJFJB5n1H7c8AjO5?=
 =?us-ascii?Q?3NE4kEoSFIz0oENLaGFSeP9zdrtRy3bIsVkZaqRB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad1cf2a-7bc0-4e61-28f6-08dc54a20f3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:23:40.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80cUz4bNZTDRKPStev+48adXPFoQdEVx/bxEY9f33IChzy03HuiYjxXg7fZ7ULTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On Wed, Apr 03, 2024 at 05:01:49PM -0700, Jakub Kicinski wrote:
> On Wed, 3 Apr 2024 13:31:46 -0600 David Ahern wrote:
> > > ... Patches aren't languishing for want of reviewer resources; it's just that it
> > >  takes *submitter* time and effort to bring them up to the quality level
> > >  that's required, and occasionally the vendor has to (shock! horror!)
> > >  tell the world what one of their magic knobs actually *does*. ...
> > > 
> > > ^^^^ Content
> > > This paragraph alone shows that you completely didn't understand the
> > > discussion here.
> > 
> > +1
> 
> "didn't understand the discussion" is an ironic thing for you to +1,
> David. After all my emails about HNS3 RDMA you somehow concluded today
> that I want to make rules for the entire kernel:
> https://lore.kernel.org/all/6faa47b0-27c3-47f9-94be-1ec671d9543c@kernel.org/

What if (hypothetically) I tould you that the congestion control
settings in the device FW impacted netdev sourced ethernet trafic as
well? Would you be so sanguine that RDMA should have those settings?

> And I second what Ed said. I have asked multiple vendors preaching
> impossibilism in this thread to start posting those knobs. I offered
> to do a quick off-list review of the list of knobs they have to give 
> a quick yay / nay, so they don't waste time implementing things that
> would get nacked. None of the vendors bothered taking me up on that
> offer.

As far as configuration/provisioning goes, it is really all or
nothing.

If a specific site can configure only 90% of the stuff required
because you will NAK the missing 10% it then it is still not usable
and is a wasted effort for everyone.

You have never shown that there is a path to 100% with your approach
to devlink. In fact I believe you've said flat out that 100% is not
achievable. Right here you illustrate the fundamental problem again:
there are configurables that already exist in the device that you will
NAK for devlink.

This is fundamentally why no one is taking you up on these generous
offers to pre-NAK device's designs. You made it explicit that you will
will NAK something and then it is not 100%.

Saeed has said repeatedly he wants 100% of the endless configurables
in mlx5. You have the manual and know what they are, tell him how to
get to 100% in a few months of work and I will believe you that it is
not impossible.

Then we only have fwctl's support for debugging and other topics to
argue about :P

Jason

