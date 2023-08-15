Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B477D454
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbjHOUh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbjHOUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:37:36 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B126A4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:37:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-686b879f630so6264048b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131823; x=1692736623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=194Q9JKRkX0kn5HS7G+Yhmq9XbiwQ8AINE2AwfpTISk=;
        b=UcjAxrAD0iT9xyNSSRKw6S6Mnh+F9jsWWrhMuioT2vmmxmn8yfZR5CzeYjfZ7qbGk1
         aAX8OdtgJ8Q9vokeo3rgEmW+jMQZvpoa2tNiXA6Ol2FEahLf2fpPDxKwHXfzbZrVKf2R
         f5GfJJevtQw3EiWD6D3UY/FVmDNzE0zmxwOLDrYVoJzYDSP22gi1K2GuYGhu0eunYGYI
         G54NHubi6Tk/NDwt+DzuhIqPNUjYIeafzun97fCvpJfq5ng7SOL2/RIHw9xbYW1nN5G5
         afQVSljfzOQ5VFRdxqn0MM+BXMv5sQd6VC9NjXq5vbbfs2btQYY1tkk7DNpqtQEuQiVJ
         Psbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131823; x=1692736623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=194Q9JKRkX0kn5HS7G+Yhmq9XbiwQ8AINE2AwfpTISk=;
        b=igqte7ttrA0oNzgw6ofFueAVspfMbA91YVvsQKmMknvmmZEN2rQUgOpwj582YLFGbk
         ebopItUo53K09Zwy6JkAVAkmYilaBfgRjDbg2EDwKhs6JadedWhsnOXpsYrNaSZX8JJ0
         tKWdWhgHe+IObxPalvuD2BHHBWMu6KpjdQNXylPBmwNaGM5mDWwME4m9CLHAXI5b+kGp
         PJG0ywGiAeVtGMDkltEIhDjASlP80YTt0HvXupdknx4NL7N9l3NwbU9DIREaEbluN8Na
         bIQ6NqLVyRBthKu11lFRX6VGP/CvWwS7ySs9VdAhDuhDMxUNrY4YvNXhPqXjCTkPKjpd
         sZvw==
X-Gm-Message-State: AOJu0YxU54iJdXifYvTTVOlUxBwnZV+hskYG62jTVmda+omog9i+EVwj
        JBrcNaJKEMzS73gNhmG5VJc+ielQgmM=
X-Google-Smtp-Source: AGHT+IHQKU3jEXExnIEFi74xujdPT3vtmMe3RhUwRMHGoznyBB7vqMTLiRTpubj1+/t4vfHF5k4NsahV0AY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a0f:b0:687:4554:5642 with SMTP id
 g15-20020a056a001a0f00b0068745545642mr5954001pfv.0.1692131823190; Tue, 15 Aug
 2023 13:37:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Aug 2023 13:36:42 -0700
In-Reply-To: <20230815203653.519297-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230815203653.519297-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815203653.519297-5-seanjc@google.com>
Subject: [PATCH v3 04/15] KVM: VMX: Check KVM CPU caps, not just VMX MSR
 support, for XSAVE enabling
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Guang <guang.zeng@intel.com>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check KVM CPU capabilities instead of raw VMX support for XSAVES when
determining whether or not XSAVER can/should be exposed to the guest.
Practically speaking, it's nonsensical/impossible for a CPU to support
"enable XSAVES" without XSAVES being supported natively.  The real
motivation for checking kvm_cpu_cap_has() is to allow using the governed
feature's standard check-and-set logic.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1bf85bd53416..78f292b7e2c5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7745,7 +7745,7 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
 	 * set if and only if XSAVE is supported.
 	 */
-	vcpu->arch.xsaves_enabled = cpu_has_vmx_xsaves() &&
+	vcpu->arch.xsaves_enabled = kvm_cpu_cap_has(X86_FEATURE_XSAVES) &&
 				    boot_cpu_has(X86_FEATURE_XSAVE) &&
 				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
-- 
2.41.0.694.ge786442a9b-goog

