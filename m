Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8620A76F2ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjHCSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjHCSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC926B2;
        Thu,  3 Aug 2023 11:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F64A61EAA;
        Thu,  3 Aug 2023 18:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9D4C433CA;
        Thu,  3 Aug 2023 18:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088143;
        bh=95Dt53hR2pyBz39OJo3JRDWSs/xQPgCW4Y8m1VN2MTo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iKhq/fj8MaM0IEbTjBTPoJfjrkSC+hVn0SNJKfrodcO7wm+PSmBwo6mX9rS/4q+kH
         NGkaPQn3CV9peiWVaWBwzHzetYAdlJdIl1QwgHrQZ7KwHAcVYQP6c2KiEN9joGDv+a
         k5COH7hCFhp9SRu2HM++qTzRf6nNV9gXlOFtDmZYvYuRQv6a5x4YSpKCA3aS/5/Kdh
         G7v/O+d/MIuFI4f+/xM2jWRLO4DnV2WOVJUyvIPcSxvKuTHJA1HBwkCEbakQeA5mea
         ShpqaBq1fA6hXTCvv3Sn2TEJqIOFhhFNMP+9P5o/+NgSqLuVc4CKPzt0qoKNkzOzrs
         yyg+HG9Ip8H9Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 03 Aug 2023 19:33:23 +0100
Subject: [PATCH 3/3] arm64/fpsimd: Sync and zero pad FPSIMD state for
 streaming SVE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-3-49df214bfb3e@kernel.org>
References: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
In-Reply-To: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=broonie@kernel.org;
 h=from:subject:message-id; bh=95Dt53hR2pyBz39OJo3JRDWSs/xQPgCW4Y8m1VN2MTo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBky/UG59zUDvfiprOkSFdpvtR91Bq9XADckhG2g6Sc
 jiCzcImJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMv1BgAKCRAk1otyXVSH0GTVB/
 9J8/zx7cdkXvm4pbhhG5E4Heen6fPAuF/GNuXHVhmgPYd/qRn9HZz93uR4OlhvCIkfOcMDsRWZVXZT
 XBjRbHU3zKf/+1X+diJZf22raEPYoYjwJK3EeRQkYjPMHz1DZQu1aPoposJKxxDDgNkzdRqNDSfFOp
 pxF2WiEK0O7hgXtI6r4Nx3OVHgw0oDATOC60HggBmXODZWQIzOpRvvFhgmBDm/F2mpje6VduU3dS/Y
 6mUk3H4BLWwd64hpSiQfc70nAcG4BzcIoE0JItmKd4n2CZd4tVVqSs5AEdat3g61cwd1vYIyzZ92wB
 QcpSFIZpyStyDkPGwIe0m3j4ZOkhG2
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

We have a function sve_sync_from_fpsimd_zeropad() which is used by the
ptrace code to update the SVE state when the user writes to the the
FPSIMD register set.  Currently this checks that the task has SVE
enabled but this will miss updates for tasks which have streaming SVE
enabled if SVE has not been enabled for the thread, also do the
conversion if the task has streaming SVE enabled.

Fixes: e12310a0d30 ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b4afa0d147cc..8e8b853da616 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -835,7 +835,8 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 	void *sst = task->thread.sve_state;
 	struct user_fpsimd_state const *fst = &task->thread.uw.fpsimd_state;
 
-	if (!test_tsk_thread_flag(task, TIF_SVE))
+	if (!test_tsk_thread_flag(task, TIF_SVE) &&
+	    !thread_sm_enabled(&task->thread))
 		return;
 
 	vq = sve_vq_from_vl(thread_get_cur_vl(&task->thread));

-- 
2.30.2

