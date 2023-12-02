Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7173C801883
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442040AbjLBAFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442037AbjLBAFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369461BF3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so1516610276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475483; x=1702080283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fYSe4fYTi/FXGdeBXMWzLtaR6u3FlgzSZKw16CFq7Qs=;
        b=P5Oy/bS9Z7j0HLHWiDBbSHIA5JB5v0s/N0Xl8tgwcfKGk4zlUf5FpOKto8xih/RUFX
         hAcxikJ+PKvgBLXaQQEUC3Ki9c174PTje0vpn04GdZqsO7jvzmFDpt+TJAPyKCKtPiA8
         11eyCXtmO2qQyiv8Rx5ppGGMmIDlKT1f6o/wTPqavlqK4ssWduyA6iXLQMC7/c435jGu
         qC3j5Tr3KIlLsJzFDc3Bs7QE7AAdOS0NBVxansK48HbAIM5EV9836x02wI0v1VMGiIcE
         vRVQIxqfuqzx4dTD6W+hLzkoKtprvztO6mchOoK2aBiZyS3tacTwPMbbIO/t2rJteuq9
         9WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475483; x=1702080283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYSe4fYTi/FXGdeBXMWzLtaR6u3FlgzSZKw16CFq7Qs=;
        b=dYKt0+6q5o6R3bK5Nl1+FFl9S4KP5JuusFYMR+qGtDio4sP+DPTMcrby//beD2fLLX
         PDdtEZnZPFcwb8EPvHuGPz69/UA8VSUFFu1eGGRL+Y5erc5Tols96/BKJxWXda0Kqcfx
         mG6VbAJIJS47hlakjsN2v//psFMlNJeux4qzB3mfKkQx4RQ80+zhjD8zEecUhRLHLwTD
         7PWXY1tQWaXCNi6CSWdcbDKyVL1x/7hUDLd3uCZcFceKEjCrwWnwUG51+7h1IGEsMV90
         HnMpzvYASOzmro2Tpg/TDfii8Z/PkmNuezmWM/kYU6u6a6PXVc+FF6lBA17hwl8O45Ko
         /POg==
X-Gm-Message-State: AOJu0Yz28vyZn242qJCHZ7mCf0G3kEehqVxjDOu0SplJoM0VPHa5yLuc
        ZSTrbBxB0fDbJw1djqLgOtx3ZiDtWss=
X-Google-Smtp-Source: AGHT+IHAld8sq5015asBCXpzz1bGTW9LUBWyPvkc9PgfkusUCW0Kq3MDDnx8Vav2rn2hiVVO5LlkFzOkmoE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d1d1:0:b0:db5:423c:965c with SMTP id
 i200-20020a25d1d1000000b00db5423c965cmr226579ybg.5.1701475483633; Fri, 01 Dec
 2023 16:04:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:01 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-13-seanjc@google.com>
Subject: [PATCH v9 12/28] KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the "name" parameter from KVM_X86_PMU_FEATURE(), it's unused and
the name is redundant with the macro, i.e. it's truly useless.

Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 932944c4ea01..4f737d3b893c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -290,7 +290,7 @@ struct kvm_x86_cpu_property {
 struct kvm_x86_pmu_feature {
 	struct kvm_x86_cpu_feature anti_feature;
 };
-#define	KVM_X86_PMU_FEATURE(name, __bit)					\
+#define	KVM_X86_PMU_FEATURE(__bit)						\
 ({										\
 	struct kvm_x86_pmu_feature feature = {					\
 		.anti_feature = KVM_X86_CPU_FEATURE(0xa, 0, EBX, __bit),	\
@@ -299,7 +299,7 @@ struct kvm_x86_pmu_feature {
 	feature;								\
 })
 
-#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(BRANCH_INSNS_RETIRED, 5)
+#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(5)
 
 static inline unsigned int x86_family(unsigned int eax)
 {
-- 
2.43.0.rc2.451.g8631bc7472-goog

