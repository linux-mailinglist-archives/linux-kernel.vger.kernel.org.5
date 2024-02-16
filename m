Return-Path: <linux-kernel+bounces-68424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2A857A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC891F21040
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06C1C68A;
	Fri, 16 Feb 2024 10:12:11 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E511C292
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078330; cv=none; b=Fi6tJcXbCRg95qjIuHzd2/vqcjklMlTCFAnYCBJKjRvUIRYQvDwKL2gRFbDBWzAbWarpP+X90bWxEuxUHZ/o2Y+gp9L+mUz4/k4zAxJH/MKHqEe9uquRSpJB5zSrfEDhCIc/FSn5OXCzKvISurOPfPdhpu45fL7CwDY+bHHtlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078330; c=relaxed/simple;
	bh=03kSx/Xj1N2C9q6WgA/pGs7PiUtVb+PYHpq8O/z+ySU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFpaix5o9bCHK0FCTgMGJAiyOi66Sr1SgjeQSwRd1ohj7ROWbAXqzmaF7uN2xh6PtxYAT2dU/VXSJ2WNyX9HXru7/zANi2ODrPHqJLAsXbscu+Crjss7kxgDomrPp+J0iLhTTZHIra6wJP4R1dH/mSv7ntqJmL2/yBVV45sDLu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Tbnm66x0Cz9syV;
	Fri, 16 Feb 2024 11:12:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7SDVoGdzgC5N; Fri, 16 Feb 2024 11:12:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Tbnm66M6Gz9syQ;
	Fri, 16 Feb 2024 11:12:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D65798B786;
	Fri, 16 Feb 2024 11:12:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id NtHKeuYaB3Rg; Fri, 16 Feb 2024 11:12:06 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.102])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 862AA8B765;
	Fri, 16 Feb 2024 11:12:06 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Implement set_memory_rox()
Date: Fri, 16 Feb 2024 11:12:05 +0100
Message-ID: <dc9a794f82ab62572d7d0be5cb4b8b27920a4f78.1708078316.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708078326; l=1982; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=03kSx/Xj1N2C9q6WgA/pGs7PiUtVb+PYHpq8O/z+ySU=; b=Tto0qP7joTrcp/+S58ahfE8oUF+EO5e/EajrmaQmtTc4EuqNVl/kMkP9wUAefhsa+aLhOM3nz YUaB0qT81cxDSOwmiwyT6PLv5ps1NOksX8As7tsDQp9SOgd1SJ4g/Bi
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Same as x86 and s390, add set_memory_rox() to avoid doing
one pass with set_memory_ro() and a second pass with set_memory_x().

See commit 60463628c9e0 ("x86/mm: Implement native set_memory_rox()")
and commit 22e99fa56443 ("s390/mm: implement set_memory_rox()") for
more information.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/set_memory.h | 7 +++++++
 arch/powerpc/mm/pageattr.c            | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/set_memory.h b/arch/powerpc/include/asm/set_memory.h
index 7ebc807aa8cc..9a025b776a4b 100644
--- a/arch/powerpc/include/asm/set_memory.h
+++ b/arch/powerpc/include/asm/set_memory.h
@@ -8,6 +8,7 @@
 #define SET_MEMORY_X	3
 #define SET_MEMORY_NP	4	/* Set memory non present */
 #define SET_MEMORY_P	5	/* Set memory present */
+#define SET_MEMORY_ROX	6
 
 int change_memory_attr(unsigned long addr, int numpages, long action);
 
@@ -41,4 +42,10 @@ static inline int set_memory_p(unsigned long addr, int numpages)
 	return change_memory_attr(addr, numpages, SET_MEMORY_P);
 }
 
+static inline int set_memory_rox(unsigned long addr, int numpages)
+{
+	return change_memory_attr(addr, numpages, SET_MEMORY_ROX);
+}
+#define set_memory_rox set_memory_rox
+
 #endif
diff --git a/arch/powerpc/mm/pageattr.c b/arch/powerpc/mm/pageattr.c
index 6163e484bc6d..421db7c4f2a4 100644
--- a/arch/powerpc/mm/pageattr.c
+++ b/arch/powerpc/mm/pageattr.c
@@ -38,6 +38,10 @@ static int change_page_attr(pte_t *ptep, unsigned long addr, void *data)
 		/* Don't clear DIRTY bit */
 		pte_update_delta(ptep, addr, _PAGE_KERNEL_RW & ~_PAGE_DIRTY, _PAGE_KERNEL_RO);
 		break;
+	case SET_MEMORY_ROX:
+		/* Don't clear DIRTY bit */
+		pte_update_delta(ptep, addr, _PAGE_KERNEL_RW & ~_PAGE_DIRTY, _PAGE_KERNEL_ROX);
+		break;
 	case SET_MEMORY_RW:
 		pte_update_delta(ptep, addr, _PAGE_KERNEL_RO, _PAGE_KERNEL_RW);
 		break;
-- 
2.43.0


