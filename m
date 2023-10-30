Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFA7DB32D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjJ3GVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjJ3GVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:21:30 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8169C;
        Sun, 29 Oct 2023 23:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSq+z239JhBexnCGQLaxuWAgHpiZ78U9tzmjRLw1Xq9vEia6iArzf++BPejuLFjhuW+AC997PmDBgmly/rfx1IBMKBfDGZ2NNhk1jdcGRRyHNp6vPCVKhKgv4DvbWWnHNe6wWZ8I0cwwkxcY5wTccEziaYsfNhYhwampmHFooPSgwydMGumW3UW2rjIeuBSa932RfaHoT278csnK0YdIYlav1ovSPDBto4jGzjFoigNR3/P5caWiCXPlmL5kgTj2V0WOvXIIFPK3i5bwdFiwfC0gNIieXcxMoWa5B4Q6fE2myq7ZQcxfZ32R7llHztLQzRDTYR90O0PiPQO8zNlwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEC3kG0rh3rcdPKSFcNNmuzpIgh3dy+3Kym4Jiu8dhw=;
 b=MnJypaRIn0ae7YSq7zPhSWZT3W2QtN13O96IMbsFa6FxqwiWfUOQyRi298/afxFIDql7NvULndfAHOlbMuF1HH5aRPA/cWJ71iG0OwH/D6dTeuDj2hJEGLwNjWqjeaF0FYNDdID5SYJ7vT5DewtUKcfQxrDxjmxqidtle/XMLRqDZlWeDFELvWGIhzXP8YSmi72bYVqz8UQKFHnBU7YcNuPrza3Y7jP1keEPT0FqfpFV0X/dHeQdMaDAn6ykYeta9jpXJa+eT8KRZ2zlqqZmuurcEDFVam2RAC0e6BrKssmqStGbHTJLrLuBCpMfu/CbcHR2UONAghy9n0cdCBPlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEC3kG0rh3rcdPKSFcNNmuzpIgh3dy+3Kym4Jiu8dhw=;
 b=qJ+8Gf07Ibgcr+Ppsds97yVxA6f0qUIE+hvPS9Fgg9YC0GcS37ls0Qvpqzg6C/kPhEuNy3P97vH/ZpcUjwl+Cb9eYCWCpCQ9JRKsRm3eRPj2NPTmremZAbUgg+gUgvI6fr7K2f8BC+dvYE+Mwoy2YVMXXzW1QySZKG8bFmUkEcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 06:21:24 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e%2]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 06:21:24 +0000
Message-ID: <f21143fb-91d2-4186-938e-0d147e32aa76@amd.com>
Date:   Mon, 30 Oct 2023 11:51:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared
 memory
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     john.allen@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jens.wiklander@linaro.org,
        jarkko.nikula@linux.intel.com, mario.limonciello@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
        Rijo-john.Thomas@amd.com, nimesh.easow@amd.com, ray.huang@amd.com,
        stefano.stabellini@amd.com
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
 <CAFA6WYPKXFftMzqJ4GnXT-zqu21_Jzn8aKti_wU-pQ4KpEVNrA@mail.gmail.com>
 <4a261870-03e0-49f8-b968-4cbcf646d9eb@amd.com>
 <b743d759-8f6b-b4f8-afc6-d8f11a5562ff@amd.com>
Content-Language: en-US
From:   "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <b743d759-8f6b-b4f8-afc6-d8f11a5562ff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d88522-9acf-494b-5200-08dbd910705c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v0YA9Me6HPRa6Z0jx4ESrE8SFBrcIhLNH+nADefmMXe40WytxJWYTcftbydzh6qxOy6Y6f/7r5jnTt4rs9QUIYepZB1FQPIPAyUttGTJrLQe63/hFmMLWB59j4otY6Rgjs/1h0HVKjuwpJK/mUg74b3u/iWFuB6Wk/fwjpZlKds4p24yGaplMqqmA7Iax0kfTj1EAbEHd7ayS5n+X5OnKA+eEsue9yBsD5xCsPy5p1lNoTFLAGvMJr35oUjnICmEonxgpGXwAbzJLAR5D3lTxXUlaUdYUpf8R5J1Y4+ryn0L4GcMsS4kB59X7aJ0apSsymmlbsKOmkuv/MCNxxf/42fSccwohb3yIS6tiuUiqe8cwRh2J1zSydnlOzMaUKwcbJRk+LFdZmZFJtJV4eQZItRX8MzGxbcuk4T5jXV3vv3dXAACyWSunoCLgtKiouGn3vvrMGscTRQCZJ4ijiiiUCxc3zzAsc1Z2aMVyXSH2msuh24yIH3nAnOhQUV26nujZ9woDDI+VxbEQzo8p1r9k+nTa5aqvqnakqgYs4PmKBOP12Awh3FvZk0QBwdt+zVY5Q2T2vaUtpTU78VxeKOxwmZ7VPMI7svkX+Yfhg2T+s5wnIDlGQ03j3fnPqQXTG/Z6wNDheBZHuY2GUWKrbzFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(83380400001)(26005)(38100700002)(2616005)(316002)(110136005)(66946007)(66556008)(66476007)(5660300002)(4326008)(8676002)(8936002)(53546011)(6666004)(41300700001)(6506007)(2906002)(6486002)(6512007)(478600001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVzREltUjRZZXB4dTFnRUY5dFZSMk8rWWJhT2kzQkRTZFRUdTgzVGkxdmVR?=
 =?utf-8?B?Zy9KRW8zeXFETmJ0ekhmTGQ0andsQWJjZmNnbUlYdjFXUTBMZVpIMlF4cDdy?=
 =?utf-8?B?aGNTQlFoamMxQTB3QUNuelljYXkyd2xuZlZHaEpFVWliWWRqVkZGcjErUHZm?=
 =?utf-8?B?VDFnWE9kSmhxcHpnUEZITUdJQVIvUHB6UXFSZXNoM3liRGlzL0JSeEhkUzRX?=
 =?utf-8?B?TkdPbE1MRGtUa210RHFDdXEweUUwb1haVWxLOCtFQkM3aEdDSkJDWmV3eDQ3?=
 =?utf-8?B?S2hvVmhwWnNkRld1YlA2NDJOR3B5MGNYcTI5ZzQzcGw2NjVJbk81djlybHdX?=
 =?utf-8?B?RURzTXBoNHJCa2ZpckR0bUw0QU5nSlV4dURZekpvVXVNS1l3SnVPeTR4N1VU?=
 =?utf-8?B?RndPMElDamVmMnhqNjRYQmlmemViODA0UThudWxGSjdsaXdnUGtUY1Q0L3px?=
 =?utf-8?B?S2lzOFBSemhJVHZROWZla2U0b2RUR3FjMTgvS04zeXc3OHpML2x2UFlsT08v?=
 =?utf-8?B?RFlodnJ6UlJXZDV4U1BBeHVUQmFCTFZ5SE5iV3FOQVRZZ3pKeloxc3FJYUNO?=
 =?utf-8?B?MTRuNjJyK2czMWdLRnRZdWRPV3VYSU95QUN1WThhVGJhcGhXODErcTNQaUJZ?=
 =?utf-8?B?WnNkZUhHQU0yUGt2a2p4S1ZEVy9Hb2Q2ZHF6Z2ZtWFdMQStpRGZHOVJBZXN6?=
 =?utf-8?B?cnNjVEQ1VVFDaVZUdWt4T1UvVW9ScWg2MHloMDZyUXRLRktGb3A4eWdCMldQ?=
 =?utf-8?B?RDkxTGlUYmRZTm9SWmFBQisxVjJrTWpUZFhyUWpvbndMY2dYQ3pKbG1QOVhX?=
 =?utf-8?B?dVNENGZsVGtZeVlRZE8zU3lrQW9oQ3RXYkFoV25oMFdXS2F4MStoeWlIZ0lK?=
 =?utf-8?B?U1VOZEhMVldjNi85Q0FEV2dyVVRRTUlDbW5NaFdteFAzUlIySDlHcUJkald4?=
 =?utf-8?B?VHlVUFhvb1h4TFN2NFlOd3dxbFAySGRkckMyaUxVWFFvbEtZdFp1NGlsa1Rj?=
 =?utf-8?B?Mk1JNVMrR1hJcWRXaGp3UnJXZ1ZQVCtoMzZpTmZlVDNjT2JMRE9PcDl0eUM1?=
 =?utf-8?B?UlBWYXRxWlJzQWg2c2pwQ2lxRFd0SThsVk9PRno3d0xhNzJvSnh1YXBSUVBs?=
 =?utf-8?B?bzltZjFxdEk2YnhxdlJFQ2RJc1JINVBCcllNYW5hRU9zM3l5eHFlaTlaU3FO?=
 =?utf-8?B?aitxTWI5Tm9xMXBRNFNiZ3FZeXQ1dkRxT2F2Y2tFWW9IZVFuYTJTVyt4TG8v?=
 =?utf-8?B?c0t2c2lmamRRMGxvQ3ErTjE4NU1zMW1Sc3dNeWJOeGp2Q3lQSWZxSFloeVEz?=
 =?utf-8?B?b0R0c1ArSHlyeXJrajArVkphNlpydFJXSGhuT1FFSzlRYk5PeEhGbENSa1Bo?=
 =?utf-8?B?SUJ3a25EQ00zNTFEbHJZZndRZUNRRVlEUlRmREpxUTdTL0xNb2pYa2wrRDZx?=
 =?utf-8?B?THZDUWc3RENKaDFjVTdJdVU1cUdxZVAzU2VXSVRVeDZ5Ym1LTVdMaVJHSEdR?=
 =?utf-8?B?NEwzTzhDTW9hNFRZeFVGeHhwUVFqL3VBZWpTVHZCbWF1M1c3OVUyek5YRUll?=
 =?utf-8?B?WVVSeDgzcGNUUFZjOUUxWDhMdU9SelRBZW9ySzdHRDFCd0NSTVRrOVNGWDFl?=
 =?utf-8?B?dDNXRlBDeUFGb2dyMkdYdFI2Y09xd09WdHlmYkl1NkVkend2eEVnK1Z5UHNk?=
 =?utf-8?B?K244cUFHT1ltUXQ4cnJjN25yVmx3TGI3UkFyRXY4V3FTQmJCUEJ3YXdFOHo5?=
 =?utf-8?B?OHVlKzFURlA4bGlCUVN4cENJakZmMEhMZnFhbGNHRXk4UzBmVXpwS3YxQmgr?=
 =?utf-8?B?UURXMGpzRFNQQVV6VlJISEkreDJFN2lSWFpDQlJuT1lqN1lwLzdyNjNXZFBK?=
 =?utf-8?B?QmJINDFlS040QkRza2JMNzBaZlNIa1VUdTQ0cHFLRjl6RmwySEpCUmZCLzBJ?=
 =?utf-8?B?RVdJbnJubURSaXNYOWdFMmRYaHRjUGg4R1RKbmY2UFlpR0g1QUJib1BTd2lq?=
 =?utf-8?B?QjkwZENmdWZCSjlxdzhDajVIWWRUVStrM3lnVkd0UC9TLzE3T2krZUlSRFZy?=
 =?utf-8?B?VDVVTm1aMHBtRzNRMlN1QU9BZG91SG96Nmh4d2kxdTNLNGdIN2g3OERXTklU?=
 =?utf-8?Q?MQeCLn5kQAo0bmMkduVmx2TYb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d88522-9acf-494b-5200-08dbd910705c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:21:23.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCG2kTTg/XpXUOmqIJGXM9+cRtPPy9x202Cx/mVbauavXLQXyEP6p1LrN79rFfmaHtGzv71dkvth8q8XP6maAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 26-Oct-23 8:23 PM, Tom Lendacky wrote:
> On 10/26/23 05:30, NK, JESHWANTHKUMAR wrote:
>>
>> On 25-Oct-23 7:01 PM, Sumit Garg wrote:
>>> Hi Jeshwank,
>>>
>>> On Wed, 25 Oct 2023 at 12:27, jeshwank <JESHWANTHKUMAR.NK@amd.com> 
>>> wrote:
>>>> From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>
>>>>
>>>> At present, the shared memory for TEE ring buffer, command buffer and
>>>> data buffer is allocated using get_free_pages(). The driver shares the
>>>> physical address of these buffers with PSP so that it can be mapped by
>>>> the Trusted OS.
>>>>
>>>> In this patch series we have replaced get_free_pages() with
>>>> dma_alloc_coherent() to allocate shared memory to cleanup the existing
>>>> allocation method.
>>> Thanks for putting this together but I can't find the reasoning behind
>>> this change neither in this commit message and nor in the patch
>>> descriptions. Care to explain why?
>>>
>>> -Sumit
>> Hi Sumit,
>>
>> We see that there is an advantage in using dma_alloc_coherent() over 
>> get_free_pages(). The dma-ops associated with PSP PCIe device can be 
>> overridden. This capability will be helpful when we enable 
>> virtualization support. We plan to post a virtualization related 
>> patch in future.
>
> To be specific, you are referring to Xen virtualization support, 
> correct? Because I don't see how this works in a Qemu/KVM environment 
> where you would get a GPA and not an SPA.

The patch is not specific to Xen. We have verified it in Qemu/KVM and 
Xen PV mode. Support for Xen PVH mode will be added as a separate patch.

>
> If that is the case, you should clearly specify that. Also, this looks 
> like it should be introduced with the virtualization support that you 
> submit in the future and not before.

I will update the commit message in the next version of the patch series 
to include these details.

> Thanks,
> Tom
>
>>
>> Regards,
>>
>> Jeshwanth
>>
>>>
>>>> Rijo Thomas (3):
>>>>    crypto: ccp - Add function to allocate and free memory using DMA 
>>>> APIs
>>>>    crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>>>    tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>>>
>>>>   drivers/crypto/ccp/psp-dev.c        |   3 +
>>>>   drivers/crypto/ccp/tee-dev.c        | 119 
>>>> ++++++++++++++++++----------
>>>>   drivers/crypto/ccp/tee-dev.h        |  11 +--
>>>>   drivers/tee/amdtee/amdtee_private.h |  18 ++---
>>>>   drivers/tee/amdtee/call.c           |  74 ++++++++---------
>>>>   drivers/tee/amdtee/core.c           |  72 ++++++++++-------
>>>>   drivers/tee/amdtee/shm_pool.c       |  21 ++---
>>>>   include/linux/psp-tee.h             |  47 +++++++++++
>>>>   8 files changed, 221 insertions(+), 144 deletions(-)
>>>>
>>>> -- 
>>>> 2.25.1
>>>>
