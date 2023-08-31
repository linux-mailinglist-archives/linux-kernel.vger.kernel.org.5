Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E178F40F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347350AbjHaUbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjHaUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:31:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CCE1721
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B43D4B823C5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E03C433C7;
        Thu, 31 Aug 2023 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693513836;
        bh=aQ4nhpCB5+LdRupp8kpZ3PR8UVwoGTWspDaPEo1f0cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qoj9BWv/Sabgffn1ain9/MQNbJdU3u7u3ak+NMiR3/HXmJ6pBRPdoI+Vei+nLCmYI
         6M6v70LigBsh44jVsb6W3jYxb6pm6g/424+nmE8Wb/1VvkKVtpGDRBxWHE3pxTjpXD
         C2ITYtrjHpakSsMiKVDsSH0KCbUf0tZ48tVE87diB8q7Mi2sPA8i5CmGaqa8PY1bSq
         lhRWjUXWEFJ7b1kC/IMgfdQhnVHlSROWlL5CWN6JkeZS29awh8JZUV0AnVix6L2Xph
         R86IPcMWO86QSiE5CbyfwK7XHtAvKDHaqu6OJsfA9bq1hUkijaopJQeMTUyVYVI4+9
         9ShIwcDzQyPww==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v4 7/7] sched/fair: Fair server interface
Date:   Thu, 31 Aug 2023 22:28:58 +0200
Message-Id: <db775d65b18ddac4a75faad6761c6c2abf3efb78.1693510979.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1693510979.git.bristot@kernel.org>
References: <cover.1693510979.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interface for fair server setup on debugfs.

Each rq have three file under /sys/kernel/debug/sched/rq/CPU{ID}:

 - fair_server_runtime: set runtime in ns
 - fair_server_period: set period in ns
 - fair_server_defer: on/off for the defer mechanism

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/debug.c | 177 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4c3d0d9f3db6..dad7d5d073ef 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -333,8 +333,183 @@ static const struct file_operations sched_debug_fops = {
 	.release	= seq_release,
 };
 
+static ssize_t
+sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long flags;
+	u64 runtime;
+	int err;
+
+	err = kstrtoull_from_user(ubuf, cnt, 10, &runtime);
+	if (err)
+		return err;
+
+	raw_spin_rq_lock_irqsave(rq, flags);
+	if (runtime > rq->fair_server.dl_period)
+		err = -EINVAL;
+	else
+		rq->fair_server.dl_runtime = runtime;
+	raw_spin_rq_unlock_irqrestore(rq, flags);
+
+	if (err)
+		return err;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	seq_printf(m, "%llu\n", rq->fair_server.dl_runtime);
+	return 0;
+}
+
+static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_runtime_fops = {
+	.open		= sched_fair_server_runtime_open,
+	.write		= sched_fair_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static unsigned int fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned int fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+
+static ssize_t
+sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long flags;
+	u64 period;
+	int err;
+
+	err = kstrtoull_from_user(ubuf, cnt, 10, &period);
+	if (err)
+		return err;
+
+	if (period < fair_server_period_min || period > fair_server_period_max)
+		return -EINVAL;
+
+	raw_spin_rq_lock_irqsave(rq, flags);
+	if (period < rq->fair_server.dl_runtime)
+		err = -EINVAL;
+	else
+		rq->fair_server.dl_period = period;
+	raw_spin_rq_unlock_irqrestore(rq, flags);
+
+	if (err)
+		return err;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_fair_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	seq_printf(m, "%llu\n", rq->fair_server.dl_period);
+	return 0;
+}
+
+static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_period_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_period_fops = {
+	.open		= sched_fair_server_period_open,
+	.write		= sched_fair_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static ssize_t
+sched_fair_server_defer_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long flags;
+	u64 defer;
+	int err;
+
+	err = kstrtoull_from_user(ubuf, cnt, 10, &defer);
+	if (err)
+		return err;
+
+	if (defer < 0 || defer > 1)
+		return -EINVAL;
+
+	raw_spin_rq_lock_irqsave(rq, flags);
+	rq->fair_server_defer = defer;
+	raw_spin_rq_unlock_irqrestore(rq, flags);
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_fair_server_defer_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	seq_printf(m, "%d\n", rq->fair_server_defer);
+	return 0;
+}
+
+static int sched_fair_server_defer_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_defer_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_defer_fops = {
+	.open		= sched_fair_server_defer_open,
+	.write		= sched_fair_server_defer_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct dentry *debugfs_sched;
 
+void debugfs_fair_server_init(void)
+{
+	long cpu;
+	struct dentry *rq_dentry;
+
+	rq_dentry = debugfs_create_dir("rq", debugfs_sched);
+	if (!rq_dentry)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%ld", cpu);
+		d_cpu = debugfs_create_dir(buf, rq_dentry);
+
+		debugfs_create_file("fair_server_runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
+		debugfs_create_file("fair_server_period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
+		debugfs_create_file("fair_server_defer", 0644, d_cpu, (void *) cpu, &fair_server_defer_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -374,6 +549,8 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_fair_server_init();
+
 	return 0;
 }
 late_initcall(sched_init_debug);
-- 
2.40.1

