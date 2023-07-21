Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B5275D7FB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGUX4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGUX4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:56:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0652B30E1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:56:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8a7734734so14363525ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689983805; x=1690588605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/0/Ys3eyilWPWK3MFX3CavmjPp16nyypaJP3VylXGoU=;
        b=AozewlHZURPovNElQfoYDp0vUxJqneJqSpZ25EaH5FyAd+F6cPs+hMGzHxOByIMyyh
         cR4vkzvcesyxfxZklzBFTQTHJDnA+yJQFcZVLfCq4J4NTQ54Dhz1GxFvCBQ3OpazhV2t
         mSegV8J9RIDYTJTSxe1a/R9AdW0mwmzUwYjnECwhFQdQsvzipRK2PPsQOHcTNR2TuU2c
         OAT/p71pi2JxgYVyi3xGPONi9yWumb2uFjAJlqpu99GgiMhGvGZdUHVW9615aMaMV6Hg
         j2I0ZYUg4yYhysw5dsu3sD9dUF57v7H59Qf0FX55q7EB0U4nTm5c+T/MFN3AnMoClLaV
         Zd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689983805; x=1690588605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0/Ys3eyilWPWK3MFX3CavmjPp16nyypaJP3VylXGoU=;
        b=iY5QnPzf2n9mYaxt6gC/j6X4LeEvY+D7KBRMmhcVG6MnvwoLbebsbpwf0h40r+B+XR
         0Lz+6ETeMvQAQvlg+Mx8mtVMv+TLkryk2o6zNYgEc57DFJ89dpEtP2Kx6ghd0KLKOYsp
         XH1WKcxaGGq5Kyq5h6bAUVXfkc8IbmHYKgnQ1/MbSRKHBfDhaWG3gDfMCJuQDDuj9kiM
         go0pRV6RlZEsQQFhxLNzJWF3FN4SesloUPazJZY1qfAuTXQiRfz9BuTa4dF9NoAsy/wF
         0RAwv0WQx2igK0X2d5Y4BcMCJ7Do4BISU0v3QRNCGTNa+NWT+aqUjIlXAyegxEBUrXVn
         jM0g==
X-Gm-Message-State: ABy/qLbaDHHOWoBu9SAkazZtneCR5738zBrO/ejqnBvyI9TSQaa4Tqzl
        KgshwRBD6XI6IXp9Wxqi7p6I0P42uOc=
X-Google-Smtp-Source: APBJJlF9re/QfEiwtTvrQ2bbtlEB4e6P4b3U+Tw4dcVSuQCMsevPuEn/b6qzORLgenNlpOoqeUsTqJReT68=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:32cd:b0:1a6:4ce8:3ed5 with SMTP id
 i13-20020a17090332cd00b001a64ce83ed5mr13087plr.4.1689983805595; Fri, 21 Jul
 2023 16:56:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 16:56:37 -0700
In-Reply-To: <20230721235637.2345403-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721235637.2345403-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721235637.2345403-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: VMX: Use vmread_error() to report VM-Fail in "goto" path
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
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

Use vmread_error() to report VM-Fail on VMREAD for the "asm goto" case,
now that trampoline case has yet another wrapper around vmread_error() to
play nice with instrumentation.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx_ops.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 5fa74779a37a..33af7b4c6eb4 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -108,8 +108,7 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 
 do_fail:
 	instrumentation_begin();
-	WARN_ONCE(1, KBUILD_MODNAME ": vmread failed: field=%lx\n", field);
-	pr_warn_ratelimited(KBUILD_MODNAME ": vmread failed: field=%lx\n", field);
+	vmread_error(field);
 	instrumentation_end();
 	return 0;
 
-- 
2.41.0.487.g6d72f3e995-goog

