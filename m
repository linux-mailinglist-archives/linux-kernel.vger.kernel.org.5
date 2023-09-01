Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76D78FF46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350027AbjIAOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjIAOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:35:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39078A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693578910; x=1725114910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mOVxArc6MrRCO13fhpvfMhpyVmbjTOOueaBnCjUDhhs=;
  b=UEp3nlXSEckzA0VsbqAhMSO3YJDcBrVuzvU1l3/1e42K+1+alPMfNraX
   6iebn4x4F8AGfFr8TWVxA++c7mCwn7jlTXJlfZR8ajl2tOPeoSCEb4s+M
   q7CSJ/pjtdZmyJWaYHOOsNyDhd4sr11v6mzzJ0bxG9W0T5EgBUUt7b8eM
   OISurnccwqdabUdOokawngmBCe7sVSuykPdshNSyNNWZxeiksz8ehdzao
   jq2HGOqSKbjuSYeVeXh9CkaXMNbHlgZiyg9bYizgx8XyKBbbfFF7qbUIQ
   I3HdCAmEJd/GufaH//oKqxEiYCkfaGG7CoDVnQG3pAan1qG5/nANGTwM9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373627534"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373627534"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805450043"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="805450043"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2023 07:35:00 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, dave.hansen@linux.intel.com,
        yi.sun@intel.intel.com, Yi Sun <yi.sun@intel.com>
Subject: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Date:   Fri,  1 Sep 2023 22:34:12 +0800
Message-Id: <20230901143414.1664368-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901143414.1664368-1-yi.sun@intel.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two trace points x86_fpu_latency_xsave and x86_fpu_latency_xrstor.
The latency dumped by the new trace points can tell when XSAVES/XRSTORS
are getting more or less expensive, and get out the RFBM
(requested-feature bitmap) and XINUSE to figure out the reason.

Calculate the latency of instructions XSAVES and XRSTORS within a
single trace event respectively. Another option considered was to
have 2 separated trace events marking the start and finish of the
XSAVES/XRSTORS. The latency was calculated from the 2 trace points in
user space, but there was significant overhead added by the trace
function itself.

In internal testing, the single trace point option which is
implemented here proved to save big overhead introduced by trace
function.

Make use of trace_clock() to calculate the latency, which is based on
cpu_clock() with precision at most ~1 jiffy between CPUs.

CONFIG_X86_DEBUG_FPU and CONFIG_TRACEPOINTS are required. And the
compiler will get rid of all the extra crust when either of the two
configs is disabled.

If both of the configs are enabled, xsave/xrstor_tracing_enabled
would be reduced to a static check for tracing enabled. Thus, in the
fast path there would be only 2 additional static checks.

Since trace points can be enabled dynamically, while the code is
checking tracepoint_enabled(trace_event), the trace_event could be
concurrently enabled. Hence there is probability to get single once
noisy result 'trace_clock() - (-1)' at the moment enabling the trace
points x86_fpu_latency_*. Leave the noise here instead of additional
conditions while calling the x86_fpu_latency_* because it's not worth
for the only once noise. It's easy to filter out by the following
consuming script or other user space tool.

Trace log looks like following:
  x86_fpu_latency_xsave: x86/fpu: latency:100 RFBM:0x202e7 XINUSE:0x202
  x86_fpu_latency_xrstor: x86/fpu: latency:99 RFBM:0x202e7 XINUSE:0x202

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 4645a6334063..5f7cb633df09 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -89,6 +89,41 @@ DEFINE_EVENT(x86_fpu, x86_fpu_xstate_check_failed,
 	TP_ARGS(fpu)
 );
 
+DECLARE_EVENT_CLASS(x86_fpu_latency,
+	TP_PROTO(struct fpstate *fpstate, u64 latency),
+	TP_ARGS(fpstate, latency),
+
+	TP_STRUCT__entry(
+		__field(struct fpstate *, fpstate)
+		__field(u64, latency)
+		__field(u64, rfbm)
+		__field(u64, xinuse)
+	),
+
+	TP_fast_assign(
+		__entry->fpstate = fpstate;
+		__entry->latency = latency;
+		__entry->rfbm = fpstate->xfeatures;
+		__entry->xinuse = fpstate->regs.xsave.header.xfeatures;
+	),
+
+	TP_printk("x86/fpu: latency:%lld RFBM:0x%llx XINUSE:0x%llx",
+		__entry->latency,
+		__entry->rfbm,
+		__entry->xinuse
+	)
+);
+
+DEFINE_EVENT(x86_fpu_latency, x86_fpu_latency_xsave,
+	TP_PROTO(struct fpstate *fpstate, u64 latency),
+	TP_ARGS(fpstate, latency)
+);
+
+DEFINE_EVENT(x86_fpu_latency, x86_fpu_latency_xrstor,
+	TP_PROTO(struct fpstate *fpstate, u64 latency),
+	TP_ARGS(fpstate, latency)
+);
+
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH asm/trace/
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a4ecb04d8d64..5a8321d9f7db 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -5,6 +5,9 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/xcr.h>
+#include <asm/trace/fpu.h>
+
+#include <linux/trace_clock.h>
 
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u64, xfd_state);
@@ -68,6 +71,20 @@ static inline u64 xfeatures_mask_independent(void)
 	return XFEATURE_MASK_INDEPENDENT;
 }
 
+static inline bool xsave_tracing_enabled(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_DEBUG_FPU))
+		return false;
+	return tracepoint_enabled(x86_fpu_latency_xsave);
+}
+
+static inline bool xrstor_tracing_enabled(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_DEBUG_FPU))
+		return false;
+	return tracepoint_enabled(x86_fpu_latency_xrstor);
+}
+
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
@@ -113,7 +130,7 @@ static inline u64 xfeatures_mask_independent(void)
  * original instruction which gets replaced. We need to use it here as the
  * address of the instruction where we might get an exception at.
  */
-#define XSTATE_XSAVE(st, lmask, hmask, err)				\
+#define __XSTATE_XSAVE(st, lmask, hmask, err)				\
 	asm volatile(ALTERNATIVE_3(XSAVE,				\
 				   XSAVEOPT, X86_FEATURE_XSAVEOPT,	\
 				   XSAVEC,   X86_FEATURE_XSAVEC,	\
@@ -126,11 +143,22 @@ static inline u64 xfeatures_mask_independent(void)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define XSTATE_XSAVE(fps, lmask, hmask, err)				\
+	do {								\
+		struct fpstate *f = fps;				\
+		u64 tc = -1;						\
+		if (xsave_tracing_enabled())				\
+			tc = trace_clock();				\
+		__XSTATE_XSAVE(&f->regs.xsave, lmask, hmask, err);	\
+		if (xsave_tracing_enabled())				\
+			trace_x86_fpu_latency_xsave(f, trace_clock() - tc);\
+	} while (0)
+
 /*
  * Use XRSTORS to restore context if it is enabled. XRSTORS supports compact
  * XSAVE area format.
  */
-#define XSTATE_XRESTORE(st, lmask, hmask)				\
+#define __XSTATE_XRESTORE(st, lmask, hmask)				\
 	asm volatile(ALTERNATIVE(XRSTOR,				\
 				 XRSTORS, X86_FEATURE_XSAVES)		\
 		     "\n"						\
@@ -140,6 +168,17 @@ static inline u64 xfeatures_mask_independent(void)
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
+#define XSTATE_XRESTORE(fps, lmask, hmask)				\
+	do {								\
+		struct fpstate *f = fps;				\
+		u64 tc = -1;						\
+		if (xrstor_tracing_enabled())				\
+			tc = trace_clock();				\
+		__XSTATE_XRESTORE(&f->regs.xsave, lmask, hmask);	\
+		if (xrstor_tracing_enabled())				\
+			trace_x86_fpu_latency_xrstor(f, trace_clock() - tc);\
+	} while (0)
+
 #if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
 extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
 #else
@@ -184,7 +223,7 @@ static inline void os_xsave(struct fpstate *fpstate)
 	WARN_ON_FPU(!alternatives_patched);
 	xfd_validate_state(fpstate, mask, false);
 
-	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
+	XSTATE_XSAVE(fpstate, lmask, hmask, err);
 
 	/* We should never fault when copying to a kernel buffer: */
 	WARN_ON_FPU(err);
@@ -201,7 +240,7 @@ static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
 	u32 hmask = mask >> 32;
 
 	xfd_validate_state(fpstate, mask, true);
-	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+	XSTATE_XRESTORE(fpstate, lmask, hmask);
 }
 
 /* Restore of supervisor state. Does not require XFD */
@@ -211,7 +250,7 @@ static inline void os_xrstor_supervisor(struct fpstate *fpstate)
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 
-	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
+	XSTATE_XRESTORE(fpstate, lmask, hmask);
 }
 
 /*
-- 
2.34.1

