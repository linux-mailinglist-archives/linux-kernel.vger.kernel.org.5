Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD68050A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376618AbjLEKix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjLEKif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2BE136
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701772679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjWk7hRVR22y9K4b1+8Cn8jc4sdz8J7ZvP+cd1cDwUg=;
        b=QEqH86bzBykOikYRjfSTNlgBvxlxp1xhQJwWZnhxM+vIbxB5YeSPgotJLYkLhQlulC0GSe
        NZLh9pgrML8FQ71P3456PuDFH9gD+wVvIjv5wlVuWUDppBej2dplY+ktZfAs2XoYuLb5dL
        +/iWQxu6D1n87LL9otB0sChoxMvAe6Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-CIAvvymCPImLRCsr7U8M6A-1; Tue, 05 Dec 2023 05:37:55 -0500
X-MC-Unique: CIAvvymCPImLRCsr7U8M6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0FD383B821;
        Tue,  5 Dec 2023 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 575A7C15968;
        Tue,  5 Dec 2023 10:37:52 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v4 2/4] KVM: x86: add more information to the kvm_entry tracepoint
Date:   Tue,  5 Dec 2023 12:37:43 +0200
Message-Id: <20231205103745.506724-3-mlevitsk@redhat.com>
In-Reply-To: <20231205103745.506724-1-mlevitsk@redhat.com>
References: <20231205103745.506724-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VMX/SVM specific interrupt injection info to vm entry tracepoint.
Also add a flag showing that immediate vm exit is set to happen after
the entry.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  5 ++++-
 arch/x86/kvm/svm/svm.c             | 17 +++++++++++++++++
 arch/x86/kvm/trace.h               | 15 +++++++++++++--
 arch/x86/kvm/vmx/vmx.c             | 12 ++++++++++++
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 3aeb7c669a0b09b..68fc0ef91ccbedc 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -99,6 +99,7 @@ KVM_X86_OP(get_l2_tsc_multiplier)
 KVM_X86_OP(write_tsc_offset)
 KVM_X86_OP(write_tsc_multiplier)
 KVM_X86_OP(get_exit_info)
+KVM_X86_OP(get_entry_info)
 KVM_X86_OP(check_intercept)
 KVM_X86_OP(handle_exit_irqoff)
 KVM_X86_OP(sched_in)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 044b4f9265c5427..97a5fecc16c8542 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1689,13 +1689,16 @@ struct kvm_x86_ops {
 	void (*write_tsc_multiplier)(struct kvm_vcpu *vcpu);
 
 	/*
-	 * Retrieve somewhat arbitrary exit information.  Intended to
+	 * Retrieve somewhat arbitrary exit/entry information.  Intended to
 	 * be used only from within tracepoints or error paths.
 	 */
 	void (*get_exit_info)(struct kvm_vcpu *vcpu, u32 *reason,
 			      u64 *info1, u64 *info2,
 			      u32 *exit_int_info, u32 *exit_int_info_err_code);
 
+	void (*get_entry_info)(struct kvm_vcpu *vcpu,
+				u32 *inj_info, u32 *inj_info_error_code);
+
 	int (*check_intercept)(struct kvm_vcpu *vcpu,
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d2c6ff9036009dd..ad27e07da767f99 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3492,6 +3492,22 @@ static void svm_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		*error_code = 0;
 }
 
+static void svm_get_entry_info(struct kvm_vcpu *vcpu,
+			u32 *inj_info,
+			u32 *inj_info_error_code)
+{
+	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
+
+	*inj_info = control->event_inj;
+
+	if ((*inj_info & SVM_EXITINTINFO_VALID) &&
+	    (*inj_info & SVM_EXITINTINFO_VALID_ERR))
+		*inj_info_error_code = control->event_inj_err;
+	else
+		*inj_info_error_code = 0;
+
+}
+
 static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4983,6 +4999,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.required_apicv_inhibits = AVIC_REQUIRED_APICV_INHIBITS,
 
 	.get_exit_info = svm_get_exit_info,
+	.get_entry_info = svm_get_entry_info,
 
 	.vcpu_after_set_cpuid = svm_vcpu_after_set_cpuid,
 
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 83843379813ee3e..28e8a63368cc021 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -21,14 +21,25 @@ TRACE_EVENT(kvm_entry,
 	TP_STRUCT__entry(
 		__field(	unsigned int,	vcpu_id		)
 		__field(	unsigned long,	rip		)
-	),
+		__field(	u32,		inj_info	)
+		__field(	u32,		inj_info_err	)
+		__field(	bool,		req_imm_exit	)
+		),
 
 	TP_fast_assign(
 		__entry->vcpu_id        = vcpu->vcpu_id;
 		__entry->rip		= kvm_rip_read(vcpu);
+		__entry->req_imm_exit	= vcpu->arch.req_immediate_exit;
+
+		static_call(kvm_x86_get_entry_info)(vcpu,
+					  &__entry->inj_info,
+					  &__entry->inj_info_err);
 	),
 
-	TP_printk("vcpu %u, rip 0x%lx", __entry->vcpu_id, __entry->rip)
+	TP_printk("vcpu %u, rip 0x%lx inj 0x%08x inj_error_code 0x%08x%s",
+			__entry->vcpu_id, __entry->rip,
+			__entry->inj_info, __entry->inj_info_err,
+			__entry->req_imm_exit ? " [req_imm_exit]" : "")
 );
 
 /*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b8fa16f9e621878..2d78c94e464295d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6156,6 +6156,17 @@ static void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 	}
 }
 
+static void vmx_get_entry_info(struct kvm_vcpu *vcpu,
+			      u32 *inj_info,
+			      u32 *inj_info_error_code)
+{
+	*inj_info = vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);
+	if (is_exception_with_error_code(*inj_info))
+		*inj_info_error_code = vmcs_read32(VM_ENTRY_EXCEPTION_ERROR_CODE);
+	else
+		*inj_info_error_code = 0;
+}
+
 static void vmx_destroy_pml_buffer(struct vcpu_vmx *vmx)
 {
 	if (vmx->pml_pg) {
@@ -8294,6 +8305,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.get_mt_mask = vmx_get_mt_mask,
 
 	.get_exit_info = vmx_get_exit_info,
+	.get_entry_info = vmx_get_entry_info,
 
 	.vcpu_after_set_cpuid = vmx_vcpu_after_set_cpuid,
 
-- 
2.26.3

