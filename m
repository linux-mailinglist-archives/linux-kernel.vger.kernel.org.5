Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB17A67F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjISPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjISPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:22:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7939EA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkoKFsXt/Y0fr73+Ioj1qUP9BKqNVELXhnMWxH9oRilOqNCbpu0vo7tfomA7hvE/DwrbzAL534A928fGqjsZUmF3rXdjT+yGR7SZXRgaDIcecVGpOkfEFZb+OndHiv8WOmvRQcdnGACY0sIjgHb75WW0Izl7aMkTufo4V7frv3vpSNUZttKLbfIKcsxO+//iEfaPidvf831WDsAhXD+7ksyI91T9TjDXSfC0CwIMvZEB1liTCdYjeJqmME5oPu4jiH99g8Z46/RmJBB2VUQdgRQshVXWhFlKBrx/PXNYtjngbLmDkTZqEgDofZQg17hkzi+z3r12xNpcCku7thM25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX+EZ/mljrgrAwa7AYXjA01/Bo/GWr8jv4Rj//t5MlQ=;
 b=ckBSvRjTFPeZQo7u/DPD9nyELdnR0AA+1Pmus+NZx4ap55IhF2kmOnav196+ZCIzW+7th8vYRhonI4icF0OFLVCmV93gbLZNyKwEIY7lgNkefVj57wKUSUDTl8iLgts30dpV3P8qkA/Z7Wy7gOtL7H8gtE6JShWEWbYBwo5gJGIr7P8kkTyWLd/LxWc9XZ6cr18yhKMWG/yeCFMVt7RKEgVHQuIF5CEviP/DRzm/+UBq8KFZ+pX1XdGLMcxqM0ZuHnL+Kl9bw9j9ZXqJOKkALeelrFpvp6cyEvxtqD9BfQ17qKAoH4prEFlmPiCEvapYD9cr1es99vJuRljMqR9NIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX+EZ/mljrgrAwa7AYXjA01/Bo/GWr8jv4Rj//t5MlQ=;
 b=dcF4OJsrxDafAuG0nW5QEP9/9vfNfi8iuqF+mqgzZD1sjdh4vX/i0i8n/tsrJIyOmGvwwG4eSFsSv/1KmhvYVST36+ouoR3oXSSqPTxb/7G3nRy8HnqdvAfRTqqzHOhnyAuAWjno0HRN1QXE7+w30yypHRrplrk7LoKKu6pQMOtECdMRdrbGCACynXrxndGDONULVRXlgomoX5ZiycJ4iBeNY6W30pZericuHRt12IdieG+RKhu958PkMOIZvDjM3IhR87rI+F7onpklJLGOwnGy1WhP0Kr8avUsNE7LV0pxsntk7WUsJWhinEVWKgJb3c5/kzphj6KnOPJL+1JLlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:22:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:22:24 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Tue, 19 Sep 2023 11:22:21 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <E7EFFD6A-57CA-4FFC-B86B-2A1869E7A48B@nvidia.com>
In-Reply-To: <10988935-A726-41FA-A254-70DFD98EA30D@nvidia.com>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey> <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org>
 <10988935-A726-41FA-A254-70DFD98EA30D@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C239C2C1-B97A-45C4-9E1D-87DCF72D660A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb7bb15-07b8-47f2-cd96-08dbb9243a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VykiKVop++80Q1GdbhFigMYy9f9X5jrW2lK+aUHreD3xB7HSv/BTlr1YbM/AWtdCpSUx3Y9vWWw9AuwYn5iAlEVPaBVRitlfmiWhLkNNQoqAFZy16/ODZYpwsAjpQSKvw+hfl/19Pcpe4GTkZigcr+kmAPjqoCGJGPcAlaFIfArtLWgxtd49fCZ8Uu+He3T3m4Jj+XOoEwblC3aBElJZnNxO06t7OgCWo3KXwGyBxtYUi3FsIY5hUeI2Ljg3R0BYW7wGSFbW+oYaHC4GcWOyYdeiaka10ISvLLAazvLO/EzjSZEBU3znOP57t/vac4r3lh8mHMBKA9J4USq4/SlfvuvFamYn3HtUa6WNnPvfW2QageoyaBYIZS61QOHQueohubMthUIRpFczWCMGjduo/qzCnbuPLSQXfZyloGw1kae5o3NBmzBWa21cr8Lg1OtmDd0D9FAfoevh5uka0/LPcM1WEO+D1t70JVFwQDvYqWONtVO29GYVCvrAH/yLn6iBjjvnRJt62FtKwEdd9+PmQhgEL6EnL0vSGbKuAcOBKbOld56mHkkGV1WoNJQtXmCxVlaOKXya3EZ8XbDYhfTIJMTT+XwTGy8r+5by+QfdAvJTi5EkNYAQb8vK78ZIRUAP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(186009)(1800799009)(6512007)(4326008)(53546011)(6486002)(6506007)(26005)(2616005)(8936002)(8676002)(83380400001)(2906002)(38100700002)(36756003)(41300700001)(66476007)(86362001)(66556008)(66946007)(54906003)(6916009)(316002)(33656002)(6666004)(5660300002)(478600001)(235185007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPyMT+P640+JqKEMUwJd+OFoaS+QoPwpjNE3T4MsLimODjQTVg3XeK72d3+y?=
 =?us-ascii?Q?jXx1lWwvpoQd7Wy18hWYyeguhXahjsVZb5HUNo6RlrG26JI9U2hy7N9Mgzvt?=
 =?us-ascii?Q?u5QBLI2yEQev742LFOXSb3HNKL+mutr3NYlAfBVTvEntKlu4FD7Lf1dvJ+cO?=
 =?us-ascii?Q?jn7AChC4qJavawPCqu2dQmlB9qo8NvPzlEpCrnxFC3l08R9VesbgtCd9N8g+?=
 =?us-ascii?Q?nKKUDbx6A6UXhdmcKcIiBqatNUZA8HVigSbYcCjBWBlMJsqNWQ3nfMTQ2rYh?=
 =?us-ascii?Q?w5vvGGpCPmc3l0s4eRk3wObowy2OJ8al+M3W8pkIRoIAdRp44lyVJZbdh8jS?=
 =?us-ascii?Q?BakyEl9sPXleREOSGZ/WYn6znFU1wwL4j2+RxILQ27QykCe6r2PYGNXCtVEm?=
 =?us-ascii?Q?9yvGjTbBSBaLm3+nhF8MIQqm8KvTrUXmkGZDg1eLhDePPkxDHTPviotFHgEl?=
 =?us-ascii?Q?NrUqodT2S5xjB4KDTvZPaiY00PWSfNqxBHecmYhogI42/KcugoGqX4SscsA2?=
 =?us-ascii?Q?LALrtYEXSdlqUIK77fJcT0SsM+6K4qeE/ZS6lXlhzv5dMpUtx2k1wea8t0W4?=
 =?us-ascii?Q?Jpqtj1YGtx8fAY9QquB05wHzDyl/4biuNcX7q+11/MJDE1RMLtWcpsHGsLKn?=
 =?us-ascii?Q?9rxZm3Dph/ASv+rtrcynUwikLrGx75hNSm7u8v2/VtcPI75RAC0ZQpet5Mfn?=
 =?us-ascii?Q?g4O2/rHWidjq9wInLwZPfYm243FY1OAoahaG5rDsmgke850oomUQrUb6CEcV?=
 =?us-ascii?Q?W4ZgZhMamhblemFBOLJ4dlwJPlYtVW7btfYT8n6Q9Tc+kc27gK7ieojAIpxg?=
 =?us-ascii?Q?ZpWdt2ItjSJ5cGjJxudvJ5sFCamM2mh020HTRoqu+LC+FwUKuCJj35u8tgFz?=
 =?us-ascii?Q?S+qg0mf+zuGvKQ2p7BP/znnXnb+r/FyobtfHD56WDnpGZuNljMYug40Ow7iZ?=
 =?us-ascii?Q?U28ONl4+CS1AOKX+cspZoZg/3sUTCd++oj+Yq3bzGCP9vdsf/aEG+vPW1GxL?=
 =?us-ascii?Q?+f2s5ZFKEx/BYy9PKXooEfH6jnPbx9MeFtSQvrjpKqFfwNvjpsp1q6KeKcRT?=
 =?us-ascii?Q?8zCVTvhdnX4DZo0dxqH5v/MMZTcuy4OZ7/Xoes0Sp7YXzqYQ/5+MnaUxBnCH?=
 =?us-ascii?Q?z3qWdvTgOFaRx8vy433CL4FNe/dR1crIv+tDekBIkkU/1EtS0yWOWUSqmCZN?=
 =?us-ascii?Q?b/RnMt/NAXeS3unMtcs1+uu8SwqnMLXjtw0DefB6x0BUlfnKVLhF2ZHDMLnJ?=
 =?us-ascii?Q?G0okpmbpFjNSaXhCzp8UppSrOHkcxvzRnrarJU++zQ7IhzsEItEAKcC2NDza?=
 =?us-ascii?Q?a+Vlw9vGxdTP1NRMTv3k/6Q4Oy1Qd9n86N2rWhdYHFBsw2/d/ANqA90tZSvq?=
 =?us-ascii?Q?kbvsklJCZa7ShmHz5rio06onYwYaTmeQhHGHPOJlAXLwuLTCQyjjjCVGaZrj?=
 =?us-ascii?Q?93yyW+B+3OvAZCDG745/cvr6fkAerqn/RkYk7df44zHg+rsB4IDtNHskJoKx?=
 =?us-ascii?Q?9ZZ5luepBEVlJQr0w+NPM2RXx+Q12NCsYuuTHJIXpCuciViNzH4VsIYBvvOR?=
 =?us-ascii?Q?0i0xiavlvKdhOAlvwFo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb7bb15-07b8-47f2-cd96-08dbb9243a16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:22:24.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FD+k5ISYZSFYmBvT7glWM1FxX4r2Mqrhmhr74b35lJb88G+xrlQvkM2mQXBScnIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C239C2C1-B97A-45C4-9E1D-87DCF72D660A_=
Content-Type: text/plain

On 19 Sep 2023, at 8:37, Zi Yan wrote:

> On 19 Sep 2023, at 2:49, Johannes Weiner wrote:
>
>> On Mon, Sep 18, 2023 at 10:40:37AM -0700, Mike Kravetz wrote:
>>> On 09/18/23 10:52, Johannes Weiner wrote:
>>>> On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
>>>>> On 9/16/23 21:57, Mike Kravetz wrote:
>>>>>> On 09/15/23 10:16, Johannes Weiner wrote:
>>>>>>> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
>>>>>>
>>>>>> With the patch below applied, a slightly different workload triggers the
>>>>>> following warnings.  It seems related, and appears to go away when
>>>>>> reverting the series.
>>>>>>
>>>>>> [  331.595382] ------------[ cut here ]------------
>>>>>> [  331.596665] page type is 5, passed migratetype is 1 (nr=512)
>>>>>> [  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 expand+0x1c9/0x200
>>>>>
>>>>> Initially I thought this demonstrates the possible race I was suggesting in
>>>>> reply to 6/6. But, assuming you have CONFIG_CMA, page type 5 is cma and we
>>>>> are trying to get a MOVABLE page from a CMA page block, which is something
>>>>> that's normally done and the pageblock stays CMA. So yeah if the warnings
>>>>> are to stay, they need to handle this case. Maybe the same can happen with
>>>>> HIGHATOMIC blocks?
>>
>> Ok, the CMA thing gave me pause because Mike's pagetypeinfo didn't
>> show any CMA pages.
>>
>> 5 is actually MIGRATE_ISOLATE - see the double use of 3 for PCPTYPES
>> and HIGHATOMIC.
>>
>>>> This means we have an order-10 page where one half is MOVABLE and the
>>>> other is CMA.
>>
>> This means the scenario is different:
>>
>> We get a MAX_ORDER page off the MOVABLE freelist. The removal checks
>> that the first pageblock is indeed MOVABLE. During the expand, the
>> second pageblock turns out to be of type MIGRATE_ISOLATE.
>>
>> The page allocator wouldn't have merged those types. It triggers a bit
>> too fast to be a race condition.
>>
>> It appears that MIGRATE_ISOLATE is simply set on the tail pageblock
>> while the head is on the list, and then stranded there.
>>
>> Could this be an issue in the page_isolation code? Maybe a range
>> rounding error?
>>
>> Zi Yan, does this ring a bell for you?
>
> Since isolation code works on pageblocks, a scenario I can think of
> is that alloc_contig_range() is given a range starting from that tail
> pageblock.
>
> Hmm, I also notice that move_freepages_block() called by
> set_migratetype_isolate() might change isolation range by your change.
> I wonder if reverting that behavior would fix the issue. Basically,
> do
>
> 	if (!zone_spans_pfn(zone, start))
> 		start = pfn;
>
> in prep_move_freepages_block(). Just a wild guess. Mike, do you mind
> giving it a try?
>
> Meanwhile, let me try to reproduce it and look into it deeper.
>
>>
>> I don't quite see how my patches could have caused this. But AFAICS we
>> also didn't have warnings for this scenario so it could be an old bug.
>>
>>>> Mike, could you describe the workload that is triggering this?
>>>
>>> This 'slightly different workload' is actually a slightly different
>>> environment.  Sorry for mis-speaking!  The slight difference is that this
>>> environment does not use the 'alloc hugetlb gigantic pages from CMA'
>>> (hugetlb_cma) feature that triggered the previous issue.
>>>
>>> This is still on a 16G VM.  Kernel command line here is:
>>> "BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.6.0-rc1-next-20230913+
>>> root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0
>>> console=ttyS0,115200 audit=0 selinux=0 transparent_hugepage=always
>>> hugetlb_free_vmemmap=on"
>>>
>>> The workload is just running this script:
>>> while true; do
>>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>>> done
>>>
>>>>
>>>> Does this reproduce instantly and reliably?
>>>>
>>>
>>> It is not 'instant' but will reproduce fairly reliably within a minute
>>> or so.
>>>
>>> Note that the 'echo 4 > .../hugepages-1048576kB/nr_hugepages' is going
>>> to end up calling alloc_contig_pages -> alloc_contig_range.  Those pages
>>> will eventually be freed via __free_pages(folio, 9).
>>
>> No luck reproducing this yet, but I have a question. In that crash
>> stack trace, the expand() is called via this:

I cannot reproduce it locally either. Do you mind sharing your config file?

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_C239C2C1-B97A-45C4-9E1D-87DCF72D660A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUJvK0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU2aEP/R6+FgVXDo3DVHYe4is/sQffoNlheSrlIG93
54ZpwUc7c7H682FvUEbcWJ2mCy2X05JfeprVsIcRBI+AIoFpjOUJ6prIW6P/8oO0
dz1khD20fqHf4YUoOOvmCeaSCkx0EcMcpdw35lxY/PF6DUMdAm0DIAjmPAGKI2sl
xTJuZGfmANACtYJIRpadHRVkQrVFyAriE0G+VUe/UjB93IwLDkYvI5Dg0TgYX2Jx
pUb9mBssoYFAHgiYQp0AgsiVYLyLq61oeyTis1BG4f79+SbB4Ym2ObznME1Q762b
a5rYwsiAGGukHVSj3U9BZkiASXJ92i9UAnMLYNRaDCIkEdoDnon5S1cCb2pqsdTZ
J/adrrTqzPGrX/nkE7Igode0bVdnr1ONpgqh+raK9K4vFd2/Fszd4mMUFmvg0mEq
O5iXBjb1MJcAjlhK8jahLZUnPHK2oYQaXhFIty5Q99waM3uBb6pG3Uu735ucat6M
9v/lglV0F9nR1bAffZFOrjpjVVF4kEvTscCx1ViUdRYVGL0gfsDvIHxdr6ulLK7A
svjM9YQXqBDfArAgQFZKDcoS8Wv+sxj66K8iqr1gndtYQiYKWoW3QYnwBj2qrJTi
kNyfdr3HhSLGcLjbKbW5t6I2IaCQ0AEcumoqBkOMXGaam21nKFDX0NoMrXAfkS3m
rSShD8GA
=raPL
-----END PGP SIGNATURE-----

--=_MailMate_C239C2C1-B97A-45C4-9E1D-87DCF72D660A_=--
