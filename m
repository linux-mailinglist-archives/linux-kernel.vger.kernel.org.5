Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1840776F2F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjHCSo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjHCSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A5E2D71;
        Thu,  3 Aug 2023 11:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FADD61D5F;
        Thu,  3 Aug 2023 18:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D220BC433C9;
        Thu,  3 Aug 2023 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088139;
        bh=Q6O8ubzpvyVkC7Ej05HHTMDmMzaSvsK+JutbFIX5e0s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kbZKyYeaOPPCdZwv7ubKCh30NYJEYWQwYEs4BlcmwX/AG14B7B6ct/NmSi0zbpqsx
         OVyotPmnROQN6BVOA3z8VZId3WESsSfGApoeqc+H7yJ/sHo5AiFx9k5QeyRfZt+EyF
         hlGi0RfK8daFyAL1olp5gPwXJavKRZ5KPaT451qbPWWSjaV37nLiMluN3KQojMhAQg
         ZCIgjjxr1vO+6suD9s6qPMcql75EfBIgE2Z+8/QjiuNUiU99XryURAkW1R200TDTaT
         pf91yjzszWJCzttRb+YnST1bQtYopbzyfT4MXlXvEloW8Ja3GM6hl/FpYVgaz6te20
         AdlVJ3tGizmlA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 03 Aug 2023 19:33:21 +0100
Subject: [PATCH 1/3] arm64/ptrace: Don't enable SVE when setting streaming
 SVE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-1-49df214bfb3e@kernel.org>
References: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
In-Reply-To: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Q6O8ubzpvyVkC7Ej05HHTMDmMzaSvsK+JutbFIX5e0s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBky/UEmwKiFjTRvpTlHWMHkQ3ykgHly+u9CiYxdtUF
 dR5Ms1GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMv1BAAKCRAk1otyXVSH0FFnB/
 oDTbLZARptJWnKqqaplgnHepLKSsvOpQBNaEbXDpncgv2gLndEkIFNdsoOtoTlVUZ913ZFKFS47HsY
 rnG7oslf0LQHCR9yaGudN08M//nV399/8H6ScITDlRnBzZ10LSiPQDTlO6GQuChG5hGYRCpxXIjAqA
 aT4TQHHiEuesDQhMN0TkwVvc6qcVCZY/dtUvtE3k7yrs7REHhQgaWtaBAxBWO9VGiKVFUjq3bPohsW
 xu28lbFnYprLSi0sWEdIya02W/YR+7lzsVcwqXyr44JRusdNUDN6j0/WbgTgjrMpeRAmkkYOeAwy7H
 V7tFlkiySYs7gDWDM3uzOHoPVxHjNu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems which implement SME without also implementing SVE are
architecturally valid but were not initially supported by the kernel,
unfortunately we missed one issue in the ptrace code.

The SVE register setting code is shared between SVE and streaming mode
SVE. When we set full SVE register state we currently enable TIF_SVE
unconditionally, in the case where streaming SVE is being configured on a
system that supports vanilla SVE this is not an issue since we always
initialise enough state for both vector lengths but on a system which only
support SME it will result in us attempting to restore the SVE vector
length after having set streaming SVE registers.

Fix this by making the enabling of SVE conditional on setting SVE vector
state. If we set streaming SVE state and SVE was not already enabled this
will result in a SVE access trap on next use of normal SVE, this will cause
us to flush our register state but this is fine since the only way to
trigger a SVE access trap would be to exit streaming mode which will cause
the in register state to be flushed anyway.

Fixes: e12310a0d30 ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/ptrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d7f4f0d1ae12..8a85dcc66597 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -932,11 +932,13 @@ static int sve_set_common(struct task_struct *target,
 	/*
 	 * Ensure target->thread.sve_state is up to date with target's
 	 * FPSIMD regs, so that a short copyin leaves trailing
-	 * registers unmodified.  Always enable SVE even if going into
-	 * streaming mode.
+	 * registers unmodified.  Only enable SVE if we are
+	 * configuring normal SVE, a system with streaming SVE may not
+	 * have normal SVE.
 	 */
 	fpsimd_sync_to_sve(target);
-	set_tsk_thread_flag(target, TIF_SVE);
+	if (type == ARM64_VEC_SVE)
+		set_tsk_thread_flag(target, TIF_SVE);
 	target->thread.fp_type = FP_STATE_SVE;
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));

-- 
2.30.2

