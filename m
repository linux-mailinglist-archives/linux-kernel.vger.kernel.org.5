Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4578E07E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjH3UVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjH3UAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:00:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5544718
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693424071; x=1724960071;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o93wNKer2be7oqO3RsMGZMQCNhI39E5QvgMKNtPbL8I=;
  b=Sqy05hHIu8uEHWxQCKv536vO34MKYgsAc/SGHLq5RldYqIq9zqlRaG1u
   vUDbA/pw1UpswGgp3vBJ/BbWqgb9/bhzazIeBEGt1T2i85di0bPquo6cd
   CSFfS8mnScZwVMbZWrvGocolU2XCZXTu+3nz89Yo7CpsPEhvJtT/II2za
   RDq0fxlDmPHFqrOpcEh26GOlZ/TIur6LxmjkbmOp1YlJbMGzKB/PplcZp
   FZHJmb9c7mfZpiG+vKLF25VuPFlNTACeKdD8UUavgqClIpYZX9FyDxZn0
   jx0DT1B2SujhJPFzhOxaNAGrfjbiKS2QHnniXofH+LlPDc7huFeIjbWFf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360723591"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="360723591"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 12:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="853844756"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="853844756"
Received: from nivakuma-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.238.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 12:33:12 -0700
Subject: [PATCH v3 0/5] configfs-tsm: Attestation Report ABI
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Date:   Wed, 30 Aug 2023 12:33:12 -0700
Message-ID: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that I am sending this during the merge window due to the high
level of interest. My current expectation, barring major review
concerns, is that this intercepts Linux-next soon after v6.6-rc1 for a
v6.7 merge. Given the switch to configfs I did not carry forward
Reviewed-by's from v2.

Changes since v2 [1]:
- Switch from sysfs to configfs to scale the interface for containers
  (Jeremi)
- Fix locking in outblob_read() to avoid racing freeing and generation
  of ->outblob (Jeremi)
- Add missing mutex to sev_report_new() (Jeremi)
- Fix incorrect usage of no_free_ptr(), switch to return_ptr() (Peter)
- Drop hex input parsing (configfs bin attributes are not seekable which
  eliminates the concern) (Greg)
- Note why DEFINE_FREE() for kvfree() includes a NULL check (Greg)
- Document the permissible values of privlevel in the ABI documentation
  (Greg)
- Bump column limit to 100 for sev-guest changes, since that's existing
  code, for tsm.c use the .clang_format default. (Tom)
- Drop report buffer size to 4K (Tom)
- Fix uninitialized variable @rc in register_tsm() (Tom)
- Fix collision detection confusion, always increment write_generation
  on successful write regardless if old data is being re-written (Tom)
- Switch to sockptr_t for sharing {get,get_ext}_report() between the
  ioctl and configfs paths (Andy)

[1]: http://lore.kernel.org/r/169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com

An attestation report is signed evidence of how a Trusted Virtual
Machine (TVM) was launched and its current state. A verifying party uses
the report to make judgements of the confidentiality and integrity of
that execution environment. Upon successful attestation the verifying
party may, for example, proceed to deploy secrets to the TVM to carry
out a workload. Multiple confidential computing platforms share this
similar flow.

The approach of adding adding new char devs and new ioctls, for what
amounts to the same logical functionality with minor formatting
differences across vendors [2], is untenable. Common concepts and the
community benefit from common infrastructure. 
 
Use configfs for this facility for maintainability compared to ioctl(),
and for its scalability compared to sysfs. Atomicity can be enforced at
item creation time, and a conflict detection mechanism is included for
scenarios where multiple threads may share a single configuration
instance.
 
[2]: http://lore.kernel.org/r/cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com

---

Dan Williams (5):
      virt: coco: Add a coco/Makefile and coco/Kconfig
      configfs-tsm: Introduce a shared ABI for attestation reports
      virt: sevguest: Prep for kernel internal {get,get_ext}_report()
      mm/slab: Add __free() support for kvfree
      virt: sevguest: Add TSM_REPORTS support for SNP_{GET,GET_EXT}_REPORT


 Documentation/ABI/testing/configfs-tsm  |   68 +++++
 MAINTAINERS                             |    8 +
 drivers/virt/Kconfig                    |    6
 drivers/virt/Makefile                   |    4
 drivers/virt/coco/Kconfig               |   14 +
 drivers/virt/coco/Makefile              |    8 +
 drivers/virt/coco/sev-guest/Kconfig     |    1
 drivers/virt/coco/sev-guest/sev-guest.c |  133 +++++++++--
 drivers/virt/coco/tdx-guest/Kconfig     |    1
 drivers/virt/coco/tsm.c                 |  391 +++++++++++++++++++++++++++++++
 include/linux/slab.h                    |    2
 include/linux/tsm.h                     |   54 ++++
 12 files changed, 665 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-tsm
 create mode 100644 drivers/virt/coco/Kconfig
 create mode 100644 drivers/virt/coco/Makefile
 create mode 100644 drivers/virt/coco/tsm.c
 create mode 100644 include/linux/tsm.h

base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
