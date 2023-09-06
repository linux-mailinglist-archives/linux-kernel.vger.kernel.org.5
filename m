Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0597794012
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbjIFPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjIFPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:14:59 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007FBE64
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:14:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68a6cd7c6c0so4240294b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694013295; x=1694618095; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SGtKf8yShh4CSFb6KNk0X1Y8UQuGAFVHPS1RsqL9uvw=;
        b=e9OJlsja2yDVUsaaJcouDggemXncgGbjGgSdKaU2OQc/fZW18llLTRmppaEqg2zJId
         WgjMSNVdYroxuVxHfJiKm8eV6npBenKh6vl5+83bzalJX+N9s02y3u4uEu8bK7gvSRUF
         ROI880OEzxIHfIIN3EwOUqk+qwOav76FC1Pr/JG4P3aKEMMCBYP1ZEH+BM+Od8KLhGXC
         jV+BePOO9IowjiEJz0aCvXzf0ijggERaF03w5Hz4cbBFB89ZE3jtjT3hWHxSq4f6vGUu
         ocVjqmayJXeTnUU/DAwdNxKGeFZGopW18H7cmAuADwlcQeVeEm5QI6xNRIwcdxPkhr/R
         wGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013295; x=1694618095;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGtKf8yShh4CSFb6KNk0X1Y8UQuGAFVHPS1RsqL9uvw=;
        b=PKfj33FlwkKXalVQGWesBjZU50Jt2rdXhuGBp2ZFvTxIyAdKlcnIcOx0tSZKRxSzqv
         kmWZhc8FP3xHcyxhWxxe+Ts75WVoHsTL7XgGGbltsmjXWufWRpgfeIPSTlZlfkRvliHx
         ZdNu+EoIcHqLoo+HpYNzXpcGxa39eFXh/FlGikoUHcF/5t/dyuw6kovidVbpp+aOsae4
         mjrsmTGsnYwXS3GHTm70TFZNOAv3tl8WIn3X0q6tpCTglP5QrXHvgyXeYMDVyjia2a/9
         J+YMlcQ1p9+4mCwN6ZModwCV0zqHuS4pYQNzxZBBEvkKgN4nc6hIS79vNBy7qvRN37j+
         ARZA==
X-Gm-Message-State: AOJu0Yyuc3UmS1TbuMG5KtuLNI66uvfj+D17nEydzAKT+z5+DhSK3m50
        cuSlHIz+d3wDsd07xNifl/Hws/a0hl4=
X-Google-Smtp-Source: AGHT+IE/tnuG+PBjEOm9KRjhb810rtGMR0faOhyMhq/4H9d1Hbu0eGVfxaqNx9WupFQMz6s1rtWrHx2cwxI=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:e3bb:5424:b689:5e16])
 (user=pgonda job=sendgmr) by 2002:a17:902:ced2:b0:1b8:95fc:d0f with SMTP id
 d18-20020a170902ced200b001b895fc0d0fmr5800744plg.7.1694013295413; Wed, 06 Sep
 2023 08:14:55 -0700 (PDT)
Date:   Wed,  6 Sep 2023 08:14:49 -0700
Message-Id: <20230906151449.18312-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH V2] KVM: SEV: Update SEV-ES shutdown intercepts with more metadata
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
 arch/x86/kvm/svm/svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 956726d867aa..cecf6a528c9b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2131,12 +2131,14 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 	 * The VM save area has already been encrypted so it
 	 * cannot be reinitialized - just terminate.
 	 */
-	if (sev_es_guest(vcpu->kvm))
-		return -EINVAL;
+	if (sev_es_guest(vcpu->kvm)) {
+		kvm_run->exit_reason = KVM_EXIT_SHUTDOWN;
+		return 0;
+	}
 
 	/*
 	 * VMCB is undefined after a SHUTDOWN intercept.  INIT the vCPU to put
-	 * the VMCB in a known good state.  Unfortuately, KVM doesn't have
+	 * the VMCB in a known good state.  Unfortunately, KVM doesn't have
 	 * KVM_MP_STATE_SHUTDOWN and can't add it without potentially breaking
 	 * userspace.  At a platform view, INIT is acceptable behavior as
 	 * there exist bare metal platforms that automatically INIT the CPU
-- 
2.42.0.283.g2d96d420d3-goog

