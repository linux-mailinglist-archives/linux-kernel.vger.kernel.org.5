Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AC7BA1B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbjJEOn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbjJEOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD46604
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514676; x=1728050676;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZXJ1Loo2clcYjSHbu/5/7ENvQ/32ZeG1I2EOrnfZPoM=;
  b=F/BN4COZSPKyMUubEacf2SietLnUenHSrYUCGYR+umuWiLh92XrKhpP6
   x2j9oXbMp3URXh/H/CTlljUm9RmX0UXRnzRuAeE3dUpSVyly/YGudDe6a
   PIpj4Tss1CiR3i39I4VpC09bHjcj178hgwsEaRjOrtCRHmTVD9YhA/BcR
   X8Nux3mh7rcNlfTqMPQh0yrr7XwQ+Qscuh2QswvqTs2MWfD1wZ5JvweM2
   ey1KK0mBCfE8CEeux9Hjp25ZC02SZa7+2p9vQzhuqzxP6Ahq7wygRUxov
   k654xCHQugX/+ynOYxgct4pl8uViASPGSHvOB5TPPetl5y3Aku0MX4T4l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380767054"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380767054"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="728449203"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728449203"
Received: from skwasnia-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.222.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:16 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 0F3D410A12D; Thu,  5 Oct 2023 16:14:14 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 00/13] x86/tdx: Add kexec support
Date:   Thu,  5 Oct 2023 16:13:49 +0300
Message-ID: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds bits and pieces to get kexec (and crashkernel) work on
TDX guest.

They bring kexec support to the point when we can start the new kernel,
but it will only be able to use single CPU. It should be enough to cover
the most common case: crashkernel.

The last patch implements CPU offlining according to the approved ACPI
spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
kernel.

Please review. I would be glad for any feedback.

[1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher

Kirill A. Shutemov (13):
  x86/acpi: Extract ACPI MADT wakeup code into a separate file
  kernel/cpu: Add support for declaring CPU hotplug not supported
  cpu/hotplug, x86/acpi: Disable CPU hotplug for ACPI MADT wakeup
  x86/kvm: Do not try to disable kvmclock if it was not enabled
  x86/kexec: Keep CR4.MCE set during kexec for TDX guest
  x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
  x86/mm: Return correct level from lookup_address() if pte is none
  KVM: x86: Add config option to gate emergency virt callback support
  x86/tdx: Account shared memory
  x86/tdx: Convert shared memory back to private on kexec
  x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
  x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
  x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method

 arch/x86/Kconfig                     |   8 +
 arch/x86/coco/core.c                 |   1 -
 arch/x86/coco/tdx/kexec.c            |   0
 arch/x86/coco/tdx/tdx.c              | 220 +++++++++++++++++++++-
 arch/x86/hyperv/ivm.c                |   9 +-
 arch/x86/include/asm/acpi.h          |   5 +
 arch/x86/include/asm/pgtable_types.h |   1 +
 arch/x86/include/asm/reboot.h        |   4 +-
 arch/x86/include/asm/x86_init.h      |   4 +-
 arch/x86/kernel/acpi/Makefile        |  11 +-
 arch/x86/kernel/acpi/boot.c          |  88 +--------
 arch/x86/kernel/acpi/madt.S          |  28 +++
 arch/x86/kernel/acpi/madt_wakeup.c   | 262 +++++++++++++++++++++++++++
 arch/x86/kernel/e820.c               |   9 +-
 arch/x86/kernel/kvmclock.c           |   9 +-
 arch/x86/kernel/reboot.c             |   4 +-
 arch/x86/kernel/relocate_kernel_64.S |   5 +
 arch/x86/kernel/x86_init.c           |   4 +-
 arch/x86/kvm/Kconfig                 |   5 +
 arch/x86/mm/mem_encrypt_amd.c        |   8 +-
 arch/x86/mm/pat/set_memory.c         |  17 +-
 include/acpi/actbl2.h                |  19 +-
 include/linux/cc_platform.h          |  10 -
 include/linux/cpu.h                  |   2 +
 kernel/cpu.c                         |  17 +-
 25 files changed, 604 insertions(+), 146 deletions(-)
 create mode 100644 arch/x86/coco/tdx/kexec.c
 create mode 100644 arch/x86/kernel/acpi/madt.S
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

-- 
2.41.0

