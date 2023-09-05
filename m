Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30577792A68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjIEQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350928AbjIEFFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49390CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 934EECE10A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC70C433C8;
        Tue,  5 Sep 2023 05:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890306;
        bh=BD3BaAX8xgtKJl99GW2gGHo4WFlWj3W64cI+MHUIFx0=;
        h=From:To:Cc:Subject:Date:From;
        b=p11JHm6ODjs55qeF6CQu1wmuACALq6ovVREZsXpBvazUgytaeyzYajjKMrU3ntKq7
         T+UxZ59v5pVrjdbN0Yo0nXjAew/3BWvN2lXpw5REqcrsvzOZ8mhB87LI2QoyZia6HF
         Yr5bFuPFpt2meVcr8+1Ne4VypcxlvsKjCEnnAgcrVZHgexL/KBYKsbExJxxgxt93db
         qLC0BnpoecGlXvxwrMyTe0xWB/wNdfjqn8sESkEzIFmFDXWSFowVBCRxxPSuLQvVaX
         u+gEu0aGETtxLgTxwKRGqX4Og8thB7R0U5ylOD9HcR6n046rBkewZjOy211m324oH1
         HwxhvyqTfl0Sw==
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
Subject: [PATCH v3 00/20] SRSO fixes/cleanups
Date:   Mon,  4 Sep 2023 22:04:44 -0700
Message-ID: <cover.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- drop kvm patches (to be picked up by Sean)
- fix "no microcode, no microcode" printk
- fix "Safe Ret" capitalization in documentation
- fix chopped line in commit log
- drop "x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check" patch

Josh Poimboeuf (20):
  x86/srso: Fix srso_show_state() side effect
  x86/srso: Set CPUID feature bits independently of bug or mitigation
    status
  x86/srso: Don't probe microcode in a guest
  x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
  x86/srso: Fix SBPB enablement for (possible) future fixed HW
  x86/srso: Print actual mitigation if requested mitigation isn't
    possible
  x86/srso: Print mitigation for retbleed IBPB case
  x86/srso: Fix vulnerability reporting for missing microcode
  x86/srso: Fix unret validation dependencies
  x86/alternatives: Remove faulty optimization
  x86/srso: Improve i-cache locality for alias mitigation
  x86/srso: Unexport untraining functions
  x86/srso: Remove 'pred_cmd' label
  x86/bugs: Remove default case for fully switched enums
  x86/srso: Move retbleed IBPB check into existing 'has_microcode' code
    block
  x86/srso: Disentangle rethunk-dependent options
  x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
  x86/retpoline: Remove .text..__x86.return_thunk section
  x86/nospec: Refactor UNTRAIN_RET[_*]
  x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()

 Documentation/admin-guide/hw-vuln/srso.rst |  24 ++-
 arch/x86/include/asm/nospec-branch.h       |  69 ++++-----
 arch/x86/include/asm/processor.h           |   2 -
 arch/x86/kernel/alternative.c              |   8 -
 arch/x86/kernel/cpu/amd.c                  |  28 ++--
 arch/x86/kernel/cpu/bugs.c                 | 102 ++++++------
 arch/x86/kernel/vmlinux.lds.S              |  10 +-
 arch/x86/lib/retpoline.S                   | 171 +++++++++++----------
 include/linux/objtool.h                    |   3 +-
 scripts/Makefile.vmlinux_o                 |   3 +-
 10 files changed, 201 insertions(+), 219 deletions(-)

-- 
2.41.0

