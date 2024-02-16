Return-Path: <linux-kernel+bounces-68353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD374857928
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A695F284AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E531BDD5;
	Fri, 16 Feb 2024 09:46:55 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508DF1BC20
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076814; cv=none; b=k2nvgw269bpH/wZiHa0lQbjg3Sg4LLFNSojZ1JWZdqXOFUTBVO4XpMJoNAVHDHNGPbxsz/BGK+QSlu8d+SK8Kci2FtgG346OFL82LpoBv/ubUlx25IfmtJ9dBD8q2kCu+pcWahTJXnGx+0vnE4l/LJys2dcSef5Zq9KVfG9m/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076814; c=relaxed/simple;
	bh=jQSDNvlSvXj1/uFQqCpVwQ2VcEHhnQsmskPJnVBLVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJzC91aaxjK8tyKyqvgAXO0gGqs0COu4lOGbCmod5S+Ok/HkQx9GNAhyHCOZpKxWD7oFLBgGDPqX38pb3nOYQ9x6gYCyyP8qRsb3plmBxr1zQqq8JLpNWPkiHSch8Arrylm0bUQO6DEF3p7gq+C0hNgx3bEu7TrrFO7sfulLaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TbnBr4fvVz9syV;
	Fri, 16 Feb 2024 10:46:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id peyhQNuAFxmK; Fri, 16 Feb 2024 10:46:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TbnBr436jz9syQ;
	Fri, 16 Feb 2024 10:46:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 869688B787;
	Fri, 16 Feb 2024 10:46:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gWjL-nAXy4fJ; Fri, 16 Feb 2024 10:46:44 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.102])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 065D78B765;
	Fri, 16 Feb 2024 10:46:43 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/trace: Restrict hash_fault trace event to HASH MMU
Date: Fri, 16 Feb 2024 10:46:43 +0100
Message-ID: <85a86e51b4ab26ce4b592984cc0a0851a3cc9479.1708076780.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708076803; l=1035; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=jQSDNvlSvXj1/uFQqCpVwQ2VcEHhnQsmskPJnVBLVQ8=; b=dli5kkWpxgzKF1Gl+nepuo8w18O4GjGWcq5DVBCZqOiFGyRxV7GaeYH/vja+BiYbK6yV4tdfw zMq65olsweCDR2RGWVw9MXU7+sHsTFNo8ara9svxSgY9uQyJSNwJTqk
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

'perf list' on powerpc 8xx shows an event named "1:hash_fault".

This event is pointless because trace_hash_fault() is called only
from mm/book3s64/hash_utils.c

Only define it when CONFIG_PPC_64S_HASH_MMU is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index 82cc2c6704e6..d9ac3a4f46e1 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -267,6 +267,7 @@ TRACE_EVENT_FN(opal_exit,
 );
 #endif
 
+#ifdef CONFIG_PPC_64S_HASH_MMU
 TRACE_EVENT(hash_fault,
 
 	    TP_PROTO(unsigned long addr, unsigned long access, unsigned long trap),
@@ -286,7 +287,7 @@ TRACE_EVENT(hash_fault,
 	    TP_printk("hash fault with addr 0x%lx and access = 0x%lx trap = 0x%lx",
 		      __entry->addr, __entry->access, __entry->trap)
 );
-
+#endif
 
 TRACE_EVENT(tlbie,
 
-- 
2.43.0


