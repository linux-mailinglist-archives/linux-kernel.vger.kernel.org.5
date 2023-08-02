Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A004876DBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHBXrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjHBXrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:47:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8161BF1;
        Wed,  2 Aug 2023 16:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A89B61B7F;
        Wed,  2 Aug 2023 23:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BEBC433C7;
        Wed,  2 Aug 2023 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691020036;
        bh=/qLrq5KmhPCru0yGNrw689Q7iuDeimHvE/3JmRSDTww=;
        h=From:Date:Subject:To:Cc:From;
        b=AwGQtqIPzjbR8wMuR5jn2X71Mwj4xDLmlhgEmXwS6B3MUajRsljJLfcJoV+JWzkpB
         RzPxVWhsI3E/BTIFE7+Idh22k3TjJLZTFlUeLJw1YvZFYX7vmg22cAl+M2dUjKuYC0
         ZSLPwBslwt6qGqlztOwGzXdAErfHGcQ6kG+/z3PtP0RsYMVGjfEgI5mGuDODF4FL/6
         90DddhJfnLjAH6LEDvcwRiZ9pPGVbIK2huHwt9lvNmfl1amXfswQFM+TabHFvKrpJl
         0w/BZs6N3v33CFxpF/PiWFd91eQPWJtYj/SWmMXP71Lu4Mc+pjZIgpPbEpQuIN2MUc
         VKLVj7VY2RgMA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 03 Aug 2023 00:46:39 +0100
Subject: [PATCH] arm64/fpsimd: Clear SME state in the target task when
 setting the VL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-arm64-fix-ptrace-tif-sme-v1-1-88312fd6fbfd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN7qymQC/x2MywqAIBAAfyX23IKZSPUr0cF0rT30YI0IpH9PO
 g7MTIZEwpRgqDII3Zz42As0dQV+dftCyKEwaKVb1SmNTjZrMPKD5yXOE14cMW2Eao6hN77T1gY
 o+SlUrH89Tu/7AXktrpBqAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/qLrq5KmhPCru0yGNrw689Q7iuDeimHvE/3JmRSDTww=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkyusCoD1cpgdbLKtmBqNR295Gzu5KbTY2MY4nxVPB
 0NnJ2mmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMrrAgAKCRAk1otyXVSH0B3JB/
 9WoAz7QxboWYtzDkqt8/cmsOqEMDh0uIswB63EKF0rOJZSkukmRnuVUIIt01kyH9jEh6/CfbJeIhMX
 COMMFmM3tzymxHyb+FQOU3sFXzx+GxDmQiB79Jvwhh9+djemFdAKmSkOjmZROUrl+cGhPiGSbfpwRl
 t230mvLmbkeDajUEwoCeiFjRnH8prZPX8yfCEaLWFslWxL3I+awa2jrGm0XSwkmojp5oFAueyYfrnu
 2NwKEiwEjAi6pDcqqueBmmkR94EiKYlEkbk2X9rkUeTIXO/MteVFapOop7v7kuwNJRSZfRRAhDQoE+
 sB21YuxIJTucBsPanLSxDuQwgrole5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting SME vector lengths we clear TIF_SME to reenable SME traps,
doing a reallocation of the backing storage on next use. We do this using
clear_thread_flag() which operates on the current thread, meaning that when
setting the vector length via ptrace we may both not force traps for the
target task and force a spurious flush of any SME state that the tracing
task may have.

Clear the flag in the target task.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 520b681a07bb..a61a1fd6492d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -909,7 +909,7 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 			 */
 			task->thread.svcr &= ~(SVCR_SM_MASK |
 					       SVCR_ZA_MASK);
-			clear_thread_flag(TIF_SME);
+			clear_tsk_thread_flag(task, TIF_SME);
 			free_sme = true;
 		}
 	}

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230802-arm64-fix-ptrace-tif-sme-0bfd94c8266d

Best regards,
-- 
Mark Brown <broonie@kernel.org>

