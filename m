Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D59D80380F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjLDPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjLDPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:00:26 -0500
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FAFB9;
        Mon,  4 Dec 2023 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:To:From;
        bh=Xrs5wM6gBETIHeYh3Xm5diocfhQBioljk8lQV33tdj0=; b=aAdU8jXlc+qOGuZ35FRaNzkHxt
        8NOpVXOoEM5QqGRzNfJwfz4qdyYvqM3hWnG3IT51xhRREY0h2EZPgc2Ncn1ziUlWV+yNHbJmG2qmc
        8OQ1u4lMWQmFMGUYjFu0q4FRtsjByD8QUZt3BOHxor7O0hUgDIhUCyb0aGhXrWSktFto=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAAQk-00043f-PF; Mon, 04 Dec 2023 15:00:18 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAABG-00088g-2j; Mon, 04 Dec 2023 14:44:18 +0000
From:   Paul Durrant <paul@xen.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v10 10/19] KVM: xen: (re-)initialize shared_info if guest (32/64-bit) mode is set
Date:   Mon,  4 Dec 2023 14:43:25 +0000
Message-Id: <20231204144334.910-11-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204144334.910-1-paul@xen.org>
References: <20231204144334.910-1-paul@xen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

If the shared_info PFN cache has already been initialized then the content
of the shared_info page needs to be (re-)initialized whenever the guest
mode is (re)set.
Setting the guest mode is either done explicitly by the VMM via the
KVM_XEN_ATTR_TYPE_LONG_MODE attribute, or implicitly when the guest writes
the MSR to set up the hypercall page.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org

v10:
 - New in this version.
---
 arch/x86/kvm/xen.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 9351b32cfcba..3aa452a71890 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -623,10 +623,20 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		if (!IS_ENABLED(CONFIG_64BIT) && data->u.long_mode) {
 			r = -EINVAL;
 		} else {
+			bool lm = !!data->u.long_mode;
+
 			mutex_lock(&kvm->arch.xen.xen_lock);
-			kvm->arch.xen.long_mode = !!data->u.long_mode;
+			if (kvm->arch.xen.long_mode != lm) {
+				kvm->arch.xen.long_mode = lm;
+
+				/*
+				 * Re-initialize shared_info to put the wallclock in the
+				 * correct place.
+				 */
+				r = kvm->arch.xen.shinfo_cache.active ?
+					kvm_xen_shared_info_init(kvm) : 0;
+			}
 			mutex_unlock(&kvm->arch.xen.xen_lock);
-			r = 0;
 		}
 		break;
 
@@ -648,9 +658,6 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 
 		srcu_read_unlock(&kvm->srcu, idx);
 
-		if (!r && kvm->arch.xen.shinfo_cache.active)
-			r = kvm_xen_shared_info_init(kvm);
-
 		mutex_unlock(&kvm->arch.xen.xen_lock);
 		break;
 	}
@@ -1101,9 +1108,24 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 	u32 page_num = data & ~PAGE_MASK;
 	u64 page_addr = data & PAGE_MASK;
 	bool lm = is_long_mode(vcpu);
+	int r = 0;
+
+	mutex_lock(&kvm->arch.xen.xen_lock);
+	if (kvm->arch.xen.long_mode != lm) {
+		kvm->arch.xen.long_mode = lm;
+
+		/*
+		 * Re-initialize shared_info to put the wallclock in the
+		 * correct place.
+		 */
+		if (kvm->arch.xen.shinfo_cache.active &&
+		    kvm_xen_shared_info_init(kvm))
+			r = 1;
+	}
+	mutex_unlock(&kvm->arch.xen.xen_lock);
 
-	/* Latch long_mode for shared_info pages etc. */
-	vcpu->kvm->arch.xen.long_mode = lm;
+	if (r)
+		return r;
 
 	/*
 	 * If Xen hypercall intercept is enabled, fill the hypercall
-- 
2.39.2

