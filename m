Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79577E8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbjHPSkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345656AbjHPSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A31B2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 795C16238B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D03C433C7;
        Wed, 16 Aug 2023 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692211233;
        bh=QxvQN53CzFgOBeqWZdUvI6VyFWSQsjCkpHyDHIq9UwA=;
        h=From:Date:Subject:To:Cc:From;
        b=lYadnspxDVRYe7N0hysyQhckggUajPtDyS4kXqm3c3oZPGqSL39EUsxRUeEHgln/8
         QhzV+KdPLpwQrq/Lb2lXp7xPU8cBizT4fJSOK6XRaq3sru/g+s5hEZs8eDlHvFSue7
         6lAtypElIDCunLFlKQCQSlQ18zpE52PvLJPS+vXdxarH5Vr/VVrskpBpq90E7L8bje
         +9E3QFNvq9j2sE04DPxoCnxB4kBcxNlU2G8/aK3IdBj3ZB5cdksIRV2iYMuZhsKgyI
         adbZrcZYayLtMBQyQqfnVbxqyy7Ph56kw4Fq8RA8zWrYqpIhpzXVh9E8yCP0FhN1LT
         FI29ILZOLJpPg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 16 Aug 2023 19:40:07 +0100
Subject: [PATCH v2] arm64/ptrace: Ensure that the task sees ZT writes on
 first use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-arm64-zt-ptrace-first-use-v2-1-00aa82847e28@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAYY3WQC/42NQQ6CMBBFr0Jm7Zh2BIKuuIdhgXUKExXItBKVc
 HcrJ3D5XvLfXyCwCgc4ZQsozxJkHBLQLgPXt0PHKNfEQIYOprI5tvooc/xEnKK2jtGLhojPwMh
 lcSwuZEvyDtJ+Uvby2trnJnEvIY763q5m+7P/VGeLFr2ruDJENje+vrEOfN+P2kGzrusXX8oFs
 8MAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Spickett <David.Spickett@arm.com>,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QxvQN53CzFgOBeqWZdUvI6VyFWSQsjCkpHyDHIq9UwA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk3RgfaK/KBaIRvP4k5Pb2gkrSBV+bA+Ah7Fow0EES
 ESO1BveJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZN0YHwAKCRAk1otyXVSH0KUoB/
 9xW6gxAJnln9XdwuTggxEtZRV6Ql33wTyGIoIU2yfego1rWChUyX/fa6xKbVBnisCvBdbQmkD33bS7
 oajnsavN6q2GahonyAzjUj5JPk6O7uMiFdCGm/pS9/HILFB8eNUafS5R0FZ1HsLGea3cMkcBiJVBsg
 sLotxT9FLhpgi4sRBmeg77V9Z59+Y0kC9y1peiwNgxBdT+Dpwqx9Gkw6zvf6KFxTtyo9GG6RoIDiQS
 A1ReQtYOVhmM9AsAoqofjm9fYMjln5pNQN2T+prqWnbgdQFZgD2gU60PcHbx/uXGnv3QTxnzbooMzG
 OkzkjDYuBdIGNlFIDny+pMc/oA9MRT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the value of ZT is set via ptrace we don't disable traps for SME.
This means that when a the task has never used SME before then the value
set via ptrace will never be seen by the target task since it will
trigger a SME access trap which will flush the register state.

Disable SME traps when setting ZT, this means we also need to allocate
storage for SVE if it is not already allocated, for the benefit of
streaming SVE.

Fixes: f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Only set TIF_SME if we copied in data successfully to match ZA.
- Link to v1: https://lore.kernel.org/r/20230814-arm64-zt-ptrace-first-use-v1-1-fc8e8022140f@kernel.org
---
 arch/arm64/kernel/ptrace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5b9b4305248b..8206127d6e19 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1170,6 +1170,11 @@ static int zt_set(struct task_struct *target,
 	if (!system_supports_sme2())
 		return -EINVAL;
 
+	/* Ensure SVE storage in case this is first use of SME */
+	sve_alloc(target, false);
+	if (!target->thread.sve_state)
+		return -ENOMEM;
+
 	if (!thread_za_enabled(&target->thread)) {
 		sme_alloc(target);
 		if (!target->thread.sme_state)
@@ -1179,8 +1184,10 @@ static int zt_set(struct task_struct *target,
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 thread_zt_state(&target->thread),
 				 0, ZT_SIG_REG_BYTES);
-	if (ret == 0)
+	if (ret == 0) {
 		target->thread.svcr |= SVCR_ZA_MASK;
+		set_tsk_thread_flag(target, TIF_SME);
+	}
 
 	fpsimd_flush_task_state(target);
 

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-arm64-zt-ptrace-first-use-e6595b2162fc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

