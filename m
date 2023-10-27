Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C77D8C90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 02:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjJ0AfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 20:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0AfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 20:35:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB911B6;
        Thu, 26 Oct 2023 17:35:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b9af7d41d2so1489807b3a.0;
        Thu, 26 Oct 2023 17:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698366912; x=1698971712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=usbHaxcBxH3v5TUXsmVVZxNrcj87lpTiZe9iPVq/oHc=;
        b=aRBYX/lB+H0RHOWogdS8RKa99kEzBMZiDlD62iuK36d8oFDXCBpkGNTYjGU55rq/lU
         tsmL7mEu8hI0wfFPDfTr6FYIjmZbWswBFFIh1Za3wV9bX2NL8idm2gFtMI1RUU9SKW5b
         dQ4yutTa4uIcvzZVacDjVrzpZAEpgmcPKv/gufNpzwjJKjPj5pYvh2UEjgodrUo9XZGn
         nerU8QUYrLHC0vOQ4+0LlvtjATdCTVQBQtvMQj+Bi+xqdpHJfgQfYp0euGLrxiz/Ng7y
         MnZE4puqYICFPnhDFD+/739gBV8I0LfHHxInatCeqSjnMDytI6mHiAzGBoEOn0Hj4xB6
         /yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698366912; x=1698971712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usbHaxcBxH3v5TUXsmVVZxNrcj87lpTiZe9iPVq/oHc=;
        b=Jjgd5qTw8C8DmSKnaIo4eQXUZPG8nDoGrp8SkE6em4Gj/VrlfdzbqNBLW0dos5jBqL
         CcbzAXEUx5BgimILbYrxvyaNNa75eT8egPTAdF6gFYd7vwcX5JR8ZLwXhBVhU8YBSic8
         z54P1+8FVww/XfsyMZl5E1fw+2Lu4hBccgn5Tp3+4s0Qb95+OjxcZqKQ8DRS93VRAw5d
         iGDk23c8jpq8y6k/lSPApKdsHhYaVm78a/X1pXBLZppcdmT9G8Tk12CV5UyX4zQLmDE8
         0Xx4ajJaioaPxrR4C2PtyEx+TYJ/cR+UJSY8u7nC0prkNzaC2n7758IdvuYloXEMaGOm
         yjoA==
X-Gm-Message-State: AOJu0YwYShrKfPixxRdL+sDqo+xZCDFbwCbQKk4Syd6Pjcn/sz7o0YFi
        dJ/Gpg2ebxHV8lmghhwCjgk=
X-Google-Smtp-Source: AGHT+IF7e19PsOJXZ79tU9gqfcLbOm3UW/Lf7l3/z0dKRoeJf+SPUfv4Z7C8Gx/vWwd5f4tmdBlzjA==
X-Received: by 2002:a05:6a00:1810:b0:68e:3bc8:17d1 with SMTP id y16-20020a056a00181000b0068e3bc817d1mr1467842pfa.29.1698366911825;
        Thu, 26 Oct 2023 17:35:11 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006be683108cesm183096pfo.213.2023.10.26.17.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 17:35:11 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/2] rust: crates in other kernel directories
Date:   Thu, 26 Oct 2023 21:34:49 -0300
Message-ID: <20231027003504.146703-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 Makefile                        |  4 +--
 drivers/usb/core/Kconfig        |  7 +++++
 drivers/usb/core/Makefile       |  3 ++
 drivers/usb/core/usb.rs         | 13 +++++++++
 samples/rust/Kconfig            | 10 +++++++
 samples/rust/Makefile           |  3 ++
 samples/rust/rust_usb_simple.rs | 22 +++++++++++++++
 scripts/Makefile.build          | 49 ++++++++++++++++++++++++++++++---
 scripts/Makefile.lib            | 18 ++++++++++--
 scripts/Makefile.modfinal       |  7 ++++-
 11 files changed, 128 insertions(+), 10 deletions(-)
 create mode 100644 drivers/usb/core/usb.rs
 create mode 100644 samples/rust/rust_usb_simple.rs

-- 
2.42.0

