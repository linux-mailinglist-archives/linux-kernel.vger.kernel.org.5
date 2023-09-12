Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8279D817
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbjILRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbjILRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:53:22 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDBF1FE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:52:53 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id DF124BCD1629; Tue, 12 Sep 2023 10:52:38 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 1/4] mm/ksm: add "smart" page scanning mode
Date:   Tue, 12 Sep 2023 10:52:25 -0700
Message-Id: <20230912175228.952039-2-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230912175228.952039-1-shr@devkernel.io>
References: <20230912175228.952039-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a "smart" page scanning mode for KSM. So far all the
candidate pages are continuously scanned to find candidates for
de-duplication. There are a considerably number of pages that cannot be
de-duplicated. This is costly in terms of CPU. By using smart scanning
considerable CPU savings can be achieved.

This change takes the history of scanning pages into account and skips
the page scanning of certain pages for a while if de-deduplication for
this page has not been successful in the past.

To do this it introduces two new fields in the ksm_rmap_item structure:
age and skip_age. age, is the KSM age and skip_page is the age for how
long page scanning of this page is skipped. The age field is incremented
each time the page is scanned and the page cannot be de-duplicated.

How often a page is skipped is dependent how often de-duplication has
been tried so far and the number of skips is currently limited to 8.
This value has shown to be effective with different workloads.

The feature is currently disable by default and can be enabled with the
new smart_scan knob.

The feature has shown to be very effective: upt to 25% of the page scans
can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
a similar de-duplication rate can be maintained.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 981af9c72e7a..bfd5087c7d5a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -56,6 +56,8 @@
 #define DO_NUMA(x)	do { } while (0)
 #endif
=20
+typedef u8 rmap_age_t;
+
 /**
  * DOC: Overview
  *
@@ -193,6 +195,8 @@ struct ksm_stable_node {
  * @node: rb node of this rmap_item in the unstable tree
  * @head: pointer to stable_node heading this list in the stable tree
  * @hlist: link into hlist of rmap_items hanging off that stable_node
+ * @age: number of scan iterations since creation
+ * @skip_age: skip rmap item until age reaches skip_age
  */
 struct ksm_rmap_item {
 	struct ksm_rmap_item *rmap_list;
@@ -212,6 +216,8 @@ struct ksm_rmap_item {
 			struct hlist_node hlist;
 		};
 	};
+	rmap_age_t age;
+	rmap_age_t skip_age;
 };
=20
 #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
@@ -281,6 +287,9 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
=20
+/* Skip pages that couldn't be de-duplicated previously  */
+static bool ksm_smart_scan;
+
 /* The number of zero pages which is placed by KSM */
 unsigned long ksm_zero_pages;
=20
@@ -2305,6 +2314,45 @@ static struct ksm_rmap_item *get_next_rmap_item(st=
ruct ksm_mm_slot *mm_slot,
 	return rmap_item;
 }
=20
+static unsigned int inc_skip_age(rmap_age_t age)
+{
+	if (age <=3D 3)
+		return 1;
+	if (age <=3D 5)
+		return 2;
+	if (age <=3D 8)
+		return 4;
+
+	return 8;
+}
+
+static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap=
_item)
+{
+	rmap_age_t age;
+
+	if (!ksm_smart_scan)
+		return false;
+
+	if (PageKsm(page))
+		return false;
+
+	age =3D rmap_item->age++;
+	if (age < 3)
+		return false;
+
+	if (rmap_item->skip_age =3D=3D age) {
+		rmap_item->skip_age =3D 0;
+		return false;
+	}
+
+	if (rmap_item->skip_age =3D=3D 0) {
+		rmap_item->skip_age =3D age + inc_skip_age(age);
+		remove_rmap_item_from_tree(rmap_item);
+	}
+
+	return true;
+}
+
 static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 {
 	struct mm_struct *mm;
@@ -2409,6 +2457,10 @@ static struct ksm_rmap_item *scan_get_next_rmap_it=
em(struct page **page)
 				if (rmap_item) {
 					ksm_scan.rmap_list =3D
 							&rmap_item->rmap_list;
+
+					if (skip_rmap_item(*page, rmap_item))
+						goto next_page;
+
 					ksm_scan.address +=3D PAGE_SIZE;
 				} else
 					put_page(*page);
@@ -3449,6 +3501,28 @@ static ssize_t full_scans_show(struct kobject *kob=
j,
 }
 KSM_ATTR_RO(full_scans);
=20
+static ssize_t smart_scan_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", ksm_smart_scan);
+}
+
+static ssize_t smart_scan_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	int err;
+	bool value;
+
+	err =3D kstrtobool(buf, &value);
+	if (err)
+		return -EINVAL;
+
+	ksm_smart_scan =3D value;
+	return count;
+}
+KSM_ATTR(smart_scan);
+
 static struct attribute *ksm_attrs[] =3D {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
@@ -3469,6 +3543,7 @@ static struct attribute *ksm_attrs[] =3D {
 	&stable_node_chains_prune_millisecs_attr.attr,
 	&use_zero_pages_attr.attr,
 	&general_profit_attr.attr,
+	&smart_scan_attr.attr,
 	NULL,
 };
=20
--=20
2.39.3

