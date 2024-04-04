Return-Path: <linux-kernel+bounces-131374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AE8986E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDB91F25A3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721C8664B;
	Thu,  4 Apr 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPlvPzsv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545B84FCC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232813; cv=none; b=U+KE8ho/sx7CnIorUZ/YHzxaqdGvkHEbnUaNTmNQwuHjDMvjeO9QmHaxiZWp59RIV3HLg7rw4SWouzwp7jOg0k4a1XcJZsc6X6IoHNGYg6TYpL+j1eYM0sjeFmJGjioS3OJ5XUii90LhSNE0gaYmKCbzN8GJLgfwHbCQVR5WPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232813; c=relaxed/simple;
	bh=3UZOWxvel2gxNTwrPzBwKutiH6HW6UJXahf+TYTu8Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+HfAQVM6SPvPgQ1NJo2zj+PrLv764Q5W58+8ZTyhMxQ+aQViSq4CVwK1ZNlE0b5Bj30ch3j9Ajp5vpLOqwe5VYMjlTp5GpfFdzF19OsXvf7YkQYI04JkRjO4NPxI2sYN28bwHshJ2fkNJMXINFCNLgYHjqumlzgjnTZzkIxF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPlvPzsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712232810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IyuuUxiGnoaxGNnwqcPQ8aX2JAcsb4DAgIo+w+cUTM=;
	b=RPlvPzsvGCSa+tNgdP6R+2hMTDUQ+wrdvNaJb3o8uG9d6BRRemVSnQfd0CFZKf4YUg2L4s
	8yJmTYG0e+Re0hR5AtKutY/vC8RmlXkK7uKm9jOsyjSudLM6GR6ER7xoFzFq4HKlqLs97W
	0zYDc9yMbIDfiYO8wbXXBWgCVhsJl2s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-J2GjL78mPd-aU5DuVvTYUg-1; Thu,
 04 Apr 2024 08:13:29 -0400
X-MC-Unique: J2GjL78mPd-aU5DuVvTYUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A5A91C05AC8;
	Thu,  4 Apr 2024 12:13:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D59DE2024517;
	Thu,  4 Apr 2024 12:13:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	isaku.yamahata@intel.com,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v5 03/17] KVM: x86: use u64_to_user_ptr()
Date: Thu,  4 Apr 2024 08:13:13 -0400
Message-ID: <20240404121327.3107131-4-pbonzini@redhat.com>
In-Reply-To: <20240404121327.3107131-1-pbonzini@redhat.com>
References: <20240404121327.3107131-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

There is no danger to the kernel if 32-bit userspace provides a 64-bit
value that has the high bits set, but for whatever reason happens to
resolve to an address that has something mapped there.  KVM uses the
checked version of get_user() and put_user(), so any faults are caught
properly.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47d9f03b7778..3d2029402513 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4842,25 +4842,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	return r;
 }
 
-static inline void __user *kvm_get_attr_addr(struct kvm_device_attr *attr)
-{
-	void __user *uaddr = (void __user*)(unsigned long)attr->addr;
-
-	if ((u64)(unsigned long)uaddr != attr->addr)
-		return ERR_PTR_USR(-EFAULT);
-	return uaddr;
-}
-
 static int kvm_x86_dev_get_attr(struct kvm_device_attr *attr)
 {
-	u64 __user *uaddr = kvm_get_attr_addr(attr);
+	u64 __user *uaddr = u64_to_user_ptr(attr->addr);
 
 	if (attr->group)
 		return -ENXIO;
 
-	if (IS_ERR(uaddr))
-		return PTR_ERR(uaddr);
-
 	switch (attr->attr) {
 	case KVM_X86_XCOMP_GUEST_SUPP:
 		if (put_user(kvm_caps.supported_xcr0, uaddr))
@@ -5712,12 +5700,9 @@ static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vcpu,
 static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
 				 struct kvm_device_attr *attr)
 {
-	u64 __user *uaddr = kvm_get_attr_addr(attr);
+	u64 __user *uaddr = u64_to_user_ptr(attr->addr);
 	int r;
 
-	if (IS_ERR(uaddr))
-		return PTR_ERR(uaddr);
-
 	switch (attr->attr) {
 	case KVM_VCPU_TSC_OFFSET:
 		r = -EFAULT;
@@ -5735,13 +5720,10 @@ static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
 static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
 				 struct kvm_device_attr *attr)
 {
-	u64 __user *uaddr = kvm_get_attr_addr(attr);
+	u64 __user *uaddr = u64_to_user_ptr(attr->addr);
 	struct kvm *kvm = vcpu->kvm;
 	int r;
 
-	if (IS_ERR(uaddr))
-		return PTR_ERR(uaddr);
-
 	switch (attr->attr) {
 	case KVM_VCPU_TSC_OFFSET: {
 		u64 offset, tsc, ns;
-- 
2.43.0



