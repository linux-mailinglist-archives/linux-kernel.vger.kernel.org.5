Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F64754CFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 03:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGPBJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 21:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjGPBJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 21:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2C271E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 18:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA8AA60C53
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A64C433CB;
        Sun, 16 Jul 2023 01:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689469774;
        bh=ynG3uNudPw4EsmIgbd5wO/+ejwNGpxxg7axI66LyiMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6LZpv+XdvwV51008/a0gH39M+APPgJM1D7EOMzHvhYSMZ4+D9rHkfJmYJBPT690F
         I3n665Knoij7AITE//UPgEmnmhA7iRcmfJegbBSEp5mz7BYNtVNLLwqy5mck6iN/q7
         5t3JmblHrXTGgqVwEP/wr8WRgHZjjGBu2YSC2lJRRUDPLWljHtK661ebqE4RNG4Kin
         3D2+YeCk+ylACT8MLGW6/FRiwMxULxnhCHSZsBTNlC3BekaP5OpZC6/EqQH5Pm70Ti
         z3QbEtEwUtMhcsPLOZttOBKif81QBovz2Cvfrl/aQ3gtLvYqki3F0QTi0/PqfzK4Vu
         FouNsEgrezM9w==
From:   Chao Yu <chao@kernel.org>
To:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] mm/mm/damon/sysfs-schemes: reduce stack usage in damon_sysfs_mk_scheme()
Date:   Sun, 16 Jul 2023 09:09:27 +0800
Message-Id: <20230716010927.3010606-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230716010927.3010606-1-chao@kernel.org>
References: <20230716010927.3010606-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct damos_quota quota caused the stack usage of damon_sysfs_mk_scheme()
to grow beyond the warning limit on 32-bit architectures w/ gcc.

mm/damon/sysfs-schemes.c: In function ‘damon_sysfs_mk_scheme’:
mm/damon/sysfs-schemes.c:1526:1: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Allocating dynamic memory in damon_sysfs_mk_scheme() to fix this issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 mm/damon/sysfs-schemes.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 50cf89dcd898..35fa1b421c26 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1486,6 +1486,7 @@ static struct damos *damon_sysfs_mk_scheme(
 	struct damon_sysfs_scheme_filters *sysfs_filters =
 		sysfs_scheme->filters;
 	struct damos *scheme;
+	struct damos_quota *quota;
 	int err;
 
 	struct damos_access_pattern pattern = {
@@ -1496,14 +1497,6 @@ static struct damos *damon_sysfs_mk_scheme(
 		.min_age_region = access_pattern->age->min,
 		.max_age_region = access_pattern->age->max,
 	};
-	struct damos_quota quota = {
-		.ms = sysfs_quotas->ms,
-		.sz = sysfs_quotas->sz,
-		.reset_interval = sysfs_quotas->reset_interval_ms,
-		.weight_sz = sysfs_weights->sz,
-		.weight_nr_accesses = sysfs_weights->nr_accesses,
-		.weight_age = sysfs_weights->age,
-	};
 	struct damos_watermarks wmarks = {
 		.metric = sysfs_wmarks->metric,
 		.interval = sysfs_wmarks->interval_us,
@@ -1512,16 +1505,32 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
+	quota = kmalloc(sizeof(struct damos_quota), GFP_KERNEL);
+	if (!quota)
+		return NULL;
+
+	quota->ms = sysfs_quotas->ms;
+	quota->sz = sysfs_quotas->sz;
+	quota->reset_interval = sysfs_quotas->reset_interval_ms;
+	quota->weight_sz = sysfs_weights->sz;
+	quota->weight_nr_accesses = sysfs_weights->nr_accesses;
+	quota->weight_age = sysfs_weights->age;
+
+	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, quota,
 			&wmarks);
-	if (!scheme)
+	if (!scheme) {
+		kfree(quota);
 		return NULL;
+	}
 
 	err = damon_sysfs_set_scheme_filters(scheme, sysfs_filters);
 	if (err) {
+		kfree(quota);
 		damon_destroy_scheme(scheme);
 		return NULL;
 	}
+
+	kfree(quota);
 	return scheme;
 }
 
-- 
2.40.1

