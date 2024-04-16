Return-Path: <linux-kernel+bounces-146675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9138A6918
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BEEB216CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F4812838F;
	Tue, 16 Apr 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hXXx051o"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25D127E32
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264838; cv=fail; b=kTV09zquRPC/mIp6xefnhEO48h0i1pUfe4S4I0ElTqobPqNObdJv5YbbZfMcDkmv9WWiTKWcel/sVZkTDArzynQbexMSKFTpcmT4FabOo0ziQGiLSKP5r2FLj66zzkiAg7J5Jp5J5wjD5hntMiM5svOy4OelFXkhRHTO0gI/2C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264838; c=relaxed/simple;
	bh=6LtNkCA0LjccXURNOfitxHeXzT2bkXI5IlG2HIQmRUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPcsNVsDFTwe01Z9CEyijsNF68v5klNq4SnFb3wfeKwcFH2/rFsOzuOUPi5cZgWEj1kFmn8Z9F2E3oiGigtoCaBs/YQRHoc4tlSHtcrmLbQoFf4FEMAkTdlg8JkfXZC4CLW6fgaRfx13TJ2IGf0txtSZXC521Wf5UD/LTuiBpFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hXXx051o; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtFiKip0zys8A9DysN3eITF+BNmGH3gsRMfs3cEeQn3ooS+7Z6Fm8MXu2/UuQu6E8bPOIm1r2ryj9iZpQsvA8JWecuHxuvXWkOIHQOXUe+ACLqZ/SwpyHBfhw6VSUd7OFrvmvB/A6LVtLelnTgcDNfz/iMk0Tr4fa7eY/etj8VJ8ZTPTkZhHMGocILNTaRxhwTOaJgrA0uTzn3WbYuAyW6B2jL11aKp4Z7PpEMT2EAl98E/aFItCTLkhQfhED6BTJQXoZX4l+H9bT9tuHTzh6Ulm8ZHo2Bl3tHi1U6QHKjl/zxDrwhrTOwpTQq+xw4A5Eof11E5cYehsS1ZGDjDPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oxkKHPdtbTVZGdFFjV4/zDHUh5CFccch9cw2Mty7o0=;
 b=iRQeOSCRbQc9IQtsWD3my2vDM0bgj4qcNoVKgE8MxNet6/jP4pBILkNV2Rx8/v0+FM1vwXwANkw5NFYMsQJ97BMACQRqFY/42zEauEWtFPv/HUVr3/cRUmG+CBHu0Y3CIiUi9/Vv2Bbzi8yNmRKNGEMC0ptIlSuDB+PSwr4kIGowDE/gzCC8yMn6lrJwbYJuV3MOSVsdgpzeT/ZSoVHNGWWk6lIAxQLH4dJqDD0pclwsFaxrvL0fdWxe6cZbbIXi3N5SH80HSlkIfuZeO7AkPcI/ywFUGYSRfhKAKaNwFjUbFTpVGxwLOYGo9Iw1aIaCd/M8jreeiD9QeFLpJzxMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oxkKHPdtbTVZGdFFjV4/zDHUh5CFccch9cw2Mty7o0=;
 b=hXXx051oigP7k7EqMe+ILm0fQvocfXcXBd+h3/q7M3SXQN56EBpRyO7QR/sszpa7uKWmJIqJW8WVkmNmUnH5BeKSTAWVGPR2Zgem/sK4zpDqr92qWc3AfloVKYt4JtHxWk3ozbGiyH3AYWdVNVQzjD5VfN9pZ+5cO+PsKRH6CVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:53:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7409.042; Tue, 16 Apr 2024
 10:53:49 +0000
Message-ID: <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>
Date: Tue, 16 Apr 2024 16:23:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Eric Wagner <ewagner12@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <CAHudX3x-ofB=-K6UwWpf4r7Ge9AQbvLQ2qq2C7N-R5LG2qMz7Q@mail.gmail.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <CAHudX3x-ofB=-K6UwWpf4r7Ge9AQbvLQ2qq2C7N-R5LG2qMz7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c910ebc-50ad-4b31-5baa-08dc5e037f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uV9bGHQecB4MPnajXlEHeDg6EOI4zNv3ARqtDNExxffjdfb9DgF2nu79mEeGHgubLssdGl9CKjsxDI8X5R5oiCSmxMXOmhS2LSw4+bRCE08ZeMDjiezL7Yai+dHl9+P9AF5r/3DdUHkaf80AT2UQT/W+LydbZtHEww5UONCb1WA1Z20nYG9KL1jxILCor5W34q+DgrTL9tmISsYcAjz63LSFCTjpxc/ticFtokoCtLR6KngbesggwQVI47W3x6BzXLoDPrboS+6OhdFREZzqXICRFvfnP1pfc2fkJCMRlBdVFNiKdIJzXIYouuELURgwIyrne6r0nw4HCPxi66Ec+YiWZok7fxvq87MwtTcAGWy70Se+rC+CAp7zsHSAuCpSMeacdAI7Uy+7U9PHKjm9q37nTWOvsUAN7LyXkUJLv5x1Bts8FYZcMRa+xGdFJCTSsyAs1mtlJQGEkEqydI8zs1IghOg3NQGDge+OlewmmPOgt8QskCfeq+bHniKtZjl+4QTY/qjwF+EtckIRHRZq6FYj6f1xRIpGKgSgrMsvVqKfV1xUukVKzBEec/l+QsFgI3o0wEdx8EALCqIdfKvhPMxeBWGngh5ENe9dpO4cCYext6PBsEMFL18sA55X02WMJN1CiayIS3XyyPsE0YUe4scOePnByuvfn6Grljb6K4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTVTMXIvWWk3VkJhRXlxZG9FUUwwZjU2MzFCaDlaSEdSSy9GU1BJWlYzdFRJ?=
 =?utf-8?B?WlB3aXR3NWlndzJ0Rkxsd052aGMxUUEzbS9iSnpwc0lLUlZVazNodHhpQ2Rw?=
 =?utf-8?B?Z2RkUWkreFJ2TmttZkpVZXJRSFNLakNPU25lQ0dPdUlGRWJBWEhVNndGbk1I?=
 =?utf-8?B?ems5Z3V5VXBDUHp5WEdUeUdrZDlpdE94aDRSdWFObjFPVlpMWWR3MkxwcGN3?=
 =?utf-8?B?QU51RGU4SnRiMkt3SWFNTzVBcnladk4rZjBUSXlqTlFPampFb0hzTWtnTmp2?=
 =?utf-8?B?M2VqYTdpZ1RGWDR2Z2FHQWJMTnNJWkVUbTJUeVBzLzU5aGg0ZDRxSjRlamRp?=
 =?utf-8?B?VDVmUmlseDJvekNYNy9KbDRLTTlidzRXRU81SDVNKzEzZkhvUzlCRkhvU3J3?=
 =?utf-8?B?R0l6M2RvRy92Y05FVlhwZkZOQ1lOMGV6K1NQcE54YVZveDVjek1LL1NTb0I5?=
 =?utf-8?B?TEE3Ym56QmJmNWdSU2RiZEJMKzQrRUJDVUMyRHVrU0xiWnoyUGdLb2wyMUtr?=
 =?utf-8?B?eWowMmFjMjdiSjFHcDNBQ3Q3dG1Ic2pFOFo4R3dhcmtRcFB3Y1dkNnYwUUlP?=
 =?utf-8?B?OGoxVEd5Rlo1dWo4RE5mL1NKTTdoV24rNWttOFlIcE1sY1RHajBmTnFYSm9C?=
 =?utf-8?B?SXRuemFsVW5Ed2J1RzJKL2U4ekYvVTVJd0dsZHR0SUo5UWlDUW9UR0FtUmZj?=
 =?utf-8?B?R2JlakRYcmk2N2FpOW1nM0JJUFF5RzlTeWFZY2FQd3VXSmdObzhNdHpQSTY5?=
 =?utf-8?B?VXZObEIwZ1lLQXN1OExEVys2YkQ2bUZKZzYwMFVjYVV0eDIzU3A1L2dpL0hq?=
 =?utf-8?B?bHhyV1hjYW1rNzAvSC9kQ3RIVHh0N0E5TXVNWERFK25oOXg2dUk5TVBTNFpw?=
 =?utf-8?B?c3hmT3hSWjkyWnZpOEhMYUZVTmdVT3c5N1pEM0FUUmkzeVJQNTFKb0pHNTZB?=
 =?utf-8?B?STdiZEpsRHhVRUZsSUN3Mk9hQ2IzRE5xZ0hnRFo4cHZPSlBFalRKbVRjMlo4?=
 =?utf-8?B?Zm4wWHFMVFU3WVRYNkRjVkFrVE1PaCt2b2RqUUJHUmFRQWRySUs4NWd1ZjNa?=
 =?utf-8?B?M3Q1ZnNYT1dIbkIyUXZ1OTlWR1JmN25nN1R0L2s0Q3ZubzM2ellLdUptL2ky?=
 =?utf-8?B?Q0k1VlZoejJmY1hGUjc4cnhMU0xVWCt4Y0xWVmd2R2oxYjJIUjV5d050YWYw?=
 =?utf-8?B?NUU3VUVJN21KTDNBUDNxT1g0YXloVGV4eTVjdUVMMlQ1NXZMS3l0d2lJZ044?=
 =?utf-8?B?Z2RhQjM5VFM2dlcxYktFNXRsY3ZNeCtLdkxCM2NlQWsweGV0OWFMSWxLYUVq?=
 =?utf-8?B?Z2dCbXJvOWh1dHBnbXN1aDBkMnZncVJldHlyR3FVNEpEenY4T2VwanluZDFL?=
 =?utf-8?B?cDVZb2xWaFV6WUFpZWM3dnFNYlFXZVhOQVVMT0lDTDFOdFp4blpaSGlYVCtD?=
 =?utf-8?B?dkxlMU5ua0MzUzBRbkdoaTl1ZzlBRGE2elNBZEV2enYwZ1hJUjhHQndOV21v?=
 =?utf-8?B?MTIvZkdtdFBLUVAyb1JRb1NFZ3NNdjMzdkxSWUl3M3gvL2ZoNThEQmJQRDdv?=
 =?utf-8?B?MlBSR2lmWDBvSFIyZlREZ1VoNjRkbXdqUnRNRkZFK3NFdDA2SmRYcVN2NEtI?=
 =?utf-8?B?Z1VNZmhySU9raFJzV2hMNEdyOUNXdW9tTG1DT2o3eTNkamRsMXV6QmR0eFBL?=
 =?utf-8?B?RDRHdXVlK0p3WGpLYnRTbWRXdGk3ZnlXT0NpMTVpY2Y4T3I0VmF4WGdKazNm?=
 =?utf-8?B?VW9jc2NSbXRaclVuWC9hdUtPRzdETk1mOHRyVXBBVWhsMkYwZVJ1UUVkbnJB?=
 =?utf-8?B?WkVLQkd0cFVxMHJqWEMrYlpPTDkwQWpqQUxFQVdITXFVSjh3cE1iY1J5eTBw?=
 =?utf-8?B?YWkwTFdQQnFRaEhZQjFXNVZQQk5tNXN2NVRmcmdQRVJmZ0JrZGVJRm9GNngx?=
 =?utf-8?B?TkZIVjIvdTI0UGhyZHI0RjgrUm5MWjhiZHdINXpVZXM3RFZPRzEva0xpOGVu?=
 =?utf-8?B?RDNaK1VITEEycEpEZ0wvaHVwMkpmWlpTL3NZNVp5V0orTS90alQrYUR0ditL?=
 =?utf-8?B?d1l4OWRVcGdXUXBQYmEzcUU4NXdNQUNjbmlldkVVRDVoU1NhbC96aDh5L1F5?=
 =?utf-8?Q?7PNdpCIg2RvC/LfG/p0BUcrWD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c910ebc-50ad-4b31-5baa-08dc5e037f42
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:53:49.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7x/rhEDJoO+oKFfPoOmalThOy8DGFACOokLUlQFu2tF8ISB/6a+F3CHi3OGCo2tvbUbS7n7PXktf4CSPHJ0PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

Hi Eric,


On 4/16/2024 7:42 AM, Eric Wagner wrote:
> On Mon, Apr 15, 2024 at 5:44 PM Robin Murphy <robin.murphy@arm.com 
> <mailto:robin.murphy@arm.com>> wrote:
> 
>     As a first step I'd test the quick hack below, but be prepared for things
>     to still break slightly differently.
> 
>     Cheers,
>     Robin.
> 
>     ----->8-----
>     diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>     index 996e79dc582d..063e1eb32fbd 100644
>     --- a/drivers/iommu/iommu.c
>     +++ b/drivers/iommu/iommu.c
>     @@ -1774,7 +1774,7 @@ static int iommu_get_default_domain_type(struct
>     iommu_group *group,
>                                      untrusted,
>                                      "Device is not trusted, but driver is
>     overriding group %u to %s,
>     refusing to probe.\n",
>                                      group->id, iommu_domain_type_str(driver_type));
>     -                       return -1;
>     +                       //return -1;
>                      }
>                      driver_type = IOMMU_DOMAIN_DMA;
>              }
> 
> This worked and got the system booting for me.

Thanks for testing.

IIUC eGPU is behind Thunderbolt  and hence IOMMU treated it as 'untrusted device'.

AMD driver tries to allocate "IDENTITY" domain for GPU devices. 
iommu_get_default_domain_type() return -1 as it expects IOMMU_DOMAIN_DMA for 
untrusted device.

Can you please attach lspci -vvv output? Also /proc/cmdline output.


> 
> On Mon, Apr 15, 2024 at 8:39 PM Jason Gunthorpe <jgg@ziepe.ca 
> <mailto:jgg@ziepe.ca>> wrote:
> 
>     On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
>      > On 2024-04-15 7:57 pm, Eric Wagner wrote:
>      > > Apologies if I made a mistake in the first bisect, I'm new to kernel
>      > > debugging.
>      > >
>      > > I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
>      > > 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were
>     good.
>      > > Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
>      > > as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
>      > > bisect log is attached. It ended up at the same commit as before.
>      > >
>      > > I've also attached a picture of the boot screen that occurs when it hangs.
>      > > 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
>      > > problem.
>      >
>      > Looks like 59ddce4418da483 probably broke things most - prior to that, the
>      > fact that it's behind a Thunderbolt port would have always taken precedence
>      > and forced IOMMU_DOMAIN_DMA regardless of what the driver may have wanted to
>      > saywhereas now we ask the driver first, then complain that it conflicts
>      > with the untrusted status and ultimately don't configure the IOMMU
>      > at all.
> 
>     Yes, if the driver wants to force a domain type it should be
>     forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
>     is incapable of supporting otherwise.


@Jason,

Looks like before commit 59ddce4418da483, core IOMMU layer was enforcing 
'IOMMU_DOMAIN_DMA' for untrusted device. If its trusted device then it was 
letting HW IOMMU driver to pick best domain type.

Did we change that flow? Are we expecting HW IOMMU driver to handler untrusted 
devices as well?

> 
>      > Meanwhile the GPU driver presumably goes on to believe it's using dma-direct
>      > with no IOMMU present, resulting in fireworks when its traffic reaches the
>      > IOMMU. Great :(
> 
>     I wonder where is the missing error handling.. iommu probe failure
>     should not go on to allow driver attach, there is no guarentee any DMA
>     works now that many iommus are booting up in BLOCKED.


Looking into code path, in failure path we cleanup device, not group. May be 
that's causing issue? Not sure where it failed. If I manage to find some system 
I will try to debug further.



> 
>      > However the other notable thing that also happened between 6.6 and 6.7 was
>      > the removal of the AMD iommu_v2 code, so there's some possibility that the
>      > GPU driver still may have only been working before due to that also
> 
>     Most likely it is the above change interacting with this patch when
>     they are both combined in the merge:
> 
>     commit 92e2bd56a5f9fc44313fda802a43a63cc2a9c8f6
>     Author: Vasant Hegde <vasant.hegde@amd.com <mailto:vasant.hegde@amd.com>>
>     Date:   Thu Sep 21 09:21:45 2023 +0000
> 
>          iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
> 
>     @@ -2471,7 +2481,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
>               *    and require remapping.
>               *  - SNP is enabled, because it prohibits DTE[Mode]=0.
>               */
>     -       if (dev_data->iommu_v2 &&
>     +       if (pdev_pasid_supported(dev_data) &&
>                  !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>                  !amd_iommu_snp_en) {
>                      return IOMMU_DOMAIN_IDENTITY;
> 
>     Which, IIRC, was intended to be temporary to work around limitations
>     in the DTE programming logic within the driver. Previously iommu_v2 as
>     a module option that Eric probably doesn't set, I guess.
> 
>     The below will probably make it boot, but Vasant should check what
>     happens if PASID is eventually attached too.
> 
>     diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>     index d35c1b8c8e65ce..f3da6a5b6cb1cb 100644
>     --- a/drivers/iommu/amd/iommu.c
>     +++ b/drivers/iommu/amd/iommu.c
>     @@ -2758,11 +2758,16 @@ static int amd_iommu_def_domain_type(struct device *dev)
>               *    and require remapping.
>               *  - SNP is enabled, because it prohibits DTE[Mode]=0.
>               */
>     -       if (pdev_pasid_supported(dev_data) &&
>     -           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>     -           !amd_iommu_snp_en) {
>     +       if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp_en)
>     +               return IOMMU_DOMAIN_IDENTITY;
>     +
>     +       /*
>     +        * For now driver limitations prevent enabling PASID as a paging domain
>     +        * on the RID together.
>     +        */
>     +       if (dev_is_pci(dev) && !to_pci_dev(dev)->untrusted &&
>     +           pdev_pasid_supported(dev_data))
>                      return IOMMU_DOMAIN_IDENTITY;
>     -       }
> 
>              return 0;
>       }
> 
>     Jason
> 
> 
> As it booted ok with Robin's patch above, these changes to 
> drivers/iommu/amd/iommu.c didn't seem to make a difference for me. I was testing 
> with amd iommu v2 off in the kernel config and I also have TSME enabled in the 
> BIOS if that matters.

TMSE is transparent to OS. So its fine.

-Vasant


