Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A341D7F5832
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344760AbjKWG2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWG2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:28:21 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B15AD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erfEyoSkAYmyHHuM/9yAjasIu2PFdqXGnyuo+O2E7qqm1QAGOZpctQwMSxeP5WR4wQ6OSrYMtUdn7CKgKaBVM6R7K3MfiLCfVrfcLLqD4nndC3StINMwdfJwcbTvzBPYOmPRq6x9ku4D4UtJ7T/ktlV4qIRn21EEALAQj2rBUdzcB2aQN4A2rKr8MtbR1MRLYD19xa9G/Me24dE0tXj+eOASFHKq0tfSjVBD7Bv/QOLynrQ9huEdqkpJQgMcFdwHzDoOZhjyryitPY5dfMfcBFVGaHiNZHSlnlNjJoFVAvmPCY1WJS1ljjPhHJZPsnlLyXeNnQaP6qZ6L2wY/oY9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMdN8nYSx4Eemcc1GPPEt9xpGQEmhE/LTCD4UkN5+ag=;
 b=AWbd/uezGHXiC5yihXRdh7DO4PJMjX7sd6M4HTjjbZtC+HkW1QUDeGW0/gkUTUfcOWhu55xWiWFm3rKn2s0HYA3J3UqhZlp/Mls3LtN5zW2sqTDcgmb0/2+FbCISVw3E9w2lB6URh8K5yHqhBEKx9R6QGt9mW0VGkyy8TdbvHDSggEZE0aL10/WV7MkP0jGCOK6x6Kf84Cm6PnKK60PaZT2jOgY0ZPGcQtxgXYXhyOesyS3V7m4SIIPBmoJefTNu42IIg6NMrbm6cph3Der1+d4ms6j/bh6JJ2602DA6Z2QOcadYtAKsXi/sGwy2dQ5bmiKsbqe49AqXH8hAbsrWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMdN8nYSx4Eemcc1GPPEt9xpGQEmhE/LTCD4UkN5+ag=;
 b=ZeLnl1cn2sImjqdCXJaVH/2DDPREHPOb1Y5h0jldrXtFy3aH4c8wIsx1zI/rkk96OZF9azs30LssXGlM6ezS8SLiwdf58ixLxeK5K3EwMb3BPBRneugLQg3p95ubYz5WEcR4IPXGJVF1T3uJyi2JQBo4Tps1RWOMaTYbgv9muGZyCZdRAa3bTu/Ht4kbjms6SIjQVYYV4raB2bdGLOWbcpWU8q1vJYe6Z/PWfoveuZW5op5iiWl1It5x1JBki2veJ+DDP6CA/VHXnacFSf25ix4tH8dYUfXB/Gc1K1EaQ9fVHTczFdgYJgMRuVBbz/wqaxNnhrg3ya7Jq6c0T04KGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 06:28:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 06:28:25 +0000
Message-ID: <101e5ffa-acf3-459c-85f4-7f36a63b125a@nvidia.com>
Date:   Wed, 22 Nov 2023 22:28:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
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
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231122162950.3854897-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:a03:117::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: c31fb7de-e9f3-4543-37ad-08dbebed65a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSa6oPi/IH6fdFwly0hAmjz9UqVpWhFe7qS0S0LLiXadyKXNYyLTLr9i0WecLm2E7D5JzhQiB2XnrWlMwZV1D9SFBr5Ld3O9IwJ/KZUNcjkwXS7qbhm1KEYeb8qfAHEwoCyFiavZ7MFQCaA8yGi5oWQJAoXiXc1PHwYAswiR2UKublb3TOEMY3Nfkix0bGtn2hRHS72bt9Lr6AHVVwcjeJZDqEyaE5oMptCCmLi0daXSyI1/cyNiuNdnguBtbbUWrPRCKGToDoZ5VaG4VsVeF/LVtDLL3tgyGj6QOLZFf43udjR9gKh689NdKwRJ0qwjqQRH0S5Xs8PzYX1CFsSYTLz9BoL8wFVLX2ZlmXSavNLPyha1OnMsiWk86ZX70vzKNp9HIjgXdJxq7abVo0ZW8OjmO9nD+RurR28SfGGlwZB+h5jZvF0yLO9NqKlxywtW58Vv/RaQRYnEORk0F63YuqHRiO0KlYQTLAVzyoLWor0sPo3BY4uhYoAtRdYoQuRfaWPOU9RYnaiqPXi5brvZjna5KIuii28tbVzQzF7T7eta9qbRk3ifnRP+Cm68XbjFCLs2hyR2t5tsFn83MnaRRuQdrU2K5zTgMJpf+XmGnAoAzpRGQaRWWIBB6BauUd5WoTvP8hpWc8SStQDnvOXTHOaGmLLMMg8v0On9qawJ5L4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(8936002)(8676002)(4326008)(31696002)(86362001)(7416002)(5660300002)(921008)(41300700001)(36756003)(83380400001)(53546011)(6512007)(6506007)(2616005)(38100700002)(110136005)(31686004)(66476007)(66556008)(316002)(66946007)(478600001)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek1sTVRPREhXUkhZM2FqOXZ2UlFPYjFvbUlOWGdob0JGSVNJaTFoUk1HdXdm?=
 =?utf-8?B?bTBsS2twbUg0NXFOdlBaU0hFUUhlV3JabVU0Vk9RalJuWHg0K1hDOXlvWllo?=
 =?utf-8?B?NWZNM05nVEhTeEtGWjRGL0tRVGxmN0U2OHI5MmJrQVZOWXVoN3pnbGRJOExQ?=
 =?utf-8?B?YXFaUG5hbzRzWC9SNlNKODk2aStDaXEvc3luSVRRMURidmgvZzFuUmNLS3V5?=
 =?utf-8?B?RTJiaExQK0paMjNkd3JNR0V4T3prdGFJR3FDOFpDcnV3ZHRrMUR5VFlxTUQ2?=
 =?utf-8?B?YVZtdWJQMjU3QzNlYXoyZlYxVHFLL201MzJzNnhpemZOSmFJQzk5eERPL21W?=
 =?utf-8?B?M3J6NTNyRnVUdk0wVmw5NWg5UnZiTElnU09BWTJZeEcwQ0FFTjd0MXA2aGVu?=
 =?utf-8?B?TU1EUlV4Wk1kelRtUEZRRnhXNGRsV0YzYmhCUjROTCtyMlpEOU0rc002ekRM?=
 =?utf-8?B?aUFkYlMvS0k5Q2RsUGUxbEZldEpGc0w0OXJkUzM2OWVvaGdxMEFEYnA2ZlE1?=
 =?utf-8?B?RkpPWGNtM2Q1Mm8rU1FlYk54MWtqNk9abXJ4WVMrWXNZNndhMzk2Vmx5b01z?=
 =?utf-8?B?eXJtZzVFdDJXZ3lWeGo5RmdSbHM2U2NrWWxtd3BraVF4d1ZRZXNQV0hKVitD?=
 =?utf-8?B?dVJrUE9aNzcweXV2QngyVm8zNmxFKzZlclpDaVBBeHJOL0lSU2NYQVpRSUlY?=
 =?utf-8?B?dndZRnpBdG1sWGlncEEzT0tGbnNqOFg4WEdEdkF5azFTSGorU0dWU1BObzJm?=
 =?utf-8?B?bUtITWlFOU1BRXNCT1pJbW5jRDZSYzkzVG9QazFaRE1mSzRnRXVFZzZzQmRx?=
 =?utf-8?B?Qm9CTnZYYVZGOEp5R1BSZVozK2NnVTJRMUgzWlpVT3o5NXFjZlpiS3ZmQzJS?=
 =?utf-8?B?U3huMTZDaTB3cHJMT0xsRi9vV3RvbGNydHRacVVMOG5RditVYnkvSjNkaGU5?=
 =?utf-8?B?alBaRlJ4T3JqOFdWQlVsQ1dKNWFUSk1MOThSVlBldGFXRnVyN2M2d3MxK2Nq?=
 =?utf-8?B?dVA0L2RwcDRjMHhsOGlydGcwQml0UDR1M0tiRUxWNW9KQUlXTy9JM1ZSc3h3?=
 =?utf-8?B?OU5tV0lnWjNaSGw5M3k5aGJyNmIvbkEvNGp3RXE4dTZGTFJTMnV3T0NwR2Vq?=
 =?utf-8?B?N0NBd3JHdzNQZFBUUG1WZGRRYWpVNFFwR0RzVGZaQ3JPbXFxSDJ1cE0rbTly?=
 =?utf-8?B?aVY3ZjZ0aXV5OUYxeWloeks1N0tzSXVZeERNWWUzS0pqSllPd3lNejJROFRo?=
 =?utf-8?B?SC9UQnhSMkFPaXV5dmJRQVBPajhxWVVNNkEwS3JkdFllcU9SeTlJa1Qvc3lT?=
 =?utf-8?B?WmQvdkNUckJWRE9jM2RaaGIzTkFDUFdvZnhrM0VaVklCbmNveVZhU3pCT0cy?=
 =?utf-8?B?Q1lWeldqNVo3aDNSYXI4OXhDaHFhNTBDSjRkaUdveW9aZk9qS2xDSzN1MStw?=
 =?utf-8?B?ZFYzbHkzd1JhL3lEd3ZMRUpUSE5TQjlhMXhUVHUzS2FPdEFyQ2l6bGdZVzRE?=
 =?utf-8?B?d0hUdmVIZ3ZOWVlWY1Q2Nm5rOTZxNzF2WWlyOERGenA3NFhkSzJlVHUvSG5h?=
 =?utf-8?B?ZDRnTWdtVnU0aUttOEpRWGJDQk1oT3JRdkU0UkVINzVhQlVzTVZudkVJWEdp?=
 =?utf-8?B?Rm1ZUDJVQTYxZ3B1TnczdjVnN0lpSUZhSHgwR1k5WUM4bWc3NFlLMTdRQlNJ?=
 =?utf-8?B?MUdMZ2RENmEvN3E0ckFFL0sxcUZNdjRWV3pqK21OZWYrTm5hYkZlVTN1bytT?=
 =?utf-8?B?UGJ6dXRoMitQNzQ3VEJQOU8vNFJBSzhRWHFkR0p6NmZ1Z29pc1k2RG9vWkx3?=
 =?utf-8?B?MU5Tb1FqZmlDaWtiNGJvRVJzbEFSZUo2d3lzRFhJZGZOczdJOWpYRkJQMVNT?=
 =?utf-8?B?YTQraWdXS1JiN3NZaTdvQ2ROZTlQZkw2TE1pbDFSdVJvVjNObWJjWjJCVUhP?=
 =?utf-8?B?ajhkdjQxQ1JxRmJOZ3BOYUdPNGp4SXp3T2dHT0d3OS9ydWREY1JnQVcvK3lB?=
 =?utf-8?B?Q3BKak1UVzNTbTVEM1B5S1dHL0JId0dQREtWTmFYMDduRUdYQmtibC91OWZ1?=
 =?utf-8?B?eU1sU1J3LzIvbGVXejBzQm84YjhEMmZzSzdFTHk4WENLcVZWQnNIa0JMUVhM?=
 =?utf-8?B?Rm5FUllVSnNqNXIzQjVLV3NSTmtIR1VsemJ2SmYveFovaEt1WkMwQ28xSWlR?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31fb7de-e9f3-4543-37ad-08dbebed65a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 06:28:24.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/achWDwmnGGEV8b5EJtFjxbhudOQv18rytBazb1HXTLM+YwCSk3neIPekk0bxLdlnn28kAyppPUBmZ1+akLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 08:29, Ryan Roberts wrote:
...
> Prerequisites
> =============
> 
> Some work items identified as being prerequisites are listed on page 3 at [8].
> The summary is:
> 
> | item                          | status                  |
> |:------------------------------|:------------------------|
> | mlock                         | In mainline (v6.7)      |
> | madvise                       | In mainline (v6.6)      |
> | compaction                    | v1 posted [9]           |
> | numa balancing                | Investigated: see below |
> | user-triggered page migration | In mainline (v6.7)      |
> | khugepaged collapse           | In mainline (NOP)       |
> 
> On NUMA balancing, which currently ignores any PTE-mapped THPs it encounters,
> John Hubbard has investigated this and concluded that it is A) not clear at the
> moment what a better policy might be for PTE-mapped THP and B) questions whether
> this should really be considered a prerequisite given no regression is caused
> for the default "small-sized THP disabled" case, and there is no correctness
> issue when it is enabled - its just a potential for non-optimal performance.
> (John please do elaborate if I haven't captured this correctly!)

That's accurate. I actually want to continue looking into this (Mel
Gorman's recent replies to v6 provided helpful touchstones to the NUMA
reasoning leading up to the present day), and maybe at least bring
pte-thps into rough parity with THPs with respect to NUMA.

But that really doesn't seem like something that needs to happen first,
especially since the outcome might even be, "first, do no harm"--as in,
it's better as-is. We'll see.

> 
> If there are no disagreements about removing numa balancing from the list, then
> that just leaves compaction which is in review on list at the moment.
> 
> I really would like to get this series (and its remaining comapction
> prerequisite) in for v6.8. I accept that it may be a bit optimistic at this
> point, but lets see where we get to with review?
> 
> 
> Testing
> =======
> 
> The series includes patches for mm selftests to enlighten the cow and khugepaged
> tests to explicitly test with small-order THP, in the same way that PMD-order
> THP is tested. The new tests all pass, and no regressions are observed in the mm
> selftest suite. I've also run my usual kernel compilation and java script
> benchmarks without any issues.
> 
> Refer to my performance numbers posted with v6 [6]. (These are for small-sized
> THP only - they do not include the arm64 contpte follow-on series).
> 
> John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
> some workloads at [10]. (Observed using v6 of this series as well as the arm64
> contpte series).
> 

Testing continues. Some workloads do even much better than than 10x,
it's quite remarkable and glorious to see. :)  I can send more perf data
perhaps in a few days or a week, if there is still doubt about the
benefits.

That was with the v6 series, though. I'm about to set up and run with
v7, and expect to provide a tested by tag for functionality, sometime
soon (in the next few days), if machine availability works out as
expected.


thanks,
-- 
John Hubbard
NVIDIA

