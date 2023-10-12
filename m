Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6CC7C75C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbjJLSUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbjJLSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:20:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4FCC;
        Thu, 12 Oct 2023 11:20:49 -0700 (PDT)
Date:   Thu, 12 Oct 2023 18:20:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697134847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3jHAuNIXAPhyFONCLzgwQk08/kHkQsm5jfg/En/LeQ=;
        b=ddt6I8uhlgwkL+dFz2uOmtgc4Wb1WphOOvcQ8A/ARafGL8mEXE/FQ9aApj1kxCDRoXhiV5
        jMaPsttWIxxeV5ps6Al9V0Sr+80KWIAWEDQ9kYy3FR25OftrUnpzPFqf+BfT2Ue+OSRrOq
        oX32YAebbj1J+1mjTMlzdOe5xUCQ52612asBX+wmxCk+KQ0TaEZDpVHNbWWlkgHjc8TvtG
        6Lk0PtFX9609309+X2sSyJXU5OfBIAMZu4PegWEs3OQ1pmikXgFvLt4aB7GofMnV3q44P0
        0X/oVAEmX5RJwNdKVmNffUOKkYBLxetNqSewTRMcuDa3eSoU7UiA4BC7o7Zz3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697134847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3jHAuNIXAPhyFONCLzgwQk08/kHkQsm5jfg/En/LeQ=;
        b=l0i7AyM/UIZjpkCYzY+ELFtk3RCYB9exdlWZq0Rv3DysJrOIoA6WAtcQ8K+iPfy499QMry
        pwmQumccLYIpiwCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpu: Fix the AMD Fam 17h, Fam 19h, Zen2 and Zen4
 MSR enumerations
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
MIME-Version: 1.0
Message-ID: <169713484702.3135.9739629828157326909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     deedec0a152a3d7fa5b04ef9431aeb71802835b5
Gitweb:        https://git.kernel.org/tip/deedec0a152a3d7fa5b04ef9431aeb71802835b5
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Thu, 12 Oct 2023 20:01:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 20:10:39 +02:00

x86/cpu: Fix the AMD Fam 17h, Fam 19h, Zen2 and Zen4 MSR enumerations

The comments introduced in <asm/msr-index.h> in the merge conflict fixup in:

  8f4156d58713 ("Merge branch 'x86/urgent' into perf/core, to resolve conflict")

... aren't right: AMD naming schemes are more complex than implied,
family 0x17 is Zen1 and 2, family 0x19 is spread around Zen 3 and 4.

So there's indeed four separate MSR namespaces for:

  MSR_F17H_
  MSR_F19H_
  MSR_ZEN2_
  MSR_ZEN4_

... and the namespaces cannot be merged.

Fix it up. No change in functionality.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com
---
 arch/x86/include/asm/msr-index.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 0ad9ba8..f8b5028 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -637,18 +637,20 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-/* Fam 19h (Zen 4) MSRs */
-#define MSR_F19H_UMC_PERF_CTL		0xc0010800
-#define MSR_F19H_UMC_PERF_CTR		0xc0010801
-
-#define MSR_ZEN4_BP_CFG			0xc001102e
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG                 0xc001102e
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
-/* Fam 17h (Zen 2) MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
+/* Fam 19h MSRs */
+#define MSR_F19H_UMC_PERF_CTL           0xc0010800
+#define MSR_F19H_UMC_PERF_CTR           0xc0010801
 
-#define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
-#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
+/* Zen 2 */
+#define MSR_ZEN2_SPECTRAL_CHICKEN       0xc00110e3
+#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT   BIT_ULL(1)
+
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
 
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
