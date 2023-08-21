Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA23782111
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjHUBTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHUBT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:19:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF749C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD63B61E8E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A369FC433C8;
        Mon, 21 Aug 2023 01:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692580767;
        bh=jArgxD7lzLNxdiulYTukUVJwbw7Th0G7hkO4belLIKY=;
        h=From:To:Cc:Subject:Date:From;
        b=NeQXpsaaApDsUbGcd5YYjmy88fLNXApFsOzdvBq4xztr7PHTLam72MvPAJQrKUnV7
         IeEASp8g2TDDJBjl3pvSrmNWi0zb1UkN02hB0k5v+efPROm6aPAaIyyBAEn8JP94Ru
         839pwh5iNMNZBOgxsmLxNcMdd9IlwrZ+gB3CKsng7ivaowUlZZ2ANIl4p1DIB2eHtB
         vMis+16jruzYH5M0ojZVs5VQGjtgWZrAyevoJq5vj85q4XwITK2wL/AqVHUIY2wrda
         ADmfgkVUF2P8WARSfUAxFpIoGDhtJf1Qgdm0hMS00EfBk4jO0/E/boB+ISlyyzWn8L
         SKydktjZoAD2w==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/22] SRSO fixes/cleanups
Date:   Sun, 20 Aug 2023 18:18:57 -0700
Message-ID: <cover.1692580085.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are several SRSO fixes and cleanups, based on tip/x86/urgent.

One of the patches also adds KVM support, though a corresponding patch
is still needed in QEMU.  I have a working QEMU patch which I can post
to qemu-devel.

Josh Poimboeuf (22):
  x86/srso: Fix srso_show_state() side effect
  x86/srso: Set CPUID feature bits independently of bug or mitigation
    status
  KVM: x86: Support IBPB_BRTYPE and SBPB
  x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
  x86/srso: Fix SBPB enablement for mitigations=off
  x86/srso: Print actual mitigation if requested mitigation isn't
    possible
  x86/srso: Remove default case in srso_select_mitigation()
  x86/srso: Downgrade retbleed IBPB warning to informational message
  x86/srso: Simplify exit paths
  x86/srso: Print mitigation for retbleed IBPB case
  x86/srso: Slight simplification
  x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check
  x86/srso: Fix vulnerability reporting for missing microcode
  x86/srso: Fix unret validation dependencies
  x86/alternatives: Remove faulty optimization
  x86/srso: Unexport untraining functions
  x86/srso: Disentangle rethunk-dependent options
  x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
  x86/srso: Improve i-cache locality for alias mitigation
  x86/retpoline: Remove .text..__x86.return_thunk section
  x86/nospec: Refactor UNTRAIN_RET[_*]
  x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()

 Documentation/admin-guide/hw-vuln/srso.rst |  22 ++-
 arch/x86/include/asm/nospec-branch.h       |  69 ++++-----
 arch/x86/include/asm/processor.h           |   2 -
 arch/x86/kernel/alternative.c              |   8 -
 arch/x86/kernel/cpu/amd.c                  |  28 ++--
 arch/x86/kernel/cpu/bugs.c                 |  87 +++++------
 arch/x86/kernel/vmlinux.lds.S              |  10 +-
 arch/x86/kvm/cpuid.c                       |   4 +
 arch/x86/kvm/x86.c                         |   9 +-
 arch/x86/lib/retpoline.S                   | 171 +++++++++++----------
 include/linux/objtool.h                    |   3 +-
 scripts/Makefile.vmlinux_o                 |   3 +-
 12 files changed, 199 insertions(+), 217 deletions(-)

-- 
2.41.0

