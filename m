Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80E7CE1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjJRP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjJRPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:55:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF20C125;
        Wed, 18 Oct 2023 08:55:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DC7C433C7;
        Wed, 18 Oct 2023 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697644556;
        bh=QOxEFIuVVtPbHt6SDOXDaVCFqda4cdEMS/w7hpcXpcY=;
        h=From:To:Cc:Subject:Date:From;
        b=cOBM6IcDPq8PDGVpDXBEVv2ba4ZO3hdCRkDH99bm77Lm0p9dV07OIINqZGvUli5kW
         393SvZ2692e9Fm6JpK5M+pUYen/CfJ8cEkLgIPpHSnc8ZPsZUSzrEZKLTYOYIZXuws
         zctziMrDbUICAaZl8dzV9yyBm3Ij9I8MuBfYGe0x+ipPe2748ZDpdQebMcGCmuE8Ei
         RR2qjbaefdWlVhex7QO6OKYUhHCfKVR68q/klDBXpBimYRdUJA58dK2GK45ZJqLz+4
         5+4o702K+xpZPiVl6aK/cZgGZlX5jTGz3K0JHczF50iUsNM0qQ5+1pu7AYvcsO2PmN
         1kShxUpTolNRA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH] rust: docs: fix logo replacement
Date:   Wed, 18 Oct 2023 17:55:27 +0200
Message-ID: <20231018155527.1015059-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static files placement by `rustdoc` changed in Rust 1.67.0 [1],
but the custom code we have to replace the logo in the generated
HTML files did not get updated.

Thus update it to have the Linux logo again in the output.

Hopefully `rustdoc` will eventually support a custom logo from
a local file [2], so that we do not need to maintain this hack
on our side.

Link: https://github.com/rust-lang/rust/pull/101702 [1]
Link: https://github.com/rust-lang/rfcs/pull/3226 [2]
Fixes: 3ed03f4da06e ("rust: upgrade to Rust 1.68.2")
Cc: stable@vger.kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..08af1f869f0c 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -93,15 +93,14 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
     rustdoc-alloc rustdoc-kernel
-	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)
-	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)
+	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/static.files/
+	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/static.files/
 	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
-		-e 's:rust-logo\.svg:logo.svg:g' \
-		-e 's:rust-logo\.png:logo.svg:g' \
-		-e 's:favicon\.svg:logo.svg:g' \
-		-e 's:<link rel="alternate icon" type="image/png" href="[./]*favicon-(16x16|32x32)\.png">::g'
-	$(Q)echo '.logo-container > img { object-fit: contain; }' \
-		>> $(rustdoc_output)/rustdoc.css
+		-e 's:rust-logo-[0-9a-f]+\.svg:logo.svg:g' \
+		-e 's:favicon-[0-9a-f]+\.svg:logo.svg:g' \
+		-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g'
+	$(Q)for f in $(rustdoc_output)/static.files/rustdoc-*.css; do \
+		echo ".logo-container > img { object-fit: contain; }" >> $$f; done
 
 rustdoc-macros: private rustdoc_host = yes
 rustdoc-macros: private rustc_target_flags = --crate-type proc-macro \
-- 
2.42.0

