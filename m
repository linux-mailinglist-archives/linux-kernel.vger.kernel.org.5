Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F87E80C3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjLKJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjLKJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:00:59 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E01A7;
        Mon, 11 Dec 2023 01:01:00 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b7020f03c9so173648839f.3;
        Mon, 11 Dec 2023 01:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702285260; x=1702890060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vN+RlAGZeGH2zMVmYb6ghj5GDWJcjTyD9/i+J4cSzo8=;
        b=JxyHvGnkNpqPpJH89mUj2mpRaDAiHAj5RLxPmUz3SXtlP41HUZvyN7n5oFXvwk7yfp
         XD0gwxJkA49EXjv5Da4Ad397HV8eYPVs5tkA/DGbQavQ//SybErtsSpHpsI3PPra62l6
         bhHOAuWAbl930nd2niN61l6e/b1wCqTur3chWnVCcDqpEp4/Jc466j3RqdYjCpAYBM6+
         cylOxFTelxQBlitJhvAmh1yV7u397qSYgi/k63VCIyWbgKBktM2gXT+xzfqBLogK1Mw3
         I5Ft9siyiVd1itUGRxSYQiJnqo5TMoNcvepDahEfBoR/596+G9+ivHxN8SXYS1dzFZia
         Q3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285260; x=1702890060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN+RlAGZeGH2zMVmYb6ghj5GDWJcjTyD9/i+J4cSzo8=;
        b=lbHCefBdvB5IHVE67D4dYLSfWEWEB6eFzcMSub0hJuJIiBPJiMZFbDGCZYUIjiWdnp
         jQKbFPgh+AY8GjtJNBP1rkZzZttNtty1rIgeWomI4HPZIEo5sirKpwOoRQGLsrdjgx4K
         YMnouUCTA8WxAJ52PygXcP59tOkRfTjanQKtRJoZD2yhc/c9eki1xhtkDis/0CootGdr
         +LpyFT2+oN6PmUsrkbERpIVhjpvadiXCRwUNilr4GaWMHk7z6rLR5d2PAbr5L6CGpSM8
         Ka1cVLKVplo0OpfSyMypcElFpaPIxPAIg14zi5sJadTqYD2hGaRbYsEaatxL1a6KPMhr
         z76w==
X-Gm-Message-State: AOJu0YyhFqW7Dy81smnC60yD9/Rq7IWpsmxKdS8MQUZeFYLYgZO/Lr86
        8SVZvozFJ9nVILu50G/PQN/2PjDo7Ec=
X-Google-Smtp-Source: AGHT+IE1sKCuGQStpjgZz24q1F+6gUFjFzwfnx1Z68zljQrTtBbgl+OeUjzPURrTCayBGeirVktHfg==
X-Received: by 2002:a05:6e02:16ce:b0:35d:6c24:f5f6 with SMTP id 14-20020a056e0216ce00b0035d6c24f5f6mr7023715ilx.14.1702285259773;
        Mon, 11 Dec 2023 01:00:59 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f14-20020a056e020b4e00b0035b0b05189bsm2211216ilu.38.2023.12.11.01.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:00:59 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v3 4/5] dm verity: Fix I/O priority lost when read FEC and hash
Date:   Mon, 11 Dec 2023 16:59:59 +0800
Message-Id: <20231211090000.9578-5-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
 <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
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

