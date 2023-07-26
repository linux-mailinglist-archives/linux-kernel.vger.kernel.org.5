Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53A7635E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjGZMMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGZMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2D10F6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B4561ACC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B2C433C7;
        Wed, 26 Jul 2023 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690373569;
        bh=wrRT7NFd9Bvr4h7xBlJXhSHiN/+ljJthxlmIl+sdp2k=;
        h=From:Date:Subject:To:Cc:From;
        b=grI3BXVfYuZj5jhxCge8NKby94n2FQl3YTK24XIbikbudu53Q4eYR14zRZbcXd34B
         84nHSdlLomsuo6wD+OTYdlc2V56iGiQiBjQWuRgd0s/K/oHn5UFDTTUROW0mFMCsNG
         G5YIz/9YeK81A7z2JX6DhPBkrQcD1XqV/vVBRGf2Hju0FkbP5+zlctqAoHT07mUY+m
         ME0lTHj0C4tqJ+eWKw5bxXAWr7Z3pu7JYTj/0Tjz5XwzHrLtj+pJlKDXDjk7RkKzl2
         AtgK1DUvs2IQg10ck/uGiLWJV+7iQc+LpKoW4sqwzW+ccmUS9fB1Y7aW76FNwvbi8U
         ldVTMRIf5GPcw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 26 Jul 2023 13:12:26 +0100
Subject: [PATCH] arm64/sme: Set new vector length before reallocating
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-arm64-fix-sme-fix-v1-1-7752ec58af27@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKkNwWQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyMz3cSiXDMT3bTMCt3i3FQwnWJgZGJmaGxqkGpgpgTUV1CUChQGmxk
 dW1sLANpoOjBjAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wrRT7NFd9Bvr4h7xBlJXhSHiN/+ljJthxlmIl+sdp2k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwQ28nT3oB11vx/d16fqseVTVUqaRsgrKAtmNy
 7sVPEzG89eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMENvAAKCRAk1otyXVSH
 0I6iCACDyTJUice6NN3V4UbafqIBKJvRShR9TOXwtyNBAMs9qbt8MFZmV55YzspCkfwf5l8Dhth
 vGDCx5PDl8FrsctTwa8RtjLos6eNCUFcuMHoQRJ9vRURjIjccUSdzRxwYmAjj8uneKEaixZvx2L
 Mx5R2lwmC21SbxNo3Ocgil663++UgQvvJ77LW2qY7ZfPumBTF3mydC6E7tf5c8P1CLmwIGBPbDq
 rv9vy7dkmX1t7UnGxRCfumZOYMfXDSUa/7hq3x8E1lwDtjGPAtALRsC5Gz3JoONVFANgzRBEdv1
 3Jwy8wLbX5SD9YOK/z3q+jKhWd6FkQUfDs1Ew9VpulouyAjA
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

As part of fixing the allocation of the buffer for SVE state when changing
SME vector length we introduced an immediate reallocation of the SVE state,
this is also done when changing the SVE vector length for consistency.
Unfortunately this reallocation is done prior to writing the new vector
length to the task struct, meaning the allocation is done with the old
vector length and can lead to memory corruption due to an undersized buffer
being used.

Move the update of the vector length before the allocation to ensure that
the new vector length is taken into account.

For some reason this isn't triggering any problems when running tests on
the arm64 fixes branch (even after repeated tries) but is triggering
issues very often after merge into mainline.

Fixes: d4d5be94a878 ("arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 89d54a5242d1..c19092642920 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -917,6 +917,8 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (task == current)
 		put_cpu_fpsimd_context();
 
+	task_set_vl(task, type, vl);
+
 	/*
 	 * Free the changed states if they are not in use, SME will be
 	 * reallocated to the correct size on next use and we just
@@ -931,8 +933,6 @@ int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 	if (free_sme)
 		sme_free(task);
 
-	task_set_vl(task, type, vl);
-
 out:
 	update_tsk_thread_flag(task, vec_vl_inherit_flag(type),
 			       flags & PR_SVE_VL_INHERIT);

---
base-commit: d4d5be94a87872421ea2569044092535aff0b886
change-id: 20230726-arm64-fix-sme-fix-d02461350e06

Best regards,
-- 
Mark Brown <broonie@kernel.org>

