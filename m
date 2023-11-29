Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778297FE394
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjK2WtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2WtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:49:13 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA226131
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1b2153ba1so5885807b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701298159; x=1701902959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQGfKgLsWbH5boPzhPSVcXAwo8BdoBCKDSp6PZpEKdw=;
        b=zJLBm2z9mHwup210q5dz0tBNXPFt0BVAYjuuQqQXcvyn5wDKpaNkyDHhcm8MsN4ZnW
         TToqv9GcGtBaHlxh+6jAK3rzvl9VRVMh3feUt9hRwH0+3UqXP7TpNwfm2X0LdNV8yD9Y
         CkbCkxj4nz2so/XBELHFUqK+Zs3vKduGnpY/cvdoRRahwiM5PHexh4sLXRLHTgjZqKP5
         70OR/iS2PqH3tgPmjd3w1VxNehr3Qza4XpGKMsZY6jhCN/CubiK+MkChZ4H/VAfplJoi
         vqsDBgNGTWkpjo3o01RjfQJsXYBvdbnOfS5ZHs14sbrquiUFFuLnTMNLlSg1js4YFIY8
         SA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701298159; x=1701902959;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQGfKgLsWbH5boPzhPSVcXAwo8BdoBCKDSp6PZpEKdw=;
        b=FkTxFCOwvEdZD+ssoNP35ImgvZKkHqnwFEaCTPv4SWPHcXPSS/LAq5v3JKOCMlJ4iF
         KZ7srsflt8NOEnoSiCi4Npig92NT9eqHXC3ncvogXI/a6iQBwX9C5B65hE5pG6mpIw9T
         hXPK87s1y3PWSkBJUtM1tH75nhLEPrECYoC4RV2VaukFJKIx06lUmKRFTFEx6jf4KUJH
         3QqWvH9NJnQqCE6nZd53aaCp20rl7YjHnG9VQdNS/lf56SomHW9HMmA97Zf05xqk2iL8
         0iNTmXomr3HF+nTF4JHScFzlTLSB71rlzpJDBYQ55WmY+8KB6iDkfETnZ9i07GNQtkfA
         T7/Q==
X-Gm-Message-State: AOJu0Yws95bCaxeqktT7VPw/Wft/JIS1a4RGKaH4kQYZPhIPaeeRKK2M
        WXMN/yUmxQw+7kRJAATVBzD4ARMxNdo=
X-Google-Smtp-Source: AGHT+IGsUSjfvRWUpviDYQXPdAuM4jG73OOk44zgfo4+QQBkUpvCVmZ+QUiwISRihsjSPP2r8hQPZ78ZMSg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3608:b0:5c5:bc62:9734 with SMTP id
 ft8-20020a05690c360800b005c5bc629734mr654018ywb.9.1701298159181; Wed, 29 Nov
 2023 14:49:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Nov 2023 14:49:12 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129224916.532431-1-seanjc@google.com>
Subject: [PATCH v2 0/4] KVM: selftests: Annotate guest printfs as such
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
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

Fix a handful of broken guest assert/printf messages, and annotate guest
ucall, printf, and assert helpers with __printf() so that such breakage is
detected by the compiler.

v2:
 - Annotate the relevant helpers. [Maxim]
 - Fix all other warnings (v1 fixed only the MWAIT error message)

v1: https://lore.kernel.org/all/20231107182159.404770-1-seanjc@google.com

Sean Christopherson (4):
  KVM: selftests: Fix MWAIT error message when guest assertion fails
  KVM: selftests: Fix benign %llx vs. %lx issues in guest asserts
  KVM: selftests: Fix broken assert messages in Hyper-V features test
  KVM: selftests: Annotate guest ucall, printf, and assert helpers with
    __printf()

 tools/testing/selftests/kvm/include/test_util.h        |  2 +-
 tools/testing/selftests/kvm/include/ucall_common.h     |  7 ++++---
 tools/testing/selftests/kvm/set_memory_region_test.c   |  6 +++---
 tools/testing/selftests/kvm/x86_64/hyperv_features.c   | 10 +++++-----
 .../testing/selftests/kvm/x86_64/monitor_mwait_test.c  |  6 ++++--
 .../kvm/x86_64/private_mem_conversions_test.c          |  2 +-
 .../selftests/kvm/x86_64/svm_nested_soft_inject_test.c |  4 ++--
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c |  2 +-
 tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c   |  8 ++++----
 9 files changed, 25 insertions(+), 22 deletions(-)


base-commit: 6803fb00772cc50cd59a66bd8caaee5c84b13fcf
-- 
2.43.0.rc1.413.gea7ed67945-goog

