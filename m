Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930DD7E0BF7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjKCXGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjKCXFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:05:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C0AD48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:05:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so1908423a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699052751; x=1699657551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8r9KyLTXzHPbLN5BIkdsSD83nOYaYPo3Uiesh5mapqg=;
        b=WEk0je4OxmlYws5A2zp0yML7uSsa2wiAdrh7tf36y8axz/Kpgm2WMW0ZZVjKt5zK3r
         9GYmXPcJekkE+uP/C7F8u5HsvDNNLiRweecdeuTq9GjRGKxJhKRR/ll359lOd1JAPy/I
         XRsJobfd0Ai/SfB3MkcV2Vq7aVJF1vISz/km47vleHaT8ypy0UUweRvFvm8WSfBkMiBN
         umfs1WZI2w+6TOqWWc/NAF7nsxxKQfrDlO41VpPVKYqJJF4jsmmHZH5GhCpDBIhY9C1K
         Qonw36bPXDzwrIhwxYeIyif5+SKuZ8P5/BKjYRsuojXBKfzjLSdCJXcOheBmGZQpFJNo
         uclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052751; x=1699657551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8r9KyLTXzHPbLN5BIkdsSD83nOYaYPo3Uiesh5mapqg=;
        b=jQVfCpk2mEcNYBrwKUA0TOyZwcF/Ok4ZEVgzg1KNKO40wJ/A5mI4rnr6Kaud3Ax0aN
         FzMzRfKxQu5jk039ae3lyeduLACWMh6GLnSfALoB3op7gyDswnaFLMivgoBBSgn1zmKf
         aEhwyV85W+U7l3YbMMEkhWVQzf0+VZ2PkRMTNxAClPLEVSzZSuUCWpcjDmlm9sAxLVVO
         xWOYX3mAK5ucu6PGg/yIrnCPcikLxCmVUKabAAUmBKcOLw8aTMYagDxZo1Y5hwQwJhLd
         XGgpvvEIS6tnKTuEOVEYNHI4lLOKvPBuzHYv6XxGsQ5M9lLAjVMQVS6aQiedFWS98nAG
         KtNA==
X-Gm-Message-State: AOJu0Yy1wEG8X7Qfb/g2VoQAfGf1J+U022jsmyWCD625dQY9Vo3J+cyt
        zbKpHK1Ptr8ScpO1TdJvM4YgGDW27/8=
X-Google-Smtp-Source: AGHT+IHPFl9rx3FEGjophWX1BIYSgQUn/Wb8sMkl1ur3aPB+4a48Xmek6HCimoafytzVOV/hsiz7QCQWDgE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d718:b0:1c5:7c07:e403 with SMTP id
 w24-20020a170902d71800b001c57c07e403mr408772ply.10.1699052751476; Fri, 03 Nov
 2023 16:05:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 16:05:39 -0700
In-Reply-To: <20231103230541.352265-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231103230541.352265-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103230541.352265-5-seanjc@google.com>
Subject: [PATCH v2 4/6] KVM: x86/pmu: Remove manual clearing of fields in kvm_pmu_init()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code that unnecessarily clears event_count and need_cleanup in
kvm_pmu_init(), the entire kvm_pmu is zeroed just a few lines earlier.
Vendor code doesn't set event_count or need_cleanup during .init(), and
if either VMX or SVM did set those fields it would be a flagrant bug.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 458e836c6efe..c06090196b00 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -710,8 +710,6 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
 
 	memset(pmu, 0, sizeof(*pmu));
 	static_call(kvm_x86_pmu_init)(vcpu);
-	pmu->event_count = 0;
-	pmu->need_cleanup = false;
 	kvm_pmu_refresh(vcpu);
 }
 
-- 
2.42.0.869.gea05f2083d-goog

