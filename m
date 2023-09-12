Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA779D970
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbjILTQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjILTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:16:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD884C1;
        Tue, 12 Sep 2023 12:16:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBFDC433C8;
        Tue, 12 Sep 2023 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546163;
        bh=c7jZxlk5p8L1YHtA+APUlJpnJH+hzWn4svc71Gb/BZg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XjJSu2s/iCGS/x1K4vCQ0wm8NfNZVit0R02LHCWS0yWS+bAaBd0A23lZc+WIJOp/w
         dsS7AM9peTkMQqrbYLt398NI7Ltx8h37rp8auXfMaa1TIceI37gtaDLfFqXzhJLyjP
         kG8DRvvCJ0n0mqh3Mne4pebzz5WnM40oXGGkCHZeBEaNehGBs+K2iGotRqJzcNdid5
         csAUpUO1483rnrI6OiDqpM0ZuNFhKDlVdClZEoA2oaHibwjpEBvaNB7RCaoBN2M1PA
         hyd7TseWxnSHswaDrcKRu5FxuSQj7schd6YGr7g1VTcHr2t7dK3ocRLbE0FccaqbF0
         iqKhInnCwvyzw==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 12 Sep 2023 12:15:41 -0700
Subject: [PATCH 4/7] bcachefs: Fix -Wformat in bch2_bucket_gens_invalid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-bcachefs-warning-fixes-v1-4-a1cc83a38836@kernel.org>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=nathan@kernel.org;
 h=from:subject:message-id; bh=c7jZxlk5p8L1YHtA+APUlJpnJH+hzWn4svc71Gb/BZg=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkMO96vVIx7se7eO6OrgclsXg3xAWnTSxuX1Pi/kP4d8
 tB9HUtsRykLgxgHg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIOSOG/8lTPmU9nbvASihx
 0c8VETeLGyY/3dBXcPBu2Gr/J+svrW1jZDjAvLVgOf8rt1Tzddl1OxeumRx0YcJBU4/st5yH+Ms
 UzZkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building bcachefs for 32-bit ARM, there is a compiler warning in
bch2_bucket_gens_invalid() due to use of an incorrect format specifier:

  fs/bcachefs/alloc_background.c:530:10: error: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
    529 |                 prt_printf(err, "bad val size (%lu != %zu)",
        |                                                ~~~
        |                                                %zu
    530 |                        bkey_val_bytes(k.k), sizeof(struct bch_bucket_gens));
        |                        ^~~~~~~~~~~~~~~~~~~
  fs/bcachefs/util.h:223:54: note: expanded from macro 'prt_printf'
    223 | #define prt_printf(_out, ...)           bch2_prt_printf(_out, __VA_ARGS__)
        |                                                               ^~~~~~~~~~~

On 64-bit architectures, size_t is 'unsigned long', so there is no
warning when using %lu but on 32-bit architectures, size_t is 'unsigned
int'. Use '%zu', the format specifier for 'size_t', to eliminate the
warning.

Fixes: 4be0d766a7e9 ("bcachefs: bucket_gens btree")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/bcachefs/alloc_background.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index 67e73864823c..2b0d155d1ed5 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -526,7 +526,7 @@ int bch2_bucket_gens_invalid(const struct bch_fs *c, struct bkey_s_c k,
 			     struct printbuf *err)
 {
 	if (bkey_val_bytes(k.k) != sizeof(struct bch_bucket_gens)) {
-		prt_printf(err, "bad val size (%lu != %zu)",
+		prt_printf(err, "bad val size (%zu != %zu)",
 		       bkey_val_bytes(k.k), sizeof(struct bch_bucket_gens));
 		return -BCH_ERR_invalid_bkey;
 	}

-- 
2.42.0

