Return-Path: <linux-kernel+bounces-55526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9C84BDAB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880C2B244DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC81B81F;
	Tue,  6 Feb 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwCpZaN0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94413AD9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246036; cv=none; b=tt3BC/36Ft4pqWW9BAXR/qWs4VOUeeR7v+Z8y5qHlPWsxOLpgiLWtNGWySzhlx6cjEqGsw7vU7sl8qxfH7jNNTH3Cy9FcaayjntvZuNSCUM3cRBT9/q+9MNYdqDSaMD0o85Baz+PkAUtz6jxGUs9QajnoBCHT8nbJ9Ui+I8Kvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246036; c=relaxed/simple;
	bh=iYscZKrjzq/VJEK3uGeFUSm3luENc+9pjzqH3KmL/aA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Pa4A0I56F3SJ5xsxMK4/9mKxU6GcDZBnOGjSg85fOwCO78B69m/sf307mNPP261mJfne/Qvmz/m5yNojCzrJ4NQBNdhrvxsB8WuutPPhfesmXYV5rbV3LJZ8EoFK1sFhMunb60jOvA5ZKY8jJGOPFTwBs0VJzdviE4FdqcGYzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwCpZaN0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707246028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=k/0Yk/GxZoG+c8QW/AJpba3YgbiqoE294HEaLbyeDao=;
	b=hwCpZaN07MckGbMME2oaHU1zf8z3mNp0oJYcSivLIlj3aVFfzOomQSNE8iMuKfW5daRyGj
	CDjx4Hx/8f9g2B2fGhG+rvViV7bPQNJZYGf+UqG1SHgkD6kXH1ew2qKhLjQ1bQfP5DySrs
	JOSTyl03wQExmTON7kjzD1O9RhrkTc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-gj3_c91fPQq4lZqKhhmmNA-1; Tue, 06 Feb 2024 14:00:25 -0500
X-MC-Unique: gj3_c91fPQq4lZqKhhmmNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E512881C85;
	Tue,  6 Feb 2024 19:00:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F36EB2026D06;
	Tue,  6 Feb 2024 19:00:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 19650401E0C72; Tue,  6 Feb 2024 15:58:07 -0300 (-03)
Message-ID: <20240206185709.849294306@redhat.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 15:49:12 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 01/12] cpu isolation: basic block interference infrastructure
References: <20240206184911.248214633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

There are a number of codepaths in the kernel that interrupt
code execution in remote CPUs. A subset of such codepaths are
triggered from userspace and can therefore return errors.

Introduce a cpumask named "block interference", writable from userspace.

This cpumask (and associated helpers) can be used by code that executes
code on remote CPUs to optionally return an error.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-isolation/include/linux/sched/isolation.h
===================================================================
--- linux-isolation.orig/include/linux/sched/isolation.h
+++ linux-isolation/include/linux/sched/isolation.h
@@ -72,4 +72,28 @@ static inline bool cpu_is_isolated(int c
 	       cpuset_cpu_is_isolated(cpu);
 }
 
+#ifdef CONFIG_CPU_ISOLATION
+extern cpumask_var_t block_interf_cpumask;
+extern bool block_interf_cpumask_active;
+
+int block_interf_srcu_read_lock(void);
+void block_interf_srcu_read_unlock(int idx);
+
+void block_interf_assert_held(void);
+
+#else
+int block_interf_srcu_read_lock(void) { return 0; }
+void block_interf_srcu_read_unlock(int idx) { }
+void block_interf_assert_held(void) { }
+#endif
+
+static inline bool block_interf_cpu(int cpu)
+{
+#ifdef CONFIG_CPU_ISOLATION
+	if (block_interf_cpumask_active)
+		return cpumask_test_cpu(cpu, block_interf_cpumask);
+#endif
+	return false;
+}
+
 #endif /* _LINUX_SCHED_ISOLATION_H */
Index: linux-isolation/kernel/sched/isolation.c
===================================================================
--- linux-isolation.orig/kernel/sched/isolation.c
+++ linux-isolation/kernel/sched/isolation.c
@@ -239,3 +239,109 @@ static int __init housekeeping_isolcpus_
 	return housekeeping_setup(str, flags);
 }
 __setup("isolcpus=", housekeeping_isolcpus_setup);
+
+struct srcu_struct block_interf_srcu;
+EXPORT_SYMBOL_GPL(block_interf_srcu);
+
+cpumask_var_t block_interf_cpumask;
+EXPORT_SYMBOL_GPL(block_interf_cpumask);
+
+bool block_interf_cpumask_active;
+EXPORT_SYMBOL_GPL(block_interf_cpumask_active);
+
+int block_interf_srcu_read_lock(void)
+{
+	return srcu_read_lock(&block_interf_srcu);
+}
+EXPORT_SYMBOL(block_interf_srcu_read_lock);
+
+void block_interf_srcu_read_unlock(int idx)
+{
+	srcu_read_unlock(&block_interf_srcu, idx);
+}
+EXPORT_SYMBOL(block_interf_srcu_read_unlock);
+
+void block_interf_assert_held(void)
+{
+	WARN_ON_ONCE(!srcu_read_lock_held(&block_interf_srcu));
+}
+EXPORT_SYMBOL(block_interf_assert_held);
+
+static ssize_t
+block_interf_cpumask_read(struct file *filp, char __user *ubuf,
+		     size_t count, loff_t *ppos)
+{
+	char *mask_str;
+	int len;
+
+	len = snprintf(NULL, 0, "%*pb\n",
+		       cpumask_pr_args(block_interf_cpumask)) + 1;
+	mask_str = kmalloc(len, GFP_KERNEL);
+	if (!mask_str)
+		return -ENOMEM;
+
+	len = snprintf(mask_str, len, "%*pb\n",
+		       cpumask_pr_args(block_interf_cpumask));
+	if (len >= count) {
+		count = -EINVAL;
+		goto out_err;
+	}
+	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
+
+out_err:
+	kfree(mask_str);
+
+	return count;
+}
+
+static ssize_t
+block_interf_cpumask_write(struct file *filp, const char __user *ubuf,
+			   size_t count, loff_t *ppos)
+{
+	cpumask_var_t block_interf_cpumask_new;
+	int err;
+
+	if (!zalloc_cpumask_var(&block_interf_cpumask_new, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpumask_parse_user(ubuf, count, block_interf_cpumask_new);
+	if (err)
+		goto err_free;
+
+	cpumask_copy(block_interf_cpumask, block_interf_cpumask_new);
+	synchronize_srcu(&block_interf_srcu);
+	free_cpumask_var(block_interf_cpumask_new);
+
+	return count;
+
+err_free:
+	free_cpumask_var(block_interf_cpumask_new);
+
+	return err;
+}
+
+static const struct file_operations block_interf_cpumask_fops = {
+	.read		= block_interf_cpumask_read,
+	.write		= block_interf_cpumask_write,
+};
+
+static int __init block_interf_cpumask_init(void)
+{
+	int ret;
+
+	ret = init_srcu_struct(&block_interf_srcu);
+	if (ret)
+		return ret;
+
+	if (!zalloc_cpumask_var(&block_interf_cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	debugfs_create_file_unsafe("block_interf_cpumask", 0644, NULL, NULL,
+				   &block_interf_cpumask_fops);
+
+	block_interf_cpumask_active = true;
+	return 0;
+}
+
+late_initcall(block_interf_cpumask_init);
+



