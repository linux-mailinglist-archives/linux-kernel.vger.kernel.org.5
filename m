Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0D79D819
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbjILRxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbjILRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:53:22 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C801FE9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:52:54 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 28DACBCD162C; Tue, 12 Sep 2023 10:52:38 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 2/4] mm/ksm: add pages_skipped metric
Date:   Tue, 12 Sep 2023 10:52:26 -0700
Message-Id: <20230912175228.952039-3-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230912175228.952039-1-shr@devkernel.io>
References: <20230912175228.952039-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the "pages skipped" metric. To be able to evaluate how
successful smart page scanning is, the pages skipped metric can be
compared to the pages scanned metric.

The pages skipped metric is a cumulative counter. The counter is stored
under /sys/kernel/mm/ksm/pages_skipped.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 mm/ksm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index bfd5087c7d5a..728574a3033e 100644
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
@@ -2345,6 +2348,7 @@ static bool skip_rmap_item(struct page *page, struc=
t ksm_rmap_item *rmap_item)
 		return false;
 	}
=20
+	ksm_pages_skipped++;
 	if (rmap_item->skip_age =3D=3D 0) {
 		rmap_item->skip_age =3D age + inc_skip_age(age);
 		remove_rmap_item_from_tree(rmap_item);
@@ -3435,6 +3439,13 @@ static ssize_t pages_volatile_show(struct kobject =
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
@@ -3532,6 +3543,7 @@ static struct attribute *ksm_attrs[] =3D {
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
 	&pages_volatile_attr.attr,
+	&pages_skipped_attr.attr,
 	&ksm_zero_pages_attr.attr,
 	&full_scans_attr.attr,
 #ifdef CONFIG_NUMA
--=20
2.39.3

