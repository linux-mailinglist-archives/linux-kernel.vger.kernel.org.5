Return-Path: <linux-kernel+bounces-145645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632E8A58E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF27FB23699
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6491482C63;
	Mon, 15 Apr 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyJMx3a1"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E0823CE;
	Mon, 15 Apr 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201272; cv=fail; b=DwvUQn9upJx3ARBFhgWgo4ZV5cvEcZtgJT9KQt+1Cvx3JF/c/s9bY3huy6igYdWlTpqd2zlCPddAl0w4XnbxCI53SeLCdCfd6enuLhFgod2nz3isYoGl/L50yGTY/jwLlXck35oRXCZE6+tDp/0sEDq20e0BKRy6z1JIP01dwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201272; c=relaxed/simple;
	bh=panOP/c8StZ5Pa6o//LHz50S2TiUTLc+3FECFyq89ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JEkPP2jd2wQuPVeBqsCz9yZWWQHDIn3LcotCufjFn3neq3GPOBRpgcvvF1SuWcnryTEunolZqDiliZr5s0Ej5KmZZKnb+2zZhj0eRzCy0IRjqFcKoWOxj0k2XhEhwgHYdlBJhTtBs5VzyzZx/ymvNttOQn/5wcQ8JRTzJAcPQtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyJMx3a1; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDuKhB6SVH/xGhUSR8ouszyv4xvzqyipJ8LVsWqrCnuak25EUhsN9Hxb//RSNQO4VNp+49jcIkrEwsC0yhzm+Da5RF1IxLMPRZoJudXLwgRUyb5a7ZMlS7JL8jBrN939f4ua+9f5x7DIyCrQnYXg7zo0cpFkDHvSbUrgb1WMACX8+Gsv8Yn3yfbQ/bpA5GKRnkgkui0Tiniiw20jJf8XM7wAw6Np5q0RKluYRgPy+k0MexOxnYDz5W6aeNQEOt6wX4jEs2DjBdvgwfqhLuax5Rtig+ROIf94iVDXsbK/KCjVp5Zc1v0mTtPUAX/ULejK/9d3nUFb6MU5SWnrKQ4hPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=panOP/c8StZ5Pa6o//LHz50S2TiUTLc+3FECFyq89ms=;
 b=X61522Gubl4hmAcZwHxxK7WxY+cV81J9g8Xmge4QzThpj/MQtESNqtK6RaNvX08DrhejqYuviclYWrF5N2eE5lRFnedb9D33mHVQzAQV4Cad3H8A/2u14L6p2osEBu28fOoTIzK4J7T5lxKA/qH+ZS7lH803zkf5SeUWrOtatDm6KrKNd2dgPX2kJ7McynWmVVL6W58TrEwZuT0e0lrlHphLmj5wmA0ee6uBJQvMrORwuUPbeavcj8pwpgoIh6DVFokDjHp5qPfofu9Z8g3chJ/8yDmV6C4t85pLyqKDDZfAZ9zJOtUv3H6bT50FsTk4SrNT/7AtRa71r6BCfWjj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=panOP/c8StZ5Pa6o//LHz50S2TiUTLc+3FECFyq89ms=;
 b=eyJMx3a1vUKB0I6BF4Z7sRFrVa9qCxjNWqErBHZcvOtfZyaTvPyg7RMSBXRg8i1tyhCInNVljasy4hiYDKJhfE11RzKoTB+nAkYArxX4+Qf1tit7qLwptXQ9YinKtgDTEAwmSQ0DXimBHjewD2v9ZdweqHTLEQoyt+WacgpMYMSNGxlYGeNX++pNmhXa3p/jrnXFxZVhBRhQ6k7L0YmP7GopPmUaWPJIW/9upPNsSpMbzFsuwkqeTJ4Ge4fZAoJT5zxbKoLgD4Mfmf2zQ1J3NSnCqzqdLOdPJiSCk7jrh+gadAAcAyvlNMUvYROmo8zooMgdaN8QRFwBK38GrXiS+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 17:14:28 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 17:14:28 +0000
Date: Mon, 15 Apr 2024 14:14:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Message-ID: <20240415171426.GF3637727@nvidia.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712977210.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: e31cb13b-f4e3-4a68-8efc-08dc5d6f81a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EsFv28XUqCclw+ht7BmOEzXejJKecmnGHoKm+0zZe788Bi2ELTP5f6sbV5hLO1NvHcwsQw/Rd5vYdeMEjV1mYcze6OzYEKa5EAFEgLp/7x+NbMYQdecWelOgtGzL8+pD337f+ulSsrHmk7MkSVnn9NcmhPMi+YASKIDMsD1GKRt3g4Kivp8wv3GFo/hhlfJYw8ZMdQlvtrDbx+jSxjm0VbIgC0rbjKyGON2epDLqwVqdMA0A/rBwMHEExGnryQkXxFMSQpDas4EgFYWRf4LV120T7RQUPPksA08Qkyrr4UlyS8NO2Y7UiJr6qmzkaeEyJsRw8rNf+c5YJiR2HecUml2S/IjFC2ZXQSYhZ4hqU3sQKwQhmquT/fP/fpSaVsOUnCuXXcEiC0uPazZV20HXaMU5HItkAIKnwVB73BRDAKEZsN/P2H0L6vvaQk/TDIJngm7EAMxx0IzEhauFOq4swMC+4QhWp3J1SvAYigTNVybvQA5nduZnsMaRaEjtNRxioHJjpqKaPTRc9LiVGk2VDr6LPT/y87wmKtLAEXGMAGARt7qUv7N+WZN8UV5w6ykOWCJd9XzM8KIvO5lP1pKiDY+sR2c4zH+kPGG+cBL0TZNqKFL8kx6eZU1HDog7B+/hpvO5WHdkJrHnuP13O3KSV7YpVo2SnzWc9O5ji3U23E8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcFApMRcqOkhAEhw82sTjBj7eKvU9hqvpT48282g2ZzfJ8G0kjGi3RqcpjhM?=
 =?us-ascii?Q?TJAoCLbyzU8OwdmZcY37fQEKreqk7zsFB1AaHo8eQHy0DenwO4EknvoXbxL3?=
 =?us-ascii?Q?ySzakUIrjYahijGTDvcNrMRhZ/M7o7xWOIRNQb+KjYY1K+mBF9x4UHjWGh0A?=
 =?us-ascii?Q?QERSBmVNLC2V+5ZoQTSG8UFMbvJLjjl3Os3iYTISsJOyUQlvzhUnishbNoDm?=
 =?us-ascii?Q?ZaU5XsAXnCbHq0LXMWonjLxryQI8+enzNxbwdGDSGhlVv+6kvQ/YaGuet3Tj?=
 =?us-ascii?Q?QnL59x3CLvTzkoRbyYCq97Ra1Fmfw+WkGgBclENulVXT6EH8SczBIJdRTRgD?=
 =?us-ascii?Q?Uq8YlIXWIwCMbPFD3iAiAZhLUzWkuIfuMWsxtEP4Fp7TsTS0SrFnCLjbV16k?=
 =?us-ascii?Q?LDddwzZ3ep7hIny8y1pHipDCqhYxlZ1xYpokjFfbHgdJq6SKkuiNRbVwoGEA?=
 =?us-ascii?Q?hhK9ST5zDB2qXRnJw1CPa5cnMDfrgyb+K35Rpw7jIRRebrcXS7MKIUyRTlPO?=
 =?us-ascii?Q?dVC11MmGchYVGj85ZvGXfbuE+vnhHCLtYYcD6MzpzrICp/21CpOOh65pWeHu?=
 =?us-ascii?Q?PZ3eBP2jVx46sI1szMc/+1JBwCvaQY7yqvJvphq7TrOa1l8J7U5wt1YEG6Vq?=
 =?us-ascii?Q?UxXZS/UIt5Udj32UBRh40BoZMQD2Emx9UV2jq9B6RmrI5u/ovMntaihqAfiv?=
 =?us-ascii?Q?kQ/cgUSd0h2LxJ95U7bp3C5EMlavigR8GweFINbQoAE9fNQ1s5TjN7/WEMmr?=
 =?us-ascii?Q?XxHXZvJMbGXIzFsHRvLW2UFpjgk+eWae/lqdXbhjwhb6Z3DpVWv7yddypLol?=
 =?us-ascii?Q?l4FgselvWeflTf5zV0XgVsog3wKCi5Qlk9d+jVKoqLTGo1sGDYUKeqFAiOKH?=
 =?us-ascii?Q?zz2k8ytcqWnbnYky30p8AjINIuwCIxWPh5wSap0PAHf+JKSbWR+am6XIANI5?=
 =?us-ascii?Q?FbTlM6WhkKkXqYsBdYTw1J1T/dUi2H66tZhB3zUuEV8RLIp1BYqf6flHLM17?=
 =?us-ascii?Q?xA7qty2kHqZBK50oAE2qGj/MS6bTA28LMciSaMEwdbTWFRX4TiCnXGgim5Uh?=
 =?us-ascii?Q?kbdBxA2mBqLE7Hy+MYJ7kH0oBio+X9P8hU5zKZAtYGFtmynYXFMonFPK7Vbl?=
 =?us-ascii?Q?WGcX5brVsiSvhKykYXvBAyXVrStQ/tee6HjuaCqslLFrjPeJDJIKBPVUOvXD?=
 =?us-ascii?Q?I9czwYG90jEGRnrnjW/ItE/3fICPHcQ+oUK/Onh6qNssZZ+753bLDlgpaw7h?=
 =?us-ascii?Q?/BUhOFvvEN1yi2pJ1b/zC0sznMA5bQjNSNf/zPPK7Os2Q6bs7FXlP8pkU01S?=
 =?us-ascii?Q?BGhc85D9CzouHQQMOG4JyIU0nkAse/Mw6IExGk8Wn6TsqCiWrD5qKIIHGpUU?=
 =?us-ascii?Q?8W+YUGzmNe3uav5u7VpgdH004i7wHVu+80Z6fQc8sRbi8/T5qI1wx51mjJmm?=
 =?us-ascii?Q?ezxeoMx05MxmKB4z8zaF5+OYlfT/3OrHVu8NCsxuYqGYWyVzcMCzw3e4/umg?=
 =?us-ascii?Q?fPautV/cvtrnekBXGx+3TgbJ8dEGlEQGA12uckfadTW0ErZExzZP3tqacnix?=
 =?us-ascii?Q?JSXssXiQtHMEYsH9ToVYdZ01ENsxzvbRIgXOIRFy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31cb13b-f4e3-4a68-8efc-08dc5d6f81a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 17:14:27.9693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chKNvLKGsBDuMA9qON+/U26gVzxs7scSpLdGAR4sBDWQUJzLWXvOxW0MXsmAf8RF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

On Fri, Apr 12, 2024 at 08:43:48PM -0700, Nicolin Chen wrote:

> The user-space support is to provide uAPIs (via IOMMUFD) for hypervisors
> in user space to passthrough VCMDQs to VMs, allowing these VMs to access
> the VCMDQs directly without trappings, i.e. no VM Exits. This gives huge
> performance improvements: 70% to 90% reductions of TLB invalidation time
> were measured by various DMA unmap tests running in a guest OS, compared
> to a nested SMMU CMDQ (with trappings).

So everyone is on the same page, this is the primary point of this
series. The huge speed up of in-VM performance is necessary for the
workloads this chip is expected to be running. This series is unique
from all the rest because it runs inside a VM, often in the from of a
distro release.

It doesn't need the other series or it's own part 2 as it entirely
stands alone on bare metal hardware or on top of commercial VM cloud
instances runing who-knows-what in their hypervisors.

The other parts are substantially about enabling qemu and the open
ecosystem to have fully functional vSMMU3 virtualization.

Jason

