Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE545803F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjLDUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjLDUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:33:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB37129
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:33:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8362C433D9;
        Mon,  4 Dec 2023 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722026;
        bh=AIeWwXRelijdVQAE+IrIDAn5zmzSCs+pcDzGtmCLkS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezGADa6moBp/Mjbkoq6S2YDpnmoO1e+hu5Nyk6XZafZY42vQBEglGFecM6E3Hnp7Z
         ulmet4vFbbJmrsSfEvM3K4hP08cFO4MYD4Vhz6Bwcttpc7dyaZEDeqfjm4Cx3M7FT1
         J5MKSxzCvUjTvWuGlgOETm4TWgiiPGHb2zZW6p6qKMqlVP1msevxGN7jUyiWs3c402
         Ep7ISMkIQ+hy7Ev0iuABANehaotR35zCm7f8NXLgvWD5GJ3KjNG+2eAEwN+a4ZdR2o
         BlnRLRZ9D/0nWBQGSYAeEJh+7F3+EVGO3zoQ4h2dnwhxCifmUENKrjgzK1jW+eBAPu
         mukzFbjEXdkQw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/32] wifi: cfg80211: lock wiphy mutex for rfkill poll
Date:   Mon,  4 Dec 2023 15:32:31 -0500
Message-ID: <20231204203317.2092321-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8e2f6f2366219b3304b227bdd2f04b64c92e3e12 ]

We want to guarantee the mutex is held for pretty much
all operations, so ensure that here as well.

Reported-by: syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 563cfbe3237c9..f6ada0a729778 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -221,7 +221,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
+	wiphy_lock(&rdev->wiphy);
 	rdev_rfkill_poll(rdev);
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
-- 
2.42.0

