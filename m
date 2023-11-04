Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B347E1117
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 22:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjKDVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKDVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 17:12:24 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717BDBE;
        Sat,  4 Nov 2023 14:12:20 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-da2b9211dc0so3164879276.3;
        Sat, 04 Nov 2023 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699132339; x=1699737139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4BE7f3GCa9oWSPmgCGhi6gOPLq4PIsHZK88aUtaT08=;
        b=adaL4YFh63sFGk+uMi4m8AtdeDB2iAmht2eipROpZBT2zRvdwEUBYW0yoHbEht+Ic9
         gn5PjP9qrR/o5vBQDV9pDHROSBAplK/Fg+af2E5JAQkCWs4JSwnN6v2+czXsuvcdd4RF
         DRY2YjuWPJdAyLQusNBy9zRaHWwaBpIXOhw2mcKh+iSUqWnwayBKEzBcaIzS9WZYVpth
         yJM4xqtZiftaqq7YJF5SYXcwJ1FiY/ptZxy7B51f5MeA0w9nXtoXt5Xivei2iFK/xkK+
         RDwIrZxAZCpGlT2WugWl2MtvVtV15l78cPTJBHDgds6KXKjtJiNwbBTPQW5y/wdPt2K6
         nyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699132339; x=1699737139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4BE7f3GCa9oWSPmgCGhi6gOPLq4PIsHZK88aUtaT08=;
        b=p1DkvJ4TnaIvSJBKqZDZTU35xNmwLZ62ygXyFka/ATmFYSBEEKSTwWF7fyxTkzw2ft
         +8P9bvQAnwpblaOm3OSVBXpONGxa+BWeVvqDTIs3a2ZwQ7ZeYNgBsUL6WMJ5hnRzTN6T
         tCu9SFqOMLvMzfu86wCVZEfRhN+4CWiJ0LjGT70wQQLv5xx1EgEMwDyWL+aey7SSu7IZ
         uznBh2j8sh07fClceoUH69W+HL1S83QFhVOFTNPxQ0m1KJ+VMYGn3g8riqLKhlpi5oNd
         heY8pccBxxEIXf6d+69MLInu2if4sqYUcCAuJkqDCbPoK5NrMXOSrdVDHQHFRh4RcKwq
         uSyg==
X-Gm-Message-State: AOJu0Yz7o/SB++6pyluF8kIOH0OR3JrVA9RXSjbI5ld5MGC0PlMMhsak
        dYT1XIRfUTbVzMZyvxp3Pd4=
X-Google-Smtp-Source: AGHT+IEUeRrVoSB97fjQ3e/VA752XmGXRXnT+7Tt2yX1JL332Edn/+IpbEghZ615xT4Y/UteKsIo2w==
X-Received: by 2002:a25:db13:0:b0:d9c:a3dd:664e with SMTP id g19-20020a25db13000000b00d9ca3dd664emr22432042ybf.56.1699132339611;
        Sat, 04 Nov 2023 14:12:19 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t14-20020a25838e000000b00d9cc49edae9sm2094731ybk.63.2023.11.04.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 14:12:19 -0700 (PDT)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v3 0/2] rust: crates in other kernel directories
Date:   Sat,  4 Nov 2023 18:11:57 -0300
Message-ID: <20231104211213.225891-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC provides makes possible to have bindings for kernel subsystems
that are compiled as modules.

Previously, if you wanted to have Rust bindings for a subsystem, like
AMBA for example, you had to put it under `rust/kernel/` so it came
part of the `kernel` crate, but this came with many downsides. Namely
if you compiled said subsystem as a module you've a dependency on it
from `kernel`, which is linked directly on `vmlinux`.

So instead of overpopulating `kernel` with a gazillion modules that
throws you into dire straits you should rather have the bindings in the
same directory as the subsystem you want to bind with and link it to
it.

With this patch Rust sources can be compiled into libraries for them to
be consumed. These libraries are ar archives that follow the `.rlib`
structure, namely a libfoo.rlib thin archive with a foo.foo.o object
and a libfoo.rmeta rustc metadata as members. Such Rust crates get
their symbols exposed and the `bindings` crate is made available for
them.

Also included there's a sample usage of this in another patch, but it
is not meant to be merged as it remains as an example.

If you want to use a crate with your Rust module just add a `rust-libs`
variable in your Makefile with a value of the relative directory of
said crate plus its name, e.g.

    # Link with the foo crate
    rust-libs += ../path/to/foo

Martin Rodriguez Reboredo (2):
  kbuild: Build Rust crates as libraries
  samples: rust: Add USB sample bindings

 .gitignore                      |  2 ++
 Makefile                        |  4 ++--
 drivers/usb/core/Kconfig        |  7 ++++++
 drivers/usb/core/Makefile       |  3 +++
 drivers/usb/core/usb.rs         | 13 ++++++++++
 rust/bindings/bindings_helper.h |  1 +
 samples/rust/Kconfig            | 10 ++++++++
 samples/rust/Makefile           |  3 +++
 samples/rust/rust_usb_simple.rs | 22 +++++++++++++++++
 scripts/Makefile.build          | 42 ++++++++++++++++++++++++++++++---
 scripts/Makefile.lib            | 20 ++++++++++++----
 scripts/Makefile.modfinal       |  9 +++++--
 12 files changed, 125 insertions(+), 11 deletions(-)
 create mode 100644 drivers/usb/core/usb.rs
 create mode 100644 samples/rust/rust_usb_simple.rs

-- 
2.42.1

