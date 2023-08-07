Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485C67722AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjHGLhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjHGLgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:36:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DD422F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:33:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc76cdf0cbso634435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407980; x=1692012780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2xQZfHf5bNVsT7uWSGQWuu07PHxrGT3T56hFvtqSrg=;
        b=Myhpev/Y7xYJNTBNSk6JtX77oJTRKYeZv2N5FL+JAMcau6gywJ9j8E18YWhSuyyXsb
         F7pQFwh5yC2BkKs22s9zCy3leu7xgBN1B2DMqJCSTjvouC/B5q5n1nKQi9P6Uz/UDGwH
         oSAY3wMC3SpVhPBv16etL9jsCZRh5cTg9ReJn2ibOvM8b4JWx1keXGq4dcRjErjnUn96
         npetv8oz6Q4YOoqxHPB2Jmd1CCAGTd6HDTWbCTU5uM0ckgMtoCnnCUv4Ygrphy0ILZa5
         CHieDTdXZxeSXNGuDdaHCh90poHo+zMn5eo842I2YHMu1yGH/PycLsrStO3CBSHpC5E3
         3Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407980; x=1692012780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2xQZfHf5bNVsT7uWSGQWuu07PHxrGT3T56hFvtqSrg=;
        b=PhzfVEtySRUik9Ie+kWyw6Th/vZ/Ht26ua8jGil0nvrue8AbMPLisr5X+OLJBpn8ld
         47BcV3tyFbkebzxxPzR5zUDz2akrxygKBvu4CdHqIKLbPrQFuka/7PGZ79WRyMYI59eI
         OJZm/aFfJBvwSRJ0ftMa/YPUnlua+PY4lD6za2CZQI4EbKQSQaVfgHpTin8MuqeLtCEQ
         Y2+i57oQjq1zhlLH2pIzpyBXrLn6EwWRqEFPzsGD7Pu3iEde3G4QOUi+rDL8T0uvekK/
         joBArDjTtAtVCSZi+ppeVx+yyxNvWmFVqvmJCH83XeZ3VHUyUv8zz+jxKxGIgeGfIWmf
         Zg0g==
X-Gm-Message-State: ABy/qLbACb8naQH0dK+g5btE4mp/GIl6F7wMpHBzzZn8mo20x0Mxq7zK
        +3iUwse2DDJG7327Cjv0c7teLA==
X-Google-Smtp-Source: AGHT+IFlvQWL2g4YOY+ZhMNeAWWdQSS9yshpdy35E0gAyloBC4LB48Br4CdI402F04hX0eeuRkMt6Q==
X-Received: by 2002:a17:90a:c8d:b0:268:196f:9656 with SMTP id v13-20020a17090a0c8d00b00268196f9656mr12999255pja.1.1691406969055;
        Mon, 07 Aug 2023 04:16:09 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:16:08 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 29/48] bcache: dynamically allocate the md-bcache shrinker
Date:   Mon,  7 Aug 2023 19:09:17 +0800
Message-Id: <20230807110936.21819-30-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the md-bcache shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct cache_set.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/bcache/bcache.h |  2 +-
 drivers/md/bcache/btree.c  | 27 ++++++++++++++++-----------
 drivers/md/bcache/sysfs.c  |  3 ++-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 5a79bb3c272f..c622bc50f81b 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -541,7 +541,7 @@ struct cache_set {
 	struct bio_set		bio_split;
 
 	/* For the btree cache */
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
 
 	/* For the btree cache and anything allocation related */
 	struct mutex		bucket_lock;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fd121a61f17c..ae5cbb55861f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -667,7 +667,7 @@ static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
 static unsigned long bch_mca_scan(struct shrinker *shrink,
 				  struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 	struct btree *b, *t;
 	unsigned long i, nr = sc->nr_to_scan;
 	unsigned long freed = 0;
@@ -734,7 +734,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 static unsigned long bch_mca_count(struct shrinker *shrink,
 				   struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 
 	if (c->shrinker_disabled)
 		return 0;
@@ -752,8 +752,8 @@ void bch_btree_cache_free(struct cache_set *c)
 
 	closure_init_stack(&cl);
 
-	if (c->shrink.list.next)
-		unregister_shrinker(&c->shrink);
+	if (c->shrink)
+		shrinker_free(c->shrink);
 
 	mutex_lock(&c->bucket_lock);
 
@@ -828,14 +828,19 @@ int bch_btree_cache_alloc(struct cache_set *c)
 		c->verify_data = NULL;
 #endif
 
-	c->shrink.count_objects = bch_mca_count;
-	c->shrink.scan_objects = bch_mca_scan;
-	c->shrink.seeks = 4;
-	c->shrink.batch = c->btree_pages * 2;
+	c->shrink = shrinker_alloc(0, "md-bcache:%pU", c->set_uuid);
+	if (!c->shrink) {
+		pr_warn("bcache: %s: could not allocate shrinker\n", __func__);
+		return 0;
+	}
+
+	c->shrink->count_objects = bch_mca_count;
+	c->shrink->scan_objects = bch_mca_scan;
+	c->shrink->seeks = 4;
+	c->shrink->batch = c->btree_pages * 2;
+	c->shrink->private_data = c;
 
-	if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
-		pr_warn("bcache: %s: could not register shrinker\n",
-				__func__);
+	shrinker_register(c->shrink);
 
 	return 0;
 }
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 0e2c1880f60b..45d8af755de6 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -866,7 +866,8 @@ STORE(__bch_cache_set)
 
 		sc.gfp_mask = GFP_KERNEL;
 		sc.nr_to_scan = strtoul_or_return(buf);
-		c->shrink.scan_objects(&c->shrink, &sc);
+		if (c->shrink)
+			c->shrink->scan_objects(c->shrink, &sc);
 	}
 
 	sysfs_strtoul_clamp(congested_read_threshold_us,
-- 
2.30.2

