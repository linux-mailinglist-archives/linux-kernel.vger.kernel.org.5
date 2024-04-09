Return-Path: <linux-kernel+bounces-137397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24589E17D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4931F23C1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CB156229;
	Tue,  9 Apr 2024 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtJpo53N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039015539C;
	Tue,  9 Apr 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683523; cv=none; b=Grjw7cVjP9G5cigW+z0b6FhOA4k2wIiElafH3vRM9QKReS/N+YuLo0Gr1tPDgALt3+5MZkcBXb3UUH7JKGLV/WgdMD7nS2kmOkvL8/Njh+vMfvvITw+xR/usuv90S7q1WSA8OgylhFhXqJ+i4fC6jUvrqkqJGf7lbD7RvhgAh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683523; c=relaxed/simple;
	bh=Z7G26vJ7drjhQBqY768GVlza2RGDKJV6xJzSOxOV+Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kX2gZ4xSL2bW/H4rLFPZw/DVt5NeII/X3Rm2t+Ox4aUZX1h+M6rJGXOMNeMX5Qy5Rybc8UF8lPwx95gt70XgZC+EvR65MvT3nvy7e7tCCPlN8Bc/AJT7jPYMGxFhAdiK5nQVD01t12thuKrIiLLLCZHHD8RcpvYYhRQjL5g1eeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtJpo53N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1450CC433F1;
	Tue,  9 Apr 2024 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712683522;
	bh=Z7G26vJ7drjhQBqY768GVlza2RGDKJV6xJzSOxOV+Ac=;
	h=From:To:Cc:Subject:Date:From;
	b=FtJpo53NtrsGi0x7/1DjifT6PbQ15bJ7LWhF0g/Hx+vT8eKEcS/ZCx2Cmb6mVgzja
	 lg3s6b0HjfMK0I0K4/ZtBW1quMJTMna+WqxR1MYR2SHNTn22vT8g3flWIUHSZANvoo
	 oxhp32sdJ1ETlfK+9F3s2LgUX3Ma5N0sF4yvXLyiteN/CJ08MyYSHQXX+3AioLSs9l
	 YAnf84ILVJr6jsi0v9CUycXXvcJRIUdY670pH4cZPAJe4cA9tQ1HRgVLR9bksHmQJE
	 ONVIS5XbnArcoDXpnGjALyOIgJapzffN9acXMW4Jj9CccObKivFpP18BqHp7L2yvz1
	 hK9TMdkBLarDw==
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
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 0/1] RISC-V: enable rust
Date: Tue,  9 Apr 2024 18:25:15 +0100
Message-ID: <20240409-unsaddle-skittle-c93eb77732bb@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jBURk0m47eQdKCm4nsBSeG1Pgaujx2S3yr8amWAalEA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmilb/fpZtkTudRfTNRPWJyUuKBlfHWbe1qz/7HOzzr+ vWEQXprRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbSz8Dw38UquCjqvY73ndsO zGF/f/u//lDq2+rdPOmcC8OpKLXYCob/aa1ad8KXBRkkiD6OjTqRZCgS/Wy3hI6AxpPb937Uusz gBgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

I've intentionally not turned on the gcc support, as discussed on
v1. I've also switched over to using the target, but it is a bit heavier
than the one arm64 seems to be using. RISC-V has fewer targets available
and this was the closest. I preserved the redzone disabling, just moved
into the Makefile. Any comment from Gary or the LLVM lads on the target
would be great I think:
https://github.com/rust-lang/rust/blob/master/compiler/rustc_target/src/spec/targets/riscv64imac_unknown_none_elf.rs
arm64 is using:
https://github.com/rust-lang/rust/blob/master/compiler/rustc_target/src/spec/targets/aarch64_unknown_none.rs

I was gonna send this yesterday, but found out last minute I had invalid
code in the target generation script. The kernel test robot had given my
branch the global all-clear - the rust coverage with all the
"depends on !FOO" must really limit the build coverage. I built for x86
with rust enabled locally this time to make sure..

As this as lifted from the state of the Rust-for-Linux tree, the commit
messages from there cannot be preserved, so these patches have commit
messages that I wrote.

I've tested this on Icicle, and the modules seem to work as expected.
Unfortunately there appear to be implicit 32-bit divisions (or similar)
in core Rust code, so, as in the downstream Rust-for-Linux tree, Rust is
only enabled for 64-bit.

Thanks,
Conor.

Changes in v3:
- Use a builtin target and modify it in kbuild
- Drop the kCFI patch, that's been merged independently

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
CC: rust-for-linux@vger.kernel.org
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: llvm@lists.linux.dev

Miguel Ojeda (1):
  RISC-V: enable building 64-bit kernels with rust support

 Documentation/rust/arch-support.rst | 1 +
 arch/riscv/Kconfig                  | 1 +
 arch/riscv/Makefile                 | 7 +++++++
 scripts/generate_rust_target.rs     | 6 ++++++
 4 files changed, 15 insertions(+)

-- 
2.43.0


