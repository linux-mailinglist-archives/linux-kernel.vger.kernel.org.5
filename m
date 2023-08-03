Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EAE76E490
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjHCJg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjHCJfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:35:52 -0400
Received: from keen-gwydion.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA6A3595;
        Thu,  3 Aug 2023 02:35:37 -0700 (PDT)
Received: from malleable-ellyllon.authn-relay.a.mail.umich.edu (ip-10-0-72-197.us-east-2.compute.internal [10.0.72.197])
        by keen-gwydion.relay-egress.a.mail.umich.edu with ESMTPS
        id 64CB74E7.34E6EDA0.5CA2EDAA.70552;
        Thu, 03 Aug 2023 05:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1691055335;
        bh=elT4B5g6oxJl47kw6yls2EuBwoQcgDU3XUgEiz68IfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rOdabUCn6SgmcP257XywA71g1ugfTC+DQoJrsG4iVRfShYYngVvnvYEApMY36Gk1f
         ol3DhC8Wa6Cit3NISbyZ7YdGk1pdVgEPie3XCRLNOF5BjytEa4PVvm7Ts9jtikYsb/
         p4H/5nt/BFcbhzJfxJOQOtHwPixE+M7V/5Valj19TijJ+YJf1Z4EkxTpjGESdpNmgM
         d9ZtZVCFT8ejRbK4voyTPu+ZC4pCCwt96KwEq2165O3uJ//O0kNedgabZoeDpcWSwO
         qErrmI+xKSF/DMCY4d4mebYdhgA2/Jc8c39ZZlI/5k349pAg+Xhi0zSTNEN0yVgmfQ
         L5zkNnwt6evHA==
Authentication-Results: malleable-ellyllon.authn-relay.a.mail.umich.edu; 
        iprev=permerror policy.iprev=68.32.216.219 (unknown);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (unknown [68.32.216.219])
        by malleable-ellyllon.authn-relay.a.mail.umich.edu with ESMTPSA
        id 64CB74E6.280818CF.72FCE152.1340056;
        Thu, 03 Aug 2023 05:35:34 -0400
From:   Trevor Gross <tmgross@umich.edu>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>
Subject: [RFC PATCH 2/2] rust: bindings: add warning about configuration dependence
Date:   Thu,  3 Aug 2023 05:34:18 -0400
Message-Id: <20230803093418.51872-3-tmgross@umich.edu>
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

Add a note stating that binding documentation may differ from a user's
configuration, to make users aware that published documentation may not
always match a specific setup.

Signed-off-by: Trevor Gross <tmgross@umich.edu>
---
 rust/bindings/lib.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 9bcbea04dac3..869632c2341c 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -7,6 +7,9 @@
 //! This crate may not be directly used. If you need a kernel C API that is
 //! not ported or wrapped in the `kernel` crate, then do so first instead of
 //! using this crate.
+//!
+//! Note that this module is heavily configuration-dependent, published versions
+//! of documentation may not accurately reflect local configuration.
 
 #![no_std]
 // See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
-- 
2.34.1

