Return-Path: <linux-kernel+bounces-13695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6B820B46
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 12:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34140B213DE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068E54691;
	Sun, 31 Dec 2023 11:24:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B814418
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3BVBOZgG083971;
	Sun, 31 Dec 2023 20:24:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sun, 31 Dec 2023 20:24:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3BVBOZds083967
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 31 Dec 2023 20:24:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <88573ed5-5b9b-4488-9b4c-71ca6ad95101@I-love.SAKURA.ne.jp>
Date: Sun, 31 Dec 2023 20:24:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] profiling: Remove create_prof_cpu_mask().
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

create_prof_cpu_mask() is no longer used after commit 1f44a225777e ("s390:
convert interrupt handling to use generic hardirq").

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/profile.h |  5 -----
 kernel/profile.c        | 43 -----------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/include/linux/profile.h b/include/linux/profile.h
index 11db1ec516e2..04ae5ebcb637 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -18,13 +18,8 @@ struct proc_dir_entry;
 struct notifier_block;
 
 #if defined(CONFIG_PROFILING) && defined(CONFIG_PROC_FS)
-void create_prof_cpu_mask(void);
 int create_proc_profile(void);
 #else
-static inline void create_prof_cpu_mask(void)
-{
-}
-
 static inline int create_proc_profile(void)
 {
 	return 0;
diff --git a/kernel/profile.c b/kernel/profile.c
index 8a77769bc4b4..2b775cc5c28f 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -344,49 +344,6 @@ void profile_tick(int type)
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
-static int prof_cpu_mask_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "%*pb\n", cpumask_pr_args(prof_cpu_mask));
-	return 0;
-}
-
-static int prof_cpu_mask_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, prof_cpu_mask_proc_show, NULL);
-}
-
-static ssize_t prof_cpu_mask_proc_write(struct file *file,
-	const char __user *buffer, size_t count, loff_t *pos)
-{
-	cpumask_var_t new_value;
-	int err;
-
-	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
-		return -ENOMEM;
-
-	err = cpumask_parse_user(buffer, count, new_value);
-	if (!err) {
-		cpumask_copy(prof_cpu_mask, new_value);
-		err = count;
-	}
-	free_cpumask_var(new_value);
-	return err;
-}
-
-static const struct proc_ops prof_cpu_mask_proc_ops = {
-	.proc_open	= prof_cpu_mask_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-	.proc_write	= prof_cpu_mask_proc_write,
-};
-
-void create_prof_cpu_mask(void)
-{
-	/* create /proc/irq/prof_cpu_mask */
-	proc_create("irq/prof_cpu_mask", 0600, NULL, &prof_cpu_mask_proc_ops);
-}
-
 /*
  * This function accesses profiling information. The returned data is
  * binary: the sampling step and the actual contents of the profile
-- 
2.18.4


