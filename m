Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8973F804048
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjLDUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjLDUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:40:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54619A0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:37:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36590C433C7;
        Mon,  4 Dec 2023 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722258;
        bh=jQ+D2iihSTK+aKrxjtXFfBlStzbtYXPCbVhBZbnb9bo=;
        h=From:To:Cc:Subject:Date:From;
        b=DseyW8QAj8aBxawwdrp9SofXXecA8Ygo5O4qtDnMWwuRwSEe9rB/ijhcuV7WQjvln
         xOHvc/2NSucx+ZLy/+tEdSi6CZLZCR1Cck++tsFWO+B1drwszqOYlhUEVAwm172HeI
         9hTTGHzBD0fBqnFqhni0ZPzwtoNGdOY0gpT2Acy+rKehTuYrqD9YoYp1L/vxcTl1R6
         +L1wivZ2fmpPuHL6xV2JPSoq3ZlcTu9f7rq96rBbtoP/ghJXZc3HFhL46kYWrJC8WB
         CWMwNwukU9GQjDhDpZFRT7WROOtHOq9Pjcr0ptGjCnXVnQaiFqAUPMmFtz9kNVhMMh
         M5olsi8q9zz4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14] wifi: cfg80211: lock wiphy mutex for rfkill poll
Date:   Mon,  4 Dec 2023 15:37:34 -0500
Message-ID: <20231204203735.2095033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.331
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
index 0e08629b15d1d..abe7912a23760 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -202,7 +202,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
+	wiphy_lock(&rdev->wiphy);
 	rdev_rfkill_poll(rdev);
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
-- 
2.42.0

