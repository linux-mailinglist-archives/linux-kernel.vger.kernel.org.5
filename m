Return-Path: <linux-kernel+bounces-9354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CB81C479
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505CA1F258DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9765D539A;
	Fri, 22 Dec 2023 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JW29o6h7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605523D8;
	Fri, 22 Dec 2023 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fCSM/xbXg41FRfHNUILYTv5XhyXDuX5hUzcGjOUJb1U=; b=JW29o6h7DCzdPnq/UvZWGf0APD
	7lTkLiEDSM+kLsJF1vt0E7A6omO1ElVQlKKk/jUNJ3KNCcBg0zP7RWX1sGbdGoKMrhjkfCRON6Re+
	3y42dysYyFgtMTCOGiJm/3lquOuEFAOCNtQ/MhOKzJ4qdmek1YobmnmVtvvFXcQ3q9wc9cOYcEu9L
	9Bi+ow6sXX/eab0wistbLEA0QsJxLrQu9kn2AniycGslicVCcXxz4d5cYma6hRTeuZjGbui+wTO2Z
	SgtZPyJMn2yb9vsMX6rj4ip4G0IDXXyOPHmYAwZhO+7gTL+lv/a5mVe/c9Xo10EBdIDhHo6cDjt82
	Jd7QqvKQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXcA-004v1T-1a;
	Fri, 22 Dec 2023 04:58:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v3] LoongArch: signal.c: add header file to fix build error
Date: Thu, 21 Dec 2023 20:58:25 -0800
Message-ID: <20231222045825.14732-1-rdunlap@infradead.org>
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
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
v2: repair Cc: list
v3: use Kent's @linux.dev email address

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

