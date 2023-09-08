Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78C798D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbjIHSUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbjIHSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA3268E;
        Fri,  8 Sep 2023 11:18:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46387C116D4;
        Fri,  8 Sep 2023 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196910;
        bh=4HKDkTtC4tOIWsd2cApCbbBMtlwvL78yXaFUdzme9NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkSZjNTLjqzPwyE65J50JBK7sFAnyMsr0QvUM/iUT58eSS6pQkSjgIA8ka36xlWLa
         MHCpqXex9uKmleMaxxtlXH3fWv8WkiczIcRj502pWIoQoWIRQbfssJr9x3IeM3CF+8
         osw4Us5HggeHBgYnZfVpEG9cJqmLq28Fd05ujzTIJCFu/jxh8T2miB553yDtjhWgFm
         lnJv2Z1QIVe4ymXj6KmqebMJQcF7u+n1R6pNe1QPShzUJjTA6D7+41rCK7pjDiAlbD
         h+0eCX5IYzJFCSXMJVw22EHHhZJOhPrEFx3RODwJ+sQM8UIU26NzwOQPguGKF/lhL7
         cA4LrYo0HGNng==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+999fac712d84878a7379@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 36/45] wifi: mac80211: check for station first in client probe
Date:   Fri,  8 Sep 2023 14:13:17 -0400
Message-Id: <20230908181327.3459042-36-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
index e7ac246038925..953f24166ffcf 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4133,19 +4133,20 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
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

