Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9977DC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbjHPI0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbjHPI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:26:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8858D1990;
        Wed, 16 Aug 2023 01:26:27 -0700 (PDT)
Date:   Wed, 16 Aug 2023 08:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692174386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5Uo85dlChXiK1e7VOp+AQdIs8SHZzORk/Gf/7Po0gY=;
        b=vvzkT8cZIWvKKpoafhrHBB0EvECJqCy3HOtNKtHHGa5gtwOofoBYVJHrDjs+G2aQJWA5cs
        crX7U0GbrrKCtzflf2hYwqaR/VdK6jDHF7P1oLEoZUSD+l3IlSv6MReEOdwuYC4VXKZY8v
        Q//9heXPlibT9N5Mlhx9aqNHVL47QSjyMtofRDObBu5tCPwnVTvymDZg2zFvptlSIZkq4Q
        qlbBCBfpFXZo+EIvkjSzTIbgJTCv/RH19OOVS7dCfHeuCDjVm0RhfExIZoUkrWCod3JgFt
        Vx9eEXSrzn2d9pm/vyjYXHBfoAhMM0hlNx/ATRR3zbvi+GsNKt0QlWUAuEj6jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692174386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5Uo85dlChXiK1e7VOp+AQdIs8SHZzORk/Gf/7Po0gY=;
        b=KQeEmaEtXMLBxbkGf+kVuX1J/ONMEeazGLNhs+5NRyY1nUdZI0Ve9IjXibDf7VcgLM/PZi
        rkXM9RNBPrArUnCg==
From:   "tip-bot2 for Alexey Kardashevskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Do not handle #VC for DR7 read/write
Cc:     Alexey Kardashevskiy <aik@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230816022122.981998-1-aik@amd.com>
References: <20230816022122.981998-1-aik@amd.com>
MIME-Version: 1.0
Message-ID: <169217438542.27769.5398729789133595994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e221804dad4e6fe3a0cf192ba3c42cd2f328bdac
Gitweb:        https://git.kernel.org/tip/e221804dad4e6fe3a0cf192ba3c42cd2f328bdac
Author:        Alexey Kardashevskiy <aik@amd.com>
AuthorDate:    Wed, 16 Aug 2023 12:21:22 +10:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 10:13:42 +02:00

x86/sev: Do not handle #VC for DR7 read/write

With MSR_AMD64_SEV_DEBUG_SWAP enabled, the guest is not expected to
receive a #VC for reads or writes of DR7.

Update the SNP_FEATURES_PRESENT mask with MSR_AMD64_SNP_DEBUG_SWAP so
an SNP guest doesn't gracefully terminate during SNP feature negotiation
if MSR_AMD64_SEV_DEBUG_SWAP is enabled.

Since a guest is not expected to receive a #VC on DR7 accesses when
MSR_AMD64_SEV_DEBUG_SWAP is enabled, return an error from the #VC
handler in this situation.

Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Link: https://lore.kernel.org/r/20230816022122.981998-1-aik@amd.com
---
 arch/x86/boot/compressed/sev.c | 2 +-
 arch/x86/kernel/sev.c          | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c3e343b..e83e710 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -365,7 +365,7 @@ static void enforce_vmpl0(void)
  * by the guest kernel. As and when a new feature is implemented in the
  * guest kernel, a corresponding bit should be added to the mask.
  */
-#define SNP_FEATURES_PRESENT (0)
+#define SNP_FEATURES_PRESENT	MSR_AMD64_SNP_DEBUG_SWAP
 
 void snp_check_features(void)
 {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ee7bed..d380c93 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1575,6 +1575,9 @@ static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
 	long val, *reg = vc_insn_get_rm(ctxt);
 	enum es_result ret;
 
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
 	if (!reg)
 		return ES_DECODE_FAILED;
 
@@ -1612,6 +1615,9 @@ static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
 	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
 	long *reg = vc_insn_get_rm(ctxt);
 
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
 	if (!reg)
 		return ES_DECODE_FAILED;
 
