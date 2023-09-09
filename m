Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117257996B6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 09:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbjIIHS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 03:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjIIHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 03:18:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2DA1FC0;
        Sat,  9 Sep 2023 00:18:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a56401b9aso2424674b3a.1;
        Sat, 09 Sep 2023 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694243902; x=1694848702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fqDJASkFf9bOx5d/kJEcUk+LtosXyiNzmJ6ycmPL39E=;
        b=oFk9C0TXFZzRe20ZH25I/6LyAt+sAptDyQOkFi0547FYT1Tl941GNdWvKqiKp6NdSO
         lKBFUEH+lGjI1agszNv/lKijaPxxnaMCKaoS+Y6jsp8e3sr6xpSo7IBtGWmdzD0NS5ia
         T/E5s6JDL13Q3u1kSlFyf7jnsij0ZRa3Kl59ZVcBLNEM0IYlXqHnD6q17Xm0n+iyW283
         8aPFF1UmxHYBllNmBvMvGztWxoCzKhhDI+PXm7mz4FTKy2D7VVZSX+PChraWVBn5OqMc
         OV8negE87QKd1nQVYy3q0yBK+kRPvs9x/SYpKB3I5RptMAA4cdUO9x8O/JNhVbBl9Zis
         pLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694243902; x=1694848702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqDJASkFf9bOx5d/kJEcUk+LtosXyiNzmJ6ycmPL39E=;
        b=Eztd513xgYQ2hjiSXC6xD5iLyoXOLCGP+aNrGCoLVyuPxnMnXq1FJD77cK+V9tk3Bc
         bf+YQxNH48zCGRY1vuxdI3uOEGk+XYNtMCzit4pX+TIh3EHfmUy5esTuA66imynjvpaa
         UXhk9MeQ38qm/PYiluqR8TNXWhiqJ5R6rGJ5sO6scZBCJVDukdpWabfUb0EG7Pxs+vvi
         xTOVlsLWSgzfUx/qAyTrjceA4p60IXflbkpvelEsWVti/0zvb2cuYOpp8G2hHWMRsFwG
         rPX0fxGHr2Kw97YR89ENZF1GMV9ovrfEX3rkMIqDFWzzFR8XC+B0/4RxEz/eatxlzk5r
         CQWA==
X-Gm-Message-State: AOJu0Yx1zMUs9d6ae23MZJRWDzImA6yzPfRxik4m3qcVHgZTt/C7WM7o
        Xgcj3S/A+90thKxizL0baEU=
X-Google-Smtp-Source: AGHT+IGyNwG977Ivdo5gEEHkQ2zwrpEq5LVVQoEL0W0xcKwEu28nWNew2izk6U4N+h0bbJuWlSl6Uw==
X-Received: by 2002:a17:902:c081:b0:1b8:6850:c3c4 with SMTP id j1-20020a170902c08100b001b86850c3c4mr4492720pld.22.1694243902179;
        Sat, 09 Sep 2023 00:18:22 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d30400b001bc5dc0cd75sm2629072plc.180.2023.09.09.00.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 00:18:21 -0700 (PDT)
From:   alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To:     chandan.babu@oracle.com
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2] xfs: remove redundant batch variables for serialization
Date:   Sat,  9 Sep 2023 15:17:51 +0800
Message-Id: <20230909071750.2455895-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 0a0fd19573d8..72dab39376b7 100644
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
2.31.1

