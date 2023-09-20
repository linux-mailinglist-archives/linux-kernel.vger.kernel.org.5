Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69F87A8F79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjITWe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjITWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:34:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD32AC;
        Wed, 20 Sep 2023 15:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVzTMnWQEO2p8j2KkOz8dGAK0P968pBPmanykmFNFoyJzEAR7peX2hRNHFlyW2Ij5VhI+73NX1EhqqgS1OsDPewsC19ze2sem1zJAAEtOUiZl35/VW3t40hGioPMRt/M0kox3eMuQiBdtJ4f/bvL6asm+QvJjDVpsW6LfYSl7ofx5xk+T6oXeFZMti1hj/6hHoV8y4UUMDJV6FSOCtqeCFFzc/yQc0q7x5arJ2mmNJdz6J7VzDFBNg04lVuPVXxYo56UJik8354b7Tl0AMI/1N6XG69aXDaIZzIZTS2h88KMWI0QZ9JmJVa46n8fHKcRBVK84KScy/CrL8fX0RZhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVw4pbaeK/OPJwq3Uhf26wTFm5hms6ucSJBSRm4FteQ=;
 b=CpSXGOgjXW8e9DAzfsiDNFHWOuDiDqHn7n7sA1wIf25sKHx+Jg+8j/WlLzyKjKOZa0NyLOyZFq5twfndpbQXHYBDwUd4uBGhdCn6MAPmBdrc/SkPZEedaMuCw05gAUEHWYgAX8xrvY47XL/PpHSYR+Y2wxjskozpSYSBTRaasQXd82wwMFag6fYm7i4wco2wHFCJD7/MVd/LTsl1b2TSb/xp8Hh6ewPaJwJp95zykyvJGEEH948KAs1gWTziRppz5klMmReXAgw9pmkTEUvaINtGV32dAkx3NJVShlRiImnmluMifCEjXEYpiZ2ifZUpThdgqbLp+YlTvAGUUi6J7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVw4pbaeK/OPJwq3Uhf26wTFm5hms6ucSJBSRm4FteQ=;
 b=obpAc5q2H3N4dibaDlB/9pob1qCL4vZwt4vLvHcHmD2myaRQQ44FhChuoTQhtZGmK+Eim7PG4hr/9Lx+bMjIZ8eX6F/QHDpuO9Zl4eG27+wxjcOOCajzYQ1lkWclfIeomoM3qzcOclqrgu96o3idwznTO2gfQ3T78XWZgwtxbDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7492.prod.exchangelabs.com (2603:10b6:510:f3::6) by
 LV2PR01MB7720.prod.exchangelabs.com (2603:10b6:408:172::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.24; Wed, 20 Sep 2023 22:34:45 +0000
Received: from PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::b6e2:2b48:ed1e:be72]) by PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::b6e2:2b48:ed1e:be72%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 22:34:44 +0000
From:   Yang Shi <yang@os.amperecomputing.com>
To:     hughd@google.com, surenb@google.com, willy@infradead.org,
        mhocko@suse.com, vbabka@suse.cz, osalvador@suse.de,
        aquini@redhat.com, kirill@shutemov.name, rientjes@google.com
Cc:     yang@os.amperecomputing.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified
Date:   Wed, 20 Sep 2023 15:32:42 -0700
Message-ID: <20230920223242.3425775-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24)
 To PH0PR01MB7492.prod.exchangelabs.com (2603:10b6:510:f3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7492:EE_|LV2PR01MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: f377722f-aeba-4383-c89c-08dbba29c9dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywWbZnqJLz/5pYymFKbyxmm7sMmdyVQ2sCIgaWsMFkfU68ob9osFcULVVBcP0c63D5rbH/G9CFaLlfU1zftHZFg64n8bZspkvrQCkQNCm2W39h+GOROb4U7xd9zIIX/4DE9FTLKvnyZvOioAnMv62/VcyueqWVsfgawvJG4qlGycpgO0OScRoCXcxSINmMZQAJUBdUGjUGA3UQHI7AKTmiiAWMHxLFFjpfzpbvMb5XnSI0sCC9vimZk+mHrO8fnS91U3uTEcpkOVPL38OHj7+0diaaqoD3SQ+Qm3sAlkJwqpv8URdf3VOq398l2qmS6mhfMuwemd5Q4/lFR5V+MrYne0Mnaw6oLD3K/br0pM3M+RjUM54yWVlQp8JjZwDlj4N7MKAlcDQ6z6mmOuYBQEW1k51pwnrjiSLY/CekfwpVWXwhb9mcvytJc19FBGEVpJtYMTlsRmvKFVTz+fyT09Fs3OfhERGiqfUcDiP2Af3PUO3UTTQ19Ht00Obw88yIlIn4RbeZLRX8f5NJ0HruWtzfuJjV+iG7eDM9TGWqX2ey4bob40ik3t03koWtlpCaUmaEwmDDevN1kpKaCqHZSdiLXG4X5vIUbYd90bHegTCSi9GXzISCYPbCeE+EIHL463
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7492.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39850400004)(396003)(451199024)(186009)(1800799009)(6486002)(5660300002)(6506007)(52116002)(86362001)(478600001)(6512007)(66946007)(41300700001)(38350700002)(316002)(38100700002)(66556008)(66476007)(2616005)(8936002)(26005)(4326008)(8676002)(1076003)(2906002)(83380400001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPx+S9Mzz/DT0BeVhEdR61npvdMqW4tH1LmkWO5XtDopG55ApBAvd9n1R906?=
 =?us-ascii?Q?sAEaKMpvFRUcG86iQ9dS5j5ESYTJA9LjsfHDuaeCOQ8EY1qB69yDJegauBjV?=
 =?us-ascii?Q?yghJl2d/sLmTxX/qmtg3iuCL7oL2Ajd65Jq+F+wk89y5KWnVwKJPtOHIpUDk?=
 =?us-ascii?Q?w0QLXbvpPdnbCvyjOqS5ZSPGbaOEmrABJWBixBzWoxITOhRJ9ljixmOa59EL?=
 =?us-ascii?Q?BuTWcx8uQ/bDVWfydaLIbp4LGDrwX7aKkc6KKslarOLDEyJNHZg7yKPQZY+Y?=
 =?us-ascii?Q?0VKgoNJ4kY1UWk3zelY4dukZkWR6NvVGxgBCXdZfkcs3W+yVakiRRiWB7f+x?=
 =?us-ascii?Q?Uh+Bz+4duJUMB+nAanKKVudMy4gA9XLG4ytDG1RF5gDmCNg/62d+LYa0Pi3R?=
 =?us-ascii?Q?QkBoouL8gZlHec48At1zKUhqT/UeIC52nkfQe7BnI8fA5LGFhL7IeYjVyMPn?=
 =?us-ascii?Q?Ggn0eRPGnS8yb9gbUvHVhCMU53IDpvGLX3YWa8QG/Ap2bfQ3OMq3BotwucCx?=
 =?us-ascii?Q?KZpgkb75BHeHJi6CB/Xfk/uOJjMFuVdvnfOqZyfrlsNTu69chQxnJ4EHjMeF?=
 =?us-ascii?Q?AIFNgYs6/TocsfAhyzbciF2vBiU76dVmGf42yIWq4Q24mlfDeijMVJSWsGj0?=
 =?us-ascii?Q?hFgaaFar1K8HiaxFtmKSdFkqAdhDUwVv1S5pc1c+dZvv/F3EmtgPQpLnxxbI?=
 =?us-ascii?Q?3qfblxlnUgjhsX1uVty4Ib0kE8TYH7dgydbgeB1gjgiqesgRiKZzrUP7B0U6?=
 =?us-ascii?Q?Ae3Eis1G3skO/WvpGFNIKw437PxYXuCdsghwIUBQSno3JV7Tg/r2O5+SqbUm?=
 =?us-ascii?Q?8y6Sw21ZSUSGR4XwmEZyXd1qtkTT27evlOXJqNJj9MFJCNeo88zzSe8qyHwl?=
 =?us-ascii?Q?pK+tL0x5oVter4VsyBP6Wk9mdbvd8ND191HaHbmu+zbFHV5aVpVCItKe0orr?=
 =?us-ascii?Q?JJvC+02cKelqqyRJoZDvcBQKdcqlQ37j70sUB61nLqx0HPcbvY19rv0GkIvd?=
 =?us-ascii?Q?eOsewet5tAoHxTUpCmJ8XPKqM8asvMU1pddzIVu+uO2O6mwwDDmHi7yxc4ST?=
 =?us-ascii?Q?3QbqvdgHcvuVNrgc9Gq0g4kKugHcTGNPihXXFoViSCP+/zCoYcfr4L4SBRkL?=
 =?us-ascii?Q?QnKnwYkbPxi/GDrq59tc7vhQUpUQEOeVXJGKCOQ3YgiMIpEfSgh1a86s12z/?=
 =?us-ascii?Q?sldR+37AulB5xl6GH8WKAODvVpWQTvnRPtMP4Egj4HjDD0UsDbgSydvQI15T?=
 =?us-ascii?Q?h7WUCHIQYz22dIzSey3LluUkaoklerPZHpQ8LjtEkVLsrDsM/E19HU26/EdG?=
 =?us-ascii?Q?B61prVZ13rxwk7Vbi6vQfJLtCw7tuZ0PvMHvpzopSRG19xWRa+BZWdSL2+2+?=
 =?us-ascii?Q?aYYYKG+6zzYl8ICyEPhKr/MsnjsAfgKPKDCfZ/Ih7TMw+k1O/XkYb0uPq0zB?=
 =?us-ascii?Q?31QW+PsuVtw6x0jT4NKYwXFhUQJYy8WcfBp1HkiJ7tBSjAkU2h9HoCIvy2Kn?=
 =?us-ascii?Q?JhSBqOkECM8SeS0TNPrn9JlNoUM4AyVVK8bMH6JbsL4kYqVFWC9atFbxQqqa?=
 =?us-ascii?Q?lww11JNT4ENsau4Pp9psiC72bc33DwK2koLzKSAnnzvbB8z132reHTpeUSQZ?=
 =?us-ascii?Q?SMnWggLekCCok+pgMEXARyY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f377722f-aeba-4383-c89c-08dbba29c9dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7492.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 22:34:44.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgmNUd/S4JRH9hflViuMwwzWq+juNwYtN524jIZiI4jPMZGUCPQtCKqatiOkP4yDTwWfdpZAbeUkAaEo87qSbFMsp7uqWRgWpi4U4Cz38Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7720
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling mbind() with MPOL_MF_{MOVE|MOVEALL} | MPOL_MF_STRICT,
kernel should attempt to migrate all existing pages, and return -EIO if
there is misplaced or unmovable page.  Then commit 6f4576e3687b
("mempolicy: apply page table walker on queue_pages_range()") messed up
the return value and didn't break VMA scan early ianymore when MPOL_MF_STRICT
alone.  The return value problem was fixed by commit a7f40cfe3b7a
("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified"),
but it broke the VMA walk early if unmovable page is met, it may cause some
pages are not migrated as expected.

The code should conceptually do:

 if (MPOL_MF_MOVE|MOVEALL)
     scan all vmas
     try to migrate the existing pages
     return success
 else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
     scan all vmas
     try to migrate the existing pages
     return -EIO if unmovable or migration failed
 else /* MPOL_MF_STRICT alone */
     break early if meets unmovable and don't call mbind_range() at all
 else /* none of those flags */
     check the ranges in test_walk, EFAULT without mbind_range() if discontig.

Fixed the behavior.

Cc: Hugh Dickins <hughd@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: David Rientjes <rientjes@google.com>
Cc: <stable@vger.kernel.org> v4.9+
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 mm/mempolicy.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..f1b00d6ac7ee 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -426,6 +426,7 @@ struct queue_pages {
 	unsigned long start;
 	unsigned long end;
 	struct vm_area_struct *first;
+	bool has_unmovable;
 };
 
 /*
@@ -446,9 +447,8 @@ static inline bool queue_folio_required(struct folio *folio,
 /*
  * queue_folios_pmd() has three possible return values:
  * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. huge zero page.
- * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
+ *     special page is met, i.e. zero page, or unmovable page is found
+ *     but continue walking (indicated by queue_pages.has_unmovable).
  * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
  *        existing folio was already on a node that does not follow the
  *        policy.
@@ -479,7 +479,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 		if (!vma_migratable(walk->vma) ||
 		    migrate_folio_add(folio, qp->pagelist, flags)) {
-			ret = 1;
+			qp->has_unmovable = true;
 			goto unlock;
 		}
 	} else
@@ -495,9 +495,8 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
  *
  * queue_folios_pte_range() has three possible return values:
  * 0 - folios are placed on the right node or queued successfully, or
- *     special page is met, i.e. zero page.
- * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
- *     specified.
+ *     special page is met, i.e. zero page, or unmovable page is found
+ *     but continue walking (indicated by queue_pages.has_unmovable).
  * -EIO - only MPOL_MF_STRICT was specified and an existing folio was already
  *        on a node that does not follow the policy.
  */
@@ -508,7 +507,6 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 	unsigned long flags = qp->flags;
-	bool has_unmovable = false;
 	pte_t *pte, *mapped_pte;
 	pte_t ptent;
 	spinlock_t *ptl;
@@ -538,11 +536,12 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!queue_folio_required(folio, qp))
 			continue;
 		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-			/* MPOL_MF_STRICT must be specified if we get here */
-			if (!vma_migratable(vma)) {
-				has_unmovable = true;
-				break;
-			}
+			/*
+			 * MPOL_MF_STRICT must be specified if we get here.
+			 * Continue walking vmas due to MPOL_MF_MOVE* flags.
+			 */
+			if (!vma_migratable(vma))
+				qp->has_unmovable = true;
 
 			/*
 			 * Do not abort immediately since there may be
@@ -550,16 +549,13 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			 * need migrate other LRU pages.
 			 */
 			if (migrate_folio_add(folio, qp->pagelist, flags))
-				has_unmovable = true;
+				qp->has_unmovable = true;
 		} else
 			break;
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
 	cond_resched();
 
-	if (has_unmovable)
-		return 1;
-
 	return addr != end ? -EIO : 0;
 }
 
@@ -599,7 +595,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 		 * Detecting misplaced folio but allow migrating folios which
 		 * have been queued.
 		 */
-		ret = 1;
+		qp->has_unmovable = true;
 		goto unlock;
 	}
 
@@ -620,7 +616,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 			 * Failed to isolate folio but allow migrating pages
 			 * which have been queued.
 			 */
-			ret = 1;
+			qp->has_unmovable = true;
 	}
 unlock:
 	spin_unlock(ptl);
@@ -756,12 +752,15 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 		.start = start,
 		.end = end,
 		.first = NULL,
+		.has_unmovable = false,
 	};
 	const struct mm_walk_ops *ops = lock_vma ?
 			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
 
 	err = walk_page_range(mm, start, end, ops, &qp);
 
+	if (qp.has_unmovable)
+		err = 1;
 	if (!qp.first)
 		/* whole range in hole */
 		err = -EFAULT;
@@ -1358,7 +1357,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 				putback_movable_pages(&pagelist);
 		}
 
-		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
+		if (((ret > 0) || nr_failed) && (flags & MPOL_MF_STRICT))
 			err = -EIO;
 	} else {
 up_out:
-- 
2.39.0

