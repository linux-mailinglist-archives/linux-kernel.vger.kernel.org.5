Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38A176F2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjHCSoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjHCSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557DF3581;
        Thu,  3 Aug 2023 11:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F67861E97;
        Thu,  3 Aug 2023 18:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D58CC433CB;
        Thu,  3 Aug 2023 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088141;
        bh=VyfjNO5h5r77yO4Y1JW8iCxzkIDFIM1fWR/4Pr5RYRg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PLCPxIk+rX4tVb1dQWIa7fuSns+Q05eQxvWW1pX9z4siJovRzdIkePyyZFfLatKwg
         OKjhAo4UeTFFBQl8ZqVXb+hivg4QBExi/Q1qkURhjOL8a9ElJiC1ouwgShjA1i2Fxf
         jmf/cvlP09V+cY6Jg0DdTJNPRW4GzRP7HwTgv5Cu8KKgRSDsPyEXnDRBwG5z86vwIs
         bg/NJCZ3hLg4KHoHshygIiVaCbkv2V2pkUBoTSkhzQ9rB+tTywray8lkcpbD2DaiEe
         X/LApfLG0zs7LmR2cjVTaQ6eu4oo0mRRWWLy/GIL2U1HZ/dTfw9FvKZq9OCLa7kONq
         aJmqThvOXaYcg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 03 Aug 2023 19:33:22 +0100
Subject: [PATCH 2/3] arm64/fpsimd: Sync FPSIMD state with SVE for SME only
 systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-2-49df214bfb3e@kernel.org>
References: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
In-Reply-To: <20230803-arm64-fix-ptrace-ssve-no-sve-v1-0-49df214bfb3e@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VyfjNO5h5r77yO4Y1JW8iCxzkIDFIM1fWR/4Pr5RYRg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBky/UFuHsJ06H3Tw69T76dXRohdyF0xpCyyRI8oCC/
 d5fJ7SeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMv1BQAKCRAk1otyXVSH0DwkB/
 wLdg/UyqGcamMN1NStA3gnuq4KUFkBMnOgGe0MR/DTXqKb4z5c4AXSdU+WQZ8iFVP1nNFtpPERUinw
 4ePvcXEwRCtiLVET0UOMyq8C06RslgakCPJJ6OgSXVXA18uKXsNjZVnLorkwhvNay5Xwxi39v1OX/k
 RhczmRj2zdB9EACANJtldzSkwNjt82ambXoCiQKkUKIXl/AHUOnlNc47v95rO5+Orn+spJUQW6adk9
 SjKPRalND+QtLZvjmssYZWZZ95FxdBoVPz1iIosAzsfSRp63NMTXCypaergImIVq+q/079uw4cWLC+
 d5oJfnBr7baCUCEDWA7aOHdSUOJrIK
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

Currently we guard FPSIMD/SVE state conversions with a check for the system
supporting SVE but SME only systems may need to sync streaming mode SVE
state so add a check for SME support too.  These functions are only used
by the ptrace code.

Fixes: e12310a0d30 ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 520b681a07bb..b4afa0d147cc 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -679,7 +679,7 @@ static void fpsimd_to_sve(struct task_struct *task)
 	void *sst = task->thread.sve_state;
 	struct user_fpsimd_state const *fst = &task->thread.uw.fpsimd_state;
 
-	if (!system_supports_sve())
+	if (!system_supports_sve() && !system_supports_sme())
 		return;
 
 	vq = sve_vq_from_vl(thread_get_cur_vl(&task->thread));
@@ -705,7 +705,7 @@ static void sve_to_fpsimd(struct task_struct *task)
 	unsigned int i;
 	__uint128_t const *p;
 
-	if (!system_supports_sve())
+	if (!system_supports_sve() && !system_supports_sme())
 		return;
 
 	vl = thread_get_cur_vl(&task->thread);

-- 
2.30.2

