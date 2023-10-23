Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690047D378A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjJWNQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJWNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:16:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B4C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWrNMITh1wNHqESzjLlTrOhv+XmRRuxeMAXGWgzN2It9JOpA5cSB3al53kg1i7vvXMSYNIU+KzAg/akEfvUUw5KAD2Os9JKEUxcJWQupQAxiWaros66VuhyTw1eMw9CcTGBs2EHAzGJVxVIIlrfAxifF9GPrK+fV4prjvgKbtBQsn2BFsa5TP93bufSgZ7tJJOvA4C5S16PNM7MQriqJAcCta9vtu5PmaouQ+WUkUOjWXRyRSzIpHTQq2nFmrtIzQICjJS8fkhpl9I2eLJKu5lKDCIsMlAqltnnP+5aPgMPpOkObfA4hHWa+YnmnMItqwOa0moCvxEE6dOWo1kCABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ7agf/nRf09pbPUmLqSY8XvMtDTJtM7hqI+rNR7Qwk=;
 b=BNSIqMq6XNGXAs0KAxoMpoKSt4UfNNPPiSzk24nCccxa4sadIeJLoE6NNt1qF1eDoXnXV0HYI8Mgn32AjUpZLyr/3QiHYv7glBYSYRde1B68fK8M74TSc+KscgbnNf6GzJ17stjwATh3hhbX8A20sVhBC7W6l4zRCoD6VAfwwyAxh8wLrCY3/mx+IGML9CI3QdpcwhCrAAPYkgsBWVYjnWZfw/FItYnpJ3RhBH6foXIzIcP/NVmtgNv1Hoass7NziDvynUA32LEexEUsxMUG9XAoPvtrJ+DY4PqLeARYRxTX6k4rc8jDQgbJ6FdJzHhnIXc3xsVlKeskrlxdpWmQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ7agf/nRf09pbPUmLqSY8XvMtDTJtM7hqI+rNR7Qwk=;
 b=pRWIY06ThcOQAD4n+lBTismOQ7bUgBreyBde9DHy12wpB+2R8XAjVOBVQUUeKVgBm/ZhBLJl0pJPEsPN1bYaUJDlCFSbJPgGlIcSJ6a17c3U/u2OjqnP6TosMmIhNmsLhnO/FAN6wiiF/eAyCh/HIBS1bp8SdnPlt3jJGpUJS/nLjIQazBHl1nncvIkH8SVQdPozvUKXpdftjeOf1LFzu4riLoh5eryCBl5AT6k75zpwFFkkHtTV8nrVqL+3K15Ry5lN4pmrW3TswJsFpMRHvckWFd37oUdsIawLoAq0PbumFFfJCU+GUkjIfMQAuusStai8DeEfvQIEjo11VneQeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 13:16:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b90d:78a0:f664:ffd2]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b90d:78a0:f664:ffd2%3]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 13:16:43 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, ying.huang@intel.com,
        fengwei.yin@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
Date:   Mon, 23 Oct 2023 09:16:40 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <85FF2F7C-13D9-4CBD-9621-D067FDAEAA2E@nvidia.com>
In-Reply-To: <06e9153a7a4850352ec36602df3a3a844de45698.1697859741.git.baolin.wang@linux.alibaba.com>
References: <06e9153a7a4850352ec36602df3a3a844de45698.1697859741.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1834C37F-366E-4822-8569-BCF694AC091F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0419.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 54125034-98f9-4fe3-f1ee-08dbd3ca4ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzUbjKalCHiAEsn+micGxYnBwm2zIMhYedFBcNT8JZ8/gAYI7g+aLMn6x+OmccbUJPlA/cyXqv63qgFTgLTZ2zBXVw5Afp0je13oFmCiGeMcbhwgWQT0VNZiqdNWScN1ZFnUmVaVQjzGzV80alI7cuFpmDpWGUOyptOlIkPXq+kd8Av2kp+O/vRkZnbPYM/NPFKyU3vxvCw1ccxNlISrcjVG4Sp8ouH1sEXk5MhDydWQ1/P1KclfpuCv1ikJldgErcyEfvoMgsEuSaxgbyTp60ZYGJR6tIGKNrDsPyyGjetJnfAR/kmlnt49fDFAamDX/SYd4LLP+VI7OGNqt3IXtm5s456NFO67KEMtAGtph/z7VPvfQ47lQOHpv1N9xN3lGO/e4AtgxrDsKhzNermdSUD+G4Jksw9zW79nDqk6xQQGYADCqCwp0WYFDEZ0+IHZGc0SxU6h30ZdGKdLPFCdhEnCUXvxdqE+hAs0ZSNVBYDY/kgOka1lTOr6XUdViugr5+p9FJhndeoUnjxn+NqGbE4dshXxts7uHND8XyUcLUzQbtrD71SkUnMOic8JEOdjHNviF4jvTF9c7FtwVrWtqNtb5BsMg4+FIlhp8N/ZcfEmPb5ex4hrThgkkbwVrWX4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(2906002)(38100700002)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(235185007)(2616005)(478600001)(53546011)(6486002)(6512007)(83380400001)(36756003)(86362001)(5660300002)(33656002)(8936002)(8676002)(4326008)(26005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/QIVgqDO5Ixr3oKUVPqePwwZ6Agor/HQq6sM36tTu36/DNmTLGqFRQ3ml5f?=
 =?us-ascii?Q?SpgcNOVaW4BjTxO1XQtdOv5gjquHM11FzaKPTPOCRhko/j0Ho3ef/7p3izIg?=
 =?us-ascii?Q?gNRWkaEldwiHMPCxcaaN1Mm9G9Ifn9kmenKrwRKecRWo50Sj2wBdVkLYnO2D?=
 =?us-ascii?Q?Zh+6aSPWq3tXhHIlxM86y0HqOVySBOyVslwj6++W2oXqF7mT09v9Rmp8dNpr?=
 =?us-ascii?Q?tKU1l4b5B4fxW3x46SBHTZCCCne6xlDkTmKaQlKXS6ESTS0jqwdiKQ0d5sjO?=
 =?us-ascii?Q?Kw7L01/vOkfOCzxpGzU+CmlYB5FHb32owDfViUdS9P8ejti7i+dRJwLQ578N?=
 =?us-ascii?Q?H6DLbwYYZtdTR5bxwrLf6a/ECI8fm1OOxp+4bdQ/PEi6qMbAycrGvordIWip?=
 =?us-ascii?Q?kyGIr6B3hL9gTbJvAikRH803O2HxJu/m5NcQLJi3IU8BsMv/2Ke7oi4G6cTZ?=
 =?us-ascii?Q?4ey+5MxBfvEdugKmiW1YsawccM+nP+QNZBCxJOp952qYlKqQfxVZ23eAbyOa?=
 =?us-ascii?Q?fWnya387exLDmqKaX+m3azufZ/4BKdKLB3mYs3GbuVTtqHkc/uBRaq6jEzG3?=
 =?us-ascii?Q?fNNMxeG2QT4Al/vogkt4gAPSwPtFAFX0xqU8lKu6d/COk2ViZPeuxTlxoqSJ?=
 =?us-ascii?Q?ELkfs70jewyRwBUL9+W48XfVzoFXf1Bi2yVgJ1u+uU8psivrYtXZsddxy5ng?=
 =?us-ascii?Q?PcuZS/LlsebGTydJvqEotqoIqwSun4plFGWxN2PsRNVvC7tMNA4B1Qrf4JEc?=
 =?us-ascii?Q?rKqKO8RmhIarPkEQDQQDsKE46GcqbalBqCVV8zU0PGlC/AFfnCLr0s1Jy+Ix?=
 =?us-ascii?Q?vA1oefsFO+2IdfaSdg5Pbza7dUpt5OHQKLUvzIhCO1PbryNl85BKgAalWkew?=
 =?us-ascii?Q?7cdeBw1H+oe7NTkfHCZfIrpy+T7EMd8adshPmDGlPlylqCNdrrrHMmQREmFN?=
 =?us-ascii?Q?yyCMcpjnctomves+gA160go4Xph35jL6NA+qXFEONS+h/t/YYbQJKuadgtY1?=
 =?us-ascii?Q?FsHrKBiU9VSJ8rRhhutMfdkQ05Ut06F14xKnWL0MmJRX93qBQH3Ooat2FqiQ?=
 =?us-ascii?Q?TW2xb/mv3/DCJwL5M7Hm3XqZnUG0G4nyhqCl3Lgp/ohK37Lr/KA6Ln9LWF5A?=
 =?us-ascii?Q?vWvlamTvzYGrcgI/fcN5Po9F5zEzQfy+3K5CgbtW3FJrAFdt+JY1OIattiN2?=
 =?us-ascii?Q?9Z4H5/af4+r2JuNTpKatW9L9mfCf1Nm4EFU/jH+zytOaPpm9F8jX4q1T2m66?=
 =?us-ascii?Q?bss8XBvVFtMBszEWglXE86iLUjUc5Q/c7SyzwV1wgOtsr2M/QJAwsWVdHaJB?=
 =?us-ascii?Q?n+ItPSEEoxKOh1O4Z4a3ESlhA5L+Xv12nblpIh1Mk7Z0hotTosB4Qtc4Gqwl?=
 =?us-ascii?Q?/k8LH3nIwpjsjGGXGkYONFAMegW/giL3bX44+m+GOuACtPX5BHu55CBqetaz?=
 =?us-ascii?Q?isbMtnnoPHlnMAGOqb8kUI6TTVgjDzeRlylrYjENixWggyNX9i0SwaGyKpAO?=
 =?us-ascii?Q?ifmbIIs54BCEvhWsOb2e2V3m7bLUP5Qj1gAR37zYPfdJK4dyN6GHC2Byo9n3?=
 =?us-ascii?Q?5bEzgFgxhlM/vG5EO50=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54125034-98f9-4fe3-f1ee-08dbd3ca4ccf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:16:43.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiY/8MxRjNYhCXl8jffQmdOK+aI3NGCBfJn+xNa4i7WI2s4USi+ppkBYHY7Nwfb9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_1834C37F-366E-4822-8569-BCF694AC091F_=
Content-Type: text/plain

On 21 Oct 2023, at 0:33, Baolin Wang wrote:

> When doing compaction, I found the lru_add_drain() is an obvious hotspot
> when migrating pages. The distribution of this hotspot is as follows:
>    - 18.75% compact_zone
>       - 17.39% migrate_pages
>          - 13.79% migrate_pages_batch
>             - 11.66% migrate_folio_move
>                - 7.02% lru_add_drain
>                   + 7.02% lru_add_drain_cpu
>                + 3.00% move_to_new_folio
>                  1.23% rmap_walk
>             + 1.92% migrate_folio_unmap
>          + 3.20% migrate_pages_sync
>       + 0.90% isolate_migratepages
>
> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
> immediately, to help to build up the correct newpage->mlock_count in
> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
> pages are migrating, then we can avoid this lru drain operation, especailly
> for the heavy concurrent scenarios.
>
> So we can record the source pages' mlocked status in migrate_folio_unmap(),
> and only drain the lru list when the mlocked status is set in migrate_folio_move().
> In addition, the page was already isolated from lru when migrating, so checking
> the mlocked status is stable by folio_test_mlocked() in migrate_folio_unmap().
>
> After this patch, I can see the hotpot of the lru_add_drain() is gone:
>    - 9.41% migrate_pages_batch
>       - 6.15% migrate_folio_move
>          - 3.64% move_to_new_folio
>             + 1.80% migrate_folio_extra
>             + 1.70% buffer_migrate_folio
>          + 1.41% rmap_walk
>          + 0.62% folio_add_lru
>       + 3.07% migrate_folio_unmap
>
> Meanwhile, the compaction latency shows some improvements when running
> thpscale:
>                             base                   patched
> Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*
> Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*
> Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*
> Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*
> Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*
> Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*
> Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*
> Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*
> Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v2:
>  - Use BIT() to define macros.
>  - Simplify handing page_was_mapped and page_was_mlocked variables with
> introducing old_page_state variable.
>
> Changes from v1:
>  - Use separate flags in __migrate_folio_record() to avoid to pack flags
> in each call site per Ying.
> ---
>  mm/migrate.c | 48 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_1834C37F-366E-4822-8569-BCF694AC091F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmU2cjgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUJjsQAJAlmacOjmJayrCWA4yU4MvL1EApWxXdPIGU
HDhEw+GovNdh95ddSPKE7wHapqIWyCWrQlc6rfOsm1AcE3cjDqMEN1KSSjmR3flU
AvGK0ebFjLpOS4Z6Ig0jGIhm4TfvjSYL9C9V6L4xEDU+xI3OxjVe61KZGm32WlJV
MqzIW1GaB7d6UwrUwi94ZtI/qhf0U4zneQdBwQPX+rzUgyGbUVaraoKOTZjvBlyf
/VhhEPLIWgNzGDCCO5B2DAeoTlOneatWRsrKZ5zKK95IPAA3T6wsZIwDNLPDJIL0
BjuFIrOwkYy+D9GD2P2SZbYa5N2WGZT6TBeI0kIFvPkWN+FLvBRMaix6DQVeUY4X
2MRQm/3hdhkAGVsoIVtVgt3O0uB1VQkn+14g6Uv/GAQiFFJqe8A5i9FWagkOT3vY
4WsUHS+LP6RX1yY8Hc37SautEi2d//NeHCcJhIaoJyZBy/uh1OIimWNLUDSwuel+
FwKve/HuPffRuO7I+BfmQ5jNbilLC9U7mWl1eGOX08B3SgQoijrm4jIv7DZ8iQVE
lPLqg0WzSUluCWO/oBVlrhuf7QMiQE/4UnKAK2y8LytpPkmVRa8yZnLrhCK4WWCO
XYVF+octpDhs0taTNJ1JNg2CGsHtNoRQDMZfb6Y9DMDWlS+MEjAmKyKjyDi4QlJI
9C7Sxc0l
=ajXH
-----END PGP SIGNATURE-----

--=_MailMate_1834C37F-366E-4822-8569-BCF694AC091F_=--
