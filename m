Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C86E7DD6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjJaUUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjJaUUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:20:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F10101
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:20:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso5286194276.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698783631; x=1699388431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIpaUvpPt/FXbzm5nKCXxMF++9wEyj/NimmkMOXmsLo=;
        b=g8TpMIfqmwvE4qRFARnYsmOLrd64zxKuq6VhQ55wVz58nYL09vKitIfhHApafnTJk9
         eE/c9028THd1H2WOgtbRLcj5mgv7JnKUNzlxLKqRsIiju0LGgqzbqjTQeNCSD3Zw00eo
         kP1n5q0zCrqFwN1blRazvwOEiX1mrNTRsam4H2EW7WsoaxnKS2APJaXQaAzE0PeP+mRV
         08lp1DQfUQhP5ejl/bKVXmdIwfQlbe94fTE/iJNPOgnNxBdglLexHVVBgFnzPRt/oNcG
         SHnfml5O/GMxAd1b5cDLcNKtyrTsjP3zOpOrJ8P6Lzz8twvQxt/DPq1fVmm/ppHtXqj8
         /mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698783631; x=1699388431;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIpaUvpPt/FXbzm5nKCXxMF++9wEyj/NimmkMOXmsLo=;
        b=mjQ9nBhl3Yh+gjbvYQnBM96QelrTgstVz5bJVxxvz7iz450SXtsrRiChkuz/rZj6z0
         Yw/ip9BeWOznR41IfdJLYvxLUxlhJzsYDXNVBvnvvTQdcPNfkRqidWYtrTVGcUv1XXOZ
         23vdtkSi5LuJnMa5FBgYsPpq8o3PY/OxXUWqv+7122YOpdLY+nHIlI4AasFMe1+Zhwms
         mv9Hlr/KoCgv3fIQD/IdPfqfMyvL31PWm4kVHmaMBAnGRt7YO73YhaME1jmkbW8cpE/H
         EvBJazc7X+ISH+lv6TkyqdsTzhAgdnMHoKVE8jHnk+0Q9xaEjqNwO4ftU5c82C13DjF3
         CvOw==
X-Gm-Message-State: AOJu0Yy+ipGcU2zVMNb9eliRaXiwVlhBmjSsia6RNy5qDlyfT8W+4coq
        nxadEjQoDOtbdHlo0fR/4S2OoLyM1rXp
X-Google-Smtp-Source: AGHT+IGLO+nOjD62+HLAfpYoCH9Rz2qtqF+wmxh11MaslROEb45vmSU864vwQzq+PEmwctuPBAUQaj3vRvU1
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:4c8:b0:d9a:54e7:e910 with SMTP id
 v8-20020a05690204c800b00d9a54e7e910mr278979ybs.4.1698783631471; Tue, 31 Oct
 2023 13:20:31 -0700 (PDT)
Date:   Tue, 31 Oct 2023 20:19:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031201945.1412345-1-mmaurer@google.com>
Subject: [PATCH] rust: Ignore preserve-most functions
From:   Matthew Maurer <mmaurer@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither bindgen nor Rust know about the preserve-most calling
convention, and Clang describes it as unstable. Since we aren't using
functions with this calling convention from Rust, blocklist them.

These functions are only added to the build when list hardening is
enabled, which is likely why others didn't notice this yet.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/bindgen_parameters | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 552d9a85925b..8d9f82d350b8 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -20,3 +20,7 @@
 
 # `seccomp`'s comment gets understood as a doctest
 --no-doc-comments
+
+# These functions use the __preserve_most calling convention, which neither bindgen
+# nor Rust currently understand, and which Clang currently declares to be unstable.
+--blocklist-function __list_.*_report
-- 
2.42.0.820.g83a721a137-goog

