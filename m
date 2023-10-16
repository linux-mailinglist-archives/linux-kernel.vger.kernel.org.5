Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21C37CAA62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjJPNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjJPNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:48:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7A100;
        Mon, 16 Oct 2023 06:48:15 -0700 (PDT)
Date:   Mon, 16 Oct 2023 13:48:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697464094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzjbF6qk1vI0M7eaJT2fgIaqJymQ1gJxl89gNX4MTHg=;
        b=JFJlAyoCd3sY2R3Ww9X1WigZB+hKLCx7XplDdoH/TPsB2ZNi2QH8SgvTSox5jipmRV5Lj0
        hjA9JDC/XHH885gUemYe4XpJALLlkVxuw9NVkD+D+wJ8uhikS2Dd2mALwOkcuYMAugkqQr
        +TLKbZkMrfTW5Vd/lQoB33R+bMUNRD9ia+zZlvt3KZ2Rkjqh99Lq2X44WjoOkvB/9ZItCG
        nQngD/z71lBZ1Uos1ylUvR8HQAfINXK9J8IidE7OVwngpS16AyN06+mpRvEzBArE4YulYw
        m465zWONyRIYbRlyPl6J4wDs5zPxvK/0ASAQG4WdaBtZwOa84lMrr6aJqu4mtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697464094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzjbF6qk1vI0M7eaJT2fgIaqJymQ1gJxl89gNX4MTHg=;
        b=wRoE6EkBFh5UHslWFtmBYkzxxWT+tlsmnJm80YH9A4PuFZ99hcl+II7dC75u1vhPsmjHD7
        jAycSjZGiEFtsIAQ==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD: Split amd_mce_is_memory_error()
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613141142.36801-2-yazen.ghannam@amd.com>
References: <20230613141142.36801-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <169746409345.3135.6438220840208007314.tip-bot2@tip-bot2>
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

Commit-ID:     495a91d0998367f4f079593f491bdfe8ef06838e
Gitweb:        https://git.kernel.org/tip/495a91d0998367f4f079593f491bdfe8ef06838e
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 13 Jun 2023 09:11:40 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 16 Oct 2023 15:04:53 +02:00

x86/MCE/AMD: Split amd_mce_is_memory_error()

Define helper functions for legacy and SMCA systems in order to reuse
individual checks in later changes.

Describe what each function is checking for, and correct the XEC bitmask
for SMCA.

No functional change intended.

  [ bp: Use "else in amd_mce_is_memory_error() to make the conditional
    balanced, for readability. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230613141142.36801-2-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c267f43..c069934 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -713,17 +713,37 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
-bool amd_mce_is_memory_error(struct mce *m)
+/*
+ * DRAM ECC errors are reported in the Northbridge (bank 4) with
+ * Extended Error Code 8.
+ */
+static bool legacy_mce_is_memory_error(struct mce *m)
+{
+	return m->bank == 4 && XEC(m->status, 0x1f) == 8;
+}
+
+/*
+ * DRAM ECC errors are reported in Unified Memory Controllers with
+ * Extended Error Code 0.
+ */
+static bool smca_mce_is_memory_error(struct mce *m)
 {
 	enum smca_bank_types bank_type;
-	/* ErrCodeExt[20:16] */
-	u8 xec = (m->status >> 16) & 0x1f;
+
+	if (XEC(m->status, 0x3f))
+		return false;
 
 	bank_type = smca_get_bank_type(m->extcpu, m->bank);
-	if (mce_flags.smca)
-		return (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) && xec == 0x0;
 
-	return m->bank == 4 && xec == 0x8;
+	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
+}
+
+bool amd_mce_is_memory_error(struct mce *m)
+{
+	if (mce_flags.smca)
+		return smca_mce_is_memory_error(m);
+	else
+		return legacy_mce_is_memory_error(m);
 }
 
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
