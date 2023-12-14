Return-Path: <linux-kernel+bounces-186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE2813D39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18C828395F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393666AC7;
	Thu, 14 Dec 2023 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy1KhZDQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4746720A;
	Thu, 14 Dec 2023 22:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34043C433C8;
	Thu, 14 Dec 2023 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702592591;
	bh=pgyu4wBiidMdBiu1uYG+TluTmLJL6JHzn+KTryLFeg4=;
	h=From:To:Cc:Subject:Date:From;
	b=hy1KhZDQeVmw/PKAZKMyHpyFpLjMJvZ9nzmSzg1q25LbazraEx0KJ3LDB8nRJJvpX
	 3jXCtGicmnegnajOaGeUiliNcYAg0Kv2/pOJZIINAIncAfSGEUcFTdS6+Sw3FkUUIV
	 O0nRnHfXWkFc0zAIDOsUyh8cCkqx1OCcYo+K5aMstdkf6vM6GKbcRbXYnQdMNrbxjS
	 qHc1tXmWh4RrjAfJAr3gYMqXpOSQIpykKFOM4pyoP6GAAVRIW4qrdMLUlff6dQIqiv
	 /4fO0fIg7F5Iy4RdxU4hqQedtn/JRLasYTUA9lvGmygWOzBJ/DJrzVqJiNz0QSh+q5
	 z8xkqRXYjB/TQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] kbuild: rust: add `rustupoverride` target
Date: Thu, 14 Dec 2023 23:22:53 +0100
Message-ID: <20231214222253.116734-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up the Rust support via `rustup`, one may use an override
in order to select the right version of the Rust toolchain.

The current instructions at Documentation/rust/quick-start.rst assume
one is using an in-tree kernel build (i.e. no `O=`) [1]. We would like
to provide also the way to do so for `O=` builds, but ideally in a way
that keeps the one-liner copy-pastable and without duplication [2].

Thus provide a new Make target, `rustupoverride`, that sets it up for
the user given their build options/variables.

Link: https://lore.kernel.org/rust-for-linux/20231207084846.faset66xzuoyvdlg@vireshk-i7/ [1]
Link: https://lore.kernel.org/rust-for-linux/CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com/ [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Viresh may send a patch on top of this to refer to `rustupoverride`
from the Quick Start guide in `Documentation/rust` -- that one should
probably be applied right after this one.

 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 70fc4c11dfc0..7fe82dd4dc6f 100644
--- a/Makefile
+++ b/Makefile
@@ -276,7 +276,8 @@ no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers headers_% archheaders archscripts \
 			 %asm-generic kernelversion %src-pkg dt_binding_check \
-			 outputmakefile rustavailable rustfmt rustfmtcheck
+			 outputmakefile rustavailable rustfmt rustfmtcheck \
+			 rustupoverride
 no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
 			  image_name
 single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
@@ -1611,6 +1612,7 @@ help:
 	@echo  '                    (requires kernel .config; downloads external repos)'
 	@echo  '  rust-analyzer	  - Generate rust-project.json rust-analyzer support file'
 	@echo  '		    (requires kernel .config)'
+	@echo  '  rustupoverride  - Set up a rustup override for the build directory'
 	@echo  '  dir/file.[os]   - Build specified target only'
 	@echo  '  dir/file.rsi    - Build macro expanded source, similar to C preprocessing.'
 	@echo  '                    Run with RUSTFMT=n to skip reformatting if needed.'
@@ -1735,6 +1737,11 @@ rustfmt:
 rustfmtcheck: rustfmt_flags = --check
 rustfmtcheck: rustfmt

+# `rustup override` setup target
+PHONY += rustupoverride
+rustupoverride:
+	$(Q)rustup override set $(shell $(srctree)/scripts/min-tool-version.sh rustc)
+
 # Misc
 # ---------------------------------------------------------------------------


base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
--
2.43.0

