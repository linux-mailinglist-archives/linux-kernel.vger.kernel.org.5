Return-Path: <linux-kernel+bounces-51098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25C84866E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917B11C2320F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A25EE98;
	Sat,  3 Feb 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZgat+VU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15F5EE8D
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965289; cv=none; b=hbZ57OCrcnzwxMJRiMdFxrV2rF6U+X7MKk/F4FeXBxrQOnsT/ORAtnxY2N4wQ0an578sN/YkUtZ432eCZREuGbhQNfpsnURYewWEue95d+kVTDPY0lWsWeP7lSER7jxdQgKU6xl5i9fqUoAb9nFFlCvrPSzrk4pm4hE8/y8WJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965289; c=relaxed/simple;
	bh=EAbTSMPbYo7NkFe23hvp0C1Clui1JNxdOmENIj9lOq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+awT27poWxCZyJwkFiZ3EcXa2VMVLwhqqNjalVAoDLqYb0n6PduQQgFjyTmI0SFLCF0/G/kkzi/huvH2v/ULWflYxzdev2DiB5RhPExIhY7IG8kdF10BnndTJ6PSBV4yups2Ag3u0EJ4KtmmeiWeXUdQ8Kw1otUCYRjE/+DLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZgat+VU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AFCC433C7;
	Sat,  3 Feb 2024 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706965288;
	bh=EAbTSMPbYo7NkFe23hvp0C1Clui1JNxdOmENIj9lOq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uZgat+VUsmUDt+Vq9NXQ25ez0yXRmsrdTc785RA0TkxNDWysZzktZrhq+DvZBQehS
	 07g9F6qjE9YwLzI3x9kyMI/K+qN22xn05WvQ30rztoXp6xCUGc4yoKJMB5VNreR3f3
	 jntral71coziR4sPoD0J7Z1M+BaWDcm9r22tGVv/e3XJ4U6bvM71YSJeTlf0Ifkp5d
	 2CzSOWNtFC+hoEZ/M1z33nLa3Vetjy56LWqGyiQAJmxE09RLyGiPOabhPzpIktTTpm
	 96udRKseP9jOyeood8fNEVx5FnPpvWD5G1zTuC2Onx+4nPceecdNwHIIFat/TcoJ0L
	 7NrZhNO/gkMfQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 13:00:41 +0000
Subject: [PATCH v2 2/2] arm64/sme: Restore SMCR_EL1.EZT0 on exit from
 suspend
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-sme-resume-v2-2-a1fbaddc4425@kernel.org>
References: <20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org>
In-Reply-To: <20240203-arm64-sme-resume-v2-0-a1fbaddc4425@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, 
 Jackson Cooper-Driver <Jackson.Cooper-Driver@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EAbTSMPbYo7NkFe23hvp0C1Clui1JNxdOmENIj9lOq4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjkTOxfeXqJXIwfA+1GogU8KWgiTC8jUf6+WEHcU
 OzK/j2iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb45EwAKCRAk1otyXVSH0BBuB/
 4yB73VEdmQiV/eD2xRwFIagUQD/ROfRHWYDTG+vdDY6evFGYyp+o5jMal0EBnScrQhAtiw5/n0c+0T
 98naJhKjgE+s923Ed6S3yhb2n7K5HoYTMx3JQABL+vO+yD1TH+e8R6X6ZOATxZHRG/sC3oe53o6t22
 thdMDzT2+2Q51RhxgQ1TYuNp36N9Kw4KPUi1skupgKFdislUvyfxpBF7QQbGyBv+A2bMLvcZLfdiwE
 X2LNyCYfP0AunHT4tht1Cg7jscj/j0/DHX3VSkAKL07ZCmNVjV4XkAsESTRGkTkFrlcxSos+3bbLWX
 /npT0r/lQlsn6radcopiLw84Z5Ie5e
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


