Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F7D767715
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjG1Uf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjG1UfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C754497
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E78621FF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 20:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EADC433C8;
        Fri, 28 Jul 2023 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576494;
        bh=Z5TufRLeeFt1IBETpXgGonzkgtF37kqef1//j1myid4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8PVYgKS6PhpVB48g8KXiKO4k/4GohZSRliIWj6R8O15K5G2kmG3fnkO0dbOgFkhl
         /UIHcmpSyJadZWQStltOcf4TGAZaLSowi0asMBRi5Z25HoZhta724/fvsHSQ8I11dY
         m0D2LjqwzdyKx4hl4XteU2v1tlgB8ElHctrSEsXcU7G5B6pCvO3pYtQe09rd02zLfr
         x5+D+Qc8R/BZ+Kms/T9KuXAgCUV1tqJo1KVQDt+oxGtbopKr6djuCFIfNOdrhkt9m3
         oCcs97pGo1x5w4rXqcln4QseMgiqsejzcN5BQNS9bsf387Cz+oFRuJyfs37iSJb33t
         eF9hu+cVBOMxw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/13] mm/damon/sysfs-schemes: support target damos filter
Date:   Fri, 28 Jul 2023 20:34:40 +0000
Message-Id: <20230728203444.70703-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend DAMON sysfs interface to support the DAMON monitoring target
based DAMOS filter.  Users can use it via writing 'target' to the
filter's 'type' file and specifying the index of the target from the
corresponding DAMON context's monitoring targets list to 'target_idx'
sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 03ddba3e216d..527e7d17eb3b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -283,6 +283,7 @@ struct damon_sysfs_scheme_filter {
 	bool matching;
 	char *memcg_path;
 	struct damon_addr_range addr_range;
+	int target_idx;
 };
 
 static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
@@ -295,6 +296,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
 	"addr",
+	"target",
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -413,6 +415,25 @@ static ssize_t addr_end_store(struct kobject *kobj,
 	return err ? err : count;
 }
 
+static ssize_t damon_target_idx_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%d\n", filter->target_idx);
+}
+
+static ssize_t damon_target_idx_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoint(buf, 0, &filter->target_idx);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
@@ -437,12 +458,16 @@ static struct kobj_attribute damon_sysfs_scheme_filter_addr_start_attr =
 static struct kobj_attribute damon_sysfs_scheme_filter_addr_end_attr =
 		__ATTR_RW_MODE(addr_end, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_filter_damon_target_idx_attr =
+		__ATTR_RW_MODE(damon_target_idx, 0600);
+
 static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_type_attr.attr,
 	&damon_sysfs_scheme_filter_matching_attr.attr,
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
 	&damon_sysfs_scheme_filter_addr_start_attr.attr,
 	&damon_sysfs_scheme_filter_addr_end_attr.attr,
+	&damon_sysfs_scheme_filter_damon_target_idx_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
@@ -1539,6 +1564,8 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 				return -EINVAL;
 			}
 			filter->addr_range = sysfs_filter->addr_range;
+		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
+			filter->target_idx = sysfs_filter->target_idx;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.25.1

