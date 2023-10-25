Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C07D70B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJYPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0412A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698247451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UY00r4KJgutxwf++YFP2KIoZ7cjz3Yt618EIRpz4fA=;
        b=RiwrYz2CBTuwFfHJRJUmt1xsx/CW6gfSUKyfnSBhWscQ/4wjDXcflEeHCge1o9ynzPsVzP
        dAIkk8pbwU9gdgCPTfR9m9pAkQ3RUhfCJK8FpzzfMgFgAYZxJXX+mxKVIdHo9XgjgcUzc/
        K135QiNtBLbu0zZCToRP0HdkOe5Ee3Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-b95o5wwuO0ifj5N-nPufZg-1; Wed, 25 Oct 2023 11:24:09 -0400
X-MC-Unique: b95o5wwuO0ifj5N-nPufZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 564A0802891;
        Wed, 25 Oct 2023 15:24:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69EB12166B26;
        Wed, 25 Oct 2023 15:24:08 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] KVM: x86: xen: Remove unneeded xen context from struct kvm_arch when !CONFIG_KVM_XEN
Date:   Wed, 25 Oct 2023 17:23:53 +0200
Message-ID: <20231025152406.1879274-2-vkuznets@redhat.com>
In-Reply-To: <20231025152406.1879274-1-vkuznets@redhat.com>
References: <20231025152406.1879274-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saving a few bytes of memory per KVM VM is certainly great but what's more
important is the ability to see where the code accesses Xen emulation
context while CONFIG_KVM_XEN is not enabled. Currently, kvm_cpu_get_extint()
is the only such place and it is harmless: kvm_xen_has_interrupt() always
returns '0' when !CONFIG_KVM_XEN.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 5 +++++
 arch/x86/kvm/irq.c              | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 394e1a31c02c..d107516b4591 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1136,6 +1136,7 @@ struct msr_bitmap_range {
 	unsigned long *bitmap;
 };
 
+#ifdef CONFIG_KVM_XEN
 /* Xen emulation context */
 struct kvm_xen {
 	struct mutex xen_lock;
@@ -1147,6 +1148,7 @@ struct kvm_xen {
 	struct idr evtchn_ports;
 	unsigned long poll_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 };
+#endif
 
 enum kvm_irqchip_mode {
 	KVM_IRQCHIP_NONE,
@@ -1349,7 +1351,10 @@ struct kvm_arch {
 	struct hlist_head mask_notifier_list;
 
 	struct kvm_hv hyperv;
+
+#ifdef CONFIG_KVM_XEN
 	struct kvm_xen xen;
+#endif
 
 	bool backwards_tsc_observed;
 	bool boot_vcpu_runs_old_kvmclock;
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index b2c397dd2bc6..ad9ca8a60144 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -118,8 +118,10 @@ static int kvm_cpu_get_extint(struct kvm_vcpu *v)
 	if (!lapic_in_kernel(v))
 		return v->arch.interrupt.nr;
 
+#ifdef CONFIG_KVM_XEN
 	if (kvm_xen_has_interrupt(v))
 		return v->kvm->arch.xen.upcall_vector;
+#endif
 
 	if (irqchip_split(v->kvm)) {
 		int vector = v->arch.pending_external_vector;
-- 
2.41.0

