Return-Path: <linux-kernel+bounces-44875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB1842862
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7A91F2765E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA182D8A;
	Tue, 30 Jan 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M973pKRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3417F7F8;
	Tue, 30 Jan 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629813; cv=none; b=Yoc/GzbYHCccupUIOFZjet8YMa3g8JhZgfTqaGLu9XEx+eRCkYn9buaaXNUN15VBO8awiatxJFuic85g18eX8DkGmBYyeWqKVaYh/saN4+eiEmJ0IvwMSd1ZsGH7zL0Ek7AC7VGHU0aHGpeMXqQdpYQXEVuCEZuLxacsJWPu1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629813; c=relaxed/simple;
	bh=Vk+a4/PMaLBaT+nR1i1sQXCbsnZJFcPjFylI7eVgV6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y38bnktNgc2EqRUaYIwMG+VkoluOG/PjQPautmMKkO2iFhZojBJ7y8Jhx1XP59Lo5kLry++zxzx9JH1Ms4NrKMYAussksdoI1aaY0CsjuER8o8GsDo9conxKzYitoODrlDUTuF8XMUgZ8k0EyzuJ5eXj2tGHyBXqG/yYMiBbjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M973pKRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161BAC43390;
	Tue, 30 Jan 2024 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629812;
	bh=Vk+a4/PMaLBaT+nR1i1sQXCbsnZJFcPjFylI7eVgV6Y=;
	h=From:Date:Subject:To:Cc:From;
	b=M973pKRE6MfhRjYhN/QX9P4MIQdalu8v2X3PRR4X2wkpeF5HlJSrqVSgv0cfoZRte
	 byNduhOFiXGGCs0nEyoN+41yhcwLWbZDwKRw3/EQgJ+0PdwIj6lk2OOoq2OE3dQ/It
	 muBxO+dRteoisnZlfjG+GpK4uz4SRL2bG+GXBk6DVkJiyNYtmENYWnA8Lqu4Z9N+V8
	 Tf26BdKgVrF6jKZT5aRhf94VyY5Cjssfkk+CRC5XN4Sc4nUFvTnvsUHjOCACL3HOn3
	 bq6fA0xPEyV0FZK3LTxxpVX06/yHXKrKED5TCF4qBBFDbtv8HoAsHChH0WjljAmYF7
	 ENi08H6//CVBg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Jan 2024 15:43:53 +0000
Subject: [PATCH v2] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-arm64-sve-signal-regs-v2-1-9fc6f9502782@kernel.org>
X-B4-Tracking: v=1; b=H4sIADgZuWUC/3WNQQ6CMBBFr2Jm7ZhOAwiuvIdhUWQojVjMjGk0h
 LtbSVy6fC/57y+gLIEVTrsFhFPQMMcMdr+D6+iiZwx9ZrDGFoaoRif3qkBNjBp8dBMKe8XySMS
 mJ1PYEvL2ITyE19a9tJnHoM9Z3ttNoq/9FZs/xURI2DVDX1FnbN24840l8nSYxUO7rusHZNnBz
 LsAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2358; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Vk+a4/PMaLBaT+nR1i1sQXCbsnZJFcPjFylI7eVgV6Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBluRqyMHHatjsuh3dci6BH1TGN/k8YOn3ayYgBl2xd
 Ylsce+6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbkasgAKCRAk1otyXVSH0CWgB/
 9EgqGXGKiU/cckQpSisnL3ThKknzqaZLsTFUsNS7B7DhLmSNufzrK+9UzTncwxTV3dvF6hoNg26pep
 iGC3J5/DWPnFOhudx5hLftkNu8HWRICd819Zl4G1UAFnL5RCL3g1JrvvbC2doFWVAOknqz3u9uro+A
 RA/ULVS00sIN+1vPXCeUcsjDwyfvHeN5UP2/nxHHUBz2z0Bk/sT7clfE1ngtd4Jvbt3tVIPbDmP/vA
 RsPakFYbyZNrrJivLxbx7FwtC11A46INvB41FdUV1Le7GUxNPlIorIMHf20CILIkaZTCXHxRa0/0g1
 P1qqOvKFDLw+8aWGNm81vhM2cxFJ3l
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
Cc: stable@vger.kernel.org
---
Changes in v2:
- Rebase onto v6.8-rc2.
- Link to v1: https://lore.kernel.org/r/20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 arch/arm64/kernel/signal.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a5dc6f764195..25ceaee6b025 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1635,7 +1635,7 @@ void fpsimd_preserve_current_state(void)
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
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240118-arm64-sve-signal-regs-5711e0d10425

Best regards,
-- 
Mark Brown <broonie@kernel.org>


