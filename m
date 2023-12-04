Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F91803745
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbjLDOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbjLDOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:44:20 -0500
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E3CF2;
        Mon,  4 Dec 2023 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:To:From;
        bh=ZaSnRCjQVsFh/5IUUgdWADV17OSBEY/CgjhDDgFObz8=; b=nDQY+4fi2L0ck3OHDozZyiL0JD
        n8xf0Vpd9+V76YFwjaxSW1URU0ih38B25OUKuS6HKjIgjf/VV+0or0zhfoTcW0WAR9NghEMkIuZae
        rJCmrCFe/8tMm9oOCH+SY0ix6bLCwVAOwBFEPG2aaRp2rdO3bmM/NWipGlP3v1AN+CHs=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAABD-0003gP-Tq; Mon, 04 Dec 2023 14:44:15 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAABD-00088g-Ki; Mon, 04 Dec 2023 14:44:15 +0000
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
Subject: [PATCH v10 09/19] KVM: xen: separate initialization of shared_info cache and content
Date:   Mon,  4 Dec 2023 14:43:24 +0000
Message-Id: <20231204144334.910-10-paul@xen.org>
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

A subsequent patch will allow shared_info to be initialized using either a
GPA or a user-space (i.e. VMM) HVA. To make that patch cleaner, separate
the initialization of the shared_info content from the activation of the
pfncache.

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
 arch/x86/kvm/xen.c | 55 +++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index e1967f970f54..9351b32cfcba 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -34,41 +34,32 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
-static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
+static int kvm_xen_shared_info_init(struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct pvclock_wall_clock *wc;
-	gpa_t gpa = gfn_to_gpa(gfn);
 	u32 *wc_sec_hi;
 	u32 wc_version;
 	u64 wall_nsec;
 	int ret = 0;
 	int idx = srcu_read_lock(&kvm->srcu);
 
-	if (gfn == KVM_XEN_INVALID_GFN) {
-		kvm_gpc_deactivate(gpc);
-		goto out;
-	}
+	read_lock_irq(&gpc->lock);
+	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
+		read_unlock_irq(&gpc->lock);
 
-	do {
-		ret = kvm_gpc_activate(gpc, gpa, PAGE_SIZE);
+		ret = kvm_gpc_refresh(gpc, PAGE_SIZE);
 		if (ret)
 			goto out;
 
-		/*
-		 * This code mirrors kvm_write_wall_clock() except that it writes
-		 * directly through the pfn cache and doesn't mark the page dirty.
-		 */
-		wall_nsec = kvm_get_wall_clock_epoch(kvm);
-
-		/* It could be invalid again already, so we need to check */
 		read_lock_irq(&gpc->lock);
+	}
 
-		if (gpc->valid)
-			break;
-
-		read_unlock_irq(&gpc->lock);
-	} while (1);
+	/*
+	 * This code mirrors kvm_write_wall_clock() except that it writes
+	 * directly through the pfn cache and doesn't mark the page dirty.
+	 */
+	wall_nsec = ktime_get_real_ns() - get_kvmclock_ns(kvm);
 
 	/* Paranoia checks on the 32-bit struct layout */
 	BUILD_BUG_ON(offsetof(struct compat_shared_info, wc) != 0x900);
@@ -639,12 +630,30 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		}
 		break;
 
-	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
+	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
+		int idx;
+
 		mutex_lock(&kvm->arch.xen.xen_lock);
-		r = kvm_xen_shared_info_init(kvm, data->u.shared_info.gfn);
+
+		idx = srcu_read_lock(&kvm->srcu);
+
+		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
+			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
+			r = 0;
+		} else {
+			r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
+					     gfn_to_gpa(data->u.shared_info.gfn),
+					     PAGE_SIZE);
+		}
+
+		srcu_read_unlock(&kvm->srcu, idx);
+
+		if (!r && kvm->arch.xen.shinfo_cache.active)
+			r = kvm_xen_shared_info_init(kvm);
+
 		mutex_unlock(&kvm->arch.xen.xen_lock);
 		break;
-
+	}
 	case KVM_XEN_ATTR_TYPE_UPCALL_VECTOR:
 		if (data->u.vector && data->u.vector < 0x10)
 			r = -EINVAL;
-- 
2.39.2

