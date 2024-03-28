Return-Path: <linux-kernel+bounces-112935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40688887FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C8D1C21160
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB176044;
	Sun, 24 Mar 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEVTuLiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34F7581D;
	Sun, 24 Mar 2024 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319748; cv=none; b=u3f2hMwlFOeUh81isHedBem6pjg4IqYBFgspg436Chxv5NkYPSSgeFOdYfgQc5BARfa/aRh4ZIFSnQ9KpzCDBW7HentcTyaF6iVoKkK6SjUWIyBPINr7GxTnGl4iT44Ed66EPJXdBkwHl12Bpp7DXeWKgNHgw0769VWUDJ8ZHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319748; c=relaxed/simple;
	bh=jdfu/KH7YL1zTK/NxSGJU5Hr4wSQlNuG4dX03k2hbfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmUOZpuAz/+jTGjQk2dkejoXvw79hT62mOiOde8voaOSmed+2Z+UdsgVYBr4Yew+hvOU5aZmw+U98LnXT5cjq3nzEGQbcHJYHw+ELjv29/vVIhAI3yz+OcC+kLMzjawSVtIxYQJZRZ496PXnVjiAodUzM08ONSx3Sy9X+d4zcMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEVTuLiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3111C43394;
	Sun, 24 Mar 2024 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319747;
	bh=jdfu/KH7YL1zTK/NxSGJU5Hr4wSQlNuG4dX03k2hbfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEVTuLiGbR+vNSCr/CGK2srh6YoFhdlD94/9505MI7COig8Clzvt8Tt2rKgqN7dSv
	 zKAcfKSkAquClJRstz+GUpkP6kiqKq1n4x2ybKP5N7FUDJ0LUOoyJTYPzQqokzLzA8
	 JT72elH8C5okPDtbKfBWj8lBvRq3RCy91ptPVSRCB85G0OnIaWmLwihN1gqo0+Ba2r
	 a48c9EHig9+Tzd4AwZU9I+BebVW8dEWb2HyuI9yoMC2uenGxHHOC6VwfvvlbL8owbs
	 pEtBzwElSYd2rUir4hr5PqUsatKCYsSaMfkH+e0vPl98u0VVcuYCcBfIib4P/6PA2G
	 NReLoqJ8Wa4IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 048/715] x86/sme: Fix memory encryption setting if enabled by default and not overridden
Date: Sun, 24 Mar 2024 18:23:47 -0400
Message-ID: <20240324223455.1342824-49-sashal@kernel.org>
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


