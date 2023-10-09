Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757527BE8CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378020AbjJIR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377375AbjJIR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:59:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885EBA;
        Mon,  9 Oct 2023 10:59:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B45C433C9;
        Mon,  9 Oct 2023 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696874387;
        bh=cb2RlVIw4noXeBlWpyiD4YYjxMG+5cCZ+39utZ6p6gM=;
        h=Date:From:To:Cc:Subject:From;
        b=Hj1WIpj0zzjAsMsi1dvVoxdhsRzyggk+NaQPbeJZVWQApNUzsElvGiepI5DBDgPdP
         B2Zifh4pmohGQKkl0aCwoOd9U+hWq2Ykynm6Y/Z+7j8hcOwXIaPoweQU0pRwicOtfI
         QCT+lKR/6/ad2somVn9EedoZEuUE3R5/orMp4Vy6lEeUf721HtK5Y1Ru0EXfDJBoke
         efwg9yl7C/PoVK35hMsgBB3+pqzjvIhJWA0s0T5lbsm0VyRcEVlM+29OPVSG1e37JC
         iem45Bx8weBz/dhHtOZlqinJvMsLxHqf5nRKO12XALOar/3Fyy0ydx8YMpTK6MTa5h
         sKmCrJRNObpkw==
Date:   Mon, 9 Oct 2023 11:59:41 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mac80211: Add __counted_by for struct
 ieee802_11_elems and use struct_size()
Message-ID: <ZSQ/jcmTAf/PKHg/@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure including, of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/util.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e92eaf835ee0..0d3d386445c5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1746,7 +1746,7 @@ struct ieee802_11_elems {
 	 */
 	size_t scratch_len;
 	u8 *scratch_pos;
-	u8 scratch[];
+	u8 scratch[] __counted_by(scratch_len);
 };
 
 static inline struct ieee80211_local *hw_to_local(
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 98a3bffc6991..a91b0e7795a4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1612,7 +1612,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	int nontransmitted_profile_len = 0;
 	size_t scratch_len = 3 * params->len;
 
-	elems = kzalloc(sizeof(*elems) + scratch_len, GFP_ATOMIC);
+	elems = kzalloc(struct_size(elems, scratch, scratch_len), GFP_ATOMIC);
 	if (!elems)
 		return NULL;
 	elems->ie_start = params->start;
-- 
2.34.1

