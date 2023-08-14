Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F077BED2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHNRV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHNRVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:21:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EA10C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:21:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so70368621fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692033706; x=1692638506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9JC5TFMXUMZWvGoHxDc++vq6ZIXjTrzJoWy+WtuWXDM=;
        b=KoAWn8A5CWOqyO7GkArV0tVey//pMjPAxQu+o0AWib7dv4xooofRm/gacWDYLbIIzZ
         wwBgBcaoBfA5RLFMfgLGhpdX4Q94KlvY7DaHd1/HfwrFVfZj0AJ+CbUl1fiD0NZMXhzG
         0Si0wJlilkAt5E/DJD0j43Bh9KrLiETiPjxY4qJu2lZX+tFsy5SGFlkAw61S/iYp/JeV
         5FezNTBPWkLi8kq5KolGdEVfuzOYb6OmKLnUNcGH/wjF/8htqj1dUHsJTZERX3mutcBv
         H2QpyrahXO6phpCuAZjVspNVfhl4clKCRpRY/KeglpW0qxm060sbjPNOuUnOFfwxx2J7
         9MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692033706; x=1692638506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JC5TFMXUMZWvGoHxDc++vq6ZIXjTrzJoWy+WtuWXDM=;
        b=Z3xqgynV30zIH+fW5ssaWF8gqZ/SEpgKNkjfTyiWLFmQomJHq/i94bL7gZQoRQ4fef
         GjMg9IAB8P7HX01gy28lw0BELcbQwlKgMz37IbYgdAaW0UNKCUaSEnb/ldX1vqPGleWq
         Ek+q/izIa+gd5llMk86FFxNEPqSRCOOyFqdHRWRUcGnJ5nPbXS9SA2WAvwzkf3cVsX9Q
         RgDL1WAVpzfKkcwN+GfCFTc8BsJSAtPAFpGK1zbJGRtk31zOx6XmuShfTRibbNQ0Kojd
         SP/4phZ90Jk2G2FHvleHxbP2qRDM0uMctJSZYQDhVvq56zCiSPj64blIgGobMxoCxEHx
         to8Q==
X-Gm-Message-State: AOJu0YzZ/jWysW/jTTfDVYhlNlyXdxmNvxxlw5yN07pJpMtMd8i2YhDZ
        JJ9b1l4B9NRGBfdIqkkdutexvGpVNJsQLQ==
X-Google-Smtp-Source: AGHT+IEn4S9L2R9YQDurZoa+CF0wHXe3lqfG72WFd/bO8Q6ncD1XA83TUYmlcJcmfZiNMlmBdExT2A==
X-Received: by 2002:a2e:8612:0:b0:2b9:dd5d:5d0a with SMTP id a18-20020a2e8612000000b002b9dd5d5d0amr6781528lji.40.1692033705607;
        Mon, 14 Aug 2023 10:21:45 -0700 (PDT)
Received: from f.. (cst-prg-75-195.cust.vodafone.cz. [46.135.75.195])
        by smtp.gmail.com with ESMTPSA id sa25-20020a170906edb900b009937dbabbd5sm5855444ejb.220.2023.08.14.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 10:21:45 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, david@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, koct9i@gmail.com, oleg@redhat.com,
        dave@stgolabs.net, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] kernel/fork: stop playing lockless games for exe_file replacement
Date:   Mon, 14 Aug 2023 19:21:40 +0200
Message-Id: <20230814172140.1777161-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
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

xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
exe_file serialization"). While the commit message does not explain
*why* the change, I found the original submission [1] which ultimately
claims it cleans things up by removing dependency of exe_file on the
semaphore.

However, fe69d560b5bd ("kernel/fork: always deny write access to current
MM exe_file") added a semaphore up/down cycle to synchronize the state
of exe_file against fork, defeating the point of the original change.

This is on top of semaphore trips already present both in the replacing
function and prctl (the only consumer).

Normally replacing exe_file does not happen for busy processes, thus
write-locking is not an impediment to performance in the intended use
case.  If someone keeps invoking the routine for a busy processes they
are trying to play dirty and that's another reason to avoid any
trickery.

As such I think the atomic here only adds complexity for no benefit.

Just write-lock around the replacement.

I also note that replacement races against the mapping check loop as
nothing synchronizes actual assignment with with said checks but I am
not addressing it in this patch. (Is the loop of any use to begin with?)

V2:
- fix up comments
- tweak commit message

Link: https://lore.kernel.org/linux-mm/1424979417.10344.14.camel@stgolabs.net/ [1]
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/exec.c     |  4 ++--
 kernel/fork.c | 22 +++++++++-------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1a827d55ba94..dc41180d4e70 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1276,8 +1276,8 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
-	 * not visible until then. This also enables the update
-	 * to be lockless.
+	 * not visible until then. Doing it here also ensures
+	 * we don't race against replace_mm_exe_file().
 	 */
 	retval = set_mm_exe_file(bprm->mm, bprm->file);
 	if (retval)
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..7b8b63fb0438 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1396,8 +1396,8 @@ EXPORT_SYMBOL_GPL(mmput_async);
  * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
  *
  * Main users are mmput() and sys_execve(). Callers prevent concurrent
- * invocations: in mmput() nobody alive left, in execve task is single
- * threaded.
+ * invocations: in mmput() nobody alive left, in execve it happens before
+ * the new mm is made visible to anyone.
  *
  * Can only fail if new_exe_file != NULL.
  */
@@ -1432,9 +1432,7 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 /**
  * replace_mm_exe_file - replace a reference to the mm's executable file
  *
- * This changes mm's executable file (shown as symlink /proc/[pid]/exe),
- * dealing with concurrent invocation and without grabbing the mmap lock in
- * write mode.
+ * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
  *
  * Main user is sys_prctl(PR_SET_MM_MAP/EXE_FILE).
  */
@@ -1464,22 +1462,20 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 			return ret;
 	}
 
-	/* set the new file, lockless */
 	ret = deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
 
-	old_exe_file = xchg(&mm->exe_file, new_exe_file);
+	/* set the new file */
+	mmap_write_lock(mm);
+	old_exe_file = rcu_dereference_raw(mm->exe_file);
+	rcu_assign_pointer(mm->exe_file, new_exe_file);
+	mmap_write_unlock(mm);
+
 	if (old_exe_file) {
-		/*
-		 * Don't race with dup_mmap() getting the file and disallowing
-		 * write access while someone might open the file writable.
-		 */
-		mmap_read_lock(mm);
 		allow_write_access(old_exe_file);
 		fput(old_exe_file);
-		mmap_read_unlock(mm);
 	}
 	return 0;
 }
-- 
2.39.2

