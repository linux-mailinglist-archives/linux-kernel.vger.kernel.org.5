Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5387E95CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjKMD6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKMD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:57:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C93111
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:57:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpgRRMDKRxAkBSBP13zAWJ9skyeVWmJ8oS/SYnsUf/t2z0b1CAr2kyDkpLGyh9/v1iY543wrBYPA8ZWu1I6DYMjhFSjCxZUAvcdUMk6ODIiJDD7pJjQ4LwR4yT5rud0SVAo83ZRvCGp5UO25iZLcubQMM+wGLXgmOOz2WN3atB+S/8EgpP7i5CO3HOIyXOsilllFwy6WCCc1/07SHc9zI7jUkwRc1lDEx3hk7hZrTX4PiNR/utmikPphUQ7Xc6pVkv6cK2Or6SO9+KL4ED85L9RikP4nFM/ipBlxbewy0LBqrShrmcaVMDhhP5P8y9T4ZIK0fMQJmTL5eAEJGZdL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ+zoCNOzyDKFz+n0SMCCAqU7Eqn7/nIL1k4yPQRJ5U=;
 b=DuXCUZQooDnZXYi4MLzQQYXHW0dScewhGlR8lvKUj41fiMNV7hbm2bKMtS0fPAC4Ywa66xLvatOJTX2meHKqH5Jkia1rNZbzSvkH5FK4nqjdTtPaYebNm0rb9a/vEP7Gef4tHuVzEsYViiWKQ0ES+AoLbA511FZNKjnhx/R+3fqmqb4UUgW0HyqmZA08pGk/rb8lYaKcUTqOITZN5wzu7GStNw/XJMUnNpZT4HpSXYNEoJeYPvdXzGeCJ5CI6wLzhHaBElGpA0g2RukcXJO6zEu1NwzmMppcVhqsP8WDITUe3tVQ+IsgjjtvE8k08AXwOERL9Iyup9mPxkvFIANP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ+zoCNOzyDKFz+n0SMCCAqU7Eqn7/nIL1k4yPQRJ5U=;
 b=Dg6nhwGXtX/Py9tBQp62OJrate+YwQoLAG4Y9b38NCYyxmzXfRaB1xEFgDnu+P1YqMuqkfIAEYxlk4OnDdTuYOdJZvUmS7FPIwJQce8sElZHc4au/IMCcFUJRPCNJloPQIxK7cpjHS4TYqQnuk1kol3/XpF6li/Q2oODslbNnLb/PW0NL/Uil730QajLIYPDcmkma7mAmyJDkLWjSulKp+1tydKUoJXVOWKtcYNKiqmzcGVoqG9R1f7SDDrimLTxVIWuaK59JrCGrMabIWB37ClyaDU319tULdMbyWTXtBLVsPEUsKU4JQ12RSlxOdqDWUbtJJoRF4bc5R5C9TM1OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 03:57:53 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.6977.019; Mon, 13 Nov 2023
 03:57:53 +0000
Message-ID: <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
Date:   Sun, 12 Nov 2023 22:57:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
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
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230929114421.3761121-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aac6ea6-2399-45ac-91df-08dbe3fcb609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebzABq5L406Rc+VKI6uO6XSQI5EBMhAwUj8zFoVBadEJskJexxFNQ9SjlgVAzDisKcjR7srz81FbxsqKLfgmdiuyiT3vMQbZJuagE7h4Foggen0PIwjlQLfGNmF0w7PKj8A6GegzFgjKBRNYC3rly2Z82dX1eR0BKv4S4n9XQNFrRMhPSixMKt0u50BzRDcd4vXFd//OsGBBVRyOmo/fAmeDOHDBBtkPAqCcAZHlCWGzYGOyCnLZCIOEWV8iY+3s6ZG0qRjiTcvCByN2Q9zbzR7v/8l3Lts97y7hpGzBJbOqFl4M8tal6u2AjnDAmLjnjRG5WBvZH14aq1Ipc98XgKIEoTzQUyf37WgUsppQeiBWblL5qrPU4CAnHnlo+OD9jmel3omMe+8VwFEUqwdr9XZS8GqGSNL6/aY+4ltlsc/6dBT328W2NK1KIX1Wj3pGJ66KRc3ZsUbLSkPWXyu/Xrwi1suAezC3ZxnXvI4Y04knbKx7+Rv3k4TBVY+jKGWQmaZAT3EAmyhyWxJ0JgeyowT7Y/adwiWy+L4JjyDSo3s/xY3gDUMs/tPqMhdP8bQJspIsMZtlbq8ZLXKOAuup103W4tiZ9hjMnAX+tE2JHOjCh9UW6EDvJImjkJFrUU7ITNUlSsxXKNskR670wM5DlZbc7jSMdtmlEmUTnPD0n2e6YLbln/trOwocJ8pKq956zrnfimf/SSjwA5u4qzeQLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(31686004)(2906002)(6506007)(6666004)(7416002)(83380400001)(5660300002)(8676002)(36756003)(8936002)(4326008)(921008)(110136005)(66556008)(66476007)(316002)(66946007)(966005)(6486002)(86362001)(31696002)(53546011)(478600001)(6512007)(26005)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3lLbWtIeHViTGJLSHNvcFdubytkUXY0S0duOXhNQ3RoZGFpQU1tZTFiWHNu?=
 =?utf-8?B?ZHJzYldORFRDNWl4NjFNRjRtYUxFcmV1NkpMaEo3VVoyd0dwbnpIblcweFkz?=
 =?utf-8?B?YnRhWkRpTWVlRFNlc085RUQydUdGSWVIUi95QWoyeXNvdU0xdUh3MnNtdjNS?=
 =?utf-8?B?K2VPVXdRL0psUzNhem54SnBXK2NZRkMrM1VxbVVzZFJxNm9jRDM5VkxFM3Fn?=
 =?utf-8?B?YlYzdGRYTVFuaUlhaTkrZWxyRDJaWUV3MENVMHNkTmdPbzBDdXphcVZMOUE1?=
 =?utf-8?B?cUxQMlFzSy9TNjVDN3Zjd3pTeFBBTVQwbzcwZGNFVVhkamdmbERLcXEydjlx?=
 =?utf-8?B?MXI3S3RhRWE4cWFFRjJjdUFLSTlLaGRQMlpWb0dLQ2ttNWZMVUtHUG9TazJ0?=
 =?utf-8?B?eFdxbHdEOHVyeWVSWlZINUFodU9HQWZhL1NNNzBXNzd6dUpMd0FpdmNlcjBP?=
 =?utf-8?B?WU1oNS94SVEyZVRHM2FWUkhOeFdtaVQ0S2dHKzVHaDRtWFVoTWg4L3ZmcE56?=
 =?utf-8?B?NXFOaHg1cmd0M0tXa24ySHcxa2tjaFJ4SG5lRGxxbEthN2hDcElXc0VJdnFR?=
 =?utf-8?B?SW9LK1FRS1ZVdm5WNExVQmc5VklrVml1TS84QmdBWGwyam9JYW1DakhrMVlJ?=
 =?utf-8?B?ZzZsaFJIWHBGYnNPYmtXWlA1c0pJYU5OOUhXd05KdU0wcDZ2bWZnZy9iVjAz?=
 =?utf-8?B?bUtJNnpQSHhWNHRYZCtLeVoxTlB3dVZBU1dEZEEvOWdjbStDWDV5dHdPUEE1?=
 =?utf-8?B?RFdGRUJpNTlLRjIxeTF3VXBlWTB2bGhEZXZPMnZLUDN4TDA2L2hVODlMWHVr?=
 =?utf-8?B?bWxWMnZLZ0RXZmF5dXFKdHlWZnRJVVlpajI2Ky8rNWtUMUVoSEoyNWNjTjBo?=
 =?utf-8?B?UWUyNFRwL2pqNWdlWklBRzk5aHhaN1Z5WGU2UG8reFdrbElsMmhWZ0t6MUh2?=
 =?utf-8?B?RkdqazlUaktwQ3Z1VDJwQzRiVy8zOEpXaCszOXdFMHVEazRNdVJ5SjV1ZWw4?=
 =?utf-8?B?RFVIc3lLK1RNZHh0L2hYNVdwNU84Ymp4VlNFWjdmK2o2MFl3SU1FWDdtZ21V?=
 =?utf-8?B?ejZ0WlEvTGZMSDZCRHhyTjZyN2VjM21TU29tVU40ZWN2cmkrM0V2Q1BrYnMz?=
 =?utf-8?B?M2dvYnZMaVA2QnVCTStlQmtDMUJVbldZdkhqTkxmOWE4NXdEYTh3YUtZQ3Qr?=
 =?utf-8?B?MTB0VUxkQXhIS3lWWmZFbnQxbXNYdVVWbmFxMm5iRzk2b0M1U01LU0NXRjFr?=
 =?utf-8?B?R2NwR0lWUXFpUTRaVktvVzJGdzhZWVRpVVBMUVpaUFJUbkNrdFlhVUhlNTIx?=
 =?utf-8?B?YjdMSDdIRCtncVBtMHo2WC9UbitJUmxuY3RuS3VoZjQrZmdXa2dIUG5Qbkd4?=
 =?utf-8?B?YVFHdENVMXh2S3NIVkRXL3RqeEphc3J3cHdOWXFUUFRraENwd1RqbmZOeTdl?=
 =?utf-8?B?Z2lJdjJIbkRwaG5MWEp2aGpFMFNGN2RpckpNOUdmYy82emIxNFhseXJQamtP?=
 =?utf-8?B?OTFqdG1yYXRFWWpRSUE3ZDdyRkhLTC95dlF0amQxT1FmWHlUd0x5M2ZrZEln?=
 =?utf-8?B?QzF1TXAzc2MvNDdJQ0pJNGFVOGRhaWpKcitjaWpJTlBJeEtZZ1pmRWd3NGQ0?=
 =?utf-8?B?cXNFSlY3K29rWGdYL25LMDhDKzRydEhsNm5MNkJQRDJZZG1BZExsQnQzRmRk?=
 =?utf-8?B?cUdDdHljOVAwYlpqRG9WRllvU3JpaE9FUERPVXJYUFovd0Q0VENkRFduVmhs?=
 =?utf-8?B?bFRnclljMDUrZU1aN2hjZ0dJTFV0K0dzaENSR0xLQjFiSWRyb1JNbzA1OXMz?=
 =?utf-8?B?bC9WTFpvTUJ4TjVVenZDeUhOU3pKQ1ZDbGNNeFhVYXlBQ0c3ZlNYK0dYZU5I?=
 =?utf-8?B?MTY0NXJJanMyY241NU9lL1RUVm5DK1JrWk4weUpyclBFYzZBbXZWTnJ6bmsx?=
 =?utf-8?B?djR0UVMzMjh5Z1ZxSm1sR1V5RC9LN0poV3drRTh5VFEzWWp4bitGRXR2QnZK?=
 =?utf-8?B?d0hiVEkvSEdpNGFvdUkwMGRHZjU0TngvRHRtUlFPV1ozeXJTdzU4QVJyUVVW?=
 =?utf-8?B?ZWV5ajBXM25EUUtVeEo1MzFYSmdiQkswaHowMVIrVzZwUHEwZWE3UE5iR3BY?=
 =?utf-8?Q?KSRNCv2DPHDFkPax/YeaXNNq1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aac6ea6-2399-45ac-91df-08dbe3fcb609
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 03:57:52.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zU66wUSKqvkIqwD167eJokH6FjuxxT6XP+HVl4CLUisL3eGWmr9JLgEsaMq2gZRBe1pOU4aAjuA46bMRXyLNwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 4:44 AM, Ryan Roberts wrote:
> Hi All,
> 
> This is v6 of a series to implement variable order, large folios for anonymous
> memory. (previously called "ANON_LARGE_FOLIO", "LARGE_ANON_FOLIO",
> "FLEXIBLE_THP", but now exposed as an extension to THP; "small-order THP"). The
> objective of this is to improve performance by allocating larger chunks of
> memory during anonymous page faults:
...
> 
> The major change in this revision is the addition of sysfs controls to allow
> this "small-order THP" to be enabled/disabled/configured independently of
> PMD-order THP. The approach I've taken differs a bit from previous discussions;
> instead of creating a whole new interface ("large_folio"), I'm extending THP. I
> personally think this makes things clearer and more extensible. See [6] for
> detailed rationale.
> 

Hi Ryan and all,

I've done some initial performance testing of this patchset on an arm64
SBSA server. When these patches are combined with the arm64 arch contpte
patches in Ryan's git tree (he has conveniently combined everything
here: [1]), we are seeing a remarkable, consistent speedup of 10.5x on
some memory-intensive workloads. Many test runs, conducted independently
by different engineers and on different machines, have convinced me and
my colleagues that this is an accurate result.

In order to achieve that result, we used the git tree in [1] with
following settings:

     echo always >/sys/kernel/mm/transparent_hugepage/enabled
     echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders

This was on a aarch64 machine configure to use a 64KB base page size.
That configuration means that the PMD size is 512MB, which is of course
too large for practical use as a pure PMD-THP. However, with with these
small-size (less than PMD-sized) THPs, we get the improvements in TLB
coverage, while still getting pages that are small enough to be
effectively usable.

These results are admittedly limited to aarch64 CPUs so far (because the
contpte TLB coalescing behavior plays a big role), but it's nice to see
real performance numbers from real computers.

Up until now, there has been some healthy discussion and debate about
various aspects of this patchset. This data point shows that at least
for some types of memory-intensive workloads (and I apologize for being
vague, at this point, about exactly *which* workloads), the performance
gains are really worth it: ~10x !

[1] https://gitlab.arm.com/linux-arm/linux-rr.git
         (branch: features/granule_perf/anonfolio-v6-contpte-v2)

thanks,

-- 
John Hubbard
NVIDIA
