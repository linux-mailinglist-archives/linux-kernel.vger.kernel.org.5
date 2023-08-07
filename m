Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300D67728BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHGPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHGPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:08:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38751737;
        Mon,  7 Aug 2023 08:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jVZ9rt84fY/SCIKuioMTW0aEVXr50l2Bm4273NqkiiM=; b=rtaOKSS819RjtduPkO6fmwE0tr
        pDbqcL4U+u1TDVL3x0BnvX3wVb5qWt28y0gmOl2DKTNZlQS7uKKTPAPTJ0gV+ZHNX9Q9bmOZFFdtx
        1vig5erg6vGUpRVZ43Xo/Z1ccNF2AusINF0lwekmD+Mx9IepwS8VK1lbF9024j/iBpwhnjhT4EdXt
        h3kA/ZocnAxtnCuM7905FC9I7MjU1yCR+EgGrU2GH24AYLLSMP0utoNPxq2dsvK5uyeM/wOSFj9qj
        pcwQJYTQxF6QA0qiXWxeHTdxzKNVasCqHSjW6400jQ6edKy/dssxzg8tN1N7AlZeQRR30FdBpBkDK
        P3irErjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qT1pQ-00BlpD-1F; Mon, 07 Aug 2023 15:07:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A25D53005A2;
        Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7B13B201FD2EA; Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Message-ID: <20230807150405.757666627@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:38:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        Tony Luck <tony.luck@intel.com>, luto@kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@linux.intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/3] x86/cpu: Fix Crestmont uarch
References: <20230807123806.700370534@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra Forest and Grand Ridge are both E-core only using Crestmont
micro-architecture, They fit the pre-existing naming scheme prefectly
fine, adhere to it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/intel-family.h                         |    5 ++---
 drivers/edac/i10nm_base.c                                   |    2 +-
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -155,9 +155,8 @@
 
 #define INTEL_FAM6_ATOM_GRACEMONT	0xBE /* Alderlake N */
 
-#define INTEL_FAM6_SIERRAFOREST_X	0xAF
-
-#define INTEL_FAM6_GRANDRIDGE		0xB6
+#define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
+#define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
 /* Xeon Phi */
 
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -906,7 +906,7 @@ static const struct x86_cpu_id i10nm_cpu
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SIERRAFOREST_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -720,7 +720,7 @@ static struct miscdevice isst_if_char_dr
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SIERRAFOREST_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
 };
 


