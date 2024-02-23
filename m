Return-Path: <linux-kernel+bounces-78391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE07D8612DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFACB1C221F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFB7F7DB;
	Fri, 23 Feb 2024 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoneYX3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FF22EF5;
	Fri, 23 Feb 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695513; cv=none; b=l6yJOws4LG4tdnZd7Mh1MDeilqd0yuGsbMAJGLJ+9jLrxVe33VICP1Ii3MFczulx+BIVDOf6W1cNeOTETiI0sqJIljGgA7eouPTLKNl8l3zQsN7rrpnAMRgXyVv0p6vbUZ5LgZH5V7JIxf90b4pLZS0VdnE4jzth8xLd2smIB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695513; c=relaxed/simple;
	bh=7Fsxt5dUnwFrhpCWGP+0Mujqc3o+HtSLor3KISLhljg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHyeOywPwIUpltgLSeeKB+EgZPjzj0wdIlaeO3Uhr7Iwje6fOTPufwuIfXSFMThO6VLnKGlZY1H7PiEPtU/W5WoS0SmGpxaKp2hO/ufxa+Y8BEo15UKkbTDWzE1tnh76IPckIl7vM69qYHLyojQtoOvTh+5D3eQG+IIJLiU0fQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoneYX3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B284C433C7;
	Fri, 23 Feb 2024 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695513;
	bh=7Fsxt5dUnwFrhpCWGP+0Mujqc3o+HtSLor3KISLhljg=;
	h=From:To:Cc:Subject:Date:From;
	b=XoneYX3fUtHPv/QtDZAlU3gHMtogjPJMXJG0fKir4kkVyqoMQML0T7gyb5110b4YG
	 KUCFwNlKqmsZfwbRrzD+8/a5t4Sa8LL+rwEElpO28omgZQxBqNIUxl/wsiDpL/xzx7
	 Ilrf3jD1w7e0snf14FHGxB9DyjgiYQTFh5ib2D2zquDh7vx84D/bCQn9SV+D7+8Zxj
	 UZFUmE3hQjFv6Z45O9WScBCiiqz4Lwe3ukGIUCXfeWptMwU1lhroo4BEXI53pRWgr2
	 nS7b1DRD0guVYixLerEMCwstXo8isimJ2KLRjToXNVws/oXu95oIXDY63mgKD1Sx3A
	 BPUJChTRrtryQ==
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
	llvm@lists.linux.dev
Subject: [PATCH v2 0/3] RISC-V: enable rust
Date: Fri, 23 Feb 2024 13:38:02 +0000
Message-ID: <20240223-leverage-walmart-5424542cd8bd@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Q8gmemx8ug1xAd70cV163zIEsT6BGWLzhKHazmMK2rg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk35u95x9GhKR107q3o3E9S/JuMvfbMDNu+5IpYxtQMh sazwsHsHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI0kRGhr+fNvi/eLe2Xc6q o/h1Wg/PNvEtmt4G9+2XSp20c7VI/c/wi1lP9lxgrcS6zU92qRf1vp5zZNu/oh16AUHhxyf8uh+ xmw0A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Now with a patch to disable RUST if CFI_CLANG is enabled.
I've also intentionally not turned on the gcc support, as discussed on
v1.

As this was lifted from the state of the Rust-for-Linux tree, the commit
messages from there cannot be preserved, so these patches have commit
messages that I wrote.

I've tested this on Icicle, and the modules seem to work as expected.
Unfortunately there appear to be implicit 32-bit divisions (or similar)
in core Rust code, so, as in the downstream Rust-for-Linux tree, Rust is
only enabled for 64-bit.

Thanks,
Conor.

Changes in v2:
- Rebase, since a good bit of time has passed!
- Add the extra patch, disabling when CFI_CLANG is enabled.

Changes in v1:
- rebase on v6.3-rc1
- resort the `um` entry in the arch-support table while adding RISC-V
  to it
- drop 32-bit bits
- have another crack at assigning authorship

Changes in RFC-RESEND:
- fix the asymmetrical additions in the Makefile bits
- add cc-cover to my git send-email command...

CC: Miguel Ojeda <ojeda@kernel.org>
CC: Alex Gaynor <alex.gaynor@gmail.com>
CC: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Gary Guo <gary@garyguo.net>
CC: Björn Roy Baron <bjorn3_gh@protonmail.com>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Nathan Chancellor <nathan@kernel.org>
CC: Nick Desaulniers <ndesaulniers@google.com>
CC: Tom Rix <trix@redhat.com>
CC: rust-for-linux@vger.kernel.org
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: llvm@lists.linux.dev

Conor Dooley (1):
  rust: make mutually exclusive with CFI_CLANG

Miguel Ojeda (2):
  scripts: generate_rust_target: enable building on RISC-V
  RISC-V: enable building 64-bit kernels with rust support

 Documentation/rust/arch-support.rst |  1 +
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/Makefile                 |  2 ++
 init/Kconfig                        |  1 +
 scripts/generate_rust_target.rs     | 16 ++++++++++++++++
 5 files changed, 21 insertions(+)

-- 
2.43.0


