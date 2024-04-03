Return-Path: <linux-kernel+bounces-129903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85498971DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1611F1C2705C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4D14900B;
	Wed,  3 Apr 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="GnE3S7hQ"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0A148FFA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152899; cv=none; b=fmcyS0RGlgXSx51qMTPkb3fFumGmvF1892bQibCA4uS2TeYhDXMC15lQMpCy3dWJiVr6PI3pBIhDvhka6XteIk+eRb57ZaWN2A3lVIRxTsD7b087pKXwwN78ZBvAZD6XnYn/o4fdo0SaRkTFXILjvQKjKQr22RzUSk3FZY31zps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152899; c=relaxed/simple;
	bh=FDYnvGX3jppgjt0ms5JcBF+Jc7zw8R2BAEn2b+ABJPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5e3GzDCMt/d6TtZlqzFFDo85txyVJO6Lk4b0FJk9XzMmzoxO01ksmHDsHDU7DeBLeOLjxUE/4SnZxMluxn2cU2zp7ncyg+a+1Gk5JSe06Bn/IYlV3/MAoFdj6ooznTlwqACuhRNWldN2tq/bwTzDbVUf5TDHC1XZwYn3WtVmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=GnE3S7hQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6991fb8f31dso8922116d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1712152896; x=1712757696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAl5yGyZgzeKDHOgPfwgCPdv3gtVirZpx2WY36IzrFA=;
        b=GnE3S7hQtlBzz5FDFR9gGbJi5gW9SwyzYiv5Lg6Q1W42Y+3WljBLh8H/viIHOSpZ5l
         mDtivDKn/qfjy5Nfes5lqHs8B6ZSdovK1C7WqAOxe9PWOUhtdDmaN60MohYRrYZKqovC
         xMurIZIP5Hx0a3gi1yIJbQaOCkHha8SO7T1UXR/e50/xKFS0aFnjhDQKezyWPyE6+pJR
         cAwFj/QTrvFtCz34A5TfhcSpUZzQrZAWvviCr4vkw2Lf+tvu0ncbu3Kyowm+B59NCBKq
         FrUcar++MI6oumNg1ElnfIBMhGQbZPXDKKb8yyPezo5zk/4KTBRQd3iBdSxqneOeUGul
         I3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152896; x=1712757696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAl5yGyZgzeKDHOgPfwgCPdv3gtVirZpx2WY36IzrFA=;
        b=MN3V//43/NHxXo1BCxbI65iL7Lwf0DprvkBBf6V5U9n96GJcWD0SMGus/GBuoyp/yB
         F4jqXnYfqgZZdblzVaOyDtP48aT9kK1rdr0LUGRyGtq3SsuwCkSL0XwbN8PU8tPmuFDk
         ehh9lLQQcaXEfQgEmZvgBKKpllX0AY7l757m/Xdh4i3dd2ZPYnA7zg33zdfJWNEHT19F
         PFLvaTKp1U+prYAU56igdUJ+pBUvvCZAYGzArlH2s2llYeZ+lCi0fAjVdnMe9BL6IoSm
         fQJLFdpKlB0XEtYgTr8n38udCT5WbWzyG+zDvBR7e2JP5GhuKCtZZldHOwKi71cpgbwL
         xrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzPe5SAfA2arHHgedqaJKaSlFTp/W94fCb9BDNjUcuO4P6shQwmlwVWnGtuRAd6Q49b9mlORzOcEBih5Z5OhrDeWfMpk90x6rTEB78
X-Gm-Message-State: AOJu0Yy3+V0rGCh4/mPhzGAxKjZvp9XU5ocWoIpXq10ngObshAIsiPdC
	eXGcHnPS/OY6wRibXaO11Vw0kxeNFi6yVGwbRDdT8UlTY01+9yJMOZj8JzMzeIE=
X-Google-Smtp-Source: AGHT+IHvc+Z8rAGYdV18GoHSVhAuEJhixIxtB7Sprh49Rl10nkC3+gtuPFpYpMsM5sh5ZkIdR/76QA==
X-Received: by 2002:a0c:ed4e:0:b0:699:1b6b:82ae with SMTP id v14-20020a0ced4e000000b006991b6b82aemr4264059qvq.17.1712152896489;
        Wed, 03 Apr 2024 07:01:36 -0700 (PDT)
Received: from vinbuntup3.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id gf12-20020a056214250c00b00698d06df322sm5945706qvb.122.2024.04.03.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:01:26 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Ben Segall <bsegall@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	himadrics@inria.fr,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH v2 3/5] kvm: interface for managing pvsched driver for guest VMs
Date: Wed,  3 Apr 2024 10:01:14 -0400
Message-Id: <20240403140116.3002809-4-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240403140116.3002809-1-vineeth@bitbyteword.org>
References: <20240403140116.3002809-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ioctl for assigning and unassigning pvsched driver for a
guest. VMMs would need to adopt this ioctls for supporting the feature.
Also add a temporary debugfs interface for managing this.

Ideally, the hypervisor would be able to determine the pvsched driver
based on the information received from the guest. Guest VMs with the
feature enabled would request hypervisor to select a pvsched driver.
ioctl api is an override mechanism to give more control to the admin.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/uapi/linux/kvm.h |   6 ++
 virt/kvm/kvm_main.c      | 117 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c3308536482b..4b29bdad4188 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -2227,4 +2227,10 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+struct kvm_pvsched_ops {
+	__u8 ops_name[32]; /* PVSCHED_NAME_MAX */
+};
+
+#define KVM_GET_PVSCHED_OPS		_IOR(KVMIO, 0xe4, struct kvm_pvsched_ops)
+#define KVM_REPLACE_PVSCHED_OPS		_IOWR(KVMIO, 0xe5, struct kvm_pvsched_ops)
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0546814e4db7..b3d9c362d2e3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1223,6 +1223,79 @@ static void kvm_destroy_vm_debugfs(struct kvm *kvm)
 	}
 }
 
+#ifdef CONFIG_PARAVIRT_SCHED_KVM
+static int pvsched_vcpu_ops_show(struct seq_file *m, void *data)
+{
+	char ops_name[PVSCHED_NAME_MAX];
+	struct pvsched_vcpu_ops *ops;
+	struct kvm *kvm = (struct kvm *) m->private;
+
+	rcu_read_lock();
+	ops = rcu_dereference(kvm->pvsched_ops);
+	if (ops)
+		strncpy(ops_name, ops->name, PVSCHED_NAME_MAX);
+	rcu_read_unlock();
+
+	seq_printf(m, "%s\n", ops_name);
+
+	return 0;
+}
+
+static ssize_t
+pvsched_vcpu_ops_write(struct file *filp, const char __user *ubuf,
+		size_t cnt, loff_t *ppos)
+{
+	int ret;
+	char *cmp;
+	char buf[PVSCHED_NAME_MAX];
+	struct inode *inode;
+	struct kvm *kvm;
+
+	if (cnt > PVSCHED_NAME_MAX)
+		return -EINVAL;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	cmp = strstrip(buf);
+
+	inode = file_inode(filp);
+	inode_lock(inode);
+	kvm = (struct kvm *)inode->i_private;
+	ret = kvm_replace_pvsched_ops(kvm, cmp);
+	inode_unlock(inode);
+
+	if (ret)
+		return ret;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int pvsched_vcpu_ops_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, pvsched_vcpu_ops_show, inode->i_private);
+}
+
+static const struct file_operations pvsched_vcpu_ops_fops = {
+	.open		= pvsched_vcpu_ops_open,
+	.write		= pvsched_vcpu_ops_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void kvm_create_vm_pvsched_debugfs(struct kvm *kvm)
+{
+	debugfs_create_file("pvsched_vcpu_ops", 0644, kvm->debugfs_dentry, kvm,
+			    &pvsched_vcpu_ops_fops);
+}
+#else
+static void kvm_create_vm_pvsched_debugfs(struct kvm *kvm)
+{
+}
+#endif
+
 static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 {
 	static DEFINE_MUTEX(kvm_debugfs_lock);
@@ -1288,6 +1361,8 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 				    &stat_fops_per_vm);
 	}
 
+	kvm_create_vm_pvsched_debugfs(kvm);
+
 	ret = kvm_arch_create_vm_debugfs(kvm);
 	if (ret)
 		goto out_err;
@@ -5474,6 +5549,48 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_gmem_create(kvm, &guest_memfd);
 		break;
 	}
+#endif
+#ifdef CONFIG_PARAVIRT_SCHED_KVM
+	case KVM_REPLACE_PVSCHED_OPS:
+		struct pvsched_vcpu_ops *ops;
+		struct kvm_pvsched_ops in_ops, out_ops;
+
+		r = -EFAULT;
+		if (copy_from_user(&in_ops, argp, sizeof(in_ops)))
+			goto out;
+
+		out_ops.ops_name[0] = 0;
+
+		rcu_read_lock();
+		ops = rcu_dereference(kvm->pvsched_ops);
+		if (ops)
+			strncpy(out_ops.ops_name, ops->name, PVSCHED_NAME_MAX);
+		rcu_read_unlock();
+
+		r = kvm_replace_pvsched_ops(kvm, (char *)in_ops.ops_name);
+		if (r)
+			goto out;
+
+		r = -EFAULT;
+		if (copy_to_user(argp, &out_ops, sizeof(out_ops)))
+			goto out;
+
+		r = 0;
+		break;
+	case KVM_GET_PVSCHED_OPS:
+		out_ops.ops_name[0] = 0;
+		rcu_read_lock();
+		ops = rcu_dereference(kvm->pvsched_ops);
+		if (ops)
+			strncpy(out_ops.ops_name, ops->name, PVSCHED_NAME_MAX);
+		rcu_read_unlock();
+
+		r = -EFAULT;
+		if (copy_to_user(argp, &out_ops, sizeof(out_ops)))
+			goto out;
+
+		r = 0;
+		break;
 #endif
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
-- 
2.40.1


