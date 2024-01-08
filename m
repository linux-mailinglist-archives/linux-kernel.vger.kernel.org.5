Return-Path: <linux-kernel+bounces-19062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7633F826762
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC5A1C21780
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFECAD51;
	Mon,  8 Jan 2024 03:21:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B248827;
	Mon,  8 Jan 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.22.232.245])
	by gateway (Coremail) with SMTP id _____8Bx2elAaptlqgQDAA--.5571S3;
	Mon, 08 Jan 2024 11:21:36 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.232.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxO9wxaptlNuUGAA--.17925S4;
	Mon, 08 Jan 2024 11:21:33 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	WANG Xuerui <kernel@xen0n.name>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH v1 2/2] LoongArch: Enable initial Rust support
Date: Mon,  8 Jan 2024 11:21:17 +0800
Message-ID: <20240108032117.215171-3-wangrui@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108032117.215171-1-wangrui@loongson.cn>
References: <20240108032117.215171-1-wangrui@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxO9wxaptlNuUGAA--.17925S4
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr4xWr4xGr4fWr13CFWDKFX_yoW5Ary3pa
	929r97Jr4xXrykJrn8JFyUZr4UAFyDGr47XF18Cw18Jr4DZryUXr1ftFn3JF1rGws5ArW0
	gF15GryUArWUJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jHv3bUUUUU=

Add initial Rust support for LoongArch.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 Documentation/rust/arch-support.rst |  1 +
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/Makefile             |  3 +++
 scripts/generate_rust_target.rs     | 10 ++++++++++
 4 files changed, 15 insertions(+)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 14875a2e073a..73203ba1e901 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -15,6 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
 =============  ================  ==============================================
 Architecture   Level of support  Constraints
 =============  ================  ==============================================
+``loongarch``  Maintained        -
 ``um``         Maintained        ``x86_64`` only.
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 15d05dd2b7f3..6d39ec3077da 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -142,6 +142,7 @@ config LOONGARCH
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK
 	select HAVE_RSEQ
+	select HAVE_RUST
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_SETUP_PER_CPU_AREA if NUMA
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4ba8d67ddb09..ba45cb7b621c 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -81,8 +81,11 @@ KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
 KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
 endif
 
+KBUILD_RUSTFLAGS_MODULE		+= -Crelocation-model=pic
+
 ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS_KERNEL		+= -fPIE
+KBUILD_RUSTFLAGS_KERNEL		+= -Crelocation-model=pie
 LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext $(call ld-option, --apply-dynamic-relocs)
 endif
 
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 3c6cbe2b278d..3edda6a10dd0 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -161,6 +161,16 @@ fn main() {
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("target-pointer-width", "64");
+    } else if cfg.has("LOONGARCH") {
+        ts.push("arch", "loongarch64");
+        ts.push(
+            "data-layout",
+            "e-m:e-p:64:64-i64:64-i128:128-n64-S128",
+        );
+        ts.push("features", "-f,-d");
+        ts.push("llvm-target", "loongarch64-linux-gnusf");
+        ts.push("llvm-abiname", "lp64s");
+        ts.push("target-pointer-width", "64");
     } else {
         panic!("Unsupported architecture");
     }
-- 
2.43.0


