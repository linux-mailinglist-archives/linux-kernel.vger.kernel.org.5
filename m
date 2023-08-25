Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027E6788077
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHYHCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbjHYHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC98E6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E684562C89
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAD8C433C8;
        Fri, 25 Aug 2023 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946922;
        bh=UBJmLcWAydNk4AsVk/2V5lnKNBOxuN5coNe2xiTdpmE=;
        h=From:To:Cc:Subject:Date:From;
        b=Yk3TlyDSqvvG0RtWoJYkLm56VSSKYsZM1o91S0t4//6I9SvsKa2Qn67myCwx/LtIY
         u49BTdOoFedPgK2hB9tS4wGJSPGNSiGqslXBVRkLnpMRXyM65Qg6pRPdZ2Jal3dpyq
         bQXmW/E7vC1/zbHCErg1To98Hez0Lga9+yu10MtMzRNHr7TuSFikVILkYWXN3Lgv4m
         SVHX2KjVTIMXlnp0rwOIY9k0CnwMZHAnC6szQFu2ujow6mOcHhDtVtkAIBUE++eCEy
         /NzHgl1hGWLwEJNzCTRZJNrnQKFupVg24+B7kYbBwY/fGl/XlSAiyy0BJrRMBZuXDU
         F8dHEv+OrBLog==
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
Subject: [PATCH v2 00/23] SRSO fixes/cleanups
Date:   Fri, 25 Aug 2023 00:01:31 -0700
Message-ID: <cover.1692919072.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- reorder everything: fixes/functionality before cleanups
- split up KVM patch, add Sean's changes
- add patch to support live migration
- remove "default:" case for enums throughout bugs.c
- various minor tweaks based on v1 discussions with Boris
- add Reviewed-by's

Josh Poimboeuf (23):
  x86/srso: Fix srso_show_state() side effect
  x86/srso: Set CPUID feature bits independently of bug or mitigation
    status
  x86/srso: Don't probe microcode in a guest
  KVM: x86: Add IBPB_BRTYPE support
  KVM: x86: Add SBPB support
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
  x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check
  x86/srso: Disentangle rethunk-dependent options
  x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
  x86/retpoline: Remove .text..__x86.return_thunk section
  x86/nospec: Refactor UNTRAIN_RET[_*]
  x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()

 Documentation/admin-guide/hw-vuln/srso.rst |  22 ++-
 arch/x86/include/asm/nospec-branch.h       |  69 ++++-----
 arch/x86/include/asm/processor.h           |   2 -
 arch/x86/kernel/alternative.c              |   8 -
 arch/x86/kernel/cpu/amd.c                  |  28 ++--
 arch/x86/kernel/cpu/bugs.c                 | 104 ++++++-------
 arch/x86/kernel/vmlinux.lds.S              |  10 +-
 arch/x86/kvm/cpuid.c                       |   5 +-
 arch/x86/kvm/cpuid.h                       |   3 +-
 arch/x86/kvm/x86.c                         |  29 +++-
 arch/x86/lib/retpoline.S                   | 171 +++++++++++----------
 include/linux/objtool.h                    |   3 +-
 scripts/Makefile.vmlinux_o                 |   3 +-
 13 files changed, 230 insertions(+), 227 deletions(-)

-- 
2.41.0

