Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97247F6A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjKXBe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:34:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006B120
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtZqOKP62ITNXfd0wYAtkMfxJJwiw9n9XaUXoOXJ0uiwKLXI9CQ+dZyAtqn1WsDFbdZtpgTF0d2pu/8BxEnilwa8lxKqmgw+Z8FXkC0VsvH5l7pSfxv5p6Z/1WljfivqLLwzvrRXLIqyuZHo96DQ94kjAKbR3Wh1jJgKPJTcLlfyBvIACrPb4N38bYl2jx+39RD1yJx+PHO7z6wDKv42QOMJ8u/iDIgPd+aGx3SMYHvQzRXV+y7gaujyrjTa3WPbPeGiNkKcmAwzdUTdFYYVP+YOtrzNQS0aCujXSX+bp9HHC3gaYBmPlgEvpdTn/jPUwSdsyKOCjpZN1ZS4UxRJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6xnlSJbD+2ddbVEeKDW79uwYVORajWaXp4Wyazn7GY=;
 b=O7D7HifNyh5DqC/K6yoaw2qqqp/PrhA9yGI9hPqCjsCyx0dv69emRUNgTMc1HSztbjeUPlalfKDLQNgf5vaSqD06APJtOzX3Taq0XrVZTHe09BD+UZCW33vAT/87yLktZv2GXwKHm1fAIp0RTN37PEvWuzQwJevRvSraw5zYem+KCMy9fVpaM0Diqm2moRIPykzFzTmwJuG0jXt6ri8FNEox/yOm0xEtI3sg5sv7aPDfkLV+GweAI6bErfVQzt4iyiVG8DfmB3KfnmyUTrKyv34DCc/vtX7Kgc+GhoBkftCsftURaCv0y0ZQnFjQCtjIGCum27ZIzdmZBD/OH42Crw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6xnlSJbD+2ddbVEeKDW79uwYVORajWaXp4Wyazn7GY=;
 b=g9cblsLdMq2t6gYCAiB8TMxWWaJMdA5ImIWhD5+nAZXp9kxF0WiHLfIorvaM4ERrFkJe7njeKzHfBzPBhRsk2lUw0s2AVsNNVAYsXH7vkBLtmdtIKjXt/JQvjGLpjjsCaIM/WfpLF2nYoa+fi9aqbQCUpBs+syz3/Bu9iLq87Rrz0Vp1hGhsiiYPCV/bG9CtPNfTcIVDKsUthMhr4pZTgTj5yH3S1Xf9qQ58cXKZj42qPmplN+Fj/ovTIcZoCpPOgE524JztTymRvSu8tmS058KQkKeEi0ivtR+ZYY+c6VShQ6ETXJiaHJicD+wO056aSCymGonmneE0QHZHuvJBuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Fri, 24 Nov
 2023 01:34:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1%7]) with mapi id 15.20.7025.019; Fri, 24 Nov 2023
 01:34:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "\"Huang, Ying\"" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "\"Kirill A. Shutemov\"" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Date:   Thu, 23 Nov 2023 20:34:24 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <F516C7FB-3B40-421B-B0DA-E865806EE6B9@nvidia.com>
In-Reply-To: <7d4efbe8-5690-4db0-be06-399353679982@redhat.com>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <7f76ee6c-f0e6-443b-bcff-3637895dec66@redhat.com>
 <ZV97RO3i02+NmwD2@casper.infradead.org>
 <7d4efbe8-5690-4db0-be06-399353679982@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1CC793B5-DDDB-48B1-874E-528E06F8ED5B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:208:329::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 03347c89-871f-4761-2d73-08dbec8d7f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIbD3YgS1/3tlhsRpv++n/Zk7/kM6T7IdYLH33yUwNWQWdEjdHXg8AGGuiOnGPtwuPrZTjxTGTnkfbxifymQuFvbucu6um2UNB4zYNkgTx+UbA6GDbz5eJE3FVssxODDVjyn22moanzxI9EGWwhyqwaLvQmo07mBJmycUvN0SbJLfkWFEGVYU8DzpMRRZ/f5L1LowOb6XyhBm2OMetTln5LhuTdyQ1hWtas1Oxx2zbkTW7i3eWsa0yN0a5g36skwB8Cd3eZL/fi0MRaF8JLahL9RdPQ802qmy9aXv8Kz0M4OqdlUnFM23mJpf/jS6881FkT3Mr0zk+ZCZqCHNNN2Zdtg0049Y9GpIaMK7hVe9VJRr4bNpWyMUch5aL/RoLHg2/8waKmcuuANMCIU3q+6n6a9pIXZqlS0+r8n/9sT+32GSXMxwokg6Y2ooGwPFUK8n5ujerSf0YG23jqpCAfY+T6a9AYdMy5zUxTS8odc/VBFwcNUqXfucCAikUPAjfu8vAfl200AzrNQkLUVc/5jywTPBmHiI9imNP2x3lX0tZcJW+/05PzOKE3R7lsBjRjB3oRAuQn9ZzEy2z35yJT+ll8Ncup9XAsy/zVku0ab6/dkf9FD1vyrF236mKXusnmjvgB+UJUytk/j6DLUwHlDOY0Z7N0UNnP26dvZ5JtlbhvKlGo9BgjZ3SpVnywzu6JHV6Qy4gM5RYyKVVq6phwJbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66899024)(66476007)(66556008)(66946007)(54906003)(33656002)(38100700002)(36756003)(86362001)(6512007)(83380400001)(478600001)(8676002)(6506007)(6666004)(2616005)(6486002)(53546011)(7416002)(2906002)(26005)(316002)(6916009)(8936002)(41300700001)(235185007)(4326008)(5660300002)(966005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CXPQtLyIQrA5aJuefTuGvd25pICccl5AW5h7fnF0xoWLsPjwaUI6IpuqqV8?=
 =?us-ascii?Q?V/+0TUY98S/w778wbdxznIYzKDl97ag0qGumcODjKTs4ErX33eJV+S97teSq?=
 =?us-ascii?Q?9y2Nsuv9CSURl0WGxOHQYsg+lCUQWen1UqS7V+qedAN4r2BVtjRK7amR/azo?=
 =?us-ascii?Q?bLtiAIHduxLlWN3uqTbX2kl3Yg+IFDN4AoRwz7OurwyVN4VRgSnx1Wg1EUTm?=
 =?us-ascii?Q?aJfr9LfyC3v359gtYfkprOqI+3jU7F2PmlzesyQSp8E0B4995W9o9/boRiH7?=
 =?us-ascii?Q?2CxVxW+xoVTVcXE4JeMsfwL9OJDfXWg2tS3tpnqjD3a9zT0UJ+u9hm2lujAg?=
 =?us-ascii?Q?RWC6Ed4jqTKe1AGaag0/DPSWUr4tsFYNZNhSJNvghWP5u771SvfORRjxSECH?=
 =?us-ascii?Q?BAg9Ot496OO1x+i1Xs7TauyUekEw7VXdFx0h+x1zio9Zj1/V3mo925e65rl9?=
 =?us-ascii?Q?Mh32MdvswUDmToMM417ctFCaJtcsXUUQ4na4S+eXRrPy9t8s/f2eS/EGkmVM?=
 =?us-ascii?Q?40Uxtuit4uEOhqTfdNUGqP2wPXRcquV4bKgnsheb/VE1finrcv8XrIYqae8l?=
 =?us-ascii?Q?ixGvYiJuS8Y0kvzLQA3YITmLNXflPYSBTB1fIpj5U48UgcCqqMp8NhqZ9ca2?=
 =?us-ascii?Q?i8ScvoJtbx/hX68AC9rQBD2gxE3+X9dSTS1q2fVQVv1XRHIeCSTyz0PT0Vqj?=
 =?us-ascii?Q?c+v9K0fMqu8ArnxeDHDWjIoncumd6CCO3SNxIIuwBMxeNGoJD5VUcwa1TjCo?=
 =?us-ascii?Q?ueLCMKfcK74ymoWfva1FUc7xhMGpj/mR3HxckE4JQ8hTYLasssGzWAPG4C6a?=
 =?us-ascii?Q?liJZkNeh+x110QtmNtia4AYe80ectwVHdDVl4FHhOobEFIcZCCzqcWCdnKWc?=
 =?us-ascii?Q?PWUSmK3jJpvFaCpAKGDWSN51bvUJ6z/tPLl50eZSSwwwM6NXI0HSQ3SubjXe?=
 =?us-ascii?Q?PyqwvRwgzKRSaasXSJ3176Qi+B2nGtjbnviKJY+l6JmNq/LH/yuT0FMFjqjx?=
 =?us-ascii?Q?OrB5Jt8bEB/yTZ2QpqbdLCzxoX8Z9ZJZyba8Hndk3kgKtM6xehLi6zN3AVst?=
 =?us-ascii?Q?5eD21sYKfIVwDcSfI5jRlLhUfCcbPEoM2fiswODmO865pZPwWkWwFC0EFbDm?=
 =?us-ascii?Q?6o7p0DoelC1UBZmF4W1SqSFgtcrShT/p0meWzSV2lIX6sbP6WpQNJMBw2zpf?=
 =?us-ascii?Q?L8P0CuxcSpu2aMNXg9G+PH+03qxX8ic+YDOkqY3+PwdQtb4MuXZSmCs/+Ory?=
 =?us-ascii?Q?SQuStDcNaLCkx5uuI+TIDx/x1sCx+wX/gk/t2hjzW+RjRgLCVedY/iWAxgj7?=
 =?us-ascii?Q?ncoItyDKyUyjiYqMFht3Jfv9PBeDwFr5l7yUa8ow7T8zgspmluvfjiXM29h1?=
 =?us-ascii?Q?NBxn0BIMeswCToJRw6gWBgwvHeCU0DN43DlCQhQ8CztLpOVlgq6HAeQCcc3s?=
 =?us-ascii?Q?wSxNq36J8YWX8yIh4a5zntQSnGHcucgn5jAFEikHKSeELQO+781n+I8OyNKA?=
 =?us-ascii?Q?uadjhUcO0DigDvUiLnl8RKxqktb/QUHmWg6N0As09DJf+H5GsrQRRZAjXkiL?=
 =?us-ascii?Q?+k5a+hxm5B3UBWffSbc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03347c89-871f-4761-2d73-08dbec8d7f51
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 01:34:27.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26DVGdCfa27E3+dIi/r9UtNM/womn2HVYXeMMK+gGutvC89s6FBTdsv6/M8VQlkj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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

--=_MailMate_1CC793B5-DDDB-48B1-874E-528E06F8ED5B_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 23 Nov 2023, at 11:50, David Hildenbrand wrote:

> On 23.11.23 17:18, Matthew Wilcox wrote:
>> On Thu, Nov 23, 2023 at 05:05:37PM +0100, David Hildenbrand wrote:
>>> On 23.11.23 16:59, Matthew Wilcox wrote:
>>>> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
>>>>> Note: I'm resending this at Andrew's suggestion due to having origi=
nally sent
>>>>> it during LPC. I'm hoping its in a position where the feedback is m=
inor enough
>>>>> that I can rework in time for v6.8, but so far haven't had any.
>>>>>
>>>>> Hi All,
>>>>>
>>>>> This is v7 of a series to implement small-sized THP for anonymous m=
emory
>>>>> (previously called "large anonymous folios"). The objective of this=
 is to
>>>>
>>>> I'm still against small-sized THP.  We've now got people asking whet=
her
>>>> the THP counters should be updated when dealing with large folios th=
at
>>>> are smaller than PMD sized.  It's sowing confusion, and we should go=

>>>> back to large anon folios as a name.
>>>>
>>>
>>> I disagree.
>>>
>>> https://lore.kernel.org/all/65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redh=
at.com/
>>
>> And yet:
>> https://lore.kernel.org/linux-mm/20231106193315.GB3661273@cmpxchg.org/=

>>
>> "This is a small THP so we don't account it as a THP, we only account
>> normal THPs as THPs" is a bizarre position to take.
>>
>> Not to mention that saying a foo is a small huge baz is just bizarre.
>> Am I a small giant?  Or just a large human?
>
> I like that analogy. Yet, "small giant" sounds "bigger" in some way IMH=
O ;)
>
> I'll note that "small-sized THP" is just a temporary feature name, it w=
on't be exposed as such to the user in sysfs etc. In a couple of years, i=
t will be forgotten.
>
> To me it makes sense: it's a hugepage (not a page) but smaller compared=
 to what we previously had. But again, there won't be a "small_thp" toggl=
e anywhere.
>
> Long-term it's simply going to be a THP. Quoting from my writeup:
>
> "Nowadays, when somebody says that they are using hugetlb huge pages, t=
he first question frequently is "which huge page size?". The same will
> happen with transparent huge pages I believe.".

I agree. Especially our ultimate goal is to auto-tune THP sizes to give t=
he best
performance to user. Having a separate name for small sized THP is benefi=
cial to
kernel developers, since we want to use the right THP size for right
workloads/scenarios. But for average user, it is better to keep interface=

as simple as possible, so that they can just turn on THP and get good per=
formance
boost. For ninja users, I assume they know differences between THP sizes =
to not
confuse themselves and we can expose fine tune interfaces if really neces=
sary.

>
>
> Regarding the accounting: as I said a couple of times, "AnonHugePages" =
should have been called "AnonPmdMapped" or similar; that's what it really=
 is: as soon as a THP is PTE-mapped, it's not accounted there. But we can=
't fix that I guess, unless we add some "world switch" for any workloads =
that would care about a different accounting.
>
> So we're really only concerned about:
> * AnonHugePages
> * ShmemHugePages
> * FileHugePages
>
> The question is if we really want to continue extending/adjusting the o=
ld meminfo interfaces and talk about how to perform accounting there.
>
> Because, as we learned, we might get a new file-based sysfs based inter=
face, because Greg seems to be against exposing new values in the old sin=
gle-file-based one.

I am not aware of this. And it is interesting. Do you have a pointer?

>
> In a new one, we have all freedom to expose what we actually want nowad=
ays, and can just document that the old interface was designed with the a=
ssumption that there is only a single THP size.

This sounds like a good strategy and hopefully we could design the new TH=
P interface
more future proof.

>
> ... like hugetlb, where we also only expose the "default hugetlb size" =
parameters for legacy reasons:
>
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
>
> -- =

> Cheers,
>
> David / dhildenb


--
Best Regards,
Yan, Zi

--=_MailMate_1CC793B5-DDDB-48B1-874E-528E06F8ED5B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmVf/aEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU2YAP/j8GY4Zos2u0zPYV4oLmZfP4HaWgqhZBvJo7
PFQ8SO1a+hpvfjG3yCTD1wRl2cjW4pIwtbaTAP0xRXJQo5HclG1I7/kB9H6llRl5
pe3xmVCxT5H3JqaIHshV652g5MpB0/dT/bJaQqmxijDaeG3ktU5U+I4ylzwyqlsb
lBNTl2ZIiZcJZkNfc1YPLNHi9IsnACGhJhaQE0DzBEv9JRNlKAOS7362s6h6rwia
nzuBZriDEbBJG2UOpha+fMTrOu0vwybL3Pvd1v2hJSVuaTaYzzWwnBo1o6E1SRQW
ekhKp2lsJlVFT5Q704MVvJGDKQowA0q3sHVv0LCJBXUQYtzV0Ptbr8mG66uhkNk4
Iz35bqqyamOcTQw6++j5PlJzIH+TZD50gccpS7e5u2Zv8oeHlv7birLFWUEhByLw
+bWp5hzrppNkvBP26yyeG5hJKGefbTtd4HJZwzOduvnq8iJ4X5YtfoRlhAhzizNT
3FOXht7CYxeDVu4kzycEKwv1mtX2S0HPhmT8uhZ70mUTR6mPvGeaiBfPEzUPosi1
aCmO+zs8Q7zxFah/MAniQvo9Ukk3fuBvDJoalRg37Aejc2prHJ44oMbrhbFOyNcE
t6NtlGGbHqzDugHbW+647QNGkMqQeXTlRRaO4L8BTc8l4VEHqDOisUhK2/GrZSC6
W+EgKZEN
=sN4N
-----END PGP SIGNATURE-----

--=_MailMate_1CC793B5-DDDB-48B1-874E-528E06F8ED5B_=--
