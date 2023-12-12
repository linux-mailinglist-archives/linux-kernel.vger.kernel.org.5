Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626BA80EA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjLLLOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjLLLNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:13:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD962695;
        Tue, 12 Dec 2023 03:12:30 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c701bd98f3so1055941a12.1;
        Tue, 12 Dec 2023 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702379549; x=1702984349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vN+RlAGZeGH2zMVmYb6ghj5GDWJcjTyD9/i+J4cSzo8=;
        b=EAvhWgQdAcKkYca7iH3EIeWNvw1BqsZ51l6UWqoLW9u0HmEwCSY04xLdWYx1Hrfkrr
         zmeYu3itNjMAXRbt5L3R+j5KwjHuxKV9ZW166wmDknc5oL9b2nNLPi0tzcDs79SycgW0
         q7yMcfgregHzDeVFPa3pqlXzzfpPowRx1ZXGISvM+IFy9g5mL7FuTIflN7OWB4HBp/rS
         kZzO1Nwc4ZOtYuAO2PO2fB2C2/RkQowmU44+q43Q4MOZfFbranwEePe1yACFA5QQMIct
         uYlLT4aA2c2sOn8vJauFRbnORotXTjYh3RbG5I9THGy9SLYY9E4Ve1hctG4ZCubnAcf5
         TEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379549; x=1702984349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN+RlAGZeGH2zMVmYb6ghj5GDWJcjTyD9/i+J4cSzo8=;
        b=TASBvnp+zxs/t/uaFCW09UKo+HcVvZhjTtKUum6TVgOdBEoM/n/APCcE0f4qhnPQZa
         H+ADqVKdc/4nxOwV/0rNcZdsHKDGl9d0eOBpOWG471jMYXKbMDQ5Bp4np10s2aCeoJPl
         FTskbzzqIl1Mfq3HQZiI+pdy738LiXFLjd6zCMhJnCsT70QDZ3juacCXzL7KmGcGRn4s
         fp9XUkKWUKVOERXcAcz9y+9J7qWDQDxKcLiR2TE+2iNaMXfEoJMQvgLhzHWpfy2NI1oc
         jHMHjwA8Wc3kIZBuerEsNp9GRkn0SFLms+TFscjDeQ1OMkmpvhHiJy0H8n+aiAv6bLOv
         hjRA==
X-Gm-Message-State: AOJu0YyU0nHUuzHWK+4GH7MeqeHyebrhZZdTWV/19NJL5WkdyIVqaQrn
        3qkN643HYrS/9MhddWllDh0=
X-Google-Smtp-Source: AGHT+IH8HknLDzaW0Q9TDSRdg3SQu4DIMs5eNiFa7zAa7YAtIDMAqdyYIiPkKRRbitlR1WMMmVqmNQ==
X-Received: by 2002:a05:6a20:4287:b0:186:e53:b64b with SMTP id o7-20020a056a20428700b001860e53b64bmr3221043pzj.47.1702379549391;
        Tue, 12 Dec 2023 03:12:29 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d0511c990csm8345453plo.237.2023.12.12.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:12:29 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v4 4/5] dm verity: Fix I/O priority lost when read FEC and hash
Date:   Tue, 12 Dec 2023 19:11:49 +0800
Message-Id: <20231212111150.18155-5-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
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

To fix this problem, when read FEC and hash from disk, I/O priority are
inconsistent with data block and blocked by other I/O with low I/O
priority.

Make I/O for FEC and hash has same I/O priority with original data I/O.

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-verity-fec.c    | 3 ++-
 drivers/md/dm-verity-target.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 715173cbf0ee..6a5a679e7e8a 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -209,6 +209,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	u8 *bbuf, *rs_block;
 	u8 want_digest[HASH_MAX_DIGESTSIZE];
 	unsigned int n, k;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	if (neras)
 		*neras = 0;
@@ -247,7 +248,7 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 			bufio = v->bufio;
 		}
 
-		bbuf = dm_bufio_read(bufio, block, &buf, IOPRIO_DEFAULT);
+		bbuf = dm_bufio_read(bufio, block, &buf, bio_prio(bio));
 		if (IS_ERR(bbuf)) {
 			DMWARN_LIMIT("%s: FEC %llu: read failed (%llu): %ld",
 				     v->data_dev->name,
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 0038e168f3d7..8c911b6722ce 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -51,6 +51,7 @@ static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
 struct dm_verity_prefetch_work {
 	struct work_struct work;
 	struct dm_verity *v;
+	unsigned short ioprio;
 	sector_t block;
 	unsigned int n_blocks;
 };
@@ -293,6 +294,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 	int r;
 	sector_t hash_block;
 	unsigned int offset;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	verity_hash_at_level(v, block, level, &hash_block, &offset);
 
@@ -307,7 +309,7 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 			return -EAGAIN;
 		}
 	} else
-		data = dm_bufio_read(v->bufio, hash_block, &buf, IOPRIO_DEFAULT);
+		data = dm_bufio_read(v->bufio, hash_block, &buf, bio_prio(bio));
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -717,7 +719,7 @@ static void verity_prefetch_io(struct work_struct *work)
 		}
 no_prefetch_cluster:
 		dm_bufio_prefetch(v->bufio, hash_block_start,
-				  hash_block_end - hash_block_start + 1, IOPRIO_DEFAULT);
+				  hash_block_end - hash_block_start + 1, pw->ioprio);
 	}
 
 	kfree(pw);
@@ -728,6 +730,7 @@ static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
 	sector_t block = io->block;
 	unsigned int n_blocks = io->n_blocks;
 	struct dm_verity_prefetch_work *pw;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	if (v->validated_blocks) {
 		while (n_blocks && test_bit(block, v->validated_blocks)) {
@@ -751,6 +754,7 @@ static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
 	pw->v = v;
 	pw->block = block;
 	pw->n_blocks = n_blocks;
+	pw->ioprio = bio_prio(bio);
 	queue_work(v->verify_wq, &pw->work);
 }
 
-- 
2.34.1

