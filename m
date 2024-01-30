Return-Path: <linux-kernel+bounces-43666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F24841762
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A67B1F23FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2391273FB;
	Tue, 30 Jan 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpfJiGmv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394D1F5E6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573673; cv=none; b=qHHe7hFg3CmAu7Tc+tE5gKMAo/d63aG2X58hZ8HSenXoWk+Kfn4Hc1xWyP6AqQw7tNBGFutVQHiQYQA+lcSwkj2W4sVIgFnTsxEWOuocZkt9jb2KwJhrBSGeb3udQEbL0dp9AVaMhIkl5tIzRC+BDsg3iECa3sBhyk27QSLTJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573673; c=relaxed/simple;
	bh=xEARPrXco3uTwEMG96xAAVNItcj/45n5YEk1eOwXClE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6hh0jhnLUfmnPRpqN6Yqgk8TgBDp56y2bGFjQl5DtsHcGF9nVxkjoWA89X8RfG6hDtqcUIxs89avYHcJfVixHNaNJaaasvkpFU576H/r82SF6ZEfX9K3Bh8sdGxcx+/NQu9fR24nneh6ytz4/bQxeKrOKc/FIviYBmteonZXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpfJiGmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129CAC433F1;
	Tue, 30 Jan 2024 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573672;
	bh=xEARPrXco3uTwEMG96xAAVNItcj/45n5YEk1eOwXClE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rpfJiGmv2ewynNRmxqcFutzROj92ZWWNfnlXznIBeT9B+qAkKvijXcMfnZjwUVhtP
	 NhihLpFTDJjpzw9k4FF+CfxUhaRDUJMAN+z9W44pz/kDQpbI9Z8RnFAkDkGUQgVI9B
	 n4CT+IUSQzEad1xWllVykN+pTeDuMSOYLYDF1t4f6BckgyttiXv0oLdwODzr9OUYXc
	 ls/2WGTTjNuQ+sZlOL9AJl9NrYlrXF1/pgUCqG41PLpCCa5y/5rD0kztRKovoasGB0
	 57Yc5VeCx+I3SG7p8YWNm/hOdu0+SjuWn7nHfkG3KqTMohlpVrB5+AFbt50tqC9lYG
	 PcoOXd/lDwODw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Jan 2024 00:02:49 +0000
Subject: [PATCH 2/2] arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-arm64-sme-resume-v1-2-0e60ebba18df@kernel.org>
References: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
In-Reply-To: <20240130-arm64-sme-resume-v1-0-0e60ebba18df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xEARPrXco3uTwEMG96xAAVNItcj/45n5YEk1eOwXClE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBluD9i6yBs2MgbbLUzAPKlp1ZuhKTGe0vDXTQl6XYM
 5TVEHjqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbg/YgAKCRAk1otyXVSH0KIZB/
 0VUqbC1WxvC5599zPIxyITE5LsBkJ1mSnsGokZEsNminewQPOex98hDJhyZYzBNMULgL636VUgyLL4
 sLiH4tj4vzBEDIuGN4q8lNnLs7PnrNh2tC1+0u9SAHllCPuognJbWsRWZfbejbYxu16Jwci4KqhTjW
 /TfAx9RQgmbOb4X1qTLpc7Mfd5B7bo4aeJR2ZcLBsRtYGug91XOKzhVX4N4xynZqQatLuzp2A9MK2l
 qUfvY0yLD11I2dQeVp/3Fcqg1rGLOt8MGRt/I/pfBKJaq3UYLb5ueLUMn9G+I1q9Md2h9NuoSaIBk1
 2WysA6QBWN+bsC8h6lTv4xZ30EKYav
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fields in SMCR_EL1 reset to an architecturally UNKNOWN value. Since we
do not otherwise manage the traps configured in this register at runtime we
need to reconfigure them after a suspend in case nothing else was kind
enough to preserve them for us. Do so for SMCR_EL1.EZT0.

Fixes: d4913eee152d (arm64/sme: Add basic enumeration for SME2)
Reported-by: Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 69201208bb13..329782fe39c5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1320,6 +1320,8 @@ void sme_suspend_exit(void)
 
 	if (system_supports_fa64())
 		smcr |= SMCR_ELx_FA64;
+	if (system_supports_sme2())
+		smcr |= SMCR_ELx_EZT0;
 
 	write_sysreg_s(smcr, SYS_SMCR_EL1);
 }

-- 
2.30.2


