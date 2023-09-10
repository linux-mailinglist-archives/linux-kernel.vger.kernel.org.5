Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB8799C73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjIJDlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbjIJDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:40:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0D1BF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:40:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A62C43391;
        Sun, 10 Sep 2023 03:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317255;
        bh=rUjHOoTpqiE+vomfhnfVsNQY6HBVoYZiR13zlPEqKrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HksUUdUWanh2pIH/SIVi+KtR2Gpkua5pt58Q7EXmTfMRYCH7jaiFAOMfZNHBo42HY
         z39BHHSJOmBs/f8JKvNW0aPkpOiiMzWKRTfmOTIOLjJb8waymf//tQg5CphaSotpMd
         /Xz+oETjlqnLKNewbNPDT051K1hoSuHpjd7nOuFQamxyK84TH74GVw/5DSGP9iY+m0
         oOf6ozysUwk04FHCgSAISPQ9GSarjemZhdkoPEv+0HpJ/OaGytO4+d/QwY/uTPG4Sy
         9upFfCh6680+hjMyr10vq8w2P/tDJE1hwRqJrup3A7YoMVWoKHyfwmafq06KaUvh41
         Qb9r1Q6zeXE2g==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 6/8] mm/damon/sysfs-schemes: support DAMOS apply interval
Date:   Sun, 10 Sep 2023 03:40:46 +0000
Message-Id: <20230910034048.59191-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON sysfs interval to support DAMOS apply intervals.  Users
can set and get the interval for each scheme in microseconds by writing
to and reading from the new sysfs file, 'apply_interval_us', in each
scheme sysfs directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3d30e85596b0..a7d70b95c4dd 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1121,6 +1121,7 @@ struct damon_sysfs_scheme {
 	struct kobject kobj;
 	enum damos_action action;
 	struct damon_sysfs_access_pattern *access_pattern;
+	unsigned long apply_interval_us;
 	struct damon_sysfs_quotas *quotas;
 	struct damon_sysfs_watermarks *watermarks;
 	struct damon_sysfs_scheme_filters *filters;
@@ -1141,7 +1142,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 };
 
 static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
-		enum damos_action action)
+		enum damos_action action, unsigned long apply_interval_us)
 {
 	struct damon_sysfs_scheme *scheme = kmalloc(sizeof(*scheme),
 				GFP_KERNEL);
@@ -1150,6 +1151,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 		return NULL;
 	scheme->kobj = (struct kobject){};
 	scheme->action = action;
+	scheme->apply_interval_us = apply_interval_us;
 	return scheme;
 }
 
@@ -1353,6 +1355,25 @@ static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return -EINVAL;
 }
 
+static ssize_t apply_interval_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%lu\n", scheme->apply_interval_us);
+}
+
+static ssize_t apply_interval_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int err = kstrtoul(buf, 0, &scheme->apply_interval_us);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -1361,8 +1382,12 @@ static void damon_sysfs_scheme_release(struct kobject *kobj)
 static struct kobj_attribute damon_sysfs_scheme_action_attr =
 		__ATTR_RW_MODE(action, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
+		__ATTR_RW_MODE(apply_interval_us, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
+	&damon_sysfs_scheme_apply_interval_us_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -1413,7 +1438,11 @@ static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
 	schemes->schemes_arr = schemes_arr;
 
 	for (i = 0; i < nr_schemes; i++) {
-		scheme = damon_sysfs_scheme_alloc(DAMOS_STAT);
+		/*
+		 * apply_interval_us as 0 means same to aggregation interval
+		 * (same to before-apply_interval behavior)
+		 */
+		scheme = damon_sysfs_scheme_alloc(DAMOS_STAT, 0);
 		if (!scheme) {
 			damon_sysfs_schemes_rm_dirs(schemes);
 			return -ENOMEM;
@@ -1610,8 +1639,8 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, 0, &quota,
-			&wmarks);
+	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
+			sysfs_scheme->apply_interval_us, &quota, &wmarks);
 	if (!scheme)
 		return NULL;
 
@@ -1641,6 +1670,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->pattern.max_age_region = access_pattern->age->max;
 
 	scheme->action = sysfs_scheme->action;
+	scheme->apply_interval_us = sysfs_scheme->apply_interval_us;
 
 	scheme->quota.ms = sysfs_quotas->ms;
 	scheme->quota.sz = sysfs_quotas->sz;
-- 
2.25.1

