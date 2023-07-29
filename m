Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6A767A96
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbjG2BQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbjG2BQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:16:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5413C34
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:16:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1ebc896bd7so2518275276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690593380; x=1691198180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yjRclKPY/9S+JAFpnnezgnJAMv3d4o18PbOAl4Gq6ok=;
        b=caCnBKLK7IeUNp+Z+raLFiokOC/PMzHYkMmLwjuwc30UhDYMyfbhEyZ5nbkAN7xkug
         KKEqQjN9iHGmf2ROn0mMx3MXFk+YuOxc8W5HM0Gs4i/dieGRnzIvxSz0qTiN9Odhjyab
         seK5w16gJ9mug5/WoV1dYB+JqSU4GkUKZuEOGiyzUF8SpjKRgXR1FrDI+0JENrWJtLKT
         2GG1xPNuSYMeHfd3SL6QK/G/DsfLaMWwAuExeV/ZmopcHhdtiUrB6+SH9EIoA0GYXJA2
         KkguPnmbdOsuwC+YTNWiz362JDyAEftoOG+Gtq8k02+XNdOvh3/R0RtWkr+0nNq2QegI
         I8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593380; x=1691198180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjRclKPY/9S+JAFpnnezgnJAMv3d4o18PbOAl4Gq6ok=;
        b=FE4qrH0koDxVKFoagwlxGSc4N20a3sv+2Iako/5OaZDmuBmU7p4eibrLu0ZcRgIAz4
         kg7MKgMg7pV9U2yjOdpbkc2mPGwXuN1NqVthty/LSfutPhZVASLlUCFmrOCUC1dVnPC1
         KlojGD8dcEYm0iKwjEmLH1EQDAm6iMAPN+FlCcY+RvYfAu0SJNE0iRmnTTCRppDygBPK
         N6t16UKyrov13RSYvZrded2hnqEh9one0E3lznkw0327IM9JtxUgUwT21lmqPh2aFliq
         asARD43kWS1zr8t2UaCPSbkT1T73SAR6GYo8L3pB7Bng/gQFRlU0ebmJO9oRiqScU4X8
         cO/A==
X-Gm-Message-State: ABy/qLbPuewHJnNc8x4XZRMN/maX/ou389sBE4uAE1bBLMlih8EvDSyB
        qeoSK9y2Y/mV+LZZFMfKmV5unzAf5xM=
X-Google-Smtp-Source: APBJJlEV5PhfGedhl3jiGyHeUE/m8NExxIiEA2dNQG0uJ2VsA7EdgcHWbU7ZBrlSB3ScclHwZe4y4vgA/9E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ac48:0:b0:d15:d6da:7e97 with SMTP id
 r8-20020a25ac48000000b00d15d6da7e97mr17043ybd.3.1690593380274; Fri, 28 Jul
 2023 18:16:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:15:51 -0700
In-Reply-To: <20230729011608.1065019-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729011608.1065019-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729011608.1065019-5-seanjc@google.com>
Subject: [PATCH v2 04/21] KVM: SVM: Clean up preemption toggling related to MSR_AMD64_TSC_RATIO
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly disable preemption when writing MSR_AMD64_TSC_RATIO only in the
"outer" helper, as all direct callers of the "inner" helper now run with
preemption already disabled.  And that isn't a coincidence, as the outer
helper requires a vCPU and is intended to be used when modifying guest
state and/or emulating guest instructions, which are typically done with
preemption enabled.

Direct use of the inner helper should be extremely limited, as the only
time KVM should modify MSR_AMD64_TSC_RATIO without a vCPU is when
sanitizing the MSR for a specific pCPU (currently done when {en,dis}abling
disabling SVM). The other direct caller is svm_prepare_switch_to_guest(),
which does have a vCPU, but is a one-off special case: KVM is about to
enter the guest on a specific pCPU and thus must have preemption disabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 13f316375b14..9fc5e402636a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -552,15 +552,11 @@ static int svm_check_processor_compat(void)
 
 static void __svm_write_tsc_multiplier(u64 multiplier)
 {
-	preempt_disable();
-
 	if (multiplier == __this_cpu_read(current_tsc_ratio))
-		goto out;
+		return;
 
 	wrmsrl(MSR_AMD64_TSC_RATIO, multiplier);
 	__this_cpu_write(current_tsc_ratio, multiplier);
-out:
-	preempt_enable();
 }
 
 static void svm_hardware_disable(void)
@@ -1112,7 +1108,9 @@ static void svm_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 
 void svm_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 multiplier)
 {
+	preempt_disable();
 	__svm_write_tsc_multiplier(multiplier);
+	preempt_enable();
 }
 
 /* Evaluate instruction intercepts that depend on guest CPUID features. */
-- 
2.41.0.487.g6d72f3e995-goog

