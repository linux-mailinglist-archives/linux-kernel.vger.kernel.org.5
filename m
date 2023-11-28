Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0CA7FC38E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbjK1Sj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjK1SjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:39:25 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30695137
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:39:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nre+SEworX6kCcnmct3Jm1tQiGqia+TIGuHFEx4G0RCpVC/+AO5uA5/uwfa0NlKm4BdFXh2++AiEgr9T3P2Mn30tHOGHDC2EXWgTJhusiprE5Lr5QB2YfRBdJxaJPD1p5c/RsV8Tu2xd4+8jGENUjLT2FQlSPdS5ZuhYnUdNxzPPJIxEXtKXdDN+F63AX8HjRUFDr3wSZ1QfpKh5LwYuTWVR7if7xtECYD6pAiV8WxVW66H8g7C7/Ky2VDqQ4/2vAnCghSygrTT5UYvkz4jkCyPUE1YAr+UdNfONdN9CgXDMjX2QFMJ8QjHbdbTCZ5m4TkAXBIzngg2ZgZYRqqg7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oIAzroTe2CFHljGWXCN2mJnpB+EifQiGcEMeUdCHpY=;
 b=Mj2Qq9jUDHPVyki7d8dPZn8JugS2vG36o8ydGLYlQTyUbyFLS1wOmvUQwgOwXH+koqSJ3ZpkhUckG6WjlWhcC6Jixy8lTeTPg+/gMrGitrgryZT2Fvvym8jlsKoDzCZyXoL1oDOfLYGlazS3qMqLEJ41CBDchq6ccP5OKvHnpRJddgaokOoq0XAJtyKRnWBGtkqhx8jYaH0NfMjycxGx5oH2DtxX+GqU/FszleOGFIcGvIk3zTuV8si1C8Ysklzec+a8Cjr1OUDhl+GwvNJBQJyeTblOopj7bL9hY5W+UcJQvmxlFOzPnl2um0j2u4HM71G++5Ys3Cm8vOSbcU0AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oIAzroTe2CFHljGWXCN2mJnpB+EifQiGcEMeUdCHpY=;
 b=ObIqFYLsoaeajC7W6Bb2N0zettUJ/WGM95pG139NCAJgJkMLLydRoiRD4NFlgLcAkVg+d5WVJedVTggwn+i842XPVGsJvF3b8JfCOgnR2WxnpXHSu7GddmC4TGvVXHxjyyRgPNjj+s1vl3uWR9cw/+03kalXU0pnetjvxEczcpM6JQsRpjyTRvMKe/Oua8S8Y8OrSWEyViMC0pPD0Y6sflX1u5BW81kgX82SYyuRlYL/t7Ynze3HPdnN1Qn8Rk8JDlj3A+zm8aLwzgi8zP/Ekh3PpYy5H6U+KSpKelR97bOGsClUfx+i0DbMVY0WxBOpOP83esCKqYqGDwWHpysgMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 18:39:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:39:25 +0000
Message-ID: <47d27539-6cf1-4375-9bbb-2ebb9a2acfb3@nvidia.com>
Date:   Tue, 28 Nov 2023 10:39:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
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
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
 <87sf4rppuc.fsf@nvdebian.thelocal>
 <51e6c9f1-e863-464b-b5f3-d7f60a7ebed6@arm.com>
 <b2d19306-0d68-4aef-9b68-15948ddc8ea0@nvidia.com>
 <afb92816-25ed-41c8-a48b-94fb2d885d8e@redhat.com>
 <58af512c-3d7d-4774-88f7-6336c9384b61@arm.com>
 <137902b6-24dc-4d51-9be2-6f94aa9dbc3a@redhat.com>
 <f4c3972e-f341-4d15-baa2-bedda8d7a8ad@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f4c3972e-f341-4d15-baa2-bedda8d7a8ad@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM4PR12MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9865e2ed-dca9-4cf0-d508-08dbf04158b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6vU2ATqo5ob5UgzGWnCTQuvmKLkvsjG9cd2BB6RO4XZdDByHyqlsZ5H8G89etqgD6yIdrR91UQqKtrv/bX1iWbCLmxnsQQ5BtJpo5PE5luTmPSS9XrYNxd9VF4bQ30O6zzUL3UeNWpYsQDUUQAxZ/Ggjhnbc24CgK+vaptnZFnWl/qr3Fww3xMMqYpeC1BTdUTLbbhxbD/xh4XUZqKVe68LDN2PGzEXj9Ud557n41lGw2CdL6NabNfWFr9dHXwmNEv+dYrYDbBvc/zynH+OZxWl3mZq6wGSswDYlMBdN54pyUkTX8tiVeTZfnNi2G8bhN2McWEzc6e8Aqqb7glAqi7pw+H0EmeNaCDbl+KxuMd7lPX8JdkIQ5TrraJTEdWnIioBqMejj++DtmP3u5U0ZpZ2ixI8GXc7+IIJDxcWptfOvFI9pCI0I4pCTp9jRcJnfSmXkdNrej6tkg1PeHS/bfQnfRRqB1liOmgdZwyiJhDxL1B/k0SVWqQQUEREwMXwW0b2rD9MJZ8R4FBL9nVpYst+fuVXFbmI4gt/95WpqpMvxhRgT9MnsvNVd21tfd7BFW3DibUGMaM516YzDhet4Jagc5PtyzzaqTqr7gF1wY2oAViI51T4CAhDIqEfNYxXqYxYBCoKp6Yg0RmnEHDizw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(6506007)(6666004)(6512007)(53546011)(8676002)(8936002)(4326008)(6486002)(110136005)(86362001)(478600001)(2906002)(5660300002)(54906003)(31696002)(316002)(66946007)(66476007)(6636002)(66556008)(38100700002)(83380400001)(31686004)(7416002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJtdUcrenVtWTRreWVrMlJ4UFoyS3BaTjhQOWJoMys1VWlETEQyUHRvWkVV?=
 =?utf-8?B?N1k0T3pYaGxHTHRNTThHVTdObGpNRFQ0VSs4dHUxMDZqNk5tL2hRVVo5SnFa?=
 =?utf-8?B?REFqU2FaV29LOUYxblBMbXpLTyttMDQ5UjRTYlFSaFVmUWVoSUdLSWpaY2dK?=
 =?utf-8?B?VDFnN1d5M2FHYjVLaHBmMU1RaUdKeE9kbmpzd3Vydzk5U3ZDamw2N1l2VnJu?=
 =?utf-8?B?bE42Qy9UWUtDNEZGVHZJNGMwd0pzcllvenBUYmwzNXJlem1LdWdnSVVUU2x6?=
 =?utf-8?B?aDFrcVhjYlRZZ1FJd0lPWkcxOGFIZWprcTI0SWlxWXp1UnNQZktROHRzakNH?=
 =?utf-8?B?QTBaOUYyZ1FjMVJkekhpc1pWdEhVQ1l0Z0hSeGYvN3U2UjduM1pjWkd1OFVL?=
 =?utf-8?B?S080KzdISUNXVVJKREhrUHdCbVkzQ3ZjOHc3WTdlKzFxTDB6M3NTR2hETjNz?=
 =?utf-8?B?S3o2dERTK0QvMTk0U3ZuTCtuR3NkV2pRVDFEdTFaNTB2RXdUN3krSWZMWk1E?=
 =?utf-8?B?WGJYOWZoSVFZS29FOTBGZlZpV1FUZXZpWG80MWJnS29hLzRuYjg5K3Z5Yzll?=
 =?utf-8?B?ajIxc251ckxabEFSUGNFQ0NuWUtzNDF2RW1sWEluS0h5WXRIaDdMb0VTMlc0?=
 =?utf-8?B?aEZWK2RVQTFaNEZpZ3I2d1pZSnZwSHQyUHYrZUtwMHJXY3BseDRzbmU0ZjJl?=
 =?utf-8?B?aWhSclV1ZDl1WkQzak93anFERnhXR2d2S05ydjlwUVlCZFk0QzVFRmJTOXVi?=
 =?utf-8?B?aXdock0wQXRmQWo3QnhUQlhjdkp0VWgvdTJnYno1QUFmbmRmck43a21WSnVv?=
 =?utf-8?B?bnFiS3FxdzlJU0kvbWRZa0J0RW0ydGxFUmN3VXFoSGxtZHM0K1g0OEZmdVAv?=
 =?utf-8?B?K3JMMk5LTUVjOURCVndEdUU0eWs1dWV1eU5oRys0djRPdGozVExDMHo2eEVM?=
 =?utf-8?B?VU9kSGxqOHR6VGRuc2tMcEtvdXBrVExRNjlzU0Q2djZabyt3NnhCZ0EyNVFz?=
 =?utf-8?B?OUt5QlBFZCtLR0RlQTREanc4aFJsQXBUY0RTTUNOWS80aWhmVXNKS1NuRndw?=
 =?utf-8?B?TDU0Q3IzQlZ4OWw3ZlZhWGFJSENEclB2MzlQYTYwUGM2dnU2UjhSNnVHTTVw?=
 =?utf-8?B?TDFHazREWXYyWmFsSWJqRlJjWHB2SmtLLzB2Qkd6N0IrUGMvU0IxcTZ6Y2g1?=
 =?utf-8?B?OVlZYnhJbUo0RzdWUHB6SGFqOFZiVS9mb3I4TXdsaGp4R1lCY3pPY0hqTytD?=
 =?utf-8?B?cmxpNTUzVHFsMFljMTRIVTN6UDFwSFFIMjY1Vkl5V0drRzg2MnYyZHdpVGtV?=
 =?utf-8?B?MkVJMkF2T0lVYW1Lekg4U0JpR3lod1hhZkR5NjhQNWJTVTROYWg1OG02OVU3?=
 =?utf-8?B?U3poaXU2eTJidnRRbHNSNGR2TlJCRVl0UTFKTzlRWU5sRkpkL01sdFdNQmpV?=
 =?utf-8?B?Q3FxUGxiOFI3SnFhSzNlN1l3ZDZwVXNVMkZ6bUZiMmlZSE5DQldLNGhZUXVR?=
 =?utf-8?B?NzlWTjlDeHRTMzhXQW8xeFo3bjNSZHBDRDhnN0t2ZzN0ZTY4a3pIZ0RyelJu?=
 =?utf-8?B?a0xkYXJ2RDMvSkdTaU5wT3JvUWFsbWRvVnpLYm5NY3U5aWdQT0ZiTU1aaFpa?=
 =?utf-8?B?bmhlaU9WbCsrMmxWcXR1MURtTGdVL1VXRzdEWEwwbUMxRVBBVDdXR2RLMjI2?=
 =?utf-8?B?QWJtVjkrWGQ3VmV3M3duUndxbGdIZ0c2UFVBSi9IVGoyamp2ZDhHcUMrRTlK?=
 =?utf-8?B?MXF1TURiVW5jRXMyY1JOL1lnOUQ2S3hPdzV3RzNsK2J6UzVkU1dJc2FWU01y?=
 =?utf-8?B?N2VRdzNVcHBjM3ZyZFRUaVZ2WTZ2UGpNK3VUcjdLVE1acTNXbERoT3N6YkhF?=
 =?utf-8?B?WVVsQjNJTHdSSU16MTluc1FLaE1pZE16bVExK2hLZ3IxdlVUWE5IVk5RMUVu?=
 =?utf-8?B?YWx1YS9vNGR0cngyL1lsQWZ1TWU4bTJvOUtxZ1lJSENKM1h2VXJROVgwWmI5?=
 =?utf-8?B?Ulk0NGthaEtIcE5tK1c4cFFuNXRER0pFUnNhdWR6QStKZHBTRWRXQzZKNkFV?=
 =?utf-8?B?anR6dEpSR3lYOEVHcXhOWGZVbWVLSXdNcmEydW9HeW9pQ3NSSVZqczdPMjBy?=
 =?utf-8?B?eEtjajRrSG9XSmNxMzNMSEFlZEc5QjQ2em5nRmZzcWltRUh1YndRZVM3clQw?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9865e2ed-dca9-4cf0-d508-08dbf04158b6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 18:39:25.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiXkG7mJEHo+mUBW9GsZgtsztQqXh3sU1K1u2AJxqiKSJxn/Qm0iMbXSlShkAK44vnQm1RuLS8BQsKLFtjZqEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 07:34, Ryan Roberts wrote:
> On 28/11/2023 14:09, David Hildenbrand wrote:
>> On 28.11.23 13:15, Ryan Roberts wrote:
>>> On 28/11/2023 08:48, David Hildenbrand wrote:
>>> How about we just stop trying to come up with a term for the "small-sized THP"
>>> vs "PMD-sized THP" and instead invent a name that covers ALL THP:
>>>
>>> "multi-size THP" vs "PMD-sized THP".
>>>
>>> Then in the docs we can talk about how multi-size THP introduces the ability to
>>> allocate memory in blocks that are bigger than a base page but smaller than
>>> traditional PMD-size, in increments of a power-of-2 number of pages.
>>
>> So you're thinking of something like "multi-size THP" as a feature name, and
>> stating that for now we limit it to <= PMD size. mTHP would be the short name?
> 
> Sure.

Sounds workable to me, too.

> 
>>
>> For the stats, we'd document that "AnonHugePages" and friends only count
>> traditional PMD-sized THP for historical reasons -- and that AnonHugePages
>> should have been called AnonHugePmdMapped (which we could still add as an alias
>> and document why AnonHugePages is weird).
> 
> Sounds good to me.

OK.

> 
>>
>> Regarding new stats, maybe an interface that indicates the actual sizes would be
>> best. As discussed, extending the existing single-large-file statistics might
>> not be possible and we'd have to come up with a new interface, that maybe
>> completely lacks "AnonHugePages" and directly goes for the individual sizes.
> 
> Yes, but I think we are agreed this is future work.
> 

We do want to have at least some way to verify that mTHP is active from
day 0, though.


thanks,
-- 
John Hubbard
NVIDIA

