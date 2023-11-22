Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98867F4F22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjKVSRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKVSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:17:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC99A4;
        Wed, 22 Nov 2023 10:17:13 -0800 (PST)
Date:   Wed, 22 Nov 2023 18:17:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700677031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spZGf1X2ZZQiMgpB/kpF42wNr1pNzbMMgX1NRP70Bsg=;
        b=a5TzKAoLQ4h/B1EegFNhIcl1bL4nPyn2VjKe0sJiR/vzDzyHDLiLLeo30ZBSCqcvEWL4en
        YaVWwM6p7a1YkWPXLigoqfwRMi8XhxQfvSmPKjlsD3DOt4HBtYIFRHAYDfAuGh70TeEhMm
        DjBQThO4qk4QMygoyMVZgFp5Ypt8KCWE4M9Mt4Q7LzubSqkDal69ItZHLXBKdmE3TS+xMp
        ZhWd1zQp9uI4+bKxXYp0wesqGyWpep6KWErVKewHJK1upkv53Z2ecFKtc504auBxKQzESZ
        Kh8KkBoFAB5hhUmwdey1wGmA/asYPFWEJF4iqMkEYf8EIdLEiu/5bPBWNNI7sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700677031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spZGf1X2ZZQiMgpB/kpF42wNr1pNzbMMgX1NRP70Bsg=;
        b=vfTJDH5NKi5BVD4kiXbMphLiCFpCSjAn5dEPXVs/2/fuweycHiB53KcLYQBUx6Qe0oCKeA
        VmuZPF25oPtno0BA==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/inject: Clear test status value
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231118193248.1296798-2-yazen.ghannam@amd.com>
References: <20231118193248.1296798-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <170067703062.398.8150315880389793451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     6175b407756b22e7fdc771181b7d832ebdedef5c
Gitweb:        https://git.kernel.org/tip/6175b407756b22e7fdc771181b7d832ebdedef5c
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Sat, 18 Nov 2023 13:32:29 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 22 Nov 2023 19:13:38 +01:00

x86/mce/inject: Clear test status value

AMD systems generally allow MCA "simulation" where MCA registers can be
written with valid data and the full MCA handling flow can be tested by
software.

However, the platform on Scalable MCA systems, can prevent software from
writing data to the MCA registers. There is no architectural way to
determine this configuration. Therefore, the MCE injection module will
check for this behavior by writing and reading back a test status value.
This is done during module init, and the check can run on any CPU with
any valid MCA bank.

If MCA_STATUS writes are ignored by the platform, then there are no side
effects on the hardware state.

If the writes are not ignored, then the test status value will remain in
the hardware MCA_STATUS register. It is likely that the value will not
be overwritten by hardware or software, since the tested CPU and bank
are arbitrary. Therefore, the user may see a spurious, synthetic MCA
error reported whenever MCA is polled for this CPU.

Clear the test value immediately after writing it. It is very unlikely
that a valid MCA error is logged by hardware during the test. Errors
that cause an #MC won't be affected.

Fixes: 891e465a1bd8 ("x86/mce: Check whether writes to MCA_STATUS are getting ignored")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231118193248.1296798-2-yazen.ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 4d8d4bc..72f0695 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -746,6 +746,7 @@ static void check_hw_inj_possible(void)
 
 		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), status);
 		rdmsrl_safe(mca_msr_reg(bank, MCA_STATUS), &status);
+		wrmsrl_safe(mca_msr_reg(bank, MCA_STATUS), 0);
 
 		if (!status) {
 			hw_injection_possible = false;
