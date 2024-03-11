Return-Path: <linux-kernel+bounces-98904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD438780E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE105283A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14033DBA8;
	Mon, 11 Mar 2024 13:50:39 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40D83D970
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165039; cv=none; b=ia1XGyx7GxkawCxEwEF1nXHVSEMrs1s9O4xlDk1BWuiT+UP/X7+XN6fwZmwkk2unxKW7RPRpjuFcaJpt59eEJLLMZbAIAc13CnehYdtvFXBIopapcKbXweCKUH3CNIvbVxdWymGE7VdlcOiC+hBHzdTQyw3p5p8NKAWv9KQQDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165039; c=relaxed/simple;
	bh=RwsgmWjB5jQM5rG+Q8V+ThuRJIdkgmR4+Rfw1CoFMJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duoNYMIXAXU3QeqI+kN7FQtT4lugcpD6xcl+cdnRXf3xubAVrefZF1Ko7WE5NJNMimdfHM3VpS66CkC1EGiMg5K8VKC1+of38XB4Jx3dhemL+TG+hC2jJS2Dv2iVsO8aalNzrAGpkeThLNl87yqKqE9st7mx8PSZoYhvIv9SY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4TtdKp2bbJz4x1CT
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:44:14 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id xRk62B00T0SSLxL06Rk6bv; Mon, 11 Mar 2024 14:44:06 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rjfwV-003L5c-2T;
	Mon, 11 Mar 2024 14:44:06 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rjfwk-005i88-Bg;
	Mon, 11 Mar 2024 14:44:06 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fork: Use THREAD_SIZE_ORDER
Date: Mon, 11 Mar 2024 14:44:04 +0100
Message-Id: <f713d82fe6526288f51fc138cd16681cec6b43a6.1710164592.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the existing THREAD_SIZE_ORDER definition instead of calculating it
from THREAD_SIZE and PAGE_SIZE.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0d944e92a43ffa13..e79fdfe1f0bf4953 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -252,9 +252,9 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
 	int ret;
 	int nr_charged = 0;
 
-	BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
+	BUG_ON(vm->nr_pages != THREAD_SIZE_ORDER);
 
-	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+	for (i = 0; i < THREAD_SIZE_ORDER; i++) {
 		ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
 		if (ret)
 			goto err;
@@ -535,7 +535,7 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 		struct vm_struct *vm = task_stack_vm_area(tsk);
 		int i;
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < THREAD_SIZE_ORDER; i++)
 			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
@@ -556,7 +556,7 @@ void exit_task_stack_account(struct task_struct *tsk)
 		int i;
 
 		vm = task_stack_vm_area(tsk);
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < THREAD_SIZE_ORDER; i++)
 			memcg_kmem_uncharge_page(vm->pages[i], 0);
 	}
 }
-- 
2.34.1


