Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80BA7BBA06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjJFOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJFOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:12:54 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB678A6;
        Fri,  6 Oct 2023 07:12:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55C5C1C0012;
        Fri,  6 Oct 2023 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696601568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=agJi0nKF7FOULQsqtdpXdutlZ5f5eTcBhobxYJ95y04=;
        b=OcgiKH3GTtvsfq6zaW1CVNcZt6+/AyeiINmUGtHdnWt5I7aMH0YFCydwd+KdJRebhS3YF3
        CzQ0U5Qzp4MRTjFa1yPiP9VMS591VG9jM1g19DNWzZ/bBB9UEIv0Wxp2HN2SyZWYzyuSxr
        yYzmblz7wnLSDcJIuRV2+OxX+fbx90bWisN2Rr+1xDgXj4wE0f9vu91E8yaABUQi9iGKJ+
        45aqO9ZGQE0YfVlmO7bzAeeccDPi/blNgqNGkuPUsW6hTNNXSFxj5Hq3TgT8XW0jBz8NLE
        iYw5koCOBfMzYi9VvVLScS73uevl2lVNuVOBKto2iXtQXdqL0hfMKFVBgFpvQw==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Simon Horman <horms@kernel.org>,
        Kory Maincent <kory.maincent@bootlin.com>,
        thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2 1/1] ethtool: Fix mod state of verbose no_mask bitset
Date:   Fri,  6 Oct 2023 16:12:46 +0200
Message-Id: <20231006141246.3747944-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

A bitset without mask in a _SET request means we want exactly the bits in
the bitset to be set. This works correctly for compact format but when
verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
bits present in the request bitset but does not clear the rest. The commit
6699170376ab fixes this issue by clearing the whole target bitmap before we
start iterating. The solution proposed brought an issue with the behavior
of the mod variable. As the bitset is always cleared the old val will
always differ to the new val.

Fix it by adding a new temporary variable which save the state of the old
bitmap.

Fixes: 6699170376ab ("ethtool: fix application of verbose no_mask bitset")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Fix the allocated size.
---
 net/ethtool/bitset.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 0515d6604b3b..8a6b35c920cd 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -432,7 +432,9 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 			      struct netlink_ext_ack *extack, bool *mod)
 {
 	struct nlattr *bit_attr;
+	u32 *tmp = NULL;
 	bool no_mask;
+	bool dummy;
 	int rem;
 	int ret;
 
@@ -448,8 +450,16 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 	}
 
 	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
-	if (no_mask)
-		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
+	if (no_mask) {
+		unsigned int nwords = DIV_ROUND_UP(nbits, 32);
+		unsigned int nbytes = nwords * sizeof(u32);
+
+		tmp = kcalloc(nwords, sizeof(u32), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		memcpy(tmp, bitmap, nbytes);
+		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
+	}
 
 	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
 		bool old_val, new_val;
@@ -458,13 +468,19 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		if (nla_type(bit_attr) != ETHTOOL_A_BITSET_BITS_BIT) {
 			NL_SET_ERR_MSG_ATTR(extack, bit_attr,
 					    "only ETHTOOL_A_BITSET_BITS_BIT allowed in ETHTOOL_A_BITSET_BITS");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		ret = ethnl_parse_bit(&idx, &new_val, nbits, bit_attr, no_mask,
 				      names, extack);
 		if (ret < 0)
-			return ret;
-		old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
+			goto out;
+
+		if (no_mask)
+			old_val = tmp[idx / 32] & ((u32)1 << (idx % 32));
+		else
+			old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
+
 		if (new_val != old_val) {
 			if (new_val)
 				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
@@ -474,7 +490,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(tmp);
+	return ret;
 }
 
 static int ethnl_compact_sanity_checks(unsigned int nbits,
-- 
2.25.1

