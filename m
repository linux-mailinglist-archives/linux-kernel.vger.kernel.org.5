Return-Path: <linux-kernel+bounces-82187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B786806C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975991C23E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB95132495;
	Mon, 26 Feb 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GccLdLsM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FB12FB3F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974235; cv=none; b=SmZMtCl3l7+Saf1nPAf8H5yWC7QmprHNhdXsymcEzXoblNpxL6QfjQfL8K400nXU9W17UAkll2CtHkwSZCD9o1544HFZFgvwk5D3xYn8pDYVjw5cyM2nw9UIITz6ts1fvlCy+PnwkcJjFJPMiTHNbZNJF/rcaPRI4rIKDZlUfgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974235; c=relaxed/simple;
	bh=rCfHCHTYWoz4975u7BrV2pN/NoZkUaeFEvOlrnvEp1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgBM8JURpKtR1K9BIi4C5zFqSUxiK2GT5KzlI/zLQY5VUJTFoB/Ia7Vrd+GdfDNDuFABMVD0bsscGYqFRkOaxP8g7uaBka02UzpWnu+uAjL9Vwm8kGJwpkRUujwpw+9dBKSCos5xfiD1uADE3/NzyoeefYIsxzkcxATA5F4JBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GccLdLsM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708974231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GguoVTCj+D4yyYhhVzaIqifzwJU/fPpInE2qMCgiHY=;
	b=GccLdLsMGbwypJn7YSnQQGVPSxHR/FkhZ7d5Mt2upAke4fTPTJdxBifW0mY/JveGCXy02v
	gAeuea57wKx7dnl6E+Nmu2IG8Ha9jZwXtIvVW1tEruiSLvxnKhHPDQQShd6+W6F0H5fSoD
	ViYP57RmjWRXAhHWkoXSiwBnAD94EFk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-UC0NhyPPMJKzqNTTWv8S8A-1; Mon,
 26 Feb 2024 14:03:47 -0500
X-MC-Unique: UC0NhyPPMJKzqNTTWv8S8A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D924D38212D8;
	Mon, 26 Feb 2024 19:03:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0A5D492BC6;
	Mon, 26 Feb 2024 19:03:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com
Subject: [PATCH v3 06/15] KVM: introduce new vendor op for KVM_GET_DEVICE_ATTR
Date: Mon, 26 Feb 2024 14:03:35 -0500
Message-Id: <20240226190344.787149-7-pbonzini@redhat.com>
In-Reply-To: <20240226190344.787149-1-pbonzini@redhat.com>
References: <20240226190344.787149-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Allow vendor modules to provide their own attributes on /dev/kvm.
To avoid proliferation of vendor ops, implement KVM_HAS_DEVICE_ATTR
and KVM_GET_DEVICE_ATTR in terms of the same function.  You're not
supposed to use KVM_GET_DEVICE_ATTR to do complicated computations,
especially on /dev/kvm.

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/x86.c                 | 43 ++++++++++++++++++++----------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 378ed944b849..ac8b7614e79d 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -122,6 +122,7 @@ KVM_X86_OP(enter_smm)
 KVM_X86_OP(leave_smm)
 KVM_X86_OP(enable_smi_window)
 #endif
+KVM_X86_OP_OPTIONAL(dev_get_attr)
 KVM_X86_OP_OPTIONAL(mem_enc_ioctl)
 KVM_X86_OP_OPTIONAL(mem_enc_register_region)
 KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index aaf5a25ea7ed..651ce10cc152 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1770,6 +1770,7 @@ struct kvm_x86_ops {
 	void (*enable_smi_window)(struct kvm_vcpu *vcpu);
 #endif
 
+	int (*dev_get_attr)(u64 attr, u64 *val);
 	int (*mem_enc_ioctl)(struct kvm *kvm, void __user *argp);
 	int (*mem_enc_register_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*mem_enc_unregister_region)(struct kvm *kvm, struct kvm_enc_region *argp);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 14c969782d73..a12af5042d82 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4791,34 +4791,49 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	return r;
 }
 
-static int kvm_x86_dev_get_attr(struct kvm_device_attr *attr)
+static int __kvm_x86_dev_get_attr(struct kvm_device_attr *attr, u64 *val)
 {
-	u64 __user *uaddr = u64_to_user_ptr(attr->addr);
+	int r;
 
 	if (attr->group)
 		return -ENXIO;
 
 	switch (attr->attr) {
 	case KVM_X86_XCOMP_GUEST_SUPP:
-		if (put_user(kvm_caps.supported_xcr0, uaddr))
-			return -EFAULT;
-		return 0;
+		r = 0;
+		*val = kvm_caps.supported_xcr0;
+		break;
 	default:
-		return -ENXIO;
+		r = -ENXIO;
+		if (kvm_x86_ops.dev_get_attr)
+			r = static_call(kvm_x86_dev_get_attr)(attr->attr, val);
+		break;
 	}
+
+	return r;
+}
+
+static int kvm_x86_dev_get_attr(struct kvm_device_attr *attr)
+{
+	u64 __user *uaddr = u64_to_user_ptr(attr->addr);
+	int r;
+	u64 val;
+
+	r = __kvm_x86_dev_get_attr(attr, &val);
+	if (r < 0)
+		return r;
+
+	if (put_user(val, uaddr))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int kvm_x86_dev_has_attr(struct kvm_device_attr *attr)
 {
-	if (attr->group)
-		return -ENXIO;
+	u64 val;
 
-	switch (attr->attr) {
-	case KVM_X86_XCOMP_GUEST_SUPP:
-		return 0;
-	default:
-		return -ENXIO;
-	}
+	return __kvm_x86_dev_get_attr(attr, &val);
 }
 
 long kvm_arch_dev_ioctl(struct file *filp,
-- 
2.39.1



