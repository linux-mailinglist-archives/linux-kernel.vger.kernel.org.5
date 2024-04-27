Return-Path: <linux-kernel+bounces-161109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C9D8B473D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46D21C215AF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE3142E72;
	Sat, 27 Apr 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzS+vtzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7B4EB39;
	Sat, 27 Apr 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714238216; cv=none; b=eEVnRtp85XsPzGuMJCvxkUw0nPuVElI2z3UxRhOD+pk0wW01B8zYFvPgSAmLPP71IEuwfq/qipypyqQrbevNSny5rxEOLNI0cqVKUxMTuWFh86ia/lwsUNZZ0Hjf1bA9Q9hY3DtQOBme+lQqZqdIoZJp9Zbh9iFs7XWnlpBJvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714238216; c=relaxed/simple;
	bh=6C8qc+2nbWsj88zYuaWTC/p/dDWtLVgW0nmBbGPJGvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3yNztLUOs+zpbDSsTLEYduK6419VDw6GjJqo2gOnk4wQ4a01h7dFXmnUiZax/8gHQpUlBGfHq/LZU4ES6bwK0Q8x+4iNsoku7fIVWZUZf/MmR4ObedLkHG5SQNbwBKMIcnLbicI83+yywGmm2qKbKzEuYh2lycqhs7fBlkHoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzS+vtzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67861C113CE;
	Sat, 27 Apr 2024 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714238216;
	bh=6C8qc+2nbWsj88zYuaWTC/p/dDWtLVgW0nmBbGPJGvY=;
	h=From:To:Cc:Subject:Date:From;
	b=FzS+vtzBO8Xah/t/XnEYCDvpvr2I+G+ce0/HeMHRK30W6pOobK/OUXWZC9QokABPk
	 XDWU9maS10H30JOOvUTxK7OZyEtluAMZMn+Y+hcv2fRb1fp4QNDqxpV3h0Dpy53lT0
	 ryC6kvMG5Rhg/Go8rk4fQhdL3lx75rXd/2Q9cuESsJQ3VXFo0XUEStcnyOeDueK1eI
	 naLhnECvvsgKnXLyQLvjq+enwTERS88X0y2KK0xEb5GihAJ10b93UcS0imkQFuC7Pa
	 XUIG26fBZM0WYT8BAxmHfRiLtArBWFVrp3WOIdOzKQOHciK31qF3pHBLfpsrZVJiqm
	 c61vSTKRLf6XA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust fixes for 6.9
Date: Sat, 27 Apr 2024 19:15:49 +0200
Message-ID: <20240427171549.934651-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust.

There are a few that I am not sure if they should count as fixes
(trivial docs rendering, macro example and CONSTRUCTORS), so if you
prefer to see them in the merge window instead, please let me know.

The spike you will see in the diffstat is due to indentation changes,
added comments and moved lines -- the actual change is small.

Most have been in linux-next for more than a week, but the last ones
have been there only for a couple linux-next tags, and I reworded one
of those a couple days ago to add a tag (no changes otherwise -- the
original commits can be found starting at 56b70b91a161 in linux-next).

No conflicts expected. No changes to the C side.

Cheers,
Miguel

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.9

for you to fetch changes up to 19843452dca40e28d6d3f4793d998b681d505c7f:

  rust: remove `params` from `module` macro example (2024-04-25 17:34:33 +0200)

----------------------------------------------------------------
Rust fixes for v6.9

 - Soundness: make internal functions generated by the 'module!' macro
   inaccessible, do not implement 'Zeroable' for 'Infallible' and
   require 'Send' for the 'Module' trait.

 - Build: avoid errors with "empty" files and workaround 'rustdoc' ICE.

 - Kconfig: depend on '!CFI_CLANG' and avoid selecting 'CONSTRUCTORS'.

 - Code docs: remove non-existing key from 'module!' macro example.

 - Docs: trivial rendering fix in arch table.

----------------------------------------------------------------
Alice Ryhl (1):
      rust: don't select CONSTRUCTORS

Aswin Unnikrishnan (1):
      rust: remove `params` from `module` macro example

Benno Lossin (1):
      rust: macros: fix soundness issue in `module!` macro

Bo-Wei Chen (1):
      docs: rust: fix improper rendering in Arch Support page

Conor Dooley (1):
      rust: make mutually exclusive with CFI_CLANG

Laine Taffin Altman (1):
      rust: init: remove impl Zeroable for Infallible

Miguel Ojeda (2):
      kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE
      kbuild: rust: force `alloc` extern to allow "empty" Rust files

Wedson Almeida Filho (2):
      rust: phy: implement `Send` for `Registration`
      rust: kernel: require `Send` for `Module` implementations

 Documentation/rust/arch-support.rst |   2 +-
 init/Kconfig                        |   2 +-
 rust/Makefile                       |   1 -
 rust/kernel/init.rs                 |  11 ++-
 rust/kernel/lib.rs                  |   2 +-
 rust/kernel/net/phy.rs              |   4 +
 rust/macros/lib.rs                  |  12 ---
 rust/macros/module.rs               | 190 ++++++++++++++++++++++--------------
 scripts/Makefile.build              |   2 +-
 9 files changed, 132 insertions(+), 94 deletions(-)

