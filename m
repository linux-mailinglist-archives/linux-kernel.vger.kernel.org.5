Return-Path: <linux-kernel+bounces-63811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E78534C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F651C2293F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BFF5EE8F;
	Tue, 13 Feb 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd/9uVyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241265EE79
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838553; cv=none; b=Mfyl/7JbSUq0TLqmPcYTxVij9ge/TbdjLCJf2tyR/rZ4BKupnjXikcdGGJy6To6vN/BCy7fOYb8Y610XNm5PlIDUGf3y/qPlsA7SQmQB9J151DThRSQgK5U/4CZYGfDYBfmn63MzjQCsVrNLudlGzhkJSoFFiTSOyGkMEPO2BkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838553; c=relaxed/simple;
	bh=SUBjxkuKBtRVkvGx34gf818xvgGWgaa/xPYwJFrPRlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsKRcHFi7/pkqrHlBciCjumtqavlr4eLFiDXMXE+DMlztzLQTYnK0q9BNzd6+im7H72uFF2DZ0G7Ykbcq9ufn3X9wMJdiW2mZHVbs4u6HwY2DwC6SjU5SGnaMaqXxhC9rftSe8MhdjuyCL8zOGNEGkGVpGZRUTU4PaQzoKoRe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd/9uVyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752ABC43399;
	Tue, 13 Feb 2024 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838552;
	bh=SUBjxkuKBtRVkvGx34gf818xvgGWgaa/xPYwJFrPRlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kd/9uVyyIJb5NAJl3o+ZexzNZwJkGOgxeNr2DwrbbuSFfxBuBBnCxfWzrjldxs9b5
	 fwoK01VQpIJun/p1nejaIMQcLSttc9fgvDlVuV/NPQl/KSsvv2FzNeTHNcOlUmsu3Y
	 +Fg7t9vX/9ybXMMoKbL0ieHkQ7oxJXKE8GF8yM5SXgG8OXZj40nt6U+yttDzgbwFnW
	 HdW4QpVJJrkvZnvRzhaax76ZQIvTjey69jbug2hzpf4sTWczabdocO6Coir8nYd3VI
	 CZzDNzcXpa6G2PhiMPQrcVxw4hvuOv9zrMXvZkwoInPY08oGsds4vA+9mOIVPR4zUO
	 ROIhKq36K23Bw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 13 Feb 2024 15:32:45 +0000
Subject: [PATCH 1/2] arm64/sve: Ensure that all fields in ZCR_EL1 are set
 to known values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm64-fp-init-vec-cr-v1-1-7e7c2d584f26@kernel.org>
References: <20240213-arm64-fp-init-vec-cr-v1-0-7e7c2d584f26@kernel.org>
In-Reply-To: <20240213-arm64-fp-init-vec-cr-v1-0-7e7c2d584f26@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SUBjxkuKBtRVkvGx34gf818xvgGWgaa/xPYwJFrPRlM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBly4xU8jE97v/JDxRmvJyueiHa2XfsWKq9Yvi56jLQ
 ptOViZWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcuMVAAKCRAk1otyXVSH0DflB/
 9VepOmmsuiVYGDQF13XF2tE56zYQ7dQMtVpBtyjZDXvgXXEI1IA/BeL4nUYq2sfeXiSzMyFFybqImD
 Gv6EgNRRqoAs1xXNH9TBCJMYZxLx11YF0apQqr8+VRyOCfl8eF99DhSRV+Im5cG/puiNysDr6j0XKi
 fNxRSdbsfh/y+1upsRPPRWLTOXqCSqDuDkhZz6ZlVpKOUG7zyabwO9v9gMbfSFwbNZUlxjqAXveva/
 duOjOXx1Gjr1RcKcSAcQiMOzXb6hHrSU/cDyAtr7ZvowCzXfLiDc5knyWP+ysnEf79QWOfcbw4oVRl
 H9ox2a/OjlARoFxcgBJ9SVPJ8gVpLr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

At present nothing in our CPU initialisation code ever sets unknown fields
in ZCR_EL1 to known values, all updates to ZCR_EL1 are read/modify/write
sequences for LEN. All the unknown fields are RES0, explicitly initialise
them as such to avoid future surprises.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a5dc6f764195..cc3c9ad877a8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1134,6 +1134,8 @@ void cpu_enable_sve(const struct arm64_cpu_capabilities *__always_unused p)
 {
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
 	isb();
+
+	write_sysreg_s(0, SYS_ZCR_EL1);
 }
 
 void __init sve_setup(void)

-- 
2.30.2


