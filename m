Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAF7A5276
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjIRS6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjIRS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:58:43 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE087121
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:58:37 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 2B029C25F828; Mon, 18 Sep 2023 11:58:22 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/4] mm/ksm: add pages_skipped metric
Date:   Mon, 18 Sep 2023 11:58:14 -0700
Message-Id: <20230918185816.1518366-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230918185816.1518366-1-shr@devkernel.io>
References: <20230918185816.1518366-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the "pages skipped" metric. To be able to evaluate how
successful smart page scanning is, the pages skipped metric can be
compared to the pages scanned metric.

The pages skipped metric is a cumulative counter. The counter is stored
under /sys/kernel/mm/ksm/pages_skipped.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/ksm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 7a1aa3872cf4..7fbf22814c8d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -293,6 +293,9 @@ static bool ksm_smart_scan;
 /* The number of zero pages which is placed by KSM */
 unsigned long ksm_zero_pages;
=20
+/* The number of pages that have been skipped due to "smart scanning" */
+static unsigned long ksm_pages_skipped;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes =3D 1;
@@ -2378,6 +2381,7 @@ static bool should_skip_rmap_item(struct page *page=
,
 	 * Skip the page and calculate skip_age on when to re-enable scanning
 	 * for this page.
 	 */
+	++ksm_pages_skipped;
 	if (rmap_item->skip_age =3D=3D 0) {
 		rmap_item->skip_age =3D (age + skip_age(age)) & 0xFF;
 		remove_rmap_item_from_tree(rmap_item);
@@ -3468,6 +3472,13 @@ static ssize_t pages_volatile_show(struct kobject =
*kobj,
 }
 KSM_ATTR_RO(pages_volatile);
=20
+static ssize_t pages_skipped_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ksm_pages_skipped);
+}
+KSM_ATTR_RO(pages_skipped);
+
 static ssize_t ksm_zero_pages_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
@@ -3565,6 +3576,7 @@ static struct attribute *ksm_attrs[] =3D {
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
 	&pages_volatile_attr.attr,
+	&pages_skipped_attr.attr,
 	&ksm_zero_pages_attr.attr,
 	&full_scans_attr.attr,
 #ifdef CONFIG_NUMA
--=20
2.39.3

