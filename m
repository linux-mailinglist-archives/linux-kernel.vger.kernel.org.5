Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9C77C268
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjHNV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjHNV3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD94B3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B342363CE6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 21:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10E4C433C8;
        Mon, 14 Aug 2023 21:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692048540;
        bh=STaj8td9cui3Me7gAKPjRhUvpBEqCdVFg2sxrc1L9HI=;
        h=From:Date:Subject:To:Cc:From;
        b=AhL+P+uBFabhsqvUHwvcn/C9cJCWPHlWHxKuROpV6jsznxZTZUgn2NEKlMzGCohdG
         9yZPiP2X1XNcP3FdFAGc8nDO9nDcrW2NVgus36y4eIJbi42dxegjrwQ3FSpbF+Q1c4
         4fxBZTMO4Zk5zEbuDQEYRZLZydvARMzLZh2/HGuBSkLN/YB62Pwub2z4MWAR1brohi
         tGrAAU8O1jUMl4CcBeLqYxqS65IlCFBDMZaVyjsEqp0LLcNiutLCaFtEnruzX04Rm4
         tyJRRW1AmPI53Y2Z272N5mytgwgEh1MJBKRWiHCASEeBFcohM+d6FkbiLOG6hyvyEc
         J8g1dn0+0A5fQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 14 Aug 2023 22:27:51 +0100
Subject: [PATCH] arm64/ptrace: Ensure that the task sees ZT writes on first
 use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-arm64-zt-ptrace-first-use-v1-1-fc8e8022140f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFec2mQC/x3MPQ6DMAxA4asgz7VEUoiAq1QMIXWKB35kB1SBu
 DsR4ze8d4KSMCl0xQlCOysvc4Z5FRBGP/8I+ZsNtrTvsjEVeplchUfCNYkPhJFFE25KSK5u68E
 aZ2OA3K9Ckf/P+9Nf1w0EJuapawAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Spickett <David.Spickett@arm.com>,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=broonie@kernel.org;
 h=from:subject:message-id; bh=STaj8td9cui3Me7gAKPjRhUvpBEqCdVFg2sxrc1L9HI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk2pyZZ/Nb87nFg2VvapXZ9y9h4IYNPxLU62q7z+QW
 9R+VjR6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNqcmQAKCRAk1otyXVSH0ANEB/
 9ouLTgbmYnpJIisdgjsP5W5b5VNMtRtmAOUF3MRCipJ499ZTrCSVqPr/EdKKaDYJ+r1sVA0/Zndi3V
 DjarTnhKmGXjin4C4o3uERax+9aWtSuPJ1SMYnH4shcmYNILqZGrCv1HjW6DYRBEqWM96bQwTKIHIe
 iB2mBn9KfKsdsymbr+lKz4p+5zWqwZX6Z0CAjv7bsmbnsMd+uUQLG54jsha6GxfMFnG7CVW/2qCVtd
 a84OAgbRvALu5xSGQxgv5PYMsttI3qGBFb7+dGmRgmkrGVvxEiS3JTteAQ1u4AOS2lOkQD3g+ssNrn
 GVKvDiW73O+BmuDg/dCcOj0+pOF8ES
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm64/kernel/ptrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5b9b4305248b..254eb37e1f07 100644
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
@@ -1182,6 +1187,8 @@ static int zt_set(struct task_struct *target,
 	if (ret == 0)
 		target->thread.svcr |= SVCR_ZA_MASK;
 
+	set_tsk_thread_flag(target, TIF_SME);
+
 	fpsimd_flush_task_state(target);
 
 	return ret;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-arm64-zt-ptrace-first-use-e6595b2162fc

Best regards,
-- 
Mark Brown <broonie@kernel.org>

