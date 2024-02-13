Return-Path: <linux-kernel+bounces-64507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE62E853FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA24328C326
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F763401;
	Tue, 13 Feb 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAJ8LHag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDB633E9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865638; cv=none; b=oZ48Ja3Dkav+Qhyx0cV/38KCkBczeLC/gRnfsU4o1NwhqpYL+aHqIeF1JC4dgseohOysJriTfJMF19PrdCnEtNW6ejmGTOu9ga+7B7tkWsVTSkBVDsTKfpF2thP5ofBVDr1OQplWZ3XgjB5RYv8vNDNUZX0Vd6WqFzzrSyVkGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865638; c=relaxed/simple;
	bh=EAbTSMPbYo7NkFe23hvp0C1Clui1JNxdOmENIj9lOq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eyOlYLjqqxsstEnv/9LWjL3xh0Mecp+YYQbUPMDMXxgFgos+Tm/ziDnmfUrvJf3S1tKVsnbMKCvyBGj/fqyWwG0w+29oIBHpUgBrlfofTSKRBr+bdzE2vMol5bX7g8r1c+YN+uuYMjigKx1AKiTmlES2uuARFlJA7a+OW7tHVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAJ8LHag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A2EC43399;
	Tue, 13 Feb 2024 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707865637;
	bh=EAbTSMPbYo7NkFe23hvp0C1Clui1JNxdOmENIj9lOq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hAJ8LHaghvkkxiqweYcM+tjPbcoozyj5+8nI1gtLU/uVOCVrHD7A9LBc0o/34npev
	 SK1vQzANlK3ndNgpc/RLlEWZi8l46QgqfgZAATTea1mP2gJWG7LpxoM9M/AQX/bZdh
	 KU/1RK7GCoTOG17RZJl40JGHJO5ReH1kycxLs5ax9hg/0utXfaaJVgfLGDeu4/JX9K
	 VsKAt4OVe3KZpNIG88AnBijgOFUlG0qECnDyIFqig/6TWlYOaQn2kOwM99tqWnQhic
	 w7xb1AG+v4dSLu/NxhQMaqLNVVI1fDRdZrpcIbNVanXzZcSHdhHjbRSCVN92jJw5sX
	 k4P3ED7ZIg1zA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 13 Feb 2024 23:06:33 +0000
Subject: [PATCH v3 2/2] arm64/sme: Restore SMCR_EL1.EZT0 on exit from
 suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm64-sme-resume-v3-2-17e05e493471@kernel.org>
References: <20240213-arm64-sme-resume-v3-0-17e05e493471@kernel.org>
In-Reply-To: <20240213-arm64-sme-resume-v3-0-17e05e493471@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EAbTSMPbYo7NkFe23hvp0C1Clui1JNxdOmENIj9lOq4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBly/Yf2kx5jbZv4Nhm4KK9MO6SBlZ5G5dJiR7zhNs8
 y2ljCYqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcv2HwAKCRAk1otyXVSH0OLCB/
 wIv2Gm5BjBWurapN1ify5+sQprymBHlpMubMEOS4g3KPoR522jMOGZh3OxMw/l0X3TiSza46yYr7Cr
 OH5chMq2fJnNrbOsO/jsBLE2wiHdLCdI8AYmlBmKRVJijQU486QLCnKVckNHph9svDlQIx8GPzCp3N
 JeR3Q+L2salvs5LqJO2jnCsrC9iVQqPaU4nozI4eWcSvRkHWf+51QK7Viy8blrlXZP4irrh3XobJRI
 o9uwhnXaNwGPnd0V31PDawbO190djWiylohffo0Xba5PSGDus/4gvqmE+1OizjoTi1P7NN3GZoDZqa
 fVhSQTM57RcDXbF8TuKZo+6p03+e26
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
index 8d2a5824d5d3..7a7c056f0647 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1320,6 +1320,8 @@ void sme_suspend_exit(void)
 
 	if (system_supports_fa64())
 		smcr |= SMCR_ELx_FA64;
+	if (system_supports_sme2())
+		smcr |= SMCR_ELx_EZT0;
 
 	write_sysreg_s(smcr, SYS_SMCR_EL1);
 	write_sysreg_s(0, SYS_SMPRI_EL1);

-- 
2.30.2


