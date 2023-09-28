Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40907B0FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjI1AUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1AUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:20:01 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CB8F5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 17:19:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-27763c2c27dso8903143a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695860399; x=1696465199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIhlczPTAFSXJtuz0kr4uNehhoedtrBaBEaYSQ3/D3w=;
        b=mdqi3CV6ogd+sLjUE0adY1tjTK8dTH8aEdvxS0QxhkeHAFu0CEAbbBC4MFijtqP1Ly
         sjZTGe4VhUUb/M9MK4TbEOatIHvLNoIhsPHiP350mptcWfo4FF6STM6mL/vMFyLsSZyT
         X7mnnqlnhUEEmmE4L+2M7AdtXBciHMTjvxlqNP2WFYUccCbdj2AnNTB2KQ+x1ujJZcnr
         njQZL90vUj2nrWJOTZk4TWrwQ3bo5KBupnlCZ83mzkdvD6qdy+qZcubw71mooKyD+WTp
         KimIF/iFxfNWmiysn9zEBCwU46D+J9XKcW+HSFh4ADA1egulhRU8BSKJv9NvKUv5n9Gu
         T7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695860399; x=1696465199;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIhlczPTAFSXJtuz0kr4uNehhoedtrBaBEaYSQ3/D3w=;
        b=YhVPYa1IiTz8pkdR/tEePv7u4s2LVIPzLNP7ekqYDdhCLNxbCXBuM0fbN/9v0OetOv
         BDkpMUo3r3BywFcy4c/TCKkRZStALCRbUjEGH5DcLlZCsMO2yqW7NzRRDF5EEfzMN9HS
         BscIl8IhqlI6NNLHE52gNuMNLpmtAaj8fK1GhulHuS5q81LA6/9q/YUHblsnLfjje8t5
         9x34aqEUmYAlwcZUE17MHjqweeFjmQlnkjo1eA+HS9mP/lBEtJCWqt2zkgf0HAYzbSOG
         JQYbEop/GlJmGduTmnsUv+MMqgfnqoyynVRKnltpNS/+3joVexxbvVyrT5HSX5IyxuIf
         CNvg==
X-Gm-Message-State: AOJu0YxFaWz7LCWb1iVec/CLoTpWq1Tbrs7mYBR/R8SXjggD9nkB8Dqm
        yVTsEl89zvu0M6vP+7RcUTNIOCK0Qlo=
X-Google-Smtp-Source: AGHT+IGCbuN35ynl7FnkIb26JwfUSQivcI5ht12Lhq63ANf0P98cgnGB/yAMFxzlpCJU6VRv0zB+soGU8eE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:604:b0:1c0:d418:8806 with SMTP id
 kg4-20020a170903060400b001c0d4188806mr44172plb.12.1695860399477; Wed, 27 Sep
 2023 17:19:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Sep 2023 17:19:51 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928001956.924301-1-seanjc@google.com>
Subject: [PATCH 0/5] KVM: x86: Fix breakage in KVM_SET_XSAVE's ABI
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Tyler Stachecki <stachecki.tyler@gmail.com>,
        Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework how KVM limits guest-unsupported xfeatures to effectively hide
only when saving state for userspace (KVM_GET_XSAVE), i.e. to let userspace
load all host-supported xfeatures (via KVM_SET_XSAVE) irrespective of
what features have been exposed to the guest.

The effect on KVM_SET_XSAVE was knowingly done by commit ad856280ddea
("x86/kvm/fpu: Limit guest user_xfeatures to supported bits of XCR0"):

    As a bonus, it will also fail if userspace tries to set fpu features
    (with the KVM_SET_XSAVE ioctl) that are not compatible to the guest
    configuration.  Such features will never be returned by KVM_GET_XSAVE
    or KVM_GET_XSAVE2.

Peventing userspace from doing stupid things is usually a good idea, but in
this case restricting KVM_SET_XSAVE actually exacerbated the problem that
commit ad856280ddea was fixing.  As reported by Tyler, rejecting KVM_SET_XSAVE
for guest-unsupported xfeatures breaks live migration from a kernel without
commit ad856280ddea, to a kernel with ad856280ddea.  I.e. from a kernel that
saves guest-unsupported xfeatures to a kernel that doesn't allow loading
guest-unuspported xfeatures.

To make matters even worse, QEMU doesn't terminate if KVM_SET_XSAVE fails,
and so the end result is that the live migration results (possibly silent)
guest data corruption instead of a failed migration.

Patch 1 refactors the FPU code to let KVM pass in a mask of which xfeatures
to save, patch 2 fixes KVM by passing in guest_supported_xcr0 instead of
modifying user_xfeatures directly.

Patches 3-5 are regression tests.

I have no objection if anyone wants patches 1 and 2 squashed together, I
split them purely to make review easier.

Note, this doesn't fix the scenario where a guest is migrated from a "bad"
to a "good" kernel and the target host doesn't support the over-saved set
of xfeatures.  I don't see a way to safely handle that in the kernel without
an opt-in, which more or less defeats the purpose of handling it in KVM.

Sean Christopherson (5):
  x86/fpu: Allow caller to constrain xfeatures when copying to uabi
    buffer
  KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2}
  KVM: selftests: Touch relevant XSAVE state in guest for state test
  KVM: selftests: Load XSAVE state into untouched vCPU during state test
  KVM: selftests: Force load all supported XSAVE state in state test

 arch/x86/include/asm/fpu/api.h                |   3 +-
 arch/x86/kernel/fpu/core.c                    |   5 +-
 arch/x86/kernel/fpu/xstate.c                  |  12 +-
 arch/x86/kernel/fpu/xstate.h                  |   3 +-
 arch/x86/kvm/cpuid.c                          |   8 --
 arch/x86/kvm/x86.c                            |  37 +++---
 .../selftests/kvm/include/x86_64/processor.h  |  23 ++++
 .../testing/selftests/kvm/x86_64/state_test.c | 110 +++++++++++++++++-
 8 files changed, 168 insertions(+), 33 deletions(-)


base-commit: 5804c19b80bf625c6a9925317f845e497434d6d3
-- 
2.42.0.582.g8ccd20d70d-goog

