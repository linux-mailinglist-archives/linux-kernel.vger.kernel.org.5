Return-Path: <linux-kernel+bounces-105171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421B87DA03
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DAA1F219CB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C43F1798C;
	Sat, 16 Mar 2024 11:52:49 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178F168DE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710589969; cv=none; b=KuhF5ACblkAaBBlh9QT+PAdpG7Jm+9LupobTe/YN5Tpp4ETEUTE8XjI0h8S9h2yM75jptFkQLDkySMcsJMa0imelJhGK+m/bCc1g3/bkTVcQswfrFVvROm/JvHiOB2Uhca2Xfuf6m5ZWaXpZfkC4mvt/WfI8ygMbZZfAJA0D7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710589969; c=relaxed/simple;
	bh=UV1rJKmQt3T24+tdC8X4Jq5oU7gkF6J2ipvnXC2QiV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKBz/8ATvkNTr7msPZrMRjss5HgyMV3KMjvPgEHqwx9mcv/af2OAusr2TKFyy3GEOy3Rk8dNDown4CKBLw45QOYwE0WFVvfvb6WKB91l0DNJzRflC9XghPcLXpaexiQPdsczLL4A5jDBcmHSMV1jQpUsvDT/5upQxTT9MRb28vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Txfcs3BD1z9sgJ;
	Sat, 16 Mar 2024 12:52:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIt7TkOhbv4W; Sat, 16 Mar 2024 12:52:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Txfcs26FLz9sd1;
	Sat, 16 Mar 2024 12:52:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3EFF28B768;
	Sat, 16 Mar 2024 12:52:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id JWE_SLCmtil4; Sat, 16 Mar 2024 12:52:45 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO18731.IDSI0.si.c-s.fr [192.168.233.183])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E01028B764;
	Sat, 16 Mar 2024 12:52:44 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm: Remove guard around pgd_offset_k() macro
Date: Sat, 16 Mar 2024 12:52:41 +0100
Message-ID: <59d3f47d5615d18cca1986f269be2fcb3df34556.1710589838.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710589962; l=932; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=UV1rJKmQt3T24+tdC8X4Jq5oU7gkF6J2ipvnXC2QiV0=; b=DsDMFPDJf1yqqD0SlQfv8Y3XTssUfqv+N1186Y+VnjDdg6gtNIKZlk/k7OsGnBCTnGY0IDjMF vhG3og/F2IwAswDffzZgS+1nm3NUnKaK1yActGVrXa0jGPU90ZNEm4F
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The last architecture redefining pgd_offset_k() was IA64 and it was
removed by commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture")

There is no need anymore to guard generic version of pgd_offset_k()
with #ifndef pgd_offset_k

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..bd9c7180718c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -149,9 +149,7 @@ static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
  * a shortcut which implies the use of the kernel's pgd, instead
  * of a process's
  */
-#ifndef pgd_offset_k
 #define pgd_offset_k(address)		pgd_offset(&init_mm, (address))
-#endif
 
 /*
  * In many cases it is known that a virtual address is mapped at PMD or PTE
-- 
2.43.0


