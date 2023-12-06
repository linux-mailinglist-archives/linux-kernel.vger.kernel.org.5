Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5510806DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378181AbjLFLY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378049AbjLFLY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:24:56 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8010A;
        Wed,  6 Dec 2023 03:25:02 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58d06bfadf8so4708762eaf.1;
        Wed, 06 Dec 2023 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701861901; x=1702466701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw9FJ5pKqgGHmlfm8Mu7G/JM0STLt1ZI15B6GB2xzN0=;
        b=KefWzfEZDI+q1E5sZly1+fGxIijB5xXASVCju6GDO2C0Nb0VSiFzKeVAN/oULeM2yH
         w6uM2KQfcYYGlIqxbGKLYh2/THsYbaKU2Qv7wf7lwftpsrkfbBKp5MX824f2MzT6Hdg7
         73fs1HoUqSd8amTcgK+kTSQG5QtbOS9tafo1btulOLqft5mqywMsXW2aCB3TFOjoKdFG
         hgsHQq0mF1T/eWP6vvMI2TkOtryMt9B0rE/1JknlN8+PwCHh8XqYaGslXBIvaV+UmNSV
         n/yo26+GuRd4Q0+MoBbreBgPbo4H/GNgBqLl8W28BPbNt6Sk/VobjgjSSd8f81weJGg9
         8naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861901; x=1702466701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rw9FJ5pKqgGHmlfm8Mu7G/JM0STLt1ZI15B6GB2xzN0=;
        b=jILxuW/HRE9IuuNqp4nw9Qk8nTjVLT8sdX1QjqJUkk1YlR10P+Pvah27kQk9RFfo+q
         DpbJTq2wBM8GI5aICQM3KRNuOJfMfql+wIx4OO9YvgIN0dOi0NfNlQvIp+2ejtJFAX1q
         DNJJby+lsTKXOs8YJmxnzjIN88EH29y+kry6eSbMlx0U4X8KIuyOf7zqudVYJWyAdf1x
         XaqkN4A+tFbpFMRriSG28NyDb92FCWM8nQJnckzlFlG8zvfKRHo0QjVg7BVlnp5NHy3b
         YjNCmmqaSmFMWMBJOvsusa8tUoCH/8imqmXjXGcbHin4mXJA0j4WhbIDchXHuZ3VR1YL
         0G3g==
X-Gm-Message-State: AOJu0Yz9D9IrSr2gGkNwXOt0WXXh9IkTjSH5kuhPZfr8nH7lCI98J7xP
        AAdaAeGzICH16vpswjieFWabAaZd9WQ=
X-Google-Smtp-Source: AGHT+IHARwrPmtaWDD4rwd7bVkjMfXibPvL9x7/c7EGiTpOhdGC5+pIU7YF9i5FQlA13gkrlUbNKsw==
X-Received: by 2002:a05:6358:7247:b0:16e:12c:16ad with SMTP id i7-20020a056358724700b0016e012c16admr1331233rwa.8.1701861901408;
        Wed, 06 Dec 2023 03:25:01 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d17-20020a656b91000000b005c2420fb198sm9459912pgw.37.2023.12.06.03.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:25:01 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     hongyu.jin.cn@gmail.com, axboe@kernel.dk
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] block: Optimize bio io priority setting
Date:   Wed,  6 Dec 2023 19:24:38 +0800
Message-Id: <20231206112438.9430-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Jin <hongyu.jin@unisoc.com>

Current call bio_set_ioprio() for each cloned bio and splited bio,
and the io priority can't be passed to module that implement
struct gendisk::fops::submit_bio.

Move bio_set_ioprio() into submit_bio(), only call bio_set_ioprio()
once set the priority of origin bio, cloned and splited bio
auto inherit the priority of origin bio in clone process.

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 block/blk-core.c | 10 ++++++++++
 block/blk-mq.c   | 11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..68158c327aea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,6 +49,7 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
+#include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -809,6 +810,14 @@ void submit_bio_noacct(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
+static void bio_set_ioprio(struct bio *bio)
+{
+	/* Nobody set ioprio so far? Initialize it based on task's nice value */
+	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
+		bio->bi_ioprio = get_current_ioprio();
+	blkcg_set_ioprio(bio);
+}
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
@@ -831,6 +840,7 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
+	bio_set_ioprio(bio);
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..a6e2609df9c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,6 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
@@ -2922,14 +2921,6 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	return rq;
 }
 
-static void bio_set_ioprio(struct bio *bio)
-{
-	/* Nobody set ioprio so far? Initialize it based on task's nice value */
-	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
-		bio->bi_ioprio = get_current_ioprio();
-	blkcg_set_ioprio(bio);
-}
-
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2963,8 +2954,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
-	bio_set_ioprio(bio);
-
 	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
 		if (!bio)
-- 
2.34.1

