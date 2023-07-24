Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3361475FE32
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGXRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGXRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:44:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0974F1BDF;
        Mon, 24 Jul 2023 10:44:11 -0700 (PDT)
Message-ID: <20230724172844.399780653@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=15fa3zOR6FTjADI+P/8aKC6n9dvVMoPwTnUjFsnPU9g=;
        b=Oh/zm0czFvSOuwQLZCeK1ETIVR5LwHft9W8vWqcVgt8L5ZrOTP61lr/sJY6u1E7EWTqWeS
        lh653t0KzattRcslTycXPAjGTF3r5NQQ30t9R4Lyaitzy8P2zDX1xtyL4GTjusa/fwnXpn
        lQ3u2gclSzb1k9YVPdwmibu3wSGprQZHGVHWh7CLwEg/ha6PaLzP/ToL3X/0s7UgcdyHeO
        ERLGm0pG2SZbxhC2YtMs87VjMp1nTl0Ysj1BZ2lzt4+bTW4xh60VCUecyZ8OMx8y6Zpafi
        A3WW6haWN2wbpuQok85/MG8/a2Yiq9BO6Va2XExEAq1S3yvVJMAl6jz2OJ/+8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=15fa3zOR6FTjADI+P/8aKC6n9dvVMoPwTnUjFsnPU9g=;
        b=Yj8apQgXs1sQo9COSKMBbvMFmzOfBIAsDbq5bdKWAcujWzsJzr8ox4E/3Z9Eajkc47brzf
        YGYBEdVz9OEF7DBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 12/29] x86/cpu: Provide cpuid_read() et al.
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a few helper functions to read CPUID leafs or individual registers
into a data structure without requiring unions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpuid.h |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -127,6 +127,38 @@ static inline unsigned int cpuid_edx(uns
 	return edx;
 }
 
+static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+{
+	regs[CPUID_EAX] = leaf;
+	regs[CPUID_ECX] = subleaf;
+	__cpuid(regs, regs + 1, regs + 2, regs + 3);
+}
+
+#define cpuid_subleaf(leaf, subleaf, regs)		\
+	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
+	__cpuid_read(leaf, subleaf, (u32 *)(regs))
+
+#define cpuid_leaf(leaf, regs)				\
+	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
+	__cpuid_read(leaf, 0, (u32 *)(regs))
+
+static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+				    enum cpuid_regs_idx regidx, u32 *reg)
+{
+	u32 regs[4];
+
+	__cpuid_read(leaf, subleaf, regs);
+	*reg = regs[regidx];
+}
+
+#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg)		\
+	BUILD_BUG_ON(sizeof(*(reg)) != 4);			\
+	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg))
+
+#define cpuid_leaf_reg(leaf, regidx, reg)			\
+	BUILD_BUG_ON(sizeof(*(reg)) != 4);			\
+	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg))
+
 static __always_inline bool cpuid_function_is_indexed(u32 function)
 {
 	switch (function) {

