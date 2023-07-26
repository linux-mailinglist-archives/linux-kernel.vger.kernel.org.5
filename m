Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FCE7634D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjGZLZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGZLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:25:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63810FD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690370741; x=1721906741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KX6BIbniV4wusNAuM7J81MalluJ/zyXLCX2BddKZpYg=;
  b=GfaBgtfhyp4IIVvPeqaKj3VDtW0FkzhQi1E8dyGGmWjrQY20ahxST5qJ
   6Bn9qg10s/5lncdTWrQ8z+pdSQPr3PGMo3SK7Q5MZrfabcQWK44tBFM3y
   1sU73vZtrGnNiA6xtqqlYJXTDX3tbZyX2j5qq6sAyynp+bYosm7S/WFmz
   UuhNnEm59znqQbsvHh5bxwN77A8LH61+TrsJB3s+p65fuviz4aDBfu3RQ
   F60AGqrPmqzZgElGxlEmJ5YJueX5hB86FPAShKzZOI7rokeAbNapOWOO9
   hWj7lrFHy3nyXP/Bh8bokFgjL+Nx+4ELdQSdqw0C90l5c/6+yxJvI/9Gr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370663819"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="370663819"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791810874"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791810874"
Received: from bterry-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.177.246])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 04:25:37 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v3 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Date:   Wed, 26 Jul 2023 23:25:02 +1200
Message-ID: <cover.1690369495.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Kirill, all,

This series unifies the assembly code for TDCALL/SEAMCALL and TDVMCALL.
Now all of them use one singe TDX_MODULE_CALL asm macro.  More
information please see cover letter of v2 (see link below).

This version mainly addressed Peter's comment to add patch to adjust
'struct tdx_module_args' to match KVM's "vcpu::regs".

Tested by booting TDX guest, initializing TDX module, and running TDX
guest successfully, all with this series applied.

------- Histroy --------

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
  x86/virt/tdx: Allow SEAMCALL to handle #UD and #GP
  x86/virt/tdx: Adjust 'struct tdx_module_args' to use x86 "register
    index" layout

 arch/x86/Kconfig                  |  12 ++
 arch/x86/Makefile                 |   2 +
 arch/x86/boot/compressed/tdx.c    |   6 +-
 arch/x86/coco/tdx/tdcall.S        | 231 ++++--------------------------
 arch/x86/coco/tdx/tdx-shared.c    |  28 +++-
 arch/x86/coco/tdx/tdx.c           |  69 +++++----
 arch/x86/include/asm/shared/tdx.h |  92 +++++++-----
 arch/x86/include/asm/tdx.h        |  11 ++
 arch/x86/kernel/asm-offsets.c     |  33 ++---
 arch/x86/virt/Makefile            |   2 +
 arch/x86/virt/vmx/Makefile        |   2 +
 arch/x86/virt/vmx/tdx/Makefile    |   2 +
 arch/x86/virt/vmx/tdx/seamcall.S  |  61 ++++++++
 arch/x86/virt/vmx/tdx/tdxcall.S   | 227 ++++++++++++++++++++++-------
 14 files changed, 433 insertions(+), 345 deletions(-)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall.S


base-commit: 18b44bc5a67275641fb26f2c54ba7eef80ac5950
-- 
2.41.0

