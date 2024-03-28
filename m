Return-Path: <linux-kernel+bounces-123354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E6890708
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070A21C273AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F512BF39;
	Thu, 28 Mar 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRird4n+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735D80617
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646408; cv=none; b=gfuskfhoph6n7rTKhuOQNou9g+zShcwlkFs1c1jOCbGXYhabg6vmGROozoRfdTR7BwgHWiW4Dg7F+zE/Ngd/1l4NRSXFRv1f9IflM1pRUfjjvUv+vxdu/ivERXzds/ic+4o8+gCi8UgiAMQFUwLX3RW6bp7mQzk59UgPaFNCKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646408; c=relaxed/simple;
	bh=5nG12px40b95OiupwSpL661ZIzoB74o9DKh2Yxu7VGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqTEieWWNDM/cI9ZptCZYtJD9wJQzSfvUfTkMpf8etkbrHwq6UDQHe5M8hs227GAn63gZCYoEaopY9O2lx3iWs1NY0V9QJueYNolSVrM9/Z/bWwn+M1faHcmeiApyU1qRNih0QrIZUTd4jF0TzTY3lqo8U9BTNFdqrUjZqCfeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRird4n+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711646405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlDC3S558v4nqZXrURYnNQqnqNZ8k/Xoba+HwgD1low=;
	b=hRird4n+7ckY0G/VqrihRYWLR0t8V155SeHXNS/M09Dv5DeLsR8Fph+tF0jiFyt8e81ly8
	VWDHMsfLDf9RXXmuj8d5fN0xQCqkxGnWLond1qk9yG64tGSPce+SHAUbiO4p42rWaR5ZDu
	tvTnOe2vuGlMAyl60rg7xhbj+nVkRkc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-lDR0D0wCOmumcCLX4nG-eQ-1; Thu, 28 Mar 2024 13:20:04 -0400
X-MC-Unique: lDR0D0wCOmumcCLX4nG-eQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6987005a2fbso6544036d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711646404; x=1712251204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlDC3S558v4nqZXrURYnNQqnqNZ8k/Xoba+HwgD1low=;
        b=cGMfZIhSXJbs2HgOCNmjcsCXWLVW7Z8bir8W60ZryiHbfH7LJyLsgTPTYrvX1E4YZV
         MFnv3tqp9Ga2fLIiM7P0WWEXr6lqIcQFc7rcFbX1Vi13jflXQiQQoOTaTmstAqI71ADN
         zckomKGU2e1MNxnYmrEFVDJXYegvSM4flONQRMfwjXcCkzrjcplZeKvM/ueXqxqnOpXC
         HNoLkWWE/gR0OlQUM2xkeIMXf7BX02YLZgImtweXgi6TQDzbbckuebJ1z2Th1/MXDMNJ
         5Xxmvcb1J5kKx4pPHiNM8xZ8NQw19D2jRzrHYI88DOY8ETy0m/ckT5t1yIBWfFfhHM/Y
         fBMg==
X-Forwarded-Encrypted: i=1; AJvYcCV8rd2WasMhaikeA7hTD1IdbuVjbq+OV45gaMOsyXnao6OoDyNBB3Lr/xuzkEhgLbVTi97fsMhA9v78YzzpsrkraQKeqNN7yO4rcpiI
X-Gm-Message-State: AOJu0YyTizTACZo4qeRLEKAlk1paG4hX7niDUpAwCUj8KhHi1GaTpXH4
	lUN5IVOO+2vRjkdUdU+OxheEDGGYOVBaPtwRODaq0rqoRzgaZDYP02LHeugAe5iu156n4lGFzEK
	42h3h+izfza7kBdFF7BfdC2mQCT3rvfXxhjLq9bjKOKxJL6jFgie4+mJfLtTNVA==
X-Received: by 2002:a05:6214:500a:b0:698:7ab0:eb15 with SMTP id jo10-20020a056214500a00b006987ab0eb15mr2054221qvb.46.1711646403946;
        Thu, 28 Mar 2024 10:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmeHJjJWBC27/ap5AWRtSmt7CBRCbfvjktUlnWlqC/t2lVabfEtbBhByfRUEWDgZkb7PIurw==
X-Received: by 2002:a05:6214:500a:b0:698:7ab0:eb15 with SMTP id jo10-20020a056214500a00b006987ab0eb15mr2054204qvb.46.1711646403682;
        Thu, 28 Mar 2024 10:20:03 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:d7ed:4b57:3fcd:d5e6:a613])
        by smtp.gmail.com with ESMTPSA id m13-20020ad45dcd000000b00696944e3ce6sm809078qvh.74.2024.03.28.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:20:03 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [RFC PATCH v1 1/2] kvm: Implement guest_exit_last_time()
Date: Thu, 28 Mar 2024 14:19:46 -0300
Message-ID: <20240328171949.743211-2-leobras@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328171949.743211-1-leobras@redhat.com>
References: <20240328171949.743211-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep track of the last time a cpu ran guest_exit(), and provide a helper to
make this information available to other files.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 include/linux/kvm_host.h | 13 +++++++++++++
 virt/kvm/kvm_main.c      |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 48f31dcd318a..be90d83d631a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -470,31 +470,44 @@ static __always_inline void guest_state_enter_irqoff(void)
 {
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
 	guest_context_enter_irqoff();
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+DECLARE_PER_CPU(unsigned long, kvm_last_guest_exit);
+
+/*
+ * Returns time (jiffies) for the last guest exit in current cpu
+ */
+static inline unsigned long guest_exit_last_time(void)
+{
+	return this_cpu_read(kvm_last_guest_exit);
+}
+
 /*
  * Exit guest context and exit an RCU extended quiescent state.
  *
  * Between guest_context_enter_irqoff() and guest_context_exit_irqoff() it is
  * unsafe to use any code which may directly or indirectly use RCU, tracing
  * (including IRQ flag tracing), or lockdep. All code in this period must be
  * non-instrumentable.
  */
 static __always_inline void guest_context_exit_irqoff(void)
 {
 	context_tracking_guest_exit();
+
+	/* Keeps track of last guest exit */
+	this_cpu_write(kvm_last_guest_exit, jiffies);
 }
 
 /*
  * Stop accounting time towards a guest.
  * Must be called after exiting guest context.
  */
 static __always_inline void guest_timing_exit_irqoff(void)
 {
 	instrumentation_begin();
 	/* Flush the guest cputime we spent on the guest */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fb49c2a60200..732b1ab43ac9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -103,20 +103,23 @@ EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);
  */
 
 DEFINE_MUTEX(kvm_lock);
 LIST_HEAD(vm_list);
 
 static struct kmem_cache *kvm_vcpu_cache;
 
 static __read_mostly struct preempt_ops kvm_preempt_ops;
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
 
+DEFINE_PER_CPU(unsigned long, kvm_last_guest_exit);
+EXPORT_SYMBOL_GPL(kvm_last_guest_exit);
+
 struct dentry *kvm_debugfs_dir;
 EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
 
 static const struct file_operations stat_fops_per_vm;
 
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
 static long kvm_vcpu_compat_ioctl(struct file *file, unsigned int ioctl,
 				  unsigned long arg);
-- 
2.44.0


