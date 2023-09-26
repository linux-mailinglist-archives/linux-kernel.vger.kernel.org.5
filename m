Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F77AE513
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjIZFca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIZFc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:32:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3567F0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 22:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot5C92cdpydhRyIs1hYgg+kM+X/X10dfgsVfKMu3oXOZD+U8fCiRxTGJUOGtR5A019iDJHZJXr3UPTK3Iimd/YG6o0eAtC2w1Jm/1pw0+r0PG+I7orHHkGtIe3cCV/ZQTS169SjGusLpZqtq4riTrQWppxG5jQKUWXB0/1aZQDKGJK8xqMSDS5JO7hy0IuMJjYFvyOf5P2b/0U9ebX1OGFZDe8JWHU4XZoAGtLRYPaqkmngVpi4+BAmSixhw5MxeiDcb7qapusG7+qaxd9TSv4QZjU37v7wLOlNFUl7unDLmMLwbe21R7ZGEaPffvwzNsWF+uutSVX5xQuXjR/LbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WLhqPGiPNhSEnXJ+mALRiw0/m+EjVtjSorc2Ylip2w=;
 b=hZ/IUiz2eM3FfYMwHja9IN9xoHbgv1A6GJWwhwEDNXB37HZtV5J1BXn9puWTWMo24oWigLCtgsBpaAq50oANPiSUgPshbOqvAndplAzrEGf2Pwgor0hrKODU1C9MCtEIFqg7QhjvZIJ2lpI/ChxkDhWjk7qXSfjXoU0K5rzAI1h/+b3r8vi19WVagKoSbeGBjip+ebHE9QRQZItuEYPCpboUH9XLdPoVZu22dW52W7cAlmEcpCixnXgMfMfCy14MFQhkyxKt/P6VcUl8hvO6Jh2yhAna5N6Xp2w+wEdL+BUg7VmzmhrxAXgaqCeOB9XzyAmvWcV8FUZPE2UC/Z672Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WLhqPGiPNhSEnXJ+mALRiw0/m+EjVtjSorc2Ylip2w=;
 b=AsQqG4Ahty6OS4zzsaMA3fKMBhhb3QaoDpxa0TaHDp6ailfpK8HcrWQLvZMmNzbPYef22sdFNO7pM8XzZ0bPA3jJq8ZnmfKNIHmOBO4g67XQkwAO5YYBaVJpewVxHCzVt2CBo5+N1wLUdyix+PMkaMoAYH2aX/mxBIgxypyuH2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:32:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:32:17 +0000
Message-ID: <c083c51d-f9d4-8e3d-8a90-2257949ad774@amd.com>
Date:   Tue, 26 Sep 2023 07:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?B?UmU6IOetlOWkjTogZG1hX21hcF9yZXNvdXJjZSgpIGhhcyBhIGJhZCBw?=
 =?UTF-8?Q?erformance_in_pcie_peer_to_peer_transactions_when_iommu_enabled_i?=
 =?UTF-8?Q?n_Linux?=
Content-Language: en-US
To:     Kelly Devilliv <kelly.devilliv@outlook.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TY2PR0101MB31361E2EE3391EBFAB78014B84FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
 <39dff6ed-2fc1-0462-0317-9d1e4c1c718e@amd.com>
 <TY2PR0101MB313667D70F284FC28BE4039B84C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <TY2PR0101MB313667D70F284FC28BE4039B84C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: b9270351-6617-4af0-b570-08dbbe51f1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNNGnZzkK/zIq/ZVA0bi3b+rOaFDFi50WOSbuKL++P3dMgmxYrgRfyLIHXwoLmy7wOQZIDSSSUqxibG6rxeJDYkFhYEU7ZGHS6kPffMtzZnDa7+A9WTFB/Zo06laVdz3MqIZzYEi8hCj/HLogVAFsrOs8sLSKLJMC0p07Q/gMfQiJokAXDp4g7Iv0wTi2peb6iTzMS5OVQPXdpml58DQBkVGEv6wW8xowCR5cThnXRRNqfJrAyx9q/aToBzSm14MBeUnBVFfncSDq6Yug5BmrCGj/WmepsGQwGsUqR6qGfDEnAnQz7cY8LNfl2yKwrgMZetGifRby6c6ZszqMIY8eWdVCY1Yl0MurrIXEaMRl4eN+1fVaaOXt6c4/Osv5iin2iVFB6ibUrEzq5cmjJTLBGR5MvWGNpc+b05Q5qP3TRSsSqFuKU2EFt1lxepnMF7zO91I7Asmk4dTcm5KgFamM7YFAXLiNbvQPcqhzsddXknMa55grsRqKJNRy7oYg/obGiF/qY3ffmr9xlBPuwTeCFxVnvRgDG24FSzkMGgmDTxakMiij9CRPKZ61tj3dXSQLtcfxaKu0r5oAdYwdYjPpPphd7KW6wuYb/4Mohvg6uxPzcAd/KCpOR6hdEotIyAHHkm99qcdOnfuHRomESOMoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(6512007)(224303003)(53546011)(6486002)(6666004)(6506007)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(66574015)(26005)(2906002)(41300700001)(110136005)(31686004)(8936002)(4326008)(54906003)(66556008)(66946007)(316002)(66476007)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFDODhjMnlvZ3lJNHNCZkJGazUxMHlqMWlQV1JXRnJDazlNbjcxeXRwYWNY?=
 =?utf-8?B?VmlHOGNNWVo4MnI2RHI1aG11RksrV1hqcTBlUG9GNmVZRFZ5dWJrQVB3MTVm?=
 =?utf-8?B?bEx6dWoyNDRaem9PZWZZa2hkMS9FcHRHemRpN0hnU3RlRnU5SldmaXhkQUxl?=
 =?utf-8?B?WDBWQUdlWFgrbkwyZ3EwQXdrUkZQdjZ3K1ZjL2xBS0xZbVNVYU9qMkFEdU5S?=
 =?utf-8?B?L25qRHNWR3lPZ0FjbHpZUTMxa2tBUzI1QnhxZlRSU01wSklRWHR0NjZsQ1FR?=
 =?utf-8?B?UlRQSzFQeE5Lell1cWZ6WEtzamR5VEQ3NmR0cWJ5MThBMnFDais2M1UwSEtF?=
 =?utf-8?B?YUp2alpiUmtZMUhjQmZRWGVGQmVYWHhyOVlUSjZzQitSQThXUm9pTVBqYjVT?=
 =?utf-8?B?anNYakcraE9vSEpLckd0S3h4bTF4VFgySWNEUU9ZRjh1QlluR0tFc0c1L29v?=
 =?utf-8?B?clhBaFlDVDdGUnJuNFRqaTFUVkN4OFhsZHEvU3JYS1BQbHNtWk42aXZjVXhM?=
 =?utf-8?B?ODdWbWcvSEJCa1R0QmFHOXpRazVrM2JIb24rc2IyVU9ZNDZveFJ2ejJ1eHQx?=
 =?utf-8?B?dmFNZE9sTmJ0dDI4SThRZE5JVDgvS29GdUZKL1BxbWlsSk12cXpoZWFyY0Yv?=
 =?utf-8?B?TDNGTnNIbDVVY2JLaTI0NU9CVDJTWUp3Y2VXQzV4SGg1UUxQcEpDOEJSR2hO?=
 =?utf-8?B?RTh0Q3Vqcmlid0Z6d014YzI0WitIaU1GdDVuTml0VzVjZGF5ZDMzMDBJL0F2?=
 =?utf-8?B?SmdpbzA4VkZ1QWpRMmlkSi9CeHFtU2hjMkZMajFTOENjd3MwdXk5VEFYVWp1?=
 =?utf-8?B?SG03cHI5bERkeTlTUHJwZ0lYekF3ekdhR1Yyb3lSTGRGVW82cmJMbUVvK3hy?=
 =?utf-8?B?RzNkMHp5T01UR3RPdElzb0ZUN1BNN1lwQzA1SlZiNmpvRGg0K2EyN2lJVDZE?=
 =?utf-8?B?TkIwMUFRTnVVZ0ZLaWE0bEM2Zzk4VzNSMEs0Rkxic05uajRJaFhhcGxleUVT?=
 =?utf-8?B?VTVqMUJZNGtVT3poQUJldzVpd3piaTNkRmk1ci9FS0J1anRvLzBHUVRSUCtF?=
 =?utf-8?B?dytCcU4rRndqL0gva3RTZUhkYXphY2kzZlZkZHh6Z2VrMEJyZXFOUVZnejFl?=
 =?utf-8?B?ZGtOUUNvMElwQ1J5dFIzS2RybkY0dDFzNVJ2UW90Zm9tdzhRdjlTWTNPTjE2?=
 =?utf-8?B?Z1lYb1YxS0FXaU9Bb2VVdU1GcHJ4UzNhZUtJTEdvQ1krVm9zV0ZBVUtWYlV5?=
 =?utf-8?B?KzF5NEVxMmg3TEVaSkJFbDh5RTlNeWMrb2pKYkxvWXlEV2hNc09JdzA4aWJ1?=
 =?utf-8?B?cFBDa1FZOXlOQjh6aXJJbVRHWENvamh4SE52TEJSeWJ2bmU3S0xOY2dwbEpF?=
 =?utf-8?B?RzRFZFlMYVZnMytheGxLR0pGejlIcFNYSVgwNzJlU3NGZTBsMTBCMmw1bFVa?=
 =?utf-8?B?ZEczUys4cTdodjByOE5JOXFNTWZOWG9LQktIYmVyYytjZDhkcGx4MFc0ZlJr?=
 =?utf-8?B?N0l3MEwyZUNXL1g4K0NVZzhiU3NtcEVLaDJ2bVVxOVpRZGJOV2JJblZ0RlNq?=
 =?utf-8?B?WERSczNYbnB1OFBPbTlpQ2R5UEsvK3MrZmp1b2ZxOENEMzdWeVlnWkdoOGNh?=
 =?utf-8?B?b2JjS0RVL1FsMzNQZng3SnFEbjJTTzA1bDk3OUtxcTljL1VucS9JenhxbEZi?=
 =?utf-8?B?TDBIYkNUL3V2N3UzVjlmRERNVWNjNmhMSEdGYkt4WkRDVXpXU2tRQ0FhZjkv?=
 =?utf-8?B?ZDhVdTltRm1wK3ZoQkszUFRSdWExKy9EelV2QlNGY1VjK0JvZnhjak9DaHBE?=
 =?utf-8?B?OEN1bHdFeW5iY2JLckxIY2dQUWtrRXJSUk5BWmFWbmpoMStvSThQYlJ6aWFs?=
 =?utf-8?B?SUFtbG5WWUZPRERJSGZyTmdIZzA4aUFpRUZ1cDRQMlZyNURJRjhNZEZxRDJa?=
 =?utf-8?B?QW5Demkyc0RPR0JUeHFZazZZdlo5bTRVeWNneUJxWnlOUUluTUdpUzVrRDI4?=
 =?utf-8?B?TnRUUExSUDhYL0hWV3BDdUQrdGs3Qjd2YWNidnBoT1czdFh4ZlUrWjdpQVh5?=
 =?utf-8?B?YjZrYnJVWTk3SUJmVi9RL0VDa2EyVTFHREdjUWp4enllTjVuSi9ITnFHSUlR?=
 =?utf-8?Q?PLhg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9270351-6617-4af0-b570-08dbbe51f1ef
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:32:16.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KdVboMSRhxVmqk9+JVR29FcvQrDApPs4tPzmC4p0EX8tKqsOCeQMWjwdO99+/hr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.09.23 um 06:33 schrieb Kelly Devilliv:
> On 2023-09-26 01:58, Christian König wrote:
>> Am 25.09.23 um 16:17 schrieb Kelly Devilliv:
>>> On 2023-09-25 19:16, Robin Murphy wrote:
>>>> On 2023-09-25 04:59, Kelly Devilliv wrote:
>>>>> Dear all,
>>>>>
>>>>> I am working on an ARM-V8 server with two gpu cards on it. Recently,
>>>>> I need
>>>>> to test pcie peer to peer communication between the two gpu cards,
>>>>> but the throughput is only 4GB/s.
>>>>> After I explored the gpu's kernel mode driver, I found it was using
>>>>> the dma_map_resource() API to map the peer device's MMIO space. The arm
>>>>> iommu driver then will hardcode a 'IOMMU_MMIO' prot in the later dma map:
>>>>>           static dma_addr_t iommu_dma_map_resource(struct device
>>>>> *dev,
>>>>> phys_addr_t phys,
>>>>>                                    size_t size, enum
>>>>> dma_data_direction
>>>>> dir, unsigned long attrs)
>>>>>            {
>>>>>                    return __iommu_dma_map(dev, phys, size,
>>>>>                                            dma_info_to_prot(dir,
>>>>> false,
>>>>> attrs) | IOMMU_MMIO,
>>>>>                                            dma_get_mask(dev));
>>>>>            }
>>>>>
>>>>> And that will finally set the 'ARM_LPAE_PTE_MEMATTR_DEV' attribute
>>>>> in PTE,
>>>>> which may have a negative impact on the performance of the pcie peer
>>>>> to peer transactions.
>>>>>            /*
>>>>>             * Note that this logic is structured to accommodate Mali LPAE
>>>>>             * having stage-1-like attributes but stage-2-like permissions.
>>>>>             */
>>>>>            if (data->iop.fmt == ARM_64_LPAE_S2 ||
>>>>>                data->iop.fmt == ARM_32_LPAE_S2) {
>>>>>                    if (prot & IOMMU_MMIO)
>>>>>                            pte |= ARM_LPAE_PTE_MEMATTR_DEV;
>>>>>                    else if (prot & IOMMU_CACHE)
>>>>>                            pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>>>>>                    else
>>>>>                            pte |= ARM_LPAE_PTE_MEMATTR_NC;
>>>>>            } else {
>>>>>                    if (prot & IOMMU_MMIO)
>>>>>                            pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
>>>>>                                    <<
>> ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>>                    else if (prot & IOMMU_CACHE)
>>>>>                            pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>>>>                                    <<
>> ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>>            }
>>>>>
>>>>> I tried to remove the 'IOMMU_MMIO' prot in the dma_map_resource()
>>>>> API
>>>>> and re-compile the linux kernel, the throughput then can be up to 28GB/s.
>>>>> Is there an elegant way to solve this issue without modifying the linux kernel?
>>>>> e.g., a substitution of dma_map_resource() API?
>>>> Not really. Other use-cases for dma_map_resource() include DMA
>>>> offload engines accessing FIFO registers, where allowing reordering,
>>>> write-gathering, etc. would be a terrible idea. Thus it needs to
>>>> assume a "safe" MMIO memory type, which on Arm means Device-nGnRE.
>>>>
>>>> However, the "proper" PCI peer-to-peer support under
>>>> CONFIG_PCI_P2PDMA ended up moving away from the
>> dma_map_resource()
>>>> approach anyway, and allows this kind of device memory to be treated
>>>> more like regular memory (via
>>>> ZONE_DEVICE) rather than arbitrary MMIO resources, so your best bet
>>>> would be to get the GPU driver converted over to using that.
>>> Thanks Robin.
>>> So your suggestion is we'd better work out a new implementation just
>>> as what it does under CONFIG_PCI_P2PDMA instead of just using the
>>> dma_map_resource() API?
>>>
>>> I have explored the GPU drivers from AMD, Nvidia and habanalabs, e.g.,
>>> and found they all using the dma_map_resource() API to map the peer
>>> device's bar address.
>>> If so, is it possible to be a common performance issue in PCI peer-to-peer
>>> scenario?
>> That's not an issue, but expected behavior.
>>
>> When you enable IOMMU every transaction needs to go through the root
>> complex for address translation and you completely lose the performance
>> benefit of PCIe P2P.
> Thanks Christian. That's true.
>
>> This is a hardware limitation and not really related to
>> dma_map_resource() in any way.
>>
> But when I removed the 'IOMMU_MMIO' prot in dma_map_resource(), the performace was significantly improved (from 4GB/s to 28GB/s), which was almost the same as what it can be when IOMMU disabled. So I guess in my common pci topology, what really matters may not be whether IOMMU is enabled or not, but in fact the attributes in dma mapping or ARM PTE does.

The key point is that nobody really supports that configuration, so you 
probably will find nobody looking into it.

BTW: ARM isn't really supported as a platform for amdgpu either. E.g. we 
have seen tons of boards which implement the PCIe standard incorrectly, 
if you run into any trouble with that you are pretty much on your own.

> I don't know if there is a way to make the memory attributes more configurable in order to be distinguished from the "safe" MMIO memory type, which on Arm means Device-nGnRE as Robin said.

Well we would need to extend dma_map_resource() to include some use case 
so that the mapping attributes don't need to be guessed.

Regards,
Christian.

>
> Sincerely,
> Kelly
>
>> Regards,
>> Christian.
>>
>>>> Thanks,
>>>> Robin.
>>>>
>>>>> Thank you!
>>>>>
>>>>> Platform info:
>>>>> Linux kernel version: 5.10
>>>>> PCIE GEN4 x16
>>>>>
>>>>> Sincerely,
>>>>> Kelly
>>>>>

