Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741FA759A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGSQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGSQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:05:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31D10B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYVejn5RzK8hj0EE67Dod8HOahCHfgpipLT7WVYCMJ58Yo7IHgCUilowFuI/jgl5KyZxzsANb3IoRQYeikvsmbwDtPEce8BN2YSYbm9y2W+ucUIZiH95U/krpzt2Ir9hvzfa6c917nkQ2QOVRasPn0th7a1gEuXmEXo0arJxE4zCaWP8cGUm9gc/wiRfTXt3MK8rTBhdYMfFX5XEHkIc7Dag8FvP0zRrnDJDfxYCzcJkrK2HYMk9gQVCCHg0ajdyZ/EBDe5zj7xaeWVTep/7tYD4vGO9L7fmJUEOCWK443U+gvRL74QcTYtLZvVRaRUugl3i8oTHjgqX63Rh9hiSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW1jFcfFh01eVKrChpGffNMHXWBRGGyxeCeWPthCUeM=;
 b=Sr/IYAjZH8RcCdk9fzHsTCMNQtYmvoGZcks8B2ZFASp6GJ0gBK+SFHw85OjaZSpnQzCzm3bU299W1S//MIFiy3evGUvdQg2Xo6RNvPZ+9oy1bQZk8UpuG0rYKHWWm5Xn/Dqsng6gIcDMAzWpZrap+vPHdp38lSRkamJQAI/10hcbtBcXKMck+5UdjT5PzKIG7lGQr7weKPhNe+SLSFg5ZuV3FDwUGvZ3qN294ackTzm+jhFzAfAs1F8ubV4nxEsmOkpehNvC+iA7yVpx+adoO4AzYQalUC35w1J6YHqtfw61W3cPFlIQhiVP6+Rb61sf7PUurovXkmf0a7sa7ke46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW1jFcfFh01eVKrChpGffNMHXWBRGGyxeCeWPthCUeM=;
 b=QWuR+oBhExQo4aykXz2vQfQNUMNnWnZKoGiUln93dynlxJyltcHB+pfVCP4iToxhwl4onQr8uJ45X5R+qBv29thKpTao59bqmC7FnywQTGRRKML1j2Jab9s/bzg4387IomrDJBBBTbYs/XECJNmMBSmOHB8whVtKC5buZV/Moq5r9h7lIXUBUI9a2xFogx0baLL7YWEEC8M30Xf2Vx9xDE9P78NYVjxMThd6Hcn5HVWz9+bHzb/aKHLyh32Hf4mxv/9BYyozwyuHG5dEQM+4h95TbmHxEIh8f2pIR0pchbz7EQOL70BFcwyRkwZ7tlDnm4rvoFCcsqmGyPPTW4Bf+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Wed, 19 Jul 2023 16:05:21 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 16:05:21 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Date:   Wed, 19 Jul 2023 12:05:19 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <4DD00BE6-4141-4887-B5E5-0B7E8D1E2086@nvidia.com>
In-Reply-To: <a8f567b0-3501-7f1b-7e14-e0e5fb205a59@arm.com>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
 <ZKgPIXSrxqymWrsv@casper.infradead.org>
 <bfa13f35-bca9-c4e8-25f3-e8021f85f223@redhat.com>
 <C56EA745-E112-4887-8C22-B74FCB6A14EB@nvidia.com>
 <a8f567b0-3501-7f1b-7e14-e0e5fb205a59@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0B6EAF4C-BE8E-4112-9959-3825253B2CEB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:208:239::32) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: b0229237-7174-481c-1e6d-08db8871f443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk0feHGp/Cf9f7GjnmJfCZGOXJNHoO4yo0UxvYsBdhQjj3KagePvwS02+LcO3LjZuc0CpAQu2P+OO0cMLl/0benKvtv+xfQ82z9+SIhUtSGw7wEPXAgCmaWysq/0VLGCSJRChOK2ioij/ZzouNnZSUVE9SVTRSWGxiWB6FFdUT9jxZlsJvS5ruGXozhg3KdGbfmhlHNC3UbYC8M9maHxB4RbaZnLvtn3r0/EdPrfu8hbNQOkPDKMqg0qSpQqODVhpEumCB/WraFTOxw1edKvGAP9mReYalzkyN5ulXUAYeV7djuMG8agbB8UR0zeZk6zf+NAuk7Gh4o1wOk2pyh49/UG/SwTjju5CbCSl6kRV318fQbhwcBYAdU8FOzUjwKPvSf+Lt0TTWhMpLNeZ61M6IxFZdf0dXJ6JmgYjgFhAv2elDVP35WqIOmzhzW8Q3qgRIG65vshlItFw+B7iKqN0q7tGlN1aPC++KXQLtSw9h6wNZxB4K29LmHBDUHtMuOAgZQG95C9RSBrVU1r8KoOTV514A3h1Voog+9KiRCZlIdeAT6GzKxEBSyNYen9Tmm0vPghhQ2o4zKaExwWR4cJg8QHsmJ/mlAjlc1zWleh8/clWgjRG2lqCgijgtbTKQ+7mGWT+nLLOYKYGYeV/1H9IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(478600001)(6486002)(54906003)(186003)(6506007)(6512007)(53546011)(26005)(2906002)(41300700001)(7416002)(4326008)(6916009)(316002)(66556008)(8676002)(5660300002)(8936002)(235185007)(66476007)(38100700002)(66946007)(36756003)(33656002)(83380400001)(2616005)(86362001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QX/ZLp5fqMcucd1tZJkmgj6B8Q8ltUMsEMQyVS74AwkkIIdZ2b1cfMtvRcee?=
 =?us-ascii?Q?pb/Hj4AYeF1Wyp2zphmrmQLdiJvkKs35F1WcYGzJQMbBCZBhQZSas1XLAAFl?=
 =?us-ascii?Q?if60iZsC/OJIcTvFJuNmGyWta8GHG97EtXSretvNfZE2M3VbW2QMHjL0n0Jq?=
 =?us-ascii?Q?/NHYTxdIcXHI1VobHAMSOl9LGUWnlfGe0ouXJTYPcFxst4/L73y87ir/0r9/?=
 =?us-ascii?Q?+OcaeTxmx44TxQ4NzlizsAAAj4x6SYXYQNiPlhzBFTqkLNitjyPMEwuFLMEF?=
 =?us-ascii?Q?aK+M0RE9G73xbrFdiNBgOXoBDdzAVTvUtAEze2tE7zNZsWdqZYVatl+wYT2d?=
 =?us-ascii?Q?hxOSEiJsfWvUyRpuwJX2R6IW4Lpg7in+C7c5SjKDuk+/VGVSofuDCODC8Ka3?=
 =?us-ascii?Q?N6YrX9i8h9+8x49prcqKcE5MveF0tIVVK9t4egwA4y9u3xUeN/sA5pTGWRld?=
 =?us-ascii?Q?DXUkebQAeltFiLaF1B+M4Q76PZ6k8+FxhiJr5CqeSLGjXC/MTQxW6DlNijz6?=
 =?us-ascii?Q?/JO5B8+HWO/76DDU/OivxI36sHhbqstmz+1ZaD2FuywIYypFNZPDYZTmB7kx?=
 =?us-ascii?Q?XL+PKbmye+EmD2r+Bb0D/FUJJ8QzkUS607FvtU0dxFu/+amAWnC9VokdFu7a?=
 =?us-ascii?Q?YBk9pi8l1YmufCRZiaVHMVidaFu9eBAs1GfpIrzyjg0Xqkc1poxaSmULXEsV?=
 =?us-ascii?Q?BgTy+qeTlD+oME6tvQlCdbl4MCdxwGpVBNS/0aTSQPhKJMNgxllWYiylZmWj?=
 =?us-ascii?Q?t4r6/jh60CHY8MAkLKMiI2m/KfyxRxFYldBfaO+il4OG26hLAoPgOljONmkX?=
 =?us-ascii?Q?+AnMhub2jCshQdLlcmZub52IkweH243fmm3FFazFQQJzjfJIJwPPb2bsRAOi?=
 =?us-ascii?Q?7Wf2/L2NZiS47vV2IEHZbjB3C4XgLtlVZoYBdZqo/6LbPDLG3h8t5p1nJSTy?=
 =?us-ascii?Q?pA8sdy+6uD0ekaj6NXnjKCH9Eh5VrGJLddhJjQ8h7LpJ6vNzWetu67ut53F+?=
 =?us-ascii?Q?nDci7V6yiQDDZZNi9YCc/1qhpaB77V49RHqLPgk+FlDSqwllyUFwSqP5a3yX?=
 =?us-ascii?Q?CXzE3vHzFVSy9xYFPWfNsPhk4GpHaN3NvnQa2McxYTx+tZE02h8DRIvY3n1U?=
 =?us-ascii?Q?tgxaMHBNILOYQova+VV3LtrJFUufFbivsFhMNaGCt5Uvr38Lqq64lLLoBgsJ?=
 =?us-ascii?Q?lmPfhfYC0Q9AoVSuF30199XujpPnaYoctGUE6/hOXGXzOzVsbi1QR+eLoKgi?=
 =?us-ascii?Q?C05a2yQDJDgMjavzHgoIvPaiCtZrvnn9rzMNZFCy78jnB/uG3TWCuYR244Dl?=
 =?us-ascii?Q?LuTNZPgplzE+XBwr/PFWhvk9Gr548AD9mrSdLp8+vV1x879TUpd/vQtGOv5T?=
 =?us-ascii?Q?XlHOHrS4Op/w9XOfzafQ9DmegenTqQgBO9IvChjjiOyJwxboMk/I2Dca4JWR?=
 =?us-ascii?Q?fN6HzgTiFxL/4/D2rAAqlRhM0ColRM2jzxOAXdLfOK0DdS2pYzrE/KDltzIV?=
 =?us-ascii?Q?chMNF27YtnbrrJ8H3fqxFevBFgY4qGawyX67zWy6hNeGpnZp9wzISVItrgbN?=
 =?us-ascii?Q?f0CcbfK+5xKv4UJMh+g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0229237-7174-481c-1e6d-08db8871f443
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 16:05:21.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +93sBmrdPdsNosJIjpMR84DzmHXWMM+b0qN9bQ1ZMcoZduY6Mj2GuWaWsSSN+Dcc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0B6EAF4C-BE8E-4112-9959-3825253B2CEB_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Jul 2023, at 11:49, Ryan Roberts wrote:

> On 10/07/2023 17:53, Zi Yan wrote:
>> On 7 Jul 2023, at 9:24, David Hildenbrand wrote:
>>
>>> On 07.07.23 15:12, Matthew Wilcox wrote:
>>>> On Fri, Jul 07, 2023 at 01:40:53PM +0200, David Hildenbrand wrote:
>>>>> On 06.07.23 10:02, Ryan Roberts wrote:
>>>>> But can you comment on the page migration part (IOW did you try it =
already)?
>>>>>
>>>>> For example, memory hotunplug, CMA, MCE handling, compaction all re=
ly on
>>>>> page migration of something that was allocated using GFP_MOVABLE to=
 actually
>>>>> work.
>>>>>
>>>>> Compaction seems to skip any higher-order folios, but the question =
is if the
>>>>> udnerlying migration itself works.
>>>>>
>>>>> If it already works: great! If not, this really has to be tackled e=
arly,
>>>>> because otherwise we'll be breaking the GFP_MOVABLE semantics.
>>>>
>>>> I have looked at this a bit.  _Migration_ should be fine.  _Compacti=
on_
>>>> is not.
>>>
>>> Thanks! Very nice if at least ordinary migration works.
>>>
>>>>
>>>> If you look at a function like folio_migrate_mapping(), it all seems=

>>>> appropriately folio-ised.  There might be something in there that is=

>>>> slightly wrong, but that would just be a bug to fix, not a huge
>>>> architectural problem.
>>>>
>>>> The problem comes in the callers of migrate_pages().  They pass a
>>>> new_folio_t callback.  alloc_migration_target() is the usual one pas=
sed
>>>> and as far as I can tell is fine.  I've seen no problems reported wi=
th it.
>>>>
>>>> compaction_alloc() is a disaster, and I don't know how to fix it.
>>>> The compaction code has its own allocator which is populated with or=
der-0
>>>> folios.  How it populates that freelist is awful ... see split_map_p=
ages()
>>>
>>> Yeah, all that code was written under the assumption that we're movin=
g order-0 pages (which is what the anon+pagecache pages part).
>>>
>>> From what I recall, we're allocating order-0 pages from the high memo=
ry addresses, so we can migrate from low memory addresses, effectively fr=
eeing up low memory addresses and filling high memory addresses.
>>>
>>> Adjusting that will be ... interesting. Instead of allocating order-0=
 pages from high addresses, we might want to allocate "as large as possib=
le" ("grab what we can") from high addresses and then have our own kind o=
f buddy for allocating from that pool a compaction destination page, depe=
nding on our source page. Nasty.
>>
>> We probably do not need a pool, since before migration, we have isolat=
ed folios to
>> be migrated and can come up with a stats on how many folios there are =
at each order.
>> Then, we can isolate free pages based on the stats and do not split fr=
ee pages
>> all the way down to order-0. We can sort the source folios based on th=
eir orders
>> and isolate free pages from largest order to smallest order. That coul=
d avoid
>> a free page pool.
>
> Hi Zi, I just wanted to check; is this something you are working on or =
planning
> to work on? I'm trying to maintain a list of all the items that need to=
 get
> sorted for large anon folios. It would be great to put your name agains=
t it! ;-)

Sure. I can work on this one.

--
Best Regards,
Yan, Zi

--=_MailMate_0B6EAF4C-BE8E-4112-9959-3825253B2CEB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS4Cb8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUt9oQAIUjxRfChET+brAYmT2Qq7K9MbNAIKNQjncU
KkCqGm8Hl67SW4Xbem+tSJZPahsg6FgFlFMUfjWYgD1lI16t8+RERjytVybaluEE
PsFqWt9/onaLMFKAEjYEyki/VreD7OrVfeoM6vytsFJMFuH9NwfpKNYcCac0uC9w
paOI7b6GgYK8ysg3/4I/jVBxs1GD8RMpU5C2d6YDH2cqcDrsrevoPE2EgRfVP4fq
lXEzJ7kl9cl1MWaAtMWDB3pySH5JfpwPzaKbK9gDXSYm5k4TWjD/JU3fk1ynklJI
7Asy5QKtgGXSbZJ9GX2/PJOtZC5p5d479xmWjCrwVKSYA+kuGS+UUuNLDxNjuS9+
vCTucdWOhKjIjnmjpjEF0YKl9IYdznrBHgahfgSb795EoFfPYGJgxPqe4NGiOzBZ
wZ4piZQCq7d36CqvaVF3tgC899eYqQpwlKesMYupfxTlBxkdHBZzi0xISIZ5IZ5T
uJSiYblFp1BkxHDFNqBI9K8j0UFjPPldvYAh3HU77AaXtLv1OTDJQm8XejaFtpaC
7P5AtFwLQqDC2SOlGKZWuLmhELc++6zjxNMjug/Q5rcZaHn88GiG5PawgawXZFlL
oX2y2KkbPVfllCggHiDph7wWYeYPJ2UQRABdk1EZT3SoJqhGqoO50+SuiZL7eC2m
GfUbsEwJ
=kYjw
-----END PGP SIGNATURE-----

--=_MailMate_0B6EAF4C-BE8E-4112-9959-3825253B2CEB_=--
