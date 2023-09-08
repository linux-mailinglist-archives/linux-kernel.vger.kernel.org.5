Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469C7798D48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbjIHSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbjIHSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CCB2D41;
        Fri,  8 Sep 2023 11:18:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A223C4AF5E;
        Fri,  8 Sep 2023 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197042;
        bh=pnplm/+s8y0FwPjjHZzVh9XvGP9O9nXGhoDsgPwUWmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ1HqgOXgb6RRmBT1ruhQfLYGUO8c8tbAvF3co3Sj8KqC4MK+8YM7XiBBV+qiwHzB
         kgt8qLM5Y/dWNSjU8SagEwl0odaByxLFkKTT5ToBaSehNhVsl5Xku6f3va4ezNvPw1
         ghZmZ0ml6KkLscVdDf4+aVpKKdeNp/XKL/4TnwgyrYuc3UUDFAkkwp9LfnbYyz53Do
         c85cgyTncedfiEphQwUeuP0fK5Nuh/GD8Kxn8pRxx4I8YRB4AoHiR5wV7lRjsJhMLh
         wr+dfsbW2O6b9ArsaVV+KugaS4Gkw4uYbs63WFQoBxfae/CzuBDKVZQ8KjiOrb++GW
         K9KKoADarI+cw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+999fac712d84878a7379@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 33/41] wifi: mac80211: check for station first in client probe
Date:   Fri,  8 Sep 2023 14:15:47 -0400
Message-Id: <20230908181555.3459640-33-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 67dfa589aa8806c7959cbca2f4613b8d41c75a06 ]

When probing a client, first check if we have it, and then
check for the channel context, otherwise you can trigger
the warning there easily by probing when the AP isn't even
started yet. Since a client existing means the AP is also
operating, we can then keep the warning.

Also simplify the moved code a bit.

Reported-by: syzbot+999fac712d84878a7379@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f2d08dbccfb7d..5360876e6541a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4128,19 +4128,20 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	mutex_lock(&local->mtx);
 
 	rcu_read_lock();
+	sta = sta_info_get_bss(sdata, peer);
+	if (!sta) {
+		ret = -ENOLINK;
+		goto unlock;
+	}
+
+	qos = sta->sta.wme;
+
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
 	band = chanctx_conf->def.chan->band;
-	sta = sta_info_get_bss(sdata, peer);
-	if (sta) {
-		qos = sta->sta.wme;
-	} else {
-		ret = -ENOLINK;
-		goto unlock;
-	}
 
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-- 
2.40.1

