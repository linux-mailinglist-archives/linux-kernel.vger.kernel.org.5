Return-Path: <linux-kernel+bounces-18274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413E825ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C787BB210F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21AA364D7;
	Fri,  5 Jan 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXaJB8Wz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44F364AF;
	Fri,  5 Jan 2024 18:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF0BC433AD;
	Fri,  5 Jan 2024 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704480689;
	bh=27H198mfFlg5dXLC/oksp1mcpXEcuJokQDeBYx0aQoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXaJB8WzuY5nP+yJ+mwqSjwdNaRp7yPccV92jRBlslwyh+JHEmlsu19u4IrdGKhEt
	 5mhE8tPnvjM3Bf7OkeUF2/mqa4cSco4uTn5Jhqifz08pFMvhIKAvi12frZQPV4iMnl
	 fx6FLSsMhO1+AAuN3RC0KEd85h/pB95EnM2z3HTXpwq35RJRbd0txvWZCHtMwVnsTW
	 RdJs7G0pbUuSTyRfcblBuAYp2Vbdcf+BNzGONibAzvtQXyMgFffLrn2t0oClofIphG
	 wh1BOqH6qHSQtXemF4tt+vcBds3F9ju/Eab7+AhUgvtjc9eKxrDNKbxdaeC35L7JGO
	 ual8jcvbyLvdQ==
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
	Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v2 04/12] RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO
Date: Fri,  5 Jan 2024 10:49:40 -0800
Message-ID: <20240105184950.43181-5-ebiggers@kernel.org>
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

From: Eric Biggers <ebiggers@google.com>

Add a kconfig symbol that indicates whether the toolchain supports the
vector crypto extensions.  This is needed by the RISC-V crypto code.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a6..bf275a713b1b5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -526,20 +526,27 @@ config RISCV_ISA_V_DEFAULT_ENABLE
 	  If you don't know what to do here, say Y.
 
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
 	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zbb)
 	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zbb)
 	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
 	depends on AS_HAS_OPTION_ARCH
 
+# This symbol indicates that the toolchain supports all v1.0 vector crypto
+# extensions, including Zvk*, Zvbb, and Zvbc.  LLVM added all of these at once.
+# binutils added all except Zvkb, then added Zvkb.  So we just check for Zvkb.
+config TOOLCHAIN_HAS_VECTOR_CRYPTO
+	def_bool $(as-instr, .option arch$(comma) +zvkb)
+	depends on AS_HAS_OPTION_ARCH
+
 config RISCV_ISA_ZBB
 	bool "Zbb extension support for bit manipulation instructions"
 	depends on TOOLCHAIN_HAS_ZBB
 	depends on MMU
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
 	   Adds support to dynamically detect the presence of the ZBB
 	   extension (basic bit manipulation) and enable its usage.
 
-- 
2.43.0


