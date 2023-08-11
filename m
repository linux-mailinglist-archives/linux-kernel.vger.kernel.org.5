Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7B77929E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjHKPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:14:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5263730D0;
        Fri, 11 Aug 2023 08:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyO4fTgYVl+e4Fsb+ACfVctQmH45xwbwTjrERLHtMW+nVs6kIapBXrgzF+YGCIecqG9UZOe1VHDnjgJzmzX5KtYxfv4Jd8anJFiTO37+FnSDMFIlGJG3214SXWasbWQrEf28faWtK0tPjtfvNwxM7ZkFsoEzZkRaAt5xLHpJlvlmHjjwRsmaPtcOiNtkILQEZ/NePNFctdEGogmNmkxv+LwTXBAVYymKxw9Vd1Oayw/PS2duLPWiRbwau/40I7b7vVUBPgAFBFKOhDPxUled0fbUEze0yjWFVI9v4uSvPQvFaQitvYTYDtKTstCcs3M71xyhXWSHRcBB7qD9xtgldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2erC5/Wn5uWA11Z3HG+Pmw48mAIOgmzbJ/xIhEv7es=;
 b=WtRnonwPpdHeXJ+b3Sot2XZwjrRGgFQ8i2ZNgIkbDDeNBOj5DhyJWnmlJKeWvRDqDQ0NwvnQDdBWwu5842B1Z6S+1YJQ61fS0VVXbR5+hF6yK2zr8U9OFjj+lkkmrBIaIPrBapL936VSoGqILPI190NQeaI5rBChqZjseQCwJc2QUqZa3KXEONuj+XupBVxB6pHEBkWF6ykOG6SetQ6WtuFctFuXrmusasmf84me58qCInM7v8QaOOXzDn2UgzslF/QTBAhICC6epPPydYC7veHe+Tx23aR1FYa+BTWBOXFvRDAgnp82K5odgAdjKEmtWGVReZRZKLWY8WSxVSSxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2erC5/Wn5uWA11Z3HG+Pmw48mAIOgmzbJ/xIhEv7es=;
 b=VgeDef846RNXxJdblktidiMQTrh6nmvhL2zvd2pXE/2TzjsIx6tpbYw/p+t7u1XGpl8IsQFeLSXemYGJ6ijuB9CZg2afzvh04paNMjYmoFwAft/A8lCJxxvFE30QPr/T9PUETT6XIFxTr7wPe8e3AMF1RWdaa4L0SmJvWrtJMl6bc2XXXoluItMuJR3pmqrpxRmy133mMec4nL+NvMMgjX5TCWcgcxuFZOXEyb7mKlLKdM223CmMLsmb2rwGsjHLhaihzu1T8QCEARL6p5us3tw5HXiKRU657jwZiRyZlsK5VQ/BEqLwZ0i6Co9PIv05sd+GL0YsshTlf7Mok0LhJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:14:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:14:41 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Date:   Fri, 11 Aug 2023 11:14:39 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <9D4A9EE8-8CEF-4B08-9A32-149B6C548AB8@nvidia.com>
In-Reply-To: <ZNZNuooaFH9P4raS@x1n>
References: <20230809083256.699513-1-david@redhat.com> <ZNQD4pxo8svpGmvX@x1n>
 <ZNRYx8GhYftE4Xeb@casper.infradead.org>
 <7e31254d-8889-7e79-50e1-2630bd493d59@redhat.com> <ZNVbIyHcqeKUDuSg@x1n>
 <ZNVcfdH8+N5Q83J/@casper.infradead.org>
 <73d6d29f-9947-9b50-3b94-77f1ee547387@redhat.com> <ZNZNuooaFH9P4raS@x1n>
Content-Type: multipart/signed;
 boundary="=_MailMate_6E3800E0-F9D0-4996-BFD7-F4A73F9A56DF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f072c1a-ed3c-4b52-e165-08db9a7dafe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ie5ciENNOnjIO/NGjObsEqi3yn4scUWOCToEk7jkYyJc1A6Aid/FYPptxaAY/amQLps0bz80yhdtVsfL3iexsehHneWTJjCQdDtIUG6c5xiXxSrRwhk/TwDazR0Uq2+TA0llHpmRhF9eZCiE603uaA6s5r2nLxFq9+VUlS5+5/sjo3mlAmTIlbkCfa8Rw8rJBZh0jHzscNCJKq+Tbs0u2AlUX/+Tz2FzibRBgsNLWRUZzzto8INvklwpqrAa2P6CHPiPacm911n8hJlnIxMeSmrcSW5ZEII7l88ypP2vO9vp68tz0zU2CbijT61VWnq42rvruvfHgrqlcxpGhYil64cTlaC1Jd0otsaiLENGgOqkM3wlKW3gYM4gXyAzlwKA18aojrSZi4eBr9unx41iTrGffnNJFTFp3n14OjCyYHKCOFxh15BtYiarwQwUPP0Ev6a7MyHDxCvrC9N8A5CGipOrRk4zwbHAivoT4VczY8tCT92zsdYO1+ZV5yVlqYFoNN/ShY4qfkR/09Mozp/EKKdtFDgRNS9cq/TTikTRrlVrfpAbkZ1zDrnL4OtVZJcsysog12qJwHFcSTsa2w3uFmCTJ5quvYie6p0AhUjniHDuAo4qrfbRm8VV2NDn57ly8H6eWnzit0uvMRi4BFff6tBULdn54G+HlYXcZrQy+Av4ALvE65LKV6opp66aYOP2UanqBUc4iE1ZQQIrNgdp36xT34ozySs5D/IrMQpjJ0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(186006)(1800799006)(6512007)(6486002)(966005)(478600001)(53546011)(6506007)(26005)(54906003)(33656002)(2906002)(6916009)(8936002)(7416002)(41300700001)(8676002)(66476007)(5660300002)(66556008)(66946007)(4326008)(235185007)(36756003)(38100700002)(316002)(2616005)(83380400001)(86362001)(66899021)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jIHUBJ221n9MtsSIllhoORcPdljqdjoUGjhvV5goSoGv/F5gqPT69x1LcSYW?=
 =?us-ascii?Q?GfiXWSo9TuDeGZ3NQ5WV31a2ReWbKEHK4RSfcrKgZewmjTvCk5wugI3DKznL?=
 =?us-ascii?Q?A697Awp+6Cv4NZXQjxFvyG2tnnSIGUQ8fxD73TIClZalF4XrwocoNVrssq6M?=
 =?us-ascii?Q?4+OPq0OjARxYopQOrIxAnHtkMXMin3Z02xemBbk1HTMwKgKMa092ibXqtPF7?=
 =?us-ascii?Q?4/+GbaKpMVeVW020ugwuKrZNuNHkTo4WiVmjdWtKQUG1J/njrNTfENtk0L4P?=
 =?us-ascii?Q?87ofizUY1EaMApwiyue4tRn2WBSnmU0QrBvxZUfI/K+r1U4lWwBwjw6y6sSb?=
 =?us-ascii?Q?S/MYhiLL/wkp0C7NTyJkTCYqkl+hyx1qqcgeMJmHcSIah8sEZ15GnhFKEJok?=
 =?us-ascii?Q?OhNvDLTtJ/9oNGv0HHCmiPZOblE+luSx4H14Dy2tx9/rkhsFRIHjyugYWfyx?=
 =?us-ascii?Q?r7unsjjzSbaNFSR+kX8aGdIgbRFU2vG9S8S/wz5+nAq8uCmjSi0vBXG+cT5h?=
 =?us-ascii?Q?bdv+rAnjHFDv1DPP517Rez2pdQOGVtjpjB5pvwPVJuzcYIFHQdDoqN9HbwSL?=
 =?us-ascii?Q?9C6fnM4CWywDMB+rwYCbFJoofX8uq+JuzR0gK0LmlArt3bukIfFzv3CchQ39?=
 =?us-ascii?Q?MQTzjf/qOiF3rUs+cIHD0EwroVhD4MV9m5sqj9jjbS0w1voKEe95JA/6Rf1a?=
 =?us-ascii?Q?EGv5UdlLcpxBRtpSqozUweQP2016dFr8ixiJKNAQl/rdpuapPhr5mXUrbRkb?=
 =?us-ascii?Q?VzDeDAzcgIMM1oGwiH1V+wLbapLYkLLG3o+rpWwkb+w4LFZT7S7QC0+rBHih?=
 =?us-ascii?Q?npjW81f1/rom9sKJu8ihgYNJiX2dqjC/Oo6LYU/bu92by500aX6Mbq0HuWqB?=
 =?us-ascii?Q?2nAQ9YXHgxkWC5cSboFGBTA4Dzbu0mV6pWMggN9NTz+ThSZIvNQP2ifqy7AR?=
 =?us-ascii?Q?tfIykzW3hPH66XfKe7D2p3JcpH2Hyauko4vux0cgBb1HcgmiV07RELRhfe/c?=
 =?us-ascii?Q?sc05HgXwDSrn3vKtSaQXeJH9c9q0TrzIhKzdxO6Huco52rxv58HmOpT3va8Z?=
 =?us-ascii?Q?qNgLlbDdA2gClVL/Ocw5vW/mADhlX4aSjFJnAroLL0wN9U7b1m2uyK+wpRVh?=
 =?us-ascii?Q?XvD3immcyzUGQ8Vp14+gX5OT5gaFi6S4LNABEq9h1BhBcAbMQjj+SpW90AwT?=
 =?us-ascii?Q?nLurw0b2vlHyHkMJ1ezI9xj8eTSKooFrgLW14cZqyJGv8+D88//bq5Uwm8Ke?=
 =?us-ascii?Q?P68tjqGK8DIpzVB7HBqd+5t1f/ekITLu/0HkzRDiVWnJktYs81+T3Ml0iAq+?=
 =?us-ascii?Q?qOq4NcrZyzUgo7XD7xMlS4cpAJzn2l7pac18v+wuECOz7P8tbzgghtShO1kZ?=
 =?us-ascii?Q?0R3FiYNM91YPbsZLR5S4YQgOc2D5hkGD4pxhgHd07jTfD1WkETTev3gzpoRV?=
 =?us-ascii?Q?i9FEQ6xXCiFg9tFn7hwnjdPn0FJd33TSHJK/bcl9p5VqB6rolntg3qfqQLto?=
 =?us-ascii?Q?y06kI2TdmdAWrZj0ow4YKtDEVQMGY+CI6V3+EYrUFPxZZB/3CnHguc1b2hgo?=
 =?us-ascii?Q?zae/M+9C9f6EDzNjGc2+W8Hehgkm0T9O1UCrqld3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f072c1a-ed3c-4b52-e165-08db9a7dafe8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:14:41.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3RQChPGHh+pG3xhTRkxC1d4G24hVufyGa2kdWgbPOTVWMSQ1kySEOcHDtk6pCt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6E3800E0-F9D0-4996-BFD7-F4A73F9A56DF_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Aug 2023, at 11:03, Peter Xu wrote:

> On Thu, Aug 10, 2023 at 11:59:25PM +0200, David Hildenbrand wrote:
>> On 10.08.23 23:54, Matthew Wilcox wrote:
>>> On Thu, Aug 10, 2023 at 05:48:19PM -0400, Peter Xu wrote:
>>>>> Yes, that comment from Hugh primarily discusses how we could possib=
ly
>>>>> optimize the loop, and if relying on folio_nr_pages_mapped() to red=
uce the
>>>>> iterations would be racy. As far as I can see, there are cases wher=
e "it
>>>>> would be certainly a bad idea" :)
>>>>
>>>> Is the race described about mapcount being changed right after it's =
read?
>>>> Are you aware of anything specific that will be broken, and will be =
fixed
>>>> with this patch?
>>>
>>> The problem is that people check the mapcount while holding no locks;=

>>> not the PTL, not the page lock.  So it's an unfixable race.
>>>
>>>> Having a total mapcount does sound helpful if partial folio is commo=
n
>>>> indeed.
>>>>
>>>> I'm curious whether that'll be so common after the large anon folio =
work -
>>>> isn't it be sad if partial folio will be a norm?  It sounds to me th=
at's
>>>> the case when small page sizes should be used.. and it's prone to wa=
ste?
>>>
>>> The problem is that entire_mapcount isn't really entire_mapcount.
>>> It's pmd_mapcount.  I have had thoughts about using it as entire_mapc=
ount,
>>> but it gets gnarly when people do partial unmaps.  So the _usual_ cas=
e
>>> ends up touching every struct page.  Which sucks.  Also it's one of t=
he
>>> things which stands in the way of shrinking struct page.
>>
>> Right, so one current idea is to have a single total_mapcount and look=
 into
>> removing the subpage mapcounts (which will require first removing
>> _nr_pages_mapped, because that's still one of the important users).
>>
>> Until we get there, also rmap code has to do eventually "more tracking=
" and
>> might, unfortunately, end up slower.
>>
>>>
>>> But it's kind of annoying to explain all of this to you individually.=

>>> There have been hundreds of emails about it over the last months on
>>> this mailing list.  It would be nice if you could catch up instead of=

>>> jumping in.
>>
>> To be fair, a lot of the details are not readily available and in the =
heads
>> of selected people :)
>>
>> Peter, if you're interested, we can discuss the current plans, issues =
and
>> ideas offline!
>
> Thanks for offering help, David.
>
> Personally I still am unclear yet on why entire_mapcount cannot be used=
 as
> full-folio mapcounts, and why "partial unmap" can happen a lot (I don't=

> expect), but yeah I can try to catch up to educate myself first.

Separate entire_mapcount and per-page mapcount are needed to maintain pre=
cise
NR_{ANON,FILE}_MAPPED and NR_ANON_THPS. I wrote some explanation (third p=
aragraph)
at: https://lore.kernel.org/linux-mm/A28053D6-E158-4726-8BE1-B9F4960AD570=
@nvidia.com/.
Let me know if it helps.

>
> The only issue regarding an offline sync-up is that even if David will =
help
> Peter on catching up the bits, it'll not scale when another Peter2 had =
the
> same question..  So David, rather than I waste your time on helping one=

> person, let me try to catch up with the public threads - I'm not sure h=
ow
> far I can go myself; otoh thread links will definitely be helpful to be=

> replied here, so anyone else can reference too.  I collected a list (wh=
ich
> can be enriched) of few threads that might be related, just in case hel=
pful
> to anyone besides myself:
>
> [PATCH 0/2] don't use mapcount() to check large folio sharing
> https://lore.kernel.org/r/20230728161356.1784568-1-fengwei.yin@intel.co=
m
>
> [PATCH v1-v2 0/3] support large folio for mlock
> https://lore.kernel.org/r/20230728070929.2487065-1-fengwei.yin@intel.co=
m
> https://lore.kernel.org/r/20230809061105.3369958-1-fengwei.yin@intel.co=
m
>
> [PATCH v1 0/4] Optimize mmap_exit for large folios
> https://lore.kernel.org/r/20230810103332.3062143-1-ryan.roberts@arm.com=

>
> [PATCH v4-v5 0/5] variable-order, large folios for anonymous memory
> https://lore.kernel.org/linux-mm/20230726095146.2826796-1-ryan.roberts@=
arm.com/
> https://lore.kernel.org/r/20230810142942.3169679-1-ryan.roberts@arm.com=

>
> [PATCH v3-v4 0/3] Optimize large folio interaction with deferred split
> (I assumed Ryan's this one goes into the previous set v5 finally, so ju=
st
>  the discussions as reference)
> https://lore.kernel.org/r/20230720112955.643283-1-ryan.roberts@arm.com
> https://lore.kernel.org/r/20230727141837.3386072-1-ryan.roberts@arm.com=

>
> [RFC PATCH v2 0/4] fix large folio for madvise_cold_or_pageout()
> https://lore.kernel.org/r/20230721094043.2506691-1-fengwei.yin@intel.co=
m
>
> I'm not sure how far I'll go; maybe I'll start working on something els=
e
> before I finish all of them.  I'll see..
>
> Not allowing people to jump in will definitely cause less interactions =
and
> less involvement/open-ness for the mm community, as sometimes people ca=
n't
> easily judge when it's proper to jump in.
>
> IMHO the ideal solution is always keep all discussions public (either
> meetings with recordings, or shared online documents, always use on-lis=
t
> discussions, etc.), then share the links.
>
> -- =

> Peter Xu

--
Best Regards,
Yan, Zi

--=_MailMate_6E3800E0-F9D0-4996-BFD7-F4A73F9A56DF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTWUF8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUH+YP/0bDLQeE5iGqZmI/A5O0o72OlUekgbr84kpI
iObR045d8OyKoWoJtQo+Y9szMQh+FXCMGW6tY+9HH/C+knXYMiIcfWTHO5N633K9
S539hSrcQSCgVH4c/wMo7ejgN0VIBIKFKkZ1BXmTMLryBagfjjIMTnyeXkTHgC6C
RyKvXJEfv9SmSAMgJDFFfbdSt1yILSBjpH8+RIDifpZRUEYvmZDiuyuDkYQ16t7z
+wHwSiXVNNyEGEf3CdxTFRkgZKrQ7YOx1iIOTE1DQkoaSqQip/FKKtXp3GGJs8Yl
sWCVxKUYCuFj1kfKl4+xaRrS4liG2wnVhrIemVck2P/mphBSS92FVrk8jo8qmPc6
R1ogcYx4mi9s7pCtwytnWYdLn+E4eWy2/99EPjR9UwxgLZLycH0MOh++gL5xz5zj
66lt6Qw7MmUBsTMY4FmnB6pc84eP5fYKdARaoQs2j/kgThPtWOz/Q1xxql16joqM
mH/Ch4upKgdG2IYzHh+uXderYW9UHikFzrMJMrbj1qgq4tEJnAFz7SxH3v17rn+z
MVFElcflbiIWsZjpY2EJvExX8zCF/dHsIK6a8GiIyXdGgAQBkG4tsCmhdBHFVctH
yTHLEZbX4bKmrgTMK6DTNAKVBnPH70LYu6zm+vn3HPvl5Cagj6rXPXU5C7dvdmxw
DTncHBLj
=skLA
-----END PGP SIGNATURE-----

--=_MailMate_6E3800E0-F9D0-4996-BFD7-F4A73F9A56DF_=--
