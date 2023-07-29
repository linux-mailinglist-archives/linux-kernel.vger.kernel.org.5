Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DA767A08
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjG2As6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbjG2Asz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:48:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515513C1D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:48:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b13cso45410607b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591644; x=1691196444;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5aF32m9XD6myAo7sGEI3t+3k64lol49nBMU7las/wE=;
        b=0jJ/8t/XHDk0GXDV+9KRRZTnf547BRrRfdYX+rLg3ryp6eh0B1StTeloyrf4pGYC6M
         dd+FQuotdVV4LZFwElWuERXhxA9Yr03LUtYYletlby37BYng90IltFPGwsHLm6KWScbp
         klE3c84b1vWgnGlwC5iMwx+vB0M/rjyXYvVFmDeG2XeCEdKu+i3to7tRrLbmLq06aSEl
         v20Dyolsa+BPHKxTCV+tl+UwteoZyQ92qikE2uAufj4XkNAzy7vV+kowb4fTV4qOQAhD
         4TvDBYa2rJ+vE9zBxibj/r49UUxW7860mn+D52+R+PjgiGNLzXbUFXMGiR9kyrhwoDDS
         qUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591644; x=1691196444;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5aF32m9XD6myAo7sGEI3t+3k64lol49nBMU7las/wE=;
        b=W6v/K2Lh0hbQuEjB3iaT2rwXTvGPmuj/UFqpfbRzM964ct30jPAL1si1CyRjLSmuAZ
         nujT1F+2ISnUMtWVOgBos2WvsfuOLnQ9EWpgTnvzLmoPmQHiqxNjNqb391ioo2bYW2OA
         jG+C6/2PnJzFYdKZIPQk0s+j3CYsS1yfmvwKtZrnQX/E81GsNPvZKHWj81HvGwsT49Lp
         glLM6RMaWb5sThnL77u2urpEZcpZUWwDlIYmJi6z9M3VS4unvMylxAS4h00wtgIhHJAi
         kFizPeeCoA08+nn4vt1Llecn+XhlZ27P3tg4YcQnudqqjIcFbzhT9jb4w7WWUeOJQCmZ
         WN/g==
X-Gm-Message-State: ABy/qLbtMfCXZ1ooQBftCzWtjO881Rsl7OvNOSlUXzVFrKU59MJECebO
        BSpLkHaRku0Y1zAAyXLIptuIQRuuaco=
X-Google-Smtp-Source: APBJJlG1My05WiVFreMULfhBHDZ8pNOxsaD6PyBKYYQLfs98iNj5fQQD+L1euRxf++JbZKB0rJDKbgKdoao=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:1c47:0:b0:577:6462:24c3 with SMTP id
 c68-20020a811c47000000b00577646224c3mr35514ywc.4.1690591644467; Fri, 28 Jul
 2023 17:47:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:47:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729004722.1056172-1-seanjc@google.com>
Subject: [PATCH v3 00/12] KVM: x86/mmu: Clean up MMU_DEBUG and BUG/WARN usage
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consist of three loosely related miniseries:

 1. Remove the noisy prints buried behind MMU_DEBUG, and replace MMU_DEBUG
    with a KVM_PROVE_MMU Kconfig.

 2. Use WARN_ON_ONCE() for all runtime WARNs, i.e. avoid spamming the
    kernel log if something goes awry in the MMU.

 3. Demote BUG() usage in the shadow MMU to KVM_BUG_ON() when the kernel
    is built with CONFIG_BUG_ON_DATA_CORRUPTION=n.

v3:
 - Fix build errors related to is_empty_shadow_page (which the bot has
   told me about several times, and I managed to forget every other
   time...) [kernel test robot]

v2:
 - https://lore.kernel.org/all/20230721230006.2337941-1-seanjc@google.com
 - Collect a review. [Mingwei]
 - Call out the more obvious path to FNAME(walk_addr_generic) in patch 6. [David]
 - Use BUILD_BUG_ON_INVALID() for the stub. [David]

v1: https://lore.kernel.org/all/20230511235917.639770-1-seanjc@google.com

Mingwei Zhang (1):
  KVM: x86/mmu: Plumb "struct kvm" all the way to pte_list_remove()

Sean Christopherson (11):
  KVM: x86/mmu: Delete pgprintk() and all its usage
  KVM: x86/mmu: Delete rmap_printk() and all its usage
  KVM: x86/mmu: Delete the "dbg" module param
  KVM: x86/mmu: Avoid pointer arithmetic when iterating over SPTEs
  KVM: x86/mmu: Cleanup sanity check of SPTEs at SP free
  KVM: x86/mmu: Rename MMU_WARN_ON() to KVM_MMU_WARN_ON()
  KVM: x86/mmu: Convert "runtime" WARN_ON() assertions to WARN_ON_ONCE()
  KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode without PAE
    enabled
  KVM: x86/mmu: Replace MMU_DEBUG with proper KVM_PROVE_MMU Kconfig
  KVM: x86/mmu: Use BUILD_BUG_ON_INVALID() for KVM_MMU_WARN_ON() stub
  KVM: x86/mmu: BUG() in rmap helpers iff
    CONFIG_BUG_ON_DATA_CORRUPTION=y

 arch/x86/kvm/Kconfig            |  13 +++
 arch/x86/kvm/mmu/mmu.c          | 163 +++++++++++++-------------------
 arch/x86/kvm/mmu/mmu_internal.h |  14 +--
 arch/x86/kvm/mmu/page_track.c   |  16 ++--
 arch/x86/kvm/mmu/paging_tmpl.h  |  23 +++--
 arch/x86/kvm/mmu/spte.c         |   6 +-
 arch/x86/kvm/mmu/spte.h         |   8 +-
 arch/x86/kvm/mmu/tdp_iter.c     |   4 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  28 +++---
 include/linux/kvm_host.h        |  19 ++++
 10 files changed, 143 insertions(+), 151 deletions(-)


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0.487.g6d72f3e995-goog

