Return-Path: <linux-kernel+bounces-148171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C28A7EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BB51F223B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795BD12837C;
	Wed, 17 Apr 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eL0mnwE/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E756A338
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343713; cv=fail; b=hsg+z6VFMGzf90tdJnDFXJrhvDL7R0gk4zANpLCmQj5SHMBO7jSLagy8NWOmuThLXICXBFZ8339DTKAWMLm46HvrT8t61pd6/ueZ/SfPShR2Vc8MiZ6E8c/5+5b4l+VyGZQCkIV2iAvRC9rQiaoO/X7EnU2jGIJ3tB3CPJJumHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343713; c=relaxed/simple;
	bh=WgaQSERREQrOU0xx7pMUXrj2EEKUtOZ1qLbF577tnC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upcaCuNubrk0WFnT4y1QtF/fJ1Y7MIfqTwf83WmUjybwwkkqh64+nOAdq4I+jlpl9aL8jEOGWCg/LpDlUClsHppn28Ny9gbH0svVa806ucUxVXZBuE62c+iILGIddHTxJAPTqdExzO8TKdpPd4kXc+HVsJGnBZ+2hvXAgyJFpZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eL0mnwE/; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq9DtK+e2kzzkQxbkVAJGLkZg0/l/36xN09/q3ta06dK/yx8zKoHhr3Hz6Z+Ru7bd2cgHwOwmW+DP7YidTsNS5DWDKYOT1219i5Ovv37aBRrit92/b8bmUtbnZrwIz+Pp8eWnRlyK3c05TK4AnasYU4jckyjSVcFv/KwOAGHTxAZRFF9SFjITVV3TNdnuZ/b2paHtcSn+j6qqeyTzUmDCFhQO3b/JzK2O/kZG4RJTchClUvr2k8YEKcU7/2fonc2jebS+nbxIqDFmLGXRK1uaFFN/wofa8u3GSeUxPQx+U5ll0crjd3Gk5ong8O+ReRbVvz5nS9S6lnQ+ZasgqugPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z06tkYs5f7NG+q9i5cG0KsRBRO3X5PQVLub9VTnsZnU=;
 b=a+OhIqn5PPglF9aFw64rIk9fJQKWkIzQEtEVQaPnEc78WoC4X1U6RvnOqUodg0rUXpfXxeW6U7Cfp6dhTvfpB9m38vHVSED1FIb+vo876O07I3mlvIMOZsgIDS7hkYmSIF8J5R5TzBnW5HWKW7+cHz6cUGcAPqxMbl+PFJqOaSs5M1Q4Wb6dr5bRonDTB02yZ+uELj4q5MF7GfNsljxnL/5gU9C4J6ueeM70Ne04GMHlAgGEZC/HkKY6I9X3abD6394t14W7qy95VOs1ClRoafRsjartEfNRx+mEFZ/T7KP8t6MKFNiIG7wyP2bZ9IU+BFDYngxMYcU5ixwJpHGyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z06tkYs5f7NG+q9i5cG0KsRBRO3X5PQVLub9VTnsZnU=;
 b=eL0mnwE/seZLvNgzGQ9DJ+xFJWD0ayasgp3iMgR2mOPYlnbKsUQlBmyRTcJ3alN8NQsn/s1zYEQ65rvYfxfn4agfgaPVJMOtq5X7QLkpr1wEZ+VJgG9FAVe567Mr+wIDUJkkdmnNSAJu/6icNP6hFHkv/dc0V5scdfU6CxkL9pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 08:48:29 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 08:48:29 +0000
Message-ID: <0afc5f25-eeea-4e41-8d5b-38513917d6d8@amd.com>
Date: Wed, 17 Apr 2024 14:18:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Eric Wagner <ewagner12@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <47d4bfd6-1d76-4bb8-a33c-c9c99b86656b@arm.com>
 <20240416114955.GT223006@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <20240416114955.GT223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b182651-1c59-4fd2-2f5b-08dc5ebb2786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	amcXkmiHhnZ6Ce0g0+HzlSzsPBKNh5KqBTsQGqhBwUqZ/w+hRDqwLezEpSbEDCMdYdMBth6ieL2LgAJ4T9Xk6D7iIdLIOgtItdO8qDfA5l1SfKv/oOaChCJO6fNw+Mo8EdhA6FEk977nJFct2mRloIKu/85z4U8iwOUQdfKqO9Bkzo+5zVNxhPIIlKyAZotxHsb5hDyZ+H4jxVc5D4FggRjU3Xrvq5AUFqT2CpoPX8Y6AeiJvX7vcptq/q99SngEcjPUYHxWlHdYE9epfSFH1kOWCfVBtiN6lzk9EwgWiuUHE6Yo4mL4r9nt+o/eq1U0GyYPOXPrALWWF4BKU+B8eKbRIWR/iLfpCM24e5wCBaHNaecVQjrtnZaCuCBL6a1E9K6Xe/sIQijNbCrbHVqI8Ds77UicFhulI+UgYn/6RpjXQjXUQCwc23jGkX3yNzbzEViV72QXIpH3RY2FcCEarCC5D5awWb1nh79do3y9dQtmk2VUu4PLi1INqMLsCbgeNfmpoKEPk2L0xbif7rA8tHAGVp5k91FhgNlyu/nmk29HjgXM8LpERXVTY9kpa8QB3DfNlpdsvbImEYksvklGnU/7171u4LcbBaz3Veq8ToTfc7Z/BNmA6TPebcm20S4sY2H/nIZDc6C/o5Nx479571m7M6878On98RLQtyRIPt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmUxSE56LzJtVHZzS3prMEN1cXBhY1RGZGs0VlZnV0grYVZ4TExzUmVrc3BH?=
 =?utf-8?B?S2ZBSHJtQ3M3aWFPR2VsZHNjd25TNkI5SmJEcnU0VXh4bjd1OTJXNGM3bnYx?=
 =?utf-8?B?SU1YSHdsZU10aStheG5vWTBabE1pS0hTOWRNcTZPU0ltcFRxWDd1NFJGNm5P?=
 =?utf-8?B?eVlEN2ZDR1pHY1NEVFM5LzQ2ajY0cU5qalhKalc1TnJTQkZyS0EydzA4Mmh4?=
 =?utf-8?B?MkVlaHUrc0c1aGdmQ3ZZNzYwUUJLS3FKOWpSVUFRNGxzUG5mQm9UcE53aU80?=
 =?utf-8?B?RDVYb3dwcUI4blFacGdXTUtJUFAvNS83VjBNN2V3aUl2V3JxZy8vemxXQ0Ro?=
 =?utf-8?B?SzgxL0Y1SDdheTlKN3pPdUVNb2luTnNiLzZHV0J0WUpMWVpCUGVpOUdWcEFu?=
 =?utf-8?B?eGxZVlVxc0tBTVRFSmhRdjFVVk4zRTA5TkRUa21nTEFONUpKMDZ5S1RsNnAy?=
 =?utf-8?B?bGFoSnNkci9acTJuT0FIT1RlUCs1NnFLN1ZsNFUxMFpZZGRrU3didTNLNnJi?=
 =?utf-8?B?aGlqd3dDOVAyeThPZkhPS3J3SlJvd1FWUFNmUHdMK1doOVM5ci80S3g2YUF4?=
 =?utf-8?B?K05GOXpNdVNMUCtCS3dYYmJQUjhPcHhVUWJTZTR0bGhlZnQ0eUNsVDZGZElI?=
 =?utf-8?B?Ni90bU9Fb0h4KzVGbStnZlViM3piTmlsNCtqTlJNMzZ4Rk9mLzc1dHhJaitQ?=
 =?utf-8?B?REs3eXg2UFF5RHZEOGhwMTdWTVFNK0VrZzRVUTQySVB4ZXRoRVFrK1ZwM2Nz?=
 =?utf-8?B?Ny80R05lR0NrNmlnYldqRWlkQ25yaFF0QjNuM3Vsb1NVR3lvNzc0R1IxZXVM?=
 =?utf-8?B?NStNOWdUSzZJSnI4S3ltZ25uT0RZeE4vbzhSd04yWEhjZjIxaU1pN0hRbmF1?=
 =?utf-8?B?cUhTTzZueloxV1VhNjhNcGo5UTEvZjVpMG1MUXEySnc5QWpENWpnN2pZcGtZ?=
 =?utf-8?B?YTZJaHNrMHFHV1daWWxyUVMzNGtZamcrSnlnNzkxYnNnTytGV2F0T2l0MllC?=
 =?utf-8?B?NjR5K0JycUpCUTIzMDB1OUdra2g0SW1zaTdMRHNCaHY2TktOQXVtOGd0Z0RM?=
 =?utf-8?B?QkpKbG1FU2NVdCtUOFNuWkVUeDlDRTNZZ0lGa1VTWGxaU0JEUG9iQzVacUEr?=
 =?utf-8?B?NVQ3YVRMZEdrNlE5YnlXM0pVb0s2MlJlK2lNQ3FHM3QvWEpsQkl3SDAxOWNL?=
 =?utf-8?B?T2JSS045QVRKb0JNU0hrMko1TFpCeHlHb3h1dXZnQ2J1WkRkTlM0MktWby9G?=
 =?utf-8?B?eWxWWFdlUTRiZWNDbmhvbFptSHU4MEY2Uk4xT3ZNWGZNanorTUlnSzFla3hl?=
 =?utf-8?B?SWlNR2g5VFh2cERpUlVTam14aEo0c29ieFJwTjZZZlNOeDRCdjc5MkhHYitU?=
 =?utf-8?B?YjRwekYveVdtWHBQckpBSHJBc2JlVGdKQVFaTENJVTVTMGdXSzFheXRZQmY2?=
 =?utf-8?B?allVWjUrOGpHdzJSTnZYMVZsUEhROHpkMEsxN0ZrRGNVem5RL3NaaFpJQTZD?=
 =?utf-8?B?QUNuVVlTaFJHby9iTWh4cUc5aUV2M0VvYXRyKzBtOFZZZUIzc3Q5WjRrVTAy?=
 =?utf-8?B?WmNRL3VxTkRQbTZJNlR5WDRCTVdIWGp2RGNCN01IWkh4YjRvZWxSMnZhOUhR?=
 =?utf-8?B?amVad3FaRGw3bUpVR1F3ZjdPV3RaVkFmOCs3emthbW42U280SnFmTExTcHR2?=
 =?utf-8?B?QmVwMERzNnN5TlpGNi9LcU5TbEI0VzE0ZkcybktMNGN6TUZydWl2QnczMUxa?=
 =?utf-8?B?WDRzaEd6YThLV25mdzUzaXk5T0JxU2pVdUl0ZnUrTmU5OXh0S0pueTdneC9Y?=
 =?utf-8?B?RElIL0tlSC9mbnRVaTM3Snp1Z2QrMUNEZExTblVqbWtHbVNrMUJJVXYxb2pL?=
 =?utf-8?B?VjBTUkZ1MWVHUlZ2Y0tqaUptYXlPVTZ6b1hZbUpiSERTR2orWkpkZ1Z2Vnds?=
 =?utf-8?B?azVLYU05eGZLUWJMY1R5MGV5dEM3R1gvOSt3cks0ZkNERDk2eTkxb25sV1VZ?=
 =?utf-8?B?QzBkVnhSYnFoSHF4VnNzK3p6aC9ZSy9jYlRGWXhVVzdoRGJaVVJVU0doNkVr?=
 =?utf-8?B?QTRqVG9ha0Q4OS8yWnUzRUhBbW5rbWUrNDFjZDZlMWVQcFNGUll1Z2QzNFEv?=
 =?utf-8?Q?uhfFPmE2Tp2CQeQhID/O1gksm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b182651-1c59-4fd2-2f5b-08dc5ebb2786
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:48:29.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDMAsEi1YCwul8zsPeKhA16AWisc1hMeep7oauYX6tnCrhYyszcT5+JUrXKk/JGAx68Uo6EKeAH32q3DueqeMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269

Hi,


On 4/16/2024 5:19 PM, Jason Gunthorpe wrote:
> On Tue, Apr 16, 2024 at 12:25:52PM +0100, Robin Murphy wrote:
>> On 2024-04-16 1:39 am, Jason Gunthorpe wrote:
>>> On Mon, Apr 15, 2024 at 10:44:34PM +0100, Robin Murphy wrote:
>>>> On 2024-04-15 7:57 pm, Eric Wagner wrote:
>>>>> Apologies if I made a mistake in the first bisect, I'm new to kernel
>>>>> debugging.
>>>>>
>>>>> I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
>>>>> 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
>>>>> Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
>>>>> as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
>>>>> bisect log is attached. It ended up at the same commit as before.
>>>>>
>>>>> I've also attached a picture of the boot screen that occurs when it hangs.
>>>>> 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
>>>>> problem.
>>>>
>>>> Looks like 59ddce4418da483 probably broke things most - prior to that, the
>>>> fact that it's behind a Thunderbolt port would have always taken precedence
>>>> and forced IOMMU_DOMAIN_DMA regardless of what the driver may have wanted to
>>>> saywhereas now we ask the driver first, then complain that it conflicts
>>>> with the untrusted status and ultimately don't configure the IOMMU
>>>> at all.
>>>
>>> Yes, if the driver wants to force a domain type it should be
>>> forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
>>> is incapable of supporting otherwise.
>>
>> No, in the case of AMD it only forces identity if it thinks the device might
>> want to use PASIDs (because of the architectural limitation that the RID
>> always operates in GPA space so can't have its own independent translation).
> 
> AMD forces this because it doesn't yet have a way to automatically
> choose it's v1/v2 page table format during alloc domain. It is just a
> SW bug.

Yes. This will be fixed.

> 
> The CC/SNP limitation is also a SW bug but is more fatal as it can't
> even attach a v1 page table in this mode.

Memory Encryption needs Encryption bit support. So we enforce Paging mode (Both
AMD v1 and v2 page table format works fine).

SNP is hardware limitation. When SNP is enabled then IOMMU must be configured
with v1 page table. It won't support Identity mapping.

> 
>> Either way, though, there's really little sense to that argument - if
>> enforcing strict translation *might* compromise the device's functionality,
>> we should instead go out of our way to ensure it's definitely as broken as
>> possible? I fail to see how that can be justified as useful or desirable
>> behaviour.
> 
> For SNP cases the attach of a DMA domain will fail, so yes, moving the
> failure earlier and giving a clear message is desirable.

Its handled during initialization itself (iommu_snp_enable()). If IOMMU is not
configured with V1 page table we don't enable SNP.

-Vasant


> 
>> "Failing" iommu_probe_device is merely how we tell ourselves that we're not
>> interested in a device, and consequently tell the rest of the kernel it
>> doesn't have an IOMMU (via device_iommu_mapped() returning false). 
> 
> Probing failing with ENODEV means the device has no iommu and the rest
> of the code should assume DMA direct will work.
> 
> Probing failing with any other error code means the device has an
> iommu and it couldn't be setup. DMA direct probably won't work today.
> 
> If you want all failure codes to mean the device is safe for DMA
> direct then we need to try and attach the IDENTITY domain on various
> probe failure paths too.
> 
>> I think I've now satisfied myself that a simple fix for the core code is
>> appropriate and will write that up now; one other thing I couldn't
>> quite
> 
> It really doesn't match the design here.
> 
> Jason

