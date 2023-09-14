Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E6F7A0AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbjINQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjINQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:32:44 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86AA1FDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:32:39 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-64f387094ddso6351946d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1694709158; x=1695313958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBpYCeeiHkRSP1d/Fs1QslqOdnD/9unLXrEK1uz74Tw=;
        b=x+Yd94kQKSZq7SABaWGpYOvW1N6EGdOnwF4m7cP5o+RuhkQFc1EOsZuEM7dU+8dk3t
         uroxGajlrl/9Rutb9mqnhWsJNu3lER21eXbd+Vyq7UwSfy/1znKJ2DSjfFf5YWOdJWHe
         dCtH6+gio+jjuxGxxnlfPVfSelTsK73kuNvoUdk8qj+zep/yZ+54U0BIw7YE+GvfMGeh
         MEoacB9uB0AXfrYu9X1lnjugk0VV9LcoZxOv8wP8y8oo7PcV3PiwnQNp80UqEuCnLLnU
         7+zLzpDkA7hpGkGKieJByvs4OZ7Bd1+k1P84x8MqEqdJMMgV6svjTOKkkmWybC+RHROX
         2zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709158; x=1695313958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBpYCeeiHkRSP1d/Fs1QslqOdnD/9unLXrEK1uz74Tw=;
        b=ks3p1BbDr0boFnxTnEtLVjerlK8yI7CEQ+W7CFhNWm9BjACw3JdbZ7nSXuNOe/GmD8
         EYIsjeUQ65wnB3pfmsICp3bbyHYDCPXLyQKWSf7b8FOBswEr6qgiGNIHzsi/2uNRSawd
         XsfL3axgayjMwNRayUPEQojjlTUyT4T3rV/ZnKrLguUWL6QhC47lS8JgXXT4GmFkdPb+
         UXhi7JXmgdCFwFxLTyPEPfKLOpOJV5ntuEzPdJUxUu7SRVLgLGRlzb4FgVCuwhwiReBK
         9mDGjQnMKMEJdV46Djb52ztkHV/1wyIWgz5Q+p2sjwMxRW+pHWk5K4SzS7NMwDNXoMbg
         4Jzg==
X-Gm-Message-State: AOJu0YzJ3tULiyRmx0QjupxZPvSHCk0fuDIAGDCKYP6ATqkUsHB/VBaK
        Hmw9AhvAtyJg8fZ1HDrg8Ym++0Li5gVG24mwGuipiA==
X-Google-Smtp-Source: AGHT+IGludCmXbLx+omxZ+Rh8LXM31hPcSOfnELHU56S6MFz8xkk0vPxdTAclYoBzGIE5OhYZCv9eQ==
X-Received: by 2002:a0c:e6c3:0:b0:64f:67ae:a132 with SMTP id l3-20020a0ce6c3000000b0064f67aea132mr6129634qvn.23.1694709158650;
        Thu, 14 Sep 2023 09:32:38 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id v6-20020a0cdd86000000b0063d38e52c8fsm579122qvk.18.2023.09.14.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:32:38 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Greg Ungerer <gerg@uclinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Ben Wolsieffer <Ben.Wolsieffer@hefring.com>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] proc: nommu: /proc/<pid>/maps: release mmap read lock
Date:   Thu, 14 Sep 2023 12:30:20 -0400
Message-ID: <20230914163019.4050530-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>

The no-MMU implementation of /proc/<pid>/map doesn't normally release
the mmap read lock, because it uses !IS_ERR_OR_NULL(_vml) to determine
whether to release the lock. Since _vml is NULL when the end of the
mappings is reached, the lock is not released.

This code was incorrectly adapted from the MMU implementation, which
at the time released the lock in m_next() before returning the last entry.

The MMU implementation has diverged further from the no-MMU version
since then, so this patch brings their locking and error handling into
sync, fixing the bug and hopefully avoiding similar issues in the
future.

Fixes: 47fecca15c09 ("fs/proc/task_nommu.c: don't use priv->task->mm")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 fs/proc/task_nommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 2c8b62265981..061bd3f82756 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -205,11 +205,16 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-ESRCH);
 
 	mm = priv->mm;
-	if (!mm || !mmget_not_zero(mm))
+	if (!mm || !mmget_not_zero(mm)) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return NULL;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		mmput(mm);
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
@@ -218,23 +223,21 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 	if (vma)
 		return vma;
 
-	mmap_read_unlock(mm);
-	mmput(mm);
 	return NULL;
 }
 
-static void m_stop(struct seq_file *m, void *_vml)
+static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
+	struct mm_struct *mm = priv->mm;
 
-	if (!IS_ERR_OR_NULL(_vml)) {
-		mmap_read_unlock(priv->mm);
-		mmput(priv->mm);
-	}
-	if (priv->task) {
-		put_task_struct(priv->task);
-		priv->task = NULL;
-	}
+	if (!priv->task)
+		return;
+
+	mmap_read_unlock(mm);
+	mmput(mm);
+	put_task_struct(priv->task);
+	priv->task = NULL;
 }
 
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
-- 
2.42.0

