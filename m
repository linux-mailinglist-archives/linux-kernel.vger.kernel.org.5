Return-Path: <linux-kernel+bounces-114708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52EC8890C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F749297B68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34C2BB67C;
	Mon, 25 Mar 2024 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDxqRoPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD02152DF9;
	Sun, 24 Mar 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322368; cv=none; b=EuTUDGcAyJ+qCJOc9aSZjJOn1iwkZv9xd/A6ozwRuhWg8CUCWwgye8p+6j+JKBgs4uVGCBfhsJQUGIyBY4FQYu5HnWX0wyjbsxX0Q4POlvUzl3rdTxdi6PhNMoUGbyYaRt7Q7BKJ8llvxABeLx2wGmO2vjCEcUTRkoOWHvZ425s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322368; c=relaxed/simple;
	bh=Zt1YcWJk2oY9V6XFY0hmrkQhTHqT8Z2fR3NfegnzwNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlTkWmmT73fw6tXP43a9r2yBZs1mjgj50O7Dh/GLP2SGPyEDyYsNTzoLprqtyZq468gLmkguUaCAlOYPIB7Djiq/z+lCM10RJy9Tmt3mmvW2sDqcCiOzmy1oCClbXSCltt9bgi2pZDZb+9q+H1FWOMlcHtNZyw3unSltFvKNM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDxqRoPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40484C433C7;
	Sun, 24 Mar 2024 23:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322367;
	bh=Zt1YcWJk2oY9V6XFY0hmrkQhTHqT8Z2fR3NfegnzwNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDxqRoPw+QFhFDt2DjKbSCTsGb12vIdVcjFojs64rtfRy8krIkLAOFesEiaFQWNYR
	 ptnKC2mc+oxphQGEY9UA73Uk2kVI3cYNP+oqve47YNONTnRa0paLkXWGi0vwYp/yMB
	 +UktSn2hbrUDxTIQ8mf8p4qu9PS17Tmy9Oom0zeW5RD+OfFLRklODhqvvgXOQlvVTW
	 YlaoBdeqa4ngRIRvApM8e8+jhB6uxLmcdgMWzvZXeAhjGhGVElo2F8q3TNZBZnV3Ku
	 hBIMnwtu5rdrnbp505uI0hzHGC0FI/t8Fjh/U3ksSEfTguoU97pNFzhyGyVoSvN+A4
	 Rog2+SS5Y7Q7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 450/451] x86/efistub: Don't clear BSS twice in mixed mode
Date: Sun, 24 Mar 2024 19:12:06 -0400
Message-ID: <20240324231207.1351418-451-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index aa07051459f52..dc50dda40239e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -434,7 +434,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
-	memset(_bss, 0, _ebss - _bss);
+	if (efi_is_native())
+		memset(_bss, 0, _ebss - _bss);
 
 	efi_system_table = sys_table_arg;
 
-- 
2.43.0


