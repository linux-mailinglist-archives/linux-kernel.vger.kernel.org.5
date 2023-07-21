Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07E975D7A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGUWnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGUWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:43:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AD13A86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:43:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2631231fed0so1289603a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689979423; x=1690584223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QLdjoAuH6ny9qcAXLDVVZFI8shq7PUiJbkoQWuRMVVg=;
        b=r7DayOcA+ltTh6qjlaW24skIpW7xZ/eeZRZhOUL6eNDr49X0gtEPZCrp9ecJuvEyXa
         iyUjReMGUqms9AQmBsMakzpo5wZxxM68a5j76iaYZttCeKC4bgdGFfLa/BnQr3+jt8S+
         +wXPqZcgfTEEk3m9HhS0BLqP24tj0/TPPTZGgXkBIKGL56mERUjJVbULQtda6tVhY5wQ
         eqhWSNgI0nNgQGqXEIaQ8wWdHVrZ1LWyxmvpoDZcT8PSdbhwYfJDwFHV3UfEtrr/WgNh
         /BQ+a0EeMxOH3Ukt17t90axDe3hzA33+A6yMeH5hU5EXAVwuIAeIrC8vgkArp/6Z5hks
         ynzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689979423; x=1690584223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLdjoAuH6ny9qcAXLDVVZFI8shq7PUiJbkoQWuRMVVg=;
        b=fGejo3Ou5OiSxu9EHwkLxXSInj9NZp1gafnIgZPVjwldneBAz7rmlD+tb0MoCA7FTG
         CERcKNWKUl+bxLTTgvxpxSBl5EOtT2PbmWwrvywjVW/rtLyBRxsk4/z+GjQlXeuYhQL1
         MzNIQb/Xkd/EcdwC6lHqQNgwyykOxyXjKSKozS8gIzm74S62Y9yzx0bcHHedCDJpThP3
         qxXwcx1nUj+IzYkHO/ZeK6rcKoH8x0hsepMeeRfdOutfkOt6r5Bg1HucU3jHWnqZCflI
         ++Tak0gZhFO4L6IKVThBfJ9kf4rAHUIvylKJqvkvEHTt3Aqs+nxLlErsCA0uPCOSJ96g
         Ze4g==
X-Gm-Message-State: ABy/qLaV1t4uLsuyvbkBRlnlsg2G4Ygd0g7CmjziIGpwAv28E8DO7NJh
        jDXzape6+oIS2opPtXcrmJnM1svS0CY=
X-Google-Smtp-Source: APBJJlGl6ZlPeg7FzuC/9y7JTBhGtcOsUDfONYfHz3CdAvqvd3nJVGgrwd6x8dJgPSW4q+12UlFCrNglprA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f691:b0:1b8:a555:385d with SMTP id
 l17-20020a170902f69100b001b8a555385dmr13248plg.9.1689979423484; Fri, 21 Jul
 2023 15:43:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 15:43:37 -0700
In-Reply-To: <20230721224337.2335137-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721224337.2335137-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721224337.2335137-3-seanjc@google.com>
Subject: [PATCH 2/2] Revert "KVM: SVM: Skip WRMSR fastpath on VM-Exit if next
 RIP isn't valid"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>,
        Aaron Lewis <aaronlewis@google.com>
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

Now that handle_fastpath_set_msr_irqoff() acquires kvm->srcu, i.e. allows
dereferencing memslots during WRMSR emulation, drop the requirement that
"next RIP" is valid.  In hindsight, acquiring kvm->srcu would have been a
better fix than avoiding the pastpath, but at the time it was thought that
accessing SRCU-protected data in the fastpath was a one-off edge case.

This reverts commit 5c30e8101e8d5d020b1d7119117889756a6ed713.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d381ad424554..cea08e5fa69b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3986,14 +3986,8 @@ static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
-	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
-
-	/*
-	 * Note, the next RIP must be provided as SRCU isn't held, i.e. KVM
-	 * can't read guest memory (dereference memslots) to decode the WRMSR.
-	 */
-	if (control->exit_code == SVM_EXIT_MSR && control->exit_info_1 &&
-	    nrips && control->next_rip)
+	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR &&
+	    to_svm(vcpu)->vmcb->control.exit_info_1)
 		return handle_fastpath_set_msr_irqoff(vcpu);
 
 	return EXIT_FASTPATH_NONE;
-- 
2.41.0.487.g6d72f3e995-goog

