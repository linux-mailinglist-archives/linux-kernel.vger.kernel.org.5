Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205337676DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjG1USc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjG1US2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F033423B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D05E5621F9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 20:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EF3C433C9;
        Fri, 28 Jul 2023 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575506;
        bh=f9khGIJiHzKXZGP9/5olstezaDHUu4yK0qoxQ3r57d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXDARGXp/FQxUmz94YzoxW4KJmVhaTi8JMBOSvWlDj/b+y6OEkY2wrOSS7c5yn1i0
         Ci+nBCovt0ADVQQKNC0GDEWUMEuRklyBLHOS6s9X8KU0sKUxqrHnYRyxZgqA5xGIQ6
         4Q+mpKNFvUoPm4uIlWa9pz0/8RiO/K43iPvbe8fM+poFQuOj0WMnoe7smZKgJWEkim
         G0bWwohWE+kl+R+Azlx0tgbK2DDgcccqX3oyiyPbnbyz0G74JY7JUkBX8dWeux+Iu3
         d0HEGCyrbhDETvHyadG0aX7JRJ0J3k1p30E9qQFkVAowidxX/3+npipplm8elUwNUj
         RixUsfUXlC/gA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] mm/damon/sysfs-schemes: implement DAMOS tried total bytes file
Date:   Fri, 28 Jul 2023 20:18:13 +0000
Message-Id: <20230728201817.70602-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728201817.70602-1-sj@kernel.org>
References: <20230728201817.70602-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tried_regions directory can be used for retrieving the monitoring
results snapshot for regions of specific access pattern, by setting the
scheme's action as 'stat' and the access pattern as required.  While the
interface provides every detail of the monitoring results, some use
cases including working set size monitoring requires only the total size
of the regions.  For such cases, users should read all the information
and calculate the total size of the regions.  However, it could incur
high overhead if the number of regions is high.  Add a file for
retrieving only the information, namely 'total_bytes' file.  It allows
users to get the total size by reading only the file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 50cf89dcd898..6d3462eb31f2 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -117,6 +117,7 @@ struct damon_sysfs_scheme_regions {
 	struct kobject kobj;
 	struct list_head regions_list;
 	int nr_regions;
+	unsigned long total_bytes;
 };
 
 static struct damon_sysfs_scheme_regions *
@@ -128,9 +129,19 @@ damon_sysfs_scheme_regions_alloc(void)
 	regions->kobj = (struct kobject){};
 	INIT_LIST_HEAD(&regions->regions_list);
 	regions->nr_regions = 0;
+	regions->total_bytes = 0;
 	return regions;
 }
 
+static ssize_t total_bytes_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_regions *regions = container_of(kobj,
+			struct damon_sysfs_scheme_regions, kobj);
+
+	return sysfs_emit(buf, "%lu\n", regions->total_bytes);
+}
+
 static void damon_sysfs_scheme_regions_rm_dirs(
 		struct damon_sysfs_scheme_regions *regions)
 {
@@ -148,7 +159,11 @@ static void damon_sysfs_scheme_regions_release(struct kobject *kobj)
 	kfree(container_of(kobj, struct damon_sysfs_scheme_regions, kobj));
 }
 
+static struct kobj_attribute damon_sysfs_scheme_regions_total_bytes_attr =
+		__ATTR_RO_MODE(total_bytes, 0400);
+
 static struct attribute *damon_sysfs_scheme_regions_attrs[] = {
+	&damon_sysfs_scheme_regions_total_bytes_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_regions);
@@ -1648,6 +1663,7 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 		return 0;
 
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
+	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
 	region = damon_sysfs_scheme_region_alloc(r);
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
@@ -1678,6 +1694,7 @@ int damon_sysfs_schemes_clear_regions(
 		sysfs_scheme = sysfs_schemes->schemes_arr[schemes_idx++];
 		damon_sysfs_scheme_regions_rm_dirs(
 				sysfs_scheme->tried_regions);
+		sysfs_scheme->tried_regions->total_bytes = 0;
 	}
 	return 0;
 }
-- 
2.25.1

