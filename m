Return-Path: <linux-kernel+bounces-149994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D08A98DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD41C21BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742C15E80C;
	Thu, 18 Apr 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jxhfzS9B"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD015E5DA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440716; cv=fail; b=YdiL8vKz8QTENUYaKbBhR4uwckEqmPRD9DJDIyiOgconFHNs8cKWznbaPqFmIeK17XzHSgmw4EssaX9AOZFTYLOSpd935TWx0J/+7zZoHmj1vMKU5ZgJkfzlXbOLxBDOyiIsS6B/6ftIe9HlczZL6f2gM92Ak3pyZ4rJhQhZzL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440716; c=relaxed/simple;
	bh=nOivyiAZhlE4MeecCm2BbeHrPVWOcaIAJUttMek8tLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YC71y8O6om2IUEcYAsr98VKpbMpAWOg7YS3uyBHTU6P/vpcVVQ9r4OsKktXebr2v80uBoHhV1VWPm4+tcxjKhoesZTyq6BtyrhFJtrWJoUOFL8sf4Vq6+Uf9zgoASzZB0mVEzxjHpNVIc1Jv5CnJ5OJ4StTxxVZntqJVS80nydo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jxhfzS9B; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbGBhJADjIW3G88H89KwUJA6hxKbMJ4eEFHt4ABWpI+6Etyf0IYgmlE9xAZiposLs+AN1+rNfOdggh2Cjh1o7C5b7OLUDwORscOzHyOyCPZQuAZ5PWbf3p3Gtcn0U2tYgUuDegJuSKK+RElXpyszYEfcgDaBWh1EaX7yRtHi1xPYht39O9p17Nm60LKFDBOno5nd+T363fdHb4e9vHvH0veL9nYtJhJaO7Mov5Klbv+7gCiBhm+ySJOmpDOTmJL690EON1r/fCA0SY/Yv6b17olizCGTKZcLfGNda9YNqy0bi5PRjYgCko4pI55bke+I7m1k/vMlnzLpJnDOPjRqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmJn8EbHgcQ07yziwZYq6QfQoLt9NeMLTDQAZVznOPw=;
 b=hNuis19YYWRokcncQ//xlDldfla4WbbDl8ZGJgE74NzHY+VJi8NIdMpeiMWcUoSjVlK8wtQ5LX1cbR+NbLiO4gNINpRDUNnFrSjJiMTfmEiHb/i3EHI+RX8AUMxWNBW/ZL8kT8wrDksLyhWYFiaeavnd3tPWCA+sWvK45yWIL+s6wgQfyCC+sGeOX/OHvRblqiyaVubo+C3RJeSQWei0659Eh8bYXg49NSaOt05q7OO+jlJNWegP3bLpCkYY9IabCVGAWJyA/CUV5y+WzvBFenOr/DKszOosbbqRxpN/XyeoBgG2J8xNgGyyUdUK71A+amWlZ9Nxbf0dkfqaUBLozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmJn8EbHgcQ07yziwZYq6QfQoLt9NeMLTDQAZVznOPw=;
 b=jxhfzS9BeZs8w66sQXtFi0N4vHweLV6prRqpojyR1awxBh1Qdtgt/iUreQpwmDjdU6+KhW65Dsgztjos0apJgHnKShNo+0SNErmsYM1KIJbO88KE6f3oF8qLbkgnMb5+9PI5LO9QsW5IryHyHmlqOA1Hzw7ojWCEG/bS6daQGEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Thu, 18 Apr 2024 11:45:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 11:45:11 +0000
Message-ID: <b014b871-1be0-4316-a72c-d699b8872604@amd.com>
Date: Thu, 18 Apr 2024 17:14:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
 ewagner12@gmail.com, suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <b0db9b48-e9c6-4e40-9d07-c353ab14e4ce@amd.com>
 <20240417160635.GW223006@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <20240417160635.GW223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AA.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a66b6d-888c-43b9-3fe1-08dc5f9d00bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JFXN+6RJe0ueP1NngMIbvGHVtb4KliCdtYjWLNAnox06ugslcAibPKJbr1Xyy7GNhUz2fXC9R6NlXAJnXeZHiu0bBt4Z8FyKgc0Ws+muEoQkXIZCZ4ARJkUc+orwNg8VIpq92a2Q+QsjUMhvWPtf5Dypo1xqtqI43KLcxtYeOVP8Y9lvEQp9uqsJL2yFJrn3oeO63orYRLxWCBg6gsvKr6xKXEtlYWe8vT8qSwOVY2wufkvU22ptGwbF0YhWATbutVkh8L+npYiBbQrJp1Tiv3kZFBgxb8djQYUK5lowkDQSjTVVEyEnEc6BQjXZlx4FlWOS9VSkmF3phobUmkoXXep0VI0yHB43Cex097C7xRUq3Wbnbj4jzJ5WOvmLsImbGylBhqPi9AKWRzE4UcX2wrPCDgEP2pF9o17Uwj8ZL1ebGHZnwIioP/N+votn1J+a7wRvxRNcnHNeih6iaR1QAADMYme2tpRVVUliimMy3Owb3EzEKtcc7hYTkp43UU0z+mMIPN/VZ7046fMtol19EULM0gMd7GRAbQk7mTMNuhr+5CbkK4LiE0KgFs0TlCh21z3gGFMhwMzCss89BNyF8U1PUSs1+QQWCf/vkCWyyiCYC1qgW3/6ra4tDgHBuSaDwgqiGs5+NhEAg33kpe7o86Ndb80LbmAno1FiwK5xmf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW1aaWlQTWVJbkFjS0hZOHA3Sk9IWVIxM3pWV0k2dkgvRWlIakpDcUI2Rldj?=
 =?utf-8?B?cGVuRjhiNDE2Nm1MTkJYUDlCb0hPVjFWUUhWNGJIMjhXZ21XelZZWG9BMkZl?=
 =?utf-8?B?bURvekVtZm1ZQzFTTXJNc29ZM2xVYVgvUFhza3gvVlZYdkFSbGVuM3RUT2ox?=
 =?utf-8?B?WFFaQVdDTGJjNXY5bmhJZHhzVjE3QTZQcTNvczhTNTkxZ0l4dmZZRFNlZHFy?=
 =?utf-8?B?ZUxTd2JyRDJlMEJSY3RVamhSSGhHSGRyV093dnpRek5hQ0thMURmTEhrWnpu?=
 =?utf-8?B?bHZsSW9qa1ZlZlpzRW9YSmhLR3ZNWUVJbVpBVWVDc21xaFY4NXZSc2E4ZDZC?=
 =?utf-8?B?WENrT1F3STdiMCtCV2pNTlRxTU1mNllCYTZFTFhPMGxhUUNzVmJ5NGRiaktY?=
 =?utf-8?B?aE82N0VJVFhSQnVHVFUyK2NoRERwNGtuc1lUWFBOV3ovU0Z2WTRUU0JsMDQy?=
 =?utf-8?B?cW1zaDlKNkVOZS9XTUUvcWdHNU1zWFBVczQ2RjBNcjU4TU9tbk85V21LOTVH?=
 =?utf-8?B?UUxmNDBIN3cwbHhWS3RBUVlsMGRxbDRNakxNdmE1K0V1d0tPejRMQlZxQUJE?=
 =?utf-8?B?ZTZRSzllY0J6eG9rdlJoTEFzeUhwcStEcUJiWGU5cWhYSVZtVmJ3LzRRbGxt?=
 =?utf-8?B?dEE5U2VTcW14VzUrR1krTzlNTWZDaGxNWTRSdG9HVHk2NTFnVjJqTURzZ3lR?=
 =?utf-8?B?RlI5cFpOS2pQNGpCSmJqdWRWamx0bEQwanNnTjNKRmcxZ2xBQ24xUnRPWVlq?=
 =?utf-8?B?TlUwbzdSMjJDVFBFUHEzMFVRVGFvYzdnQVhKZ3Y1ZUc4eCtVODE0OUlEQnht?=
 =?utf-8?B?Y1kxZ0ZSWS9tL25oTHJacVo1RVlpTW0wQitxbFh4dnY2S2dwd01oV205Ylgw?=
 =?utf-8?B?bXl6NW1yNUVFbHFRT1VVbFdiMnFTNkxRVTJFWVJIaUhBem5WSlh4Ti9GemJZ?=
 =?utf-8?B?T1VSbEtSek0zTkFzalk4V0tiK25IZDdTN2p4NTZPYWxKRVlVVmdmNHBCb040?=
 =?utf-8?B?YTBTYVh4cEE5N05IKzRuVTZ4Ri9oZVU5WXZiaTVvK1VXR0hzUGZreGRmQyta?=
 =?utf-8?B?bGJLTDYrWVVvcERXUlhrRDAvRm9kYlJkTnpleWJ2ZlBPSmhlYmQvT0FNY0pm?=
 =?utf-8?B?cW5yWk5BWGlSWkNQdTZiaklEWTFsNzMyamhUNkN2bzlIcTlMRXZDY2taSGg4?=
 =?utf-8?B?blJsZ3dreGgwTUJGallERmVXTnBxc2IveHROK0VXbWgvNFZNd3hua2l6ZHBQ?=
 =?utf-8?B?ZVpMMHg2V2pKNXg3VEUvTjZPcDFjSWZRREZVQ1ErTm1oZWExMmw3WHhtU2Vp?=
 =?utf-8?B?ZUo2ckV0WjJHZUcxMUgzNkJsa2ZtelFPejNyNnBUWkRUK2o4dXFZdXZOQ0F0?=
 =?utf-8?B?RFhPQkp5WVFBb09mRndoblBaYlF2c0o3TEVOY3I3THArR0NrVGZJTU4xMU0v?=
 =?utf-8?B?WUJkS3kycTB2Z01icFBKSy9RdTZCWWtHa2ZORnNqMWFPNmdmMWgvUzZyUlNQ?=
 =?utf-8?B?Z09iZHcxS2JWZlF5K1RsR2N3eVUzYjhiTDd0MUlIa1dJSW1kY2lRSmpwY0tO?=
 =?utf-8?B?aXF0NU1QaW9lQ25UVW0vNmlSa1paQXp5RW9QTzJkZTJkNGZ2NDFOWS9KYzYx?=
 =?utf-8?B?dUZTV1BLbEhxVUVtdVh4cVJqemdhKzdLVCtNNHVybHowdUlMK1R4elFvL3Er?=
 =?utf-8?B?ZS90NHJkQ0l1NTFGU0JoRS9jZit6YjFlYytyRnpJcTAraGpUdnYxUkdYZ1dO?=
 =?utf-8?B?c3hPdmFjZkdXRTJRWnZQekFLdlk0d0VGSDRpRktGd1lTS2h0akVrT1NhMCs3?=
 =?utf-8?B?OGIySlJPeTM5dVY5emlpRmRndFdpeGxRT1k3eVpaZGNzUTM0ZjM2OHUyRGxD?=
 =?utf-8?B?c3NXd2grT0E5YU9KY0pxaUZrQ1RibTFPb1lTdllBckFEbHZHRU1pSHNoRHZt?=
 =?utf-8?B?dG1ydUkyUzk1VDNhS1Z5bjdkK2tPOUYvVUdwZkxkd3RGQlVmUVVhRkN5M0E5?=
 =?utf-8?B?NzVTOWNub3g1RmRHdnFOTTFaelljRXpMb0VnVjlwaVAwSkxDQ05QbVV0bUdP?=
 =?utf-8?B?RFlPQzBaaEFJUWlBMDZZbVh1Q1V0ckgyam1yU0hvUkJWUFVqc1BnRVpoaXhi?=
 =?utf-8?Q?aRMQKHH++KVrvHKbptDIHlQ8f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a66b6d-888c-43b9-3fe1-08dc5f9d00bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 11:45:11.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLjNooGTnPPQwFCGf6+fm20ac1d6SsVtL0UtIkx3WhY/JxbFRVKwnEZytEGl+ZXM9KexsWa1AKNcpOPNjGw16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

Jason,


On 4/17/2024 9:36 PM, Jason Gunthorpe wrote:
> On Wed, Apr 17, 2024 at 10:53:00AM +0530, Vasant Hegde wrote:
>>>  - DART
>>>    * system page size is too small, can't map IOPTEs, force identity
>>>    * iommu does not support IDENTITY at all, force paging
>>>  - tegra: Device quirks mean paging and DMA API doesn't work
>>>  - amd: The driver can't support PAGING when in SNP mode
>>
>> Actually When SNP (Secure Nested Paging) is enabled in host, AMD driver forces
>> DMA translation mode with AMD V1 page table.
> 
> Why does it return IDENTITY?

We return IDENTITY only if SNP and memory encryption is not enabled and device
is SVA capable. Upstream has below code (v6.9-rc4)

        if (pdev_pasid_supported(dev_data) &&
            !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
            !amd_iommu_snp_en) {
                return IOMMU_DOMAIN_IDENTITY;
        }


and during boot, we will enforce Paging domain when Encryption/SNP is enabled.


> 
> 	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp_en)
> 		return IOMMU_DOMAIN_IDENTITY;
> 
> If the HW can't support IDENTITY then it needs to return
> IOMMU_DOMAIN_DMA..
> 
>>> Since actual PASID AMD attach isn't implemented yet we could just
>>> remove that check from def_domain_type as an RC fix. Vasant can sort
>>> it out properly by disabling pasid support on untrusted devices until
>>> the DTE logic is fully completed.
>>
>> Keeping PASID support aside, largely the question is who should handle/decide
>> domain type for untrusted device? Is it core IOMMU layer -OR- HW
>> driver?
> 
> def_domain_type() should return a HW limitation. It has got muddled up
> with the default domain type stuff, but in essence it's usage right
> now is to tell the core code that a specific device cannot support
> IDENTITY or PAGING. It should be combined with a matching test in
> attach_dev to block the unsupported domain combination.
> 
> The core code should use that information to decice on policy. If the
> device reports it cannot support PAGING and the device is untrusted
> then, IMHO the core code should leave the device blocked and
> inoperable for security.
> 
> The key thing is this API should not be used for the driver to inject
> some kind policy/optimization choice.

So far the policy was core layer to handle untrusted device which got changed
and hence we hit this bug.

I don't see any issue with enforcing these checks inside AMD driver.. If we go
with this approach then IMO core should just adhere to what driver returned
rather than failing. Having policy decision at two level is inviting trouble
like this one.



> 
>>   - If its individual driver, then I can try to add fix in AMD driver. But then
>> what is the expectation? Driver is expected to return IOMMU_DOMAIN_DMA -OR- core
>> IOMMU layer is expected to adhere to whatever driver returned?
> 
> If driver and HW supports PAGING and IDENTITY attaches to the devices
> RID then it should return 0.
> 
> If only PAGING is supported it should return
> IOMMU_DOMAIN_DMA. alloc_domain_paging(dev) should select the correct
> page table format - including a format to enable features like PASID.
> 
> If only IDENTITY is supported it should return IOMMU_DOMAIN_IDENTITY.
> 
> If AMD SW cannot support PASID & RID PAGING right now then it should
> return 0 and fail that attachment combination during set_dev_pasid().
> 
> In the interm you should instruct users to use the command line option
> to force IDENTITY until the driver work is completed.

This is a regression hence it should be fixed. All other enhancement/fixes can
be done later.

-Vasant

> 
> If there are embedded GPUs or something that have an implementation
> that bypasses the IOMMU for DMA then you need an ID list to check
> against like some of the ARM drivers do.
> 
> Jason

