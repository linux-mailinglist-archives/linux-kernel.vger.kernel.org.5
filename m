Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5A7EA3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjKMTWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:22:38 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFA61BB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or149qxkySrBXTVbTA+7dG+WXR27CvaqsuxDvkLkwq9GyDXn8/jWiybyeCZ9jywzq+p/n2f6OYdY51iPmNuevsOJmDQFYLrQ11zusv3omC3mSfgYMh3dfM/26AR2Gb9OagTfFGCowvbwpfPo7iRImh5Wy6xECzEa/lRjJUPevOFEWJEcvj/m5LPKncKSG99sZTJ8hfpoBjjEFWCHpW7ZyG4ZMTNMllB0Qit4hNsrDWdN3SqsZ9rViiOtHxnekbl4pOXjBJb0WonoSvYwvRk0VJhKjUhQ7lgTZ22KRZU/SxfCgD1VYLsBAbpQR2vR2yo20N+aansE6u11UgpsFO4eRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b9QvxLYGVMMjrdb8N3Jl8+WfrZmzqPFz9WnvigmCzw=;
 b=n4dZ+8P2iELxVTKCzqnLiHVwZlXoalCC6Rm4soDp5SQKQa5SxlTT/LO743YXA7gWWmxEtZS9u7GjRkuLkxKJahudSzkEoj56Hez0arH2Nc6OQ42Kiisz3qLBsphdm3ZSAzGQzysjWs1MucuXKujSCsz2sXNIs9ak40mneU/qRCnHeFUOAh/EZsDZKbSM6EI0bOcSQY2SNmn5mNTn47RovWRJrX3+zJw32CrGemZ8r66RYcFTQJU/3GM4A10v2ql340ogrktHckK8j9dvlJS/zpCaQuZMxJbxmy71OeN6kkZ5YWph61pvfJEwGqX1/m6M9cU+v1xlYAYLSNkpIVjAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b9QvxLYGVMMjrdb8N3Jl8+WfrZmzqPFz9WnvigmCzw=;
 b=kYjmhOMCKskhqGehK7M52uBcGaNPF0kxEPQqYqY9KRn7d6X+QzfizUdpfQOndDD6CKKV9PODxdk3XGKi8DIzccG39vcQdw5r1SwEpm3wfRIJVCRzinb0/BmOgODQR+y8Aheli0TkaxY1+nAeL/Hh34b4XzlvMbz6oXOGShpT9FP/KGoyXO5ukiuOd2g67xQL3q5vtZjzQe0tceRV6RenAGdMaDuaJXJZ3UIXY1JXsf347+wV4DKYp/ARMa9VMreQskV2vzLLkctG5FQsWAnoCY5n53N/MUDgyxHIqHC2QsKf7eqklRTgkphR86GK33wSqKaMMRjQOE+u0lSS78HfFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Mon, 13 Nov 2023 19:22:32 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 19:22:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "\"Huang, Ying\"" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v1 1/4] mm/compaction: enable compacting >0 order folios.
Date:   Mon, 13 Nov 2023 14:22:30 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <3F771C36-C889-448D-89B0-2202CF5EF7E2@nvidia.com>
In-Reply-To: <ZVJrTEDRzjIfL7kq@casper.infradead.org>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <20231113170157.280181-2-zi.yan@sent.com>
 <ZVJrTEDRzjIfL7kq@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_588929EE-9BE3-4C78-8BE6-F94834E8E000_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 895f3404-354b-43d9-a900-08dbe47de265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmHmNOIvlHjfybgDBrY8dw81vk3egx3oed/DCdoe/o4raWmGDVbuQg9c886T/jT457jrfiiIRQXFXSvaPZEdzLgb2rphMOUoNVUcrq44p10qLdoLSgKt6pGCcbMKxSballwiQv60kTV5NA1p7O5V/zB0y2P3eQrA3zcaIXbdYc/Yx28xr8eEQ84cUkR6dDocmSA9iAjXtqUp/WihI0210DYpZuwHxb0uBMIMZ3CoscTbUHgSsIFP6nEuNC16yEh1pWD51qjaI7mrivyTt2x6lN/il6aLyJkF5SgzpY50tEwNNg/0Q66XAekCl8g5uGgM09fIDcLJjYKTXb1tG38IUi8eR9icDJwQYvW5RGv4K+VxAROKV83oqU94daOSdnAm1PhZySWS4zcc3XvoCzI6uTLd37W/IY9M+5RmfSSf/Unof+TbWhUqoRwIHMDUkdNVVqKwxks7xaOHwtUaYt2ymMS5g1VUu7+6qiB5+3uNGhrpYinuLZqX9RMce84m6UXvovW0IQmMzUe75Ubrt+HBjoXr1vuBlYMOMEBBlybJzwyRqhGsrg5PuUyVDWwqROm/cQjDYDgLIqO14p4cLN+aFS3+ke1DQF8HqSCyD0L+X0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(7416002)(235185007)(5660300002)(2906002)(6486002)(41300700001)(478600001)(8676002)(8936002)(54906003)(4326008)(66476007)(66556008)(66946007)(316002)(6916009)(38100700002)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/jCwsyrlqBVIHT/i10QnrLjadFJ9sFvtWktJq64+hVjATCfvUmkI0gZByX0?=
 =?us-ascii?Q?uleSs8U7kQxkYaMXQHpAN7MuA3iAjeVtVGH3ganWJo6O3aCq5rTuGNLP1ZRX?=
 =?us-ascii?Q?xDnWJe/xnwfjQJtW68zJj0RCAckT1fiVvkwIpk2wSMG4OeqiwBazZBXtQHlf?=
 =?us-ascii?Q?Zj+WYVV+wr3qk32LsRJdlUqN0Kl0VAdjfQ6NvB7FBTA70KU3K2PBYScXLE/7?=
 =?us-ascii?Q?FPMzO1bxS2T3G+WUzMt6I8pGgKHwAteIDsJEyL84oammexlsDXdtF2tThTwY?=
 =?us-ascii?Q?1vORwqx9sr4OyyIw9hyB9z1xtg88w6pt2Whjag6Ze+nKgnfFZsgFI+o62Oxh?=
 =?us-ascii?Q?9Q+99Qio0gYna6HznAI4vQae8q+S3C/GVXNUFa1QiZxqoEXCD8pOQCtHCWE6?=
 =?us-ascii?Q?pNrBAKJB6RiuOnwCzbghDX1GEI33QhBe9rhloUYp3oO6+a64lxLe7P1MU9YU?=
 =?us-ascii?Q?IOL5ae6VRWz2K7v6vZmJweAEmebyOuwpM609wl6GpNea9/axDI9iH60KJC8E?=
 =?us-ascii?Q?U2k2sfO7/RqRwYTPW1ffYX446zK5Bq23wvM5CH0F0tk1k9wBlLy7kudzqMwn?=
 =?us-ascii?Q?wKXoOKL+xWvgHbQNy2eF3WKAr6YtEno5n3bptCffzAP/EWgoH/2edFKGJ7Pl?=
 =?us-ascii?Q?oDcJC/A5TMomAOh495Kw+jQzWm4xO8R4hUeu+mF1b0jj7MyZdYfqXBDD2uoK?=
 =?us-ascii?Q?VzHo71nvbtenuqpknLYZeJLtnplaXiLHTsPr1Iit4cbnYC5tzP0iis4zhGeJ?=
 =?us-ascii?Q?kcrjCmRpSKgZzE2fnpzXjhvxJSvnrl4J6fQpVdplGct2Ia+sWozp6WRuCaFi?=
 =?us-ascii?Q?dEtusSYESmIMT9a6YIDfW+x+Z6fm7YMN5S2F88E3+0WgYkg0B+2h9ygK4X8K?=
 =?us-ascii?Q?yIhD1uc6NglmHSCqe3ts2M9q5X1o3zuYeHbOo/LhVfEZJMy++Okx9sTUPIwt?=
 =?us-ascii?Q?pNM1AAuXlVCvUi4ApWV0D5pdkC81UBPUHJGJhAeHYXLSeYRlUHDgP2l0LjWc?=
 =?us-ascii?Q?8Cpv7XbEezcn6mnkCtBYraq6KSuOeAEj5NlR1RVH6VnijzAcUwwXe0UwZKzl?=
 =?us-ascii?Q?T7vPFThPz5EWv1JlbhApEBSskbByh+tOb9MIYXQpV4+LMvtVddW6EvgmOkJT?=
 =?us-ascii?Q?z3JAK4fYKf8igMNNtBj3A28N+2LW+eQnHqCZv7foQ2E0k6tlKH06C9eTjm3h?=
 =?us-ascii?Q?imkvEWk8sxhCPwTsrUMRiR43o0EC/Ce/T1C/pMjEMjCW6UQ4ZXXdzPPzj44f?=
 =?us-ascii?Q?3UfXU9p++HchdrUPmQ8WAVJqyY/xRu8ARMijOtlvoNRqr6EnuNfbYzDzFs9f?=
 =?us-ascii?Q?B35coP9YoiLfk2r5JSaIMJlVwt886uY6DzdsSmwqo2oEc0O+79iw87b4JQNX?=
 =?us-ascii?Q?EVTo91uKSNXL59gdekRXAhVV+eVF63Ts1pXGfGQdhw/HaFRD6sS9AeDtpetM?=
 =?us-ascii?Q?JlgX5HccdE0Fr+MPqSIBH0RSDgsk6sFp1I0bhDCxwtkVtXCMjYsjnw14dxpJ?=
 =?us-ascii?Q?eZe7G9aW8WA7BNVKU4NkW5KBv8NDoMBKDo+IXUH0YmdGYKFUuYCYXh1lIIe9?=
 =?us-ascii?Q?CznlUhzwHlOItfgmvuI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895f3404-354b-43d9-a900-08dbe47de265
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 19:22:32.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlrJsdcB+nKGJFu9BBriKJVRmavKMvSaLDdxURa16hD1+sT2ejHqnXnuu56Vrz8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_588929EE-9BE3-4C78-8BE6-F94834E8E000_=
Content-Type: text/plain

On 13 Nov 2023, at 13:30, Matthew Wilcox wrote:

> On Mon, Nov 13, 2023 at 12:01:54PM -0500, Zi Yan wrote:
>> +	/* this makes migrate_pages() split the source page and retry */
>> +	if (folio_order(src) > 0)
>> +		return NULL;
>
> Nit: folio_test_large() is more efficient than folio_order() > 0.
> The former simply tests the bit, while the second tests the bit, then
> loads folio->_order to check it's >0.  We know it will be, but there's
> no way to tell gcc that if the bit is set, this value is definitely not 0.

Got it. Make sense. Will change it in next version. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_588929EE-9BE3-4C78-8BE6-F94834E8E000_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmVSd3YPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPOsQAJbgdgyBaLe5+nTlKMuIxgfKFGCKCKP7qsEJ
EJ3YwUsDUUF74P2/Q6NdbTz2QAZresMkIqXsMp2YLuHDKXjqRdEQHd3NXYzNGO+z
zUW/Baj8+JF3hgpn4MFBYpnd73XJI5H9lK5zS3uMlx090vChMCPJxeXMyF/DKwvg
bhs7ULAMNVe7huaafGcS+UPi5JjmYTJEYnQztdksXuWP/MscvKStUfsymK/72Rfg
lMdRDaQZuOoqAiXPB8qH3+cYfIt6lEprzs/AXALt0QDD/npvuCvA1uSYOHaQbbBS
oyym1SPpna0q13MEqLtC/JACZhHoprIScDw+E7rnxwGUJVxvquo7dycNeh/M0odG
8hUhPzQUKthaLw6kzB/3/p8seyR7afDqKZ309kflqW+MyTWqQ67I9pDdDxetvoYX
nfPLlMxJzPiKpkHzqBf+ohFCUO09mkdeiqaJujLrSlBdxxr93bLecm67cLZf1LiH
e+DdU+Bx2BFNIIFheYEtct7Vc13DVDxNSSXxs2lXVYvmdNM42T7Ks6w/95bQzVQr
GPNYiNXW3/HoAbE0HJmGETzzXA+lKm08EsmAaQFyEVzkzoCwHG7TvKapp+z2StD+
YdP+eSa854/HIa3UmTzJkVZnavdtGmhmMVqiFvI5yIxQH0/YbVOaVp3esEtK0MAR
xr1LF8lZ
=A1/5
-----END PGP SIGNATURE-----

--=_MailMate_588929EE-9BE3-4C78-8BE6-F94834E8E000_=--
