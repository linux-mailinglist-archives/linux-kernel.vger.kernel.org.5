Return-Path: <linux-kernel+bounces-90716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B048703D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C801A281704
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D331C3FB9B;
	Mon,  4 Mar 2024 14:14:41 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3D224D5;
	Mon,  4 Mar 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561681; cv=none; b=tnOEtqz/KBl8gUFnmJ8dD/Wx6yndL/AP2ZeBoPDzp/0OWtWSbRTHDHCYFb06gHN7XKdBjU39gp/bCmXs+uavrzWlZxdPXHnrGAXjrOTEy91PxoMZPeVRosh2KJ9UVYoLVGgIqj2f/DJuT8QAFFxIHF81Kosg65jKURXA8QTqQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561681; c=relaxed/simple;
	bh=a6ig0GS31zoi7FrVgcAaLZb/F7cK+wdGRMSMu2PFpZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCJOX9eeus5dfC0d+Uba/JyGvf2McP5io9JYWOqAWa7d20tZFfWa+Jr5NdInpCEaU4vdmT0z0wmMDCKtNsPPZUm68/NBwWNkSHZ5xoDyUZ+o+se5LzDfsGWPqtSJs6tOjyHMDB4eNnmO5OXoaNR1oLqewYLppgUbJ+VBgNnTHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.22.233.39])
	by gateway (Coremail) with SMTP id _____8DxbOlM1+VlsCQUAA--.40606S3;
	Mon, 04 Mar 2024 22:14:36 +0800 (CST)
Received: from localhost.localdomain (unknown [112.22.233.39])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzxND1+Vlkt1NAA--.20796S2;
	Mon, 04 Mar 2024 22:14:30 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	loongson-kernel@lists.loongnix.cn,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] loongarch: rust: Switch to use built-in rustc target
Date: Mon,  4 Mar 2024 22:14:26 +0800
Message-ID: <20240304141426.163517-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxzxND1+Vlkt1NAA--.20796S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1DJr4rKryktw48Cr4rWFX_yoW5CrWDpa
	9a9w4rArW0qrWktr4kJFyYgws0kFn8Wr1j9FWxGw10yr4fXrWIgrs2yrsxGF1rGa4Du3yr
	Was3CF9rAF4UAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==

This commit switches to using the built-in rustc
loongarch64-unknown-none-softfloat target for LoongArch.

The Rust samples have been tested with this commit.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
base-commit: ("rust: Refactor the build target to allow the use of builtin targets")
Link: https://lore.kernel.org/r/20231020155056.3495121-2-Jamie.Cunliffe@arm.com
---
 arch/loongarch/Makefile         | 2 +-
 rust/Makefile                   | 2 +-
 scripts/Makefile                | 2 +-
 scripts/generate_rust_target.rs | 7 +------
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index df6caf79537a..17aabe7b0315 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -101,7 +101,7 @@ ifdef CONFIG_OBJTOOL
 KBUILD_CFLAGS			+= -fno-jump-tables
 endif
 
-KBUILD_RUSTFLAGS			+= --target=$(objtree)/scripts/target.json
+KBUILD_RUSTFLAGS			+= --target=loongarch64-unknown-none-softfloat
 KBUILD_RUSTFLAGS_MODULE		+= -Crelocation-model=pic
 
 ifeq ($(CONFIG_RELOCATABLE),y)
diff --git a/rust/Makefile b/rust/Makefile
index fe045dbc701e..cb40a1ce1331 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -437,7 +437,7 @@ $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--re
 $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 	$(call if_changed_dep,rustc_library)
-ifneq ($(or $(CONFIG_X86_64),$(CONFIG_LOONGARCH)),)
+ifdef CONFIG_X86_64
 $(obj)/core.o: scripts/target.json
 endif
 
diff --git a/scripts/Makefile b/scripts/Makefile
index bc90520a5426..fe56eeef09dd 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -12,7 +12,7 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen
 
-ifneq ($(or $(CONFIG_X86_64),$(CONFIG_LOONGARCH)),)
+ifdef CONFIG_X86_64
 always-$(CONFIG_RUST)					+= target.json
 filechk_rust_target = $< < include/config/auto.conf
 
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 54919cf48621..acd3b1acef83 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -164,12 +164,7 @@ fn main() {
         ts.push("llvm-target", "x86_64-linux-gnu");
         ts.push("target-pointer-width", "64");
     } else if cfg.has("LOONGARCH") {
-        ts.push("arch", "loongarch64");
-        ts.push("data-layout", "e-m:e-p:64:64-i64:64-i128:128-n64-S128");
-        ts.push("features", "-f,-d");
-        ts.push("llvm-target", "loongarch64-linux-gnusf");
-        ts.push("llvm-abiname", "lp64s");
-        ts.push("target-pointer-width", "64");
+        panic!("loongarch uses the builtin rustc loongarch64-unknown-none-softfloat target");
     } else {
         panic!("Unsupported architecture");
     }
-- 
2.44.0


