Return-Path: <linux-kernel+bounces-87047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C810986CEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D028B97C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C83134410;
	Thu, 29 Feb 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JAjabIoc"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174B7A154;
	Thu, 29 Feb 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222352; cv=fail; b=RTOY6dA6PmPEGfX+9Mg8SVmI4/ZQhGRvL3LVjHUkZBzJKsGapVnr1wX+pq9l2epvrCQlW8P8A+7tKwXw6a1U6hjKXSwTftuZ11bckRpWbeEXa8EPdO8bBWe+sN0nYLkuEGeFjmULpV+0x/71lDERsWGj0EfR9UKF4t3waXTaPQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222352; c=relaxed/simple;
	bh=2aI58htm/wzmgto1zC3nAKWxhbBnwdvEE2qV+K3m6TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HqbdrPNMxlP2VkXC7WXMEF9TjI/H8UWKXDQR18yP9vlA2ihgYHBqd5+z+IJY5wRF6QECL5e752q8HfGmg5xh5Yp9FDd9Z5zw/H0vmNIQalKmFzob3AkpXomlULffQSf8EdoiGcpnDfSM7JmbdGACpHSWck3gPJK5Te/9hkbXcZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JAjabIoc; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZeP/E2z5VP3Xh00Rr1FxpugHJ6hr3y3swfaHYXmj2JebGQEG5Jfx+Ecyr/W5QJoelfXqjc15LPLoZbadSg6cC2clhldlRm8EvWA7xEuq4uS2ot/7sUu5LFO647cqCtGsuyJxiKKnsHQLO/YHoGOKgI7MAghDPq9eNOOKaVivOCS/ms+DqmPltQDssyw9Im8KHhBIv6W6UxuMyIQ7s5tFFQBAq3oPzttRBcTrEN1UWzGom0yhG1TqnI1CqvYoWqUqi4UE65Vh7LKsIE+dh8E2WX3gW3HHas6+DTHDCUa0PXtfEukwBQ7I4t5WWNw3Ii4J60H1OQufNUlsnzIvk9s4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1SzbiqgQ8envCdajNnj+pP+4ns6KZCzFXb+bcQGBWI=;
 b=cNYm7gOEDLxok0zn6x9ksaOzWMCUtloQiPOytsmV0FVpQj9Pn43E3JkrOH+QI+KkSDJA+25zmm+qdukpezNRAtdSVrDwBcl9smRVjgRCPATwA8GstS1E876y81VbIlvR3l/JDH2UWq8SrK5SEcfFAvJwcGQvn5pHU9HQLUqnjbOZLsDTrz4B7+WFiE1McajAjChVzwooya/A0s7x9u+qho+Jz4EybkzrAM1tl3eQY7qECq16rA8qeWA22oa0Ntom2/hKOgihO75TPIE1W6Bnkn6CzL24DFXx17cXF7B15BTCbwpqqPoPx9xDzXErMh50lFBYHtahuATmCT02T1chTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1SzbiqgQ8envCdajNnj+pP+4ns6KZCzFXb+bcQGBWI=;
 b=JAjabIoc9kYfofjoEbiyhUoVRU3Lw+tUagL/6wHhv98+/fS2HCufzLhBegjmNWRpVGoaJaPdCwNuVg+EP0xuIW0226BarSfWAtpu+9j7ZyWm6ZVH0kPbY+ZahG1FOqYfSzV5KG+rvYc3WDa3SEK9R8Yxy/q0EXAOVavGPjoY422or5Ckz/Wtj0f2Bb/3QdTzfXVGZQGlPFO5+nCwmqSJugZJSo4kKCBKOq1a88FuOFTmUtPvQRJa+HZnBwiebH/9sAFKR/L3gqCr4nzxR6E5wXL5zpUVu8TCTeg0V1Mwo8p23guoy4SFFI2JbF+cL+PKWCL+eOSg5ROJk/S45PdvEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 15:59:07 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 15:59:07 +0000
Date: Thu, 29 Feb 2024 11:59:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH rc 0/3] iommufd: Fix three bugs found by Syzkaller
Message-ID: <20240229155906.GI9179@nvidia.com>
References: <cover.1708636627.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708636627.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8758b848-4570-4b41-38e2-08dc393f5c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8O7aPevBrzW2dVQM2HGpWJ1Yje+3zZC/uF/ek0jQ6JxZC+5sW2M8vPGIUKJTaF7sm4OTE0s6l72BKkvGN5yude6v8HatpE+Waf1e0ltK4ttVBgqsKZlyEmJPPDWytHrh6LhhHKdYOr5buqcM7P5TZdAgLc9YL0lzFltHiVzzKGiKL8onrX3hvkI9jt7ZSlsEzQuI+4xmEWB/0LvFd2ES8isRRqwmA3aYOA9fs0/Kd777R8CbxTHibiBcRVqrIaG9XxGVJYANVOJEbHBlj8X+Fx5jcZoJO8BgOcGvlEqeo5VT2S97YlWQjOMlp99zf0ixrkU0AL4fD8IFSwOdwQQu9HIGWsEk2pZcbTTbrJgFuX54V7TRfxJ6dCTlUpfCSfJjULBYpilbhZml3cxREDCMpce4lD5TbnNCbI/Ft+i5E75YtClZuHN0zGAWjZ04cx7GB1N8b/RE+c+3oO4hdu+k/d+jxPpH9A0t2sgl03GBlfHcgL1RZ7CEdD9kVeHkIIYcqKTTBRyk++b0EjqA+PInUDLo7XCJviPSsBwPRmiwl8CvJhUEKoJO9/llhT8TosFWvPbxcNWgqyG7UOiMdqy+riPpajeehH2JXzScbRSaUL8h8jQbg+dVa1aXoz5s2/io+fbSHNOfMpB+b5Y0rbI07g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9F2g2RwimkCTnJGTDKdh6AmkkAuWke5dZfYV/LIrkdG6k++8dypK+s1bX22?=
 =?us-ascii?Q?8aTfOqcSCfCgeL1uN0XwtTp3wre39P+jTjhPQaFcp5iiXZKZHSA7pO59CF70?=
 =?us-ascii?Q?FYkVchl+fmvuaqzp2DvLhxwpn8i3HRmThKlkBt1lTwUuzHpiY1Vmpa3h81Rv?=
 =?us-ascii?Q?cIdRxGVfwc0C5Po3/QwwXPFjvAiyvFZIOtzrH0TY3SsR1kqcw0UOYb7MG66k?=
 =?us-ascii?Q?8RIT3m4+b5n77sJ2EdNNHcN28ars81G0q/ezqAhMZlNp7wonn225iFHiujQO?=
 =?us-ascii?Q?qlytA0YPP1hnU9pyQPvgYapQIx4KNI7xFOTyfvxjx2nxjcIQy2zjzaN+J0yI?=
 =?us-ascii?Q?GmbXSnZ0iBkM3JZrWeEZBcHIYQKrB4F/GxpI00HNQODILcxlAJ0q/OvDbbPp?=
 =?us-ascii?Q?n8HnpGaCgddsB3s7ZkhuqnrZ6OEABNZ1nBi4rWOF+RZhwjwCzWMK6tVvPz5R?=
 =?us-ascii?Q?Gz2Ue8s4fBOowXlrAi8AR+OgadjAHTWmsIQIX46t6XrE9hbQRtMupltDSks3?=
 =?us-ascii?Q?spY/JIwuro6pzJqVwEFJIEGNrhTxiSjmPHIBit4phPqHiRcQmq9MVZsH1DfY?=
 =?us-ascii?Q?DD5KPn8kFSshvE/XZ/4HCrt2TbfYr/sHxIi+XGFC94VCvPh2jPKkp0mVqJOt?=
 =?us-ascii?Q?dDRxnB5RWOR0uNhlkr81mJcBxnHqQ9k7sI43qeqQdrXtRb4DEmWRg6Ioc4JT?=
 =?us-ascii?Q?oNlDxYx2LpT6jPB+Vr/gRHHRa0G3pMMP0YdJheIwTRD5wQPDlXMlAQjWLkph?=
 =?us-ascii?Q?Azq2H3RL1mzIyRCl8DDuGqGUsfUNEzReH7hjyRfK+rOnJrPMRyK0Y5jJKRNI?=
 =?us-ascii?Q?CyZ0uaU/ux06w3yw6oo+I0MINTcca6Kq1TEY5bO+XZxIT6cEluktgRXGiktS?=
 =?us-ascii?Q?/2++CTWnlG/dlPD/mpJU6gMrqMyqeSAa1sxFDxOjuqd0RrlhlW6400pxr1aM?=
 =?us-ascii?Q?ylRd6eO6jFW39JSCAM1JR7qP5SrH/IpSQvYB8OPMc5bSrO7jEkeP2isVMZL5?=
 =?us-ascii?Q?8S5TVZ6/K2fx9XtuT/tZlSEAjuf6rPhshQJot6iOV5PzV4jBtIJeWthPuKDw?=
 =?us-ascii?Q?upAbWtPSr7Dddka3GLkLSAOkBTkLMuTRN6Ir295b+jhLd78Hh83SMG2zPrBF?=
 =?us-ascii?Q?Tyl60xQgChtFf9wHyxQ54FuFSDvhtqXYOH2FTYE/VZKWWTEcObwdH7u0mj3L?=
 =?us-ascii?Q?Suu59oY1GiZlzAWOi1+0B+LqQ3+G26pkDh81XqWjuWwqMnYTwY16yxAq7qfT?=
 =?us-ascii?Q?G/7r3BPJco8addRnCq59Wf1vDkbolxiYgbTy6N31kPOoyR7vhAMKvCQLd7bR?=
 =?us-ascii?Q?4f1IG6YM/l+0aV7ZwqJCfR47/u+ACAIOVJUugMDN7HY6PBP8U3S42YUdTe/E?=
 =?us-ascii?Q?n+yMxhACeMYDTffRwCxHmAJZPpoGl90Yvm7XMnJ27kuw6oT03LtUPBBLyGw9?=
 =?us-ascii?Q?hZcpAzy64lWM9A2UU0aoZi9z06IxOoR/p3KVWEbEJssL/9a2XcCGvcz7dEGr?=
 =?us-ascii?Q?1DWFW850+AkobI8TFEHeuLvbQzGGytgKV7kBEeK1YJgf/PMQ4LjVI3rrOS8j?=
 =?us-ascii?Q?A1yWRZkIXwqqiugE3qyI3DP0jsLOOAtVaZeCNDtc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8758b848-4570-4b41-38e2-08dc393f5c3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:59:07.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUFQTkXrZLFU78iPMtXQ2yiMgQvQEfF5s5wO2tDevpa+KgHmqY1bdXtnRrhV739p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

On Thu, Feb 22, 2024 at 01:23:44PM -0800, Nicolin Chen wrote:
> Jason has been running Syzkaller that found three bugs.
> 
> Fix them properly.
> 
> Nicolin Chen (3):
>   iommufd: Fix iopt_access_list_id overwrite bug
>   iommufd/selftest: Fix mock_dev_num bug
>   iommufd: Fix protection fault in iommufd_test_syz_conv_iova
> 
>  drivers/iommu/iommufd/io_pagetable.c |  9 ++++---
>  drivers/iommu/iommufd/selftest.c     | 40 +++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 13 deletions(-)

Applied to for-rc

Thanks,
Jason 

