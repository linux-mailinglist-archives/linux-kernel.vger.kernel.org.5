Return-Path: <linux-kernel+bounces-128518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BC895BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF2FB27531
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7572315B157;
	Tue,  2 Apr 2024 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FCxzjmOr"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489415AAAA;
	Tue,  2 Apr 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083560; cv=fail; b=RYWVyOXJOzbNYOB9DA523u5hNsbpYysawY3mFJedKVcWcrB4LiQd7LCifL80RicOBl7Lee+agP6fg8tNUSAq1TRsixoIh/IPRwm0ROHHD/ao3HCcuwm/yphPL4aN4qMLwMV/7FqLqbJ3LG4/Gp/MICkeIr16E8w4MTNk/yoaz1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083560; c=relaxed/simple;
	bh=HPIMYNaYxjSTKXJNLl58NGBsUj5vo+wvLFBRgJ5fZZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j8a7l3NjInhst5uObu/VmTyaHDaH5UnmDLkkunGa8hOvEBZ2nG2Euim7yY3AS3dv2z7ads6ZzblpwvSxLKp2vQya0Y6XtKBo2/KqnyC5Y1ggFzOnBXjR8goSfoE3eyToBS2E0d758XEWwxYLB7geIxNiiutgs9RRyDqqjymcxm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FCxzjmOr; arc=fail smtp.client-ip=40.107.244.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKmI4lqFgFh99lSmyoowm/VUYZVFGMSdEereB+LLG+ZDsXWF5/WOrUghmibrs5UFQI7tsmEEGOvUEdXOK+uRsLXhTLy4hDHZHxoVoANnTniHS8VbL01UKQQdodDxOmeypuIUOJ7N7MmpdPd6J4WOwu5kGCKFwaCzZaYnsiaPh59491KmRzr48ZjHz12hz9XoMxqbRbZLVZE9P2fdr43Yk85TuH66kIaWMfZOI5QDeH6Beq2LlfX4sRYMxxXUixNI0Sc5ZRsiY4C+JYpLpXuW+7MJ/snSfjF/VaF8V3e/f/s5mmRhP1MYoQeTmkBBih62mfNDjs2C4YRPPkNhqRR6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhk60GFaOWSdzHRqV6DLr7DJzbZkt7fgcKE3VjjuYt0=;
 b=VSJRzlg223/lOKMR3L3Uv/+Z8zRwNMpqhUX/rrZnT/UpW/8ADSxmPf2WPIkiB0CplvP34SS8AausZiLrZLgtOepVrZKt4AO4qHTtQE/cvfwNEg65+VVJ8iXcqsqUu+H/LhnjwRR4mQgv/P82VLKMU3jsVL0Vvxss0jnAgYnMFkYNKR6HIHNgsB4ZNuRy4qJpdrm0a4PFetmAMJdXsVeyY9G6H9lSnptOVIPJpe7op8k6dwFB6hAzbFRzH1o0zfRr6WPbmPv/SH7fwlZ8oKDPElaHYl/EoW+4fQ+r84yWWYa33RJZx8DQ1nNmXxjgnFQsOaF5+16H6OyaVfC5ts3PQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jhk60GFaOWSdzHRqV6DLr7DJzbZkt7fgcKE3VjjuYt0=;
 b=FCxzjmOrWB2AKFutAFP8//0+4/u9pVsSPQHJV4qZ5iutvU2nNxh7Ljo/v0aPpd2pZPuqfNSNzdfUjGK75D7sxvN44UehSxlid3tELcnrtWe1YlsEdtLylDpQuRzpMosX4ISP+NjWb5um3DsHKKAzT6tctsryMVUCvr4HNqEsyLW2APhfyPoRndt58rIr+rpYEyt+enEf65gvYO4msiPhMCIgJlTfE1lZrtRXuNBFx6LZbWSMOV/wkaAEWINLotz9gSF0nLgEjzsArP0LBoasygkSwH0/opEHk4/bhDIS/OUD/UjsCGmOPNkdul6DCD2+Aux37mM69QADhwTcwtp41Q==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 18:45:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 18:45:55 +0000
Date: Tue, 2 Apr 2024 15:45:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402184554.GQ946323@nvidia.com>
References: <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <20240401123003.GC73174@unreal>
 <20240401075003.70f5cb4b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075003.70f5cb4b@kernel.org>
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB6534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CXQtH/RZmPV/zFOvcpCbPu/D6htLt5agvu88t1UptC+qdn+M4ptGtH5D7xiMow1PAmBDpK9/3SKug8W1U/Hnv9aUGeZQsfNbPd6EPW0eVaL03lAorDt7oav3x2DftRS3dee6pRo8wyxu1fHb1xVU/0U/WP78No208puhjDMK1r1X1MIGbnI16NxV/if69i30yI09HkiM0S8h98O5yJM+xaMafSKmPVh6LiKR3mrHKc3qOC9opvU6g3zfA4hEUjWK+vbcvoco3aCAmj7RvDSEphTns0y/BZxRmrD74Dimji5w+gcxJD7CpfTpmKDtXIwFAKnzZWOI+Q94AsuwSAFF5Dnl13WAO2HVL7ofwdWHvDdyJN/RRAxZypfOFTHjhL0QYCQw4kj0WNw3CNBTqezkK3elH71246HCO1Z/I/QzlLjF1POBEoxU3cWr9YysgJTx74ExZj17QERqZ/SSNKglm973JzeGz3hlyQkVMihxllqOBmx8C7/7VfHjY2nq/iO0KR8+8skL7w3OYqS/DRSlYW3Sk7h/CHloQk61IF0WdtnJksvtKpZrCufcTPcEgYaBJtaCAFgnNfOLBbJ9wk5FvcW7bu5YBafTeh4AcdwWCPrcZ9N8unM7sga9kJv/9itidOmlwKAeTx5aU67TERZOO3wIhvRXArPnEt7Dm/iuJCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kROJ356Qtb9dyQsl4w6uc2g9r67Cwd9AE/6CpsHheifs6afdiMLF695i8gTQ?=
 =?us-ascii?Q?mh2mbcDKPD5Ov/GdkTwVS/m8mmz5rWlXCUSpK3UblJp7E5HvMwkPGHOlZSZe?=
 =?us-ascii?Q?aXrlZBb0Rf3SwkBqgZo8N8jJCMCXVUWyckrsxLBETLYi8/Ho3LcvaHKK83G2?=
 =?us-ascii?Q?2yMTaWT7yqEHaEdMKdcyaHqZ5FbrWvzm/QmIxbqkKLn3gKzBZqXX984pnXdl?=
 =?us-ascii?Q?L0a3tIOrCqMDpICY3zHxEB7SbFOp64Zj6fdg6shum0BLPOcgpsOV+BeM2Quh?=
 =?us-ascii?Q?25DEk36QdoOuR2OanM6pNAHP78q8vqVXFLiH1kT6w4vJHUEK9T5E0qyoer13?=
 =?us-ascii?Q?gJgiqWTqnd9beV6AFf+CYH61K1lyaMVZWASJQgMyi3vdFwwNV3SkyVf+YXfJ?=
 =?us-ascii?Q?yX0H+2745mlUPCLBLE1osKKUS0lXcBs6mpPlyZVtk/EPAYRR46yFvFg/2o+4?=
 =?us-ascii?Q?uwgmSYiRAmiv7RSfMRL7qkyJ1Hdw7HWCyKNsrozcNPonsMZR++lKOwK7mS0k?=
 =?us-ascii?Q?LAtbP6nHpr20EJks9YaobXfESfffMaPTyJ00mM3bUJy8E7h3HENp83U8teSv?=
 =?us-ascii?Q?UJFc4u51H1fW9rYJwMsxyiJXdZugLnd78mmkDiYmfb2TPnKATvp2C12E9CV9?=
 =?us-ascii?Q?3RO6v8aNHs1qL7EDf0rUWoSROXqL1nBmwBYcwY7+zdltRKrMbgOvZtBhKcEu?=
 =?us-ascii?Q?Ptrb3wzGwV2S+4UOJCDr08b0MvS3UqzjgzhHRPRjO5viUsZZy4y20DTZv1QP?=
 =?us-ascii?Q?+TaMXsg9wFgiDdQTU39uNaXLasDTzqqIjjk7ban5KX4lyL3aUfCIRDkjHEZY?=
 =?us-ascii?Q?s75Xocy/GEFghtiTmWhdFW2G2915QW+zq6CMQvg9hHDE6ru/zsCifyyUBo1j?=
 =?us-ascii?Q?DFn0WQQwTNUjD4HZARIb3WADXONP9MSXPKg/DXDlu9CL7k/ot/npD9F9Qq4W?=
 =?us-ascii?Q?3VSo69z7i/tXutW36FdgGiGJO/oO2JMjopdpvEncSVrSWY11isdDCAtXLI9W?=
 =?us-ascii?Q?WRzymgrfJ3HxiPeZzlfEy3IQc9HVEKKjYGwn1y5AQnmIzGi0qk1MlVxqg4Ss?=
 =?us-ascii?Q?NpyzHdB5g887M6alWf+71TGTzFAJ1V7XCPiqocznMn7XEEFzu+r1CX9B9+Ws?=
 =?us-ascii?Q?sbynk/tBNPj5Y/ygIv69l72Dp5uOQJEGiKlBKEyMKfw1WXTwbPE1RXlUKg2e?=
 =?us-ascii?Q?b/ObgdEIf1qpla0VOyioSKW7cbBkHTVSA9PWz1+uWCdHmL/1hp+7pEuHx9SM?=
 =?us-ascii?Q?4lZ5XWRUfO8J8bkTr2tDQwEMhschNAjzpnx+CbgxRIYj2U9KxNJwESCz5xmj?=
 =?us-ascii?Q?IvFNDORKHAnui2ezJZ539qfbTSi0SA+6nPDXXSQPKwAxEU9vj1yrQrsuVuOn?=
 =?us-ascii?Q?UwtBL5A9d+Yaj4Yl6cBpQWdthDkNN35LnvxbAjndRDI/rtAj9NLqEOvr54xk?=
 =?us-ascii?Q?d1/zkovj0x2A843sckqXL2Bnz+z6k7HnzbRCeK9QqVMiICp8nD3WYBVwOl6s?=
 =?us-ascii?Q?oERK2OvQNV4lCyVhFACexwvQjHj2KVgMiCInbjZvSfydnESBN+66bpIb/xH9?=
 =?us-ascii?Q?ye2rt4KpPRxcUnDm0WKytYJdy+gsBHPjrDiNSAat?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f86be2-d626-4be4-7634-08dc53452155
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 18:45:55.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS3MIoEk3mAINBAizXt8m858/8b/B6/hjl0d59Qlk4nbji0zlREohTAXFJn1VQMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

On Mon, Apr 01, 2024 at 07:50:03AM -0700, Jakub Kicinski wrote:
> On Mon, 1 Apr 2024 15:30:03 +0300 Leon Romanovsky wrote:
> > > The proposal is an attempt at a common interface and common tooling to a
> > > degree but independent of any specific subsystem of which many are
> > > supported by the device.
> > > 
> > > Your responses continue to align with the notion that because the device
> > > can spit out ethernet frames, all diagnostics, debugging, configuration,
> > > etc. MUST go through networking APIs.
> > > 
> > > You seem unwilling to acknowledge that devices can work for various use
> > > cases without a netdev driver, and thus aspects of managing that device
> > > should be done outside of a netdev driver.  
> > 
> > HNS driver is a good example of such device. It has nothing to do with
> > netdev and needs common and reliable way to configure FW.
> 
> Sorry, I have a completely different reading of that thread.
> Thanks for bringing it up, tho.
> 
> As I said multiple times I agree that configuring custom parameters
> in RDMA is a necessity. Junxian's approach of putting such code in
> the RDMA driver / subsystem is more than reasonable. Even better,
> it looks like the API is fairly narrowly defined.

Uh, if I understand netdev rules aren't read/write sysfs created from
drivers banned? 

So reasonable for RDMA but unacceptable to netdev? My brain hurts.

FWIW, I've been trying to push RDMA away from driver created sysfs for
a while now. Aside from the API complexity, implementations have
messed up using the sysfs APIs and resulted in some significant
problems :(

Jason

