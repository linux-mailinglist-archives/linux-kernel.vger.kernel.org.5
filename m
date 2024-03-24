Return-Path: <linux-kernel+bounces-114480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4883889012
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C341291127
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141917BB14;
	Sun, 24 Mar 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9WjlUS0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166F912D75C;
	Sun, 24 Mar 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321909; cv=none; b=TVnO6Ag67PGAsbKFJVgQo1s1Uek9i302D4xWsietvG38leMfsK/t55sdBE1FQ+et2G1qkvkdOkidLWcYG1L2rOj5RbhmbuCh5EBE1wrPvJFJywpIRPiUJoX1yawdySExfnNsCbVm1pglBP4lVn8Akh5nrsurk1PWLzsBzp/Hy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321909; c=relaxed/simple;
	bh=S4MCq1btvMlsLJir7xY09Oy+WFy5jVRxyUJY7arKk9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxgQoONK4ykuvmeoQJfJeSNhDLeKBvKskRqiiIMLozsoGYDoCu4vrh3G4wwsbs1ggkDt+w9emvBuuIWm4PhGPRa3lekmSUK6lhj5fqVAU5grZfNHoC1Fu29EZYyjkbpTg0LQShCTCpHyySJuCiGO4bTlGPz4b3FQpT5RflZRpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9WjlUS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3F7C433F1;
	Sun, 24 Mar 2024 23:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321908;
	bh=S4MCq1btvMlsLJir7xY09Oy+WFy5jVRxyUJY7arKk9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9WjlUS0WLf6CwwtFb1nOx4Om/SQ3h8wpqBvcR1C6cBQ+lxZWZcz6R4D2ieE2Kx8q
	 JHhPrTn3Jx8z/BOCTUum5/ai3jqJKxQKSYQdMzMzPCwULNtNr3Wp3HjQQvnk6gPcEV
	 AVCr/8tq2I7t6xy63YXZY/8Lv4nBOWgktvclnfTcmUWEK5QS5QIyAdhotyFmowT8P2
	 0Ij4+wXHnsexBCmL+k0gOpbg+PLazX+s4FqFpuhpYxZB+aMsssdpkkFC/wUYYb/NHX
	 QHYYhxaQidTpEJNNxKRmHE1EX1D/t9/VAd56RkT6KBNMnK2pm8e9mmENGRkWS0q4Rm
	 5pTcQn7Yyi5ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 637/638] x86/efistub: Don't clear BSS twice in mixed mode
Date: Sun, 24 Mar 2024 19:01:14 -0400
Message-ID: <20240324230116.1348576-638-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit df7ecce842b846a04d087ba85fdb79a90e26a1b0 ]

Clearing BSS should only be done once, at the very beginning.
efi_pe_entry() is the entrypoint from the firmware, which may not clear
BSS and so it is done explicitly. However, efi_pe_entry() is also used
as an entrypoint by the mixed mode startup code, in which case BSS will
already have been cleared, and doing it again at this point will corrupt
global variables holding the firmware's GDT/IDT and segment selectors.

So make the memset() conditional on whether the EFI stub is running in
native mode.

Fixes: b3810c5a2cc4a666 ("x86/efistub: Clear decompressor BSS in native EFI entrypoint")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 90f18315e0247..d186617a93f88 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -467,7 +467,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
-	memset(_bss, 0, _ebss - _bss);
+	if (efi_is_native())
+		memset(_bss, 0, _ebss - _bss);
 
 	efi_system_table = sys_table_arg;
 
-- 
2.43.0


