Return-Path: <linux-kernel+bounces-18273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0D825ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06952814E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF2364A7;
	Fri,  5 Jan 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLofNzRT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613153609E;
	Fri,  5 Jan 2024 18:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11B5C433B6;
	Fri,  5 Jan 2024 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704480689;
	bh=nsJfxzeMQv5O8Qx1VjRmXPmszEADwolhj0yHfx5D/74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLofNzRTE48YcTNp2pEQs7koOanFijkUEzMPvxdXIP/DrnVTo1I4T2uHaF9AKaXrI
	 jgLoCgXIh9/cx/LfI0PtPZkQ25WQlWF1HKUnaVQax709V7Hzwz9z0mryE2XZLwZ3Rt
	 71JsLakPYJaaaxOrcjYlef+/OWzFCCutckJxgGbEXzNrnuKV/hzz2xnzLeWahhXlHA
	 JnHXBsJ3P2jfBSBXnJnlS0h6AIWrvpXAjkQbMDRZ9YtRFwrdF7Wit3m/rXP+0yRHay
	 XcbJJXsDC91dZGM4aKRP2anfU0GN6X1yoAj2FkBvXSeEsMY9/fWI3qWfM4XhWa2/0x
	 mhv5aMa9UnOeg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v2 03/12] RISC-V: add helper function to read the vector VLEN
Date: Fri,  5 Jan 2024 10:49:39 -0800
Message-ID: <20240105184950.43181-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105184950.43181-1-ebiggers@kernel.org>
References: <20240105184950.43181-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

VLEN describes the length of each vector register and some instructions
need specific minimal VLENs to work correctly.

The vector code already includes a variable riscv_v_vsize that contains
the value of "32 vector registers with vlenb length" that gets filled
during boot. vlenb is the value contained in the CSR_VLENB register and
the value represents "VLEN / 8".

So add riscv_vector_vlen() to return the actual VLEN value for in-kernel
users when they need to check the available VLEN.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/include/asm/vector.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 71af3404fda14..ae724e016fe24 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -218,11 +218,22 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 #define riscv_v_vsize (0)
 #define riscv_v_vstate_discard(regs)		do {} while (0)
 #define riscv_v_vstate_save(task, regs)		do {} while (0)
 #define riscv_v_vstate_restore(task, regs)	do {} while (0)
 #define __switch_to_vector(__prev, __next)	do {} while (0)
 #define riscv_v_vstate_off(regs)		do {} while (0)
 #define riscv_v_vstate_on(regs)			do {} while (0)
 
 #endif /* CONFIG_RISCV_ISA_V */
 
+/*
+ * Return the implementation's vlen value.
+ *
+ * riscv_v_vsize contains the value of "32 vector registers with vlenb length"
+ * so rebuild the vlen value in bits from it.
+ */
+static inline int riscv_vector_vlen(void)
+{
+	return riscv_v_vsize / 32 * 8;
+}
+
 #endif /* ! __ASM_RISCV_VECTOR_H */
-- 
2.43.0


