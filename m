Return-Path: <linux-kernel+bounces-167340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A4A8BA82A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF3B217AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE5148319;
	Fri,  3 May 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="r/XIi942"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C6146A66
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722995; cv=none; b=MkxY2qO+ivke05HkrPG12+5gbaW6Qinsd5HuQZsWriVkNefwEiBIcLNB//QA8ucJZ7DzxOHdBy3cYkvwH0l7sfZbFrFfnyINmP15F1IkNAw2nGhezerBzUVyftNdtkpeQG9AKcOsKpahulD5VFtdgtrAlE503ZNIWq+UttN7hic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722995; c=relaxed/simple;
	bh=ahhzW9dnhyFxRLPS4I3nFGCbkRfNCSQ4XiAAz1KsG3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO9IBIZeRVqGKx+T62queMSSdbTmcrbdcgHNb4S0SNo/HjBazGw43jc0b9DyGBfmlBZRAfMzuIPclSRYFdVeYhMhnbeOy03s1BdQG1BM1uan9VgOa9gj/jbmeIedwe4UNXsorVPiHcBaZsAVqN8SZ+zXEj2PIGvAIbOy0EObQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=r/XIi942; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714722991;
	bh=Xb4uZcBO3ovCjGUGsxkoEGWYJ/aNPwvO8oVcR3qqzIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/XIi94277McCWwhdAjYT+0VYIGkuxJC1N9kJtqfpmvQk3+SScslZAbQFACFSYeI6
	 NB3gIgPmNKbphACVaJRlSjMBDJAzBN2S1KPYM97FuN00hnwsU2cBdRYPxhYOj8QELX
	 OWR0SM7hphCpZAF+pG4qLmi3kREc6tWjYwwoGmy+AEgVSvWGJ18xPvG6Qyzcp23c0I
	 u+Ge4fn+FBi0ad4ocsY132MiYDsnz5YfILVXbokV/qmHprZ9GO6zw5S+OantsqnlYs
	 eaotmD5tKFbm01PNj2OrOhQ/doOad++5HFX1LR0MwtCj3P9Gl1Rc7brRubF70gyGRl
	 CTixMm84cHeQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW36765XRz4x0v;
	Fri,  3 May 2024 17:56:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <arnd@arndb.de>,
	naresh.kamboju@linaro.org,
	<linux-kernel@vger.kernel.org>,
	<nathan@kernel.org>
Subject: [PATCH v2 2/2] powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n
Date: Fri,  3 May 2024 17:56:19 +1000
Message-ID: <20240503075619.394467-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503075619.394467-1-mpe@ellerman.id.au>
References: <20240503075619.394467-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is code that builds with calls to IO accessors even when
CONFIG_PCI=n, but the actual calls are guarded by runtime checks.

If not those calls would be faulting, because the page at virtual
address zero is (usually) not mapped into the kernel. As Arnd pointed
out, it is possible a large port value could cause the address to be
above mmap_min_addr which would then access userspace, which would be
a bug.

To avoid any such issues, set _IO_BASE to POISON_POINTER_DELTA. That
is a value chosen to point into unmapped space between the kernel and
userspace, so any access will always fault.

Note that on 32-bit POISON_POINTER_DELTA is 0, so the patch only has an
effect on 64-bit.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: Patch unchanged, changelog updated to reflect patch 1.

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index ba2e13bb879d..048e3705af20 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -37,7 +37,7 @@ extern struct pci_dev *isa_bridge_pcidev;
  * define properly based on the platform
  */
 #ifndef CONFIG_PCI
-#define _IO_BASE	0
+#define _IO_BASE	POISON_POINTER_DELTA
 #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET 0
 #elif defined(CONFIG_PPC32)
-- 
2.44.0


