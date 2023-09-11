Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93F79B102
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354414AbjIKVxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbjIKUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:01:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100DABB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK7Nzk8KCLrMdIsmoUt/qd80RGL3PXfjNQjLXCPu+hobha6w8f4eBmWbPqqgzrYNUVF/h8n0gXcDp+DFHAdDesA8pm6HPdGdmBK3Pyk5Eg17rBTPwsrgmNW54++7xrMsZeCBQ5kdwJtj3iSwASzAzXWVQ5xjaQZXjvOYob7agf0WKrrrMBrqLVOxxDcBv6aQn6bw93noKqa9lozegBeuQ9vuOxjvLH4nH+oqYb7nbboZUsn0Rz7iZvbBUiCKHjk3a5K1Mnm6YKoVyBy9CAg4vh0NHmoYHQ8BKl9onT/qwE11IxJ5s8Vrzz3OyxIJseYo5tNVGhntj2bDW4P51jIHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdHViuliSy1ZfkbGnQVwRy/Fus8cP26Ds0FmJj4I3Yo=;
 b=E9r/biC2KZYPyZJMcdpfw9AjqUlbfPx/PhXSL7ZNq0XCkfgBqghSbmgmAHiWoRepWAuVZhqFbtWLc+ABakKNGO2h9UBWuyRfV6tLgoLzq8iJSJiYtcZySuAZNaK+rbaYNWUeTXVanCVHNLOuvkjZq1eZX3LTi06qWDVt1cUBOFr1I9dYRsOHNoshmyZteIIOVLWryAlfP+K8n/j5Fbj073yB5sIMXnkX8DQDTf3RUH0R95ZsvDkFhAFiMci4X5LZZm71LyZoW5sy9u4loJhRewL0zPDjJsnavM/+B33D+PUJj4v4yBIDkw4Mf1kJ+kJFZTdF6dDoB5FbNm9Y+gl8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdHViuliSy1ZfkbGnQVwRy/Fus8cP26Ds0FmJj4I3Yo=;
 b=fcjsEM5KhkUd0w4bAVyoVrgX+UTNtxKrUEoYG8iJAdwOgoo3GaN/B4JF6xXtQ5E8wvidgrekNWwir69R1ZVsUGEixP5G9wMkqmS7SdsJnrbGbTK9utw+SSqNap2GKImKfV3OPyZOY5RLLDFdqpG/Ah68DWjORuyMeUsSWK5KptIsadL5CJTnucVNXlrGyPrgum3jRkej1JUDBgb1Fc4IYqumSFkh58fVM34HJ8glUT7vawA3Eh3LdWjrqy0rzMSF8PNHziVYF7gsRdVKdUswcZMnMTX8RiUrgRupZRb4oBT4wv6W0fxJyGa1pCNyiCiKF0fF8Tz2Ken2vWRa/G+EKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4970.namprd12.prod.outlook.com (2603:10b6:610:67::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Mon, 11 Sep 2023 20:01:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Mon, 11 Sep 2023
 20:01:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: page_alloc: fix up block types when merging
 compatible blocks
Date:   Mon, 11 Sep 2023 16:01:23 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <FFA8C33F-D613-46CC-AD81-4789AFE4A087@nvidia.com>
In-Reply-To: <20230911195023.247694-3-hannes@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-3-hannes@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_5B6EDD91-634A-4C1A-8AE3-24BF037A5041_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: c7919540-5f8b-48fc-aa53-08dbb301e113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIQfXu6linLA2ZYUAOzv52zMHdt6lfk/PFbceVQ8A1vH+FLetH6U2m3/rNwLvSSXYOlogIRhccM3qIDQqb/ORBje3exGM2HGNELwBK9y7fJ2+K8QtqcyVWEHHScRgmVZn0Mz4jzyeLK5LbVbkEYs41FivF7dlIrmU3L8vQ+dMZMfZLa3ch9ByuwmEJ3u1yY15lpxyeyBbhCguSYGwQ3VauET7om37FoBnMvM3JuldKTin+hlxCTi39R6oN1fQRyNfkUf/F3t5KwLCINGLMmccfooC8PELCyM3a3eYyvspmqHO2eF8xAsaIqkWVMWowJ5cHiQ97n1LAVV2zZz3lcFH3pbbMoe5/Q1dlxvE3tVdTgRL+L9qUisypSnR3+laiUtswnyq/zFZrGnbTaCcspZXijUYZZOxdR8PmlasVecLJ1x0FVS6rajbL4G3HzSvDk5VjSd3hMpu+bzRPusmE8uQ3iGuwOOQ8pu9+/tbWx3A20Hf0AZMg7jb6CnwzJ3A4DZaFLGx/v5wyGu6SoARwsjPhlnSH3gSx9ClL/zK13hTWLz0pnYVUqUbS48Mzmd9H3ztc6APsbRBoPCRnfpdvbFn/rlBGjAd+hfMNLVH6nV7m9+tk1C8KDclPYgD5RlnubI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(2906002)(86362001)(83380400001)(26005)(53546011)(6512007)(235185007)(2616005)(6486002)(6506007)(38100700002)(33656002)(478600001)(36756003)(5660300002)(8676002)(8936002)(66556008)(66476007)(6916009)(66946007)(316002)(54906003)(4326008)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZhF1svccrD+5avdjWdiqxcF5kXYeVgbH+RfYgsMpZXQt/vK0jPkHCz7AJQt?=
 =?us-ascii?Q?ZDQatSjOXfgQtFINOcAFV6Nf43jVtaTH+aoK7DOCk0fwB0b5SMrkMUlEUOoI?=
 =?us-ascii?Q?E1SqrCeijuN6+tIYldW8ZPZEcNRLfPTJ6NAaYXCmTQlvuh9J82etKmyipwUy?=
 =?us-ascii?Q?Xsc6+sM7ovrMvCnMCCAHECPWt01zv+fLSQ+lZFmeZnyypCMzWCL8QIxbvWjf?=
 =?us-ascii?Q?NOmqZoTJh5h1QAxZpPxsCM5E1mTn1V708iZusyDl89I7OiQyWoj6D1WYSSWw?=
 =?us-ascii?Q?fzqjZALfx0sJxW4gVevF4AIGUQnTB9ny2+VtzYdkTlXgDJR/14kX1MJvgGP7?=
 =?us-ascii?Q?GEFdAyBtsORMAx+ufBj5SEpZTykprdpOjZfnwZ2nVyV+V3O3TjsRjS2LsMvv?=
 =?us-ascii?Q?gXqnHUgw9StAMCycbben8qX2mzWu5VbrA0uT4CkmKwGvLtEuioPv4f7WlFZL?=
 =?us-ascii?Q?N5pAme8IxriltFUGIP1Qcu5GgKajEWtltSnPiOjtnraQXYJvcFZrNYmYos0G?=
 =?us-ascii?Q?yQ5KnN2twkZrhfn0j9zdKqFZfRg4xkzc5S9JpY/G8/pvSvB0YA0IQe3jyzB2?=
 =?us-ascii?Q?ldiIRKNP+NO4tT2AxHcEnzAW2YNrQ4YxaPM/6AKMnXtG3PKt4s2ZbTzAkG82?=
 =?us-ascii?Q?AIRfPoAtqVg0egNE98LmQNr1VwJPM0J+LnxRQ9CwK8LY+pHtl0I63gMY6491?=
 =?us-ascii?Q?SEsy9lIs0lJh3LnGbgHsMsxJ65PJ3dUHGgYWldhWmfhxg1pChaDxFAZJkWZx?=
 =?us-ascii?Q?XKrSyRh4KhehhonQ3sazpmmisWLEQTbklPclSLPmN/1mui358S7hlguhJqyk?=
 =?us-ascii?Q?ztXL0+ARKoOYHLpBS7F/AGOcb3Y2QCk4wF1uyC3ULGJMtmsgojz0mM9f6Y5n?=
 =?us-ascii?Q?o/ZCUBmzur3IPM8dMw6UNB2NTJq/Ib3eBZo9e4TLygOv8D4j2pfDEZ4dg3Al?=
 =?us-ascii?Q?2dQn89ATuv1kn2I4/g6+CLSIc/UBniLRelutPQ3P+TODXEWhol02PMxQKZqH?=
 =?us-ascii?Q?tFK17z/xJSIXGTp7ntNvZZ1gwkwCeTBaHkYVTypGJv7RhtwH6FKWd7vl53xU?=
 =?us-ascii?Q?Upk2aWEt1/qDKmvQGGO10UU8c3DfhLUW/kzyFO3OPSqJl3n3NU6J8aR1l+Sz?=
 =?us-ascii?Q?DVfZgMi2bbaRWWsL+CtL+qWQAe7Q1ycHhyhE6aWObdevh/Gy6nWCU+ufuSZV?=
 =?us-ascii?Q?eskMPPiR/elV16WTIYcShVd1Q+21yQWqHJ8dQ8ci6kLalrYNOWYtNuGli8Rf?=
 =?us-ascii?Q?B/cnvwhleciGGMHJjkwIVV5PykN2RWrO+mUkL/NVC5+2cj0GyqztncA4UOKJ?=
 =?us-ascii?Q?RqmtdIjKuiV/QWnA6EuPJMMwF2W1BiFO+3YMEaPyx0+0vDbQzODKtG697kgO?=
 =?us-ascii?Q?6SEfyHcICFCGR0DXHG33VdjV9Wz+SDfv7mMekxIQqQUS8xJhGGNnOaRrZJ7I?=
 =?us-ascii?Q?JtA+jqnp6OcUuqq9yIZOFI71VtTAIHKJ1kJntUbZhRD1vmZqTeKDdpiXyx0m?=
 =?us-ascii?Q?HJmDWZ01ZSUQThhGD/tFByk7KWTSgsMyjv1bLP5ommUDmoov9cTPZ6/8fX67?=
 =?us-ascii?Q?39DLSloH7qQk4/IHGqaZMRB6Th8bnKAp4rits/L/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7919540-5f8b-48fc-aa53-08dbb301e113
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:01:25.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amv81jH70E+RR9GYGTuEYG21MDBZCxhXDtZw5AjB+8fkQZTSojIjna1r9v4Qwixh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5B6EDD91-634A-4C1A-8AE3-24BF037A5041_=
Content-Type: text/plain

On 11 Sep 2023, at 15:41, Johannes Weiner wrote:

> The buddy allocator coalesces compatible blocks during freeing, but it
> doesn't update the types of the subblocks to match. When an allocation
> later breaks the chunk down again, its pieces will be put on freelists
> of the wrong type. This encourages incompatible page mixing (ask for
> one type, get another), and thus long-term fragmentation.
>
> Update the subblocks when merging a larger chunk, such that a later
> expand() will maintain freelist type hygiene.
>
> v2:
> - remove spurious change_pageblock_range() move (Zi Yan)
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_5B6EDD91-634A-4C1A-8AE3-24BF037A5041_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT/chMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUEXcP/2WSRtlr8XEOo3jThSL9IGPB1NcdXIOrGBcB
25Lcv47N7rAH9s7Ub63xlqyR9TYGmzXPBUAszrgjMlIW/uN0dNIBOsFSGr8iep92
4UlYi8WtyZs1I/DfFLZ+VSen6P3yd8Pv2PepoLlaLgcakW++Ds05Zh/jbVVOPhiD
cjvxl2k+qoZ1jrQNzIObDnariCjsoMESZx8MjXTvXRy9hl25wsBrMLiJkQp2pn/a
L9Z34fLeu8N5NYacrYRc/S1lt2VDVheeQ/MvA9W0Ht24+KFtVYb5JuyKho4wgIeI
ERzLYo5HLpCXBkPmUMYZjcTlxi2Kydd3OAlyEYg0sgSctxqKoYk2F2UeSlFXCoT0
rIw5xm6iPgpOGYR8tJeLJvRcJODrnogGIXxhwhKWKIvDSIGuc4Ia4VnuSdlWKVpa
4jPslgHjdWwAXDvIXkAPkefy+5Kr/3x1KkBkcMHTNXa8JcJuPxTyQCJzU4xjZfj9
n9eFRSMHdTAteOkZXnW7HtCkcBltH81rndhFADM0jGyQjVP6qOWn187fm5CKJ6tT
LiSRyQVNlKLV7IbH8pkUhcQ41xb1ot/RaZWy7w52xvpwTD6qtBloN15yIuVYrIJL
BFbyWO8lldPsmx+MrQK9c3HWLT6X8pRMx7T63ttGXudsagCaS9WBFC8Ob5UHcM9G
B2v39koz
=ezit
-----END PGP SIGNATURE-----

--=_MailMate_5B6EDD91-634A-4C1A-8AE3-24BF037A5041_=--
