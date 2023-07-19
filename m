Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5D759808
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGSOU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGSOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:20:28 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632F1724
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:20:24 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689776421; x=1690035621;
        bh=5SJbhv9m6kCeMleleWVbb/UYtgrGWulTiGHG+cg8WBA=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=kmhDij1pQxsoRyCm1+cSe+7Q+VQOSCyh9ffpcou+mSBIgZGC9goGmf41pthvwTrIS
         rqx2BAUhQGUYlxKM/ThHc8crn7GiKVaY3Nry2seX6cXum3uH38bDEOUDsCdjuVyibK
         MFg4fMLVSc5cg3WkLKqxMNdMiTrHV+YfY4JT8GCsEvFZokXW+iFN2vidrcTR/7e2GZ
         ozbHJCXxc7VNKDjXApk1MTKRexz3JGxKcG6ysoJ0If6Krg5UWWi2nYRf/I/5aX1Q14
         O/W87QFHNXQPVSEtICNhLIskDXcdP75P7by+5rNZ/XgBk+ByB6z1GPebrZkyxmcHOW
         UhJagI3r77Olg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] Quality of life improvements for pin-init
Message-ID: <20230719141918.543938-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds several improvements to the pin-init api:
- a derive macro for the `Zeroable` trait,
- makes hygiene of fields in initializers behave like normal struct
  initializers would behave,
- prevent stackoverflow without optimizations
- add `..Zeroable::zeroed()` syntax to zero missing fields.
- support arbitrary paths in initializer macros

This is the second version of this patch series.
* v1: https://lore.kernel.org/rust-for-linux/20230624092330.157338-1-benno.=
lossin@proton.me/

Changes not present on modified commits:
v1 -> v2:
- implement `Zeroable` for `Opaque`,
- remove blanket impl of `PinInit` for `Init` and make it a supertrait
  instead,
- add `{pin_}chain` functions to execute code after initialization,
- update the example macro expansion

Benno Lossin (12):
  rust: init: consolidate init macros
  rust: add derive macro for `Zeroable`
  rust: init: make guards in the init macros hygienic
  rust: init: wrap type checking struct initializers in a closure
  rust: init: make initializer values inaccessible after initializing
  rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing
    fields
  rust: init: Add functions to create array initializers
  rust: init: add support for arbitrary paths in init macros
  rust: init: implement Zeroable for Opaque<T>
  rust: init: make `PinInit<T, E>` a supertrait of `Init<T, E>`
  rust: init: add `{pin_}chain` functions to `{Pin}Init<T, E>`
  rust: init: update expanded macro explanation

 rust/kernel/init.rs            | 633 ++++++++++++++-------------------
 rust/kernel/init/__internal.rs |  39 +-
 rust/kernel/init/macros.rs     | 510 +++++++++++++++++++++++---
 rust/kernel/prelude.rs         |   2 +-
 rust/kernel/types.rs           |   2 +
 rust/macros/lib.rs             |  20 ++
 rust/macros/quote.rs           |   6 +
 rust/macros/zeroable.rs        |  25 ++
 8 files changed, 784 insertions(+), 453 deletions(-)
 create mode 100644 rust/macros/zeroable.rs


base-commit: 6946437838b0ec7c976252f5d1872d4d8b679515
--=20
2.41.0


