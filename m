Return-Path: <linux-kernel+bounces-131584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D28989C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8701F2DF62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A0129E6E;
	Thu,  4 Apr 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tctwqk93"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6E823D0;
	Thu,  4 Apr 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240238; cv=none; b=Mfv/k9LBl55fzvzUVE8+hXvUbTGiCxovYINQfEqKDliPFMq+WXMA/eYJlYPMFiOGy+jbIkvuZLa5HH/OHh6OHC4r/hy2odnMeY22C9tH52nDC6K9WL7yk2l1d/Ukp9aGGeJT+n3fNHKaoJ5zoAo1eVI0wuQXnXmNMYx8eL+dNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240238; c=relaxed/simple;
	bh=fCiV5G+P7hLxL4/i+fatn5exEfxvCbsdD/tZJnnspDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rha/GG3c5Da7TgCqIw+gTdfDskCI+RR59mm+oqKHqS+ULP3YN7AdV7Ra+XgzqE0NbTsVhqa7j+ib7uTN8w+jB8ZZCxjVdgVhVPSAFZBUB2qToK7mGDIF6FHKj5GGNGq18dBaQgREvLm4e1jzPb+vaum+1M+XVqwqDTA3CTx8IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tctwqk93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1B4C43390;
	Thu,  4 Apr 2024 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712240237;
	bh=fCiV5G+P7hLxL4/i+fatn5exEfxvCbsdD/tZJnnspDM=;
	h=From:To:Cc:Subject:Date:From;
	b=Tctwqk93E2w4iLsFrEADOfQFuky5b4wNMuH6FA88PWnTMge2gd9Hb9e396USZ965X
	 X/JhrcRRgI/hyNaxrYA09P4GxYq9t47w868GKYGKvaniHLwu1zKEAxTpKaDGH7nxSf
	 4W8KuZfZkJkqDOJFMU1VdzBKY4pn4H7sVRNSvr12C+/Fa0YIIikqPxf1h2qBXYD4Y5
	 WdLs9hr5Oq3lVO8TRXPTLgSXdunvgNpBkHQ3I7iL4lmRbVcSNcSkonFwkNyhmYFnGT
	 YV8WYH87o7DqMAdJVbzimEHAEU/Ma+NaEH5xRmk8N7gl5Sa4vjwGmdii7BFYbAjZt0
	 7yFjs9n5jPC4g==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev
Subject: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
Date: Thu,  4 Apr 2024 15:17:02 +0100
Message-ID: <20240404-providing-emporium-e652e359c711@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=3u+yX39PQ8dR4zv/dMqW8YPDJelB+vvZV3YqW2204hQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl822LTjwUwHJoqN+fKFFm3BycEP1hoNrKwX41vS5S+1 bXxXr5bRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZiwMHwP7PP/eEiv1sfLKq0 V2q68F9UjXt3suRX0LdHRVEsSySmaDAynC5ZcfReOgfPsxPyDuYKEUVMiYz8wtM8kp7O8fjXWGT FBAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On RISC-V and arm64, and presumably x86, if CFI_CLANG is enabled,
loading a rust module will trigger a kernel panic. Support for
sanitisers, including kcfi (CFI_CLANG), is in the works, but for now
they're nightly-only options in rustc. Make RUST depend on !CFI_CLANG
to prevent configuring a kernel without symmetrical support for kfi.

Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
cc: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Sending this one on its own, there's no explicit dep on this for the
riscv enabling patch, v3 to continue the numbering from there. Nothing
has changed since v2.

CC: Miguel Ojeda <ojeda@kernel.org>
CC: Alex Gaynor <alex.gaynor@gmail.com>
CC: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: linux-kernel@vger.kernel.org (open list)
CC: rust-for-linux@vger.kernel.org
CC: Sami Tolvanen <samitolvanen@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Nathan Chancellor <nathan@kernel.org>
CC: llvm@lists.linux.dev
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index aa02aec6aa7d..ad9a2da27dc9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1899,6 +1899,7 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
+	depends on !CFI_CLANG
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
-- 
2.43.0


