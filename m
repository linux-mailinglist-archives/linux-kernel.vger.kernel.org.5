Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB955797B0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbjIGSAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjIGSAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:00:34 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFFB10F1;
        Thu,  7 Sep 2023 11:00:10 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-64b98479a66so7150396d6.0;
        Thu, 07 Sep 2023 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694109603; x=1694714403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HhokXD5xSGkPUoSoPqy6guGBFdQXw48s6owM048uKs4=;
        b=eaFmci6U9ItNe5GMkv7Cw6es6KYEHy+9AV2CWx8KiHPRrj8NhCtkvihzgtcD9jbivG
         NGB07nJkh45BAT6GHj7Lwn0Soqn4UA8Q56eBFq4GH0fCPsb23w0RVyBnByBR0EAkGNf1
         J+J0VewXW4dO7CETSqmWdjfxlZhMR0BE9Awx1fiGxK+gqeWfSvOODIioZoiBFxpcm4C8
         Q/tPbqhH/OhXEY6zNPvD1TSXBbjYWk7U6K/xr1QTcc3v2ssugz2JVDVZSOPfks9niHlY
         rj0o9Zra8t2qVr4dP7nSZ/EhmNpj+8FqYEfl36JUFYSSbuDSUHw6c/PhRPkCZ0jb7xu3
         HB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109603; x=1694714403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhokXD5xSGkPUoSoPqy6guGBFdQXw48s6owM048uKs4=;
        b=lm1+d5i5JHRENKKgjqdotlj7hbWfCg8GN7OeNOCvvmSvKgYhOmgikKdRXixlj6ZPTn
         4T/E9vwSPEUGMsS6PbcCQqhGa1frpA0CyXFSMQMwLGmsDdp/nw9cQPCSa3UKKw1tLhUG
         MS+oul89HiwGv8pNyP7doo0eoTisGl9fFgjBJ1BFGFSXceK23yc8uSFl1d+2uMO4skUe
         d19YSiURL19CPfPoYnWU8tFlXVctaXTNgoR2H+L7vApNpFwhD/Zz0amSPTiJwE8zKazT
         yoCF3H/HeGStjo7cDjt6n6auEfMbWx70Zuf3prC+B3+Rozqa3DBPHFC07v4LcLlLCPUo
         +vKw==
X-Gm-Message-State: AOJu0YwKZvcC9nIlIMcD7q//7+pRvfif8RXbdxbPqX3yuWNG4rHTIF5T
        bWGmqTdeh/Jr7rE9dwe5Qk8G1iZXbzt5Dg==
X-Google-Smtp-Source: AGHT+IF90bgyK6VXVH1rZEE+qmBogirTmNuiRL37+ff7b4iib6e0mP9tf5ABM61+CctjiLbZhbIRWA==
X-Received: by 2002:a17:902:c412:b0:1c3:4646:ca23 with SMTP id k18-20020a170902c41200b001c34646ca23mr12562013plk.29.1694089853688;
        Thu, 07 Sep 2023 05:30:53 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001bbd8cf6b57sm12734090plg.230.2023.09.07.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 05:30:53 -0700 (PDT)
From:   alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To:     chandan.babu@oracle.com
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] xfs: remove redundant batch variables for serialization
Date:   Thu,  7 Sep 2023 20:30:18 +0800
Message-Id: <20230907123017.1049345-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinliang Zheng <alexjlzheng@tencent.com>

Historically, when generic percpu counters were introduced in xfs for
free block counters by commit 0d485ada404b ("xfs: use generic percpu
counters for free block counter"), the counters use a custom batch size.
In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(), this
patch attempts to serialize the program using a smaller batch size as a
parameter to the addition function as the counter approaches 0.

Commit 8c1903d3081a ("xfs: inode and free block counters need to use
__percpu_counter_compare") pointed out the error in commit 0d485ada404b
("xfs: use generic percpu counters for free block counter") mentioned
above and said that "Because the counters use a custom batch size, the
comparison functions need to be aware of that batch size otherwise the
comparison does not work correctly".

After commit 8c1903d3081a ("xfs: inode and free block counters need to
use __percpu_counter_compare"), the existence of the batch variable is
no longer necessary, so it was removed to simplify the code.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
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

