Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A651F7E913B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjKLOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 09:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:37:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477E2D57;
        Sun, 12 Nov 2023 06:37:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28023eadc70so2987844a91.2;
        Sun, 12 Nov 2023 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699799824; x=1700404624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pW2hhtxGtA8CdhlmZmkyAlOcGzmFoAEuNXHaiEFYfis=;
        b=H4Lz3P3ckVxq3B2vt2IoMbMVzhGnjQQRzFd7o6PxcUTgiRTC6wSVO/1f3/7xx4+t0e
         QBkd8XoDoapKMMCTxszfS7TQ76m7LmUjMid2SkGG93Og8e4upVxLwE1L+CT/cZbDO0kj
         KLHCw8cGlNb4Ydfe+HIVxgHqRcbg7twNvVEv+ufP9kKE4JJfzu+U43qdr/Nb5t3wCiYb
         2Ep2LTsEdD26xXFw1nl3JjZGcSaTcKjRh6uRAh48zEJzcGdHZo77CWTUzXvAT1ZFJyOS
         ciJhSQXf/Q98ZrzrU0hGKrQxQHH8KXOZu2sZBonOMZNlaunV1c/BuSVYHOWxDMcLB2rc
         0JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699799824; x=1700404624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pW2hhtxGtA8CdhlmZmkyAlOcGzmFoAEuNXHaiEFYfis=;
        b=kIss7XpTIivgCB+0E5X/sx/gmVBiIg2UcQi20W2PMTpdlZW7TRXiJUTtmcwgrcX/Cm
         wB3Lgh7vlkeDqDtJjMlXy4/JSwcv2S3sw1A6uYl8LcojlVq/TYAoRFmaaycC9UKQd3GJ
         RBnBfZfxvccwUfihC1zjgB4dw9NKXZQYNRplZO/WuZ7nUy7L8W5B2MGh6dlpnRa38Mb8
         Ky+66H2+c+Ss1AbzYmRh46KgE+mw587sbe5riUze+1yVprlmxU8DFjIPugLRFJSSwfCN
         gCvRQUwWm5BYo3VW3MWCBhDI8wEnay8lm46PFtsydY2j1ud+To9D+CblXTy0MQU9sjta
         3bmA==
X-Gm-Message-State: AOJu0YzOAFsK4WyAHdOjIfVxdf44akbeCnHcqd3RaD46lIHHO+t1PQzv
        msXhjraKCir5ifdgnXYPeNs=
X-Google-Smtp-Source: AGHT+IGENpN5lbIIuI7hrQc2wnfe8JuETJJfh+PiGWrnyrxz5nkvHVzpSleYMjQ1RyvVw2ZgEAagpQ==
X-Received: by 2002:a17:90b:3909:b0:27d:5964:4eec with SMTP id ob9-20020a17090b390900b0027d59644eecmr2353892pjb.1.1699799823835;
        Sun, 12 Nov 2023 06:37:03 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001b9c5e07bc3sm2642203plb.238.2023.11.12.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 06:37:03 -0800 (PST)
From:   alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To:     david@fromorbit.com, chandan.babu@oracle.com
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2 RESEND] xfs: remove redundant batch variables for serialization
Date:   Sun, 12 Nov 2023 22:35:27 +0800
Message-Id: <20231112143525.159566-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinliang Zheng <alexjlzheng@tencent.com>

Historically, when generic percpu counters were introduced in xfs for
free block counters by commit 0d485ada404b ("xfs: use generic percpu
counters for free block counter"), the counters used a custom batch
size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
this patch attempted to serialize the program using a smaller batch size
as parameter to the addition function as the counter approaches 0.

Commit 8c1903d3081a ("xfs: inode and free block counters need to use
__percpu_counter_compare") pointed out the error in commit 0d485ada404b
("xfs: use generic percpu counters for free block counter") mentioned
above and said that "Because the counters use a custom batch size, the
comparison functions need to be aware of that batch size otherwise the
comparison does not work correctly". Then percpu_counter_compare() was
replaced with __percpu_counter_compare() with parameter
XFS_FDBLOCKS_BATCH.

After commit 8c1903d3081a ("xfs: inode and free block counters need to
use __percpu_counter_compare"), the existence of the batch variable is
no longer necessary, so this patch is proposed to simplify the code by
removing it.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
Changelog:

v2: Modify ambiguous commit message.

v1: https://lore.kernel.org/linux-xfs/20230908235713.GP28202@frogsfrogsfrogs/T/#t
---
 fs/xfs/xfs_mount.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aed5be5508fe..8e47a3040893 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1144,7 +1144,6 @@ xfs_mod_freecounter(
 	int64_t			lcounter;
 	long long		res_used;
 	uint64_t		set_aside = 0;
-	s32			batch;
 	bool			has_resv_pool;
 
 	ASSERT(counter == &mp->m_fdblocks || counter == &mp->m_frextents);
@@ -1177,20 +1176,6 @@ xfs_mod_freecounter(
 		return 0;
 	}
 
-	/*
-	 * Taking blocks away, need to be more accurate the closer we
-	 * are to zero.
-	 *
-	 * If the counter has a value of less than 2 * max batch size,
-	 * then make everything serialise as we are real close to
-	 * ENOSPC.
-	 */
-	if (__percpu_counter_compare(counter, 2 * XFS_FDBLOCKS_BATCH,
-				     XFS_FDBLOCKS_BATCH) < 0)
-		batch = 1;
-	else
-		batch = XFS_FDBLOCKS_BATCH;
-
 	/*
 	 * Set aside allocbt blocks because these blocks are tracked as free
 	 * space but not available for allocation. Technically this means that a
@@ -1204,7 +1189,7 @@ xfs_mod_freecounter(
 	 */
 	if (has_resv_pool)
 		set_aside = xfs_fdblocks_unavailable(mp);
-	percpu_counter_add_batch(counter, delta, batch);
+	percpu_counter_add_batch(counter, delta, XFS_FDBLOCKS_BATCH);
 	if (__percpu_counter_compare(counter, set_aside,
 				     XFS_FDBLOCKS_BATCH) >= 0) {
 		/* we had space! */
-- 
2.39.3

