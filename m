Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611F8773725
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjHHCyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHHCyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:54:23 -0400
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A410C4;
        Mon,  7 Aug 2023 19:54:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---.UB.bwII_1691463254;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.UB.bwII_1691463254)
          by smtp.aliyun-inc.com;
          Tue, 08 Aug 2023 10:54:14 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?=" 
        <sergio.collado@gmail.com>, <rust-for-linux@vger.kernel.org>
Subject: [PATCH v3] rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`)
Date:   Tue, 08 Aug 2023 10:54:01 +0800
Message-Id: <20230808025404.2053471-1-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we define the same function name twice in a trait (using `#[cfg]`),
the `vtable` macro will redefine its `gen_const_name`, e.g. this will
define `HAS_BAR` twice:

    #[vtable]
    pub trait Foo {
        #[cfg(CONFIG_X)]
        fn bar();

        #[cfg(not(CONFIG_X))]
        fn bar(x: usize);
    }

Fixes: b44becc5ee80 ("rust: macros: add `#[vtable]` proc macro")
Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
---
v1 -> v2:
- Use `BTreeSet` and existing `consts` as suggested by Alice and Gary.
- Reword commit messages as suggested by Miguel.
v2 -> v3:
- No need to replace `HashSet` with `BTreeSet`, since `consts` is never
  iterated on.

 rust/macros/vtable.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
index 34d5e7fb5768..ee06044fcd4f 100644
--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -74,6 +74,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
                 const {gen_const_name}: bool = false;",
             )
             .unwrap();
+            consts.insert(gen_const_name);
         }
     } else {
         const_items = "const USE_VTABLE_ATTR: () = ();".to_owned();
-- 
2.40.1

