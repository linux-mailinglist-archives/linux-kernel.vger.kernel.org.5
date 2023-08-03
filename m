Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4435276E491
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjHCJgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjHCJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:35:55 -0400
Received: from keen-gwydion.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1F3A86;
        Thu,  3 Aug 2023 02:35:44 -0700 (PDT)
Received: from malleable-ellyllon.authn-relay.a.mail.umich.edu (ip-10-0-72-197.us-east-2.compute.internal [10.0.72.197])
        by keen-gwydion.relay-egress.a.mail.umich.edu with ESMTPS
        id 64CB74E7.31CF9656.4E62D228.70552;
        Thu, 03 Aug 2023 05:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1691055333;
        bh=eCGHB3OVxX8oKBCn/5KheI7o8Eqib5nZqv5FXr+nZ7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TTzt+6UeD2pXwcRAiDxIsUtrd6xhzYCWA7E0fhG95/0mbEhcPKAehiF86g9uhqaLs
         BQzTLvk8hzLtxeyMiP3l+N/bEk5+PESAsvk59Q6u8UzC+petFkAry0XbGogBj3me3Q
         +2533Qqqk36GziD7mOJSICbMyHkZSpkZrSaKfZm9cCXLGQPtbCjzZpOZZEt0SEka1W
         wcPA8kpPmuqWImw2BlGjh0I/+rKHgds/XfQmb7vsoBznvY46XRVSmpTG9RnKt0PUbv
         vZi9gw2JLO/oEgBprDm8x3o+e2aU0hNjXc/4sBJ8kb/gV5em+uSO3izE7Z7a25fkVg
         iCr8BrmV/qb+w==
Authentication-Results: malleable-ellyllon.authn-relay.a.mail.umich.edu; 
        iprev=permerror policy.iprev=68.32.216.219 (unknown);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (unknown [68.32.216.219])
        by malleable-ellyllon.authn-relay.a.mail.umich.edu with ESMTPSA
        id 64CB74E4.2CE0CA91.645E8B9.1340056;
        Thu, 03 Aug 2023 05:35:33 -0400
From:   Trevor Gross <tmgross@umich.edu>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>
Subject: [RFC PATCH 1/2] rust: bindings: generate API documentation for the 'bindings' crate
Date:   Thu,  3 Aug 2023 05:34:17 -0400
Message-Id: <20230803093418.51872-2-tmgross@umich.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803093418.51872-1-tmgross@umich.edu>
References: <20230803093418.51872-1-tmgross@umich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bindings' crate is currently not included in rustdoc output. Add
this crate to documentation output to provide an easy reference when
developing abstractions or inspecting Rust-C bindings.

Signed-off-by: Trevor Gross <tmgross@umich.edu>
---
 rust/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index f7c9a6e54c85..b5ce57a50eb5 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -81,7 +81,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # command-like flags to solve the issue. Meanwhile, we use the non-custom case
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
-    rustdoc-alloc rustdoc-kernel
+    rustdoc-alloc rustdoc-bindings rustdoc-kernel
 	$(Q)cp $(srctree)/Documentation/images/logo.svg $(objtree)/$(obj)/doc
 	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(objtree)/$(obj)/doc
 	$(Q)find $(objtree)/$(obj)/doc -name '*.html' -type f -print0 | xargs -0 sed -Ei \
@@ -114,12 +114,20 @@ rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
 rustdoc-alloc: $(src)/alloc/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
 	$(call if_changed,rustdoc)
 
+rustdoc-bindings: private rustc_target_flags = --extern alloc \
+    --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
+    --extern uapi
+rustdoc-bindings: $(src)/bindings/lib.rs rustdoc-core rustdoc-macros \
+    rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
+    $(obj)/bindings.o FORCE
+	$(call if_changed,rustdoc)
+
 rustdoc-kernel: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
     --extern bindings --extern uapi
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
-    rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
-    $(obj)/bindings.o FORCE
+    rustdoc-compiler_builtins rustdoc-alloc rustdoc-bindings \
+    $(obj)/libmacros.so FORCE
 	$(call if_changed,rustdoc)
 
 quiet_cmd_rustc_test_library = RUSTC TL $<
-- 
2.34.1

