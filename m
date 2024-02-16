Return-Path: <linux-kernel+bounces-68427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11E857A11
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DC828268D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03D1CD17;
	Fri, 16 Feb 2024 10:13:33 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D671CD08
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078412; cv=none; b=QcfB/xj3MdVEpkqYIo10rBKL/Y2Rz1G5mYw2JB0qpfK99+4kEnP0V3jIS0ZmnkYpEEQislPtKfHG9onhiwnSH/BTcEHvxtR7MoeQAYyAdXACwYy5T08okK8vskex4x/SYinrwDmSKT+rUFdQbSZKSABzzt9CeDEa1ZRf4TAEzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078412; c=relaxed/simple;
	bh=gFvxdGBn2gnL3Qmsqfyn1m40w0A0o3zw63K6CAs0gX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBWDkgqjBM1QWZDzdtcWXrstupsdm1D8hZNvP2aVRBho8MYy+QTE+RkQhkzl7VnqAhEunIcgTwpl8Egv3wYujs3BbGVmE4Q+2eJb1J6HZ+FEbI5D0KxeXwg+uzrpT1YcY3XLsyppkUvV6+Okvw8CGTHTRNifdItckZUedoN+Z0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Tbnnj3CMlz9syV;
	Fri, 16 Feb 2024 11:13:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fxzEY0ci_yMv; Fri, 16 Feb 2024 11:13:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Tbnnj2cPyz9syQ;
	Fri, 16 Feb 2024 11:13:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 55F138B786;
	Fri, 16 Feb 2024 11:13:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oPZ7HNpSeR9n; Fri, 16 Feb 2024 11:13:29 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.102])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F31F58B765;
	Fri, 16 Feb 2024 11:13:28 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kprobes: Handle error returned by set_memory_rox()
Date: Fri, 16 Feb 2024 11:13:28 +0100
Message-ID: <b4907cf4339bd086abc40430d91311436cb0c18e.1708078401.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708078408; l=920; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=gFvxdGBn2gnL3Qmsqfyn1m40w0A0o3zw63K6CAs0gX4=; b=/IhHW28iLo2Vr4CTEJAwUYwwtuSKH+4Arca0BPk4cDLWtr2N6OVhNYmK8ndxZSjP4948b3wSt xXQoD/TyqVEBM1D4k7mx91IBxe7lQRxRQUXLsYFOfz6Uk9tn0AFkilG
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_rox() can fail.

In case it fails, free allocated memory and return NULL.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/kprobes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index b20ee72e873a..bbca90a5e2ec 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -134,10 +134,16 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
-	if (strict_module_rwx_enabled())
-		set_memory_rox((unsigned long)page, 1);
+	if (strict_module_rwx_enabled()) {
+		int err = set_memory_rox((unsigned long)page, 1);
 
+		if (err)
+			goto error;
+	}
 	return page;
+error:
+	module_memfree(page);
+	return NULL;
 }
 
 int arch_prepare_kprobe(struct kprobe *p)
-- 
2.43.0


