Return-Path: <linux-kernel+bounces-79770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97103862671
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DCF1C213B4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3924E1BA;
	Sat, 24 Feb 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM6IjYpO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882DF481DB;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796547; cv=none; b=Ajv9tYzRrhrlREtimXSrFdsRIEB06fww/EY1t0AuEbff2YjQtdnd+eTVhAwFat85MZpGi3MqN14RV7oJ9qWWWJ9q9x68Rn6lzx85dsI+xBwBQ2wWd9A0XAUkqt3ccUmggxixZd3Su5o5f3tR6JT5gT0Cf+G3kh7zmhcwyJqyfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796547; c=relaxed/simple;
	bh=BpChDc4AdXLSlhIQ1beqDCEhZX4ty/N7Hr3rHV89JQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxYe0MbaMXG8lIpnFBd7K+R94u1iYG+omsv8JP18+dnYm4a1Nvx+NMXaU1w6mYNAvFUHIM8UyTkAkC+P5dGPxV7SRXVOiOWMuz543mgADPLiD4IgB1o3dE8bGX41t0P6A8oZLzGNEyxwBhI4fpsXmTCLi0J3lO0rR1U7hkDnU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM6IjYpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43250C433B2;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796547;
	bh=BpChDc4AdXLSlhIQ1beqDCEhZX4ty/N7Hr3rHV89JQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hM6IjYpOnP7O32ustFTBJR9nsLehBYm1XHe6qd6G6vfsQOaVgkWe/VXrM3tkUp0nU
	 e5OSJtZ4x4ZbbOtuk9R2+inYXs903bweTKX3iY0gVhbTszG36R9vnd0G1e0zaXNo7L
	 M3TKZQO2Bra3x7BpiC/JzhaeNvvjj8KwauKOZEClrOCej7DRwq/b9k20rwNBuFTCua
	 3W/dFbNMK1sIdeYJ+OES6eG+G3BrzyU41DiOas48ZzveyaFMvsJqGwpAmJr3Mli4J9
	 FZJaeqvEfuUwxz8S9wqg9buQaMHw5Gib2qkCNwgQpx2IA+NTCWWBuVe/Dfkax3dF3R
	 +7TCZzp1b3klA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329BCC54E4F;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 24 Feb 2024 18:42:28 +0100
Subject: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
References:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
In-Reply-To:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708796545; l=1706;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=sp1d/B24jZbQZh3/vvpsecjIEsONMYKjjInm+P7c4rg=; =?utf-8?q?b=3Dg6ryIctXAY8E?=
 =?utf-8?q?RVSP7byE0Sv/rPNTxni/bFVxqgeeV0JsbhZM6eDayu5hVR10CVQe98O1Q1FHWAAM?=
 /aIXJuA6B9nUPGrWcgHnnmW73F4QqXtQDcNHs5JOfJ8Z60bsp0Ek
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

Passing a datastructre marked _initconst to platform_driver_register()
is wrong. Drop the __initconst notation.

This fixes the following warnings:

WARNING: modpost: vmlinux: section mismatch in reference: grpci1_of_driver+0x30 (section: .data) -> grpci1_of_match (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: grpci2_of_driver+0x30 (section: .data) -> grpci2_of_match (section: .init.rodata)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/leon_pci_grpci1.c | 2 +-
 arch/sparc/kernel/leon_pci_grpci2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index 8700a0e3b0df..b2b639bee068 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -697,7 +697,7 @@ static int grpci1_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci1_of_match[] __initconst = {
+static const struct of_device_id grpci1_of_match[] = {
 	{
 	 .name = "GAISLER_PCIFBRG",
 	 },
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 282b49d496ea..9f662340b5b2 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -889,7 +889,7 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci2_of_match[] __initconst = {
+static const struct of_device_id grpci2_of_match[] = {
 	{
 	 .name = "GAISLER_GRPCI2",
 	 },

-- 
2.34.1


