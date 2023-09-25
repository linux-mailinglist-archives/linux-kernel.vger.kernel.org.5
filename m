Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE937ADE35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjIYR6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYR6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:58:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13890
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEEN+UkWlcZb6R/sA2MZ9mF2AZHWlSj+dWTekHlQvBn5gLIxJZrDcCF0tZurGF2fpBHKLUmY7JVjOB1cpJo1O0943vyrYP2v9dN2K2UjKJYXODE3appbJwb24we5ZY+KkOTjpKSwYv9gyHO798OOcwDJA9XB0wJVRHw3UTmq1Bl4E/p42vdht38+WLVQmxtYXKXxnsshLDyNF/6a8ygaFI2Nxz3i36RtjfMrH0OfiZYqHZyZjAZfcJ+jTKzLE1SmM39JgTkmWHMQCAY2MZJNm4+AvyBld4FJeSiWgaCcWGbnaMBg2nGy6/cJerkZysXrgD2wMoX0vRNBRNN5vmttUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPDlI7KANjJAAHmpIwmqTn2V43Uh83REtLN6tKddHqA=;
 b=IZJ53Or7tJRZA2OR0f/TFQbUG4PgjPR+gRSDkX1N8oVt7V7DPWJX6/Fo5/Vo4DKZaYwTNGUZzBBT9FyUB28rwelaVUIz7/g2tOkCw34M3MezHVrmkUb4NhvD7h5h0iajyuRy7jzvIF3udXg4mtc7sWIXNs2Bbx4IkDuAG/RQXBHMIHjxN6/00Z6mtrpIbxnyGrP3J3H80xyEKwkPAEa+1mpnTxE4FZ+oYpm1hv3/2SH24wLoC9Vn/zLI7KT+WUn3LlM9WyM55qA0k1YhQVXWtQKY7ncPCrS5zrCQOMUeC2Xls9CClIELItizDtZP8/4C33ykI873AXoThaYy9IYwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPDlI7KANjJAAHmpIwmqTn2V43Uh83REtLN6tKddHqA=;
 b=eBLqatUi7Go6JmV+sRHAJZewklmSUxWOv4j3hKfbTt2zLo9M0+tBaDtfMDu9eVF//rGkpWJFJ5AM2V+b2CT3DHznoFRZah6ioc1NJPMzz9RlCkWANEY0c6auRvWmiIMP7PLTbfcRuQlokLXuB+wWgjAssxjtZ431hxczZFQZTac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 17:58:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 17:58:35 +0000
Message-ID: <39dff6ed-2fc1-0462-0317-9d1e4c1c718e@amd.com>
Date:   Mon, 25 Sep 2023 19:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Content-Language: en-US
To:     Kelly Devilliv <kelly.devilliv@outlook.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TY2PR0101MB31361E2EE3391EBFAB78014B84FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <TY2PR0101MB31361E2EE3391EBFAB78014B84FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 632d27fc-81ac-46bd-1ebf-08dbbdf10a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uMEk8e++7ik9E/WxDHZJO3HtHJ9qdqGJ0/cjVn7rbErnR7uM3d+nnn91rY4PTotFdnwbkwBBhJZyCbC+45rsCJpUEZr0XQkAFU9C7Kl0MGzAa80wxLOGM5kHQ1fxQgW9za+icZSA9JMQ1WByPB6sJRLlsJV97OuOHQZLwBZQ8haa9zHQ1/z6iqzAIrZlSvh2q/3O6JMHQO8KmDsPE0BmhyWoBLq0WdCABqBGa2c6hHp/xEe64tmvZXFL7Ta4fHYQwWvnfBkJFlYNr14f/2XjyCRGI3FmHA0lu4MJqB6KRgfyodSmaXPUxhslBleOJzFcFeGVyTixsFGSAcmA6ITFKH/iji5aWTkUTQ0Fi2MOMoedoWhAFKkpFD759RwZ+cXz40DywaJpkMUka54Bh6IHF7WAq83RB5fKeRsn1YVuMoE70tHXxT75ozz6g8ITF6PFJ+ozF8EUfzOBQ0jsH64+mvfjSGFr1b8qgtagmVHqffzDIOx4/hCYUSb7YL6A+Q4R9RcI56D3irMmKZq0VXHRF1ozH6GoAtxIs1Gm2QJe9HB8GLTKETbZIn18esmyjyJzRVW1AvkLH6a8a9mTKFpvyvR6yP6GYv7o/CzdZO8QETt3YaR4mun+YRbeq7qKvWwMz7cMnt6FquM0v3GbRZZxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(38100700002)(110136005)(53546011)(66476007)(66556008)(6666004)(2616005)(66946007)(26005)(6486002)(54906003)(83380400001)(41300700001)(6512007)(316002)(6506007)(8676002)(4326008)(8936002)(478600001)(86362001)(2906002)(31696002)(5660300002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZ4OTBhSjNXeldkall4c1R6Qk9LSXd0R2tQZmluZTk1dmREdUlIZTl2elEr?=
 =?utf-8?B?NXBlRjY0eWZFYjJsb3hJczZXL1RmWFY3M29JUVhHK0NEQlF2c0NzUFE1MTZx?=
 =?utf-8?B?Y3dlS29xZXpwWG9PcE95SFN6WHcwYmJtbnF5cnJiT2ppVXVlR1VPWFQxeHpq?=
 =?utf-8?B?V1hHdWFxQWk1cDlOcFNtczRyR0dtMVA5UHlIQ1kvcXg3aGhpRkRRT2cyU2pF?=
 =?utf-8?B?b0FaVjdpZmJIZFpQaDVENXMvOWYyMG1PeStLTHZpZ1E4WjJKYytneVl2TnN5?=
 =?utf-8?B?VjdpMVVITEVMVEtJTkNmUUlnaitYTlpXR1d2NS81VDgvUUpzQW9pVE9qejh4?=
 =?utf-8?B?NWhmNloxT3BuTEtNa3d0OFNaZHBvdTY5ZU11cEczbTNiOW5nQWpwVzV5eStK?=
 =?utf-8?B?Zjd2NXYzNW1wS2ZsOTluRlJ3Ymh4S283UzJzVG53cDBpd3lOZXQ1WWhRa3Zx?=
 =?utf-8?B?cjRlenJsaU9zZzBMdnJZQzhXZ25aa3lkN3FJMHVIWkdNSXpUTHdtUUxEOWg1?=
 =?utf-8?B?WGdXU2Ftc3lkZTF0bTZjWTRJOHFlUEpzQm1JVnl0Z0FiMFIrUXVmMWlBQjlO?=
 =?utf-8?B?LzRxR00wdjhaOGlHR2pValdJSDFNRnpFWjZ1cGU5eTFOdWNnUEN3eU1FRmpP?=
 =?utf-8?B?aElhUmZKMGNpcXdqbURkMTJNMXhsK2N4c2lVV1QwYU0rU3BFY0xSM1poSXdt?=
 =?utf-8?B?cFpKZy9jTXFtamI3WG1lM0RXMDlIVnIxbmJGV0RQU1lscmwzUUZPdlQrWkp3?=
 =?utf-8?B?T3hEcGJhZUx1cUFOdy9IQXNGYU0xSDdjbkJBQ3ZoaGhad0pJSW9LbUYxRFdn?=
 =?utf-8?B?Yk5xRU5zSGR1bWx4aklRN1dZb3RUYVBjTjlaMDRSZmRnS3dVQlArK0pWV0pn?=
 =?utf-8?B?Rmk4TG4wZVh3T2xPOU5sMm1NMjkrVitJaUlDaEZSSTVWZ0tjWWZXMFZYUnlE?=
 =?utf-8?B?bVMzZWZJMzZVZWpiai9sNERZZWdQTkxGWjJvekFoR3dZSlpSb0R0ZU40VU1L?=
 =?utf-8?B?MTdlWVhaVXduZzJKbmsrTnpMZWd0V3R5STlJRC9PbGV0MzRtQlJjQnZ5UlZk?=
 =?utf-8?B?OHVFa0RaRjBUN0k1VnJsZ3RkODNXcnN0NmJmcTZiNEZKeG9uK3FKMXRyWGtQ?=
 =?utf-8?B?N0JDWVpiYzA5NkxJMmhLNHpBenhxQk5XNDFudmFsREN3aVpWb29IbE0rS0RP?=
 =?utf-8?B?SUl4SzY0N2ZnMVJnZmZvelVrazdpK29EaGNYUExyYitvRTVXUzRuSHlBaUVF?=
 =?utf-8?B?bnY5b2VVMEIybUlBM2pJcFNCZWdRaEFvclk4M3hTMkxnNkE1b1FabStiZS9w?=
 =?utf-8?B?b2RlaTJWQVJ4cDNXcFg5dWVnK3l3ZXpxbVorRVJvVWtIUEdVOWJIR1BWNDdK?=
 =?utf-8?B?RDAwaVJudHBCbEkzWnBjanZyQ050TWVOWVhDM0FwT2hQVTNDeENXQ2RCN25I?=
 =?utf-8?B?a1JTZVdUaS9iL2hlWkFid3hXb05TekZUSHd4Lzk1SERUbS84NUlRWStDMnlr?=
 =?utf-8?B?aHQ1czh3UWRtem1wVmRsUXh5aG40eWVIbGJuYnBIRlg5TjJMWGh5UERDRVZP?=
 =?utf-8?B?YUFXS0ptK1NiOFJKcnYzYVhudzJBTlArUDB3Rm5mdDFiTlRJK1U5QlhLOERL?=
 =?utf-8?B?dVkwaGQyU2wzQXg3NWtDOGFoWGFodWxBUEYxbHZodWxxRmxBc3VGbTVCMWlI?=
 =?utf-8?B?MjdCVzVXNlhLTmhTd1IvVHRsQkhZRDZDSUIyaURSQWxPZ3JFWkFGeml0Q3Zh?=
 =?utf-8?B?bTBZVlVIelJ5RTZLeXVMWGdtZ3lZOEMyYWRGU0FxWFM5SXpraGZJRXl3bFJt?=
 =?utf-8?B?djlnRkNrM0FjK0lyNkN2YktTK3h6THUvOURjN2ppc2FOTUpOcWY0SjRFU2Z1?=
 =?utf-8?B?clkxSC9DNFZFQkh6Q3VTd2hJTGwxYm1mOEtNdXJiWG4rSzBoWGszVDVaZi94?=
 =?utf-8?B?d1gwSlRJeGdtdXpXanlUZmZDdHp0OEpzQjRDWm42emxOUVZ4Z2szZFlHODhy?=
 =?utf-8?B?YTlvTVhQUUdlNk00V2JyTXdrZTc0SGpCM1BSOElPeTBPeW5wem5McktyTCt5?=
 =?utf-8?B?TjByVjJFbGkxMktGUDBsMmIySzlETEhTdDJVNEhLaENmeTJlYnhLSCs3Ty9o?=
 =?utf-8?Q?Ou+vaX/fcYsUQQLumOwBZnkFh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632d27fc-81ac-46bd-1ebf-08dbbdf10a1e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:58:35.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBmXYdOEm0CF33Vf4qXl1cuQ5cSICOacl9tz5EohM6UcItBKwYVTPoFkoiI6VUxa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.09.23 um 16:17 schrieb Kelly Devilliv:
>> On 2023-09-25 04:59, Kelly Devilliv wrote:
>>> Dear all,
>>>
>>> I am working on an ARM-V8 server with two gpu cards on it. Recently, I need
>> to test pcie peer to peer communication between the two gpu cards, but the
>> throughput is only 4GB/s.
>>> After I explored the gpu's kernel mode driver, I found it was using the
>> dma_map_resource() API to map the peer device's MMIO space. The arm
>> iommu driver then will hardcode a 'IOMMU_MMIO' prot in the later dma map:
>>>          static dma_addr_t iommu_dma_map_resource(struct device *dev,
>> phys_addr_t phys,
>>>                                   size_t size, enum dma_data_direction
>> dir, unsigned long attrs)
>>>           {
>>>                   return __iommu_dma_map(dev, phys, size,
>>>                                           dma_info_to_prot(dir, false,
>> attrs) | IOMMU_MMIO,
>>>                                           dma_get_mask(dev));
>>>           }
>>>
>>> And that will finally set the 'ARM_LPAE_PTE_MEMATTR_DEV' attribute in PTE,
>> which may have a negative impact on the performance of the pcie peer to peer
>> transactions.
>>>           /*
>>>            * Note that this logic is structured to accommodate Mali LPAE
>>>            * having stage-1-like attributes but stage-2-like permissions.
>>>            */
>>>           if (data->iop.fmt == ARM_64_LPAE_S2 ||
>>>               data->iop.fmt == ARM_32_LPAE_S2) {
>>>                   if (prot & IOMMU_MMIO)
>>>                           pte |= ARM_LPAE_PTE_MEMATTR_DEV;
>>>                   else if (prot & IOMMU_CACHE)
>>>                           pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>>>                   else
>>>                           pte |= ARM_LPAE_PTE_MEMATTR_NC;
>>>           } else {
>>>                   if (prot & IOMMU_MMIO)
>>>                           pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
>>>                                   << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>                   else if (prot & IOMMU_CACHE)
>>>                           pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>>                                   << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>           }
>>>
>>> I tried to remove the 'IOMMU_MMIO' prot in the dma_map_resource() API
>> and re-compile the linux kernel, the throughput then can be up to 28GB/s.
>>> Is there an elegant way to solve this issue without modifying the linux kernel?
>> e.g., a substitution of dma_map_resource() API?
>>
>> Not really. Other use-cases for dma_map_resource() include DMA offload
>> engines accessing FIFO registers, where allowing reordering, write-gathering,
>> etc. would be a terrible idea. Thus it needs to assume a "safe" MMIO memory
>> type, which on Arm means Device-nGnRE.
>>
>> However, the "proper" PCI peer-to-peer support under CONFIG_PCI_P2PDMA
>> ended up moving away from the dma_map_resource() approach anyway, and
>> allows this kind of device memory to be treated more like regular memory (via
>> ZONE_DEVICE) rather than arbitrary MMIO resources, so your best bet would
>> be to get the GPU driver converted over to using that.
> Thanks Robin.
> So your suggestion is we'd better work out a new implementation just as what it
> does under CONFIG_PCI_P2PDMA instead of just using the dma_map_resource()
> API?
>
> I have explored the GPU drivers from AMD, Nvidia and habanalabs, e.g., and found
> they all using the dma_map_resource() API to map the peer device's bar address.
> If so, is it possible to be a common performance issue in PCI peer-to-peer scenario?

That's not an issue, but expected behavior.

When you enable IOMMU every transaction needs to go through the root 
complex for address translation and you completely lose the performance 
benefit of PCIe P2P.

This is a hardware limitation and not really related to 
dma_map_resource() in any way.

Regards,
Christian.

>
>> Thanks,
>> Robin.
>>
>>> Thank you!
>>>
>>> Platform info:
>>> Linux kernel version: 5.10
>>> PCIE GEN4 x16
>>>
>>> Sincerely,
>>> Kelly
>>>

