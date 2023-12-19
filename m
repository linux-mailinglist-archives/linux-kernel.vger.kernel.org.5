Return-Path: <linux-kernel+bounces-6091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213F819487
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F29E1C24A06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE1405FA;
	Tue, 19 Dec 2023 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUOCQhZa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE452405D0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MDH/v7RIAoJOaCo5XP5ceyIizo5rb419HqEyQWHity4=; b=TUOCQhZabfkqc+H17CMAeuXpYW
	Ts3oLJl7Uopu3BV26uxD7iRUl1vtqg4I+2QuAEDVybDwdaWo+95q2OAdHjn1su6rKSHwidmXeB3gn
	QIJLPEKS37vCn2TSB3bL9gYDxJuSr8i+0uI4bkJsxHWlZhxIa9fvhJbuZwOPMLUYXVLy8ZcyFG4Ds
	uVjrArG9DGp9aoS/bdL7tw8rJTrkkTwrw9nWyK5HzWZbI1bQyibixxhaJD9t1d/p506RWjv5ht/Yk
	fUkcAvEeFvxqIoyQ/apwJjc7lojQR2lhmfxglUmF+8DaXWVnSW4lE9bqJp+dKD/Q8uMNjOa9jp1/D
	7D10efww==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFjRE-00FfoS-0b;
	Tue, 19 Dec 2023 23:23:48 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] LoongArch: signal.c: add header file to fix build error
Date: Tue, 19 Dec 2023 15:23:47 -0800
Message-ID: <20231219232347.19479-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

loongarch's signal.c uses rseq_signal_deliver() so it should
pull in the appropriate header to prevent a build error:

../arch/loongarch/kernel/signal.c: In function 'handle_signal':
../arch/loongarch/kernel/signal.c:1034:9: error: implicit declaration of function 'rseq_signal_deliver' [-Werror=implicit-function-declaration]
 1034 |         rseq_signal_deliver(ksig, regs);
      |         ^~~~~~~~~~~~~~~~~~~

Fixes: b74baf4ad05b ("LoongArch: Add signal handling support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
M:	Huacai Chen <chenhuacai@kernel.org>
R:	WANG Xuerui <kernel@xen0n.name>
L:	loongarch@lists.linux.dev

---
 arch/loongarch/kernel/signal.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -15,6 +15,7 @@
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
 #include <linux/irqflags.h>
+#include <linux/rseq.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/personality.h>

