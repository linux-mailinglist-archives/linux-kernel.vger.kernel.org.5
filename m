Return-Path: <linux-kernel+bounces-113652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460E888E29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1417298178
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8E144D11;
	Sun, 24 Mar 2024 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sdmdcf5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825861D5662;
	Sun, 24 Mar 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320565; cv=none; b=aYJbMHO4LKHfDisPbD0n8UYy7175ZAPx9tLYpIOLKaACCCyQYFjlmYTmibWR66+Qr9NEavrYh+pZ7e0PMknWOfGAqgq4NIic2Q7eKHp9ub8FNewFtPqyJP7Ven3rufcPc8zTXpj54avtnj6KQRjeF7FKC1M3AsP+VKtsiazudd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320565; c=relaxed/simple;
	bh=jdfu/KH7YL1zTK/NxSGJU5Hr4wSQlNuG4dX03k2hbfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyRbH4LXwQ3SKg533yJZLCNye2gb2GYUrkGYlLEGKOw4poVMP4LvTSVboAe2/liKEOni/D+IsS9xLrhw7J78hDaMST4A9LDjzjEQjDD+11veMOQgfaXckIFSHE/Z83Q5Wv9SBCuhKUC4zBn7aE8SzmIWwU9YrSMFdM/i5DklO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdmdcf5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C8FC43394;
	Sun, 24 Mar 2024 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320564;
	bh=jdfu/KH7YL1zTK/NxSGJU5Hr4wSQlNuG4dX03k2hbfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sdmdcf5QLWbtMx8AoTZ5Ao9cd2IG3nAsBSfgodkwAdaU4BdHQ1s9491aUU0uMZTAP
	 XnSVE/w/Obi138qBxwaMRefKbaQr0VCm7WcxWXkVMJLHaBDRq+E6CLq/TvJZzQwuQj
	 KjEj08QDUuJUSFnRaGjq/IVD0HWUxBowRaeRvDQZUzsK3NYQcPR6MTWyHQU6jp6hot
	 BlZpVyDvJMQfj6Sjwg9ZHx1WK0MUbLwUKo3HfRpQlxflwV9qAhNk+CpULdqLpQkBZP
	 CKBPmBbbxVxosuGYBbqKl30pUoDqNyfJXysnzpcW2379WhVHRyb5s0Jv/zFYW0Ujf7
	 /+vLL2XQflU5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 125/713] x86/sme: Fix memory encryption setting if enabled by default and not overridden
Date: Sun, 24 Mar 2024 18:37:31 -0400
Message-ID: <20240324224720.1345309-126-sashal@kernel.org>
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

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit e814b59e6c2b11f5a3d007b2e61f7d550c354c3a ]

Commit

  cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in sme_enable()")

'fixed' an issue in sme_enable() detected by static analysis, and broke
the common case in the process.

cmdline_find_option() will return < 0 on an error, or when the command
line argument does not appear at all. In this particular case, the
latter is not an error condition, and so the early exit is wrong.

Instead, without mem_encrypt= on the command line, the compile time
default should be honoured, which could be to enable memory encryption,
and this is currently broken.

Fix it by setting sme_me_mask to a preliminary value based on the
compile time default, and only omitting the command line argument test
when cmdline_find_option() returns an error.

  [ bp: Drop active_by_default while at it. ]

Fixes: cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in sme_enable()")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240126163918.2908990-2-ardb+git@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/mem_encrypt_identity.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index d73aeb16417fc..7f72472a34d6d 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -507,7 +507,6 @@ void __init sme_enable(struct boot_params *bp)
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
-	bool active_by_default;
 	unsigned long me_mask;
 	char buffer[16];
 	bool snp;
@@ -593,22 +592,19 @@ void __init sme_enable(struct boot_params *bp)
 	     : "p" (sme_cmdline_off));
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
-		active_by_default = true;
-	else
-		active_by_default = false;
+		sme_me_mask = me_mask;
 
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
 	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
-		return;
+		goto out;
 
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
 	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
 		sme_me_mask = 0;
-	else
-		sme_me_mask = active_by_default ? me_mask : 0;
+
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
-- 
2.43.0


