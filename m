Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808587536A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjGNJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjGNJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:32:06 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781923595;
        Fri, 14 Jul 2023 02:31:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 471AB5BC3C;
        Fri, 14 Jul 2023 09:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326052;
        bh=o+SeZO+TTzWLzgNWKeL/9Zv5OKicaLoX59hV3WtVOuQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=G1Wt2cxZ6pXf5tZHduVNikkCwJ3eY/lAhhmaHq//OZOo1deR9FPvpL756OTXtqF85
         U8KN4XXHwq4kXASxrE4WM3foVumLTNRuyqWbxwvb3G5DVYK5urrwEpptS14bvFxNuV
         rM9oWkXKT6+KtlANMnhRwMIRrKKn/t+a1OQzzUInlbKfRIEEiKHfM46BpexZR3xeQo
         zw6WVMGuSbW3xPkeiUX1+B0n8oA2tixHQOpEQD8x35urVL0yabJLZeR9yatWjie17f
         HvYMnAtJzpmQQjPcKmEpSusQK/YGodFN0o0fLT0yKw6OpEZ1e/EstgBaO+Fg78oVw9
         /bKFNaONUniCA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:13:53 +0900
Subject: [PATCH RFC 01/11] rust: types: Add Opaque::zeroed()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-1-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=917;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=o+SeZO+TTzWLzgNWKeL/9Zv5OKicaLoX59hV3WtVOuQ=;
 b=P7T19OB+nyd6yqEUa+zAXigTFInuYsRPYk1q7QrYZWp3AGBZT9g7I8/XOtzJ0ql7JeJgdOQIU
 c1DhSVUSWWlDIOLTjbR15WVf3RuPsnSK+ax6uw3FGMMMCpBAJ/uBqK1
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

Opaque types are internally MaybeUninit, so it's safe to actually
zero-initialize them as long as we don't claim they are initialized.
This is useful for many FFI types that are expected to be zero-inited by
the user.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/types.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 1e5380b16ed5..185d3493857e 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -237,6 +237,11 @@ pub const fn uninit() -> Self {
         Self(MaybeUninit::uninit())
     }
 
+    /// Creates a zeroed value.
+    pub fn zeroed() -> Self {
+        Self(MaybeUninit::zeroed())
+    }
+
     /// Creates a pin-initializer from the given initializer closure.
     ///
     /// The returned initializer calls the given closure with the pointer to the inner `T` of this

-- 
2.40.1

