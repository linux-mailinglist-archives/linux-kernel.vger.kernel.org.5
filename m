Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF557A6F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjISXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjISXd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:33:58 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0651383;
        Tue, 19 Sep 2023 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695166432; x=1726702432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jhUxzf1WAjnmOPmNQMlxxqCSn6QXjVFZ7KYA9//gvkQ=;
  b=I+fEtXYL7TH/x0VNNuERTX3UcSH5FNXy6cW0ZL7n2kXPnr2LQwkqfK22
   BhXkXKh2IoG0qinyu7D3wBYsG6HnqWMkKZQn5OahX9PSB+viHOsOI3cZo
   7u/PNGYOcmsMDhlphhfdhQi/gEteDgeO7iU7WAwot6So5HpMT5DwlMdcK
   s=;
X-IronPort-AV: E=Sophos;i="6.02,160,1688428800"; 
   d="scan'208";a="30115787"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:33:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id E19E48A5E4;
        Tue, 19 Sep 2023 23:33:50 +0000 (UTC)
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 19 Sep 2023 23:33:45 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.88.167.207) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 19 Sep 2023 23:33:45 +0000
From:   Suraj Jitindar Singh <surajjs@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <adobriyan@gmail.com>,
        <sjitindarsingh@gmail.com>, Zhihao Cheng <chengzhihao1@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH stable 5.10.y] proc: fix a dentry lock race between release_task and lookup
Date:   Tue, 19 Sep 2023 16:33:35 -0700
Message-ID: <20230919233335.170835-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.88.167.207]
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit d919a1e79bac890421537cf02ae773007bf55e6b upstream.

Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
moved proc_flush_task() behind __exit_signal().  Then, process systemd can
take long period high cpu usage during releasing task in following
concurrent processes:

  systemd                                 ps
kernel_waitid                 stat(/proc/tgid)
  do_wait                       filename_lookup
    wait_consider_task            lookup_fast
      release_task
        __exit_signal
          __unhash_process
            detach_pid
              __change_pid // remove task->pid_links
                                     d_revalidate -> pid_revalidate  // 0
                                     d_invalidate(/proc/tgid)
                                       shrink_dcache_parent(/proc/tgid)
                                         d_walk(/proc/tgid)
                                           spin_lock_nested(/proc/tgid/fd)
                                           // iterating opened fd
        proc_flush_pid                                    |
           d_invalidate (/proc/tgid/fd)                   |
              shrink_dcache_parent(/proc/tgid/fd)         |
                shrink_dentry_list(subdirs)               ↓
                  shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock

Function d_invalidate() will remove dentry from hash firstly, but why does
proc_flush_pid() process dentry '/proc/tgid/fd' before dentry
'/proc/tgid'?  That's because proc_pid_make_inode() adds proc inode in
reverse order by invoking hlist_add_head_rcu().  But proc should not add
any inodes under '/proc/tgid' except '/proc/tgid/task/pid', fix it by
adding inode into 'pid->inodes' only if the inode is /proc/tgid or
/proc/tgid/task/pid.

Performance regression:
Create 200 tasks, each task open one file for 50,000 times. Kill all
tasks when opened files exceed 10,000,000 (cat /proc/sys/fs/file-nr).

Before fix:
$ time killall -wq aa
  real    4m40.946s   # During this period, we can see 'ps' and 'systemd'
			taking high cpu usage.

After fix:
$ time killall -wq aa
  real    1m20.732s   # During this period, we can see 'systemd' taking
			high cpu usage.

Link: https://lkml.kernel.org/r/20220713130029.4133533-1-chengzhihao1@huawei.com
Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ bp: Context adjustments ]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 fs/proc/base.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index a484c30bd5cf..712948e97991 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1881,7 +1881,7 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 	put_pid(pid);
 }
 
-struct inode *proc_pid_make_inode(struct super_block * sb,
+struct inode *proc_pid_make_inode(struct super_block *sb,
 				  struct task_struct *task, umode_t mode)
 {
 	struct inode * inode;
@@ -1910,11 +1910,6 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 
 	/* Let the pid remember us for quick removal */
 	ei->pid = pid;
-	if (S_ISDIR(mode)) {
-		spin_lock(&pid->lock);
-		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
-		spin_unlock(&pid->lock);
-	}
 
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 	security_task_to_inode(task, inode);
@@ -1927,6 +1922,39 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	return NULL;
 }
 
+/*
+ * Generating an inode and adding it into @pid->inodes, so that task will
+ * invalidate inode's dentry before being released.
+ *
+ * This helper is used for creating dir-type entries under '/proc' and
+ * '/proc/<tgid>/task'. Other entries(eg. fd, stat) under '/proc/<tgid>'
+ * can be released by invalidating '/proc/<tgid>' dentry.
+ * In theory, dentries under '/proc/<tgid>/task' can also be released by
+ * invalidating '/proc/<tgid>' dentry, we reserve it to handle single
+ * thread exiting situation: Any one of threads should invalidate its
+ * '/proc/<tgid>/task/<pid>' dentry before released.
+ */
+static struct inode *proc_pid_make_base_inode(struct super_block *sb,
+				struct task_struct *task, umode_t mode)
+{
+	struct inode *inode;
+	struct proc_inode *ei;
+	struct pid *pid;
+
+	inode = proc_pid_make_inode(sb, task, mode);
+	if (!inode)
+		return NULL;
+
+	/* Let proc_flush_pid find this directory inode */
+	ei = PROC_I(inode);
+	pid = ei->pid;
+	spin_lock(&pid->lock);
+	hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
+	spin_unlock(&pid->lock);
+
+	return inode;
+}
+
 int pid_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int query_flags)
 {
@@ -3341,7 +3369,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task,
+					 S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
@@ -3637,7 +3666,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
 	struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
+	inode = proc_pid_make_base_inode(dentry->d_sb, task,
+					 S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
-- 
2.34.1

