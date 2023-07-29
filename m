Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF8767D74
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjG2JJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjG2JJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:09:30 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADEE49EA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:09:22 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690621758; x=1690880958;
        bh=4lDtjHwaSFsAZDEy7KtHvYhEsNR9ASqMeTkQVXtY5AU=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=SgUnpj5i8S1wDowm+nE6f6blDsWPn7GBfTuL2KBzzkzGbkG65CTNnF7WlUwJCDszw
         RxM9sfFsWbGo/vb8KQZDIHHRBLxdwfkOUD4zPF6Zjv+9+6+UDcNdJ3ssIwrFdN8Q85
         /Yj9X0YlyHTm8ieNu7Hadr7IWvcayaHToRb4nSDMfbHLjONc3GtcRm/8D0ILLJe2CM
         8mZc4pj2DCe/7EoiBjJfhvKRlyOKSzKzXLAUoqyJLjiF0RaVjObPL3X72NgH6MqaTe
         qP9Y4J2+GMfdswVKd2HEWdLLCVx91LyycHqtU0A/Ne77ZripOvqj3hL9gCGCv9NEAo
         vJw0rHjrloBow==
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
Subject: [PATCH v3 00/13] Quality of life improvements for pin-init
Message-ID: <20230729090838.225225-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
- add `..Zeroable::zeroed()` syntax to zero missing fields,
- support arbitrary paths in initializer macros.

It is based on the `rust-dev` branch.

This is the third version of this patch series.
- v2: https://lore.kernel.org/rust-for-linux/20230719141918.543938-1-benno.=
lossin@proton.me/
- v1: https://lore.kernel.org/rust-for-linux/20230624092330.157338-1-benno.=
lossin@proton.me/

Changes not present on modified commits:
v2 -> v3:
- make `#[pin_data]` work better with `#[cfg]` attributes on fields.

v1 -> v2:
- implement `Zeroable` for `Opaque`,
- remove blanket impl of `PinInit` for `Init` and make it a supertrait
  instead,
- add `{pin_}chain` functions to execute code after initialization,
- update the example macro expansion.

Benno Lossin (13):
  rust: init: consolidate init macros
  rust: init: make `#[pin_data]` compatible with conditional compilation
    of fields
  rust: add derive macro for `Zeroable`
  rust: init: make guards in the init macros hygienic
  rust: init: wrap type checking struct initializers in a closure
  rust: init: make initializer values inaccessible after initializing
  rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing
    fields
  rust: init: Add functions to create array initializers
  rust: init: add support for arbitrary paths in init macros
  rust: init: implement `Zeroable` for `UnsafeCell<T>` and `Opaque<T>`
  rust: init: make `PinInit<T, E>` a supertrait of `Init<T, E>`
  rust: init: add `{pin_}chain` functions to `{Pin}Init<T, E>`
  rust: init: update expanded macro explanation

 rust/kernel/init.rs            | 645 ++++++++++++++-------------------
 rust/kernel/init/__internal.rs |  39 +-
 rust/kernel/init/macros.rs     | 519 +++++++++++++++++++++++---
 rust/kernel/prelude.rs         |   2 +-
 rust/macros/lib.rs             |  20 +
 rust/macros/quote.rs           |   6 +
 rust/macros/zeroable.rs        |  72 ++++
 7 files changed, 850 insertions(+), 453 deletions(-)
 create mode 100644 rust/macros/zeroable.rs


base-commit: 65fba633fcdf8c4c15ddc24a21d8e55094607e33
--=20
2.41.0


