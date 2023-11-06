Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6C7E3012
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjKFWof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjKFWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:44:24 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E1D51;
        Mon,  6 Nov 2023 14:44:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso4608268b3a.1;
        Mon, 06 Nov 2023 14:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699310661; x=1699915461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3veDMgMfom/Ebt8NzFsbnB5XbU+H8vB/5Wx02VWqWU4=;
        b=gYh1Z5leu1kHh83t/Wb7+ZHV3GYzJpbWoGTywKpmJwLVjV+1m26aYz9PlXDihL+hwF
         e2O1gGkK8I4oRh0ZTnWm/wSV1B2+h5Il9c84LETPYN+MNmhxtVn3gonIMnk2EuKZgUZ7
         o32nm0w1u83QMoe/3g+AEb+nxxErjFiHDm+BCFjpO5fhZGrLeVpsqIbGyGEO0OsXlHMi
         FyTzYoWyHk1YmqrYhGwlGGlMTYcyELqoIJC5QC/k/lHRrAxK4KVY4mBal3JCIE01+tJd
         YY4D0jDTY+3CE5WzK42mXncXa9CmZfy1iERd99/PpyITEdF8VYu4ntgOZ8JwVQykXxA/
         KAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310661; x=1699915461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3veDMgMfom/Ebt8NzFsbnB5XbU+H8vB/5Wx02VWqWU4=;
        b=aezak5SWOK8YM3tSB0/fhTYE0zvBtYBgIG64pczKhV1NWYClVU4uVmt9ZE6iqcpC74
         r4URD4RwuNjRXFGCm8OKJ1pc3/vWqmGxcebpFnJAkd0kgTNJvb3cuevsbRqzo0uq0WLA
         sWQ3eayecJsZMseKq+pdrsB2pWtF1EwNi2LEutfNcybxbnCclQcXaFDrZPQ6EEH5MuRm
         UST6HIubpS+r9tDTiRKXzN+e0/28cfz9pMc4w2kMW/NmFQrW6HfY8ts8+jdUvSm2vcYZ
         nAD0qRxpn2kr2eeyilzxTOZEJAm3bCHpXXtA0WtqFSsaq5/5b07xj6eFXhTKkCbJ9wiy
         3WRg==
X-Gm-Message-State: AOJu0YyHLeudC9m1l8pZ0r1EMlprGn/dW7XYfEWlmOlQHXlnX8yYdbha
        FEX1OzwRdysmub6aHE+ieZ2zl5uX160=
X-Google-Smtp-Source: AGHT+IG910yIVuNPbYnL+Ho6/bAy8i5TALbGKlXbrDhidWlcgAJ/PFck0c2FCgB+94f5t7fuspcFMw==
X-Received: by 2002:a05:6a20:a11c:b0:17b:62ae:a8bf with SMTP id q28-20020a056a20a11c00b0017b62aea8bfmr1008086pzk.30.1699310661370;
        Mon, 06 Nov 2023 14:44:21 -0800 (PST)
Received: from carrot.. (i223-218-131-225.s42.a014.ap.plala.or.jp. [223.218.131.225])
        by smtp.gmail.com with ESMTPSA id du8-20020a056a002b4800b0069346777241sm6216292pfb.97.2023.11.06.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:44:20 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org, Philipp Stanner <pstanner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nilfs2: use standard array-copy-function
Date:   Tue,  7 Nov 2023 07:44:16 +0900
Message-Id: <20231106224416.3055-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Philipp Stanner <pstanner@redhat.com>

ioctl.c utilizes memdup_user() to copy a userspace array. An overflow
check is performed manually before the function's invocation.

The new function memdup_array_user() standardizes copying userspace
arrays, thus, improving readability by making it more clear that an
array is being copied. Additionally, it also performs an overflow check.

Remove the (now redundant) manual overflow-check and replace
memdup_user() with memdup_array_user().

In addition, improve the grammar of the comment above
memdup_array_user().

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Link: https://lkml.kernel.org/r/20231103184831.99406-2-pstanner@redhat.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Andrew, please queue this cleanup patch for the next merge window.

It's a little early as the current merge window isn't over yet, but I
haven't had any problems with it and I feel it's better to focus on other
series, so I'll send this now.

Thanks,
Ryusuke Konishi

fs/nilfs2/ioctl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 40ffade49f38..cfb6aca5ec38 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -872,16 +872,14 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 	nsegs = argv[4].v_nmembs;
 	if (argv[4].v_size != argsz[4])
 		goto out;
-	if (nsegs > UINT_MAX / sizeof(__u64))
-		goto out;
 
 	/*
 	 * argv[4] points to segment numbers this ioctl cleans.  We
-	 * use kmalloc() for its buffer because memory used for the
-	 * segment numbers is enough small.
+	 * use kmalloc() for its buffer because the memory used for the
+	 * segment numbers is small enough.
 	 */
-	kbufs[4] = memdup_user((void __user *)(unsigned long)argv[4].v_base,
-			       nsegs * sizeof(__u64));
+	kbufs[4] = memdup_array_user((void __user *)(unsigned long)argv[4].v_base,
+				     nsegs, sizeof(__u64));
 	if (IS_ERR(kbufs[4])) {
 		ret = PTR_ERR(kbufs[4]);
 		goto out;
-- 
2.34.1

