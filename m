Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2D7536B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjGNJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbjGNJgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:36:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D533590;
        Fri, 14 Jul 2023 02:36:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 81EFA5BC9B;
        Fri, 14 Jul 2023 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326244;
        bh=qJo7mYZ92ZVzEhgvxpERMJP/merzZqrWhb59Z8XEN0k=;
        h=From:Date:Subject:To:Cc;
        b=ASk5n4CnvsESI2z/tecTRAvXqRKZ4wFHacuFAWJHfM38PBGB0zWdtQnwgt/EZun6s
         A1oLjkZMXu4htW+YOLmyGuwUYv8A4iafoJjlgVjI9djMSnDpYGwc6iJgUkNQNIeynB
         6ORsj8QMo7XJfCACQdbxCNEAQsD5qKzxUVkgjHxAIkUsJl9HxnF5wLSmE/aCo+Hp4M
         6lMW9O7xK3HW56xlh7mxLmI84iIXfd0jwStYSZEdLf6DNdr5PW909xo1YK9qIxrlkB
         e++xCU4LZUqad22/hevlsdN9hNxid6MOXAL95MHdqdRmd/+rmBumi5fV4VWshBX7vQ
         cg1CogqR45Iyg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:17:16 +0900
Subject: [PATCH] rust: init: Implement Zeroable::zeroed()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-zeroed-v1-1-494d6820d61b@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAJsSsWQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0MT3arUovzUFN2UFAPTpGRzY/M0C1MloOKCotS0zAqwQdGxtbUAjkp
 eH1gAAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326241; l=1060;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=qJo7mYZ92ZVzEhgvxpERMJP/merzZqrWhb59Z8XEN0k=;
 b=/0R7QoF0o5fRt1iGDE6jPrr2eE28drfWrZESrdhNbNwynMxHwuBVKvZKSoPzlgKPC6hNC8jWy
 heVaSsDCaPlCGkQ8LqGPG2nsisyLGbN3LrdUTiQZbyJt2ztAXZgdURV
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

By analogy to Default::default(), this just returns the zeroed
representation of the type directly. init::zeroed() is the version that
returns an initializer.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/init.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index b4332a4ec1f4..c300ce39ac10 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1354,7 +1354,14 @@ pub unsafe trait PinnedDrop: __internal::HasPinData {
 /// ```rust,ignore
 /// let val: Self = unsafe { core::mem::zeroed() };
 /// ```
-pub unsafe trait Zeroable {}
+pub unsafe trait Zeroable: core::marker::Sized {
+    /// Create a new zeroed T.
+    ///
+    /// Directly returns a zeroed T, analogous to Default::default().
+    fn zeroed() -> Self {
+        unsafe { core::mem::zeroed() }
+    }
+}
 
 /// Create a new zeroed T.
 ///

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230714-zeroed-dd05bc737f85

Thank you,
~~ Lina

