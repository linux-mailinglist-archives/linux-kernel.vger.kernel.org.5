Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C10787D45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbjHYBhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbjHYBgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:36:33 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8C81707
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:36:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c08a3f7270so6562615ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692927391; x=1693532191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+tFz1o5VJHJBHmwn/iad/HpnjqcKBaGzo/qVU/9dboU=;
        b=vWt2oom3hr+D86HKSrfN8337aaRbh074j5hyYZl3XQsnBmAl5OwUOzWvZDMFGnkWgS
         FaV9zOdk4XvEtYn7uIqNZ3mfAjHHOQzCmJVtGhxbLV8rIeZ4U5MKXtgqUOxC3gbUAXSt
         WJAG9rRCPt2Of204Fm54E1Fwk/TUDzjjw9wjmTF+ytgxEyFL8fBEUzot3zHsE1NLHw3v
         QQDEoo0847v0PekukiJSX7pwpa+/aYcRActdANx1OKoKhn99u912ITeo6OzXx8TC8PQj
         IDvFk/LaRCiUTRpXafKC2cVHlzCfPJMhEu2Wia2/d3FmjA2iaFQKmPrDdpzcMRgguySg
         Gurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692927391; x=1693532191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tFz1o5VJHJBHmwn/iad/HpnjqcKBaGzo/qVU/9dboU=;
        b=k5iG/FQ2sB3rGxtNdAF1PoaJXNkzltnjYyBhjvfGKHfela+1HMgkri2DdsQl6jR+2Q
         tiuMQx2Cx08i9Vf0ikZ0vIcC7oFy2Z+zrJKwQ/o25m2PivEbZI7Ve7IQbqGox/nthBaj
         LlhJscSRE26SGdAupkQlteo4xdfBN4MkOwwiG35+eD/lyRtesd5EPhQAatg8imFIfq8J
         i1vhDWE3t+BSlYlPyYIVpVz012m8+8hfH6k9eA7KBBPg1HRemD53r8Wnyg40GZjrSwPj
         mkrQQVaV433YmV57b3gtj5RFqo5o0ZAuxnKRowXxNzjXuaAFYmMfGP8qYT8aFnrdp3pS
         uPxA==
X-Gm-Message-State: AOJu0YzgOH5mYuA9gwjnpTHJ8a67BuuNUB/LDcycfxvoRcKY07eW7QFz
        2X0b2TtEIq11pIWBU2QUkFKIiEv0bcs=
X-Google-Smtp-Source: AGHT+IGb6VGxHTuQim1r0jy/sw1CsKGKO85abRuuyUKHLgMrhFUgcxxcFnyqGJ+Mkz4m4hrKo8Eqmwn9wBU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:32ce:b0:1bf:610d:2be3 with SMTP id
 i14-20020a17090332ce00b001bf610d2be3mr7577973plr.13.1692927391341; Thu, 24
 Aug 2023 18:36:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Aug 2023 18:36:21 -0700
In-Reply-To: <20230825013621.2845700-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230825013621.2845700-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230825013621.2845700-5-seanjc@google.com>
Subject: [PATCH v2 4/4] KVM: SVM: Treat all "skip" emulation for SEV guests as
 outright failures
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Zongyo <wuzongyo@mail.ustc.edu.cn>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat EMULTYPE_SKIP failures on SEV guests as unhandleable emulation
instead of simply resuming the guest, and drop the hack-a-fix which
effects that behavior for the INT3/INTO injection path.  If KVM can't
skip an instruction for which KVM has already done partial emulation,
resuming the guest is undesirable as doing so may corrupt guest state.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 12 +-----------
 arch/x86/kvm/x86.c     |  9 +++++++--
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 39ce680013c4..fc2cd5585349 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -364,8 +364,6 @@ static void svm_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 		svm->vmcb->control.int_state |= SVM_INTERRUPT_SHADOW_MASK;
 
 }
-static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
-					 void *insn, int insn_len);
 
 static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 					   bool commit_side_effects)
@@ -386,14 +384,6 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 	}
 
 	if (!svm->next_rip) {
-		/*
-		 * FIXME: Drop this when kvm_emulate_instruction() does the
-		 * right thing and treats "can't emulate" as outright failure
-		 * for EMULTYPE_SKIP.
-		 */
-		if (svm_check_emulate_instruction(vcpu, EMULTYPE_SKIP, NULL, 0) != X86EMUL_CONTINUE)
-			return 0;
-
 		if (unlikely(!commit_side_effects))
 			old_rflags = svm->vmcb->save.rflags;
 
@@ -4752,7 +4742,7 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	 */
 	if (unlikely(!insn)) {
 		if (emul_type & EMULTYPE_SKIP)
-			return X86EMUL_RETRY_INSTR;
+			return X86EMUL_UNHANDLEABLE;
 
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return X86EMUL_PROPAGATE_FAULT;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f897d582d560..1f4a8fbc5390 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8858,8 +8858,13 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	bool writeback = true;
 
 	r = kvm_check_emulate_insn(vcpu, emulation_type, insn, insn_len);
-	if (r != X86EMUL_CONTINUE)
-		return 1;
+	if (r != X86EMUL_CONTINUE) {
+		if (r == X86EMUL_RETRY_INSTR || r == X86EMUL_PROPAGATE_FAULT)
+			return 1;
+
+		WARN_ON_ONCE(r != X86EMUL_UNHANDLEABLE);
+		return handle_emulation_failure(vcpu, emulation_type);
+	}
 
 	vcpu->arch.l1tf_flush_l1d = true;
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

