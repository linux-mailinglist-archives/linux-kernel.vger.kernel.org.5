Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268E6753693
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjGNJbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjGNJbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:31:43 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A793599;
        Fri, 14 Jul 2023 02:31:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2DD105BC3A;
        Fri, 14 Jul 2023 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326046;
        bh=NNlQg01GoROuwHT7V4Ok4QbA2Wacecl8a9cR39wPQX4=;
        h=From:Subject:Date:To:Cc;
        b=DWOuvqjnL+WVRlQCchmZp/1Q5QSmwk1TXPN8elD+Lr+TEOyfN68h44fdUmUcdHUN2
         7A4F4XNCMes02IwEzHvDFlsJpVL0C1B4V1z1Ue0okL8UxvAiq4YGiBco3taDmSFjt/
         jS1+M7N5xtG4lbjc5aUXgomR7zvuNjImD/mfiMO2d2SBUVIwbYtnjKb3nbQzJMX+ol
         vHAaNDJRwALfpj1vg6IIcWkXw5ZDFpjpkKMYGKkPHoYaEQR6LoFiC9FK29dna86ls9
         2qOlhTZmdmXLAN5YMfQKDpOaFiZjQ2tR+HS58wyprIbaP33CVyONvqagYL1nunBGyZ
         /QtxTuAPRiOWQ==
From:   Asahi Lina <lina@asahilina.net>
Subject: [PATCH RFC 00/11] rust: Implicit lock class creation & Arc Lockdep
 integration
Date:   Fri, 14 Jul 2023 18:13:52 +0900
Message-Id: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANARsWQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0MT3eScxOLinNTi4vic/OTslNQC3TTDFFNLc6O0JJOkRCWgvoKi1LT
 MCrCZ0UpBbs5KsbW1AJoiJw1oAAAA
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=3990;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=NNlQg01GoROuwHT7V4Ok4QbA2Wacecl8a9cR39wPQX4=;
 b=/iyr7ancBEF0XHvo1tC+PR5V7K/FO06oJ0Cy/w4WDvBHh+I0Op8T6d5uYejSOZ+TUqNdVn/Ns
 klBa8CShSlIAxB40VpRMh8VI93PqdHiAsoOvp8NK/p+ZA/7SUcFENqu
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Begone, lock classes!

As discussed in meetings/etc, we would really like to support implicit
lock class creation for Rust code. Right now, lock classes are created
using macros and passed around (similar to C). Unfortunately, Rust
macros don't look like Rust functions, which means adding lockdep to a
type is a breaking API change. This makes Rust mutex creation rather
ugly, with the new_mutex!() macro and friends.

Implicit lock classes have to be unique per instantiation code site.
Notably, with Rust generics and monomorphization, this is not the same
as unique per generated code instance. If this weren't the case, we
could use inline functions and asm!() magic to try to create lock
classes that have the right uniqueness semantics. But that doesn't work,
since it would create too many lock classes for the same actual lock
creation in the source code.

But Rust does have one trick we can use: it can track the caller
location (as file:line:column), across multiple functions. This works
using an implicit argument that gets passed around, which is exactly the
thing we do for lock classes. The tricky bit is that, while the value of
these Location objects has the semantics we want (unique value per
source code location), there is no guarantee that they are deduplicated
in memory.

So we use a hash table, and map Location values to lock classes. Et
voila, implicit lock class support!

This lets us clean up the Mutex & co APIs and make them look a lot more
Rust-like, but it also means we can now throw Lockdep into more APIs
without breaking the API. And so we can pull a neat trick: adding
Lockdep support into Arc<T>. This catches cases where the Arc Drop
implementation could create a locking correctness violation only when
the reference count drops to 0 at that particular drop site, which is
otherwise not detectable unless that condition actually happens at
runtime. Since Drop is "magic" in Rust and Drop codepaths very difficult
to audit, this helps a lot.

For the initial RFC, this implements the new API only for Mutex. If this
looks good, I can extend it to CondVar & friends in the next version.
This series also folds in a few related minor dependencies / changes
(like the pin_init mutex stuff).

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
Asahi Lina (11):
      rust: types: Add Opaque::zeroed()
      rust: lock: Add Lock::pin_init()
      rust: Use absolute paths to build Rust objects
      rust: siphash: Add a simple siphash abstraction
      rust: sync: Add dummy LockClassKey implementation for !CONFIG_LOCKDEP
      rust: sync: Replace static LockClassKey refs with a pointer wrapper
      rust: sync: Implement dynamic lockdep class creation
      rust: sync: Classless Lock::new() and pin_init()
      rust: init: Update documentation for new mutex init style
      rust: sync: Add LockdepMap abstraction
      rust: sync: arc: Add lockdep integration
 lib/Kconfig.debug                 |   8 ++
 rust/Makefile                     |   2 +-
 rust/bindings/bindings_helper.h   |   2 +
 rust/helpers.c                    |  24 ++++
 rust/kernel/init.rs               |  22 ++--
 rust/kernel/lib.rs                |   1 +
 rust/kernel/siphash.rs            |  39 +++++++
 rust/kernel/sync.rs               |  33 ++----
 rust/kernel/sync/arc.rs           |  71 +++++++++++-
 rust/kernel/sync/condvar.rs       |   2 +-
 rust/kernel/sync/lock.rs          |  68 ++++++++++-
 rust/kernel/sync/lock/mutex.rs    |  15 ++-
 rust/kernel/sync/lock/spinlock.rs |   2 +-
 rust/kernel/sync/lockdep.rs       | 229 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/no_lockdep.rs    |  38 +++++++
 rust/kernel/types.rs              |   7 +-
 scripts/Makefile.build            |   8 +-
 17 files changed, 525 insertions(+), 46 deletions(-)
---
base-commit: 7eb28ae62e16abc207c90064ad2b824c19566fe2
change-id: 20230714-classless_lockdep-f1d5972fb4ba

Thank you,
~~ Lina

