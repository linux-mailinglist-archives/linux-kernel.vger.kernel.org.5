Return-Path: <linux-kernel+bounces-113340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4988838B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03B91C234A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443B198327;
	Sun, 24 Mar 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk412bDo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51F19830A;
	Sun, 24 Mar 2024 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320141; cv=none; b=kTQesHKbsq0tlQrmUFybAEqoNkYhy2CULPVIz24rFfMwiUHCgeIbH4i6pQsL5rpoauC/ldS/0DG6e8yEphRYXDK6/CCgVEUYbRQRPgmJeXVHnDVMvfYXLXcRlYCUVqiFVh3ZBY1mVfbZI98qf2i7RAp3FlOB/7EJXZXOpapeMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320141; c=relaxed/simple;
	bh=jyV1TX5A+7iSqnqRUOa2/4OWZvNsUm6BFOPjlQ3iHEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Evyn9ExWUCj3DzXUC/B8odQcGaq1whgUVKRj0er+cEHYZHLPot9LCr2O/uEyLA5AmVz7HViHOjZZa/jljO+fDBpa8x8MBfPEG3EhdmDjSh9wvFN+8vMcXJOzth+mGQUo1G2XCXH3hT9isBddtplwJyaB+TkAHdHnc29Iy+J0KPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk412bDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11C2C433F1;
	Sun, 24 Mar 2024 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320141;
	bh=jyV1TX5A+7iSqnqRUOa2/4OWZvNsUm6BFOPjlQ3iHEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sk412bDogM13Zwm+Y947/pW3jq5ZjkYsLP+CPALFVBApWZabrjASnRYyKa5/wCUy6
	 b/rtUAqnZ1HbNOrZGXqBpXy5fRmuUjK7iz6t6zD87YVNXJttkiXEFnKfkRPnYGSrUX
	 de/2E8+RU/ZG2WQzZGvQuV9xqE4sD8VshSi+J+I2zGD4ecPZZnKICA4WQwqpTYZ/2b
	 5w0ld5Cus4CHqOlNQZSsstiLiZldG4vXNhqylhINmiHZNMKcWej7elbw6Xj4bLt4cK
	 0VsZM/mYeQ+Yg2n6Dnu6rd1r1WRZeDwy5f903Cizhv0fi1os3qGHJi/AHoDjmM+RnR
	 6gr2AszshAJKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 449/715] powerpc/ps3: Fix lv1 hcall assembly for ELFv2 calling convention
Date: Sun, 24 Mar 2024 18:30:28 -0400
Message-ID: <20240324223455.1342824-450-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 6735fef14c1f089ae43fd6d43add818b7ff682a8 ]

Stack-passed parameters begin at a different offset in the caller's
stack in the ELFv2 ABI.

Reported-by: Geoff Levand <geoff@infradead.org>
Fixes: 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian builds")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231227072405.63751-2-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/ppc_asm.h  |  6 ++++--
 arch/powerpc/platforms/ps3/hvcall.S | 18 +++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index e7792aa135105..041ee25955205 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -201,11 +201,13 @@
 
 #ifdef CONFIG_PPC64_ELF_ABI_V2
 #define STK_GOT		24
-#define __STK_PARAM(i)	(32 + ((i)-3)*8)
+#define STK_PARAM_AREA	32
 #else
 #define STK_GOT		40
-#define __STK_PARAM(i)	(48 + ((i)-3)*8)
+#define STK_PARAM_AREA	48
 #endif
+
+#define __STK_PARAM(i)	(STK_PARAM_AREA + ((i)-3)*8)
 #define STK_PARAM(i)	__STK_PARAM(__REG_##i)
 
 #ifdef CONFIG_PPC64_ELF_ABI_V2
diff --git a/arch/powerpc/platforms/ps3/hvcall.S b/arch/powerpc/platforms/ps3/hvcall.S
index 509e30ad01bb4..59ea569debf47 100644
--- a/arch/powerpc/platforms/ps3/hvcall.S
+++ b/arch/powerpc/platforms/ps3/hvcall.S
@@ -714,7 +714,7 @@ _GLOBAL(_##API_NAME)				\
 	std	r4, 0(r11);			\
 	ld	r11, -16(r1);			\
 	std	r5, 0(r11);			\
-	ld	r11, 48+8*8(r1);		\
+	ld	r11, STK_PARAM_AREA+8*8(r1);	\
 	std	r6, 0(r11);			\
 						\
 	ld	r0, 16(r1);			\
@@ -746,22 +746,22 @@ _GLOBAL(_##API_NAME)				\
 	mflr	r0;				\
 	std	r0, 16(r1);			\
 						\
-	std	r10, 48+8*7(r1);		\
+	std	r10, STK_PARAM_AREA+8*7(r1);	\
 						\
 	li	r11, API_NUMBER;		\
 	lv1call;				\
 						\
-	ld	r11, 48+8*7(r1);		\
+	ld	r11, STK_PARAM_AREA+8*7(r1);	\
 	std	r4, 0(r11);			\
-	ld	r11, 48+8*8(r1);		\
+	ld	r11, STK_PARAM_AREA+8*8(r1);	\
 	std	r5, 0(r11);			\
-	ld	r11, 48+8*9(r1);		\
+	ld	r11, STK_PARAM_AREA+8*9(r1);	\
 	std	r6, 0(r11);			\
-	ld	r11, 48+8*10(r1);		\
+	ld	r11, STK_PARAM_AREA+8*10(r1);	\
 	std	r7, 0(r11);			\
-	ld	r11, 48+8*11(r1);		\
+	ld	r11, STK_PARAM_AREA+8*11(r1);	\
 	std	r8, 0(r11);			\
-	ld	r11, 48+8*12(r1);		\
+	ld	r11, STK_PARAM_AREA+8*12(r1);	\
 	std	r9, 0(r11);			\
 						\
 	ld	r0, 16(r1);			\
@@ -777,7 +777,7 @@ _GLOBAL(_##API_NAME)				\
 	li      r11, API_NUMBER;		\
 	lv1call;				\
 						\
-	ld	r11, 48+8*8(r1);		\
+	ld	r11, STK_PARAM_AREA+8*8(r1);	\
 	std	r4, 0(r11);			\
 						\
 	ld	r0, 16(r1);			\
-- 
2.43.0


