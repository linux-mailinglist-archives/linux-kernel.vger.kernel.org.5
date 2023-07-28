Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B100766CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjG1MOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjG1MNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:13:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F5E3C3C;
        Fri, 28 Jul 2023 05:13:09 -0700 (PDT)
Message-ID: <20230728120930.782489826@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690546387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=15fa3zOR6FTjADI+P/8aKC6n9dvVMoPwTnUjFsnPU9g=;
        b=X1ze7eAF1ZgivSjF0qcksy3/n3S9JitfBJ9X1w6X9YXwyJmFRYZeznANg0WAEPRxqZ0ClR
        3qsPUxShLPZe7IDBlI0wYtcIFCCwxtX0xrdO/obYujwE1JJuN7fmw2DtJsiQNmcNtLad1m
        j+kNmGs5JO+wxZMR0gmP0jAQyCoXEMXTObRRTrXGs+lRNA9bOMpS65i9Ic9IrASyAXyofS
        3FmlnrIxmiGt3DAOkGwQAI7idTTNrEqoSjDURyYpxGuIN9P2cLscgoTTjgkvQUaoCZ7I5D
        7D2aMORq9sIHAhXMWTvkuW+8wF1c1H3hw44gtGemy8zkSGSAJmAl+GeB2sQtgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690546387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=15fa3zOR6FTjADI+P/8aKC6n9dvVMoPwTnUjFsnPU9g=;
        b=Wg0SMtSPSrhjwKk8nJJJ3LaDAuFeGb5c3Y1xV4erTsfpOWGBCBNJxL9Uibo6QZgKdHRD1R
        Dv7cmn/4nxUZraCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch v2 20/38] x86/cpu: Provide cpuid_read() et al.
References: <20230728105650.565799744@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 14:13:07 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

