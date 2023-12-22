Return-Path: <linux-kernel+bounces-9338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52A481C44E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7529428543B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822FB539F;
	Fri, 22 Dec 2023 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aLvB0/0X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5324680;
	Fri, 22 Dec 2023 04:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vToPUnmN/oarZ/hFlZN6gbMr1MxOMg0QMOvO7BUHMxM=; b=aLvB0/0XIIBheIueWG+PGbXLD4
	ND/RT/jNr+W2ma814MPZt8oqaIi/mNkPNTqx/XrreansEPhPwFfjaGk6ws5LlHN1CZIIxRPC/Koy8
	iUToKssdMQcdY4fvvT4zX0PRtUBX/PQQMY0K6jvTeqe4vC65Iq12a7us+DtfI8yfVUkCLCjyBr4Zg
	r/ywM+AEkfDPoeZs2zsoQEPtJGSHrXf0MbuH7OTPq4AEEdiV0uUFAtpOAYhPeKfoR4T9C9kzu+1NJ
	OO4GCRw0rWBf3Jw6l3YIAPxb/91bsZmBVxSuUi8abbLgSvgcm1AcQXBdzFO8xYbwgSEeADeVHKm60
	qe9/jqhQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGXQ3-004sg6-1u;
	Fri, 22 Dec 2023 04:45:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2] LoongArch: signal.c: add header file to fix build error
Date: Thu, 21 Dec 2023 20:45:54 -0800
Message-ID: <20231222044554.25656-1-rdunlap@infradead.org>
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
Cc: Kent Overstreet <kent.overstreet@gmail.com>
---
v2: repair Cc: list

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

