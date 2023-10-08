Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1180A7BCDA7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbjJHJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbjJHJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:56:06 -0400
X-Greylist: delayed 283 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Oct 2023 02:56:04 PDT
Received: from short-nisien.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.216.144.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D220EB;
        Sun,  8 Oct 2023 02:56:04 -0700 (PDT)
Received: from exalted-banshee.authn-relay.a.mail.umich.edu (ip-10-0-74-179.us-east-2.compute.internal [10.0.74.179])
        by short-nisien.relay-egress.a.mail.umich.edu with ESMTPS
        id 65227B97.15EC55FA.7AE301A9.81919;
        Sun, 08 Oct 2023 05:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1696758678;
        bh=I+o9SIX4PotCqWF/xeatcNnnqUwJ9aNzchabhWdrqjA=;
        h=From:To:Cc:Subject:Date;
        b=q5dVvz0UBP3d3l2RanJF9SMVehhIpvDqS+ES4mXq2bIa7WowwiVEGUP4oHkSj9r7h
         gOvtKBiDiv2LsAsHuT+UVcucyxzL6uiTAdICEwCVuGMDxQLl25uN/Yzr1USAJ1FxPG
         iSoIoW9N+LYweqBTUGJev5/5wn+sfABzdExCXhUtIa7LAtow7W4B0/V+wPaYicAGmI
         1md/jPLut7YAdXfT/iUGcHL7/YZJ/cVD+ZqpC4JF09PLwrqI3nOYo8gVK+UlGEdzXb
         q3qh0AI/Zb/Mws7VxOAm6XXVYj9YHA9SekhoEDIvXxxhWElVju16pzMhUQRB87v0tY
         ykDi2Dy3GS8rg==
Authentication-Results: exalted-banshee.authn-relay.a.mail.umich.edu; 
        iprev=pass policy.iprev=76.141.129.158 (c-76-141-129-158.hsd1.il.comcast.net);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (c-76-141-129-158.hsd1.il.comcast.net [76.141.129.158])
        by exalted-banshee.authn-relay.a.mail.umich.edu with ESMTPSA
        id 65227B96.46860EC.3A6166B1.881404;
        Sun, 08 Oct 2023 05:51:18 -0400
From:   Trevor Gross <tmgross@umich.edu>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>,
        Trevor Gross <tmgross@umich.edu>
Subject: [PATCH] rust: macros: update 'paste!' macro to accept string literals
Date:   Sun,  8 Oct 2023 05:48:18 -0400
Message-Id: <20231008094816.320424-1-tmgross@umich.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable combining identifiers with string literals in the 'paste!' macro.
This allows combining user-specified strings with affixes to create
namespaced identifiers.

This sample code:

    macro_rules! m {
        ($name:lit) => {
            paste!(struct [<_some_ $name _struct_>];)
        }
    }

    m!("foo_bar");

Would previously cause a compilation error. It will now generate:

    struct _some_foo_bar_struct_;

Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Trevor Gross <tmgross@umich.edu>
---

Original mention of this problem in [1]

[1]: https://lore.kernel.org/rust-for-linux/20231008.164906.1151622782836568538.fujita.tomonori@gmail.com/

 rust/macros/paste.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
index 385a78434224..f40d42b35b58 100644
--- a/rust/macros/paste.rs
+++ b/rust/macros/paste.rs
@@ -9,7 +9,15 @@ fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
     loop {
         match tokens.next() {
             None => break,
-            Some(TokenTree::Literal(lit)) => segments.push((lit.to_string(), lit.span())),
+            Some(TokenTree::Literal(lit)) => {
+                // Allow us to concat string literals by stripping quotes
+                let mut value = lit.to_string();
+                if value.starts_with('"') && value.ends_with('"') {
+                    value.remove(0);
+                    value.pop();
+                }
+                segments.push((value, lit.span()));
+            }
             Some(TokenTree::Ident(ident)) => {
                 let mut value = ident.to_string();
                 if value.starts_with("r#") {
-- 
2.34.1

