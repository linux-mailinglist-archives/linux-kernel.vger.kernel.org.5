Return-Path: <linux-kernel+bounces-32233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9148358EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A6F2823A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AD15C8;
	Mon, 22 Jan 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTtQ7CnR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE637B;
	Mon, 22 Jan 2024 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882979; cv=none; b=aaXvXbOUeg1kSIQmQiru7fAmeWgWRG4ITB1GXr3c0h0aQnYc8Kciqo0jfdxEoE0q12XUtutr9QC8VdWvPSRuPj/gOy5uQ4m1BtAKC87eDZEphdFv4NiAPoREuJm3fs/G0QWXxvjPXHVnuRnXeXhvDC3kHE7wp7l434v9GPZkIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882979; c=relaxed/simple;
	bh=aVQvquY3/QZrbd8jHI67vn2mQbmidA09BUUPYfRdUOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tty0DWUiiHubVCiEJvButucwfP4lf36/o6POPT9Px243oFqQDCx3XkZT/JVNU4Jg6HdbAdNXtY5Zl1xI4i3QE0NSU44C5i3geUmLqdPIoE068NVkMiIgPctrhcbumRCJyuO4b+1k1sDDh49/yqJNGD+JiYSgosdVOnD4v5i7/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTtQ7CnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64366C433A6;
	Mon, 22 Jan 2024 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705882978;
	bh=aVQvquY3/QZrbd8jHI67vn2mQbmidA09BUUPYfRdUOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTtQ7CnRAUueJnnwKyKVtqaOwLHuwC50ol1N6VBH3F4bXANTK4yKJAw6z1Bd+7gnE
	 0IIJKaDyNCShEoILNDTHusQSstJiDlGlbnsDfmMniFSVrchtQUhYr3vI3l4khHjkKd
	 h6LcwvPzGM+OP1JHcacDkJnkgZw9TagVLJx1zZXf3RfUMrSsM7aItVVFJokHuMGpmC
	 q0Pw3Argq3++kZn2Cymq+WX+dr3xaTG8SFvmjka986TDgrZ7yZ/BegxfAUzFx6jJF1
	 jY8188HAgmTprMrmSOwzKr/UnrdXb2LuUYjSlIAZy/EkYhh97eiF4C50oT+MFjUr0s
	 44HlDYBKQ385A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Heiko Stuebner <heiko@sntech.de>,
	Jerry Shih <jerry.shih@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com
Subject: [PATCH v3 02/10] RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO
Date: Sun, 21 Jan 2024 16:19:13 -0800
Message-ID: <20240122002024.27477-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122002024.27477-1-ebiggers@kernel.org>
References: <20240122002024.27477-1-ebiggers@kernel.org>
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
index bffbd869a0682..5613b2bb686ec 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -571,20 +571,27 @@ config RISCV_ISA_V_PREEMPTIVE
 	  consumption due to the allocation of per-task's kernel Vector context.
 
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


