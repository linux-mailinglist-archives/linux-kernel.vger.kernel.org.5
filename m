Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A1279BB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjIKVX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjIKJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F1E44
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fc94307bfso148135b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425580; x=1695030380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LECipjpjMsTeT5UMm7L2TEbO8WqkVi8hOfJfny30YM=;
        b=AHOrTDDleE7vX39+4hUg6bcArmjRLj85lhxeiOVxQUo1f8UNBiZm1t/y4gK/Ck09rp
         aHtcTQ5NmF4WvEUCIK73LT3QoI7kpZsjlWsgYzKaNk5Cvy4AeUEfpdAA2U9wdFbjDI80
         sovOGohtBHNf1Z27oFuc3BTVYJXwq4q3nkEh9XeoLGm2l25VJAnKMYVLYdogij+bToPS
         018NUPeRHg4P87MNkpNMq7pNT3QcGwb8rtPLgGNrmbnD8RE83cBkwG981doZw7kZjp0h
         HalqV+RkZBlQvTFgEN8iZTLDeSc0WA4+uqCGewN6DsM82L3r2tb9vjspazOshUk3KmXo
         3qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425580; x=1695030380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LECipjpjMsTeT5UMm7L2TEbO8WqkVi8hOfJfny30YM=;
        b=OrESZUNE3fwReRalxIs8qqz6MUwJc38C6TSPZ4HQ5vmX6nIQx3JxVhiv0B5DdgE1tG
         +elvHnnI1bnpCk+FNo0JSPOUsG+MJXBA7er7MRUYa9j9UKgzZEWiwZngUHl0wlXj92de
         qjN9DxxTSkA7ginmv9l5EhxazeI4McdJIusYOf7ZscB+yvUwqrAh4sczJN8geGSPPCSz
         PcJmgqVHqoP3vHdDKAY8P/v8rjfwxt+6oNfTpj6IA0PiEZ6fAJLuZIHRf8F2463EaJ6S
         YD/DdF/PN1xFlXpphp4DIXlGsOx1ZtbQSs4V9OK9i2YkQBasRYh5nIN+G/lV/z0VfrOf
         ovBw==
X-Gm-Message-State: AOJu0Ywb+zHidqy4oQJ5TOS/vMLqJBKmhtqM3nWXf2U2s3AxBXDQFD4k
        lOpQ4yMNL+l/DSW5rU/InPWNmw==
X-Google-Smtp-Source: AGHT+IEIDNe7dp+17p/1jwosBLUpyZnN7S3R/YUG8mMRO57r91hEdK6UAfUP/CCgqA5OUGqlmZWKGg==
X-Received: by 2002:a05:6a20:a10c:b0:13f:9233:58d with SMTP id q12-20020a056a20a10c00b0013f9233058dmr11702677pzk.2.1694425580529;
        Mon, 11 Sep 2023 02:46:20 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:20 -0700 (PDT)
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
Subject: [PATCH v6 08/45] gfs2: dynamically allocate the gfs2-glock shrinker
Date:   Mon, 11 Sep 2023 17:44:07 +0800
Message-Id: <20230911094444.68966-9-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 fs/gfs2/glock.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9cbf8d98489a..35967f8e3038 100644
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
@@ -2463,13 +2459,18 @@ int __init gfs2_glock_init(void)
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
+
+	shrinker_register(glock_shrinker);
+
 	for (i = 0; i < GLOCK_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(glock_wait_table + i);
 
@@ -2478,7 +2479,7 @@ int __init gfs2_glock_init(void)
 
 void gfs2_glock_exit(void)
 {
-	unregister_shrinker(&glock_shrinker);
+	shrinker_free(glock_shrinker);
 	rhashtable_destroy(&gl_hash_table);
 	destroy_workqueue(glock_workqueue);
 }
-- 
2.30.2

