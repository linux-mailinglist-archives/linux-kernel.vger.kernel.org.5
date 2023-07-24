Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0295B75F7DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGXNJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjGXNJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC85E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08CAE6115B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594C1C433C8;
        Mon, 24 Jul 2023 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690204164;
        bh=vOoS4+QCamT+iY9Eh00e7Wk/cycC5ntyQTwsVvFI2q4=;
        h=From:Date:Subject:To:Cc:From;
        b=jIJ9kqx2u1LVG1cRWEMVxcpo0D5fwEqLKDI69U/N2aJb7hu0IHRKHL4IYd5N2wYa7
         S7qFOf3gpAuIiBC1v/DANwlmFssJcCUsrGu2AN/whbQYpXlKKKek8Wjiy6AHrzl9/T
         PbGHTiL/VbFnZDYbwvRiH3Rw+9DiqNwgceG7sCHLcFOqEEDGMs6lOwCWO8iqEGpaGc
         AO7rTvQlQywxDtdDr04t3wiPU1hQd8vA8minUQxcbMSaBuF85wB4Og6S5NCLYqBNk/
         iY0W6hMh2zedb4ioeYfWwubBJqJ7T0+SNqSrdxqQFrOshRtTAm6LNPuAgrIpfeH2Bc
         gAXkjaTTiDQPQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 14:09:19 +0100
Subject: [PATCH] arm64/fpsimd: Don't flush SME register hardware state
 along with thread
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-dont-flush-smstate-v1-1-9a8b637ace6c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP53vmQC/x3MTQqDMBBA4avIrB3Ij1jaq4iLNE50oImSSUshe
 HeDy2/xXgWhzCTw6ipk+rHwnhp034HfXFoJeWkGo4xVD6PR5TgOuOypYPh8ZUOJUlwh9Fo9w/C
 2wWoPLT8yBf7f62k+zwudgPsIagAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vOoS4+QCamT+iY9Eh00e7Wk/cycC5ntyQTwsVvFI2q4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvngCwWE6M+lN0TnXXRFYNF2vmSQ5VYdPvZFw+ryv
 W2+UtS6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL54AgAKCRAk1otyXVSH0LIYB/
 9BK5jBXbULTxIkm3pOuPbvc7kZ/wFFXmHwGdyUCCmNv/cxJKzwrpwRUsfDulAVw5m6feoaRwhOYljV
 SGRO2AbuWqCLKH3o/DSjiaNhd+PONLZGStojz7spQAPf7ROmrOLQEixWsmPAoh4hVENqa5H/7nG00/
 TZD2kS/7quMdswhdkpfUGC4UREPyFYooao87jgoC+Ia0/gEenjTX1c400cCbS5XQRSv4Xr5KPNEteU
 LiqekWbdushF+vMvqWy0D3wXtX4jYU7wP0Lf+FqsTda/OCFILJxeNSHVpIQE9kxxmxN9wzlqahhknw
 cg7sELNZxb47RTSFFiq34S0wDhjhIT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently changed the fpsimd thread flush to flush the physical SME
state as well as the thread state for the current thread.  Unfortunately
this leads to intermittent corruption in interaction with the lazy
FPSIMD register switching.  When under heavy load such as can be
triggered by the startup phase of fp-stress it is possible that the
current thread may not be scheduled prior to returning to userspace, and
indeed we may end up returning to the last thread that was scheduled on
the PE without ever exiting the kernel to any other task.  If that
happens then we will not reload the register state from memory, leading
to loss of any SME register state.

Since this was purely an attempt to defensively close off potential
problems revert the change.

Fixes: af3215fd0230 Fixes: ("arm64/fpsimd: Exit streaming mode when flushing tasks")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 89d54a5242d1..9d7d10d60bfd 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1666,7 +1666,6 @@ void fpsimd_flush_thread(void)
 
 		fpsimd_flush_thread_vl(ARM64_VEC_SME);
 		current->thread.svcr = 0;
-		sme_smstop();
 	}
 
 	current->thread.fp_type = FP_STATE_FPSIMD;

---
base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
change-id: 20230721-arm64-dont-flush-smstate-c109f4b3f31c

Best regards,
-- 
Mark Brown <broonie@kernel.org>

