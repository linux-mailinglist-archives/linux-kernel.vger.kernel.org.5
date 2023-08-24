Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14078664A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbjHXDuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbjHXDuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:50:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B34268F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-569612f9d89so486294a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848903; x=1693453703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYOB+hnIO83YvzUHSYTSuFO2utsF72W4sdU/yBHPL1U=;
        b=YIHIoc1RJYxmkhYVOcGBRkBxvRhCV1vgbhLHLMHVKdroyXNJiDuJUutMmWOFcPBpBW
         s/5YL1T7lyc2hav1PtBIIN2Dt6hyxpkwLoN2k+dutrk6yEzT3g/nPXTNMM1CpwIdn7cK
         vKpo4xp6upXNV6Rk6KduOhBhcTSJ7rKvPI0CWETY6P1zhV3T+cGTYcHPpNts1uIFt7Xa
         slnyTJaIC+EL0nEINpq6Gumx8Im0B6M3kdYzAJy8prFgOUb8N2+zr2h9bofMyVLTfYMe
         wH5VoCpJVdhicwlvFPsZC33a5pDKbpFkIRl8d9BjaJjZ66w/ZuYhKjXRayn/0wC3WvtB
         B4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848903; x=1693453703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYOB+hnIO83YvzUHSYTSuFO2utsF72W4sdU/yBHPL1U=;
        b=R0wlk09782zS60kK4t9CTseHyAFWmcvYkygyb8Dhu6yAMMch5eeqXuX0ocFdaDpxxk
         PqV2m+GfCIs0eNyAeoqItdmk2tUYAO8ZPsiRPjymYWMoG0rN4fnPti7iKhczUIK9JBzM
         duearCkk4jKdf6nBzO4GvrV3qU7zZ0ZeO1KjUIIuJS1K4oP/Rme/W6GnTeKHbbf+s+Sz
         GSBOoyd5D50b2FRHcDHgew9z+eOhnC/hCMmA0PNubJCN1qV5FmRM4/8xj6EBWCJfCQ16
         pNZJhv18v24gg+VmyzaN//vI3C/8D2zd+HR7jg0n6goa1s2msF2GdhyYJBkfK+wHSoBF
         r0UA==
X-Gm-Message-State: AOJu0YxP1b8ZPmzf9L1gNjF+DduwCUpygsTSEV7XPzJhs8zoRoQ2tpRz
        tkYmghkvyxqM5jj8b7uwi+S+OQ==
X-Google-Smtp-Source: AGHT+IG6N8tn7T7dg336qdyH1rso/0WPaO046+rzbqZhcbNGv58+8uAGt72gzl/ZUc8tgddqdUvO3Q==
X-Received: by 2002:a05:6a21:7890:b0:112:cf5:d5cc with SMTP id bf16-20020a056a21789000b001120cf5d5ccmr18056004pzc.1.1692848903439;
        Wed, 23 Aug 2023 20:48:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:48:23 -0700 (PDT)
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
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH v5 31/45] jbd2,ext4: dynamically allocate the jbd2-journal shrinker
Date:   Thu, 24 Aug 2023 11:42:50 +0800
Message-Id: <20230824034304.37411-32-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the jbd2-journal shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct journal_s.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: "Theodore Ts'o" <tytso@mit.edu>
CC: Jan Kara <jack@suse.com>
CC: linux-ext4@vger.kernel.org
---
 fs/jbd2/journal.c    | 30 +++++++++++++++++++-----------
 include/linux/jbd2.h |  2 +-
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 768fa05bcbed..75692baa76e8 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1290,7 +1290,7 @@ static int jbd2_min_tag_size(void)
 static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 					      struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long nr_to_scan = sc->nr_to_scan;
 	unsigned long nr_shrunk;
 	unsigned long count;
@@ -1316,7 +1316,7 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
 					       struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long count;
 
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
@@ -1588,14 +1588,22 @@ static journal_t *journal_init_common(struct block_device *bdev,
 		goto err_cleanup;
 
 	journal->j_shrink_transaction = NULL;
-	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
-	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
-	journal->j_shrinker.seeks = DEFAULT_SEEKS;
-	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
-	err = register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
-				MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
-	if (err)
+
+	journal->j_shrinker = shrinker_alloc(0, "jbd2-journal:(%u:%u)",
+					     MAJOR(bdev->bd_dev),
+					     MINOR(bdev->bd_dev));
+	if (!journal->j_shrinker) {
+		err = -ENOMEM;
 		goto err_cleanup;
+	}
+
+	journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
+	journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
+	journal->j_shrinker->seeks = DEFAULT_SEEKS;
+	journal->j_shrinker->batch = journal->j_max_transaction_buffers;
+	journal->j_shrinker->private_data = journal;
+
+	shrinker_register(journal->j_shrinker);
 
 	return journal;
 
@@ -2170,9 +2178,9 @@ int jbd2_journal_destroy(journal_t *journal)
 		brelse(journal->j_sb_buffer);
 	}
 
-	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
+	if (journal->j_shrinker) {
 		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
-		unregister_shrinker(&journal->j_shrinker);
+		shrinker_free(journal->j_shrinker);
 	}
 	if (journal->j_proc_entry)
 		jbd2_stats_proc_exit(journal);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 52772c826c86..6dcbb4eb80fb 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -886,7 +886,7 @@ struct journal_s
 	 * Journal head shrinker, reclaim buffer's journal head which
 	 * has been written back.
 	 */
-	struct shrinker		j_shrinker;
+	struct shrinker		*j_shrinker;
 
 	/**
 	 * @j_checkpoint_jh_count:
-- 
2.30.2

