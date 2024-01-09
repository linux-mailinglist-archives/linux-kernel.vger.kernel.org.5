Return-Path: <linux-kernel+bounces-20835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D804E8285E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065041C24082
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6A38DE9;
	Tue,  9 Jan 2024 12:15:21 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2738F8A;
	Tue,  9 Jan 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4T8VHY0sNRz9v7N;
	Tue,  9 Jan 2024 13:15:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ozAHoRKaJAh; Tue,  9 Jan 2024 13:15:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4T8VHY02Bvz9v2V;
	Tue,  9 Jan 2024 13:15:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ECE6E8B774;
	Tue,  9 Jan 2024 13:15:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id FZoHIGzf4vrQ; Tue,  9 Jan 2024 13:15:04 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.126])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 313958B77D;
	Tue,  9 Jan 2024 13:15:03 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: linux-hardening@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	steven.price@arm.com,
	Phong Tran <tranmanphong@gmail.com>,
	mark.rutland@arm.com,
	Greg KH <greg@kroah.com>
Subject: [PATCH 4/4] ptdump: add check_wx_pages debugfs attribute
Date: Tue,  9 Jan 2024 13:14:38 +0100
Message-ID: <2e8806da45a4b00249d5c449130b5f9ce78b3403.1704800524.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1704800524.git.christophe.leroy@csgroup.eu>
References: <cover.1704800524.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704802474; l=1205; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GHXEAlv0k5WPsTIzSlwSomj0miEDu7ks2lV9a6+wMCY=; b=ibzm/cyPs51Q7IIlWinvVhCDJTVa2O93PdiVEWCD+bsWH/ncfG8IK1blTnxut+3ypcbloBgn2 fQjuoG4nNpPArnos+jqQxEly3FXt6Jg7j8Ye6GzOwyRghOCV7gDmUAh
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Add a writable attribute in debugfs to trigger a
W^X pages check at any time.

To trigger the test, just echo any numeric value into
/sys/kernel/debug/check_wx_pages

The result is provided into dmesg.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 mm/ptdump.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index 03c1bdae4a43..e154099c2584 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/pagewalk.h>
+#include <linux/debugfs.h>
 #include <linux/ptdump.h>
 #include <linux/kasan.h>
 
@@ -163,3 +164,21 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 	/* Flush out the last page */
 	st->note_page(st, 0, -1, 0);
 }
+
+static int check_wx_debugfs_set(void *data, u64 val)
+{
+	ptdump_check_wx();
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(check_wx_fops, NULL, check_wx_debugfs_set, "%llu\n");
+
+static int ptdump_debugfs_init(void)
+{
+	debugfs_create_file("check_wx_pages", 0200, NULL, NULL, &check_wx_fops);
+
+	return 0;
+}
+
+device_initcall(ptdump_debugfs_init);
-- 
2.41.0


