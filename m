Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB5577CB69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjHOLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjHOLCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80719198E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097339; x=1723633339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=draGYETpsFJyGf5smNwqJuwaqJ7R6uigOE1JPNrhNKE=;
  b=ZhBGIgyTU8hzmfGMyaQLpDRFOQptNg1LxgpHmkwXmbgNJx2fdP5pns5B
   BLNziSDt1YDDQOCgkwXEfBsyIwtHyl0P+5BzYy//IXrv2KebVd5X6m1VF
   AfIrU6BrfeknsDm51pNhwpyaNQRediAhjU3dRmX+ic26ALEScycG0yKE2
   MWSlD6R4W4G6V1BdXPwqVL4vTOySLK0v7nhSzGEvvzhfm646iUi8eZ651
   rSNDAgonRsvODuOwE8XSvitaJIQsc3fu8OHsgJpc9dINLFYmeXnQjYH1h
   WfG9rToCip17UL9Wrv72HLWTdSI+M5jlsQRpAQjgppENNCE7bvzoDGCQo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436148228"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436148228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763236087"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763236087"
Received: from fwafula-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.73.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:15 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Date:   Tue, 15 Aug 2023 23:01:54 +1200
Message-ID: <cover.1692096753.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Kirill,

This series unifies the assembly code for TDCALL/SEAMCALL and TDVMCALL.
Now all of them use one singe TDX_MODULE_CALL asm macro.  More
information please see cover letter of v2 (see link below).

Tested by booting TDX guest, initializing TDX module, and running TDX
guest successfully, all with this series applied.

------- Histroy --------

v3 -> v4:

 - Addressed Kirill's minor comments
 - Collected Reviewed-by tags from Kirill/Sathy.
 - Collected Isaku's Tested-by tag.
 - Removed unneeded header file inclusion in tdcall.S in the relevant
   two patches.
 - Rebased to latest tip/x86/tdx (v6.5-rc5).

v3: https://lore.kernel.org/lkml/20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name/T/

v2 -> v3:

 - New patch (patch 12) to adjust 'struct tdx_module_args' layout to
   match KVM's "vcpu::regs[]" for VP.ENTER. (Peter)
 - Added __seamcall_saved_ret() wrapper to support VP.ENTER (merged to
   patch 10).
 - Fixed a 'noinstr' check build regression found by LKP (patch 7).
 - Rebased to latest Linus's tree (6.5-rc3 + 2 commits).

v2: https://lore.kernel.org/lkml/a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com/T/

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



Kai Huang (12):
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
  x86/virt/tdx: Make TDX_MODULE_CALL handle SEAMCALL #UD and #GP
  x86/virt/tdx: Adjust 'struct tdx_module_args' to use x86 "register
    index" layout

 arch/x86/Kconfig                  |  12 ++
 arch/x86/Makefile                 |   2 +
 arch/x86/boot/compressed/tdx.c    |   6 +-
 arch/x86/coco/tdx/tdcall.S        | 234 ++++--------------------------
 arch/x86/coco/tdx/tdx-shared.c    |  28 +++-
 arch/x86/coco/tdx/tdx.c           |  71 +++++----
 arch/x86/include/asm/shared/tdx.h |  92 +++++++-----
 arch/x86/include/asm/tdx.h        |  11 ++
 arch/x86/kernel/asm-offsets.c     |  33 ++---
 arch/x86/virt/Makefile            |   2 +
 arch/x86/virt/vmx/Makefile        |   2 +
 arch/x86/virt/vmx/tdx/Makefile    |   2 +
 arch/x86/virt/vmx/tdx/seamcall.S  |  61 ++++++++
 arch/x86/virt/vmx/tdx/tdxcall.S   | 230 ++++++++++++++++++++++-------
 14 files changed, 435 insertions(+), 351 deletions(-)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S


base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
-- 
2.41.0

