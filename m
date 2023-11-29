Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EFB7FD43A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjK2KdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjK2KdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:33:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A04D54;
        Wed, 29 Nov 2023 02:33:24 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701254001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCrcajcmWao+TZklXlucMF71m1PrDnK6AQeOVls3bYc=;
        b=Ea3DqpAw0QWS/QerrwDvBT8Fa0mJ3/5LPVbBc66hO7sEHw+YnDFZ+rntHv4/7fohyAGLFD
        3Gf/UcPXNroNBAGCwEUrPJk44N5q17hO7VFUGZG58xm6oSzPszoDLJZR39tS8Iw2GJdgH4
        blOAKbIGJLsCnNSnUKfpebIbxmqe6GsMdo8VdlLaoYt99xVCJCLgv7GNHZGQPiHmrUjP7h
        0za7FFjQIPkvWQmasRyfR49u5r7acuDbXc7oLfbFrX59hZcpyW88RJCIZvGpno9dMMBrxs
        nTrP2lREtQQKStd9KUVgShpgy5GKPwOprUghesMtMyqVmjWhv0BWC2oRP7vSQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701254001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCrcajcmWao+TZklXlucMF71m1PrDnK6AQeOVls3bYc=;
        b=2G04Gbj6JHW+8G7xOd8NSAbdi4Jny0Q9Pjh5RciT5gf4zfJ80yO+3WiYXcxH431cvhdM6d
        kRS3dlYfioPrr3CQ==
From:   "tip-bot2 for Muralidhara M K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types
Cc:     Muralidhara M K <muralidhara.mk@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231102114225.2006878-3-muralimk@amd.com>
References: <20231102114225.2006878-3-muralimk@amd.com>
MIME-Version: 1.0
Message-ID: <170125400052.398.8408207092730391634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     47b744ea5e3cf855087951a74ba9f89180fa1ba5
Gitweb:        https://git.kernel.org/tip/47b744ea5e3cf855087951a74ba9f89180fa1ba5
Author:        Muralidhara M K <muralidhara.mk@amd.com>
AuthorDate:    Thu, 02 Nov 2023 11:42:23 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 28 Nov 2023 16:26:55 +01:00

x86/MCE/AMD: Add new MA_LLC, USR_DP, and USR_CP bank types

Add HWID and McaType values for new SMCA bank types.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231102114225.2006878-3-muralimk@amd.com
---
 arch/x86/include/asm/mce.h    | 3 +++
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4ad49af..de31183 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -311,6 +311,7 @@ enum smca_bank_types {
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
 	SMCA_UMC_V2,
+	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
 	SMCA_PSP_V2,
@@ -326,6 +327,8 @@ enum smca_bank_types {
 	SMCA_SHUB,	/* System HUB Unit */
 	SMCA_SATA,	/* SATA Unit */
 	SMCA_USB,	/* USB Unit */
+	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
+	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
 	SMCA_GMI_PCS,	/* GMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f6c6c1e..2b46eb0 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -102,6 +102,7 @@ static const char * const smca_names[] = {
 	/* UMC v2 is separate because both of them can exist in a single system. */
 	[SMCA_UMC]			= "umc",
 	[SMCA_UMC_V2]			= "umc_v2",
+	[SMCA_MA_LLC]			= "ma_llc",
 	[SMCA_PB]			= "param_block",
 	[SMCA_PSP ... SMCA_PSP_V2]	= "psp",
 	[SMCA_SMU ... SMCA_SMU_V2]	= "smu",
@@ -114,6 +115,8 @@ static const char * const smca_names[] = {
 	[SMCA_SHUB]			= "shub",
 	[SMCA_SATA]			= "sata",
 	[SMCA_USB]			= "usb",
+	[SMCA_USR_DP]			= "usr_dp",
+	[SMCA_USR_CP]			= "usr_cp",
 	[SMCA_GMI_PCS]			= "gmi_pcs",
 	[SMCA_XGMI_PHY]			= "xgmi_phy",
 	[SMCA_WAFL_PHY]			= "wafl_phy",
@@ -164,6 +167,7 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
 	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
 	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
+	{ SMCA_MA_LLC,	 HWID_MCATYPE(0x2E, 0x4)	},
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
@@ -198,6 +202,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
 	{ SMCA_SATA,	 HWID_MCATYPE(0xA8, 0x0)	},
 	{ SMCA_USB,	 HWID_MCATYPE(0xAA, 0x0)	},
+	{ SMCA_USR_DP,	 HWID_MCATYPE(0x170, 0x0)	},
+	{ SMCA_USR_CP,	 HWID_MCATYPE(0x180, 0x0)	},
 	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
