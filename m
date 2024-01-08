Return-Path: <linux-kernel+bounces-19037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA62826714
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5B0B20F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D5EDE;
	Mon,  8 Jan 2024 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6sE1gu+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1B7E2;
	Mon,  8 Jan 2024 01:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE133C433C9;
	Mon,  8 Jan 2024 01:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704676971;
	bh=U48ddkhZbLIGmAm3tOALZCKxURR7hnYXdKWlBy0GGfA=;
	h=From:To:Cc:Subject:Date:From;
	b=a6sE1gu+iyHrvqLEnF3gZ8hqAMt0d19Tqb51eyQ2y2jfyu1rqDD1r8efs0JJpQFxC
	 zMj5zgm7a4R9GKgCKIZtyMr8AcFAoBmbZcjntIqii3a7oYckywD/hUf6w8xY9hxlDd
	 RxkbQEn0NVYbwyLerVdgNCQm2UXJujPH88oANXwqfMfbdjhQF4mYxbHUoGZqrWH7Vq
	 J5vRqS5fQLhjoPwwwE/lWxF7piM93sxB6FkYgXN7Kc40fUU6QxsrYG9ku3Gj0agCB3
	 uvKIN3d5uOaN0wMVkybTQDY38e+AXOogFbXijQADywzuxNezlkMrOUG2/gtPhcEJE4
	 ahvkb+qzKzzCw==
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
Subject: [GIT PULL] Rust for v6.8
Date: Mon,  8 Jan 2024 02:20:55 +0100
Message-ID: <20240108012055.519813-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the next round of the Rust support.

All the commits have been in linux-next for more than a couple weeks,
but only for 3 -next tags given the holidays (first one next-20231222).

No conflicts expected. No changes to the C side.

There are also some Rust abstractions for network PHY drivers (with a
Rust reference driver included for Asix PHY) which you will likely get
through the networking tree. No conflicts expected with those either,
and tests pass with those merged too.

Please pull for v6.8 -- thanks!

Cheers,
Miguel

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.8

for you to fetch changes up to 711cbfc717650532624ca9f56fbaf191bed56e67:

  docs: rust: Clarify that 'rustup override' applies to build directory (2023-12-21 22:47:40 +0100)

----------------------------------------------------------------
Rust changes for v6.8

Another routine one in terms of features. In terms of lines, this time
the 'alloc' version upgrade is less prominent, given that it was fairly
small (and we did not have two upgrades).

Toolchain and infrastructure:

 - Upgrade to Rust 1.74.1.

   The patch release includes a fix for an ICE that the Apple AGX GPU
   driver was hitting.

 - Support 'srctree'-relative links in Rust code documentation.

 - Automate part of the manual constants handling (i.e. the ones not
   recognised by 'bindgen').

 - Suppress searching builtin sysroot to avoid confusion with installed
   sysroots, needed for the to-be-merged arm64 support which uses
   a builtin target.

 - Ignore '__preserve_most' functions for 'bindgen'.

 - Reduce header inclusion bloat in exports.

'kernel' crate:

 - Implement 'Debug' for 'CString'.

 - Make 'CondVar::wait()' an uninterruptible wait.

'macros' crate:

 - Update 'paste!' to accept string literals.

 - Improve '#[vtable]' documentation.

Documentation:

 - Add testing section (KUnit and 'rusttest' target).

 - Remove 'CC=clang' mentions.

 - Clarify that 'rustup override' applies to build directory.

----------------------------------------------------------------
Asahi Lina (1):
      rust: kernel: str: Implement Debug for CString

Benno Lossin (1):
      rust: macros: improve `#[vtable]` documentation

Boqun Feng (1):
      rust: sync: Makes `CondVar::wait()` an uninterruptible wait

Dirk Behme (1):
      docs: rust: Add rusttest info

Gary Guo (1):
      rust: bindings: rename const binding using sed

Masahiro Yamada (1):
      rust: replace <linux/module.h> with <linux/export.h> in rust/exports.c

Matthew Maurer (2):
      rust: Ignore preserve-most functions
      rust: Suppress searching builtin sysroot

Miguel Ojeda (3):
      rust: upgrade to Rust 1.74.1
      rust: support `srctree`-relative links
      docs: rust: remove `CC=clang` mentions

Trevor Gross (1):
      rust: macros: update 'paste!' macro to accept string literals

Viresh Kumar (1):
      docs: rust: Clarify that 'rustup override' applies to build directory

 Documentation/process/changes.rst          |  2 +-
 Documentation/rust/coding-guidelines.rst   | 13 +++++
 Documentation/rust/general-information.rst | 24 +++++++++
 Documentation/rust/quick-start.rst         | 18 +++----
 rust/Makefile                              |  8 ++-
 rust/alloc/alloc.rs                        | 32 +++++++----
 rust/alloc/lib.rs                          |  6 +--
 rust/alloc/slice.rs                        |  2 +-
 rust/alloc/vec/mod.rs                      | 87 +++++++++++++++++++++++++++++-
 rust/bindgen_parameters                    |  4 ++
 rust/bindings/bindings_helper.h            |  6 +--
 rust/bindings/lib.rs                       |  3 --
 rust/exports.c                             |  2 +-
 rust/kernel/allocator.rs                   |  2 +-
 rust/kernel/error.rs                       |  6 ++-
 rust/kernel/ioctl.rs                       |  2 +-
 rust/kernel/kunit.rs                       |  2 +-
 rust/kernel/print.rs                       |  8 +--
 rust/kernel/str.rs                         |  6 +++
 rust/kernel/sync/condvar.rs                | 32 +++++------
 rust/kernel/sync/lock/mutex.rs             |  2 +-
 rust/kernel/sync/lock/spinlock.rs          |  2 +-
 rust/kernel/task.rs                        |  2 +-
 rust/kernel/workqueue.rs                   |  2 +-
 rust/macros/lib.rs                         | 62 +++++++++++++++++----
 rust/macros/paste.rs                       | 10 +++-
 scripts/Makefile.build                     |  1 +
 scripts/min-tool-version.sh                |  2 +-
 28 files changed, 275 insertions(+), 73 deletions(-)

