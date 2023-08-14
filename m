Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED8277B2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjHNHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjHNHnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:43:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91BC115
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691998990; x=1723534990;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TwoF5fq59lRt7vlTdgDePaChbL1k3CWvyUQLNnCPZ/s=;
  b=PChgSSfFONf5HgCMJjgsaKJywC7ChfzxxMIdjYPwhbZgq+PIDtxf2w/F
   XSvHeEZN2ZaClinOe+Z2u4qqQlqbquKZIYd1T1DZBikhvEAFJFHVkhUqw
   v7qTNQIG41SMhWPNA2b7oSyXMjK3S0bdIxNGd4ws0/omgQkdUuEWGnyod
   iRx2qQNZEWqN3e6VWIxImgiu2X/nM3cL8tvOWxTpppdkO2cflAL163U33
   /7hrNMJfKMhgjVAY0e3HR5CGXsjCij2tKGNUkl6vqTHYjSFFunPwc1NCb
   g7VAjCkr0SkoteeHG/pi9rG8QyuuUSbM6ikx2ftdLlEpYsBMi9/HakH6f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="370882719"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="370882719"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="736445226"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="736445226"
Received: from navanban-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.127.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:09 -0700
Subject: [PATCH v2 0/5] tsm: Attestation Report ABI
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 00:43:09 -0700
Message-ID: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
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

Changes since v1:
- Switch from Keyring to sysfs (James)

An attestation report is signed evidence of how a Trusted Virtual
Machine (TVM) was launched and its current state. A verifying party uses
the report to make judgements of the confidentiality and integrity of
that execution environment. Upon successful attestation the verifying
party may, for example, proceed to deploy secrets to the TVM to carry
out a workload. Multiple confidential computing platforms share this
similar flow.

The approach of adding adding new char devs and new ioctls, for what
amounts to the same logical functionality with minor formatting
differences across vendors [1], is untenable. Common concepts and the
community benefit from common infrastructure.

Use sysfs for this facility for maintainability compared to ioctl(). The
expectation is that this interface is a boot time, configure once, get
report, and done flow. I.e. not something that receives ongoing
transactions at runtime. However, runtime retrieval is not precluded and
a mechanism to detect potential configuration conflicts from
multiple-threads using this interface is included.

The keyring@ list is dropped on this posting since a new key-type is no
longer being pursued.

Link: http://lore.kernel.org/r/cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com

---

Dan Williams (5):
      virt: coco: Add a coco/Makefile and coco/Kconfig
      tsm: Introduce a shared ABI for attestation reports
      virt: sevguest: Prep for kernel internal {get,get_ext}_report()
      mm/slab: Add __free() support for kvfree
      virt: sevguest: Add TSM_REPORTS support for SNP_{GET,GET_EXT}_REPORT


 Documentation/ABI/testing/sysfs-class-tsm |   47 +++++
 MAINTAINERS                               |    8 +
 drivers/virt/Kconfig                      |    6 -
 drivers/virt/Makefile                     |    4 
 drivers/virt/coco/Kconfig                 |   13 +
 drivers/virt/coco/Makefile                |    8 +
 drivers/virt/coco/sev-guest/Kconfig       |    1 
 drivers/virt/coco/sev-guest/sev-guest.c   |  129 ++++++++++++-
 drivers/virt/coco/tdx-guest/Kconfig       |    1 
 drivers/virt/coco/tsm.c                   |  290 +++++++++++++++++++++++++++++
 include/linux/slab.h                      |    2 
 include/linux/tsm.h                       |   45 +++++
 12 files changed, 535 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/Kconfig
 create mode 100644 drivers/virt/coco/Makefile
 create mode 100644 drivers/virt/coco/tsm.c
 create mode 100644 include/linux/tsm.h

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
