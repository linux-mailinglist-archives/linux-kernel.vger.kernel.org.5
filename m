Return-Path: <linux-kernel+bounces-121682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A7888EC60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92B2296566
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0B14EC68;
	Wed, 27 Mar 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="MJ5m2FAV"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23B14C598
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559882; cv=none; b=P9tHdhYs0EKyepLsbg4mX5czCTGkCiXdnqEH2lHe2s1HKIxmWA5/62UtXs2y9ibaYC2/N6XungzxVZUyMQWz3AWpDVCbOO3B9Y5VWetCymdk9FTgrT0UC2cfFg9cHj4PEbXYR2uJzAHogceozsZ7b0XGixGKbaFozYDKy7s69F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559882; c=relaxed/simple;
	bh=K6QrVU5PVZBLkr9lH/YmwLeLzn9IdrE/2j59eke5SYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMwepg+ps67+F592RQQYhLeEiN3mLd30Bm8Y6FONt/y/uR1IeaLzfVn6XARLC35VyrEY2VQGpYFSJ6zv0Su5Lhd8p0kTp+KIu2AObsI0LDVnljow3BUG19m44xPI/XwMMc1eXab8ykRGiZBFKonsCBzTM6cwA/IDNR6g27gzgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=MJ5m2FAV; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711559880;
	bh=K6QrVU5PVZBLkr9lH/YmwLeLzn9IdrE/2j59eke5SYU=;
	h=From:To:Cc:Subject:Date:From;
	b=MJ5m2FAV9u/mzXXtMzeWGZzANo+OjhHwThNa2yxCvRBi54qpU0YfGTeI2DIf4Q+jK
	 DIHEaFeos/HcvAmQeU0VmEitjIlJzQ1PYa9X7vfjukXw1kVN54v2Ut2CYgMz1wCDL7
	 pxWjW/2W4y8ZK7MWvEtkJWkzq8sTnGvijThrHk9Q=
Received: from stargazer.. (unknown [IPv6:240e:358:111f:6100:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3CE0266B9E;
	Wed, 27 Mar 2024 13:17:55 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
Date: Thu, 28 Mar 2024 01:17:37 +0800
Message-ID: <20240327171737.27622-1-xry111@xry111.site>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows compiling a full 128-bit product of two 64-bit integers as
a mul/mulh pair, instead of a nasty long sequence of 20+ instructions.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..5a769bb92d7c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -56,6 +56,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.44.0


