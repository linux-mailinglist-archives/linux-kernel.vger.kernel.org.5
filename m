Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBB7A2708
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjIOTPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbjIOTPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:15:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE0E71;
        Fri, 15 Sep 2023 12:15:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808E2C433C8;
        Fri, 15 Sep 2023 19:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694805332;
        bh=EjITR0LTMcwMw0imCdzNOKP5+uLwNDiESLPjL0Q70yw=;
        h=Date:From:To:Cc:Subject:From;
        b=uWorQgmu/yJeK1Dvl8+PoM6hv0t5BrzSm+PzI2M7AijSa+s+nBO7dWUQ3TzF3PHBO
         oKCWtE7f1MwPZbn0aquWNvRMk5FO7mPRMSFueVXwo0DBK+K4HMvr4zCTVNB05kPFSB
         rvjIzweCakLZF9D/zbkAtl99ZXb1Z6Hmx29kPNGwUVlEGtKNdV+u9N6NqlSaQeSCRD
         oh7q9DTilSMWYfq6iyL5yoD/qhpNh6ejPed472lmtV5q5QMtlnzzooZSgeZ/R5Uy4o
         1glkXDvBhEpm1psOddSxPuyQef+Uz1sW4/IoLlVEk1P7QhVX4CgoMn9XxrmInVFk5p
         K29FGRVjID9jQ==
Date:   Fri, 15 Sep 2023 13:16:26 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] tipc: Use size_add() in calls to struct_size()
Message-ID: <ZQStiorAZPgfMMZD@work>
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

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: e034c6d23bc4 ("tipc: Use struct_size() helper")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/tipc/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index e33b4f29f77c..d0143823658d 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1446,7 +1446,7 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
 		sz = ntohs(p->len);
 		/* Sanity check */
-		if (sz == struct_size(p, gacks, p->ugack_cnt + p->bgack_cnt)) {
+		if (sz == struct_size(p, gacks, size_add(p->ugack_cnt, p->bgack_cnt))) {
 			/* Good, check if the desired type exists */
 			if ((uc && p->ugack_cnt) || (!uc && p->bgack_cnt))
 				goto ok;
@@ -1533,7 +1533,7 @@ static u16 tipc_build_gap_ack_blks(struct tipc_link *l, struct tipc_msg *hdr)
 			__tipc_build_gap_ack_blks(ga, l, ga->bgack_cnt) : 0;
 
 	/* Total len */
-	len = struct_size(ga, gacks, ga->bgack_cnt + ga->ugack_cnt);
+	len = struct_size(ga, gacks, size_add(ga->bgack_cnt, ga->ugack_cnt));
 	ga->len = htons(len);
 	return len;
 }
-- 
2.34.1

