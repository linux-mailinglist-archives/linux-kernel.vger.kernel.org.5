Return-Path: <linux-kernel+bounces-31132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D287832980
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0992C286FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9A51039;
	Fri, 19 Jan 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPw4y9ha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB151C31;
	Fri, 19 Jan 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667446; cv=none; b=mQekVYb6fP4bP4KZXwLBT4Oo+RVvIempOsB0NW4stT1NZXbg1TSOcaNU7zfOwW7uQvt0XfdFy0qnHI6lno/aVgRLs/D4eXoidyzLg1dCa5rm7bYHFpEHV9oe1ISow1Q5rJ1OAqbNMO6VSDQSulIQlc0QINZDRMk6M5ph+mAc6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667446; c=relaxed/simple;
	bh=lf/x0Quh6MyKXlY1+sTXB9JkbW7K3Z8gqVYtKQnWovY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iGF4rT4JyO4JMj6gOp8So3kpT/5q4mWfGezxEB+2ruJ3a1S6pW4B5xreRcJtjpY8L9uy2tsHpJhDT01Z9p2mnsg3Qbae4kM23twYabH1hEh8g19E9q79jqdPv75wCNiVVlr2Cq6A2uamArzomCiblcDWov+Fhc5V6cArQZcy8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPw4y9ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AC8C433F1;
	Fri, 19 Jan 2024 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705667445;
	bh=lf/x0Quh6MyKXlY1+sTXB9JkbW7K3Z8gqVYtKQnWovY=;
	h=From:Date:Subject:To:Cc:From;
	b=RPw4y9haj2MJnJkAI4qo+e93kxuyl5RduirN7CTQDBURa2SIqCA/aLSYrPCQtIv5z
	 mu6Dq8R/4bK1DJl9aRJg9OsZPvMc89qttUU0VPKMerKbXSnw1S/sxEn+C1GfHSoYr7
	 goHrVsXGiZSttzcu7uoTxD87SLLkhInwDtz7RR7uDOVeDqmB60966z0zsOSLta+i+K
	 eoNn1aJiTf1DAj6/SwoGkqfib8um1skRnMUCeBDMCMBnKJFGunny29p22LrkNSjv33
	 cAyuRYUYYtuGC952IlvmCrDTDcEcZA6hJy4rOKhgyHS6nPks2KfsIMmXKMg4HWgg7V
	 m1Ic4J6otPVUA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 19 Jan 2024 12:29:13 +0000
Subject: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved SVE
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
X-B4-Tracking: v=1; b=H4sIABhrqmUC/x3MQQqEMAxA0atI1gaaUnWYq4iLYmMNOB1JQATx7
 haXb/H/BcYqbPBtLlA+xORfKqhtYF5jyYySqsE7HxzRB6P++oB2MJrkEjdUzobdQMQukQu+g9r
 uyouc73ec7vsBYpiLk2cAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2214; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lf/x0Quh6MyKXlY1+sTXB9JkbW7K3Z8gqVYtKQnWovY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlqmtzPBMCsko55/jXqsoxUluay7LXpo0hu0HjvHCz
 PZyP9CSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZaprcwAKCRAk1otyXVSH0HPNB/
 9y9XJ+fJvmEyASUiIVu/UIAd2Qk4l3C66okxn9mI/S7VqLaUHEh9tLhMijFVytufDmIC4m753GfaAu
 NSRv8819LWicnjdi4blAutRme2U0WOXNCiY6XR1jUHlzcPF61O+wd6tzc1mHf9SFFFIotsS+SuoDUh
 QaV3za/dMkCpofz8EputuaEV4eL3hbwSsZDwGVQCL7IG7PhIZqLvQE0s55GT/BaE5QhLCiTnBPWMUG
 wV52GMdSPH1yuGo1AiztVv3dpjz6R4fexQa18A2M1n3fgj6cgXc9n4k5+Lfs6ZxrceVU/6I8YPutCI
 P0cyhNis9PwLTRZUlAXnX2tqRVPYHU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we are in a syscall we will only save the FPSIMD subset even though
the task still has access to the full register set, and on context switch
we will only remove TIF_SVE when loading the register state. This means
that the signal handling code should not assume that TIF_SVE means that
the register state is stored in SVE format, it should instead check the
format that was recorded during save.

Fixes: 8c845e273104 ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc:  <stable@vger.kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 arch/arm64/kernel/signal.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1559c706d32d..80133c190136 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1626,7 +1626,7 @@ void fpsimd_preserve_current_state(void)
 void fpsimd_signal_preserve_current_state(void)
 {
 	fpsimd_preserve_current_state();
-	if (test_thread_flag(TIF_SVE))
+	if (current->thread.fp_type == FP_STATE_SVE)
 		sve_to_fpsimd(current);
 }
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0e8beb3349ea..425b1bc17a3f 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -242,7 +242,7 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 		vl = task_get_sme_vl(current);
 		vq = sve_vq_from_vl(vl);
 		flags |= SVE_SIG_FLAG_SM;
-	} else if (test_thread_flag(TIF_SVE)) {
+	} else if (current->thread.fp_type == FP_STATE_SVE) {
 		vq = sve_vq_from_vl(vl);
 	}
 
@@ -878,7 +878,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 	if (system_supports_sve() || system_supports_sme()) {
 		unsigned int vq = 0;
 
-		if (add_all || test_thread_flag(TIF_SVE) ||
+		if (add_all || current->thread.fp_type == FP_STATE_SVE ||
 		    thread_sm_enabled(&current->thread)) {
 			int vl = max(sve_max_vl(), sme_max_vl());
 

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240118-arm64-sve-signal-regs-5711e0d10425

Best regards,
-- 
Mark Brown <broonie@kernel.org>


