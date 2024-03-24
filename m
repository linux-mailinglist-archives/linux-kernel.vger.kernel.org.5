Return-Path: <linux-kernel+bounces-113971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB48887AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581301F25E09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C51420A2;
	Sun, 24 Mar 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOJNC6w4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009C1E0E51;
	Sun, 24 Mar 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321094; cv=none; b=fBvmF0mbGvgDTH/GxKQi4v07CNpk2+uLb/Es7DIXSgVyNcsMcQHUajY9oFek21qdpL4yLLfJ/KL+H+yKtZmJfsMpKfpkohrP+P/GQOIdcDTUwoqI0InfhV91H08iaDnDzkBTPs2f5z7zyuShggMyKpNpQeXIhnXCoMl5wOTkRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321094; c=relaxed/simple;
	bh=F+/MumeW7ATglMzz4B+1OhtCCHK9DGl3mp3emN4Bf8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/tm2nvoF2ED0ZxuQ7lbb3tNT7QYNjT3dEMUdt0MNsZrLvd69y3iw7ooset6C8xbFcciw1wZY1Be27dnoeAilhcIN0Glbma+ALzfepldp9atclbjR9L08kPTLIQbvLtuJhNuLBGxmWxQhyeotjmimW+Oh1NTSNMes//IW/QN8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOJNC6w4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947C7C433C7;
	Sun, 24 Mar 2024 22:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321093;
	bh=F+/MumeW7ATglMzz4B+1OhtCCHK9DGl3mp3emN4Bf8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOJNC6w4u2dKYVMoVcKvMKeN+pAeaSuIdyv/n7jgviukds9/C9oTO2yahkmA+z5K9
	 yy+sQ5vPB4Qtw04ojYySVaQ8YC80YJsZySJ4TIHMl5tQynWluJzh6+tQptvqWNB/Lo
	 Ux22BGeDE4yUiX8r+8R8vTOkJ04mUDmUhDknMKactYvdkezu9Q7UXDKZVG3MuAbM8L
	 jCPvc8jz1RHooSU/dSdsaG2MYBPHA/VilE9KyxvbNNccd4SQIAku+M0fvoWie72l+r
	 kz41280YJ5eN0xwsFcFLgC4p3Qu5HvbXn/itCPZnJXRlMOnGrLWVlyeKOAXKQBvcY1
	 4hAkygFNvbShQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 656/713] riscv: Only check online cpus for emulated accesses
Date: Sun, 24 Mar 2024 18:46:22 -0400
Message-ID: <20240324224720.1345309-657-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 5255f8134aeff..1ed769c87ae44 100644
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


