Return-Path: <linux-kernel+bounces-113604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E0B8885A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0322B1C25051
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96A1CE6AA;
	Sun, 24 Mar 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on1gcJmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB51CE977;
	Sun, 24 Mar 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320408; cv=none; b=VMCl8tOwTtfMzxd20x3seNumPLoCJ6Ouu46RQsHQOYmbBJUka5PfgRVzKQAFEANG2lsp403H++s1yMdMEM3StHEBEvyHX9ukld/RNVA3iN3bwCJRBNSXqCSzDlCVpr2euL6YYn6YD76YXkeAreMSvSEsAEK1KhGsPac0n7+WhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320408; c=relaxed/simple;
	bh=B1d+cpeaseJ9PKr34K6i49gWQpYLzfuoLU2uD9m2fMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh1qRqlk0UZJ4Cz/y5JIc0hcGiHqJhzqzIZuiAQS+YEWjUuVwJYkzmBvR7Dn5sm8nlhnyxcKN5BdD9GgLHor5xAJF8vjyOI8pEkHIC4JFzanPik6ph1WoFFWxrZBnkOpxrWQpnq12nBaG9e2+tuuEMQUiIUqZiCHHNIfbu5QRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on1gcJmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F65FC43390;
	Sun, 24 Mar 2024 22:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320407;
	bh=B1d+cpeaseJ9PKr34K6i49gWQpYLzfuoLU2uD9m2fMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=on1gcJmyPMmyD1Ny5TY0e4xkSGMsb1CD8bycqX6lLH2vuofP/fDYC1LsIMeZNeXqe
	 tk5p7mHt2dEsR0UBANruDLT6c1PVUBpdCxQAcCKz2tzF+PlgDH/yEvVTbx3Gx4XEF/
	 oRycXUFhs/TsUgRM/8Yc2F4KX3ATu3WLjwM5cw7Em/5ik2cTwiccRzP89kGJINsvle
	 de1DiLu+zvhJUb4rPT+XZXUksURn3pTLCk1FEKvUPhhxxQcw6vbugqVMVWuvQyFJ83
	 /oMJX3q4xN7pEDSAPe/9gT6Bc/Um2lklYMsgqKlzJedOKbASvInTuDaY6kc49C7RRb
	 b4/+TE3iczoMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 714/715] x86/efistub: Don't clear BSS twice in mixed mode
Date: Sun, 24 Mar 2024 18:34:53 -0400
Message-ID: <20240324223455.1342824-715-sashal@kernel.org>
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


