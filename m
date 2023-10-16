Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5009E7CA9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjJPNgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjJPNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:35:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BB1131
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL5x+7LAd9LG00O8CZqOG97gc6UuNertAgKlUgqcRcGfZyoING9hB8MYaAOaAF2Y7eXyEPWRU2k4Uo9zlAGSgrRm57nJj3LkL8wD1Vj5SMSa214kU3NYa1qvJTCeCve49Wp+Ggh0w3oMlLgkaCD05D7MUBnwGW/EDQQnwh4Mau+g3yIq6ZJqJ5qfdYqhtn2I/8ghSbgDIb114mO3XEPJuOro/s7z/x99nEI5XfA4tvcE2EYWv+4L3C+0L/ajwsOsqPMXUatPTm8p1LC9mHhCG6M9jLo2p3kxehMlYNZ2BnxgWgA/S4JYjHLbi87FKRTlhsOy4PoWaQyFgPcQjKMUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlbeZzE6SDEeJcS/vSUs8kQ/EOfzatTavN+i4QxOut0=;
 b=j9yOdVOaPjt+Ikg1iocNFxlRXxqw1NpIG1bAf7elGKHvtY2Oa0MNHJuKKL9EQGTv0AtqjWLD2aBkEHDpzvLwxe7jDc9xnDbqZq55arnbsMJ9dOUPyynqdnjrVbqzUTdohij5Jrghkb4llmbUQsuNtyJyTyTKcGEgp3+XcxK1QUEntcab8/81wvVKLCeNb6GdnN9KQ9CbLuhrbZ9VLatj6Mp3aol9jK/UfwYeE5gju6Upp084J6PR5ykuNQIqQ9b2s8nOyg7HyjT4rMYfjGERTNVI3ELdX68V1co0udzwyNkEEJQMlrSeYQJdapvXIRT9s4Vcnl9X8xlvu/Hzuw4Z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlbeZzE6SDEeJcS/vSUs8kQ/EOfzatTavN+i4QxOut0=;
 b=XcmLRsTCk+/+vclFbWAUo2OvEKh8wmYnceC/spDF3Ion2WTr353xw551wzzZZU1Ev1Cgp5O6dZdp11zKvv2JrJk+wJSttiyWPhtBjXx7u72uTEjbw/H2nsl58EFimoatHtaPIOtue6kuoaug5E9NaDzNkvxrdjbEt9QmqXQsBWTYo9IihDCu834JZhXRSPmeQL3BtYq2EErXH6FH0716C0SrYK+XFX1Z0bJS9AYLM6jp5K/X4JwSgNE6NGoyRyxrCDOAq9v7GRnrQ+2ipeeCjW6fgvrOFQuawsCHg8oCZKfrUGHeEE2Mx4sFzxUhba/tgtKNNSlcXYxJ1jkPQDGxAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.34; Mon, 16 Oct 2023 13:35:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 13:35:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Mon, 16 Oct 2023 09:35:34 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
In-Reply-To: <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
References: <20230920134811.GB124289@cmpxchg.org>
 <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_46A105A6-3913-400C-8A44-DD34A63D7EC0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:208:d4::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH0PR12MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9d6d91-4997-4bf9-69e9-08dbce4cc8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c04jfl61xcAcPWkePFeW+NBPqbpDT2O/EUK8SiLxXkbyc0D2FxUZHiSRZ/A+SvVQalEVqUjAlXOhxdN8/8JDVaC/iJzM57re817ktBpqSV4RwK8jjbskl3485F9soZzrGWOcFxSy3z8NTy3qK1QEmipdFktL1v5RZZuz5SfwyfGlOHmu/MH0+p++jME13HYyhAadRHx5698H21GicY8MF55Ut9z/OkCB6rMYvE8JZDBz44uT11t+tef8rb7rd0IcV7AAYjGIsGONUpinNfEwT1MqHmKS5gtg1S1S03lc0ExLZ6+sdxYa3Esgwn5WEBl1Fc5IWjR+XEaiEFLB4IjSMvoxlAXcu4b/ndMnikCkeuiaFgNWGy1HwkKGgh/E6YPtAg4DLs/1199S2OLfM/E/qPfm4IudGMfvHHFaH+e4TnyjlGtpv7ZOhih8vzgv6vXnysbqMsq5ILTigm76lGqovsi0yZDBJOchEltNtx/aNN4XqLUQxo9nr3udnLO+J/SE6sLOYgEDxC6q9KYPPU2vc5Fkb4KNm71jcuOqRM1EKDQg3Te/B3/4wvU2uk3rTBYxxlhmPSXDxwYT4ka5p8YC+T06TaPNFWQsAwWUEwgzT1HLRo0l5mnKbxytryLjrhFW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(6666004)(26005)(2616005)(66556008)(83380400001)(6506007)(235185007)(41300700001)(4326008)(5660300002)(7416002)(8676002)(2906002)(6486002)(478600001)(8936002)(6916009)(66946007)(54906003)(66476007)(316002)(38100700002)(36756003)(86362001)(564344004)(33656002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qS1gcIKehM4HQFiNjLE+Ao0VjoRn71G2bRy4P51iB1/HcS+10MmSrC+TU/MW?=
 =?us-ascii?Q?RHUY60EgiqaCrJzuzaKW7YaDdVigwD612vExViYSSa7Jxw4WFDTpMdDgnVgL?=
 =?us-ascii?Q?ObhUjNUW+QjM3IKcMOAe9gYhjzozHBnhTvX7bmsT1UK8jl37SU75jxh+NzpY?=
 =?us-ascii?Q?Jf/yJpnY5j7ssSlkERyJVCjZZ/lgPU2JNH7tGhXyhijwde1x9huvlSZq98cf?=
 =?us-ascii?Q?x6DAwfXeuE3cy3HuZus9dJ2UYH7fvQQjvKXMJEtkkwEUA3H5LxKIjtKGUVqB?=
 =?us-ascii?Q?3PkRl47kGLxtcvPlJFZsikZBCpumN0Pb7BtCokdcBQBLKoHugyTgTgPmkWGa?=
 =?us-ascii?Q?7gLr+d0FpXibba2CFkz2DVeTRu4xfLr/uxTV60pIlbVlKHLtkNeHRNq9JHg9?=
 =?us-ascii?Q?kUjahgIM8XlwK/Jg3wUdKa/WHrPdDbLOzTHjfYWoRRR06sN3fEn3kUA7njAn?=
 =?us-ascii?Q?HYyJfZCV2JtVTLGqZrkQPKZ+JPAIBT8q0tScflU6nQB/vaprfmQ0sDQV0P8o?=
 =?us-ascii?Q?9c43tzrn7yIdeV/tzekVyzBDQS2DUv1s2V8WzluAiQis5FIU2qFQYeZHovJX?=
 =?us-ascii?Q?P1K4JJ+YMoQcfoF98bLcTTigZ3H6YzTBx/M5zo7vIgefb1l88J4Gfj1FTLht?=
 =?us-ascii?Q?wVTlcQzalKUGjFeUv8jr21rMdV74F4sGwCT8HFNj7Uh1nzB2rDI1EI/du4QO?=
 =?us-ascii?Q?Iw8QCO8HaPmdsKXfahJ1OwV9XlthW9vDVjhCKE7A9eFda0z8AjayX1jg0mqw?=
 =?us-ascii?Q?xp7bTP0A1MFPkkcsZj+J+h8dvY8B9Gxo031yNjGwS/6CNlEwt0aLMQNnCsoT?=
 =?us-ascii?Q?lqFe7vFL83bzbJtlORpXRwRAwTz36dHpusq1hHXkWOJE/bOozsIol4MwYHTe?=
 =?us-ascii?Q?79ywYIYA5objnxdQ2IosKLU6APOj8Q/QZhuQCdh3q8o1yiUkSSd+egY7m+ZX?=
 =?us-ascii?Q?1Vdk9nhqptzUIH7yWDR0nJoA/BAYNENAkw0EVJuj26B1bhI5ljenu+c4ASw/?=
 =?us-ascii?Q?Qlt7xej5QUQF/bGiyrL+zwP05IsjsvSs55ZTBduAfEQWkh8ry2TQci7dqmQl?=
 =?us-ascii?Q?kQAX3MeoDkm4lANbWZHDnlIfSvcn/UEvJhyxqIgppZTPAA8HUK1s5nuf3Ciw?=
 =?us-ascii?Q?sHMJWRWR+8+lx2Ia0Fi7UKuPffbU3hUNDM+lWpR9eKIh11AduEVIczW6GPd3?=
 =?us-ascii?Q?cJ6oA2Uosuy+Sb4NwlKSdyN6Ibe4/jBU9DrwjK04qrH03co09lg1TZ1reWFi?=
 =?us-ascii?Q?e4oe3TOSRBXrTgpQHxKfhKd8J1JdEqy3Eb47GPkmDbKOcuRQuVxULsWmfLgd?=
 =?us-ascii?Q?atYHIGFl+5vP9vQczsOEXHDBgiSskD8mMtyzP7uGSbNhhwWw9Zfhs+hnH118?=
 =?us-ascii?Q?Dzlhkgnl1zQUI93tTpzArdq37/Fa6yhmyrmlAxxOVbjugfiQN/0DInX0E/tH?=
 =?us-ascii?Q?DKd7vltxPkkOEWUG2Cp8YKtLkHakblgLiIzFXj1VMgiIHbWGDM599kJsEKAq?=
 =?us-ascii?Q?5orrKdEPPUZQVbhFoTv9tOdenlPYOD2QGaaRobMb14JkTwYTrFmr6sY1wHfH?=
 =?us-ascii?Q?bxH/8DmwxzF/skp0WJ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9d6d91-4997-4bf9-69e9-08dbce4cc8de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:35:39.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bdp2WH6YmgkJmabFpiZdU1UEm6VkIIn0K2EuFL6WAzA11FnwCYF9JxDBJTvumjr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_46A105A6-3913-400C-8A44-DD34A63D7EC0_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_32226518-2625-4B20-AB23-4E6982CCB577_="


--=_MailMate_32226518-2625-4B20-AB23-4E6982CCB577_=
Content-Type: text/plain

> The attached patch has all the suggested changes, let me know how it
> looks to you. Thanks.

The one I sent has free page accounting issues. The attached one fixes them.

--
Best Regards,
Yan, Zi

--=_MailMate_32226518-2625-4B20-AB23-4E6982CCB577_=
Content-Disposition: attachment;
 filename=v2-0001-mm-page_isolation-split-cross-pageblock-free-page.patch
Content-ID: <84A1B3E5-8F81-434B-9497-378A4D6C765B@nvidia.com>
Content-Type: text/plain;
 name=v2-0001-mm-page_isolation-split-cross-pageblock-free-page.patch
Content-Transfer-Encoding: quoted-printable

=46rom b428b4919e30dc0556406325d3c173a87f45f135 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 25 Sep 2023 16:55:18 -0400
Subject: [PATCH v2] mm/page_isolation: split cross-pageblock free pages d=
uring
 isolation

alloc_contig_range() uses set_migrateype_isolate(), which eventually call=
s
move_freepages(), to isolate free pages. But move_freepages() was not abl=
e
to move free pages partially covered by the specified range, leaving a ra=
ce
window open[1]. Fix it by splitting such pages before calling
move_freepages().

A common code to find the start pfn of a free page straddling a given pfn=

is refactored in find_straddling_buddy(). split_free_page() is modified
to change pageblock migratetype inside the function.

[1] https://lore.kernel.org/linux-mm/20230920160400.GC124289@cmpxchg.org/=


Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |  12 +++-
 mm/internal.h                  |   3 -
 mm/page_alloc.c                | 103 ++++++++++++++++++------------
 mm/page_isolation.c            | 113 ++++++++++++++++++++++-----------
 4 files changed, 151 insertions(+), 80 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolatio=
n.h
index 901915747960..e82ab67867df 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,9 +33,17 @@ static inline bool is_migrate_isolate(int migratetype)=

 #define MEMORY_OFFLINE	0x1
 #define REPORT_FAILURE	0x2
 =

+unsigned long find_straddling_buddy(unsigned long start_pfn);
+int split_free_page(struct page *free_page,
+			unsigned int order, unsigned long split_pfn_offset,
+			int mt1, int mt2);
 void set_pageblock_migratetype(struct page *page, int migratetype);
-int move_freepages_block(struct zone *zone, struct page *page,
-			 int old_mt, int new_mt);
+int move_freepages(struct zone *zone, unsigned long start_pfn,
+			  unsigned long end_pfn, int old_mt, int new_mt);
+bool prep_move_freepages_block(struct zone *zone, struct page *page,
+				      unsigned long *start_pfn,
+				      unsigned long *end_pfn,
+				      int *num_free, int *num_movable);
 =

 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_=
pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/mm/internal.h b/mm/internal.h
index 8c90e966e9f8..cda702359c0f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -457,9 +457,6 @@ void memmap_init_range(unsigned long, int, unsigned l=
ong, unsigned long,
 		unsigned long, enum meminit_context, struct vmem_altmap *, int);
 =

 =

-int split_free_page(struct page *free_page,
-			unsigned int order, unsigned long split_pfn_offset);
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 =

 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 928bb595d7cc..e877fbdb700e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -851,6 +851,8 @@ static inline void __free_one_page(struct page *page,=

  * @free_page:		the original free page
  * @order:		the order of the page
  * @split_pfn_offset:	split offset within the page
+ * @mt1:		migratetype set before the offset
+ * @mt2:		migratetype set after the offset
  *
  * Return -ENOENT if the free page is changed, otherwise 0
  *
@@ -860,20 +862,21 @@ static inline void __free_one_page(struct page *pag=
e,
  * nothing.
  */
 int split_free_page(struct page *free_page,
-			unsigned int order, unsigned long split_pfn_offset)
+			unsigned int order, unsigned long split_pfn_offset,
+			int mt1, int mt2)
 {
 	struct zone *zone =3D page_zone(free_page);
 	unsigned long free_page_pfn =3D page_to_pfn(free_page);
 	unsigned long pfn;
-	unsigned long flags;
 	int free_page_order;
 	int mt;
 	int ret =3D 0;
 =

-	if (split_pfn_offset =3D=3D 0)
-		return ret;
+	/* zone lock should be held when this function is called */
+	lockdep_assert_held(&zone->lock);
 =

-	spin_lock_irqsave(&zone->lock, flags);
+	if (split_pfn_offset =3D=3D 0 || split_pfn_offset >=3D (1 << order))
+		return ret;
 =

 	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
 		ret =3D -ENOENT;
@@ -883,6 +886,10 @@ int split_free_page(struct page *free_page,
 	mt =3D get_pfnblock_migratetype(free_page, free_page_pfn);
 	del_page_from_free_list(free_page, zone, order, mt);
 =

+	set_pageblock_migratetype(free_page, mt1);
+	set_pageblock_migratetype(pfn_to_page(free_page_pfn + split_pfn_offset)=
,
+				  mt2);
+
 	for (pfn =3D free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
@@ -899,7 +906,6 @@ int split_free_page(struct page *free_page,
 			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
 	}
 out:
-	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
 /*
@@ -1588,21 +1594,52 @@ static inline struct page *__rmqueue_cma_fallback=
(struct zone *zone,
 					unsigned int order) { return NULL; }
 #endif
 =

+/*
+ * Scan the range before this pfn for a buddy that straddles it
+ */
+unsigned long find_straddling_buddy(unsigned long start_pfn)
+{
+	int order =3D 0;
+	struct page *page;
+	unsigned long pfn =3D start_pfn;
+
+	while (!PageBuddy(page =3D pfn_to_page(pfn))) {
+		/* Nothing found */
+		if (++order > MAX_ORDER)
+			return start_pfn;
+		pfn &=3D ~0UL << order;
+	}
+
+	/*
+	 * Found a preceding buddy, but does it straddle?
+	 */
+	if (pfn + (1 << buddy_order(page)) > start_pfn)
+		return pfn;
+
+	/* Nothing found */
+	return start_pfn;
+}
+
 /*
  * Move the free pages in a range to the freelist tail of the requested =
type.
  * Note that start_page and end_pages are not aligned on a pageblock
  * boundary. If alignment is required, use move_freepages_block()
  */
-static int move_freepages(struct zone *zone, unsigned long start_pfn,
+int move_freepages(struct zone *zone, unsigned long start_pfn,
 			  unsigned long end_pfn, int old_mt, int new_mt)
 {
-	struct page *page;
-	unsigned long pfn;
-	unsigned int order;
+	struct page *start_page =3D pfn_to_page(start_pfn);
 	int pages_moved =3D 0;
+	unsigned long pfn =3D start_pfn;
+
+	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
+	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 !=3D end_pfn);
+
+	/* Move buddies within the block */
+	while (pfn <=3D end_pfn) {
+		struct page *page =3D pfn_to_page(pfn);
+		int order, nr_pages;
 =

-	for (pfn =3D start_pfn; pfn <=3D end_pfn;) {
-		page =3D pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
 			pfn++;
 			continue;
@@ -1613,16 +1650,20 @@ static int move_freepages(struct zone *zone, unsi=
gned long start_pfn,
 		VM_BUG_ON_PAGE(page_zone(page) !=3D zone, page);
 =

 		order =3D buddy_order(page);
+		nr_pages =3D 1 << order;
+
 		move_to_free_list(page, zone, order, old_mt, new_mt);
-		pfn +=3D 1 << order;
-		pages_moved +=3D 1 << order;
+
+		pfn +=3D nr_pages;
+		pages_moved +=3D nr_pages;
 	}
-	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+
+	set_pageblock_migratetype(start_page, new_mt);
 =

 	return pages_moved;
 }
 =

-static bool prep_move_freepages_block(struct zone *zone, struct page *pa=
ge,
+bool prep_move_freepages_block(struct zone *zone, struct page *page,
 				      unsigned long *start_pfn,
 				      unsigned long *end_pfn,
 				      int *num_free, int *num_movable)
@@ -6138,7 +6179,6 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
-	int order;
 	int ret =3D 0;
 =

 	struct compact_control cc =3D {
@@ -6212,28 +6252,13 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
 =

-	order =3D 0;
-	outer_start =3D start;
-	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order > MAX_ORDER) {
-			outer_start =3D start;
-			break;
-		}
-		outer_start &=3D ~0UL << order;
-	}
-
-	if (outer_start !=3D start) {
-		order =3D buddy_order(pfn_to_page(outer_start));
-
-		/*
-		 * outer_start page could be small order buddy page and
-		 * it doesn't include start page. Adjust outer_start
-		 * in this case to report failed page properly
-		 * on tracepoint in test_pages_isolated()
-		 */
-		if (outer_start + (1UL << order) <=3D start)
-			outer_start =3D start;
-	}
+	/*
+	 * outer_start page could be small order buddy page and it doesn't
+	 * include start page. outer_start is set to start in
+	 * find_straddling_buddy() to report failed page properly on tracepoint=

+	 * in test_pages_isolated()
+	 */
+	outer_start =3D find_straddling_buddy(start);
 =

 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, 0)) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 5f8c658c0853..0500dff477f8 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -139,6 +139,62 @@ static struct page *has_unmovable_pages(unsigned lon=
g start_pfn, unsigned long e
 	return NULL;
 }
 =

+/*
+ * additional steps for moving free pages during page isolation
+ */
+static int move_freepages_for_isolation(struct zone *zone, unsigned long=
 start_pfn,
+			  unsigned long end_pfn, int old_mt, int new_mt)
+{
+	struct page *start_page =3D pfn_to_page(start_pfn);
+	unsigned long pfn;
+
+	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
+	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 !=3D end_pfn);
+
+	/*
+	 * A free page may be comprised of 2^n blocks, which means our
+	 * block of interest could be head or tail in such a page.
+	 *
+	 * If we're a tail, update the type of our block, then split
+	 * the page into pageblocks. The splitting will do the leg
+	 * work of sorting the blocks into the right freelists.
+	 *
+	 * If we're a head, split the page into pageblocks first. This
+	 * ensures the migratetypes still match up during the freelist
+	 * removal. Then do the regular scan for buddies in the block
+	 * of interest, which will handle the rest.
+	 *
+	 * In theory, we could try to preserve 2^1 and larger blocks
+	 * that lie outside our range. In practice, MAX_ORDER is
+	 * usually one or two pageblocks anyway, so don't bother.
+	 *
+	 * Note that this only applies to page isolation, which calls
+	 * this on random blocks in the pfn range! When we move stuff
+	 * from inside the page allocator, the pages are coming off
+	 * the freelist (can't be tail) and multi-block pages are
+	 * handled directly in the stealing code (can't be a head).
+	 */
+
+	/* We're a tail */
+	pfn =3D find_straddling_buddy(start_pfn);
+	if (pfn !=3D start_pfn) {
+		struct page *free_page =3D pfn_to_page(pfn);
+
+		split_free_page(free_page, buddy_order(free_page),
+				pageblock_nr_pages, old_mt, new_mt);
+		return pageblock_nr_pages;
+	}
+
+	/* We're a head */
+	if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_order)=
 {
+		split_free_page(start_page, buddy_order(start_page),
+				pageblock_nr_pages, new_mt, old_mt);
+		return pageblock_nr_pages;
+	}
+
+	return 0;
+}
+
 /*
  * This function set pageblock migratetype to isolate if no unmovable pa=
ge is
  * present in [start_pfn, end_pfn). The pageblock must intersect with
@@ -178,15 +234,17 @@ static int set_migratetype_isolate(struct page *pag=
e, int migratetype, int isol_
 	unmovable =3D has_unmovable_pages(check_unmovable_start, check_unmovabl=
e_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		int nr_pages;
 		int mt =3D get_pageblock_migratetype(page);
+		unsigned long start_pfn, end_pfn;
 =

-		nr_pages =3D move_freepages_block(zone, page, mt, MIGRATE_ISOLATE);
-		/* Block spans zone boundaries? */
-		if (nr_pages =3D=3D -1) {
+		if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn, NULL,=
 NULL)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
+
+		if (!move_freepages_for_isolation(zone, start_pfn, end_pfn, mt, MIGRAT=
E_ISOLATE))
+			move_freepages(zone, start_pfn, end_pfn, mt, MIGRATE_ISOLATE);
+
 		zone->nr_isolate_pageblock++;
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
@@ -253,13 +311,16 @@ static void unset_migratetype_isolate(struct page *=
page, int migratetype)
 	 * allocation.
 	 */
 	if (!isolated_page) {
-		int nr_pages =3D move_freepages_block(zone, page, MIGRATE_ISOLATE,
-						    migratetype);
+		unsigned long start_pfn, end_pfn;
+
 		/*
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(nr_pages =3D=3D -1);
+		if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn, NULL,=
 NULL))
+			WARN_ON_ONCE(1);
+		else if (!move_freepages_for_isolation(zone, start_pfn, end_pfn, MIGRA=
TE_ISOLATE, migratetype))
+			move_freepages(zone, start_pfn, end_pfn, MIGRATE_ISOLATE, migratetype=
);
 	} else {
 		set_pageblock_migratetype(page, migratetype);
 		__putback_isolated_page(page, order, migratetype);
@@ -380,11 +441,8 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 		if (PageBuddy(page)) {
 			int order =3D buddy_order(page);
 =

-			if (pfn + (1UL << order) > boundary_pfn) {
-				/* free page changed before split, check it again */
-				if (split_free_page(page, order, boundary_pfn - pfn))
-					continue;
-			}
+			VM_WARN_ONCE(pfn + (1UL << order) > boundary_pfn,
+				"a free page sits across isolation boundary");
 =

 			pfn +=3D 1UL << order;
 			continue;
@@ -408,8 +466,6 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
 			 * can be migrated. Otherwise, fail the isolation.
 			 */
 			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
-				int order;
-				unsigned long outer_pfn;
 				int page_mt =3D get_pageblock_migratetype(page);
 				bool isolate_page =3D !is_migrate_isolate_page(page);
 				struct compact_control cc =3D {
@@ -427,9 +483,11 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 				/*
 				 * XXX: mark the page as MIGRATE_ISOLATE so that
 				 * no one else can grab the freed page after migration.
-				 * Ideally, the page should be freed as two separate
-				 * pages to be added into separate migratetype free
-				 * lists.
+				 * The page should be freed into separate migratetype
+				 * free lists, unless the free page order is greater
+				 * than pageblock order. It is not the case now,
+				 * since gigantic hugetlb is freed as order-0
+				 * pages and LRU pages do not cross pageblocks.
 				 */
 				if (isolate_page) {
 					ret =3D set_migratetype_isolate(page, page_mt,
@@ -451,25 +509,8 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 =

 				if (ret)
 					goto failed;
-				/*
-				 * reset pfn to the head of the free page, so
-				 * that the free page handling code above can split
-				 * the free page to the right migratetype list.
-				 *
-				 * head_pfn is not used here as a hugetlb page order
-				 * can be bigger than MAX_ORDER, but after it is
-				 * freed, the free page order is not. Use pfn within
-				 * the range to find the head of the free page.
-				 */
-				order =3D 0;
-				outer_pfn =3D pfn;
-				while (!PageBuddy(pfn_to_page(outer_pfn))) {
-					/* stop if we cannot find the free page */
-					if (++order > MAX_ORDER)
-						goto failed;
-					outer_pfn &=3D ~0UL << order;
-				}
-				pfn =3D outer_pfn;
+
+				pfn =3D head_pfn + nr_pages;
 				continue;
 			} else
 #endif
-- =

2.42.0


--=_MailMate_32226518-2625-4B20-AB23-4E6982CCB577_=--

--=_MailMate_46A105A6-3913-400C-8A44-DD34A63D7EC0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUtPCYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUhfUQAJM85zYQPzm0VfR1sk6MFrAcFG3NFOsW42T1
vqm14DCsTwHWtlucCQMGL2oIisNtTNiOCQsE8KdId+9ULa8geYu4N6cTfPnSHI2+
SAv487viXnK49GwKLJCl+y8twRQ958aclrquGLaw0R7LpLhvBcibRYwJvC3gOP9o
I7gdxc7jHYYPIxNOPjmymI0ckRZgyY9vY6HqR6efZDrmcw8A/JDzAuj+EnFNIgPd
xZavbgPiPu8Fp6ZhxmUDYW7NZWQvt1z/eVm8cPWTaRQuuCx32dKRY6QU7KsDTdr3
kH4quXWZFRhlw1oFea4XozvYwRuHEY47Vpzel/FQe0K6juKbc+SucTfp2RlMP1Re
RrYlpWRgVof49jvPN/MbKJu02/lwc1yYGugEVsrYh9xaadv4Qwy5XefS9X3GjCYV
Y5vnsF84W/52WwtZ6pxPPd57/1Im2JFCT0gkjhAQGG0DP/m3rJ1jRHI7Lpmjd550
nvsdAP7vkjZEMxcDccXy8KIrq8rGnlJMF0x+x1BlvoFnF2n4RU4d7DD8lWsIDCcK
LDOwaFsCVYGimMDHdsJAbdhzLPefU5ypFzAjIPIfhAZ9fe1RqMQ2HT+yFZ6ltFWr
RBJqpXEy5cF26iGFwcH05is5XSVtLEgfpOHTjpg9LikDFm9Gd+Zyn9kJx/jmk7xA
sv/2Xsf3
=b+Ng
-----END PGP SIGNATURE-----

--=_MailMate_46A105A6-3913-400C-8A44-DD34A63D7EC0_=--
