Return-Path: <linux-kernel+bounces-8058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219A81B1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DADB240D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2A4C3BF;
	Thu, 21 Dec 2023 09:03:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643044C615;
	Thu, 21 Dec 2023 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4SwkxP3FC7z9v9j;
	Thu, 21 Dec 2023 10:03:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fqs9y1ggkq6h; Thu, 21 Dec 2023 10:03:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Swkwl6cZLz9v6D;
	Thu, 21 Dec 2023 10:03:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DF5B68B788;
	Thu, 21 Dec 2023 10:03:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id W2ziqtgAv9yK; Thu, 21 Dec 2023 10:03:03 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO25106.IDSI0.si.c-s.fr [192.168.232.169])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C38B8B765;
	Thu, 21 Dec 2023 10:03:03 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org
Subject: [PATCH 2/3] modules: Remove #ifdef CONFIG_STRICT_MODULE_RWX around rodata_enabled
Date: Thu, 21 Dec 2023 10:02:47 +0100
Message-ID: <ac300e1a84eed4ba4d6a791eef2be30654bc566e.1703149011.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
References: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703149365; l=911; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=KgXa9tEdYbBGRtlR2Sk8FbMi8n/9B7ioVpOACaYMJnE=; b=bo+Bre38mcoaNi8xnqzMLLZvyIpZAWuADlq8yZdyZp1/UYDgHgyNKuVO+iy9JCZyGJYTIUT3f m9mnac+tp9rBKFv96ZmTDUPGfIg97OTiYd9K8LYhy1CkbzkJkVLe4W4
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Now that rodata_enabled is declared at all time, the #ifdef
CONFIG_STRICT_MODULE_RWX can be removed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/strict_rwx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index a2b656b4e3d2..eadff63b6e80 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -34,12 +34,8 @@ void module_enable_x(const struct module *mod)
 
 void module_enable_ro(const struct module *mod, bool after_init)
 {
-	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
-		return;
-#ifdef CONFIG_STRICT_MODULE_RWX
-	if (!rodata_enabled)
+	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX) || !rodata_enabled)
 		return;
-#endif
 
 	module_set_memory(mod, MOD_TEXT, set_memory_ro);
 	module_set_memory(mod, MOD_INIT_TEXT, set_memory_ro);
-- 
2.41.0


