Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB167FB3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjK1IMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjK1IMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:12:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E3194;
        Tue, 28 Nov 2023 00:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8kQQuPhE3Y1bI7ZUI9S4ODwTgdblHK1pHDownokqoCZPywRV21dBQXL9iIZdUdebqCkFN6BFgzsd+YwQYPbIBXGeD5XQ07+XYA++o2ob6UGWn/c/LHQ+KeH/jdrDuLb6AZC/96cQzI+86wz8JqH4YNp4i2wqPzm0FYJQGkZ5PIPvx++AEU11jFXxsIdoDxjx2Cev4TOeju9QswRqzdcRuJP2FdB4EKmsO0ut1tyouZdUbj0alX4GAnQXI0Cmalys+qD1p/3IhzUelf5TvNpUJYvBRVmTkiFI6s8V3o9QGDh8Zsan6tEfSsIvLK6ra3ZxiJdjHjwNAepdWU2m3Qzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEGRr/6KEbdzf6TplDklxRkFn60nop6KQg2v8//7e1U=;
 b=jcHGzbGsEqXl09LKEEgqpt0mpDyzz2x74lVODEBzBX6pDU2JOinNPMRHE2+K0tHFcA2RXfbzOWnR5Ma6gWVB3OHLLBmcLmP2xpDtZP55yzpyL/8lao50h3vzknm4T6Apf5trmYYdMgRSIX2WKvaYL49bqJrTVfcEphfLiUZ4qDRPXBVoRLZco40IDB+/xs25Op/5qp8npf2rrDCCAoIkIuuVn5/bK9OGjcfRunoNfH1kqBCYwqj+nwPQojPouIf7BLubRcf5XwHcpaEIQvJJC0KcExgOsmU+Ax6EkAbTUe034l4VqsjbpE3rb+WFVCZUqh9WtcnDq6qlUQICrZBjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEGRr/6KEbdzf6TplDklxRkFn60nop6KQg2v8//7e1U=;
 b=pACa0jsTWOfxg1j+S7InO4PYAQeYai1JfdGpwMxszW8RIv5/hg9OWo1RAPkBKdvECw9D6SUg0us9WyfxsRhJxhYqju0x1VBXwYVwGRc5nBjavcagAjHO+XdL9XehdEa8oRpXSkDTCzYP3nfO+97ok1Pu/sG+LD6dJNYSLZvmRGusZBtOy4ShuuO6jBJwNJBCkWdMjj4B92pc/tfwrla1eeI1eWbynRtm11sazLv/o7LOQBENzkdc8fHbzRxohQMo3gXTUuogA0ii5bJWUmUqfvY5EyXeraNt/HwZv8LvQs7BgUSUXZlz8TzUVhDh7CkFQO4XJsWOzb429HwA0G/0YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 08:12:06 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::7f6d:9dd0:95c4:3194]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::7f6d:9dd0:95c4:3194%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 08:12:06 +0000
Message-ID: <a744cc24-aae5-4b27-b317-bfcab2b0d0c2@nvidia.com>
Date:   Tue, 28 Nov 2023 13:41:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Don't reserve IOVA when address and size are zero
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, robh@kernel.org, treding@nvidia.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20231123061201.16614-1-amhetre@nvidia.com>
 <2ba7bab4-daee-4883-acd4-ec9a10c82103@arm.com>
Content-Language: en-US
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <2ba7bab4-daee-4883-acd4-ec9a10c82103@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::15) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: adbe9a94-5aaa-46bf-4e3a-08dbefe9b5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j41j6Enu2Mn0QYsBFRWHSVYF/V6uW6YySH0AMijUnjA6JMsCVcq9dsn9OvL0iIIYkXLiqE/8BBgd9KGtYFoh6WHEiZnp25k8oXoXK2Ce1eMA0y19WdpEZuDKgFNk4sVAV4+/Yd7tZtF3PjQZIRhqx+lDOHsxHJBERODdMWncx691sZN4G9ziUhkVSIwT1LnNbG+T6OyxHGH7p8wavE3yQ3ksO3Wp6LDaZ0DhXsgjNRYtdw+R0AEgszqu99v09UDPVnAIwnrdCUpV1c9mmxEN6dZ2cNR7Dw30HO1PSQDT+K3oQ0o8CN2P5XkrScqCSu62l2W1xkmsMRUgIBbApbYNKLGAVur15TGfWpyOZ7utpqmSRNMFcFLoavatjiw5pBoUOuDRD5YTYdwpSfk2VuaZTt1NN9KaKVRpJQJCJHI8rpfFhTuj2lxpbkl50IoGMHm1jY8d7F7GcOgCOw4dyeXufXTM1B8vPSxn/3CH8zrkRyJ6bZ4GPosDC11CAvVkujeDs7qHwYmBruIp2D67nIAawk6pZJcNBIAA5dGpwLzJCGvfVx5DcguZmplUkhBSlZ9n3xP2G5j01jrQv6KtJ5n0chGkrs+NRp+BzBVYxG8bVWnjCfMc4OzWAkMd5Lo4gg0JiNeJOXrqRq8FchAf/ig3zu9TDan+pDLo2EUSgjjV9iub1YYw5mAHxxyKfjisdMYl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(38100700002)(31686004)(5660300002)(8936002)(8676002)(66556008)(6486002)(4326008)(6512007)(6506007)(53546011)(6666004)(86362001)(66946007)(316002)(6636002)(66476007)(31696002)(478600001)(41300700001)(36756003)(2906002)(4001150100001)(26005)(2616005)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhLYnBQM0hFQTRoQmp0dUhGekxmYWdHM0tQcHhuc1pRYm5IZVdJbU93dVdM?=
 =?utf-8?B?VDdvb0YrLzM3RkxoOWt1TmZNaVpjdm4vODI1VWVQM2NoNlltSEFSR1FVaVpP?=
 =?utf-8?B?S01VbjUxdlNDTEp2c3dBSkhqMG1RSjFaeXhSVFRMR1JtZ3hkK09rUHZwdTg0?=
 =?utf-8?B?WHJqa0NZZ2MrcHA2aGNkNmltcFY5bjZvcGowTTh6U0RqU0NXOEQrN1JwOVBn?=
 =?utf-8?B?YWJPaDFZMTZrbzVac0xDaEJUWCt5cmVIeHB5aEwySEREYnpUYkVaVE9vbTgx?=
 =?utf-8?B?cXJjOWgxVUpjVVFSOGRQVjJqUWRTVEptRnF1NEIyOGZkUjFkYnBhQlRrL3VD?=
 =?utf-8?B?V3NVT2k0d21SWVRiODVrTndYTkg0SGdOaHdGRmZ3NmRPc0p5bW9Xa0JVRzJV?=
 =?utf-8?B?bm9PSTl0aVVRR2IxUTc5eVhrVk5pKy9lQnlSb1BzS0tLT0kveFpjZldUQ2lk?=
 =?utf-8?B?VExoV0NpdThPbnhlcmN0M3pIQjcvb0lHNXV2NnpqMnpPekNpNjN3NTBXZ2FO?=
 =?utf-8?B?Ky9Odis0VDdFUG4yVXc3R1crb0w1S1JxRktiMTYwS2hnUUxZV29hYWRJWFZT?=
 =?utf-8?B?Qmpwc1d0WUc2M3EzaWR1Wkd6VHVWaGEwNEpNT0c3ZENJTG4yWVB2N25ncnkr?=
 =?utf-8?B?WndIZ2NXc0h1d3FtK3ZnSEJ3aGcrNU10R2paTlNINXcvcUFERGtCK0pTQjQ4?=
 =?utf-8?B?Q0xsaFZPM0tnQ1dKYTUvbHJpSmpiOWdEYTVtOXNLc0RBeVRGVEJzV1ZiWmtQ?=
 =?utf-8?B?TitZOHRQL3J5a1Uxd0RsMHM2UVZtdzZ3Y3lvTkFuSzJteVNQZGdXdVJ3WTZX?=
 =?utf-8?B?NzRNU1hpVzJNTXJUWnVKUkNWWEd4dzRPNmRIYzExYmFvZ282NkdWK1F4OUw1?=
 =?utf-8?B?bmZDTFBMaVptTzl5L05mZFJkTW5qS01NbHhRK1VsWG5oRzFpa3l4SldjejNF?=
 =?utf-8?B?dThKWVdnZHMyaDV3YzRpeHBXWi94M1p4RGZZLzJyNkl2aC9NMkhhMFlNUXRT?=
 =?utf-8?B?MWp0WEZ0MHIzNmloandZdEw4VVJQNUc5bTd3VkpRT1h0MnlpSHNjV2RxMHlt?=
 =?utf-8?B?eXlJL25zQ0VUM1dnaSs1Y0xDalg2SlNLRFU0V1g1Z2tFV1VrVzRHNUp2QWN5?=
 =?utf-8?B?N3EraFZjZGswU2Z3Z1l4SDI4MWY3UXVRRkMxbzZOWkxxNE00cTRLaWVoUXh3?=
 =?utf-8?B?UklxRTUwNnVzd1JSaS9sbEl3Zlh4SGpLTGxOK0VzZHVIamZyVG14SW1kTmR5?=
 =?utf-8?B?ek42R00xVHZTcWU5aXcxdzhzYTQrWVMxdzQ4eTJNNDUrdXVydDYveFM2c0g5?=
 =?utf-8?B?S2w0ZUQ2bTNFTko3dExCVmt4QjVYQzh0TGJ0dWFqQWd1c2d6WGU5T0FUaWFr?=
 =?utf-8?B?OGJOL0FEQjJWZHQ3NU1qV1ZySWVGZytsT0xHV3JoNlYzbnN1SEN2bFU3NGpQ?=
 =?utf-8?B?OVlwQ3dsWUFnQWJFajh5NU9ra210NHU3c28vbjZDUTZ6aHQ4Skd2UEorQVps?=
 =?utf-8?B?K0VXVDZEdDdRY2VTYlpMcEtvakpKWnI2bmFSNHpBemJJU2VYR1k5L3B2MGF2?=
 =?utf-8?B?ZDZKT3VMWXBxeXpYdFY1Qm9GcHhMd2dUMlNtaEVndndqd2hsNUVreHFGWm1j?=
 =?utf-8?B?ajUxT0hxdTZ4cW5vSWI4eWdoM0c5WWc2MUlwcHhSaXplMmlocDlVMXQrdFBQ?=
 =?utf-8?B?TWkvanh5NjVET3NSTkt4WThEenFieHRlRW4xVzNIUE00ZmJTTGExMEgyVHlI?=
 =?utf-8?B?R3d4U0ZreUt6dXhwRmJQa1BoVzduQ2RRUFQzcXk2akk1N1RxemJnS05KenVo?=
 =?utf-8?B?WU5QUGw4U04zNEF3TGxTSFFVK0NDNjNjOXJPR2g0THBWY2lrVzNXMHhYM21Z?=
 =?utf-8?B?Y0dQNDdwbmZFUERZRWYrVFgrWCtIM0NjS1JaZlZENmlIdmZYalI3RlBHMGpp?=
 =?utf-8?B?NTl4YUFrQ0E5NlQzRVlsNmJxTWp3alZwRlBCMWMwS2lMZmVyQWZsOENOWHVz?=
 =?utf-8?B?OENYR1I0YVVBeDVWWjhJSCtEakdMSEJwdmZZaXlnNW9Qa1JTN3FnNkpsUTlG?=
 =?utf-8?B?a1FCNWQyK0FPOXNnY3lJcDJWZWcvNzQ5UEUrTG13bUJzeW0xbDIyTTd1M2pi?=
 =?utf-8?Q?9fGkIx/xFY6eFW0cpdEZHub2G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbe9a94-5aaa-46bf-4e3a-08dbefe9b5ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:12:06.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2lztFdsp5R/DiZ9l1EqLxg+ig+qnjJtCmsEHqFbSsFNJmBAmjmnN/e3fS9iiVO4+9zGJ33mVIBE++Xeh0gy7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/2023 4:43 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 2023-11-23 6:12 am, Ashish Mhetre wrote:
>> When the bootloader/firmware doesn't setup the framebuffers, their
>> address and size are zero in "iommu-addresses" property. If we intend to
>> use display driver in kernel without framebuffer then it's causing
>> the display IOMMU mappings to fail as IOVA is reserved with size and
>> address as zero.
>
> Can you clarify the problem there? Looking at the code in
> iova_reserve_iommu_regions() I'm guessing it's that "region->start +
> region->length - 1" underflows so reserve_iova() actually ends up
> reserving the entire valid IOVA space?

Yes, that's the problem which lead to dma_map call failures from
display driver. I don't have the logs handy to pin-point the exact
function which failed as this issue was seen before few months.

>
>> An ideal solution would be firmware removing the "iommu-addresses"
>> property and corresponding "memory-region" if display is not present.
>> But the kernel should be able to handle this by checking for size and
>> address of IOVA and skipping the IOVA reservation if both are 0.
>
> Surely it doesn't make sense to reserve a 0-length region at *any* base
> address? The symptom above wouldn't be quite the same if the base was
> nonzero, but corrupting the rbtree with an entry where pfn_hi < pfn_lo
> would definitely not be good either.
>
Agreed, we should restrict reservation for 0-length region at any base.
I will update the condition in next version.


>> Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/of_iommu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 157b286e36bf..150ef65d357a 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -255,6 +255,10 @@ void of_iommu_get_resv_regions(struct device 
>> *dev, struct list_head *list)
>>                               size_t length;
>>
>>                               maps = of_translate_dma_region(np, 
>> maps, &iova, &length);
>> +                             if (iova == 0 && length == 0) {
>> +                                     dev_dbg(dev, "Skipping IOVA 
>> reservation as address and size are zero\n");
>
> FWIW I'd be inclined to log a visible warning that firmware is giving us
> nonsense.
>
Okay, I'll replace dev_dbg() with dev_warn() in next version.


> Thanks,
> Robin.
>
>> + continue;
>> +                             }
>>                               type = iommu_resv_region_get_type(dev, 
>> &phys, iova, length);
>>
>>                               region = iommu_alloc_resv_region(iova, 
>> length, prot, type,
