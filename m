Return-Path: <linux-kernel+bounces-14093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A88217CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470371C21441
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6ACA7D;
	Tue,  2 Jan 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LekdIHCl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBDCC8C4;
	Tue,  2 Jan 2024 06:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE451C433C7;
	Tue,  2 Jan 2024 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178223;
	bh=27H198mfFlg5dXLC/oksp1mcpXEcuJokQDeBYx0aQoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LekdIHClfL7jGei4zMmYx7yDpqNzFa2vP41Ce7SFYItp8gfUQdUpWnX2Npp2Y14Vj
	 NAFhqo1z54zhnN5Kt4cEkBdD1kg18yjObC/MLNDPAAQIb38m/5leZdC81QjrARzgSi
	 49HQ+EbrqW8Q4WBk2mDbdf5IshVRs1h9CW4ecEz4rpll99jfFaRrOoRerFKKRbZve7
	 wnSCF+q7X3scrxXMaoR/7qSlT6AyxL3uyr4ZEUg4r9/madgi7jvNX+L5hK/UO37lG6
	 8s4wJK67VNVruoC2b3k3jO1oQ2lGVK/wt/JnAlvQLfyuuzTz9STtkqZ2h4hGxrBKKs
	 k0mt6rGUOIu1w==
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
Subject: [RFC PATCH 04/13] RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO
Date: Tue,  2 Jan 2024 00:47:30 -0600
Message-ID: <20240102064743.220490-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102064743.220490-1-ebiggers@kernel.org>
References: <20240102064743.220490-1-ebiggers@kernel.org>
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


