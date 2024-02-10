Return-Path: <linux-kernel+bounces-60203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DBC850167
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D041F25871
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F43C3C;
	Sat, 10 Feb 2024 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pAbbdrOM"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D801FB3;
	Sat, 10 Feb 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526900; cv=fail; b=Xjr51pxo83iomULsGraF0rp+GY9Te3jHgpAzDKAiilcyzG6svDyb6av4J/6bcyQ19YpgzmiBKod9pcV7mUXo0yBQLVhOBHukEiMOhf0Q0nGECqAdv1OFGEAtfdJhKaiLlFfdwn2FEvmqnlOg5wuNfDywX530D576IFmQPtxpzI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526900; c=relaxed/simple;
	bh=AGdf6c6eDILUkY2UwhfM8Ph38WwfkIsKh26Z2MqWxew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhjO/7MiNiPg29eFla8U7KKtMsVL9mwW7KFHmXAskHrf5YDKXAiJKfqwZpvojNW9hcJlZ4aOUCYBoAn++itbFUvq6U6SACQlqAB0b7QqXzBoImJIVN3SLY2rrfwqODYSP75oUE8ld+pM5InxV+3tUr1sVIBDeevB0sWrSNpi/2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pAbbdrOM; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfayGKpdMOoP3L8O9StsSA21a8ivgiZJyEMfb6+qXO28tHGeXGaGyxjVCzIuutAjdOr98LqT6dEmW+Q69w3cjhS1qzeqy7tx7t29CqL/e0a7FC7o1PWtSDCFyyE9ow4Wdco4VrZ/zcQGzrBTYQnGF0fGhp3KeEs1uQIIcQ3t6FpmPrYJnYAjsIaeEaiYRCHmduzazAEPI/oUaLwh8aAcFfsLea66FizjVvLQxicrIYSeijVJk+AiiitQUiZMLt4AIQrajOJsxiVF+I/aoegd6Tv3yc6YXtKxY/nyLEYWN2o6eiJHkQfZJTfsckC5rn6F6XlZIjYuCHfxBoCSRJ6oUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR4phmj5zCe/+3n2sb48U/A2xwRmaDX6XEew5pkGvng=;
 b=PTqder7PJdaQqfc1CVPS7lEiZj8NZcIjUW9xFPyQTjaQv8aUsHLAGPV8IKk77qmKGC/M0coxAlUXdo7wJOkDFft5vs9HnyAVsLPkOmWgHpn5t0aDYaCq4fzg4KeJAKP1lBKTMcdqcTbHsBU13H1JO2aloMnKuNsdnAfhQsrardh3URIINA+zBMd/mT0fbXh4QYYa4squOzUR19PPoU6FMUPKxXZb5jx0m73Vye7KUOD7WOCrXPHX0mOmeOYMeyPI2KPCXTDM+pZ6lg2i9f552SDYJHuGp3apbMle61MB4ESdOSjEnwChl1axIV5u1mmGdRSjpc3a5UTloPX0jkqQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR4phmj5zCe/+3n2sb48U/A2xwRmaDX6XEew5pkGvng=;
 b=pAbbdrOMvyCeO9RY+lGT2qf8/fK9dNH0LSuZVoc248MXmpOI/DwsDDYUwNk8AgWgJ99qpyX33gNnbb7J7nv/LihMIWQqVJRAWYTE1+nE/5zAF539E8mTSfqHYK9e4UzTabhdZGqnPjT2G0+R6oztvmhaURrFl00nWLhy3/6EaQQ/JMleQPh8OIMdPYXOlmKzuszA0BynR4UkvPqgZd+FPScLiyL8knWXfgs8/p/HFVeq4ajX96OIbEvnrtZQ8O1K5EFaRSV61FEG8YpfbfN8cDKdrmUwVkTV2sJCcMJS6wnGjj7Wfy283hc9QS0ZDTwqTNG2Us6wHS2TNP49sBbTXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Sat, 10 Feb
 2024 01:01:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7270.012; Sat, 10 Feb 2024
 01:01:30 +0000
Date: Fri, 9 Feb 2024 21:01:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240210010129.GA1010957@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org>
 <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
 <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdbb7ec-7c67-4ea6-c1b7-08dc29d3d143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KBpuXsdFNzDBWuqY+uePXpmAitBSRFVpGxKNOr9zXjQ3yJLll9nYzApkuIjoC8Q3wm+R2cZuPPDKKUKJQZAfEZdcoFtfk8W/kp5oTvFTLI0SRjfNNEhzEzS3X46evL31crGiabcW23itJME74KElg7EVoqYQNDb24C5FHPU3vD1k2H7ql7o6gJoEFy8WjZhoS5nUWGi+Nlkygm232r/hwxDUbfGa+nxPh+SWK1T9MVkesDsLtmMTPQDsyEs+805W99RxQqE7Bl1iJku9XUfhVSwH6v7lh0yPdww4fOWa3+AJ2nSDR6WanMIaOACFc4XFDFM6BmzsxMNzF6QHqpGLDzjxYj33NK2ldcpahTvYiJ38AxvbNDlRzUHCMBsjLHOKK7T4IMh90giO7Pw4Hqcr8sw9R3KbmqG3ARfjIB0O8EdyNkhk2Bvqs7DUWk17scSiSIJxPl1S13HsyCvCwOWaUE0iH/32wIhNGh0cykH81YY+I3j8/Ol/sOhGE8M5gWyE22PT18Hj/CquWrIROLlydGSlJVz/xERE9PEsWAgfbhxxszpe2D7WkznG1qyh5w90
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(316002)(33656002)(83380400001)(1076003)(66946007)(66556008)(5660300002)(6512007)(7416002)(66476007)(54906003)(478600001)(6506007)(26005)(41300700001)(53546011)(2616005)(38100700002)(2906002)(6916009)(45080400002)(8936002)(4326008)(86362001)(36756003)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PmM/wDtKF3Cp67L+Y74lkTyGHqfVpyRY0bx5GyI1ezt6F+c0N0H6ZA163Cga?=
 =?us-ascii?Q?NVpD28Gn3GPpZV44vndM8L/bp9tRxSCoi1+Gdw8LKtLYsoPWfUhXWche1oZK?=
 =?us-ascii?Q?e4CdC9F+mKI/tOmArNUIj1of0ETn7YGXJcm7L67pSSrkjxbdKToOTUN7hWax?=
 =?us-ascii?Q?/QlHEkhQMzYmrV0qvrlsjmfnbPnKn6URTvU54VCt2m4YlS6vqEyunp7H9xDH?=
 =?us-ascii?Q?DIkh2tQN7vdzYpKi1Ok4LPGgPH9sJ6tEmU8aGjdG9pHwTkyVPLYfNXBsbCAK?=
 =?us-ascii?Q?sruN0iCne5y2WluVVzlU9c8I2uTxi7npZ9J/FWjQ12u9dJDG/SpRiGQ5sDbR?=
 =?us-ascii?Q?TXeqDqt7paQBJfMKvf4V48qYW9ojGRkcFezQVtBZYh7D/UGP/pn99y4sFCzm?=
 =?us-ascii?Q?fDIBrJ96WXgP857wt2aUwkytStcdEheqXmnTkt2kjklwinXwsoq59CTEltFx?=
 =?us-ascii?Q?mTl7V/RVBi9Gx/IeM+i38PRwbvcibHJuw8tiyCX7ojjHBxmT0NwRKvdMR5zB?=
 =?us-ascii?Q?44lHG0CNUqHqZs9D8Zk6r3rz+VLfCf6Aviv3t3KuJmZk5egSc+CtzE5olK2M?=
 =?us-ascii?Q?C28p5TSErdhFBOzd3ihIlSzPhDkSUfmAFPU7x8QhJuWKgyC8muEjvDlBeR1m?=
 =?us-ascii?Q?AfS6b2YANAIR67KMyH0EYYEkoqy9MUBxS1aW0dkzJNW8v4uxxuTpkBYmXVKb?=
 =?us-ascii?Q?CqpHkY79lXApAFzlnTRf7F3WN4cGy+SyEblEm4KlQBe+hCumt1tPs/tngXWF?=
 =?us-ascii?Q?uz1L2RIqaF+hDLpp096mHT5FZLN4qGnaM2g+7u1gBlzv35Sf0zPN1JJubABg?=
 =?us-ascii?Q?ZjDePrY2ESNuACGYiIAInMcY9V/95qx5cKSy3fxO5DPLy22VGjG+brqJ9v69?=
 =?us-ascii?Q?M4SWUgutIgTRlFOoD2qqNNGyae6KYh7b9oBc3deyRjIh00xctuD3BoAxNfDH?=
 =?us-ascii?Q?LR+oytyZHZvG8iQewPTHmTtO1ZHCjnqKM38ik2KdXZ1W8xK6mXDecmw5zGXq?=
 =?us-ascii?Q?+fikt6QlLtn1xS2BkZ3UoTwUiAgvFqC6uti7ggXN4iUPef5hFkSvdME5wR8W?=
 =?us-ascii?Q?qpEJycwktUn6WkGz2ZAfA5i5O8irZGvkQzAUa2WG3JNnVSw+UEIOTpHftd2n?=
 =?us-ascii?Q?JZ8aqEPT2zBfcvYU1l+iX+HrGM9iOBCZk9Olcr/cpIb1c9VNbMK9AabHwukr?=
 =?us-ascii?Q?5vbmIpsboFCjemapCQ9bxcsQeFz789/sbVvEvLYtAPwt1aANVKG2rd0eMOrf?=
 =?us-ascii?Q?5gEwtFTZPfO3dR2J/5toPUk7zTpxAfq61oVOt0zF71usn93vkD65IomcwMVd?=
 =?us-ascii?Q?9u6lUdksqGvDJoLGc83YnQd1XOcRDsEqFlpmZKNBSF6kI88DnVnKsu8JXEDl?=
 =?us-ascii?Q?tdWDqzfy4FgvRKEzK3YhqK2ZEo7VojiwULpvv884TxciW+sJpH/bDpYMvr94?=
 =?us-ascii?Q?C9if8BkdBLaHDNHnCGgbPWFE9EtV3S8bhqTRM6FlcZNB9cnBDRXdjEk83Jvw?=
 =?us-ascii?Q?G4LyFpiIg+YWugnBRYqXWclcggKYWFyL2hklNB1oqUiiyO0k7SOnW6A2lMmm?=
 =?us-ascii?Q?d0rke40qtPeaDzGy9Ns=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdbb7ec-7c67-4ea6-c1b7-08dc29d3d143
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 01:01:30.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFscXawXMlIKAmRZR5HbbwVPmcso2NTlcby1Ni8iERwDZb2yPg3plzJ6ltkoC/YA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742

On Fri, Feb 09, 2024 at 03:42:16PM -0700, David Ahern wrote:
> On 2/8/24 7:15 PM, Jakub Kicinski wrote:
> >>> Ah yes, the high frequency counters. Something that is definitely
> >>> impossible to implement in a generic way. You were literally in the
> >>> room at netconf when David Ahern described his proposal for this.
> 
> The key point of that proposal is host memory mapped to userspace where
> H/W counters land (either via direct DMA by a H/W push or a
> kthread/timer pulling in updates). That is similar to what is proposed here.

The counter experiment that inspired Saeed to write about it here was
done using mlx5ctl interfaces and some other POC stuff on an RDMA
network monitoring RDMA workloads, inspecting RDMA objects.

So if your proposal also considers how to select RDMA object counters,
control the detailed sampling hardware with RDMA stuff, and works
on a netdev-free InfiniBand network, then it might be interesting.

It was actually interesting research, I hope some information will be
made public.

> BTW, there is already a broadcom driver under drivers/misc that seems to
> have a lot of overlap capability wise to this driver. Perhaps a Broadcom
> person could chime in.

Yeah, there are lots of examples of drivers that use this kind FW API
direct to userspace. It is a common design pattern across the kernel
in many subsystems. At the core it is following the general philosophy
of pushing things to userspace that don't need to be in the kernel. It
is more secure, more hackable and easier to deploy.

It becomes a userspace decision what kind of tooling community will
develop and what the ultimate user experience will be.

> > Why don't you repost it to netdev and see how many acks you get?
> > I'm not the only netdev maintainer.
> 
> I'll go out on that limb and say I would have no problem ACK'ing the
> driver. It's been proven time and time again that these kinds of
> debugging facilities are needed for these kinds of complex,
> multifunction devices.

Agree as well. Ack for RDMA community. This is perfectly consistent
with the subsystem's existing design of directly exposing the device
to userspace. It is essential as we can't piggyback on any "generic"
netdev stuff on InfiniBand HW. Further, I anticipate most of the
mlx5ctl users would actually be running primarily RDMA related
workloads anyhow.

There is not that many people that buy these expensive cards and don't
use them to their full capability. 

Recently at usenix Microsoft shared some details of their production
network in the paper "Empowering Azure Storage with RDMA".

Notably they shared that "Traffic statistics of all Azure public
regions between January 18 and February 16, 2023. Traffic was measured
by collecting switch counters of server-facing ports on all Top of
Rack (ToR) switches. Around 70% of traffic was RDMA."

It is a rare public insight into what is going on in the industry at
large, and why RDMA is a significant and important subsytem.

Jason

