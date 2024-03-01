Return-Path: <linux-kernel+bounces-88243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8E86DF11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085C61F25794
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03246BB44;
	Fri,  1 Mar 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt7OxJe4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3F6BB23
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288060; cv=none; b=GeJ2JoF6IJk5J+6jhcAHECdmSecdPADg6FD5wYw2V3it/CL6Kah7mRgJVRK4TkU44WLkfk/5f+Ou4C7570k6jwZ3mnSJeZoqMhlVGSuf2fK6mL6/gDGTNtmRetpm6u/cLUA391pjg1qQPoXYI71PF1v5HVzdSx9ldiU11mJW15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288060; c=relaxed/simple;
	bh=uWxgVAOGbOSnxDWiId7krxLynUZio8/ykxEd9RkbEQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0yUzbPTuSCxJtSvjmrleyXFzd/vyBTYvZpU2WxcNL/eC9BuoJkQmWtV1KHCgiKFT5dc271ue7bPhRjkg0GS/QI5ln72YaIlWmCPNdMxtr7wqywGhwLyZW0NEL+NiGZNfsyWCcmcbAiY8zUYr/btaq1mnX1/7kH1txY67gGy8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt7OxJe4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709288057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQfnpdN6UNMUhl10QWdlY0XPgUMsy+RQDz3+hBDJ3Y0=;
	b=Yt7OxJe4BEgxKF3604ciNL18KJNVNQwvLGiraoco6KcKOlckEgGiq2PcKO7meP+BeQkMeh
	SR8mJTZMzX1Ay7YsSyjZL02dgpvz5JCmCqxVVWDWR3LexJNaOFmM2BBix/3s2gYL+Sayci
	1NzmwFsohj7u6SIPYQzzy3fxpsHUFEs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534--BHjQmXgMBqh-ay5ggpBlw-1; Fri,
 01 Mar 2024 05:14:14 -0500
X-MC-Unique: -BHjQmXgMBqh-ay5ggpBlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDC638062C0;
	Fri,  1 Mar 2024 10:14:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DD32763A69;
	Fri,  1 Mar 2024 10:14:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AE62C180148E; Fri,  1 Mar 2024 11:14:10 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: kvm@vger.kernel.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 1/3] kvm: wire up KVM_CAP_VM_GPA_BITS for x86
Date: Fri,  1 Mar 2024 11:14:07 +0100
Message-ID: <20240301101410.356007-2-kraxel@redhat.com>
In-Reply-To: <20240301101410.356007-1-kraxel@redhat.com>
References: <20240301101410.356007-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add new guest_phys_bits field to kvm_caps, return the value to
userspace when asked for KVM_CAP_VM_GPA_BITS capability.

Initialize guest_phys_bits with boot_cpu_data.x86_phys_bits.
Vendor modules (i.e. vmx and svm) can adjust this field in case
additional restrictions apply, for example in case EPT has no
support for 5-level paging.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/kvm/x86.h | 2 ++
 arch/x86/kvm/x86.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 2f7e19166658..e03aec3527f8 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -24,6 +24,8 @@ struct kvm_caps {
 	bool has_bus_lock_exit;
 	/* notify VM exit supported? */
 	bool has_notify_vmexit;
+	/* usable guest phys bits */
+	u32  guest_phys_bits;
 
 	u64 supported_mce_cap;
 	u64 supported_xcr0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 48a61d283406..e270b9b708d1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4784,6 +4784,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (kvm_is_vm_type_supported(KVM_X86_SW_PROTECTED_VM))
 			r |= BIT(KVM_X86_SW_PROTECTED_VM);
 		break;
+	case KVM_CAP_VM_GPA_BITS:
+		r = kvm_caps.guest_phys_bits;
+		break;
 	default:
 		break;
 	}
@@ -9706,6 +9709,8 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, host_arch_capabilities);
 
+	kvm_caps.guest_phys_bits = boot_cpu_data.x86_phys_bits;
+
 	r = ops->hardware_setup();
 	if (r != 0)
 		goto out_mmu_exit;
-- 
2.44.0


