Return-Path: <linux-kernel+bounces-78392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE48612E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ED21F24FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0A81744;
	Fri, 23 Feb 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na5p+TP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B137FBA7;
	Fri, 23 Feb 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695517; cv=none; b=kBZSFmSfE/Jn3LdahfFsWEAwaF7nRMeGOwzPWlo5WCGZGbWC+jZVMC19g5mAXtHYBlUwW1OCChZTzj5tr3r7XmX3OfWwzu+qT7xV0Jm+kNw73u9cXmzlkzh+or7CjQwbwdZowrMlSXdOce8UzFbaZhSL+AWBgcVsXZAOSw9Az/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695517; c=relaxed/simple;
	bh=VltUvQLlmLwkpl8kRnLO58R3H1pbUYjiNeAYAhm4vK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaJ/c/2exwFYr1WSrg1BoI1QlYDXCqk0PchzXrx/RWF8J1/TPYimKKSI+VjDa67THgBilCwWf6dJ0jucvN6y9fcuk/T16lBSh4Tyv5DNVL8V+NGF8H060BAU4pTDMqQo6hI3AE68nxlnPwYa3r+mmCMN/x3ZYuqeqoIYEmjHiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na5p+TP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611A5C433A6;
	Fri, 23 Feb 2024 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695517;
	bh=VltUvQLlmLwkpl8kRnLO58R3H1pbUYjiNeAYAhm4vK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Na5p+TP86HhyZXIS9INaL8dQBTOiswdRzULSa5FNq46+4a22pnBtTtloyqFR8cWc8
	 n8yn1MMy2W7P2cqPCBcS0OBpjP8xSadnJJcXmWRnWauvwKGLaTU4cll8SATYAhUv17
	 cYr9GnNe6g5JhklC6GcTpLtBe8w85TjlaGno0uWLbIrlH/aNG/uJRDYpZM3bkdYj3O
	 6K09xONc0jMaq1Kpvw0KdV/Jv/lw63QSQ/NRvdyygkYqtcjNvcy+e76orulwxLVITl
	 SAMd1plaBCYXZCO4bQkgBlK3+NOpjLRsMt5hBqFLEl/aBsq/mk/quDjslSCEZG5OE4
	 rVGmCyn2+AIGw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] rust: make mutually exclusive with CFI_CLANG
Date: Fri, 23 Feb 2024 13:38:03 +0000
Message-ID: <20240223-perjury-preshow-fc2cf73d552e@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-leverage-walmart-5424542cd8bd@spud>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CGpXuPYcXKOyMHoYWd5SM3467xfR+bc0vpqwYOI3iyQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk35u8JtHm+ZsH5Sc/CPbpmzj1yYUtL5lVNtfKQGyezj SYVXz8p0FHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJzJRhZHj+yWvHNJapDg0f b5+5HpMl+Cir0HdTfvXKf1lxFjVqwf4M/4v2a3lvq1kyS7umuGfKg7ig3pUBuwU4+zsuViUvVFZ YygsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On RISC-V, and presumably x86/arm64, if CFI_CLANG is enabled loading a
rust module will trigger a kernel panic. Support for sanitisers,
including kcfi (CFI_CLANG), is in the works, but for now they're
nightly-only options in rustc. Make RUST depend on !CFI_CLANG to prevent
configuring a kernel without symmetrical support for kfi.

Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
cc: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
This probably needs to go to stable. The correct fixes tag for that I am
not sure of however, but since CFI_CLANG predates RUST, I blamed the
commit adding rust support.
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b..6cf05824859e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1895,6 +1895,7 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
+	depends on !CFI_CLANG
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
-- 
2.43.0


