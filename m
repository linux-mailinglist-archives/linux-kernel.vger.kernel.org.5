Return-Path: <linux-kernel+bounces-109271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B988170E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC99281ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658B6A8AF;
	Wed, 20 Mar 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT2XkyjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837D320B;
	Wed, 20 Mar 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957819; cv=none; b=kRW7aSGvFe+X5ZbQGSbLFCe/p/I9a/fzjkl/OZYzH3ghpcCw6dIXx43yGnDCJVYTlGvAqWPgkXI5b29Lw9w5mBoRNCroBk5fdXWVjX2YuyCA7E0vxAXfjlb8hxdOjS6ULunEk9sRXg4BW95CUwOhQ5hkmKA51qKo9HZakC2f6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957819; c=relaxed/simple;
	bh=rtNpxUvHf2jH9+p/WX4OSE0NIMCFyZPxBNfrQ4XJKF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Urh3mnpdedsIMAlVVneZ3zmKqwNuD5qtz0iUUM9YRk4tyrPP3RHZ8E2NFt3YqNZGhPPHuzmb398kxhAdUBEUZzY8ocYvjG547d33Uyx1hlR3spz/wQJKpz8BRxedXMgX2v+xuhQ6ulco03A2BTfuVZ3TfJtg1dzUA2oKx2BR6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT2XkyjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB2AC433F1;
	Wed, 20 Mar 2024 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710957819;
	bh=rtNpxUvHf2jH9+p/WX4OSE0NIMCFyZPxBNfrQ4XJKF0=;
	h=From:To:Cc:Subject:Date:From;
	b=KT2XkyjSLxo+ONcnO2ZQba1NcVrBFuY3cN/I5oHrVScqmqp8rPKW1u4eVhfpYX+F0
	 MxiguZiKMdh6jhNQEV7wP9JabdOCN1N/2j5jjzezYGu63fgCmy4mU5O6xFh4G6BQbU
	 va//epIxZCHyAy+IRRin8Cpmr8NioOUq2C21SYOY5eG93+mK1RqJGeRUWfd6wqiGV/
	 3d1ySDWIE1fDQi7X/ypZcbBpI0oDjIxot0d0VFB9pDmtc9VLnh7f5C3LinVoMOGuZQ
	 FNB+moL3NNlpOV+v0ZV77opjIS9FwIfQGo/xRiyxMTPqPBPzmePxT1KgCvE41Ov88H
	 G9CIrwyLNFDBw==
From: Arnd Bergmann <arnd@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Chancellor <nathan@kernel.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Hao <haokexin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] powerpc: ps3: mark ps3_notification_device static for stack usage
Date: Wed, 20 Mar 2024 19:03:21 +0100
Message-Id: <20240320180333.151043-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The device is way too large to be on the stack, causing a warning for
an allmodconfig build with clang:

arch/powerpc/platforms/ps3/device-init.c:771:12: error: stack frame size (2064) exceeds limit (2048) in 'ps3_probe_thread' [-Werror,-Wframe-larger-than]
  771 | static int ps3_probe_thread(void *data)

There is only a single thread that ever accesses this, so it's fine to
make it static, which avoids the warning.

Fixes: b4cb2941f855 ("[POWERPC] PS3: Use the HVs storage device notification mechanism properly")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/ps3/device-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 878bc160246e..ce99f06698a9 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -770,7 +770,7 @@ static struct task_struct *probe_task;
 
 static int ps3_probe_thread(void *data)
 {
-	struct ps3_notification_device dev;
+	static struct ps3_notification_device dev;
 	int res;
 	unsigned int irq;
 	u64 lpar;
-- 
2.39.2


