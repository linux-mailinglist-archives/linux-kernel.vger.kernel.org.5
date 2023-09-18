Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724837A5649
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjIRXoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjIRXoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:44:34 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44255AD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:44:28 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6bdcdde1df9so7251758a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695080667; x=1695685467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c7Ja0i1IcPpF/fnQpaRtPSeE28AosoZQ6Vg1JwyxElA=;
        b=p/IVJrdhz/bvrKB5/g5DkVC30AHte3Y77rMbkrnwL1BFvoaRWhGT8kuZUFD4myxPul
         16zHuZ7mN2xZMYOHSBxMGpUhgYNRpKJwx8ZguxlmtQYIO403SZp9fxtSkIoGZ6BaSxpf
         QaGq6uhL720dcsBhFlhfKb4D0OTWi4xq+eGUFOBZF/FHAqOFnLaP3kkOsPlxlXCJkG3t
         wq45M8EvaT2RDV4Zi+5wRYbkvs12pcqAlmk3+LEwK5tS2niiclJnzwKe6x0prtrZJZTQ
         70/bwrGEcrS8K3JbdIj6ZxxRL6wYDoDxVYxFBO4TamIQY3jOXUZbMO9cdf+TXP0j/ulO
         dT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695080667; x=1695685467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7Ja0i1IcPpF/fnQpaRtPSeE28AosoZQ6Vg1JwyxElA=;
        b=hqi7m+8ufaLMWbix+p+KEEgp0Ty40GSx+hkBGKIGd6iuOOWF/jrnbfKWIKlryc0rjP
         NsdIsl5NETSsLTN0jKwiunLI+5bMkZRtzpf8r1UZwXUDcM56Y58Ey0igKEZxdrrT5lDg
         8bhQrLXl2MIGjj11433IJeIaxYJJ8aPerIOAGY3f2cXhPbb6adZD1AwAq/b0O9BnIy9G
         wMzRuSVJRncNoOjF3FR2TTB3vWnOXw2odq9KE2bE/Bdh3FafI1y2Dw2dzbPFL8uBewu/
         7lmaLEvPuCV5ZNHpkkHKD2KroX1niR03iT0TQO0wl0809CToG0Xst27FyUFLi/gHxR+L
         +BkA==
X-Gm-Message-State: AOJu0YyJACwFYQRrqzP63quyHa0tVVV7PEToaWRbbrkgnIS3rrfbngly
        TQJRttUBALlC9f6UM4fdJVXjeCBIURXF
X-Google-Smtp-Source: AGHT+IEWNL5w9D4Trzjih8i8HTTbndguhgEOkaPQwrgdz4cmvh+FiOlSacRbRQQ6mw8fWGuPlfXnrGrMTD3F
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6830:14d6:b0:6bf:27b3:3d29 with SMTP
 id t22-20020a05683014d600b006bf27b33d29mr2987806otq.5.1695080667608; Mon, 18
 Sep 2023 16:44:27 -0700 (PDT)
Date:   Mon, 18 Sep 2023 23:43:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230918234412.363087-2-mmaurer@google.com>
Subject: [PATCH v2] rust: Respect HOSTCC when linking for host
From:   Matthew Maurer <mmaurer@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
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

Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
resulting in build failures in hermetic environments where `cc` does not
exist. This includes both hostprogs and proc-macros.

Since we are setting the linker to `HOSTCC`, we set the linker flavor to
`gcc` explicitly.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---

Updated the patch to reflect Nick's comment that KBUILD_HOSTLDFLAGS     
should be respected as well.

I did not switch it to use HOSTLD for two reasons:                     
* That variable is not globally defined - it is only available in two   
  subdirectories of tools/                                                                            
* C host scripts are linked by HOSTCC as well, even when linking a                                    
  collection of object files. It *prints* HOSTLD, but invokes HOSTCC.                                 
  See scripts/Makefile.host cmd_host-cmulti for an example.

 rust/Makefile         | 4 ++++
 scripts/Makefile.host | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..b60b7eb8c5a0 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -380,9 +380,13 @@ $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 	$(call if_changed,exports)
 
+KBUILD_HOSTLDFLAGS_SQ = '$(subst ','\'',$(KBUILD_HOSTLDFLAGS))'
+
 quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
       cmd_rustc_procmacro = \
 	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
+		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
+		-Clink-args=$(KBUILD_HOSTLDFLAGS_SQ) \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
 		--crate-type proc-macro \
 		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 8f7f842b54f9..dc0410cae5ca 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -87,10 +87,14 @@ hostcxx_flags  = -Wp,-MMD,$(depfile) \
                  $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(target-stem).o)
 
+KBUILD_HOSTLDFLAGS_SQ = '$(subst ','\'',$(KBUILD_HOSTLDFLAGS))'
+
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
 # modules case.
 hostrust_flags = --out-dir $(dir $@) --emit=dep-info=$(depfile) \
+		 -Clinker-flavor=gcc -Clinker=$(HOSTCC) \
+		 -Clink-args=$(KBUILD_HOSTLDFLAGS_SQ) \
                  $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
                  $(HOSTRUSTFLAGS_$(target-stem))
 
-- 
2.42.0.459.ge4e396fd5e-goog

