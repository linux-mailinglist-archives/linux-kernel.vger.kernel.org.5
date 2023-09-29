Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490B97B37FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjI2Qa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjI2QaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:30:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67381199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:30:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so17920043a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696005021; x=1696609821; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QA2f5lgwTTwn9iY6UG1Mu764p2rQ3AQ0k6JCDenrBcA=;
        b=B3GaBSWbUTjIz701Evcjh9HdU5pqjkQfmi3hITxg2VIFpqCKsdhe+CtqPVYFEhsCXu
         TdZYPrwj4pjT4bC7C9paUySMX0H5PT+r0UYHnACXgZoUPo74gRwfTMSfGdTtJgO9JxQk
         dwafoG/9+OwEkDqt3NmdG1Z8d0eKxFyCLg/31IOPpAdB5a5fMucMCMFUmG50BWQ788N9
         jfIdx8dmCm4mnebPRjYthIvyeJpiny5e/SS8QmWOBC2gHl7t28xNh2D4vGpd1daIjVf0
         F4vmR62vNyhSbXRdr12jEFyDLH3wvzc+fauMr7DdWY87GmFlcKP9Je9ejAUXRCzMRmxY
         PgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696005021; x=1696609821;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA2f5lgwTTwn9iY6UG1Mu764p2rQ3AQ0k6JCDenrBcA=;
        b=UyPv/LZ9vkawNUj3zX0ayUnannmkD+i+ecYoBmLaiSmXNl5VUGG3AYQZVdcGHpw72T
         oQOTnEzeh5AF78hltGOt5PgI7mz4cKlnga1S502uXQQNN6ZRSARzHTvN9dJhTGmavLpv
         WiFEQM7pFK+9LZ+VS8Mo5SsjUL5qwiWTCCgF/3mmtjkOImzeQQLMCWReur5pGaIiC6CX
         QW8DLJ8CaqvAblhB6FwbhLYfVr25SPka/2BLK28NLf7NcfOrPwqa7Df+vKOXVwrAbl2R
         RKno7eZIwFCeNRHyMVSACE6DT+MP98FZsnxvZ/URu758VeihktgBdr857exYFwqQSFph
         1xZg==
X-Gm-Message-State: AOJu0Yxkz9/53gIAkINzou6aokKGPynmSl9YgCSB33Nmj7p3RcUtxF5M
        TLsUlL5fhOezij85ep4YxsVCjcqw8g==
X-Google-Smtp-Source: AGHT+IFbybhVcUPJdNQELLRuqN+C9LyNX8+k6eTPPwI/7ia2yTtepIqE4+1JHwrym0G5pJY+Zf+wCQ==
X-Received: by 2002:aa7:db50:0:b0:52b:db31:3c5c with SMTP id n16-20020aa7db50000000b0052bdb313c5cmr4351153edt.0.1696005020570;
        Fri, 29 Sep 2023 09:30:20 -0700 (PDT)
Received: from p183 ([46.53.252.219])
        by smtp.gmail.com with ESMTPSA id fi9-20020a056402550900b00533bab9d9f1sm8804430edb.1.2023.09.29.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:30:20 -0700 (PDT)
Date:   Fri, 29 Sep 2023 19:30:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use initializer for clearing some buffers
Message-ID: <3821d3a2-6e10-4629-b0d5-9519d828ab72@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save LOC by using dark magic of initialisation instead of memset().

Those buffer aren't passed to userspace directly so padding is not
an issue.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c     |   16 ++++++----------
 fs/proc/task_mmu.c |   11 +++--------
 2 files changed, 9 insertions(+), 18 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1153,11 +1153,10 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 static ssize_t oom_adj_write(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	char buffer[PROC_NUMBUF];
+	char buffer[PROC_NUMBUF] = {};
 	int oom_adj;
 	int err;
 
-	memset(buffer, 0, sizeof(buffer));
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count)) {
@@ -1213,11 +1212,10 @@ static ssize_t oom_score_adj_read(struct file *file, char __user *buf,
 static ssize_t oom_score_adj_write(struct file *file, const char __user *buf,
 					size_t count, loff_t *ppos)
 {
-	char buffer[PROC_NUMBUF];
+	char buffer[PROC_NUMBUF] = {};
 	int oom_score_adj;
 	int err;
 
-	memset(buffer, 0, sizeof(buffer));
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count)) {
@@ -1358,13 +1356,13 @@ static ssize_t proc_fault_inject_write(struct file * file,
 			const char __user * buf, size_t count, loff_t *ppos)
 {
 	struct task_struct *task;
-	char buffer[PROC_NUMBUF];
+	char buffer[PROC_NUMBUF] = {};
 	int make_it_fail;
 	int rv;
 
 	if (!capable(CAP_SYS_RESOURCE))
 		return -EPERM;
-	memset(buffer, 0, sizeof(buffer));
+
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count))
@@ -1509,11 +1507,10 @@ sched_autogroup_write(struct file *file, const char __user *buf,
 {
 	struct inode *inode = file_inode(file);
 	struct task_struct *p;
-	char buffer[PROC_NUMBUF];
+	char buffer[PROC_NUMBUF] = {};
 	int nice;
 	int err;
 
-	memset(buffer, 0, sizeof(buffer));
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count))
@@ -1666,10 +1663,9 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
 {
 	struct inode *inode = file_inode(file);
 	struct task_struct *p;
-	char buffer[TASK_COMM_LEN];
+	char buffer[TASK_COMM_LEN] = {};
 	const size_t maxlen = sizeof(buffer) - 1;
 
-	memset(buffer, 0, sizeof(buffer));
 	if (copy_from_user(buffer, buf, count > maxlen ? maxlen : count))
 		return -EFAULT;
 
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -849,9 +849,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 static int show_smap(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *vma = v;
-	struct mem_size_stats mss;
-
-	memset(&mss, 0, sizeof(mss));
+	struct mem_size_stats mss = {};
 
 	smap_gather_stats(vma, &mss, 0);
 
@@ -877,7 +875,7 @@ static int show_smap(struct seq_file *m, void *v)
 static int show_smaps_rollup(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
-	struct mem_size_stats mss;
+	struct mem_size_stats mss = {};
 	struct mm_struct *mm = priv->mm;
 	struct vm_area_struct *vma;
 	unsigned long vma_start = 0, last_vma_end = 0;
@@ -893,8 +891,6 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		goto out_put_task;
 	}
 
-	memset(&mss, 0, sizeof(mss));
-
 	ret = mmap_read_lock_killable(mm);
 	if (ret)
 		goto out_put_mm;
@@ -1246,14 +1242,13 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct task_struct *task;
-	char buffer[PROC_NUMBUF];
+	char buffer[PROC_NUMBUF] = {};
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
 	int itype;
 	int rv;
 
-	memset(buffer, 0, sizeof(buffer));
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count))
