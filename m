Return-Path: <linux-kernel+bounces-138765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AA89FA15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC691F2A3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF416E871;
	Wed, 10 Apr 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAber0OZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011F16D9D7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759834; cv=none; b=BdGOKi7n5npEwWldJDlYdj1uSK4cSdv42/7IIozME+d6QhX6FFQ4s9pmL3alu+z6lNMBfbBIXsqFw6m+sNWkKt+O0zrsJJVyeRMBfZTs4NYvMFNeshEDAmK6te8+nyZCWJg/OgKb2NyqQ9wnSbIWXx88yOjYYFGMNazD9d7IL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759834; c=relaxed/simple;
	bh=pFynrsYJOJ+5eJpGClthQv/4eVfcqNbrm44H7lrcyi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4iZ405hkqvpBB5RX0OcNwF1Z4PmN66ULQduKkII2XLbZbUlwXzI1sleFF2bWRV/SWhcTkPtMSZ22brCGNh3243XyqwB0Y1xWyWI2T9Jfq9pkkvA8X6de5T//3idu9inWV1ON6aZip7nkbbm98E21N+l2UbAWn1ptjHymtFJWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAber0OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14443C433F1;
	Wed, 10 Apr 2024 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712759833;
	bh=pFynrsYJOJ+5eJpGClthQv/4eVfcqNbrm44H7lrcyi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAber0OZ+baRX6voEIYTgtB2eFPc3Y+1fQEr016XnTykIihv9Xr4GP3QBkkIYIgk7
	 AXXXzylli3I3oLJ52+0TJwbskZxkamEaymffPo6EnUU+baUR45FKXgzg3ADs5fmysU
	 a2BYjLWvxTRHCZVGsyUiEBJIVN6zYEZ09VJ36ePLxymvrN7kWOML7MtmPsrtyH3v/N
	 CXPT4ZbWKfJ4XApVf7+m64kFV/TPasLCiaA676XRjGdugxALST5LpywebwkDnn1aSY
	 1i7uLEoel5O662a5xf06e1y/YiedfZxOrsyaEhUdOAsxhOAhq7iN+kY8L2n/tlf+dM
	 qUSoMB72mfokg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: nommu: remove PAGE_OFFSET hardcoding
Date: Wed, 10 Apr 2024 22:23:46 +0800
Message-ID: <20240410142347.964-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410142347.964-1-jszhang@kernel.org>
References: <20240410142347.964-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
there's only one nommu platform in the mainline. However, there are
many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
the hardcoding value, and introduce DRAM_BASE which will be set by
users during configuring. DRAM_BASE is 0x8000_0000 by default.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7895c77545f1..b4af1df86352 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -247,10 +247,16 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
+if !MMU
+config DRAM_BASE
+	hex '(S)DRAM Base Address'
+	default 0x80000000
+endif
+
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MMU
-	default 0x80000000 if !MMU
+	default DRAM_BASE if !MMU
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
-- 
2.43.0


