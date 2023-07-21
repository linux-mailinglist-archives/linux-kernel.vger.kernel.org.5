Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3475D58A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGUUUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjGUUTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:19:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0471A3AAA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704e551e8bso23665447b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689970767; x=1690575567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KuoRE5Yl/DRtsjNa9mcAjfrWHh9Er79Gr1x6j80L0wM=;
        b=zD0iPAvsDw8xZvpkb6VCX2DZ6JQWGPjSkgFkC8hr4z3ClAZZgFh1N6K8U9uOWj82dp
         7NBT8FLyUndSgt9nq0w0GtFwlmH6y3aYd4KDVxwEGAqJDg+lEF5owwSgo/isG26leJl2
         WSW/txg1FS72tYowQfx/2adEJfka7gRf1lcfiA6tv8sRmumeZcalqKkBWisH0xC3+eSb
         yl+7xT9TZ7iW0pRwKkHScttEu3f7Wtg+yiiUHWnhPj9o9hWIg78vyIwhZ2EbR4Ua63cn
         KcHhoZxuRL/UQxqcQF8/gpLWTsmMelRFXVaQb1XBGI14PiIlz3uQu2uIh2s5G4c7ZoKx
         clBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970767; x=1690575567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuoRE5Yl/DRtsjNa9mcAjfrWHh9Er79Gr1x6j80L0wM=;
        b=XrP8PrsPEylaFQiCHlq9suAjveTR3e3D/MsZt4xoXo9FVVB5KnrMBA3HebcDALAoKt
         XU6CULr5DFm4VxFG+eyud6FeKt5QbqHw64weIFyn+rWmwN9twzoF5C8G1ZMhbZXLviYZ
         JsmIAaIwtPYhrHpoB9k2bT9+ib2d38yGFDwvR5yhaw9sYTw6f7bkukSQ8LZcr/JNFEpt
         j0jFWwKWKcRnf9Yljba2/B8cOM/t/LLdDXCBkDssIS0xXj4yO3G4OuSqmDITFiiuhn/i
         0s/mbYqxmybKmT5dSxugPCCi/G5zaRw5L9o+kyrS793lK5Ea7CcdP8BKmadPFCTnV4hp
         /dew==
X-Gm-Message-State: ABy/qLZZcDDY3z+modO6+q4753gGb4roQ5+Fo1648BAK7AsxjhxkB6fb
        aS0o/JP9/KNhV2g7/S4QK4LLTc+2xtg=
X-Google-Smtp-Source: APBJJlEhYy425WCnIIBImM5L/iSd03oI8qew0VWqrx4AwdpTdIPIg5t9V5WyZH2ZcsgmbT1N58lAS9Y5pS8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:102f:b0:c22:38c2:43de with SMTP id
 x15-20020a056902102f00b00c2238c243demr21396ybt.11.1689970766940; Fri, 21 Jul
 2023 13:19:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 13:18:51 -0700
In-Reply-To: <20230721201859.2307736-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721201859.2307736-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721201859.2307736-12-seanjc@google.com>
Subject: [PATCH v4 11/19] KVM: SVM: Make KVM_AMD depend on CPU_SUP_AMD or CPU_SUP_HYGON
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
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

Make building KVM SVM support depend on support for AMD or Hygon.  KVM
already effectively restricts SVM support to AMD and Hygon by virtue of
the vendor string checks in cpu_has_svm(), and KVM VMX supports depends
on one of its three known vendors (Intel, Centaur, or Zhaoxin).

Add the CPU_SUP_HYGON clause even though CPU_SUP_HYGON selects CPU_SUP_AMD
to document that KVM SVM support isn't just for AMD CPUs, and to prevent
breakage should Hygon support ever become a standalone thing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 89ca7f4c1464..66dbd1f4d57d 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -101,7 +101,7 @@ config X86_SGX_KVM
 
 config KVM_AMD
 	tristate "KVM for AMD processors support"
-	depends on KVM
+	depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
 	help
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
-- 
2.41.0.487.g6d72f3e995-goog

