Return-Path: <linux-kernel+bounces-124278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBC891502
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371DD1F22060
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379EB4AEDE;
	Fri, 29 Mar 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGWTgk/H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F1745016;
	Fri, 29 Mar 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699560; cv=none; b=ikkIlxm8IA5DC76VwwWodXST10KRwOx3k3OjXYqWRO+gcBqOxbuziC/wCWE6jMsfYUzi2PxQDuv+b9zHIvabQeK5p4rvUZ1Efoz5BnNduEfUHTk6h8VAws94FxSCtvy2KOO2D09rKFEV8hkDqevw2FYxugvqoj8tUq049Z3b33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699560; c=relaxed/simple;
	bh=XX+VRU77adYKl58Xf5SH3Psy1Aivalng4w2owP5PZaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UauHUXgV5ed66seL5BShnnjnYLRPjUqOp+onFJU/xoTvw6aF0Fp0CU6hT7xzok70Pcva8MUEDemRsS90+yp0W5vjf2Ml6DSynaHfFm0Ik/RQvarWYLmmxcKSvd/dYZ6Uy9TzVy7S8UWtnICoMqfDLC28+jKliYoj6bbG9Gp+8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGWTgk/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB36DC433C7;
	Fri, 29 Mar 2024 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711699560;
	bh=XX+VRU77adYKl58Xf5SH3Psy1Aivalng4w2owP5PZaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGWTgk/HOt2BEKHYJrtDMwiPg7uV/Rq5N/hvnbapV1svXV7MqGHAG/zdfJxfwPfLx
	 cpJB1vtpZFiBaKhsCUQ0+ySb4idOjLg//OMzEoTWdqIg/ZZLa2c3rLpFx8LcQ4k14o
	 SwY2hZnZ/VGoT037asg0u5THFYPZOya/PVG84itX25eq4i8UVTBoCoUVk+keN6vfWd
	 8fyMbYjH2fRkyl5SPI/FWhA7ozrQXvzeGsBzTDhAw4E/+mPG+nFcOpKXGWox3+uwyK
	 1tvNOgxWaggTq4kGclnN0GlXOO9Q9ZKIPtg4PDeCTrToWVwK4jG3Wf6MVwSYXEiZ6H
	 45OLpA1qvm9pA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 1/6] x86: add kconfig symbols for assembler VAES and VPCLMULQDQ support
Date: Fri, 29 Mar 2024 01:03:49 -0700
Message-ID: <20240329080355.2871-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329080355.2871-1-ebiggers@kernel.org>
References: <20240329080355.2871-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add config symbols AS_VAES and AS_VPCLMULQDQ that expose whether the
assembler supports the vector AES and carryless multiplication
cryptographic extensions.

Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig.assembler | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 8ad41da301e5..59aedf32c4ea 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -23,9 +23,19 @@ config AS_TPAUSE
 config AS_GFNI
 	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
 	help
 	  Supported by binutils >= 2.30 and LLVM integrated assembler
 
+config AS_VAES
+	def_bool $(as-instr,vaesenc %ymm0$(comma)%ymm1$(comma)%ymm2)
+	help
+	  Supported by binutils >= 2.30 and LLVM integrated assembler
+
+config AS_VPCLMULQDQ
+	def_bool $(as-instr,vpclmulqdq \$0x10$(comma)%ymm0$(comma)%ymm1$(comma)%ymm2)
+	help
+	  Supported by binutils >= 2.30 and LLVM integrated assembler
+
 config AS_WRUSS
 	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
 	help
 	  Supported by binutils >= 2.31 and LLVM integrated assembler
-- 
2.44.0


