Return-Path: <linux-kernel+bounces-49697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0630E846E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D61C220CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD77C0A2;
	Fri,  2 Feb 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ0YEdnH"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001122067
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870954; cv=none; b=Y127Hy3wKZSc47ezjfaQ2uUljaQYch13bTLpoAVj+X9QdSiq+HBWXemx9JHUzCtudlerFqBZ4FbowaGYSFbBzghWn+grBgGq+2HpjLWHgfb7R6JDdf6HeKSDu+f6300bRgp4dfeIqpfihyqjLN6pdkZRAjfWeatXP4bMx0LVvv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870954; c=relaxed/simple;
	bh=TUNEWgwCE7TF4s1setZFQ7vqa+aUgx+J5Hk6cLFenSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u/Lf1CwsK4folo9F5lxAwUmotR69eXr9FjVfABA61nuMs2nq/LobBCLUSEJh6P9S/c6h2P8OHgW/23lxuxAeK6KAiDeQDmdJdvTUy7Ro9BZDVmt4Zchd56SINFh4L3rJ5zTfa1lr420eMF6bVmMuGvaGthlAXW9jgxYX+3lx+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ0YEdnH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-295f3bf41d5so489483a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706870952; x=1707475752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvX7fSziumDbXdZjiUHHfgTgPg/Ff9yAzyog8/e7MMo=;
        b=lJ0YEdnHIBhlunGlOGpZszmyU3cNLDaDHzExGUQHsEpGGT9YKxOu/8P3ZYmVhbIK4p
         54vjgHagq9CLFbBKpCjmq0t+++Ni4hvzzu6hB0Z6FRjiKyhP1b8XeCjRttzkX0nTsjIT
         lG/IuAI+uJQwM4sESY7St/ImdbSjqKv8niUy+8bbC981lhLCvNe4trOdMdqD2cszMViH
         x5APeYZe46QA5K3mlGCqYOYGrvZh9x5Zr36Qn0xuHctVLMCDpLoRjaYqnBRqkrFI2356
         PktwFfL78xCChafvrMz8MNTuUsAz2TemCWkXXdIhMj14fHd0xd5tAc3vgq4h+aZ8ruz5
         hyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870952; x=1707475752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvX7fSziumDbXdZjiUHHfgTgPg/Ff9yAzyog8/e7MMo=;
        b=siz3CvritzmrmkI/fEjNaZsAT6qzGLW98lK9LVFFjeMo4k5AkQH791nM3KlY6pnosA
         1v8wnHQJ1ADBvTjorZ6NhRJjpMxHn3GNz+ZmJVzhraocdSHwoQu6G93Wi3CyWRPhS0j3
         D8lAV0ruAUxQehQNF+fykQ3RMAtE+rOWXDt/Vkrpnv2uGfufsfhHu7jjYWHlN7K8UPvJ
         2j0KxqWi+nud7UTCAsIK4ZJnasvnWlcpaxUH2iquiDNQx6/qSDsz2qJCeB0VgteRaI4q
         WdoBkMnZQp3JQM0bzWtjKHs3vHTA48yTAmIP/1CsFOqyYpLB7mB4gVRcRIvkIB0reOMG
         t3sw==
X-Gm-Message-State: AOJu0Yxr0bTSzk67sIWubEBDvbq9+jOyRKPP6zJy4o9RGe4wV9FtN69L
	fy75fttMUr0KDrPwaqZtD42QwDDfGUCDTcGwc0AmhzLRRRR9vH/i
X-Google-Smtp-Source: AGHT+IGt0gdW6mrDcUmC1w0BRk/KHj5akXujwsZq3qhU+VxISakWquy43yOwlo5jvZp/B3KSXo11SQ==
X-Received: by 2002:a17:90a:d98b:b0:296:1dcf:c297 with SMTP id d11-20020a17090ad98b00b002961dcfc297mr2954867pjv.7.1706870951431;
        Fri, 02 Feb 2024 02:49:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVT4GTjep3haOrCyEzDu4yCllXlJiDYd3HSnRss2NjFhnD7dw0zgX3JWqiZqfHdLb7/b5jJEFVxbNtmy5LK5RSa+MZ5Cc6qaETDwJF8fTGJQr9LSs7YIoc2UojKBRkJrmvk8F0cJRHnqORH
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903209200b001d8cde39e8bsm1314497plc.194.2024.02.02.02.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:49:11 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cpuset: remove /proc/PID/cpuset
Date: Fri,  2 Feb 2024 18:49:11 +0800
Message-Id: <20240202104911.125894-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

Now we can get all cgroup paths from /proc/PID/cgroup for
a long time, so it maybe useless to keep /proc/PID/cpuset,
besides the path get from /proc/PID/cpuset is not consistent
with /proc/PID/cgroup in default hierarchy, so now we may
can safely remove /proc/PID/cpuset to avoid the mismatch.

root@test:~# cat /proc/1186/cgroup
0::/system.slice/lmeter.service

root@test:~# cat /proc/1186/cpuset
/system.slice

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 arch/mips/configs/sb1250_swarm_defconfig |  1 -
 arch/sh/configs/sdk7786_defconfig        |  1 -
 arch/sh/configs/urquell_defconfig        |  1 -
 fs/proc/base.c                           |  6 ----
 kernel/cgroup/cpuset.c                   | 40 ------------------------
 5 files changed, 49 deletions(-)

diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index ce855b644bb0..2fbea9c604df 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -3,7 +3,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
-# CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_NAMESPACES=y
 CONFIG_RELAY=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 7b427c17fbfe..6fe340d4860c 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -13,7 +13,6 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
-# CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_SCHED=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 445bb451a5ec..c960221a0549 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -11,7 +11,6 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
-# CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_SCHED=y
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 98a031ac2648..8dcd23b9212a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3309,9 +3309,6 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_LATENCYTOP
 	REG("latency",  S_IRUGO, proc_lstats_operations),
 #endif
-#ifdef CONFIG_PROC_PID_CPUSET
-	ONE("cpuset",     S_IRUGO, proc_cpuset_show),
-#endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
 #endif
@@ -3658,9 +3655,6 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_LATENCYTOP
 	REG("latency",  S_IRUGO, proc_lstats_operations),
 #endif
-#ifdef CONFIG_PROC_PID_CPUSET
-	ONE("cpuset",    S_IRUGO, proc_cpuset_show),
-#endif
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
 #endif
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..908cd7e6efa8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -5066,46 +5066,6 @@ void __cpuset_memory_pressure_bump(void)
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_PROC_PID_CPUSET
-/*
- * proc_cpuset_show()
- *  - Print tasks cpuset path into seq_file.
- *  - Used for /proc/<pid>/cpuset.
- *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
- *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
- *    anyway.
- */
-int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
-		     struct pid *pid, struct task_struct *tsk)
-{
-	char *buf;
-	struct cgroup_subsys_state *css;
-	int retval;
-
-	retval = -ENOMEM;
-	buf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!buf)
-		goto out;
-
-	css = task_get_css(tsk, cpuset_cgrp_id);
-	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
-				current->nsproxy->cgroup_ns);
-	css_put(css);
-	if (retval == -E2BIG)
-		retval = -ENAMETOOLONG;
-	if (retval < 0)
-		goto out_free;
-	seq_puts(m, buf);
-	seq_putc(m, '\n');
-	retval = 0;
-out_free:
-	kfree(buf);
-out:
-	return retval;
-}
-#endif /* CONFIG_PROC_PID_CPUSET */
-
 /* Display task mems_allowed in /proc/<pid>/status file. */
 void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
 {
-- 
2.25.1


