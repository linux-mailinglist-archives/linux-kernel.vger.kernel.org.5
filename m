Return-Path: <linux-kernel+bounces-115586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18978889EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEADB2BCD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599C342D4A;
	Mon, 25 Mar 2024 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6Q/VYCg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E571F4170;
	Sun, 24 Mar 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321150; cv=none; b=aGhY38dtH75H1DOJsgGfWZrcCkTkU3UwPSo86EPCEyA6xGhV1MaccpqqEgjwD3+JO3zciez7MVtbcDx3qZhqIqRhffzcObtICbekl2CFpEabG7tFpkLzxCdlkj0gP4zcpaI30C9jOMsvXRdduGUuTVJMhVX9d1EJs8o64rJR++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321150; c=relaxed/simple;
	bh=B1d+cpeaseJ9PKr34K6i49gWQpYLzfuoLU2uD9m2fMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPNNi++iUbW0cVameaoftMLXNK3TIHDKv7E3/npJcKCOrE7pCDNfvvcjUUvYYpF5HjZjvMMDZ9pmIYk3tRqbSRRHo/CxElyHSkrhT+bYTtEqBFdA6dxFEjV3dpLm0ZRcMqLerun/beQRj5L57gk8Q1C1cu4ihLN8hVXgP8sKvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6Q/VYCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D630AC433F1;
	Sun, 24 Mar 2024 22:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321150;
	bh=B1d+cpeaseJ9PKr34K6i49gWQpYLzfuoLU2uD9m2fMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6Q/VYCgOjssQ66ZtsX1vuMUFJ8mKgunAjf5u6IhTFj5BcAzF3GFZyBWb6EYOglXY
	 2tZ9gZFvwaaFoJsJurHgzT5xdKMt1luCrK1U5jSxBWZhTIl+AP9uVGUdd54d2UMGyQ
	 KAnlbSd+HQWNsVPXZllbR45muFLG9B4nFnyv835kTGusFguBQCW6AwNWNBCM7i/m1J
	 iZ4ko17LLmYi3MD96QnNX+MVGFu7qzZgY5zDqHYxo/qkGQmfCS7pZO5VolaCLvTHCT
	 8DTnmtz2CpBWdKA6kIgZuxu3KSg2SukKys5v5uKYf6cOsva4biHBPYt7N82Tvrjig2
	 FhGFYNdgIkPMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 712/713] x86/efistub: Don't clear BSS twice in mixed mode
Date: Sun, 24 Mar 2024 18:47:18 -0400
Message-ID: <20240324224720.1345309-713-sashal@kernel.org>
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
index 681f576ec02a0..c9857ee3880c2 100644
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


