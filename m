Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3897CE0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjJRPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjJRPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:19:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BABBFA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:19:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso108119927b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697642348; x=1698247148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKf8GaX1o9f6WWK2vB+CbFj4C9pCegGrVSLQx7G2y0M=;
        b=S/0zXeIxD13YbjYzwZCBZ2z9UnHoSdEXs/cI7Biovs5AbBxT0GU/WmSfCo11COypGK
         03Xy4gMYgp3c5hLQYcA++km7MbdaAGNLr4WkIMJjRklLtKyNIaP94nDweokVM6CJZ911
         oNFMA5aNI127d8NrC7fsNLN2jr0YYFmtQhZw1t046AJQ0HF67JaoPK2gbBax52jMk+1x
         zUHqAT4g6TamsrZhqh2ehrV2DC5N7jzbrfY31x9WYpbnInSzRJ6kbPKCRbfjhHNLczDA
         u9kUF4ozsMFcfyVNhlvNhdBJqehcTYDHUZRUOgLAXbbQBkxAuvtm0QVIsQyRrT7dUUnX
         3RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642348; x=1698247148;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKf8GaX1o9f6WWK2vB+CbFj4C9pCegGrVSLQx7G2y0M=;
        b=X8wiDHboJIBDih3+1pgwAwZ57GM1jznqCb75VV1Vyb2/Nk5xVhK/JXJVy/P3D/7d4V
         LxyYm7i2AEG9zT2EILSz6diCZ5cZcoXqsMz5KSje7c18BhUU8G0568ggaI59yYSNAAB5
         vE5N780fpWczkx/zE1VZRS31nCKrDI8Or+aZV2ovO+G1psfW1LLtWO1+gOAKltrahpYq
         TTwDqOk335auseM0alhqTqAM8s+hJS+zH6KIiWM9SbGkC3ysX0hdA8FBwFG+3dTZrCcU
         Jd52wNMZNT8PVe9Y4n4cAayjppw38iX190gtAVXIq4+WVrYxcFNtCnqNEh7kGlO04+Mn
         NXfg==
X-Gm-Message-State: AOJu0YxDXTwE7gVdzeGUqxbpYjMCx4ZgXV1a+SLBjy5yeRj1CM1koYn6
        joJLGRwJTEq8uwdtfRiOH3Uq/D4fOPg=
X-Google-Smtp-Source: AGHT+IFzVOU51luGASB5uQCNgMK/kOtMd82lhexpSuoDtf9livm6SIy9kw5c8OYWxamwbZ/VoiOC/njkOwU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca97:0:b0:59b:c6bb:bab9 with SMTP id
 m145-20020a0dca97000000b0059bc6bbbab9mr127129ywd.3.1697642348422; Wed, 18 Oct
 2023 08:19:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 18 Oct 2023 08:19:06 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018151906.1841689-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Turn off KVM_WERROR by default for all configs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't enable KVM_WERROR by default for x86-64 builds as KVM's one-off
-Werror enabling is *mostly* superseded by the kernel-wide WERROR, and
enabling KVM_WERROR by default can cause problems for developers working
on other subsystems.  E.g. subsystems that have a "zero W=1 regressions"
rule can inadvertently build KVM with -Werror and W=1, and end up with
build failures that are completely uninteresting to the developer (W=1 is
prone to false positives, especially on older compilers).

Keep KVM_WERROR as there are combinations where enabling WERROR isn't
feasible, e.g. the default FRAME_WARN=1024 on i386 builds generates a
non-zero number of warnings and thus errors, and there are far too many
warnings throughout the kernel to enable WERROR with W=1 (building KVM
with -Werror is desirable (with a sane compiler) as W=1 does generate
useful warnings).

Opportunistically drop the dependency on !COMPILE_TEST as it's completely
meaningless (it was copied from i195's -Werror Kconfig), as the kernel's
WERROR is explicitly *enabled* for COMPILE_TEST=y kernel's, i.e. enabling
-Werror is obviosly not dependent on COMPILE_TEST=n.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20231006205415.3501535-1-kuba@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 950c12868d30..6cc0ea9cd91d 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -65,13 +65,13 @@ config KVM
 
 config KVM_WERROR
 	bool "Compile KVM with -Werror"
-	# KASAN may cause the build to fail due to larger frames
-	default y if X86_64 && !KASAN
-	# We use the dependency on !COMPILE_TEST to not be enabled
-	# blindly in allmodconfig or allyesconfig configurations
-	depends on KVM
-	depends on (X86_64 && !KASAN) || !COMPILE_TEST
-	depends on EXPERT
+	# Disallow KVM's -Werror if KASAN is enabled, e.g. to guard against
+	# randomized configs from selecting KVM_WERROR=y, which doesn't play
+	# nice with KASAN.  KASAN builds generates warnings for the default
+	# FRAME_WARN, i.e. KVM_WERROR=y with KASAN=y requires special tuning.
+	# Building KVM with -Werror and KASAN is still doable via enabling
+	# the kernel-wide WERROR=y.
+	depends on KVM && EXPERT && !KASAN
 	help
 	  Add -Werror to the build flags for KVM.
 

base-commit: 437bba5ad2bba00c2056c896753a32edf80860cc
-- 
2.42.0.655.g421f12c284-goog

