Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E742A7DA095
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbjJ0SfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjJ0SfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:35:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0684799
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:32:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6599FC433CB;
        Fri, 27 Oct 2023 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698431179;
        bh=zTfUXlXSoGJJFGgemXJajvcwNKocWCwDSQ1KIMapG5g=;
        h=From:To:Cc:Subject:Date:From;
        b=kfUqJMqzVMz/dZnpAeMnaANP+ztmmMDvyprnku1xiWzPOboEvgrViK/AZ8z6AkxTE
         GBfVVpy05IFjBnBHKvuQmL+Y8uJAusszq/HuY2p6pqfkBvS1S4uuchlkbM8P2X3z+F
         boi56GEWZfX7x4dbIlm/VemNzohp4GYtOOlF03yX+v4cx0ZSV95HuYtOf3C6f1kFKp
         UvOB9mDDYj1PTTUuMTiRky2EUigGHcRQV9mVG4rEXl2PB3RU3I2b64cn4yYxGLMODV
         TYyLSOfC+gxG7T0OjqaTxaV5co+63Qt/UGoLwM6UpJd7fTlKd+jF3gSUTxcIw1xlX0
         XH5nv6QlkzJTw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.7
Date:   Fri, 27 Oct 2023 20:25:58 +0200
Message-ID: <20231027182558.199011-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the next round of the Rust support.

The majority of the commits have been in linux-next for 10+ days.
The younger ones have been there for 3 rounds now.

No conflicts expected. No changes to the C side.

There are also some Rust workqueue abstractions which you will likely
get through the wq tree. No conflicts expected with those either, and
tests pass with those merged too.

Please pull for v6.7 -- thanks!

Cheers,
Miguel

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.7

for you to fetch changes up to 3857af38e57a80b15b994e19d1f4301cac796481:

  docs: rust: add "The Rust experiment" section (2023-10-25 03:14:00 +0200)

----------------------------------------------------------------
Rust changes for v6.7

A small one compared to the previous one in terms of features. In terms
of lines, as usual, the 'alloc' version upgrade accounts for most of them.

Toolchain and infrastructure:

 - Upgrade to Rust 1.73.0.

   This time around, due to how the kernel and Rust schedules have
   aligned, there are two upgrades in fact. They contain the fixes for
   a few issues we reported to the Rust project.

   In addition, a few cleanups indicated by the upgraded compiler
   or possible thanks to it. For instance, the compiler now detects
   redundant explicit links.

 - A couple changes to the Rust 'Makefile' so that it can be used with
   toybox tools, allowing Rust to be used in the Android kernel build.

x86:

 - Enable IBT if enabled in C.

Documentation:

 - Add "The Rust experiment" section to the Rust index page.

MAINTAINERS

 - Add Maintainer Entry Profile field ('P:').

 - Update our 'W:' field to point to the webpage we have been building
   this year.

----------------------------------------------------------------
Gary Guo (1):
      rust: kernel: remove `#[allow(clippy::new_ret_no_self)]`

Matthew Maurer (3):
      rust: Use awk instead of recent xargs
      rust: Use grep -Ev rather than relying on GNU grep
      x86: Enable IBT in Rust if enabled in C

Miguel Ojeda (8):
      rust: arc: add explicit `drop()` around `Box::from_raw()`
      rust: upgrade to Rust 1.72.1
      MAINTAINERS: update Rust webpage
      MAINTAINERS: add Maintainer Entry Profile field for Rust
      rust: task: remove redundant explicit link
      rust: print: use explicit link in documentation
      rust: upgrade to Rust 1.73.0
      docs: rust: add "The Rust experiment" section

 Documentation/process/changes.rst |   2 +-
 Documentation/rust/index.rst      |  19 ++++
 MAINTAINERS                       |   3 +-
 arch/x86/Makefile                 |   1 +
 rust/Makefile                     |   8 +-
 rust/alloc/alloc.rs               |  21 ----
 rust/alloc/boxed.rs               |  56 +++++++----
 rust/alloc/lib.rs                 |  13 +--
 rust/alloc/raw_vec.rs             |  30 ++++--
 rust/alloc/vec/drain_filter.rs    | 199 --------------------------------------
 rust/alloc/vec/extract_if.rs      | 115 ++++++++++++++++++++++
 rust/alloc/vec/mod.rs             | 110 ++++++++++-----------
 rust/alloc/vec/spec_extend.rs     |   8 +-
 rust/compiler_builtins.rs         |   1 +
 rust/kernel/init.rs               |  20 ++--
 rust/kernel/print.rs              |   1 +
 rust/kernel/sync/arc.rs           |   2 +-
 rust/kernel/sync/condvar.rs       |   1 -
 rust/kernel/sync/lock.rs          |   1 -
 rust/kernel/task.rs               |   2 +-
 scripts/min-tool-version.sh       |   2 +-
 21 files changed, 279 insertions(+), 336 deletions(-)
 delete mode 100644 rust/alloc/vec/drain_filter.rs
 create mode 100644 rust/alloc/vec/extract_if.rs
