Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED438806416
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjLFBQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjLFBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:16:02 -0500
X-Greylist: delayed 1488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 17:16:07 PST
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193C0181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:16:06 -0800 (PST)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1rAg7y-000DVy-MM; Wed, 06 Dec 2023 01:51:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From;
        bh=a+Blmlooy40wuxd6EVVL4ZFgXJ/+LK2NPLR98nHVQXg=; b=ZM5E98GluA2CEKQ4iDCTpp3ApO
        NuDgEWwDpJwBak4MATBt4IGDgXmiyIWu+1Pfd+9Ppch8pA1b6fRg97+jlfwMAIlpoZkgL4qSNHc4x
        2Re1i2ExHhf7idHVedHsfCr+krVOY1+xqiNvN+LXvKyjlDGYTO1aotBexZlKh9nWNrZGnfv0aWkv2
        NYzXZV7cGfUURAtkgar1CLWd8ll0mBcQnWCjUPBp0vAzNKBepBJ6/zk/DptQkOlHhzJwPIoCefgI/
        cZOEHBkN/z+CKmkYC7MuKE3JLg+RyatsbZd1/oaBZCTolZdEqbflwTtQ+q13d4ppgZFVxhIfXt0TI
        278olAlA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1rAg7y-0001zg-5R; Wed, 06 Dec 2023 01:51:02 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        id 1rAg7k-00CFCn-3w; Wed, 06 Dec 2023 01:50:48 +0100
From:   Michal Luczaj <mhal@rbox.co>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, luto@kernel.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 1/2] x86/traps: Attempt UMIP fixup only on #GP(0)
Date:   Wed,  6 Dec 2023 01:43:44 +0100
Message-ID: <20231206004654.2986026-2-mhal@rbox.co>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206004654.2986026-1-mhal@rbox.co>
References: <20231206004654.2986026-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not allow for UMIP exception fixup if the exception did not come
directly from the user space. This excludes #GP due to a bad IRET.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..1daa7cd9a76c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -651,7 +651,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
+		if (user_mode(regs) && !error_code && fixup_umip_exception(regs))
 			goto exit;
 	}
 
-- 
2.43.0

