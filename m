Return-Path: <linux-kernel+bounces-6014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8225F819344
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2AD28859D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B84F5E1;
	Tue, 19 Dec 2023 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHVtZ4qZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED63D3A0;
	Tue, 19 Dec 2023 22:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19DB3C433C9;
	Tue, 19 Dec 2023 22:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703023396;
	bh=dKuKJfEimO4hO2eTnf/PpJF3R3m4iQkMndh7L8fiYrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MHVtZ4qZQ8E3mUQMuKCLTEtCDPUaHv6SF8UKHdl9yuT9I/06tRXi3gq90f9vVDI36
	 dswz38mvMB1QYCRuT3ZzDUJ5fIpY4Y7V46/gnayZhNjw6TgesvdHPmLJdyGOVsfVE0
	 WshGnmwFR1+T+YUs2kiG4+M/Y6YOOyjWx1KxkSbVtMn/+q2Ot4++aeCqy0Dcn/yBPA
	 XX6/6ABxnL7QapDoLgON0+ZxY/uOn6Ka30mBDfoM3Hrq6m+PP34Ru9rGXI5vxQS3A5
	 z19Gc37+2WLq97fEw2WAE1USrFZLx/r0oWOzpaMmsgKfTx60RyDllwX0NbtCh5CJ6N
	 atn3yQ+jmNpSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9BC4706D;
	Tue, 19 Dec 2023 22:03:16 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Tue, 19 Dec 2023 23:03:18 +0100
Subject: [PATCH 13/27] sparc32: Drop unused function __get_{phys,iospace}
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-sam-sparc32-sunset-v3-v1-13-64bb44b598c5@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
In-Reply-To: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703023392; l=1970;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=E0Vh64/XjG0Um8pqx4pfsGK0FeX+R72wUc/BzUbmKDY=; =?utf-8?q?b=3DwcpWwsTyWY02?=
 =?utf-8?q?ja6To5kFELiblsY7eCvn92LTyIteU8JScRw9rKK4BLrishuuIo6zaZGwblJuujCO?=
 W7KiPfkCDAA5sPkUC1yGvZPC9BwmwtiJohyPHsK3jjTfRswBiRbl
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

Not used and references stuff that will be dropped later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/pgtable_32.h | 24 ------------------------
 arch/sparc/include/asm/pgtsrmmu.h   | 11 -----------
 2 files changed, 35 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 9e85d57ac3f2..92b063531d5c 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -368,30 +368,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return __pte(pte_val(pte) & ~SRMMU_SWP_EXCLUSIVE);
 }
 
-static inline unsigned long
-__get_phys (unsigned long addr)
-{
-	switch (sparc_cpu_model){
-	case sun4m:
-	case sun4d:
-		return ((srmmu_get_pte (addr) & 0xffffff00) << 4);
-	default:
-		return 0;
-	}
-}
-
-static inline int
-__get_iospace (unsigned long addr)
-{
-	switch (sparc_cpu_model){
-	case sun4m:
-	case sun4d:
-		return (srmmu_get_pte (addr) >> 28);
-	default:
-		return -1;
-	}
-}
-
 /*
  * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
  * its high 4 bits.  These macros/functions put it there or get it from there.
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 18e68d43f036..7cb5cbc83211 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -125,17 +125,6 @@ static inline void srmmu_flush_whole_tlb(void)
 
 }
 
-static inline int
-srmmu_get_pte (unsigned long addr)
-{
-	register unsigned long entry;
-        
-	__asm__ __volatile__("\n\tlda [%1] %2,%0\n\t" :
-				"=r" (entry):
-				"r" ((addr & 0xfffff000) | 0x400), "i" (ASI_M_FLUSH_PROBE));
-	return entry;
-}
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC_PGTSRMMU_H) */

-- 
2.34.1


