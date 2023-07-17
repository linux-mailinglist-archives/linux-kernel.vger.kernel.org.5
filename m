Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53546756698
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGQOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGQOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:38:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926ACE72
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha2ecv4x6dhSXVGmaBI6mPRp0QvUt5iQDL+6pEKanf9+oNOBrUeGWl1CgTYj6m4FqqTn20/YqXqu+8nUaEjWIxzEl1rHSA9Y63eNZIcqPyHfzkMo7I3xHtqCBhql0F1FksaiUDv+E7lCoG+YdFRH/8EkJk7qRP7WEQvMSgtqfCpp7pWJRUbHCl2ykmheoT8MkBRuAJfvvMQHrdxrModsxKUFZiu4e7zsWy3V1MfDPAtZUCX1DpJv+BzbWm+bOMwYUWZZOyvY6oMEscWdwXxILBNoKCZd9/5JvEvAVYXssmVjyGwrCqIwH97BehYeuui/CFOXyTtUjRlJ3KXLp19GKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbCbovvv3I8VH/LVWGUASY/68p9R/dQa5annR9JP1S8=;
 b=YXm99ZBRIg6HPQ/9hI2oNCNTYYnjLFjjH9dXpwYIDKK24MjASpGJsbQKnRuLarI/Jp0cyRu9AvHXytzB/ICR9tyfGDkboJ7u9Sqv/5pl0ciD4+8dixD7Hu9LhtKSDdnVqIa1lny3MHXtpeAdV8mvVfK8+R1FthLi9q3ytwKKHvapkDFwC5FXgySAP1C/JxJmtLek2SeXcfA/FXvYkATsuOjq4lzMhMucp5AtA3XNPibgkgSvHU29S5rGizw1mAka2uWxIe/S1SQurzVtKmEtUXjYKtA5x7vezKBRl0tQt8/PnQbo4PMUwB9z5HwE+/F5p0t7vfL+zm/X2CT3bsPf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbCbovvv3I8VH/LVWGUASY/68p9R/dQa5annR9JP1S8=;
 b=YTw8UZnnNtb4jZgdqTN130M4Qi/u0l/0/dzuH0QH1fHegM1xT5qFobYEglTkbq3s8NcRzfocLAZFSEMGEZllOu7N6ybbGt6PKPzbxteBuw7vQulsNPQWvRDcS9p5WvVD5tPwrJ8kGnJQxZLO0G0MTMWtWRJv6LFD6j6wGRCjc84O0rFfXBLafJNma9yVfuThyhFHcw9d6/2zedoopTOSzpf0e6Z5tYNBTyLjHN3s/Oi4LFZM/nDHyslfSwL6crS7ou8V6qiDmEORDtBJhm9UXB7MFOm49DR3nCi1QLX0wNfbrPADu9g+RgPl2uzErFWMn0klPmkooDg02OhApUQ8Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 14:38:47 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:38:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, ryan.roberts@arm.com, shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Date:   Mon, 17 Jul 2023 10:38:44 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <83A53330-D068-40A3-BCE6-4039BC2C86D6@nvidia.com>
In-Reply-To: <eab84d78-6ae6-4db7-0474-35e439435913@intel.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
 <6C3EFBC6-DC59-4167-B51A-7231A55FE1D5@nvidia.com>
 <eab84d78-6ae6-4db7-0474-35e439435913@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_87C9C001-EF0F-413F-9021-83FDF92ABEFB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:208:237::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2820d2-eae9-4e3e-9f53-08db86d38707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZo9271Aue0xHx8B9jfFJ8VPyRVRHFyYMHJjmckqtG+dm6+LeZKsHc7MhCbpuIaj7hIV2p2Gq/VI+nlu4BjTr79uxy++T4pgkqOf/+i8bGQijl8tKQ4xnDj9Y0+3lJs9EfG5hcoeLnC50Fkb9LIbde7eKBZVo4hUc1fIk1SxeG7/T616lwdrVz7gyTmgWCvmfXMG4Wq8EJN8xTx3zQPgZpRiWH9Zlmw05bD9tb5NR0lLPbRyk5N+ngGmevx5YJGMLGsr1kWv9PNoayUPXXRUKo8Fq3LgV1ywQvP0Pi+b2vVh9xIy3Ftb5biOkCNajCXKC3dxcxI0AmbMzrPqFkhf1sNbk4XCJr177r+a6e4xk3KBnyrhew1tWE5Ruv6g40d/Evc7uFSaEz7+eBhDcLkq/swJ77PMVskeMS/eEkMsD/7wafuaTUqZWZcD+hw5Rt7bmPRRwsKnzu8uH0MUkfT3tXwVv4d9YWM0Bq+gkzDfKmlahEVylUZPUdyixB2En29M09IsZSX/p6/cJj3AIxlbd6akXpxAw6A4bnni5qVHdLmuCICUFDaW6NB+z3v/jLTWAd4EuvT3QKvnIzNArH0e6YDmBI44THjSI6+KL58stinImJCBg4p8G7OEdcnUJvMiwJb8Uf8jMjw7aOupUbAXF1uffW4Zb5LM62drQSqv9McWrwyntsAYPEnQaLfJo6A3bka4PfGlOqRoaRyWvEcdTGs+UHiSW2H54J4A87ygbtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(8676002)(41300700001)(7416002)(66476007)(66946007)(6916009)(966005)(2906002)(66556008)(8936002)(33964004)(6666004)(66899021)(6486002)(54906003)(86362001)(4326008)(316002)(235185007)(2616005)(36756003)(5660300002)(6512007)(38100700002)(6506007)(83380400001)(186003)(26005)(33656002)(53546011)(478600001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2dsTS9XNTVKVnRjL2l4ZUowSzI1Wlg0NW5uOHdoWDB1S3NkSlhrblQyYUR2?=
 =?utf-8?B?MzlFKy9WVGF6eFBBMjVSWXlKY0pMSXA3UGRSTys4RDV6SVNBMGhyeWI0YWxp?=
 =?utf-8?B?cC9zWnczU1F1U3pQRDBZM216ODFSeUNtWnJjZ2JUVnl3VjFNZmVKMjBRK21z?=
 =?utf-8?B?NTZmUWcxWFFqQVRYMENqVTJTZWNwWUU0K3NscXJ3bWFiZCtJdkt2RnZjSXVj?=
 =?utf-8?B?bUhJNUh6cXkybTJYcnZkcmNvdWRIbEZEbW4xRFppRHJ2NlJRcm9ycytIcDBI?=
 =?utf-8?B?Wm1FU29NMHVQdHlVcnBvVWtjeDE4V2c3aU9XV1VGRWxWbXlUcVZ4NmVaOXJT?=
 =?utf-8?B?Znp3TzFmL1YyUkpDbUxTOXVNQXBCdStZMTRMWXhiUW9VbjZoNTlFZUNtc21V?=
 =?utf-8?B?VkQ1eld4UkxFQXFlOFUxbTAxT2kwODlQcFdkbWV0YkZVZExCejAzTWdKUjhL?=
 =?utf-8?B?ak5HNzYwZlJKWjQxUlM4eFpBZkgzQzlCL1AzKzc3NEQrRzUrSG5QR0tjVUpY?=
 =?utf-8?B?N2NWSkh5aDE3QmZuRnR3TGExZkhUc0ltWGV6WG1GbjhKU3NlNXpLZ3N6TS9u?=
 =?utf-8?B?RVJSbGZUOUYvY3BpWTQvMmVvUVNKbEVrZTY5S1Noblo2bWM0U3I4MEw2YjFn?=
 =?utf-8?B?ZnZ6MnR0ZG1oK0krcnMxQUNkS3Y1emg2emtCNkpVV21QRmNPM3NVRVhHSFEz?=
 =?utf-8?B?WnQ4Zm9mckwzQ1hxVlIyTUdjKzVsTkRhWm81RWxBSzJZeTMyMzcwc0RudTUr?=
 =?utf-8?B?T2VoZTlLejlHTmJTR3JwRUxSZzFHMXRzSWw1dkZObHZGcW8wZ1FEamVnRjhz?=
 =?utf-8?B?Nk9hMWlvNG1iNjJHaHhoNW5hbUw2cU9YbzhJSStpMWJ1U20wQ0U0aW93ODBV?=
 =?utf-8?B?ZVJjbDA0WFlrdzJDalRkVElWcTFmUUNvOWdic1BNeGFuQml0NFRPWmYxbWZn?=
 =?utf-8?B?TkxNVFpyQUwzZ01vREdocjc4UlVFM2JveWNoL1hKWFZpZ09vNFRmRTVSaHE1?=
 =?utf-8?B?YTlvUlBuajFWNFV6ZnYyZkIzM0ptb2s0R0ZuZmliT21TU3JaZTI1WEFGYmI3?=
 =?utf-8?B?VHF6TUQ1TVBNcGQrUUJXb1JHdG9yTVEwWDRTUm9rc2JtYWxUWmZ0TmZGblpD?=
 =?utf-8?B?Mm9xaUwyKzRtd0wrVHcvdkRHbm80d3pzdjdraFRyWDhXRGR4NXltZFZwaWg2?=
 =?utf-8?B?YlNKdmtvY1Z6dGZpMzlPbGIrYy9OOHNwbXI2Y0lVV01oeUg3RS9DMVZaWVpK?=
 =?utf-8?B?KytkMmdEeWtRdDlkVDBWa2JsU1kyQkFHdUc5TFlRS0R1UG9IVWs3VGRvbko2?=
 =?utf-8?B?a2c1WEdZbnlxOFY2L1ZRUStiN1hOZmVFZThVd0lhOGRRWlc2Ynd0SlBwbHBU?=
 =?utf-8?B?UngwaUJJWUJ0KzhQWUlPM2VaMUhmcC9BUldLSWFrL1U5RDk3dSt1MlFaMmJV?=
 =?utf-8?B?OFJEbDNVQWU4a2ZIUkQyaXRjRlRPUVFDcERXWDRZQ1cwaTlXL0ovT2hIUUVQ?=
 =?utf-8?B?R2QreHpDaXFTQ002T2FxUnJ4RndMVk9Yanc2M21nZUNOYWJiWWVXQWF6Umh1?=
 =?utf-8?B?NWNjVi9ML2J2R1hpczdJZS8zaGdVdmZkSXJKSjFQNjBxZUxFN21JTEdmb29P?=
 =?utf-8?B?NlpIY1hUVXBQV1NjVXZ5WGZyRUlPS2NpRlBQZGhFZUZYOGJtOXJ6N3pUTTR0?=
 =?utf-8?B?QjJQdU02T3FJMEtpT1lrM1QyblI1d0YzNmgyekRaSHQwYS8wc0srS3grYzJV?=
 =?utf-8?B?eXk4V2xuWXhpY2lKTHBoTFgxa0wzYk80TUhDQTRZZTlBZW9RZWVqcU5QS3JR?=
 =?utf-8?B?MUFGYUFCZlB2YzhyaDM4YStkdVpFMHdyd2lDK1UrZ2FMVW1aZkpxa0N0d0tC?=
 =?utf-8?B?OWhITUo0WG9VRXI1Zitrd0FVaXVWdGRJWkhkRHo4ZXJldEpPNUJiSlppSm5X?=
 =?utf-8?B?amlLM2lZWGNHaVFRQmNHL3dBa0tnVHkvMGJPVmQ4NzQvUWZCOTNSamozVzZJ?=
 =?utf-8?B?TFRrSkc1ay9LMHhiZ2NlcUY5ekRWeHpDSUV3QmQ3ZlNIcTV5K2x3aFpQbnZ1?=
 =?utf-8?B?RzEzQ2pqUy9YRE1BY25NWnV1bGFSMWw4Q3Rzd0NGb3p5NlltUFJSUjRhNmFO?=
 =?utf-8?Q?qKGs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2820d2-eae9-4e3e-9f53-08db86d38707
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:38:46.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxuJ7J2KjES9HuccxXIFrguL2qJiaitQDdjjtPhD5HJRIc1EoC6s5WbTvgERJ0Qy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_87C9C001-EF0F-413F-9021-83FDF92ABEFB_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16 Jul 2023, at 20:15, Yin, Fengwei wrote:

> On 7/14/2023 10:41 PM, Zi Yan wrote:
>> On 14 Jul 2023, at 3:31, David Hildenbrand wrote:
>>
>>> On 14.07.23 05:23, Yu Zhao wrote:
>>>> On Thu, Jul 13, 2023 at 9:10=E2=80=AFPM Yin, Fengwei <fengwei.yin@in=
tel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 7/14/2023 10:08 AM, Yu Zhao wrote:
>>>>>> On Thu, Jul 13, 2023 at 9:06=E2=80=AFAM Yin Fengwei <fengwei.yin@i=
ntel.com> wrote:
>>>>>>>
>>>>>>> Current madvise_cold_or_pageout_pte_range() has two problems for
>>>>>>> large folio support:
>>>>>>>    - Using folio_mapcount() with large folio prevent large folio =
from
>>>>>>>      picking up.
>>>>>>>    - If large folio is in the range requested, shouldn't split it=

>>>>>>>      in madvise_cold_or_pageout_pte_range().
>>>>>>>
>>>>>>> Fix them by:
>>>>>>>    - Use folio_estimated_sharers() with large folio
>>>>>>>    - If large folio is in the range requested, don't split it. Le=
ave
>>>>>>>      to page reclaim phase.
>>>>>>>
>>>>>>> For large folio cross boundaries of requested range, skip it if i=
t's
>>>>>>> page cache. Try to split it if it's anonymous folio. If splitting=

>>>>>>> fails, skip it.
>>>>>>
>>>>>> For now, we may not want to change the existing semantic (heuristi=
c).
>>>>>> IOW, we may want to stick to the "only owner" condition:
>>>>>>
>>>>>>    - if (folio_mapcount(folio) !=3D 1)
>>>>>>    + if (folio_entire_mapcount(folio) ||
>>>>>>    +     (any_page_within_range_has_mapcount > 1))
>>>>>>
>>>>>> +Minchan Kim
>>>>> The folio_estimated_sharers() was discussed here:
>>>>> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.mool=
a@gmail.com/
>>>>> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.mool=
a@gmail.com/
>>>>>
>>>>> Yes. It's accurate to check each page of large folio. But it may be=
 over killed in
>>>>> some cases (And I think madvise is one of the cases not necessary t=
o be accurate.
>>>>> So folio_estimated_sharers() is enough. Correct me if I am wrong).
>>>>
>>>> I see. Then it's possible this is also what the original commit want=
s
>>>> to do -- Minchan, could you clarify?
>>>>
>>>> Regardless, I think we can have the following fix, potentially cc'in=
g stable:
>>>>
>>>> -  if (folio_mapcount(folio) !=3D 1)
>>>> +  if (folio_estimated_sharers(folio) !=3D 1)
>>>>
>>>> Sounds good?
>>>
>>> Adding to the discussion, currently the COW selftest always skips a P=
TE-mapped THP.
>>>
>>>
>>> For example:
>>>
>>> # [INFO] Anonymous memory tests in private mappings
>>> # [RUN] Basic COW after fork() ... with base page
>>> ok 1 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with swapped out base page
>>> ok 2 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with THP
>>> ok 3 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with swapped-out THP
>>> ok 4 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
>>> ok 5 No leak from parent into child
>>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
>>> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
>>> ...
>>>
>>>
>>> The commit that introduced that change is:
>>>
>>> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
>>> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> Date:   Wed Dec 21 10:08:46 2022 -0800
>>>
>>>     madvise: convert madvise_cold_or_pageout_pte_range() to use folio=
s
>>>
>>>     This change removes a number of calls to compound_head(), and sav=
es
>>>     1729 bytes of kernel text.
>>>
>>>
>>>
>>> folio_mapcount(folio) is wrong, because that never works on a PTE-map=
ped THP (well, unless only a single subpage is still mapped ...).
>>>
>>> page_mapcount(folio) was wrong, because it ignored all other subpages=
, but at least it worked in some cases.
>>>
>>> folio_estimated_sharers(folio) is similarly wrong like page_mapcount(=
), as it's essentially a page_mapcount() of the first subpage.
>>>
>>> (ignoring that a lockless mapcount-based check is always kind-of unre=
liable, but that's msotly acceptable for these kind of things)
>>>
>>>
>>> So, unfortunately, page_mapcount() / folio_estimated_sharers() is bes=
t we can do for now, but they miss to detect some cases of sharing of the=
 folio -- false negatives to detect sharing.
>>>
>>>
>>> Ideally we want something like folio_maybe_mapped_shared(), and get r=
id of folio_estimated_sharers(), we better to guess the exact number, sim=
ply works towards an answer that tells us "yep, this may be mapped by mul=
tiple sharers" vs. "no, this is definitely not mapped by multiple sharers=
".
>>>
>>> The "mapped" part of it indicates that this does not catch all cases =
of sharing. But it should handle most of the cases we care about.
>>>
>>>
>>> There, we can then implement something better than what folio_estimat=
ed_sharers() currently does:
>>>
>>> static inline bool folio_maybe_mapped_shared(folio)
>>> {
>>> 	if (likely(!folio_test_large(folio)))
>>> 		return atomic_read(&folio->_mapcount) > 0;
>>>
>>> 	/* Mapped multiple times via PMD? */
>>> 	if (folio_test_pmd_mappable(folio)
>>> 		return folio_entire_mapcount() > 1;
>>>
>>> 	/*
>>> 	 * First subpage is mapped multiple times (especially also via
>>> 	 * PMDs)?
>>>          */
>>> 	if (page_mapcount(folio_page(folio, 0) > 1)
>>> 		return true;
>>>
>>> 	/* TODO: also test last subpage? */
>>> 	=

>>> 	/* Definitely shared if we're mapping a page multiple times. */
>>> 	return folio_total_mapcount(folio) > folio_nr_pages(folio);
>>> }
>>>
>>> There are some more things we could optimize for.
>>
>> Before jumping into the mapcount, I would like to get some clarificati=
on
>> on "sharer". Does it mean a page is mapped/shared by more than one pag=
e
>> table entry or is mapped/shared by more than one process? Your functio=
n
>> indicates it is the former, but for madvise_cold_or_pageout_pte_range(=
),
>> I am not sure that is what we want. What if user wants to page out a
>> page that is mapped by the same process twice? With current method
>> or any existing proposals, it will fail undesirably. It will only work=

>> as expect with your creator proposal[1].
> My understanding here is more than one page table entry based on:
>   - Original code use mapcount() for normal 4K page. It's for page tabl=
e.
Yes.

>   - If user wants to page out a page mapped to same process twice, mayb=
e
>     madvise_pageout() should be called twice for different mapping addr=
ess.

That could be a reasonable way of handing it, but current code bails out
once it finds a folio is mapped more than once. This means a process cann=
ot
page out any page mapped twice no matter if it is mapped to the same proc=
ess
or not. Maybe it is worth some clarification in the manpage for this beha=
vior.


>   - It has more chance to fail reclaiming if pages mapped twice in page=

>     table entry. And more chance to be faulted in again.
Only if madvise_cold_or_pageout_pte_range() unmaps the page regardless of=

its mapcount.


--
Best Regards,
Yan, Zi

--=_MailMate_87C9C001-EF0F-413F-9021-83FDF92ABEFB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS1UnQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUJawQAJNmWQIJTQWVHqjnFO/yX2I7qjudRloCxL5F
im3q93Zf3I62heCEE5s54f2UqF31XRHhvO0Y8wiLKc7Hzy4SBNMSLhim7r7dcBjM
T0s77+B3oGasqOT2PWTYMoDJQ8IV6VtoPcQz5Uxm+pxOYw93wLB+/5YPhHqH6/DA
fUbpTLc0Xvvvg69sXXiHBZCL4hOYROFnAYQHiHJ9DXWSH097RHLyd2X3Kj8T/amG
hq3pQm3S83xSJVFa2Sz04StclpIRcHd4wy3CEb7nC0MQqD/04QRQNc4h+Ajn2yFB
bX13LZr2XRozzOStF5IkC/6AmiN6UXQUnq7HzIw3oQWq2X1FvBjvs/SXLLpC6uLG
Fnk8WrB7MRxiNxyPXP41ovhoWjHWjCDAOU4vjoJu/ZAmkADzTTEK+s5VJBLiPLSu
70v9tJfgIiljSwViVtnvTEGH0vQBp5EuxN5cXKQrclGd9MRuUsZg4K9HSRx5+z6y
LTLwC1MdnJzr077wMi/F+/DnySHHaBU1bBuToxtp3NLbMgMjdDDhJxA2PDSKGbQt
ZUjuTaybFMHJXEyclBwBGWXEfN/um3G1eEeWz2+aoBFbKN5QWHzTMxlDg43Bz9fn
lueMxTHpuqkAFL76xohF8bQv17RUZfKGK4PtLKVjVEEv44Hd6GrzjR0NFfdp895c
D+Q1R3YJ
=lqD0
-----END PGP SIGNATURE-----

--=_MailMate_87C9C001-EF0F-413F-9021-83FDF92ABEFB_=--
