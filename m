Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1E805E34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjLES6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjLES6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:58:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A082CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G260DgDbTxO9mmUYPRKtNNgMD5Wk5zQmYgaPU+adxQ5dqvFQzC4eqZY98Q6VPgqeiU8Ih5L7+MoqlosmoPeqtgz30umqiHq7jem8iI2xK/f5pCTWuoxgbXWfDABRUOAGfFcYMdf+qO+iO7HDxLoXcdIcm7Ic7ndlW8XJ2Ygl2Xj3A9s8EOrBFO7UGj5N6Ui9v+ewIY6BhUKD9WZhN8kVuJWYqpNnB5P3Ky37IiiYKD5BS75pPCtx95JmsdqRyy5M5tgWrNm4WCtIaX1iYXEB9wYg1DW0iWDLNnoIJPrUkRbVSIFeskFnNRJi/fF3w0yMCs2SpTlcrTuH0n+VSWhbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Moyr0BBSubRZHz4tbo+QnxBxO1tqKfmp5dUBN6FPM0k=;
 b=mUAW3Ixvux7BgWGpuILcK/bWUIccz7MJtwDFTCfh+gk83ivQfqgnK2ITfA6abyAeEZmN+GfwvDKvCTK3UQOVBmpw/mDGThzaihjw7HAR51F44CoZ2uoF5W5BzKDvMgpYtLjq13a/ucREJUITjpx1RecBzZemmbQfOx+DNuam+OmL5fNxbMMMnyJJG/SyXpPxCzfJxCFdVT7de6SNzRAcdeSHxmW2Ju/AOsQkCJTFLLNwTD0cQ8uAo8V4iTyBP8o0HEBlzZ0KHFaLVeYZYe8K7msfNxAG5bFEb0cndCiqHwfwkZAmHBd1p1xRm1uRlI2SG5GyKXGTudFRLqvrhJjM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Moyr0BBSubRZHz4tbo+QnxBxO1tqKfmp5dUBN6FPM0k=;
 b=SgNt9j0Ox6SkPuPzeJnhXNqqV7ZWN9a8Gfl0bOhn8VHEfb15wPhij3GbBzgbLrkmYzpp1429bjrddONTmc/4WHoI5L309b/k2l5aVbiESKafJa9U4QwLA/XswazFqKUERNrgQlEYKzChamkEXplh7DZdUki49kHM5oQi/jd6bWkrLxXkcSpB+Gf2lco2iSNnGVv/RpM1lXam2HKjPxFTdLtd5GywZM2/w1W3OB1uQpHxOelMkK7skdRzlVuh5Ru2K9umAsRFsUfCqERUfPVTNayoMtBGRf04d5goDGbCmesQXnPMwtTF24K1gU/T+fEPTMxeF5q+nyV+Qb9+ryYapA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:58:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 18:58:20 +0000
Message-ID: <d185a516-8d27-4e16-8c26-d9cd3f3de2a0@nvidia.com>
Date:   Tue, 5 Dec 2023 10:58:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <2be046e1-ef95-4244-ae23-e56071ae1218@nvidia.com>
 <888e20e4-6073-426c-9159-e359c758d78a@arm.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <888e20e4-6073-426c-9159-e359c758d78a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM8PR12MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b734550-901f-45d6-91c5-08dbf5c425d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Dmhl7IyLwM7cHk+XQc2msIIGDwBZPUQmYFCMMFMtCK4545J+OhGBwF7wOMQJz2751EG5+rxLHV4gDM+L87fhVf+47E7lZCAG236C4lW1T84oMjUpiEzCprSuqQE9WBzdwfyPYlTayn5iaHjyQ2b4HR7+ARbDCXsP0ntAlhBQEP9O4qCanur9e4ewpsz3C4bVlO5TM+1Kgw8TR3WzBXti+0nbi98G++dRQwk26XJBdEXftUbjIBisxGma6pnNYaHJcNsPTCVJu7cgiX9b8NSIWlEeuUd+mxW9m7gnTjHlB/vECo/SAlcIFpaofnXDa+jvD1otCjwPWqiRDPHLqnhCs6BYnCxONeN3FN56qRmK5S/0IFSLjYa2pNu58kovyOrWtSvlYINoGPPiPbM+X4ziOY9KpnOUR/XecBGOEINLYyJyW1LPFFpuGRUptnrkFgbgkzrjL4LGm4sNDPHyCsLNvpzzcWzEa8edhHv7DAyKn+TeNMozJP36tIF56N2ip+LjP3tV286V/mrE3LcqshTPrpJ4ag82N+TSk8ckZmdbUU4Sgni4ojVhB+2PhBu+fcW2reDU6rJW+5LU8cmhSuV9+f4hX0e8lS3dzBzeK2ai9wqIt2jzbint00siaqJ8q5//6wCP14AFIzAr+GbMPywMfHIgajaefE9bBYrrvm1V2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31696002)(2906002)(5660300002)(921008)(7416002)(4744005)(36756003)(86362001)(41300700001)(6506007)(478600001)(6486002)(6512007)(53546011)(38100700002)(83380400001)(26005)(2616005)(31686004)(8676002)(4326008)(8936002)(6636002)(66946007)(66476007)(66556008)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE5NcHBvQjgvMTg5UGFwZ2UvdjJtWnRPVFRiOThXZ3BMM0FFMkxjTitaOG04?=
 =?utf-8?B?UXhDLzBEbllNdFZ6MCs2Q2o1UFhmL3c4endSeVlQVGtpU3FJeDN4VFdGdjda?=
 =?utf-8?B?enNuSkZTRTNyVGdxdlZyREp6bjAvM1h3eEZKbkhSOWFIY3hPVEJSMWZseE5y?=
 =?utf-8?B?NHJjcmpyTUx1eXB6RysyK1dvVDlSem9vVnRYQUtCSk9uMW03U0xJcENFNThB?=
 =?utf-8?B?YWhvd1ZkTzAwRmNDWkY5bUdMejBSTG5CSTVxVE9LWVFDUUd0SC9OdHliNWpP?=
 =?utf-8?B?RUs5ZU1FZFRoSllETVhCY29sTlJDcWlRRWZONTh6cWNiSmhmSkM0bnZHV2Rl?=
 =?utf-8?B?cnQ4OG9Cc0U5bTRZRWxITGIvUkFuby9ZY3pjbHVTZHVPR0pqdWZqRUtZdytC?=
 =?utf-8?B?UjZTZlZMU0dabzFTUzFvTWNlNXJBdkFZZWFZWU1jZWdLaHZSR3N2UXRNaUpi?=
 =?utf-8?B?RVdjcHo1dGhCQlFUSU5KMDFLUWhBanpJa01xRDhXWWJNVFoxcnFGMFFld21p?=
 =?utf-8?B?em9hSkhlL0FSMUxpWGxIT2s3bHdWRC9lbWI2cUx4UmR0VlFNc0lSWXU3cGky?=
 =?utf-8?B?UVFuYnFGczU5MnF1R0hwRTE2amxFa1hJZDU3enZYUFZ4VlJrNUI0cHpaSzJG?=
 =?utf-8?B?NWpLZnhCbmN1c2tiZGlidzZHc1h3MVRjTGsyWGZ1a2tVZjA2MGNHaXA3MjhV?=
 =?utf-8?B?b2dKekxDbzdNd1NzL21xWThRdXl3STdQNWdzbmpSeE5oRndnVVN0RXFJL3FR?=
 =?utf-8?B?NUdleXptVHB6RVB5RU9CUmR5dGxxVHlLVVNzT1hFU012bWFaNERCRlFZNzFC?=
 =?utf-8?B?K3RycExDbkxrLzNBOFh4ZGEzcUY2dXpocTZoVjRwMWR6WTMzVUhVS0pES3lp?=
 =?utf-8?B?QTRIWlZET04yLzJuWGtMWk9BM2NVb3RjZUliNTNSZnFHWFlGWlZ1NndKc0hD?=
 =?utf-8?B?M2p1a2U4SkdQT05UcFBZZ3A1Nm1nYUR2SWpzcVNtMEROcDhwMCtIOStlRWND?=
 =?utf-8?B?RGN1LzV2NnA1S0ExUTFJQTBiblNFVXhoQkxMY0ZwNUpJbzA0TUlBQlhTVHVv?=
 =?utf-8?B?N1V1UlpvZjNCN25nQnoxREtTQllGYlZyTTVPSGIzL2hkSmV2WCthdkFWd0p1?=
 =?utf-8?B?RU4vSXpOSkNYVHl3ZEE2VjFFWDdid1dWSUY0R3ZZQU43NTVBcmxHNUIvRGh1?=
 =?utf-8?B?NVJkbFM0YzBENlJOVG5JZ050M25QYkd5VGhZNnpYZ0d3bFhwSGFHdTI1LytL?=
 =?utf-8?B?Nk0vYzMxRVdJN01yQlZiVnpmWVMrVnI5YUNGVzZxemVKeHhlZFM0ZUhXaUxj?=
 =?utf-8?B?dlBLdlpWckVTaDYzbXFFYS9RYUVVNk50NUJHbDA3MER1WVdFYmE1TjlpalR3?=
 =?utf-8?B?TGQwVUJvbFA3S3dBcE1kTFV0eVpGZUU5dWFsVE8xLzRlSy9rLzkyMGV6MU5Q?=
 =?utf-8?B?VUN0MmhNd1pqcnZHaktJMitDTEZxYWt0dkl2TUMrTnZBcWxtM0txR2E2WjB3?=
 =?utf-8?B?ZXpaVnFoV243cGZPL0taVFE4aEw0VEZTL2UzekdCUnd2cVFnY3lWeGI2bGps?=
 =?utf-8?B?WDJXRHZ6WUxSRzNVb0ZoZFNWcEMxeUY0bkhxZGlFTjNpVjJqZUVLOHRMSzlX?=
 =?utf-8?B?djdreGYyUmxnbWZhQ0w2MzVIaDJWcUx4YURLckJGa3htYVM3RmQ2MHJXREdG?=
 =?utf-8?B?eEcwQ1dlYlRnWHdZelJZVjhiSE1yN3pMZzREM2QzSWVVTlF4L1hZZXdUVkZD?=
 =?utf-8?B?dFJSZ2x6N2ZLa2pEODlxZjlnOTlNWk54dW0wc3BnM1NPWmt4SGRndHg2d0RJ?=
 =?utf-8?B?bWViVE1hVE5aQ3NHWEQ1QWV6N2JpdnZhaVRwbUFMUzIxVTV2TVFmZTQ0WU5p?=
 =?utf-8?B?a3JCWmI1SnBjZFc2KzZCSDFYMUdibk9pS0NoRG45Sk9KQTgxaC81cEpPckg2?=
 =?utf-8?B?TmZNYmFNOS83VjRyUWlTQ012dWNFbmF0MkkvQmJCQkd0QUxYc2NpV01TeHBP?=
 =?utf-8?B?MW0wajFPZWFSREVmNDZVYS9XYVQyRU1qQm1ycmNOZlNWVmUvRlNDR2M5SGg1?=
 =?utf-8?B?SEk2SGhWL21KOHduZEpUb1dLZkxGZGdpanpTZUd5NVN5ajJteU1DQlMxVnlv?=
 =?utf-8?Q?kpotwrPz4KsRsth8KankmetVp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b734550-901f-45d6-91c5-08dbf5c425d5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:58:20.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fkyvaoonyzO8K4V+0RffheHz5LLWPbGp06aj8pvp+ZjAUndr6RKOZ3gQXtlMMR7kEM+JLu38GMOjuL5uri1Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 3:13 AM, Ryan Roberts wrote:
> On 05/12/2023 03:37, John Hubbard wrote:
>> On 12/4/23 02:20, Ryan Roberts wrote:
...
>> With those two patchsets applied, the mm selftests look OK--or at least
>> as OK as they normally do. I compared test runs between THP/mTHP set to
>> "always", vs "never", to verify that there were no new test failures.
>> Details: specifically, I set one particular page size (2 MB) to
>> "inherit", and then toggled /sys/kernel/mm/transparent_hugepage/enabled
>> between "always" and "never".
> 
> Excellent - I'm guessing this was for 64K base pages?


Yes.


thanks,

-- 
John Hubbard
NVIDIA
