Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8310F7D9A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjJ0NgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjJ0Nft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:35:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8017AD6F;
        Fri, 27 Oct 2023 06:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksw/cxhu88UxI7RS632Ix3d4I0TtJnCii3cvfNBjugv2H5I6ENXuPr0pJMvgM68XNVYvzB/FrVtWfxTeUO3eTN2WqivoN6GWGXwdZUfqpDd06VW5AJQpBbKkoWOxFndco1PqSAj7hf4KQypKbncwJNwI/sVO0rg/xv1/Cxn4DleOOu5ifZ7NVCJCCzhsnm5NxPTHWSf6KDkYgdToeU4ZvtKyWmwgStACP7RA61YzYhNmebf/yfBd909CiF3niXZPmNqhL3CAuCSDPLQglB+vWVRHGdR20phQQItptARlbRd4oav7ostzUMLT0EWVRCcmn/faPfpK5jsS1uX4HewHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjeuTRIgz7UTs/9IQgWogw4RwLRprK8MGq6rWQmRkd8=;
 b=U6bwaPJ0BURSZsE83YyZLTf3sMFVLiU6ak03xFoSRICCjQxPpwavsLAQWcfesabSqL8XyOU2mpxuhwpTUjmu97ezDZXuoYswP6Fec3ngL+CKbmqTKTfDrFsvu6WwtRa4SwSYC8LzyTxEEVnVn0S3enFWBQoTEZjRHFrMqvRVH7obSmZo8YRCkuj+MwzyTCChUyxGMZeMPLvcVNXHCGz63YH01SdEoezulAEdlIlNeGBCLaMFpT7Ghcr/go0b+P74UeWuQ180E6hFui1Lozf6MBeo4zRZqnI873SS7arBeMIvFagdAjqhFniZ2JxMaGNU3Lm5RF+fROEB5yiMBoJ4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjeuTRIgz7UTs/9IQgWogw4RwLRprK8MGq6rWQmRkd8=;
 b=L+/jfT0ph+EnE8aam6ykMUXonIiAb6gjtBDj3HAO2opUaCsXsXM1JP+wERxomyYu0Wc2bcm0Hu3rx/9DJn5sSL+/ruPpFs3GMc4Jbwj4vvGY6X/7PD5mXBWsljBOpXyLZaDMJ7mNpHbix5eGAK00YYItKiVUabVuCT43d9ywYYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 13:35:23 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e%2]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 13:35:22 +0000
Message-ID: <94059f5c-10dd-4d75-a69c-76b21ff49546@amd.com>
Date:   Fri, 27 Oct 2023 19:05:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: ccp - Add function to allocate and free
 memory using DMA APIs
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jens.wiklander@linaro.org, sumit.garg@linaro.org,
        jarkko.nikula@linux.intel.com, mario.limonciello@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
        Rijo-john.Thomas@amd.com, nimesh.easow@amd.com
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
 <20231025065700.1556152-2-JESHWANTHKUMAR.NK@amd.com>
 <ZTtJdU5a/P4kg/Ss@infradead.org>
From:   "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <ZTtJdU5a/P4kg/Ss@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::20) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eaf54b2-e79a-4ded-688d-08dbd6f191ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxcdRdqus47etqK83lZOnxW33uQ2Lgry83TU0O3Bqj3gfP1E+fgXUuS8gOGH8/X0ZPwwfMnTNOD9ZazPgiMrxD3XVeGsYm+G+893kPIl86MBjtxwLrwybszyKC7YkyraF9sXtEs/ZwGxmyQAHtmGSkJ9/xVX3yotdStIR3pbB3n+e6DpMpGsq6UCx8kfv7d7bJGyHK7NoRdeVk9fEylhsYoE7rYXb2b3fVTC+VLXOpc+UeVraa5/sFuuK5HJl3jWiDnbw58R/aeZo2f56nsNgZjhlt1f2SUcY5BBp+Bgq0eIrYxzi1uRUJi6K5bGovi4pUf0v/00ce32/03fnqF+BNi2lzMDiVAIVNc2OYfoSILK88/FbuOY6WRXpA66R9PmjYLT1Bcz5lQwXC9MjNNhPA1JV9uD+APgthZoWpdcMzzW/iefqVaqaXBpb2/5hmDgSsvQM0TWfGUcqonMu+IEZbcSZhiyxIUqETcgpaOdniYUijAHcrKKHsTwfiTGy7NWv47LfJt7MfluETzqR3t6lTvfGvkqtveYWWSr0as3/5ugW26jVl2kOCACBf0denplWsdK5KjYXMjP/b8OSbFjuXeYJu/6S/Dt+Qx/mvcESo/kgKsvEgeJ6bDtvxw2DwSyLvu4dCwTJDZw025GC4/cAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(41300700001)(5660300002)(6486002)(26005)(8676002)(966005)(8936002)(4326008)(478600001)(66556008)(66476007)(316002)(6916009)(66946007)(36756003)(6506007)(53546011)(6666004)(86362001)(38100700002)(2906002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjdrNCsvV3d3MVY2NEZZZ0dIWms4aGdJb2tRMmxHbUM4d1pJL2ZKT2w3dndj?=
 =?utf-8?B?bGM2eTNWSjFWTXlIZHNFMURvSVRhSmVURTVPTE1ibjVOR0F5QWVRZ3ZDelAr?=
 =?utf-8?B?cDdCK09FRkJnRzhlblpKUzgxTXlCTVRuNERwRmovQnB5VXRJRTlrZ3ZwajBH?=
 =?utf-8?B?K3hXRzJ2dTkzS05LNi9LdEpoK2hpeHk4ZWwvNzlra1NIdURyd00vZmxVcUhr?=
 =?utf-8?B?SjJnUDRoSStpN0QxbCtzOGl4Y3pZMWtGeGlwc0g1Z0x4eVJxMWVlWXBNUFQ2?=
 =?utf-8?B?K09nQ0l1WmxaRzgxV3BpVEJENnN0SXhld2EzNVBkY0NUek5xcU5ERU83RU4x?=
 =?utf-8?B?UzJ3ejdWbkpJdGFBT1BQVUpYRGdVOHJmWFdFUGdzeTYrbFhQNWIrYmpodnRj?=
 =?utf-8?B?NG14NXNTNzQvbFhhTjlRT1pEcTM1dW81LzRVWFcyMWQzMDhYbzRVWnlOTWUy?=
 =?utf-8?B?Mmg0d0pzK1hIc1RxVWIyN0JyVFdVZDRpc1p1NThrZ2JpTGYvdjB1aVZQSktn?=
 =?utf-8?B?V3B6dDBjQ24rN1FKUWIvZlJkVko4b1JOd282ajVwRTllanJpTVBkdzd4Nitv?=
 =?utf-8?B?QzBpQi9DNENUMTNTcExaL00wbGp3VENZbENTOGxsMEgxREdSNlBqTndEUHAw?=
 =?utf-8?B?azNPS08ra25DYVozYkRwSzVZYnAxaXp1cnM4emU4ek9ReTlXbmZLT1BMTzRz?=
 =?utf-8?B?NGFaaExIREVrbXc2dklzQksyc0REN0w0WjAvbGJHZFZDTHBFanRDcWVWZjB3?=
 =?utf-8?B?bkZpQitzRVdleU5IdFRtUFUvcklRV2doS1NnV1cxakM5MjlZNkFqNFNTdG94?=
 =?utf-8?B?dWFYYjV0UVlaaG9wZGllUHJha3UrNGtxM3pGMTAxNHZXWFBGUzlXTFBpTENr?=
 =?utf-8?B?RmtVNDI3V1VUZU1FY1BZcjVJZDRjK1ZrVjBaZkhYU3I5MGNpeDgxc3VOMzk4?=
 =?utf-8?B?MEZVWENPenRVdmJrcEYwU0JONzQrSmFKaGdrb0ZCNEZ3aFZwSnpwZlpTVzZr?=
 =?utf-8?B?RTExWDZPVGpKaFFCTXlKNkFUYXQ5K091M1Q0SWFNR3dqSS8xcFYrUjhkTU82?=
 =?utf-8?B?ZnQxcHpuTjIweTdnR3JaV0Q3bytMVERzdFFWZVp5QXhxRWprMGwwMmtkcjVr?=
 =?utf-8?B?d2FPVWxBU0dqYktoMXJUQ2doK1pwd3IwQVE2NkdqdzR3N3paN2FEOXRsSjJB?=
 =?utf-8?B?RDRKbndobTNUKzZ4dlM2ODdsbUxoR205Y1RyOVh4SHp4VXh0RHBMZkZ2U0Nr?=
 =?utf-8?B?eEp1R2hDOEFqaTBlZk40M3pCM3BoUWluUXF2REVVVVd2TFFTYmpTajdIdUVl?=
 =?utf-8?B?Sk5yblNKOXFhdW1MRHk0UVlWc0J0OURFYm1PeWt1UTNjMWZIZXh3bFhGTFhj?=
 =?utf-8?B?SkQ2NTA3WmVOb1VDNW9qZG5rM1RkZ20rMS9hZmo5emUvRW9xNU9UUFBpYmZq?=
 =?utf-8?B?UmNkUjdVVmZiWXJmNDNGYU9QdFZjWXc1WEtpUE9BV3p1VllYUVJQcklkK0lz?=
 =?utf-8?B?T0RodDdLN1BERDd2ZzlER29XSHkvUzFKdlVwZUxPdkp4T3ZUa3owNVpDUUJj?=
 =?utf-8?B?SW1jYVI1c3lFQVk1ZE4xelNSUlNnTThra1RKd0V3NjJLZkdTQ003RjBIbUl1?=
 =?utf-8?B?UGZkbk9YclRnZXBCZWlnRFZ0ZDZEbkFDZGdxcUVZNWx0REhRRkdTdDUzcWJa?=
 =?utf-8?B?c3ZOMWt1S0tlTHgzd1BSekNaSC94VzFWZzRlSU9LeW1DZ1FlYTMxQ0dCcUJO?=
 =?utf-8?B?ZGUzSWlHTHh4WFpvK2JER3J6NWRGNjZPdW11S1gyNHowQlVmOVNkQTZEU2Rz?=
 =?utf-8?B?ektMeks0Wk5FQ0FKRTVxNE1oUkRNMkFRSjR1ekZxYmtIaldsamJST3YwVmtq?=
 =?utf-8?B?ZXNMYnFEMmIzdktWVHpid1VlNU9JMFdyT2NIS2t4S0dmQ2xrMHFwbnpBNkJh?=
 =?utf-8?B?aFlZMEVaNVhvWUV3eXEvRnVjNXBlYnVPdTUvMThCSnBscy8zcWpveWorcWps?=
 =?utf-8?B?RlpMWjhieFNsY0ROMXhnVEErZzlwU25Ud2Jja09HVVExY1lxY2NRWlkrVzB5?=
 =?utf-8?B?cDdTeUxNU2h4TjZjdDMwME9mZjNYTGM2cW90aU00VEVpNElETEI4Tk1NMUhs?=
 =?utf-8?Q?WtXnpnERyhhIknZc651YJas3J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaf54b2-e79a-4ded-688d-08dbd6f191ac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:35:22.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d2v3A7NpxHhFDDpDc0sC3wq77GKjCny8L2lijq9Tir1UtjHDVTLH1X9krRCQnccg9GZb0UKEnbQAJWrD1dZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27-Oct-23 10:54 AM, Christoph Hellwig wrote:
> On Wed, Oct 25, 2023 at 12:26:58PM +0530, jeshwank wrote:
>> +	tee_buf->vaddr = dma_alloc_coherent(psp->dev, size, &tee_buf->dma, gfp);
>> +	if (!tee_buf->vaddr || !tee_buf->dma) {
>> +		kfree(tee_buf);
>> +		return NULL;
>> +	}
>> +
>> +	tee_buf->size = size;
>> +
>> +	/* Check whether IOMMU is present. If present, translate IOVA
>> +	 * to physical address, else the dma handle is the physical
>> +	 * address.
>> +	 */
>> +	dom = iommu_get_domain_for_dev(psp->dev);
>> +	if (dom)
>> +		tee_buf->paddr = iommu_iova_to_phys(dom, tee_buf->dma);
>> +	else
> No, you can't mix the DMA API and iommu API.  You need to stick to one
> or the other.

Can you please elaborate a bit more? Is it because in the presence of IOMMU,
a contiguous DMA or bus-address-space "buffer" may be mapped non-contiguously
into the physical address space? As a result, for buffers larger than a page
size, when PSP tries to map the physical address into it's address space, the
PSP Trusted OS will not be able to read back the entire buffer data.

                CPU                  CPU                  Bus
              Virtual              Physical             Address
              Address              Address               Space
               Space                Space

             +-------+             +------+             +------+
             |       |             |MMIO  |   Offset    |      |
             |       |  Virtual    |Space |   applied   |      |
           C +-------+ --------> B +------+ ----------> +------+ A
             |       |  mapping    |      |   by host   |      |
   +-----+   |       |             |      |   bridge    |      |   +--------+
   |     |   |       |             +------+             |      |   |        |
   | CPU |   |       |             | RAM  |             |      |   | Device |
   |     |   |       |             |      |             |      |   |        |
   +-----+   +-------+             +------+             +------+   +--------+
             |       |  Virtual    |Buffer|   Mapping   |      |
           X +-------+ --------> Y +------+ <---------- +------+ Z
             |       |  mapping    | RAM  |   by IOMMU
             |       |             |      |
             |       |             |      |
             +-------+             +------+

Reference diagram from: 
https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt


Regards,

Jeshwanth

>
