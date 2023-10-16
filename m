Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A87CAA61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJPNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjJPNss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:48:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022B9F0;
        Mon, 16 Oct 2023 06:48:14 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:48:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697464093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FU2ABZUUnEvuHuQbEnQMnNElb3NA6BQA8yPVD1V3sCU=;
        b=b4FfFmv/zGo8DPCQuAfNSdSLRSLWNQKKJn3KvCgZgYPC3j5PLavDZ9wi7USfwXrX7XHc+U
        4yzhcj//SYENQ1qG8+g+4J+DWmXcE5AOfR8eho3cJGYZB6c449sKpDfA5ylA5+5UHFYYhJ
        oJ6sDW4lMxkExoXAWqLcpRIU38h8+vJf0kTbfyvuQ4xKehbxQXh5YIHEXS64qqt3xN0655
        It1G6zVZP+KS2qUy98b/fiORVmhvOfAd7KacLZSF+H4k6Lpv389J+EmxHKEM1shNaekJL9
        OFVMijhb3jzwuVMKIQECZRFzY5vAXChi5hfwlXu0C+S6qjMw5KGVh+H5T8ucEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697464093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FU2ABZUUnEvuHuQbEnQMnNElb3NA6BQA8yPVD1V3sCU=;
        b=y/cezZTbQxOVwu5hRKs6Xm6RpQ8sm5uTNMuHlFaP5GGjhBWiZVCAdg3dsfchTQdQqcDx+S
        KBR7rEeo6kM2u+Dg==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Define amd_mce_usable_address()
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613141142.36801-3-yazen.ghannam@amd.com>
References: <20230613141142.36801-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <169746409281.3135.8272512933484140652.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     48da1ad8ba95ecd35d76355594c629f3ef2a954a
Gitweb:        https://git.kernel.org/tip/48da1ad8ba95ecd35d76355594c629f3ef2a954a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 13 Jun 2023 09:11:41 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 16 Oct 2023 15:31:32 +02:00

x86/mce: Define amd_mce_usable_address()

Currently, all valid MCA_ADDR values are assumed to be usable on AMD
systems. However, this is not correct in most cases. Notifiers expecting
usable addresses may then operate on inappropriate values.

Define a helper function to do AMD-specific checks for a usable memory
address. List out all known cases.

  [ bp: Tone down the capitalized words. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230613141142.36801-3-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c      | 38 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/core.c     |  3 ++-
 arch/x86/kernel/cpu/mce/internal.h |  2 ++-
 3 files changed, 43 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c069934..f3517b8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -746,6 +746,44 @@ bool amd_mce_is_memory_error(struct mce *m)
 		return legacy_mce_is_memory_error(m);
 }
 
+/*
+ * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
+ * a system physical address. Therefore, individual cases need to be detected.
+ * Future cases and checks will be added as needed.
+ *
+ * 1) General case
+ *	a) Assume address is not usable.
+ * 2) Poison errors
+ *	a) Indicated by MCA_STATUS[43]: poison. Defined for all banks except legacy
+ *	   northbridge (bank 4).
+ *	b) Refers to poison consumption in the core. Does not include "no action",
+ *	   "action optional", or "deferred" error severities.
+ *	c) Will include a usable address so that immediate action can be taken.
+ * 3) Northbridge DRAM ECC errors
+ *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
+ *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
+ *	   this bit should not be checked.
+ *
+ * NOTE: SMCA UMC memory errors fall into case #1.
+ */
+bool amd_mce_usable_address(struct mce *m)
+{
+	/* Check special northbridge case 3) first. */
+	if (!mce_flags.smca) {
+		if (legacy_mce_is_memory_error(m))
+			return true;
+		else if (m->bank == 4)
+			return false;
+	}
+
+	/* Check poison bit for all other bank types. */
+	if (m->status & MCI_STATUS_POISON)
+		return true;
+
+	/* Assume address is not usable for all others. */
+	return false;
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f72..06c21f5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -464,6 +464,9 @@ int mce_usable_address(struct mce *m)
 	if (!(m->status & MCI_STATUS_ADDRV))
 		return 0;
 
+	if (m->cpuvendor == X86_VENDOR_AMD)
+		return amd_mce_usable_address(m);
+
 	/* Checks after this one are Intel/Zhaoxin-specific: */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index bcf1b3c..a191554 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -210,6 +210,7 @@ extern bool filter_mce(struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
+bool amd_mce_usable_address(struct mce *m);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -237,6 +238,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
+static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
 #endif
 
