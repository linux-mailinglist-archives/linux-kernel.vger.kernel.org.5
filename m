Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22F2792C19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353867AbjIERGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbjIEQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:14:32 -0400
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21ACE2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:13:50 -0700 (PDT)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58fc4291239so26803377b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693930269; x=1694535069; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elh2tvnOEwSPsnja2sHYhfiZcx7ynquPFXavmZ4ChDc=;
        b=sB7R8/R6Eou9UxhWHe6z06FZiLaDzmt65AIjI3G/ffs6Dx1x4BkGxy5ywBf71Nfuyg
         8whBe8YA78f/Vc76txZxsjcbPqrd1bm1NjnH/MILpI3YAhSx7s8gHi/AKyPniIWYKuaa
         IX2hd5yMmpvgHerSBwSNojtWN9CW/CHB59m24sg/WdaoORadyvB3F7YxrsDAs50u4CuF
         fq+UtuP7v82WaReM3lI1y7/bjccy7TWd0nKc4bJkBOil6STDkamkTjV3JCX0M3lqiy03
         vIb6k7skssNoij5xjcXEixh8yx55k/j38jX+I9d0OtHXTGTbHGPN3lIl4lIS0on+YO7C
         ILbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693930269; x=1694535069;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elh2tvnOEwSPsnja2sHYhfiZcx7ynquPFXavmZ4ChDc=;
        b=b+xk5bgBFU7hLjwca0LZD1AxsQQ0qQrBMUfeP3q3PkuHLWDwJbvzQfynt5Go7hGOdH
         2IVQMMWnCWZmeIsnJ1nOeVdLBZxp4t+Lqck/FEBV4MwVb11GpkbP+kzTt4hmVV0Ssjfk
         upwod9nnyzcKC8lF2SI+ojf6bJgbEr+0C/KPxk50HcWrsAZXpews/DwO4EkprKPIRyk7
         1ESaZHFR8+zrRNl824X5Zy8GP7GKnzycVKN6U2st+yueFzE2Ng1jiDFJj3cSiTi0kQhn
         A112pWppOTj1bEOioIGkH5IS2yU2SVzEP0aRrUBFotioCB3KIl38izepqz9yzgAg+Gny
         0QVg==
X-Gm-Message-State: AOJu0YwY1dbk1qPK31kTQSI5Z1P5ad5rtgccusGNiUdCepRrJ7e0R4Ap
        Q7lOmi4UbZKLLDpOslfRCyKfFevysVM=
X-Google-Smtp-Source: AGHT+IHTRH2f5FQkBHRdyOy5nv59i/lThHn59yLvVKowANeAl0uNOjZs7MrTDcdffQ1mbM6m6fwIoZFlcbQ=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:15:a655:3f3b:27cc:1272])
 (user=pgonda job=sendgmr) by 2002:a81:c649:0:b0:583:4f82:b9d9 with SMTP id
 q9-20020a81c649000000b005834f82b9d9mr356053ywj.5.1693930269081; Tue, 05 Sep
 2023 09:11:09 -0700 (PDT)
Date:   Tue,  5 Sep 2023 09:10:48 -0700
Message-Id: <20230905161048.3178838-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH] KVM: SEV: Update SEV-ES shutdown intercepts with more metadata
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if an SEV-ES VM shuts down userspace sees KVM_RUN struct with
only the INVALID_ARGUMENT. This is a very limited amount of information
to debug the situation. Instead KVM can return a
KVM_SYSTEM_EVENT_SEV_TERM to alert userspace the VM is shutting down and
is not usable any further. This latter point can be enforced using the
kvm_vm_dead() functionality.

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

I am not sure if this is the right path forward maybe just returning
KVM_EXIT_SHUTDOWN is better. But the current behavior is very unhelpful.

---

 arch/x86/kvm/svm/svm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 956726d867aa..547526616d60 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2131,12 +2131,16 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 	 * The VM save area has already been encrypted so it
 	 * cannot be reinitialized - just terminate.
 	 */
-	if (sev_es_guest(vcpu->kvm))
-		return -EINVAL;
+	if (sev_es_guest(vcpu->kvm)) {
+		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+		vcpu->run->system_event.type = KVM_SYSTEM_EVENT_SEV_TERM;
+		kvm_vm_dead(vcpu->kvm);
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

