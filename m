Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C37977E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbjIGQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbjIGQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:36:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C0518C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:26:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-565e78b8b31so1261586a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694103893; x=1694708693; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oAJvejQkP8HyG+gPbDyWclQAKXMlf/E8yZttByLJOOw=;
        b=VvMvKBX8UtAMxcyRSsY5BkGuV3l6kL2WoI4Ze98/3vOjcaH6Lv4aeLB1IpaLLSEcsk
         gA9IOxK3qnSI08FLKArOSM67uD29Li2PgOcm+A3cewHmOIC4oeSwIUqBuPJunSfcbvVK
         r7o4cz7vxK7+OTtr7ihHmN9e+J1xWyEwvvE9CkA2NnWxNe+lsQABTHoMq49p/TpknA6D
         OSBl0uKj5z4/5K0zk7NXVaCkduyfTT2G21l08bAxJGGF9Ibo0lvXTRqI86QVQ4+xU3MM
         6mSFSjoGxS/UKafbi95UH4UuXdsAa937uZCZ6Uz8i9QJcwt6siL8yJvrAruXRBwAZoRk
         1Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103893; x=1694708693;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAJvejQkP8HyG+gPbDyWclQAKXMlf/E8yZttByLJOOw=;
        b=II5NP/LBctZhzZ3ognKL7EsiuZcYc2kR98I7nYgnoP7l5AdFEsYZragyp0Zq65l9mR
         0JCc6UVURQi4Z5/eV24Ld6PNyZL1B2bRi/kMn1RO+FvhpgpO1ER4AwI6K4fk8LrQzLgF
         5hwY1wJoD9YsIoD5Y+wtjgTkf8ylBEEY3Os0HXi8BeRaUHkjhnCD498McsVfuq6kHobl
         Q45anIqQ+8LOeaoFyioPaW42bp4pu5GAKJtWJZDtCVxhmdynND+amvq30j0KNmpZatYA
         5kEiPxTBDo1uqYXUm2H9Z3M+2Vw+vJjbwvYvNhv147Spkkxr1WYf8oPZPssxGuSPF8L9
         TXIQ==
X-Gm-Message-State: AOJu0YzyXhleFM9VHsTYmQlYuG1/A3YZ0UHleGMFJ+V5lvMamkumJnjF
        mChML5S/PiEhi8uV8zrrzgB6Fejxujw=
X-Google-Smtp-Source: AGHT+IE7SJ5e2Xx9+qwsR5zLU5cq4bwdrLUCIfdMrQWFAZGnipEekaQC5GzdIkcEbPI1oIcNljzA6+jLuZw=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:e95c:4a2a:4112:e68])
 (user=pgonda job=sendgmr) by 2002:a17:902:c950:b0:1c2:b50:c91d with SMTP id
 i16-20020a170902c95000b001c20b50c91dmr13946pla.10.1694103892924; Thu, 07 Sep
 2023 09:24:52 -0700 (PDT)
Date:   Thu,  7 Sep 2023 09:24:49 -0700
Message-Id: <20230907162449.1739785-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH V3] KVM: SEV: Update SEV-ES shutdown intercepts with more metadata
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
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

Currently if an SEV-ES VM shuts down userspace sees KVM_RUN struct with
only the INVALID_ARGUMENT. This is a very limited amount of information
to debug the situation. Instead KVM can return a
KVM_EXIT_SHUTDOWN to alert userspace the VM is shutting down and
is not usable any further.

Signed-off-by: Peter Gonda <pgonda@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/svm/svm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 956726d867aa..114afc897465 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2127,12 +2127,6 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 	struct kvm_run *kvm_run = vcpu->run;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	/*
-	 * The VM save area has already been encrypted so it
-	 * cannot be reinitialized - just terminate.
-	 */
-	if (sev_es_guest(vcpu->kvm))
-		return -EINVAL;
 
 	/*
 	 * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU to put
@@ -2141,9 +2135,14 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 	 * userspace.  At a platform view, INIT is acceptable behavior as
 	 * there exist bare metal platforms that automatically INIT the CPU
 	 * in response to shutdown.
+	 *
+	 * The VM save area for SEV-ES guests has already been encrypted so it
+	 * cannot be reinitialized, i.e. synthesizing INIT is futile.
 	 */
-	clear_page(svm->vmcb);
-	kvm_vcpu_reset(vcpu, true);
+	if (!sev_es_guest(vcpu->kvm)) {
+		clear_page(svm->vmcb);
+		kvm_vcpu_reset(vcpu, true);
+	}
 
 	kvm_run->exit_reason = KVM_EXIT_SHUTDOWN;
 	return 0;
-- 
2.42.0.283.g2d96d420d3-goog

