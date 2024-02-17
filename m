Return-Path: <linux-kernel+bounces-69580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D670858BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDDD285A08
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632025571;
	Sat, 17 Feb 2024 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqORXxC1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207011CB8;
	Sat, 17 Feb 2024 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129581; cv=none; b=SmD6ZR3b88Hl9SYDKVMAN+Q4vg/7rbYsANfi1OxvQUlllPqTn5be9M15If7HFihwuPE6IFEOu4CYJt1reXYm0WJh93GYE3hbu/59QlpQg0RyfAkPyFt470D+FPRYaeOO+j3HOL1Xkc67gEgeYZsnrlB1j2eeTgBgkNg/h+jESIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129581; c=relaxed/simple;
	bh=avUrLgmjaZ/4znw54EQSx74+Weu5yL4/tWV6Q0kUqqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBZq4NySrSgIe1eK4FS+3C2YRdCqguQWjQTFxMIWFbfCFiTY1B1GMpB9yhsAwHPHrBabk/hOnRkbdkYbzGrYLekUMhg5PAU/h9Pq8q/TErSHjuW/fPX8P2YncTKXKw/KFPp4WNnsrT4vKT18BooqS9eSV84abX2p8qRO92h3upY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqORXxC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA652C433F1;
	Sat, 17 Feb 2024 00:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129580;
	bh=avUrLgmjaZ/4znw54EQSx74+Weu5yL4/tWV6Q0kUqqA=;
	h=From:To:Cc:Subject:Date:From;
	b=EqORXxC1n3bWyTzb2paqmiMw9Jj/Ee94sJ4ogLfyAUVuHEzAR853Ew7zMBcJq4Rqa
	 ZikziQ11oc+cVuDQ9yiOKxQATx4JQEjra6m6uZ/s7z+eXR2s/UzlQjPWRIUSZp3QTF
	 U9RcOq9RXm8f0+Xtpj7EHLld6R9yZqvhMmqaBZ75AGbwCSyl+rplz84uExyuvsxHlu
	 7r5dXT3lDkeYXxP7oIKkvlnX97eyPpM+S4z3goT/pFFeZhHN0hISMF1dUoEFqqaixD
	 595cKxAoyHSxa+ntNmrh98JYCdvRmkrFqq1VTDkQoaHTmlzhLy7WDfBiB+kH+CbGLH
	 Iexs3Iu5oAhJA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] kbuild: rust: use `-Zdwarf-version` to support DWARFv5
Date: Sat, 17 Feb 2024 01:26:02 +0100
Message-ID: <20240217002602.57270-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rust 1.64.0 introduced (unstable) support for the `-Zdwarf-version`
flag, which allows to select DWARFv5, thus use it.

Link: https://github.com/rust-lang/rust/issues/103057
Link: https://github.com/rust-lang/rust/pull/98350
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/Makefile.debug | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 059ff38fe0cb..693452bc826a 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -17,6 +17,12 @@ endif
 DEBUG_CFLAGS	+= $(debug-flags-y)
 KBUILD_AFLAGS	+= $(debug-flags-y)
 
+ifdef CONFIG_DEBUG_INFO_DWARF4
+DEBUG_RUSTFLAGS	+= -Zdwarf-version=4
+else ifdef CONFIG_DEBUG_INFO_DWARF5
+DEBUG_RUSTFLAGS	+= -Zdwarf-version=5
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= -fno-var-tracking
 DEBUG_RUSTFLAGS	+= -Cdebuginfo=1

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.43.0


