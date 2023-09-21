Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4527A9715
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjIURLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjIURKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B8A5D1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxY0fhzAn/FIHva+Aa325UBHa2jaRLfTWk16LSSfEqYkZ3GNa9erKh8ijV6jxdvJGTvzdb6r/QoXDdq/CD8WtVZGBtOjRxhr2QYJ+LmT3fLCcj8HOhtv1gbU63Hfj5tooYfYnIElhvB1J/lJsw6nekzPzh415J4OBzLa6oIsIw4lzVqhm5iyL+w2a6IyplKFqwUvue3LBaYRTk4kZt3czJMSwPO+BQxlYV5J0lp72qtRdAU0hf1l8eY9Z+eEBGG9Z9Cz50BH559sn8BG3Mcg1QTVbQdNhY8GrMhS+2BjOMdBWp409UBrNNpD1FQt8OCRt35mvlWCkRkiKa8nJLx78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh8AvWItyaYLB8dzznOQs3Qfl0/GgzVjaKS54tVgBKc=;
 b=DA1P2aTII+uR4/4pcnoOtf7Xz5ghG/Wh+vsoo62l+hxKK1JD1DigcA6EZyMXrstZ6Lik/AneHSuPKdS098Cz6DIntvF8IABIsV6AJOioYVWU8ZxMxdzErIKf0Aq0f1Utn1YsXZ2+8CuX/hqh1mQZ90zNv7gEMgpn5aYxHVIbhk+D5ke+dEIIWuEcLNKrlxiZBShLdDmp+rRfTv4BkrDOr3gO3j9rhLvSVFwha+R++/+pFw7khgQFg0UpBODR7EKlPPDaHqXWOBv9JqoVxC0NLMWg7iMX9edzRtb7Ivk4rrZN1S4hjNBaAzwhr0F21QfD8Wcv86FFIBisC50b9s1dHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh8AvWItyaYLB8dzznOQs3Qfl0/GgzVjaKS54tVgBKc=;
 b=CqRlPzOl8V2SHbRTDuCWM1gClkRCs/+ELIXv066Cfnu42epCPr0skhdc78msyCnnrdkFdRBJNzB5utcx5LLBqVLxejtLAXjpV4sOysvN65OA/2cXlSzhn41pruuRM9Dgd32woUIEI9MzU4lyRcaYb0BZIIcuvBxbQXaCdWWNUCnfFeUDc0X5ZCHZSfcWZ0yEo9Cd+aGGdPK+OfDwGhrTFQI4yqgUuvRv9OUrDYxa0Lh/fgguTWPBFCs0K+m5UpbJhC8TxWDI79H2ylKAAMfDAAQhL4kE9ln5yCiNPT3QPXromVzYFJqAHUmYI7CoUfVX5/5SH8P4UX23/P4pGqcILg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 15:56:28 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:56:28 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Date:   Thu, 21 Sep 2023 11:56:24 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <F15DD167-94F1-433C-AFC3-EB13FCDEF1F1@nvidia.com>
In-Reply-To: <ZQu1EhQiV8h5Jsa6@bombadil.infradead.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <ZQuUl2DdwDlzKoeM@bombadil.infradead.org>
 <ZQuZdkxm/GMyS6wY@bombadil.infradead.org>
 <5ac6a387-0ca7-45ca-bebc-c3bdd48452cb@nvidia.com>
 <ZQu1EhQiV8h5Jsa6@bombadil.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_FB52B207-17A5-4109-9901-BF7B7E8DF576_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a300742-2188-41bb-84e6-08dbbabb5101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDTtc0t97dCwojIRZAkr+oa5rwZP920oZoRQfBISNVT92Ug8OVHTxumu+yY8eW0GbCVYmAMLCLz4ruC5qiFQfRoSSxY7XvXsPsHbWn1aWw9YCic++aaiOp99MN1PfXrLSyVkhwiR0DvGdbRUFNTxVh3a1DvpAstX1NENno6LwapbEQLOA1tEB/X9MCUWeXSy+WbUrjt3WMGrm6tYIp/dDfCS5FhkQuINKdNmX2xnE/5VkUXOrO29gUENjEjdUfjhKDbUbbwmF0dS2EIb1mkMQ2M2hNd3ovf171ZbBMagiJwtRy9F91BL+vuv1fvu4WFBQzrPzYN+qMutRRc7C2DPSRHK4eV0BjdxHPT6qY9FmxzOTVkEabRJmz0jYvOjpHwnSncBO9U13pF50IFw0jtMy3IgU9hTOY7KMkPPhHAYbb+RTpS3F4VTC6oCAYnIWWuyMGA89p/wmjvc2r6BwyMqIyLhGQWhdPzson6EG645H1D3hVA0lR3htGo+CGQqyqgv/7ZdqxUFdHuLo/M39ci5/UA7Bv55NSnixA6OwHudFzX89DWBHXU+1o3eYLrnpO8nLjEQs8o7XjochlxO/Nx1tq2VYGTAAVH7gKvbokIhYlD2O2RbjC+OgubGO5I7nirk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(1800799009)(451199024)(186009)(53546011)(83380400001)(235185007)(316002)(54906003)(66556008)(66946007)(6916009)(66476007)(6512007)(6486002)(6666004)(6506007)(2616005)(26005)(36756003)(33656002)(478600001)(5660300002)(2906002)(8936002)(38100700002)(4326008)(8676002)(86362001)(7416002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8Ow0j5Sm+w/VhNE7H5JisymVrqc1PxUztGeX/7WNXctUoEP2yavZUFskmLt?=
 =?us-ascii?Q?/88EgzSx/HlTRvcBVZhPLsC1m2bst0qQWKdUScCJZ3cfPyB801fRV16u/fsD?=
 =?us-ascii?Q?o6JzE3o0lu05ucjyKXiqAGzlpGgB6G563LA9J6+RdzCZ90D6MjWDF++CEtpF?=
 =?us-ascii?Q?6nWSaPzwiAobx4jrKffZlA3qlTGaBwPp4olCnBg/zgB4vCZdRgYNIP35tAl+?=
 =?us-ascii?Q?10JAVG5wwPjdTVX38s5Al+STSOBKvgIP+1ISXOkpHWHB+sTP8amqYf3Z7QBw?=
 =?us-ascii?Q?XjO6cEAgPt6RwJi38ft9RFZILxGy0LdxDqJViGWTu/1GH2eiEH48o+PB1Xi2?=
 =?us-ascii?Q?doSi6eTVTetGQK5iisw801sIGQChRsbWBGZklIE5O5dETV8pMJqUw0FmrvcS?=
 =?us-ascii?Q?yvzLFDoA/48uAvetX8w0Q+eBlm0eAYYbx9FYfOnRBweGJxx7WQHTBqfvbvhL?=
 =?us-ascii?Q?d3UktO1aWcpXzsbLLO+DT9rS6MmiiXkITzlXHxxInm/5ArySMHCe+uRkJPvV?=
 =?us-ascii?Q?DvaBaGfmexVpb1y65D7lZ7qm+rkvIWNcyzgkDm++n5EGNKD1aUS63N7Qj11O?=
 =?us-ascii?Q?xUKcb7uK4uF26SRlfDlYk+27GQr/3P0lwHxHrVpa8NCYvr5uusRPw9AG1oFt?=
 =?us-ascii?Q?xVjjngyFNtcyuFmlUVEYzBmwfqoRKQWQNqW8ldRQmEKZo2QwGDWa25H4YK2W?=
 =?us-ascii?Q?LSuk3vZWtyhANo5ymzdgCk6Z9VmxaZrwVRIx86RTq6mvKtReEfbsVJ/I0VOE?=
 =?us-ascii?Q?AujwJldRpPsI9gJB0TY5zbMtUUs9MrW2d+1xwBbN2idQv21j3CnDcIO+8nH3?=
 =?us-ascii?Q?3PdZsltr0TzXpZaE+s4MevvJNo4IvutgOH9SkGoFpqTx3SEyVcdXkJHiUu3c?=
 =?us-ascii?Q?4eL8MrGcWMkSUxVrPZyw3hvRYCD5hG+SealKm5AbsXYE7rMxMJCqcHNZ7D2Y?=
 =?us-ascii?Q?XaWUl5c6ajfaQc5+M0/LZU4WkcaY2trG567IGVPdoAv06rDpaZhYlAO1xc4C?=
 =?us-ascii?Q?v6iXxoaOmpmTXd4N5fWZyhGk8lBW3yfFMH+InFRUR+xlES7ph2mGExUg2s7p?=
 =?us-ascii?Q?xd97hr83jItbCvyRMc7vFO6pfMR87vlMNfnFEBkYkrE2XRQ/wpMmxqOlyXZA?=
 =?us-ascii?Q?XyVv/rgAt00lEfLKMqwx8yWh209x7ppCSwfZtwgam3jenr9yWmiWe2o6gdPx?=
 =?us-ascii?Q?RwHx6NKBX5C3+8jyXl/bYWeFEVKfZvJqCIj9a5bjEE2S1HLvpMzE4Lq/fU0y?=
 =?us-ascii?Q?aDAauigCsFQ2zqxWjturHh+nAuLHPE+ZIiZbZQSPl3jARbO1mzUJ6fmmJzWs?=
 =?us-ascii?Q?NV/WhTOuFZyaIelC5EjzYhvaFg5yb9k4HGPLaPDUjwKGmpjTs+r2yXkUvZLy?=
 =?us-ascii?Q?sOtEgKtGCXVvDfxpcO1oTaX8GtIW3PIVcfQXt9Dij++qPosb4bU1XjsKveBd?=
 =?us-ascii?Q?8cCYWSkvymHysubpLldFTSSHqJkvC3aftY6i9Yb27YGDwfm++egapKcDIlik?=
 =?us-ascii?Q?CGtEbQUJiokx3xs5QGKMrjGrE5w0HeeOxQV/FX3Bu0J2UwUYUwxYu0/2oa3L?=
 =?us-ascii?Q?zbiOGfFtlIxwUEgl4Ynpk0pEFl1PvCxcdlqFhV0H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a300742-2188-41bb-84e6-08dbbabb5101
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 15:56:28.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhJJFFZcUdPMKDHen04/DPKOX53HkWQTMqei7Cip8yLl2p5RsSBLSi8YM2vbAB74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FB52B207-17A5-4109-9901-BF7B7E8DF576_=
Content-Type: text/plain


On 20 Sep 2023, at 23:14, Luis Chamberlain wrote:

> On Wed, Sep 20, 2023 at 07:05:25PM -0700, John Hubbard wrote:
>> On 9/20/23 18:16, Luis Chamberlain wrote:
>>> On Wed, Sep 20, 2023 at 05:55:51PM -0700, Luis Chamberlain wrote:
>>>> Are there other known recipes test help test this stuff?
>>>
>>> You know, it got me wondering... since how memory fragmented a system
>>> might be by just running fstests, because, well, we already have
>>> that automated in kdevops and it also has LBS support for all the
>>> different large block sizes on 4k sector size. So if we just had a
>>> way to "measure" or "quantify" memory fragmentation with a score,
>>> we could just tally up how we did after 4 hours of testing for each
>>> block size with a set of memory on the guest / target node / cloud
>>> system.
>>>
>>>    Luis
>>
>> I thought about it, and here is one possible way to quantify
>> fragmentation with just a single number. Take this with some
>> skepticism because it is a first draft sort of thing:
>>
>> a) Let BLOCKS be the number of 4KB pages (or more generally, then number
>> of smallest sized objects allowed) in the area.
>>
>> b) Let FRAGS be the number of free *or* allocated chunks (no need to
>> consider the size of each, as that is automatically taken into
>> consideration).
>>
>> Then:
>>       fragmentation percentage = (FRAGS / BLOCKS) * 100%
>>
>> This has some nice properties. For one thing, it's easy to calculate.
>> For another, it can discern between these cases:
>>
>> Assume a 12-page area:
>>
>> Case 1) 6 pages allocated allocated unevenly:
>>
>> 1 page allocated | 1 page free | 1 page allocated | 5 pages free | 4 pages allocated
>>
>> fragmentation = (5 FRAGS / 12 BLOCKS) * 100% = 41.7%
>>
>> Case 2) 6 pages allocated evenly: every other page is allocated:
>>
>> fragmentation = (12 FRAGS / 12 BLOCKS) * 100% = 100%
>
> Thanks! Will try this!
>
> BTW stress-ng might also be a nice way to do other pathalogical things here.
>
>   Luis

Thanks. These are all good performance tests and a good fragmentation metric.
I would like to get it working properly first. As I mentioned in another email,
there will be tons of exploration to do to improve >0 folio memory compaction
with the consideration of:

1. the distribution of free pages,
2. the goal of compaction, e.g., to allocate a single order folio or reduce
the overall fragmentation level,
3. the runtime cost of compaction, and more.
My patchset aims to provide a reasonably working compaction functionality.


In terms of correctness testing, what I have done locally is to:

1. have a XFS partition,
2. create files with various sizes from 4KB to 2MB,
3. mmap each of these files to use one folio at the file size,
4. get the physical addresses of these folios,
5. trigger global memory compaction via sysctl,
6. read the physical addresses of these folios again.

--
Best Regards,
Yan, Zi
--=_MailMate_FB52B207-17A5-4109-9901-BF7B7E8DF576_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUMZ6kPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUYkcP/3G0z0EERBH/iUJaRSnlJNtPUC2MBD+DTzRT
tbqtvQC7UBsd9STrgSn9NSyyazO3uxMvRUQTXh3vOUxqfKcydIs4c/RwssYh70x9
auf7MY2MAqpinm5drD0EgcRAmwkW78lPqI+vMLuIqlaiahTiPdAHn3axZV7BD4Y+
c7j1/czwGHZ8IW5reUZspG3CTzAN+xGAz4QskMGLsFmVE+MFw0XWvkmhlp3BCyaS
2YoAmnXmt117Mf+fDBz2Ng/5tqJn+2Yr/51hlQqj+Fc2TSODcoH2TkMjGxhrCnll
OgoAYO7UFze8vWubGpAD4UxAcJyCUq4fMW8KE7Mx11LIAaN1fH2zjlMi71gFWrRU
ynaGXGPEuRvP9zmJJwpSHibatpoJzbOyiW2/4/EN6yAjNFBCEKdiimgewrB6uwsT
lJYO4Ur5e6oFpIEDfL+0NfLglZtDSgX6U3csd4u1ldHlEnrCk+75BKu5X0GKkhdG
HX/vmrA/bo/iCqdTxNGpN2PqeO9m5izhSA4QCVLrhealuSG2fB8yadImgwoVP3Ks
Qs6uE9sN/QOTQlys2SvefTWs8rXNvc9k704QOL+OIIyMwgl8qOwAEQZRxsnFtrrl
ityhp42PHHHRVg3BB7vJTaO2r6MzxA6Nl3X1b+Iaxqj13BcbjK6TyER+HDrl5xGN
oLC+ZCBi
=5qhO
-----END PGP SIGNATURE-----

--=_MailMate_FB52B207-17A5-4109-9901-BF7B7E8DF576_=--
