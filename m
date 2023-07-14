Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234797536A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjGNJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjGNJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:32:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3719235A7;
        Fri, 14 Jul 2023 02:31:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6CA745BC42;
        Fri, 14 Jul 2023 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326065;
        bh=VAWao2XqqfaUrUG4eX38dF7EKCEUq2ZmTgp3mGFnUog=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Rv070+McVf53L+fSrNOclnynR56VOM4amtL7xuLQwcaK+e19Wsy1rNkvqbg6WcsiY
         0MnUjP+vlKz8e6ztLv/VZ9thIOOFcPh0OWjANftlA2mnzK0dim3oF0fgNYG43698xB
         2hdwNHSrKhAT/ten+6mJY64iGCuS7pi9/uEKjn1hjFJZSnfhXRZNDVOMVr91DxgTgi
         J0zWbSZ5CC8aYPK4M53RQmC7CirFTX2n9Tg6KW0Wujo0/4J7KIjn4pOV7Qtb/yJMH6
         jcssZJ/U1sfZiokColgbsAoU+/s9Jf/eYAtM85nCAY7a0ZBn2JjFj9InCXH9KY+eOV
         83Kma93HKnxpA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:13:55 +0900
Subject: [PATCH RFC 03/11] rust: Use absolute paths to build Rust objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-3-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
In-Reply-To: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=2695;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=VAWao2XqqfaUrUG4eX38dF7EKCEUq2ZmTgp3mGFnUog=;
 b=Mei8TIbhg8193HQ30Z4+6AvQI9I9bSJA87f41daFHByxLcwEs3OLPMiDdbvZqxkvrxSyz2Yw4
 CfwDvXCA5JUDiUEQ/kiBq9bICTiHOt+It/8iffq7+3VXjaJJiug42AT
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

We want to use caller_location to uniquely identify callsites, to
automatically create lockdep classes without macros. The location
filename in local code uses the relative path passed to the compiler,
but if that code is generic and instantiated from another crate, the
path becomes absolute.

To make this work and keep the paths consistent, always pass an absolute
path to the compiler. Then the Location path is always identical
regardless of how the code is being compiled.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/Makefile          | 2 +-
 scripts/Makefile.build | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 7c9d9f11aec5..552f023099c8 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -369,7 +369,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 		--emit=dep-info=$(depfile) --emit=obj=$@ \
 		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
 		--crate-type rlib -L$(objtree)/$(obj) \
-		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
+		--crate-name $(patsubst %.o,%,$(notdir $@)) $(abspath $<) \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
 
 rust-analyzer:
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6413342a03f4..c925b90ebd80 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -283,27 +283,27 @@ rust_common_cmd = \
 # would not match each other.
 
 quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
-      cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $<
+      cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $(abspath $<)
 
 $(obj)/%.o: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_o_rs)
 
 quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
       cmd_rustc_rsi_rs = \
-	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
+	$(rust_common_cmd) -Zunpretty=expanded $(abspath $<) >$@; \
 	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
 
 $(obj)/%.rsi: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_rsi_rs)
 
 quiet_cmd_rustc_s_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
-      cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $<
+      cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $(abspath $<)
 
 $(obj)/%.s: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_s_rs)
 
 quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
-      cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $<
+      cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $(abspath $<)
 
 $(obj)/%.ll: $(src)/%.rs FORCE
 	$(call if_changed_dep,rustc_ll_rs)

-- 
2.40.1

