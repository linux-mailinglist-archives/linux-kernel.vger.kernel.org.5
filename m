Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182337E4920
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbjKGTXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjKGTXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:23:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F868F;
        Tue,  7 Nov 2023 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699385028; x=1730921028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nbrCvKjssexV20dkATXAyJLI6SJiBEcKPIDhZ+XrGaw=;
  b=ZfoFx4ieEX65koSb5pOqyKSpsg7g74eGHLyACXNCUh87+rvBlNCNL3Ia
   XlvbkhtGNUDIxFC2mf4PiRe7EbERcu77jXLse9JQacHh8aVlit1k7OUFr
   rSTgGQmOmaspmVi759bR/5+J4fepirUYDE9hTbE4HyN54FWlfeP/NKll9
   S7Oxr5jRR85Q6/edQZ84DRlzB2ybrBxwAYUnZExzX9jzChTR+RfepuTpo
   sfdNdKDd3CBja2aKQYDZcIMsnoozpK+tyOVFe1VTu6OnOeEPmFBoeYB6W
   0xLKmMXoYflbILYLO+2leZT8bYv68v1XT/bSh6rIhQ0beXeLbm51DA8cr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="475831538"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="475831538"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10937907"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:23:47 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>
Subject: [PATCH 0/2] KVM: X86: Make bus lock frequency for vapic timer configurable
Date:   Tue,  7 Nov 2023 11:22:32 -0800
Message-Id: <cover.1699383993.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add KVM_CAP_X86_BUS_FREQUENCY_CONTROL capability to configure the core
crystal clock (or processor's bus clock) for APIC timer emulation.  Allow
KVM_ENABLE_CAPABILITY(KVM_CAP_X86_BUS_FREUQNCY_CONTROL) to set the
frequency.  When using this capability, the user space VMM should configure
CPUID[0x15] to advertise the frequency.

TDX virtualizes CPUID[0x15] for the core crystal clock to be 25MHz.  The
x86 KVM hardcodes its freuqncy for APIC timer to be 1GHz.  This mismatch
causes the vAPIC timer to fire earlier than the guest expects. [1] The KVM
APIC timer emulation uses hrtimer, whose unit is nanosecond.

There are options to reconcile the mismatch.  1) Make apic bus clock frequency
configurable (this patch).  2) TDX KVM code adjusts TMICT value.  This is hacky
and it results in losing MSB bits from 32 bit width to 30 bit width.  3). Make
the guest kernel use tsc deadline timer instead of acpi oneshot/periodic timer.
This is guest kernel choice.  It's out of control of VMM.

[1] https://lore.kernel.org/lkml/20231006011255.4163884-1-vannapurve@google.com/

Isaku Yamahata (2):
  KVM: x86: Make the hardcoded APIC bus frequency vm variable
  KVM: X86: Add a capability to configure bus frequency for APIC timer

 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/lapic.c            |  6 ++++--
 arch/x86/kvm/lapic.h            |  4 ++--
 arch/x86/kvm/x86.c              | 16 ++++++++++++++++
 include/uapi/linux/kvm.h        |  1 +
 6 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.25.1

