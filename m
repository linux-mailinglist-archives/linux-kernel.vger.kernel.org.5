Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403475AE57
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGTM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGTM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:28:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6DA2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856129; x=1721392129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z6fFaWi1fEzRPDDKnm4TuRUQHUQ8WEN4MmJ/7EluZUY=;
  b=j7JpQN2FB2SBVnpIBlpER02HB9Nuw44ZuOLIf/8qQN2vdCZFDbdYXwPq
   W2n1DqRdw8yfjUymHBR0oOZ93It3h/XkM2N/wSDf434wTzVdIcwq6CO2U
   zCiLb+mdDSDF+UAj/ydNs/8qC3knINdVYu8oznjKmvXox0qqGW5h8Iw/n
   Sai/yLAGN/V6R7X1swFOHRDZ5qB5lqS4wFsi0yGNOt1FNVeZMSoLSoMzq
   D7F8MPhZJolpbyrd8Wqa02KAiNqdQDRvEqObXgv67WUW/G0SGDe8vzYQv
   KrlZZ4Mq6IgSERQPoVOFnEZzIbXssmMgW2dq+axcY2Tc4tMPQGqgUjXhQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356677908"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356677908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255832"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255832"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:28:45 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Date:   Fri, 21 Jul 2023 00:28:03 +1200
Message-ID: <cover.1689855280.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Kirill, all,

This series unifies the assembly code for TDCALL/SEAMCALL and TDVMCALL.
Now all of them use one singe TDX_MODULE_CALL asm macro.

With this series, I have verified the TDX guest can boot successfully
and the TDX module can also be initialized successfully.

The last two patches are SEAMCALL patches that are needed for TDX host
patchset.  They are not mandatory to be here though, i.e., can be in the
TDX host support series.  I put them here so we can have a complete view
how TDCALL/SEAMCALL and TDVMCALL are implemented.

Could you help to review?  Thanks in advance.

(Removed KVM list -- Sean/Paolo/Isaku are still CC'ed.)

------- Histroy --------

v1 -> v2:
 - Rebased to 6.5-rc2.
 - Fixed comments from Peter and others.
 - Split patch "x86/tdx: Unify TDX_HYPERCALL and TDX_MODULE_CALL assembly"
   into three smaller patches for better review.
 - A new patch to skip saving output registers when SEAMCALL fails due to
   VMFailInvalid.  
 - Removed patch "x86/tdx: Use cmovc to save a label in TDX_MODULE_CALL asm"
 - Merged patch "x86/tdx: Move FRAME_BEGIN/END to TDX_MODULE_CALL asm macro"
   to the new patch mentioned above.

v1: https://lore.kernel.org/lkml/b95c4169-88c8-219e-87b7-6c4e058c246a@suse.com/T/


Kai Huang (11):
  x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro
  x86/tdx: Skip saving output regs when SEAMCALL fails with
    VMFailInvalid
  x86/tdx: Make macros of TDCALLs consistent with the spec
  x86/tdx: Rename __tdx_module_call() to __tdcall()
  x86/tdx: Pass TDCALL/SEAMCALL input/output registers via a structure
  x86/tdx: Extend TDX_MODULE_CALL to support more TDCALL/SEAMCALL leafs
  x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL
  x86/tdx: Reimplement __tdx_hypercall() using TDX_MODULE_CALL asm
  x86/tdx: Remove 'struct tdx_hypercall_args'
  x86/virt/tdx: Wire up basic SEAMCALL functions
  x86/virt/tdx: Allow SEAMCALL to handle #UD and #GP

 arch/x86/Kconfig                  |  12 ++
 arch/x86/Makefile                 |   2 +
 arch/x86/boot/compressed/tdx.c    |   6 +-
 arch/x86/coco/tdx/tdcall.S        | 231 ++++--------------------------
 arch/x86/coco/tdx/tdx-shared.c    |  28 +++-
 arch/x86/coco/tdx/tdx.c           |  73 +++++-----
 arch/x86/include/asm/shared/tdx.h |  83 ++++++-----
 arch/x86/include/asm/tdx.h        |  10 ++
 arch/x86/kernel/asm-offsets.c     |  33 ++---
 arch/x86/virt/Makefile            |   2 +
 arch/x86/virt/vmx/Makefile        |   2 +
 arch/x86/virt/vmx/tdx/Makefile    |   2 +
 arch/x86/virt/vmx/tdx/seamcall.S  |  42 ++++++
 arch/x86/virt/vmx/tdx/tdxcall.S   | 227 ++++++++++++++++++++++-------
 14 files changed, 406 insertions(+), 347 deletions(-)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0

