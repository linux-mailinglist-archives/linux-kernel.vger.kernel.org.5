Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA827DC8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjJaI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjJaI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:58:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70698E6;
        Tue, 31 Oct 2023 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698742717; x=1730278717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s+JsvEs7Ok+DvIu+DU/KDBtPTG9fSNGUmHldnUjJuQ4=;
  b=WTXfm0YYVuUYEq7pFLQl/n1dtLhDpTTbt2vtE4Cs5lb1HnO/EhJKN0dK
   J7dheZWvubuqY0dQAR9SxhpH004ZfgGKLBsnWP/cGl9R9hreF1xt/qxyh
   1+hQidcOGfBdUGyo6jPPOTojTNsDWEb0BJ5Qm8l4MaqjLKfy0q0Tu1IlI
   LlSuANBYJNQGxpwChUrn6p7shjkI/aACgISZFCjZ1pHudXtFnptuXbGct
   WikyLomzmzFHp/7MFcL1OwHUKSu2imDa6imIpGDcWVr9m0LO5BfSlpWFr
   SaxkFZqS30BqydKndD2+elMC3FIlvueWgTpe4tpmsI/D6Z7+289VysDHV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="378627556"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="378627556"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="8257897"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2023 01:58:34 -0700
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
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <likexu@tencent.com>
Subject: [Patch 1/2] KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots event
Date:   Tue, 31 Oct 2023 17:06:12 +0800
Message-Id: <20231031090613.2872700-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
References: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
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

This patch adds support for the architectural topdown slots event which
is hinted by CPUID.0AH.EBX.

The topdown slots event counts the total number of available slots for
an unhalted logical processor. Software can use this event as the
denominator for the top-level metrics of the topDown Microarchitecture
Analysis method.

Although the MSR_PERF_METRICS MSR required for topdown events is not
currently available in the guest, relying only on the data provided by
the slots event is sufficient for pmu users to perceive differences in
cpu pipeline machine-width across micro-architectures.

The standalone slots event, like the instruction event, can be counted
with gp counter or fixed counter 3 (if any). Its availability is also
controlled by CPUID.AH.EBX. On Linux, perf user may encode
"-e cpu/event=0xa4,umask=0x01/" or "-e cpu/slots/" to count slots events.

This patch only enables slots event on GP counters. The enabling on fixed
counter 3 will be supported in subsequent patches.

Co-developed-by: Like Xu <likexu@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 820d3e1f6b4f..e32353f1143f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -34,6 +34,7 @@ enum intel_pmu_architectural_events {
 	INTEL_ARCH_LLC_MISSES,
 	INTEL_ARCH_BRANCHES_RETIRED,
 	INTEL_ARCH_BRANCHES_MISPREDICTED,
+	INTEL_ARCH_TOPDOWN_SLOTS,
 
 	NR_REAL_INTEL_ARCH_EVENTS,
 
@@ -58,6 +59,7 @@ static struct {
 	[INTEL_ARCH_LLC_MISSES]			= { 0x2e, 0x41 },
 	[INTEL_ARCH_BRANCHES_RETIRED]		= { 0xc4, 0x00 },
 	[INTEL_ARCH_BRANCHES_MISPREDICTED]	= { 0xc5, 0x00 },
+	[INTEL_ARCH_TOPDOWN_SLOTS]		= { 0xa4, 0x01 },
 	[PSEUDO_ARCH_REFERENCE_CYCLES]		= { 0x00, 0x03 },
 };
 
-- 
2.34.1

