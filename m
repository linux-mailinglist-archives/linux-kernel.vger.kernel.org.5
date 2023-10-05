Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158DF7BABCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjJEVGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJEVGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:06:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB3D9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:06:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E193C433C7;
        Thu,  5 Oct 2023 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696539989;
        bh=IgnQ6UponHD7jSbFHw/8nSE/0v3lOdZL01VrkmoEWNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTVigqePQVgAUvofgawoF4pXU1khefVIcRhUaE6EHw8QVre55UrKUxmvtvPsRn0TN
         r9c2a1hZQXYcwB4kDn5MpFuqITHIE3m1mYZlVoOibIxq9ISrbWKLQhh7dJUh7djA2F
         XVUCTXYAei48w+IWUlhMZlcFUYNgSNFGAmv0U3AzaaVNSCnorI61XMEQuQfAPBjybZ
         jALxqZ2TsDrogKhpRykPUK1xLhxlxw3RlOTegKboVip5QMTJ0jjJM5GGfYxXzFKMTc
         /PQ6A7AWO099ZFZLraaIllvNOedS03hlmQAR35aDJT82Rh5+wFzkzFOS7Rajmvd4Bv
         jomQrL5ePPWhQ==
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
        patches@lists.linux.dev
Subject: [PATCH 2/3] rust: print: use explicit link in documentation
Date:   Thu,  5 Oct 2023 23:05:54 +0200
Message-ID: <20231005210556.466856-3-ojeda@kernel.org>
In-Reply-To: <20231005210556.466856-1-ojeda@kernel.org>
References: <20231005210556.466856-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The future `rustdoc` in the Rust 1.73.0 upgrade requires an explicit
link for `pr_info!`:

    error: unresolved link to `pr_info`
       --> rust/kernel/print.rs:395:63
        |
    395 | /// Use only when continuing a previous `pr_*!` macro (e.g. [`pr_info!`]).
        |                                                               ^^^^^^^^ no item named `pr_info` in scope
        |
        = note: `macro_rules` named `pr_info` exists in this crate, but it is not in scope at this link's location
        = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`

Thus do so to avoid a broken link while upgrading.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/print.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 8009184bf6d7..f48926e3e9fe 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -399,6 +399,7 @@ macro_rules! pr_debug (
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
 /// `alloc::format!` for information about the formatting syntax.
 ///
+/// [`pr_info!`]: crate::pr_info!
 /// [`pr_cont`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_cont
 /// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
 ///
-- 
2.42.0

