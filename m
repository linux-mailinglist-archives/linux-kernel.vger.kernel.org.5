Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C7787AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbjHXVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjHXVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE6619A0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EEAE63110
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85417C433C8;
        Thu, 24 Aug 2023 21:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692913247;
        bh=P1wRDsd32ThbUWCcUYv5bBhzflzUt1SNnEMieBL8UzA=;
        h=From:To:Cc:Subject:Date:From;
        b=E2/c2T0vDRRjSuScC3WGH0kZI7gk0lLVJUqm/L0phRsJNRUHwo6Lj9KqKtctdYwq6
         ePu3kTMs311M38hdjqL4KJTKnmLLCbybQjJiIE1pvE2rh/Ye5P4RNm/SvL56KIREcd
         TdXuX4YiCOSZyl8iU+f43YPVCpI22bf9X8CNPy8pgrFeXrACimJBYoRwhohEBTMU1l
         88ER+HCvazQDbsYBm4J0tOr9UBBCmS1pVr4OJs8U54hOPLqstjvqqYA3NUG3cLpHoZ
         90L9xNAm91CcPGtvPvnIuAxxG+w0BKtOW+BGDUZQOewwZbudMPtFDiKvTayjt2JiKy
         e1gqIstm3sIlg==
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
Subject: [GIT PULL] Rust for 6.6
Date:   Thu, 24 Aug 2023 23:40:22 +0200
Message-ID: <20230824214024.608618-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the next round of the Rust support.

The majority of the commits have been in linux-next for 10+ days.
The younger ones have been there for 3 rounds now, and thus for about
a week by the time you start merging pulls.

A single line conflict is expected with the kselftest/kunit tree,
because it contains a series that adds support for testing example Rust
code within documentation as KUnit tests. The correct resolution is now
on 'linux-next':

    diff --cc rust/kernel/init.rs
    index 0071b2834b78,e05563aad2ed..4ebb6f23fc2e
    --- a/rust/kernel/init.rs
    +++ b/rust/kernel/init.rs
    @@@ -517,11 -522,9 +526,10 @@@ macro_rules! stack_try_pin_init 
      /// For instance:
      ///
      /// ```rust
    - /// # use kernel::pin_init;
    - /// # use macros::{Zeroable, pin_data};
     -/// # use kernel::{macros::pin_data, pin_init};
    ++/// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
      /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
      /// #[pin_data]
     +/// #[derive(Zeroable)]
      /// struct Buf {
      ///     // `ptr` points into `buf`.
      ///     ptr: *mut u8,

I have tested this pull together with the KUnit one, and whether you
merge one or the other first should keep all examples compiling and
passing.

No changes to the C side.

Please pull for v6.6 -- thanks!

Cheers,
Miguel

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-6.6

for you to fetch changes up to 4af84c6a85c63bec24611e46bb3de2c0a6602a51:

  rust: init: update expanded macro explanation (2023-08-21 14:31:49 +0200)

----------------------------------------------------------------
Rust changes for v6.6

In terms of lines, most changes this time are on the pinned-init API
and infrastructure. While we have a Rust version upgrade, and thus a
bunch of changes from the vendored 'alloc' crate as usual, this time
those do not account for many lines.

Toolchain and infrastructure:

 - Upgrade to Rust 1.71.1. This is the second such upgrade, which is a
   smaller jump compared to the last time.

   This version allows us to remove the '__rust_*' allocator functions
   -- the compiler now generates them as expected, thus now our
   'KernelAllocator' is used.

   It also introduces the 'offset_of!' macro in the standard library
   (as an unstable feature) which we will need soon. So far, we were
   using a declarative macro as a prerequisite in some not-yet-landed
   patch series, which did not support sub-fields (i.e. nested structs):

       #[repr(C)]
       struct S {
           a: u16,
           b: (u8, u8),
       }

       assert_eq!(offset_of!(S, b.1), 3);

 - Upgrade to bindgen 0.65.1. This is the first time we upgrade its
   version.

   Given it is a fairly big jump, it comes with a fair number of
   improvements/changes that affect us, such as a fix needed to support
   LLVM 16 as well as proper support for '__noreturn' C functions, which
   are now mapped to return the '!' type in Rust:

       void __noreturn f(void); // C
       pub fn f() -> !;         // Rust

 - 'scripts/rust_is_available.sh' improvements and fixes.

   This series takes care of all the issues known so far and adds a few
   new checks to cover for even more cases, plus adds some more help
   texts. All this together will hopefully make problematic setups
   easier to identify and to be solved by users building the kernel.

   In addition, it adds a test suite which covers all branches of the
   shell script, as well as tests for the issues found so far.

 - Support rust-analyzer for out-of-tree modules too.

 - Give 'cfg's to rust-analyzer for the 'core' and 'alloc' crates.

 - Drop 'scripts/is_rust_module.sh' since it is not needed anymore.

Macros crate:

 - New 'paste!' proc macro.

   This macro is a more flexible version of 'concat_idents!': it allows
   the resulting identifier to be used to declare new items and it
   allows to transform the identifiers before concatenating them, e.g.

       let x_1 = 42;
       paste!(let [<x _2>] = [<x _1>];);
       assert!(x_1 == x_2);

   The macro is then used for several of the pinned-init API changes in
   this pull.

Pinned-init API:

 - Make '#[pin_data]' compatible with conditional compilation of fields,
   allowing to write code like:

       #[pin_data]
       pub struct Foo {
           #[cfg(CONFIG_BAR)]
           a: Bar,
           #[cfg(not(CONFIG_BAR))]
           a: Baz,
       }

 - New '#[derive(Zeroable)]' proc macro for the 'Zeroable' trait, which
   allows 'unsafe' implementations for structs where every field
   implements the 'Zeroable' trait, e.g.:

       #[derive(Zeroable)]
       pub struct DriverData {
           id: i64,
           buf_ptr: *mut u8,
           len: usize,
       }

 - Add '..Zeroable::zeroed()' syntax to the 'pin_init!'  macro for
   zeroing all other fields, e.g.:

       pin_init!(Buf {
           buf: [1; 64],
           ..Zeroable::zeroed()
       });

 - New '{,pin_}init_array_from_fn()' functions to create array
   initializers given a generator function, e.g.:

       let b: Box<[usize; 1_000]> = Box::init::<Error>(
           init_array_from_fn(|i| i)
       ).unwrap();

       assert_eq!(b.len(), 1_000);
       assert_eq!(b[123], 123);

 - New '{,pin_}chain' methods for '{,Pin}Init<T, E>' that allow to
   execute a closure on the value directly after initialization, e.g.:

       let foo = init!(Foo {
           buf <- init::zeroed()
       }).chain(|foo| {
           foo.setup();
           Ok(())
       });

 - Support arbitrary paths in init macros, instead of just identifiers
   and generic types.

 - Implement the 'Zeroable' trait for the 'UnsafeCell<T>' and
   'Opaque<T>' types.

 - Make initializer values inaccessible after initialization.

 - Make guards in the init macros hygienic.

'allocator' module:

 - Use 'krealloc_aligned()' in 'KernelAllocator::alloc' preventing
   misaligned allocations when the Rust 1.71.1 upgrade is applied later
   in this pull.

   The equivalent fix for the previous compiler version (where
   'KernelAllocator' is not yet used) was merged into 6.5 already,
   which added the 'krealloc_aligned()' function used here.

 - Implement 'KernelAllocator::{realloc, alloc_zeroed}' for performance,
   using 'krealloc_aligned()' too, which forwards the call to the C API.

'types' module:

 - Make 'Opaque' be '!Unpin', removing the need to add a 'PhantomPinned'
   field to Rust structs that contain C structs which must not be moved.

 - Make 'Opaque' use 'UnsafeCell' as the outer type, rather than inner.

Documentation:

 - Suggest obtaining the source code of the Rust's 'core' library using
   the tarball instead of the repository.

MAINTAINERS:

 - Andreas and Alice, from Samsung and Google respectively, are joining
   as reviewers of the "RUST" entry.

As well as a few other minor changes and cleanups.

----------------------------------------------------------------
Aakash Sen Sharma (1):
      rust: bindgen: upgrade to 0.65.1

Alice Ryhl (1):
      rust: make `UnsafeCell` the outer type in `Opaque`

Andrea Righi (1):
      btf, scripts: rust: drop is_rust_module.sh

Ariel Miculas (1):
      rust: helpers: sort includes alphabetically in rust/helpers.c

Ben Gooding (1):
      rust: lock: Add intra-doc links to the Backend trait

Benno Lossin (14):
      rust: types: make `Opaque` be `!Unpin`
      rust: init: consolidate init macros
      rust: init: make `#[pin_data]` compatible with conditional compilation of fields
      rust: add derive macro for `Zeroable`
      rust: init: make guards in the init macros hygienic
      rust: init: wrap type checking struct initializers in a closure
      rust: init: make initializer values inaccessible after initializing
      rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing fields
      rust: init: add functions to create array initializers
      rust: init: add support for arbitrary paths in init macros
      rust: init: implement `Zeroable` for `UnsafeCell<T>` and `Opaque<T>`
      rust: init: make `PinInit<T, E>` a supertrait of `Init<T, E>`
      rust: init: add `{pin_}chain` functions to `{Pin}Init<T, E>`
      rust: init: update expanded macro explanation

Björn Roy Baron (1):
      rust: alloc: Add realloc and alloc_zeroed to the GlobalAlloc impl

Boqun Feng (1):
      rust: allocator: Use krealloc_aligned() in KernelAllocator::alloc

Gary Guo (1):
      rust: macros: add `paste!` proc macro

Guillaume Plourde (1):
      docs: rust: add command line to rust-analyzer section

Martin Rodriguez Reboredo (1):
      scripts: generate_rust_analyzer: provide `cfg`s for `core` and `alloc`

Masahiro Yamada (1):
      kbuild: rust_is_available: remove -v option

Miguel Ojeda (13):
      MAINTAINERS: add Andreas Hindborg as Rust reviewer
      MAINTAINERS: add Alice Ryhl as Rust reviewer
      docs: rust: add paragraph about finding a suitable `libclang`
      kbuild: rust_is_available: print docs reference
      kbuild: rust_is_available: add check for `bindgen` invocation
      kbuild: rust_is_available: check that environment variables are set
      kbuild: rust_is_available: fix confusion when a version appears in the path
      kbuild: rust_is_available: normalize version matching
      kbuild: rust_is_available: handle failures calling `$RUSTC`/`$BINDGEN`
      kbuild: rust_is_available: check that output looks as expected
      kbuild: rust_is_available: add test suite
      rust: upgrade to Rust 1.71.1
      rust: enable `no_mangle_with_rust_abi` Clippy lint

Russell Currey (1):
      kbuild: rust_is_available: fix version check when CC has multiple arguments

Trevor Gross (2):
      docs: rust: update instructions for obtaining 'core' source
      docs: rust: clarify what 'rustup override' does

Vinay Varma (1):
      scripts: `make rust-analyzer` for out-of-tree modules

 Documentation/process/changes.rst  |   4 +-
 Documentation/rust/quick-start.rst |  42 ++-
 MAINTAINERS                        |   2 +
 Makefile                           |  16 +-
 rust/Makefile                      |  17 +-
 rust/alloc/alloc.rs                |  20 +-
 rust/alloc/boxed.rs                | 131 ++++----
 rust/alloc/lib.rs                  |  50 +--
 rust/alloc/raw_vec.rs              |  18 +-
 rust/alloc/slice.rs                |  43 ++-
 rust/alloc/vec/drain.rs            |   8 +-
 rust/alloc/vec/drain_filter.rs     |   8 +-
 rust/alloc/vec/into_iter.rs        |  35 +-
 rust/alloc/vec/mod.rs              |  84 ++---
 rust/compiler_builtins.rs          |   7 +
 rust/helpers.c                     |  21 +-
 rust/kernel/allocator.rs           |  84 ++---
 rust/kernel/init.rs                | 646 ++++++++++++++++---------------------
 rust/kernel/init/__internal.rs     |  39 +--
 rust/kernel/init/macros.rs         | 519 +++++++++++++++++++++++++----
 rust/kernel/lib.rs                 |   3 -
 rust/kernel/prelude.rs             |   2 +-
 rust/kernel/sync/lock.rs           |   6 +-
 rust/kernel/types.rs               |  21 +-
 rust/macros/lib.rs                 | 117 +++++++
 rust/macros/module.rs              |   2 +-
 rust/macros/paste.rs               |  96 ++++++
 rust/macros/quote.rs               |  12 +
 rust/macros/zeroable.rs            |  72 +++++
 scripts/Makefile.modfinal          |   2 -
 scripts/generate_rust_analyzer.py  |  39 ++-
 scripts/is_rust_module.sh          |  16 -
 scripts/min-tool-version.sh        |   4 +-
 scripts/rust_is_available.sh       | 233 +++++++++----
 scripts/rust_is_available_test.py  | 346 ++++++++++++++++++++
 35 files changed, 1915 insertions(+), 850 deletions(-)
 create mode 100644 rust/macros/paste.rs
 create mode 100644 rust/macros/zeroable.rs
 delete mode 100755 scripts/is_rust_module.sh
 create mode 100755 scripts/rust_is_available_test.py
