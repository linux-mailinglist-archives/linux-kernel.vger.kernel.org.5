Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9427DC8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjJaI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjJaI6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:58:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68310C2;
        Tue, 31 Oct 2023 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698742714; x=1730278714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pEpzXE0NNcmHwTemudkQ6k8syJET3+LhUaz0WTQrc5c=;
  b=bjnUZzXaxHp13Dm5qW+AhHMGIwIb5OtyIWb3MHsirDMlpwLuwzkJhfOo
   wtOMxmHRORjVRRkoBkGPDpT0s6tEe8pNsaCrQ5Rzdw5TGKfHV76kQtxQU
   dEpkljHmWF1drTzh7BqPijP3utU3xDqp2ixO6ped54MevKvPm/4tCmnb8
   TH8TjtMuXsrHZ2sGhsDcHnbs3g8ssf/x6EavnYCaEKtnPwkbGk7p/Voc8
   qIvjVWH5y0wRKziOxuqI4HrwBb2vKzWN7O06445FYLYZAU8zjQ02qLnMi
   fR1sO3qbsr1ZIHZ/plj4W0hpZ+2FoeF005GZ6Y/+1BNdWwb70Q/YHGfG+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378627547"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="378627547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="8257894"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2023 01:58:31 -0700
From:   Dapeng Mi <dapeng1.mi@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch 0/2] Enable topdown slots event in vPMU
Date:   Tue, 31 Oct 2023 17:06:11 +0800
Message-Id: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The topdown slots event counts the total number of available slots for
an unhalted logical processor. Software can use this event to calculate
the topdown metrics by collaborating with IA32_PERF_METRICS MSR.

Since Intel Icelake CPU starts, the topdown slots event can be
programmed both on GP counters or the exclusive fixed counter 3 but with
different event & umask code. The event with code (event=0xa4,umask=0x01)
is an architectural event which is represented in CPUID.0AH.EBX and can
be programed on any GP counter. Besides, Intel PMU from Icelake
introduces a new fixed counter (fixed counter 3) to count/sample
todpown slots event so the precious GP counters can be saved. The fixed
counter 3 uses an exclusive code (event=0x00,umask=0x04) to count/sample
the slots event.

Actually this patchset is a portion of the patchset "Enable fixed counter
 3 and topdown perf metrics for vPMU"[1]. As this original patchset needs to
make some fundamental changes on perf code and cause big arguments, it
leads to the vPMU topdown metrics patchset is hard to be merged in current
vPMU emulation framework.

The patches of enabling topdown slots event is simple and doesn't
touch any perf code. Moreover topdown slots event as an independent
feature is still valuable even though in no topdown metrics cases, some
perf metrics depend on slots event and need to be derived from slots
event.

Thus the patches of enabling slots event is extracted as an independent
patchset and resend.

Ref:
1. https://lore.kernel.org/all/20230927033124.1226509-1-dapeng1.mi@linux.intel.com/T/


Dapeng Mi (2):
  KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots event
  KVM: x86/pmu: Support PMU fixed counter 3

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/vmx/pmu_intel.c    | 12 ++++++++++++
 arch/x86/kvm/x86.c              |  4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)


base-commit: 35dcbd9e47035f98f3910ae420bf10892c9bdc99
-- 
2.34.1

