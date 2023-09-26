Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A637AE47F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjIZERw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjIZERm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:17:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8BCE5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695701852; x=1727237852;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=epOhnq7zfXp3PWOVTdgcK0JMdMi1yxPVOLpK7BUEN3k=;
  b=JFqW6TEO28vi13PGwecCQ/7bH8uT0IcsZySe7H2vQiywLoWh/rlnHmQI
   S5+pbCUckyEt+5DKLhLr0YirB3/Rczl7JAAU8mGSbLi3Zmm8uDu8NhO2X
   dnAQxy6PN1uwfHrTap/OSqq4Lqe+AOOOK5t/u/rbkw5cH4Jtqb4S9sZBF
   PmBLY6aNVlJfpsFn2eqep9ZoPUDf058EutEWsZzJjg3wFdVh0jI9GsKF3
   EO54Uh8uO1nTbXi8X58o+2c/hh6fgRtW5a8vx9JyCynJhJduiSmQwDrFw
   WRhKjPMwTjiiHbM6blMmpyqVDccPTDlpjk4Qy9Ayk/CxTCmRbMEiw8AwF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378757154"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="378757154"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838867786"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="838867786"
Received: from fvivekku-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.18.72])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 21:16:57 -0700
Subject: [PATCH v4 0/6] configfs-tsm: Attestation Report ABI
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Date:   Mon, 25 Sep 2023 21:16:56 -0700
Message-ID: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
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

Changes since v3: [1]:
- Combine configfs-tsm + sev-guest conversion with the tdx-guest
  extension
- Split PEM formatted certificate data to its own output attribute
  (Jeremi)
- Parse the sev-guest output payload and emit the raw report without the
  header (Jeremi)
- Drop @format as an input parameter and always request "extended"
  reports in the sev-guest case with certificate data optionally
  included (inspired by creation of separate @certs attribute)
- Drop usage of cleanup helpers in tdx_report_new() until
  mutex_lock_interruptible() grows a guard() helper in v6.7. (Daniel and
  Dave)
- Changelog grammar fixes for tdx-guest change (Kirill)
- Defer tdx-guest emitting its cert-chain through @certs pending
  question on output payload versioning (i.e. kernel should only support
  one). In the meantime zero-sized @certs is a valid output condition.

[1]: http://lore.kernel.org/r/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com
 
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

Kuppuswamy Sathyanarayanan (1):
      virt: tdx-guest: Add Quote generation support using TSM_REPORTS


 Documentation/ABI/testing/configfs-tsm  |   67 +++++
 MAINTAINERS                             |    8 +
 arch/x86/coco/tdx/tdx.c                 |   21 ++
 arch/x86/include/asm/shared/tdx.h       |    1 
 arch/x86/include/asm/tdx.h              |    2 
 drivers/virt/Kconfig                    |    6 
 drivers/virt/Makefile                   |    4 
 drivers/virt/coco/Kconfig               |   14 +
 drivers/virt/coco/Makefile              |    8 +
 drivers/virt/coco/sev-guest/Kconfig     |    1 
 drivers/virt/coco/sev-guest/sev-guest.c |  180 ++++++++++++--
 drivers/virt/coco/tdx-guest/Kconfig     |    1 
 drivers/virt/coco/tdx-guest/tdx-guest.c |  229 +++++++++++++++++
 drivers/virt/coco/tsm.c                 |  411 +++++++++++++++++++++++++++++++
 include/linux/slab.h                    |    2 
 include/linux/tsm.h                     |   63 +++++
 16 files changed, 992 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-tsm
 create mode 100644 drivers/virt/coco/Kconfig
 create mode 100644 drivers/virt/coco/Makefile
 create mode 100644 drivers/virt/coco/tsm.c
 create mode 100644 include/linux/tsm.h

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
