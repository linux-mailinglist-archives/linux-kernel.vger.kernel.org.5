Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD597DD975
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjKAAI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjKAAIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:08:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0AF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698797303; x=1730333303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0fAlQDu6TcG0IgowxLHEv4hAohadL2zveXEyNa++vZs=;
  b=Edpiwt6SJ3sJip7PAByyfJ+z3e1S97kW0v5eIT1IP9yvRz8i8ZxMZeXc
   XrzIqyidiAt5Dt2Wwx/GaBU4p0jL2GFBMc0/SCJFmueskmXQuN9r8Wpp1
   q98C5TaXgKo57GRstfdcbWVxuH3cDaSsUWqNUBORFUtHZ2NpK6m/jGpSx
   fGfI1Gs9kcUHy1gNKhMbMrgSkykSY1IwUicbsojJZv5mFjWMUYl6zBydl
   NxrihoyPnhLbpHMjnhkj3NzXzOMvWhEr3MNTET+V6Qz1dgnBbCAu8sSA0
   v62WaDGiiuqz8V0qsqVMU7kARnEJT5BWe8EEiS+Gocr+dePf5RiCU0Vtz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="9933860"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="9933860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 17:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754298707"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="754298707"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2023 17:08:22 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.7
Date:   Tue, 31 Oct 2023 17:07:55 -0700
Message-Id: <20231101000755.4183137-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/tdx changes for 6.7.

The majority of this is a rework of the assembly and C wrappers that
are used to talk to the TDX module and VMM.  This is a nice cleanup in
general but is also clearing the way for using this code when Linux is
the TDX VMM.

There are also some tidbits to make TDX guests play nicer with Hyper-V
and to take advantage the hardware TSC.

--

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.7

for you to fetch changes up to 9ee4318c157b9802589b746cc340bae3142d984c:

  x86/tdx: Mark TSC reliable (2023-10-06 10:00:04 -0700)

----------------------------------------------------------------
 * Refactor and clean up TDX hypercall/module call infrastructure
 * Handle retrying/resuming page conversion hypercalls
 * Make sure to use the (shockingly) reliable TSC in TDX guests

----------------------------------------------------------------
Dexuan Cui (1):
      x86/tdx: Retry partially-completed page conversion hypercalls

Kai Huang (12):
      x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro
      x86/tdx: Skip saving output regs when SEAMCALL fails with VMFailInvalid
      x86/tdx: Make macros of TDCALLs consistent with the spec
      x86/tdx: Rename __tdx_module_call() to __tdcall()
      x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure
      x86/tdx: Extend TDX_MODULE_CALL to support more TDCALL/SEAMCALL leafs
      x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL
      x86/tdx: Reimplement __tdx_hypercall() using TDX_MODULE_CALL asm
      x86/tdx: Remove 'struct tdx_hypercall_args'
      x86/virt/tdx: Wire up basic SEAMCALL functions
      x86/virt/tdx: Make TDX_MODULE_CALL handle SEAMCALL #UD and #GP
      x86/tdx: Fix __noreturn build warning around __tdx_hypercall_failed()

Kirill A. Shutemov (1):
      x86/tdx: Mark TSC reliable

 arch/x86/Kconfig                  |  12 ++
 arch/x86/Makefile                 |   2 +
 arch/x86/boot/compressed/tdx.c    |   6 +-
 arch/x86/coco/tdx/tdcall.S        | 234 +++++---------------------------------
 arch/x86/coco/tdx/tdx-shared.c    |  28 ++++-
 arch/x86/coco/tdx/tdx.c           | 138 +++++++++++++++-------
 arch/x86/hyperv/ivm.c             |  10 +-
 arch/x86/include/asm/shared/tdx.h |  89 +++++++++------
 arch/x86/include/asm/tdx.h        |  11 ++
 arch/x86/kernel/asm-offsets.c     |  33 +++---
 arch/x86/virt/Makefile            |   2 +
 arch/x86/virt/vmx/Makefile        |   2 +
 arch/x86/virt/vmx/tdx/Makefile    |   2 +
 arch/x86/virt/vmx/tdx/seamcall.S  |  61 ++++++++++
 arch/x86/virt/vmx/tdx/tdxcall.S   | 226 +++++++++++++++++++++++++++---------
 tools/objtool/noreturns.h         |   1 +
 16 files changed, 491 insertions(+), 366 deletions(-)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S
