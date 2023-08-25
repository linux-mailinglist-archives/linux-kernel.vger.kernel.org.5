Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B3F787D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjHYBg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjHYBg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:36:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0D10F4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:36:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d746edab033so1240872276.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 18:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692927384; x=1693532184;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3zKt0MSpQclXBzb3GHTTMkVjfa1MlJje7RSqdsS9KA=;
        b=sdZ0hDVV6OpJhXoT4TMLcD236897knP6OAt7jC5eFB/d2aQzF4z3DpU+hS9VIz2p03
         lyPKTy+9M+sdnOOP4q190P8u+rHOHy4s1hzu7ixUFL16i+PRvhH3nyNEWxgvD4OZTN0o
         oG9AZ/Di/j7HEnx6KWgHeOXkZvtHwdUacGpRj/d+rLMm8+EasCRVr8wApZdVoasfhJFK
         x1811Rjdbd81K8IYIaTLwIhv1bwrCOnAxp370B6C1agQ+i5ymh4Yv2/Ih1/IXyPB9wjt
         nQEYSGJwpGL8wNOChn33OWOX3A/KmwI3jZAlBVEREAEq4gs6zQU8idqY2tXMdxB0M9V/
         81OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692927384; x=1693532184;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3zKt0MSpQclXBzb3GHTTMkVjfa1MlJje7RSqdsS9KA=;
        b=TyJ6/bxwwlu7GdwyUuNHbw0B1mZjNPcR4J/pTBcQd8+o0EIqJO2PZ/GWToh4kEGICg
         j6t35VUojPvcYEqDNJ7FTTBcDLb243yeHj5hjhehWYhxspVLftv63LmzmqaO6MMzvCsL
         3Ba9W7YAM3oBM2PUP4k1MMAT3z65YHBasF4RaXRLT1Vn1rfD6wz2k5/BoVrPuogO+LE4
         44UsF3JL6MFQ3oXb8CC+kruQXxYAyom/Uc5MnZ+F2QuVAljYPBYm2BwLX8wf/Sweah9A
         CLwNDOPl8xTjkuKPXzJ2x9eHkCohLLQmlDao55mSfIQKOuKNGJ60h4mNSEqNYaAFxIBs
         x82Q==
X-Gm-Message-State: AOJu0YyOUKhXWhC9oCDoSRpGJ3FK/SdxAdbtNL3UaEylV1uVnaDLElLU
        ZFTBVdTPHoy3yOavvvrzp3SWuje1CFY=
X-Google-Smtp-Source: AGHT+IEXejuR0vceKiPsiDxDwzOKvz+JnJ9kn9Jn5NJ04gxbtZY0NPLJjUHgZpzGgLAju1hMve4TXSMtFYM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e6cf:0:b0:d78:28d0:15bc with SMTP id
 d198-20020a25e6cf000000b00d7828d015bcmr94493ybh.4.1692927383859; Thu, 24 Aug
 2023 18:36:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Aug 2023 18:36:17 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230825013621.2845700-1-seanjc@google.com>
Subject: [PATCH v2 0/4] KVM: SVM: Fix unexpected #UD on INT3 in SEV guests
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Zongyo <wuzongyo@mail.ustc.edu.cn>,
        Tom Lendacky <thomas.lendacky@amd.com>
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

Fix a bug where KVM injects a bogus #UD for SEV guests when trying to skip
an INT3 as part of re-injecting the associated #BP that got kinda sorta
intercepted due to a #NPF occuring while vectoring/delivering the #BP.

Patch 1 is the main fix.  It's a little ugly, but suitable for backporting.

Patch 2 is a tangentially related cleanup to make NRIPS a requirement for
enabling SEV, e.g. so that we don't ever get "bug" reports of SEV guests
not working when NRIPS is disabled.

Patches 3 and 4 clean up the hack from patch 1, but are most definitely
not stable material (hence the slightly ugly fix).

Verified the original bug by toggling the NX hugepage mitigation to force
a #NPF when devliering #BP in the guest.

v2:
 - Actually fix the bug. [Tom]
 - Do the bigger cleanup I avoided in v1.

v1: https://lore.kernel.org/all/20230810234919.145474-1-seanjc@google.com

Sean Christopherson (4):
  KVM: SVM: Don't inject #UD if KVM attempts to skip SEV guest insn
  KVM: SVM: Require nrips support for SEV guests (and beyond)
  KVM: x86: Refactor can_emulate_instruction() return to be more
    expressive
  KVM: SVM: Treat all "skip" emulation for SEV guests as outright
    failures

 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  4 +--
 arch/x86/kvm/svm/sev.c             |  2 +-
 arch/x86/kvm/svm/svm.c             | 55 +++++++++++++++++-------------
 arch/x86/kvm/svm/svm.h             |  1 +
 arch/x86/kvm/vmx/vmx.c             | 12 +++----
 arch/x86/kvm/x86.c                 | 22 ++++++++----
 7 files changed, 58 insertions(+), 40 deletions(-)


base-commit: fff2e47e6c3b8050ca26656693caa857e3a8b740
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

