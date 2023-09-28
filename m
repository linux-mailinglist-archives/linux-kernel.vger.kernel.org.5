Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438C47B2658
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjI1UOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1UOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:14:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F58180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:14:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e1154756so267620497b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695932071; x=1696536871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CTdQf6t/tIUqszi45qXCPEPknJtrj/I7M7O29HIYM8Q=;
        b=TyZTB3/yvWlPDeRljW7Xh6F0FDIoPIEPeFKOJ/tE56R0eKxZ2N7jm00ZTvk71AyOew
         PYg5D8FfiOSwXr8iOgkTK399ix6tLk837RYMQxpf+e1Adr6GS0rmJszG37jbr1FnV/DO
         7/wcQDdt34FC6cjGy4skTMaXXnTW7tn88TlCHfQRWkdZiM4QVAzEINYufVEhMwVzFqLK
         8UEEysAE2hYHUvjav4xLe62FxdMquud+qweH873Wgmc89FQIs6nXv9TBxDCptQkS7MmZ
         4vjTflm2g6QdRUJjMuYVmO+qi7mqwKeHN4rcjQ6F6khcFqDk/D84aTG6i4RIiR6y9dvO
         s86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695932071; x=1696536871;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTdQf6t/tIUqszi45qXCPEPknJtrj/I7M7O29HIYM8Q=;
        b=ob3nvA5pWMevJRvncRBGw00JH5R1PmQUUgw0Wh9NfcN2ouE3H8MHgD9zNNu7tb2kFL
         XMQS8emh7qPXjQwssBPijtDVk0wcCeKb1zJAT0I51cFavskZ9Eg2u9cSQGUQ1NNhcHtf
         Fgllyvhe1R60D58XCByIo+YBS/34oF4Yw/+BdkxIB4sl6+Z/61f8DwedLVUN1R/pV/Ce
         /hZAy17Io7Vbbwga3FtMXlqCc4tnpe2UcxjQw3BMaTHI7+Ty/PcR4WxyurPdpBKsgmCc
         d/wNTO5XfCHGyj7RRfedn+pJ8BuS2tIeKrMM1GWtChq86Mz3HlhIxAp1q3C5k+T6vsIF
         YARg==
X-Gm-Message-State: AOJu0YzKU4hf/zSwl1oy2xlMCnv1ZsYCUd4Vky/wYRHYmDT7zrqR/MBQ
        3bEH75SPp5qtvJC4Q1BKiq6Ov7YHwY1p
X-Google-Smtp-Source: AGHT+IHwnWlji7i78BHxj4CXH0kvSLPKwNCO7+9R1dUjCa+jZFHR9zgNynredWd08boGwsZq0hGACq/j8rap
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:a4b:0:b0:d84:bf67:c76c with SMTP id
 z11-20020a5b0a4b000000b00d84bf67c76cmr32506ybq.10.1695932071020; Thu, 28 Sep
 2023 13:14:31 -0700 (PDT)
Date:   Thu, 28 Sep 2023 20:14:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230928201421.2296518-1-mmaurer@google.com>
Subject: [PATCH] rust: Use grep -Ev rather than relying on GNU grep
From:   Matthew Maurer <mmaurer@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While GNU grep supports '\|' when in basic regular expression mode, not
all grep implementations do (notably toybox grep, used to build the
Android kernel, does not). Switching to grep -Ev enables extended
regular expresions which includes support for the '|' operator.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 rust/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..e6fb7cafc0bc 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -336,13 +336,13 @@ quiet_cmd_bindgen = BINDGEN $@
 		$(bindgen_target_cflags) $(bindgen_target_extra)
 
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
-    $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters)
+    $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
-    $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters)
+    $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
-- 
2.42.0.582.g8ccd20d70d-goog

