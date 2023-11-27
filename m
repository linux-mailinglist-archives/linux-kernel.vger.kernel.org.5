Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A147F9BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjK0IXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjK0IXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:23:09 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CB0133
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:23:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzwvHWRNaTbaFM3mv+TwR+Vyasx5eTIov1GPUh50Vmeu5KKcxwzoHfEvTXGgz/GUeACjqCPLK5k9bV+/fKPPNDAh5ZeVgN+fqievMjwoknMd0ilbS4xzW+AWkkSd4JZG4jlHD5pabDnOZZg1SLxOLE3HMjormfkE5EUDmHMa+lgvhey+iK9iHu1b7CjKh83dg8Qzk3WDzNoxddeZEvdnKD3S5kAJHQr0aq6Tdv8s3WcLdb0dH5FxIhs0LvgRWOb9eCH+bKSgohvsKgDFxoJA2E+YtDGdDUIs6nN6LfOiQZWgBhIWb8/8Y75Fr/7xOB9gLXpUzgrRRAxZ4/PILXR6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paCS1Lyjot1XR4Rz7m1HhBK+7pWWWevlzP3bRA18Kp4=;
 b=bIBjVjUI+EDutKzT05KTfg3gLmFeckDfv7m4IQ3Al4jfHUjjfhOs9BfskK219QBrnTzvPC2PC08wpmAxuTwrqan0q7KB+w0+GlXoDN94d69ozA6MxaX3aAqOPKcmsgdNd7zHCsBbTOahgtdqV72KKd7a4tJ+P2RspSVGDJwuMSNNsxWrC94s7zDpXxwiDCpt+7CjHzt/jrcfYqLYI5tmOoVgiFOWgPxJ8TC9pq7SPItCL5eO7GL47pd/jBP8DjzBK8f1WcB+55JmBI4JOI2+r3IylWRWINtE18TNygrvTKipcxu3iYjtBgnWRxDumAFV4oN0O4hBOfKOBNKtEzd5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paCS1Lyjot1XR4Rz7m1HhBK+7pWWWevlzP3bRA18Kp4=;
 b=TVpWjMFwIhFq3JGRwEoXQY7Y7ERY0VqjBUcFOpKruWfdmjYpkDlsUYh/piij6LfQH5PDHZEl0JpAV6KjngkMjkWbqAgrBuKXaS7KSLgfCYZXkCZzEfGbZaSaMGgNa2RTby8Ddfrr7erYC0hsgwEDOO9jLYhqVJMobrpmuvxOmVSxe5TibfuU/6gWqpj7C4YauxXOv73YggV14PwmKT86H8L8W0PppJWxfDkrMFEuI22EMyEjgHvQyrpfO9Cm3jlekGCxgw3vjR9JoQjzc9CnD+/bkaOw+tDwGZ9NEHb7R8T5Fv6PTW/Oee5t+49ToEXWJlNAt195NfbUXX8HIHxfsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 08:23:12 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 08:23:11 +0000
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
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
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Date:   Mon, 27 Nov 2023 19:20:26 +1100
In-reply-to: <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
Message-ID: <87sf4rppuc.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0191.ausprd01.prod.outlook.com
 (2603:10c6:10:52::35) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e97f080-a907-4135-22bd-08dbef2217e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uufto580ak21C6hIcJ/vl3oeCIvYhZJwcK/Xk6/wnVYcdgKk4rdKvCjAq5glAI1O32tPB5e0S+utd4s2JHwD0qmSpXZsnohzBN9tfxn3naolEu5bHez+eI8mcKCjc9Ls6wsT9CS3xfqFhGT1BW8RiHcsEqBN/KQP4aZMPmv1FLvKSqxegknlc2wJb6oGZhNqfTCpT8iZetctoKEIL91LHNxJKMO6v/dYDPrMoXI8inrP80ONB15pqPG0hqFa2TB2HBiGBsR38RJu+t/0DHOivcpg4TU2MdUbFpYQztcwexKwUwcRTln6wFa/mWddNhzyJ8h843H27K/Vg2EYvRG3opIquguAD4sYghKROGULRKkSaTtqfZAHjHEur0nWIyAsLS1J/lxfsGVsovGUOxyVyffKS6dHWLDZpIemBcJorb7pvgj4xB+5jVglIdqTUBoelzmwz5z9lx14zbP2X3Lz9CiWRvqKR6Ehicut5meDaNqLPMTSpwMoBs/rxA3vTRvliAAu1E3qZi0z548yMWKIp3DZpPmSLB1i8wzX6u2llTQN/aSzJhiaSHGjNEJK46R+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(8936002)(8676002)(4326008)(6512007)(9686003)(6506007)(53546011)(66899024)(66556008)(66476007)(54906003)(66946007)(316002)(6916009)(6486002)(478600001)(2906002)(38100700002)(41300700001)(86362001)(26005)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdt5CKxYghzeFDzoRqcu/rCmr2I4MEqv/BTauhpfU9+oqilILSdQYOw8OnYW?=
 =?us-ascii?Q?OvG7ZHQUeW6IJOXUXT2g7iaUM3TdaBloCqD/YZxwQMUh+Uf4MFJOeU96Rg/2?=
 =?us-ascii?Q?eB9DBrn4Uv71JHJgACGyu6LGW3iIclr9AtTuT5NQS5Fh1zbaUqLUZj0ztAQ2?=
 =?us-ascii?Q?FnWSq4kVPUxNIRNXx6HiofegdPW32g/G6XjDAvSIyWVOGRm57USLWVM0hhFr?=
 =?us-ascii?Q?V8sKoXcG53p6VcO8psqmKXkO84ha+kC+jeodA3GKpjNW4dxxBp1nWsobFD6n?=
 =?us-ascii?Q?weFlZlgwPg4dSoZzSvgHnfSfK/hkTZsRGxQsWztQH6TK0Ry+4c7U2ToIyNGC?=
 =?us-ascii?Q?x6DaWoJ9pcSF0dNOq7QmeH8Y2wEAcqFv8MR+v2alncfkI1sitzMiQ3GUrvAo?=
 =?us-ascii?Q?uN6WxwY1MRS2TiB5oA1pNXiyoTYqdBODWNzu/4uM3ZjY+oBinTK0m8RwWsqI?=
 =?us-ascii?Q?yUeHwpg111IqO7TR7H0Udx7cLGEITqN1l/vhwqrwkvRqOt/ub+lM18FugEXt?=
 =?us-ascii?Q?sMwWn5Q3V3H1yOItnG1NWMG9Ivy2lJxbXxOZbEX17VpWjw8pVEcAp53Vvy3h?=
 =?us-ascii?Q?U5Bb9WDK4afsw53W3V8lcuIZ4/XqTV+QwWHqZLP7Hh5fJm+i3uKV2x2EWFA8?=
 =?us-ascii?Q?WAarS+vKo0rqUfy9BiKWICspFEbsav7Ak+nOdG1y9LnfmnbHGcgYJiksaerb?=
 =?us-ascii?Q?0TfNPkcghIjbopnC3lnReNuErX9Hs38tao0BO1pDi1Lr3pYTdXFc0gl6CpQn?=
 =?us-ascii?Q?ZJeSBThKCrrYWb508CPnwiVBhKrVd7o1r0lqLW2EYAsuhgNRaxjWO887PFd6?=
 =?us-ascii?Q?bganZpjStwMmnTdn8B2t+GWlNCSL6SPq+WUtNNoRWDP9hY2zm2uOin1EMuf7?=
 =?us-ascii?Q?LPUAcZXuD1J7noIMqx7eJP8OSUadb6LVhTKrm2tmqyybf9cA24zqUDLnOl53?=
 =?us-ascii?Q?bN2YGIIgEqOYmLzp07testM3oAVKTPKy9X4xg4hpHhDl44Z1S2HoBkAyLGac?=
 =?us-ascii?Q?IEZwFkyuwvqDDVfMdvk9Dz76JGERwEkFYaxKi281WvjaXPlSb1VHESXvFB2X?=
 =?us-ascii?Q?9ufdht4kszPzSSekRa9dZFJsBKdH6YFKKVCGbZDWqVPfO7dMFD/va5zpFz4b?=
 =?us-ascii?Q?3teHbKCv7FLsdSwOvHeiPnzQ/soGUAJVhZwKXYw9338DO+rVCjRDBhPNGoLS?=
 =?us-ascii?Q?pTPVHwmBngL0kMvJqbVXE/uyWfimUrWgOgoyow5itUrT7E64J0ZXT1MbR54s?=
 =?us-ascii?Q?k+Fijo21AdFtXvr0cjQw1rq5T3905esgse6K9YYufEiLRSwnfV2duBOP78vy?=
 =?us-ascii?Q?DsyhDMSbPlchpXEYm2Zvtbh8UtyKguJFgEuJjlGxUwAJBoq2DF763drQqUtS?=
 =?us-ascii?Q?U89NB6fmjPIC08gd7S+W4Xd4XDsWNui0H/swOUF+PU6ZvVr3J9YApo8bhUit?=
 =?us-ascii?Q?so6vPox51A8uh9Cwy+hPZrmlweCP5Qe4FyLmR0AuuFAWttYdnhqJE4/eKiol?=
 =?us-ascii?Q?zgFHVZCbzs49OxKVd6h8VChzyxZ+z2aXVDJZSfSgFXSiH3LVM4PSltXX9Kto?=
 =?us-ascii?Q?MyhEAWB0aVQK+rjRarDdYSxRPkBGcB2LjPCjqrEl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e97f080-a907-4135-22bd-08dbef2217e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 08:23:11.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61cFwIseLNUmQ/CswEYRZgc0BnJ7BaOX/FAY5LL6/wUx23fYF0Cds5k1vEG9aX2oDrGExLI7EWcwpAZXZkoeIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 24.11.23 16:53, Matthew Wilcox wrote:
>> On Fri, Nov 24, 2023 at 04:25:38PM +0100, David Hildenbrand wrote:
>>> On 24.11.23 16:13, Matthew Wilcox wrote:
>>>> On Fri, Nov 24, 2023 at 09:56:37AM +0000, Ryan Roberts wrote:
>>>>> On 23/11/2023 15:59, Matthew Wilcox wrote:
>>>>>> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>>>>>>> This is v7 of a series to implement small-sized THP for anonymous memory
>>>>>>> (previously called "large anonymous folios"). The objective of this is to
>>>>>>
>>>>>> I'm still against small-sized THP.  We've now got people asking whether
>>>>>> the THP counters should be updated when dealing with large folios that
>>>>>> are smaller than PMD sized.  It's sowing confusion, and we should go
>>>>>> back to large anon folios as a name.
>>>>>
>>>>> I suspect I'm labouring the point here, but I'd like to drill into exactly what
>>>>> you are objecting to. Is it:
>>>>>
>>>>> A) Using the name "small-sized THP" (which is currently only used in the commit
>>>>> logs and a couple of times in the documentation).
>>>>
>>>> Yes, this is what I'm objecting to.
>>>
>>> I'll just repeat that "large anon folio" is misleading, because
>>> * we already have "large anon folios" in hugetlb
>> We do?  Where?
>
> MAP_PRIVATE of hugetlb. hugepage_add_anon_rmap() instantiates them.
>
> Hugetlb is likely one of the oldest user of compund pages aka large folios.

I don't like "large anon folios" because it seems to confuse collegaues
when explaining that large anon folios are actually smaller than the
existing Hugetlb/THP size. I suspect this is because they already assume
large folios are used for THP. I guess this wouldn't be an issue if
everyone assumed THP was implemented with huge folios, but that doesn't
seem to be the case for me at least. Likely because the default THP size
is often 2MB, which is hardly huge.

>> 
>>> * we already have PMD-sized "large anon folios" in THP
>> Right, those are already accounted as THP, and that's what users
>> expect.
>> If we're allocating 1024 x 64kB chunks of memory, the user won't be able
>> to distinguish that from 32 x 2MB chunks of memory, and yet the
>> performance profile for some applications will be very different.
>
> Very right, and because there will be a difference between 1024 x
> 64kB, 2048 x 32 kB and so forth, we need new memory stats either way.
>
> Ryan had some ideas on that, but currently, that's considered future
> work, just like it likely is for the pagecache as well and needs much
> more thoughts.
>
> Initially, the admin will have to enable all that for anon either
> way. It all boils down to one memory statistic for anon memory
> (AnonHugePages) that's messed-up already.
>
>> 
>>> But inn the end, I don't care how we will call this in a commit message.
>>>
>>> Just sticking to what we have right now makes most sense to me.
>>>
>>> I know, as the creator of the term "folio" you have to object :P Sorry ;)
>> I don't care if it's called something to do with folios or not.  I
>
> Good!
>
>> am objecting to the use of the term "small THP" on the grounds of
>> confusion and linguistic nonsense.
>
> Maybe that's the reason why FreeBSD calls them "medium-sized
> superpages", because "Medium-sized" seems to be more appropriate to
> express something "in between".

Transparent Medium Pages?

> So far I thought the reason was because they focused on 64k only.
>
> Never trust a German guy on naming suggestions. John has so far been
> my naming expert, so I'm hoping he can help.

Likewise :-)

> "Sub-pmd-sized THP" is just mouthful. But then, again, this is would
> just be a temporary name, and in the future THP will just naturally
> come in multiple sizes (and others here seem to agree on that).
>
>
> But just to repeat: I don't think there is need to come up with new
> terminology and that there will be mass-confusion. So far I've not
> heard a compelling argument besides "one memory counter could confuse
> an admin that explicitly enables that new behavior.".
>
> Side note: I'm, happy that we've reached a stage where we're
> nitpicking on names :)

