Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5CC79B523
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376995AbjIKWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjIKJtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:49:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44BE4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:48:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf11a7cf9fso7701885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425737; x=1695030537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Yj0gPfexl8jpeLTCYtbI5G1wb/s5xsc3LDcKfsQ+pE=;
        b=LGytzLADMvz42cQawUan3xnLXtANYbud1cRcAZwJG5FijecCSDmQZvr+QBLmXOukJ9
         3jNTD/CDG6fXwEytC3/zyCQN7cHZDiTbGEyYM8uIGYUzLbvVou1jygZbrHeyajShPE/y
         Dpfk56OUrrQbiOzN0APGBlyJtJ/bjs/pdIgJWPc+quQsG+ICVXfjrle0Agim+UlPeNBw
         9zdkSJy2/jf/RUPHm++4C6LaY2mCp73ndfPwMLzJN0AN6aH650FHjYVfDcSPJ8GFZxiS
         OUXYupXWfSE6QDx7090oSFOFXVJB0zVsiTuAZzaqrFWkkGylhIkwbvbqYPOeYzTRoImc
         fM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425737; x=1695030537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Yj0gPfexl8jpeLTCYtbI5G1wb/s5xsc3LDcKfsQ+pE=;
        b=XrqEQCrW5AOOh4LpkSVomKiG9kV4tMK0qk2re+3rbFt+GVFrqAwSC8DYWgQzlmDtUJ
         dX8X7lmd9CkJ11ValzOiNk9EdMiEnYAXMs/yXBXtEUgfCY79dd0dlAd3Xncj3w0GhPcy
         mFzgr88wuT9eHedFnD2LB3t+hnfBFzEuRro7MDsSwkawwZWhdxEVS0hiJUZF3ds57PgB
         N0Jn6TGnJczanPyQ97z6xt+ZXh44w7GrATpC43cd7lmaHVAOHcr5ZaiB9+Je1ZFJ08YO
         tWgk0M892qimn1OJkINM+oWzn0ejm/WghPE+aTS0XCkczWZHUmHD0Yn0FnEXgUJ4GWPg
         oRjQ==
X-Gm-Message-State: AOJu0Yysmq9hzOEladp0fGtvnNrlVQbtrbfhvDHI6IE4IdU0p+0Y7XLU
        qU399OmJzzLnaFZxyqR5zISqhA==
X-Google-Smtp-Source: AGHT+IFZ0Cuso7zcW7EGyUKF+CdPkMsrNNduA/1bSkXKanT+gK0Pmmcny6T+hZLeB0kr56AjQb9xKw==
X-Received: by 2002:a05:6a20:4401:b0:140:ca4c:740d with SMTP id ce1-20020a056a20440100b00140ca4c740dmr14472508pzb.4.1694425737026;
        Mon, 11 Sep 2023 02:48:57 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:48:56 -0700 (PDT)
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
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH v6 25/45] md/raid5: dynamically allocate the md-raid5 shrinker
Date:   Mon, 11 Sep 2023 17:44:24 +0800
Message-Id: <20230911094444.68966-26-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the md-raid5 shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct r5conf.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Song Liu <song@kernel.org>
CC: linux-raid@vger.kernel.org
---
 drivers/md/raid5.c | 26 +++++++++++++++-----------
 drivers/md/raid5.h |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4cb9c608ee19..c8d2c6e50aa1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7401,7 +7401,7 @@ static void free_conf(struct r5conf *conf)
 
 	log_exit(conf);
 
-	unregister_shrinker(&conf->shrinker);
+	shrinker_free(conf->shrinker);
 	free_thread_groups(conf);
 	shrink_stripes(conf);
 	raid5_free_percpu(conf);
@@ -7449,7 +7449,7 @@ static int raid5_alloc_percpu(struct r5conf *conf)
 static unsigned long raid5_cache_scan(struct shrinker *shrink,
 				      struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 	unsigned long ret = SHRINK_STOP;
 
 	if (mutex_trylock(&conf->cache_size_mutex)) {
@@ -7470,7 +7470,7 @@ static unsigned long raid5_cache_scan(struct shrinker *shrink,
 static unsigned long raid5_cache_count(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 
 	if (conf->max_nr_stripes < conf->min_nr_stripes)
 		/* unlikely, but not impossible */
@@ -7705,18 +7705,22 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	 * it reduces the queue depth and so can hurt throughput.
 	 * So set it rather large, scaled by number of devices.
 	 */
-	conf->shrinker.seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
-	conf->shrinker.scan_objects = raid5_cache_scan;
-	conf->shrinker.count_objects = raid5_cache_count;
-	conf->shrinker.batch = 128;
-	conf->shrinker.flags = 0;
-	ret = register_shrinker(&conf->shrinker, "md-raid5:%s", mdname(mddev));
-	if (ret) {
-		pr_warn("md/raid:%s: couldn't register shrinker.\n",
+	conf->shrinker = shrinker_alloc(0, "md-raid5:%s", mdname(mddev));
+	if (!conf->shrinker) {
+		ret = -ENOMEM;
+		pr_warn("md/raid:%s: couldn't allocate shrinker.\n",
 			mdname(mddev));
 		goto abort;
 	}
 
+	conf->shrinker->seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
+	conf->shrinker->scan_objects = raid5_cache_scan;
+	conf->shrinker->count_objects = raid5_cache_count;
+	conf->shrinker->batch = 128;
+	conf->shrinker->private_data = conf;
+
+	shrinker_register(conf->shrinker);
+
 	sprintf(pers_name, "raid%d", mddev->new_level);
 	rcu_assign_pointer(conf->thread,
 			   md_register_thread(raid5d, mddev, pers_name));
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 97a795979a35..22bea20eccbd 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -670,7 +670,7 @@ struct r5conf {
 	wait_queue_head_t	wait_for_stripe;
 	wait_queue_head_t	wait_for_overlap;
 	unsigned long		cache_state;
-	struct shrinker		shrinker;
+	struct shrinker		*shrinker;
 	int			pool_size; /* number of disks in stripeheads in pool */
 	spinlock_t		device_lock;
 	struct disk_info	*disks;
-- 
2.30.2

