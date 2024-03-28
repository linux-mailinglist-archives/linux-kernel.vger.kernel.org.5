Return-Path: <linux-kernel+bounces-122434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255088F75C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05993B21F26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747084E1CC;
	Thu, 28 Mar 2024 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmNTYAey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CC48CFC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604367; cv=none; b=g+ENHLd3fUuxSSQlv4EnrWvcvYmgkXd5Yco0XW8fMhm6AHAKen5K/NyJcGQnq1j+aDilveR9DCYjsXu6FKxWm+m47MGYpjnhgWnY9yFXIY8mBWuVvSabCft2A+DZlcKlGtQ5RXuGatbUkSVvHFxfGP30ulKNhnuTS1yIx4KhGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604367; c=relaxed/simple;
	bh=OO4cjF1dzedIpZ/Rn3JEn332Jo/uK7j8W6cHjViP98o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSoAD3HaHWO8Y6ArM2A+2zerNIRX62bJbDPqY6eHyRilC96xsUSg0P4lJskQng1ZTh/MztA2nsT7hiI3lEpFy0odcjPUHMqWIxpjUagaHJ2yiDQc3+HWqy81/QS2+TIhOkevTDQZy6HMNr4ceW75SJpcsT/5uIXETtjE93yKswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmNTYAey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407E6C43394;
	Thu, 28 Mar 2024 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711604367;
	bh=OO4cjF1dzedIpZ/Rn3JEn332Jo/uK7j8W6cHjViP98o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmNTYAeyBMc+xYkhGgFyEffcpojMOnwTOpp3ZEhfPXorHPhe+4Y0db/ReKpJ3NE71
	 PseOlyDX59lGJAfYF+9ygLX87kUap6EjvAdIU9p43PST2depQXBR077fipEChK9t0v
	 XIfFeC1nkxG2zhzkrW2d3TJW+lWyd1IBlGMXpOieQz1vWQBBm9hYYEjYIxUSmoCcYW
	 T4lET7c+TAA6oOUvkvj/mfeCJVUxcfcIVm6vDoVKFgNErIePAsVqd8y2p/jnc+cKyc
	 HPXYwfZENKwPdO4eWLXZGQuZCd6gH79fMFi5hMROh1PzlLO85zIFA9fQO3b6RX5SBM
	 EY26xcCW5/Taw==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] ARC: mm: fix new code about cache aliasing
Date: Wed, 27 Mar 2024 22:39:19 -0700
Message-Id: <20240328053919.992821-3-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328053919.992821-1-vgupta@kernel.org>
References: <20240328053919.992821-1-vgupta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Manual/partial revert of 8690bbcf3b70 ("Introduce cpu_dcache_is_aliasing() across all architectures")

Current generation of ARCv2/ARCv3 based HSxx cores are only PIPT (to software
at least).

Legacy ARC700 cpus could be VIPT aliasing (based on cache geometry and
PAGE_SIZE) however recently that support was ripped out so VIPT aliasing
cache is not relevant to ARC anymore.

P.S. : This has been discussed a few times on lists [1]
P.S.2: Please CC the arch maintainers and/or mailing list before adding
       such interfaces.

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2023-February/006899.html

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig                 | 1 -
 arch/arc/include/asm/cachetype.h | 9 ---------
 2 files changed, 10 deletions(-)
 delete mode 100644 arch/arc/include/asm/cachetype.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 99d2845f3feb..4092bec198be 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,7 +6,6 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
-	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
deleted file mode 100644
index 05fc7ed59712..000000000000
--- a/arch/arc/include/asm/cachetype.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_ARC_CACHETYPE_H
-#define __ASM_ARC_CACHETYPE_H
-
-#include <linux/types.h>
-
-#define cpu_dcache_is_aliasing()	true
-
-#endif
-- 
2.34.1


