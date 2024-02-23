Return-Path: <linux-kernel+bounces-79037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74960861CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134511F23125
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5E149382;
	Fri, 23 Feb 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKHQnLvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A811448E9;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717025; cv=none; b=pdlI46xnVr1ZYRkxqOuzam4Wde9MveWEUtRz5YHL7P7IuPZVV+/xZ4rAeDr+3M9PRgoQidOmWMQlpa6IE8dVWftrqFPZzJSNj+SMHk8KAx1cgfrHYxhKPDlQiMP4dn38ckxRckH1seih6saKMDPwuwrIgCF7QwGT+XhxAavN2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717025; c=relaxed/simple;
	bh=JDG9d1e3LSCtM7kTWA5ChJDE7Zpsj0NIfR9IlwvgsvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gIs/x2LdMaFOxHinPm1D+VJuMHxkG+wg5HzT7amYbISnNomQsv3ZfPlUIm77hDsJe1t+afptIkv4vL9zaaszk7Wn5lNNC2JN2xux0riTkDCCJgRrqQ35lmXyIQFf3BavNgoGhJbvyjy/Pk+pZ0ISFOuN9LzbpWt6iOEBjoP+AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKHQnLvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EE19C433B1;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717025;
	bh=JDG9d1e3LSCtM7kTWA5ChJDE7Zpsj0NIfR9IlwvgsvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vKHQnLvDwhGpG9NDVRHQkrTVS4jB2Bf9SZMHBRV9SDIFqB6+a9SVe4rLT62xGQMYb
	 ViUAunfga39Q+8lzEK8/OSJhyKgqnr/HtPHQ0gob09YPADFSOLaojVHvkh0kw3xfZ1
	 l1rBkdvvR27e3XKlMrpBVRcFRdq0Scd7tOrOoK5Syvs0jBPy8hEGsH+WAMnhglTl9a
	 vdUrIxY5RiRsMOEoqNprMRybx5J1rsoogTNIultb9eHTnYcbfxf4JHDcQ5N9fE/EDL
	 uHxxEu+3Le7rrnabaJ+E8DfQfbCpnmmYoUIz9hIp8XDinY2DymfU+yn4U9zogQ0u8p
	 ywwzPX3WX4sKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC2C54E49;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Fri, 23 Feb 2024 20:36:51 +0100
Subject: [PATCH 5/6] sparc32: Do not select GENERIC_ISA_DMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
References:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
In-Reply-To:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708717023; l=889;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=lMxXdOPMpDx1tzgAvR97ar00I1WhL1W/uCEBzu9wvkY=; =?utf-8?q?b=3DggGkf5ePuxoN?=
 =?utf-8?q?77uiKL1N8qedIdOOw6npYIMJDxI/0wfpWe9GpS7/PQuyPyLuCNWZG1R1N2uUkMUu?=
 7tJF7mj6AdTslYKT4aZkP2h+GawJFdO/y/vRle52oc2KWM7LBg7E
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

sparc32 do not support generic isa dma, so do not select the symbol.
Without this fix, the following patch would break the build with a
missing prototype.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
---
 arch/sparc/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 734f23daecca..d08a5662ea60 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -138,10 +138,6 @@ config HIGHMEM
 	default y if SPARC32
 	select KMAP_LOCAL
 
-config GENERIC_ISA_DMA
-	bool
-	default y if SPARC32
-
 config PGTABLE_LEVELS
 	default 4 if 64BIT
 	default 3

-- 
2.34.1


