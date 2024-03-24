Return-Path: <linux-kernel+bounces-113541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1871D888527
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A4D1C246A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083CA1C1C12;
	Sun, 24 Mar 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3OmYPeD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BC1C1BF8;
	Sun, 24 Mar 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320343; cv=none; b=eQUgVtxu3jac0t+xJ/QcYDi9CW63MnUKxq8X9TWpxI83MVB6uMoWTCcXlw4XcpC/o5u7w17rNwReGXv3DAOZ9iLtN5Zv8yeHoQkZyoRPYNWFcg3Hg1hYZVf6Zc0LfQIgAMrE3QoGi2JROZXOM+NGGoaP1rIeBAfFZD0XhP9S5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320343; c=relaxed/simple;
	bh=EQayvAY48XGcdY/Bs3X19JhpOzFM3Evjdmnwpr0g0Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQFxv9hO0dnoumWdkWZAQ+iRQ3dGLPo4j1t28kfuaOKh08wQN82r3Wkt6p81rC5XRcQlglWB2Xly/td8XXlMtfeYwTujUnoGcNVaFAjFBFrzptqEbkC6t3/5kNo0BMMofCs6pCYUZXWJK2CSwlkaOCCV/VoUH2r67YxggUVPQ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3OmYPeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B65DC433B2;
	Sun, 24 Mar 2024 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320342;
	bh=EQayvAY48XGcdY/Bs3X19JhpOzFM3Evjdmnwpr0g0Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3OmYPeDNlipUeO9IzihAS3SnqAWGzm/IUlE8h2UQ4UAaPV3V8ZYftfqftBRmXEf6
	 XY2EYxRKvSHJk5KDRoxSjYiTSzfxAhRjCDE9KCojiAbVpC/GwZpaG175ueOU9yElFX
	 YH1ZP4lL4Dzrn7XbXLd4xBuoUj3G5GfvNh2d9gGhxInBVplQJEiZUzeXO8TLAyUlrC
	 M3xsWTugej1nOCYTglyFH3g8KH6Mzwxu2iJPotIvKjs368RO4hb49aer0cT+XvwKpS
	 b9wmX2c6cydkadCTFLaAi8a4zCZ+H8k1FGTjhXOUXOCIxsMmD+Rlv3/wtGmiCvHAp1
	 wImPT6tT1vu2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 650/715] riscv: Only check online cpus for emulated accesses
Date: Sun, 24 Mar 2024 18:33:49 -0400
Message-ID: <20240324223455.1342824-651-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Charlie Jenkins <charlie@rivosinc.com>

[ Upstream commit 313130c62cf1fc410ac8730b291fd4fde582d032 ]

The unaligned access checker only sets valid values for online cpus.
Check for these values on online cpus rather than on present cpus.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/r/20240308-disable_misaligned_probe_config-v9-2-a388770ba0ce@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b1..c2ed4e689bf96 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -632,7 +632,7 @@ void unaligned_emulation_finish(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		if (per_cpu(misaligned_access_speed, cpu) !=
 					RISCV_HWPROBE_MISALIGNED_EMULATED) {
 			return;
-- 
2.43.0


