Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64F78660B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjHXDqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbjHXDpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:45:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C41700
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a32506e90so1062179b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848698; x=1693453498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+a4BSDzIy5bpWMN+1YxNCRarQu4di8i3ZJob6D5Dd8=;
        b=dip4qEmJiV1YNzGzxlEI74Wryfunkc8c3rSYglaB3JIKEkT5lZ/foyX7YEMfkNEKng
         HkgCgh4ht64H1EmOCjuIJTFBRAsb5UPGfDPvHtEFoWm7IryKNuuIyQz573mu4imLgEgA
         aFipiNvgqdW+K2LFlZceFlek6WrMXBYl6UIjo1y2zHTRkONxxfYLHLcu7IEd1W2Qv/On
         OeO1Efs6M3t8mkmnGIM2HduzmF5Xd1srOyi16pQbX/gdcxkk4XFZqGf05Tj9UAofohDb
         p/FHyqijf69R6qxp9cnyWtD8AgdVX5kMyPGP2MC/1Hoaixy4uFYdTFI6vmbCaIqCJVfQ
         UAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848698; x=1693453498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+a4BSDzIy5bpWMN+1YxNCRarQu4di8i3ZJob6D5Dd8=;
        b=bWN/1+v/pdNgVWKn2eUeD/kvgnvGNIBi+G44UEqmWiijtFXm81OA+HfuuJdQmBy6Kt
         bs8fKUUyFix52c5++4XfiEAU0fAAg4zxxSk49IUahjqfhIWQ4EQnjXFGC1fjDquW5uxe
         aObijUNpdpdSBJvCQSbyGv/r2lIUpmvPVb+vnVt7DthdxqtfCAVPDLEo+sc3ARE584dA
         7Mdf/XLb3ELLbnMQZPYrdSUprlZb4hfCCEb4j666oeWF8f6kbuDuBOuoFJAGu2OdOSGH
         XrE3X+Anukx6hPo/9FYeVJqaJ0L9/KOVSvBzqpSeebDoR0Y3cWsaBnpHCP+clg9/qRah
         GrSQ==
X-Gm-Message-State: AOJu0Yy+4BhTaeDEs5Fuh/K//kqRD/zF6pWQGUYo1wsbOYx1s8djO+4b
        mRbn3Vdpp7jUB0Ke1kIWR5hoWw==
X-Google-Smtp-Source: AGHT+IEW17bvrtndnX5u4ZO2vRUQ/qIdWra1p6sHngI8edmpBrVuX9kD1hLdFF/eUVbriCdR0TGMjA==
X-Received: by 2002:a05:6a20:3941:b0:137:4fd0:e2e6 with SMTP id r1-20020a056a20394100b001374fd0e2e6mr17388012pzg.6.1692848698719;
        Wed, 23 Aug 2023 20:44:58 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:44:58 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH v5 08/45] gfs2: dynamically allocate the gfs2-glock shrinker
Date:   Thu, 24 Aug 2023 11:42:27 +0800
Message-Id: <20230824034304.37411-9-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the gfs2-glock shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Bob Peterson <rpeterso@redhat.com>
CC: Andreas Gruenbacher <agruenba@redhat.com>
CC: cluster-devel@redhat.com
---
 fs/gfs2/glock.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 675bfec77706..fd3eba1856a5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2039,11 +2039,7 @@ static unsigned long gfs2_glock_shrink_count(struct shrinker *shrink,
 	return vfs_pressure_ratio(atomic_read(&lru_count));
 }
 
-static struct shrinker glock_shrinker = {
-	.seeks = DEFAULT_SEEKS,
-	.count_objects = gfs2_glock_shrink_count,
-	.scan_objects = gfs2_glock_shrink_scan,
-};
+static struct shrinker *glock_shrinker;
 
 /**
  * glock_hash_walk - Call a function for glock in a hash bucket
@@ -2463,13 +2459,19 @@ int __init gfs2_glock_init(void)
 		return -ENOMEM;
 	}
 
-	ret = register_shrinker(&glock_shrinker, "gfs2-glock");
-	if (ret) {
+	glock_shrinker = shrinker_alloc(0, "gfs2-glock");
+	if (!glock_shrinker) {
 		destroy_workqueue(glock_workqueue);
 		rhashtable_destroy(&gl_hash_table);
-		return ret;
+		return -ENOMEM;
 	}
 
+	glock_shrinker->count_objects = gfs2_glock_shrink_count;
+	glock_shrinker->scan_objects = gfs2_glock_shrink_scan;
+	glock_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(glock_shrinker);
+
 	for (i = 0; i < GLOCK_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(glock_wait_table + i);
 
@@ -2478,7 +2480,7 @@ int __init gfs2_glock_init(void)
 
 void gfs2_glock_exit(void)
 {
-	unregister_shrinker(&glock_shrinker);
+	shrinker_free(glock_shrinker);
 	rhashtable_destroy(&gl_hash_table);
 	destroy_workqueue(glock_workqueue);
 }
-- 
2.30.2

