Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B20798D2F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbjIHSU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344134AbjIHSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E54268C;
        Fri,  8 Sep 2023 11:18:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA25BC116CB;
        Fri,  8 Sep 2023 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196901;
        bh=etr5nO4R+vHEYa++IHNZ0E9/ZO5rmMXZRBBrn74Gy7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OIzYIXbJWO1azP/yzsPMUmk8JRTCEG8LqlaIRA7MJkgFgI+aGqoIARXofm7Bv1HZi
         jopJklz37nNE/ffdi0vZKjd5zfMlFnwGzytY1Xb8L8Q0Luv1yPlomSelMV4iA3eFQV
         j5rSDJ3Rs22KPWNTw3JYhASnMok9PBNp9i/MgSOZQlmHKfSCGc9Hqis+1kXdI00j5c
         XgFVSZ4vJgAHZY9NTUJy7M1nDSHYu71nRDfTbcbpczV0W76cUdr6kDRJqgP7+gTp30
         txm73ltxZKnNc5/PFuiDCKUSfsi5uIMwtRdlseboYVgEhULOemCFiXuuSBL9egM9VR
         LNpVbNibpVwxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 32/45] wifi: mac80211: check S1G action frame size
Date:   Fri,  8 Sep 2023 14:13:13 -0400
Message-Id: <20230908181327.3459042-32-sashal@kernel.org>
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

[ Upstream commit 19e4a47ee74718a22e963e8a647c8c3bfe8bb05c ]

Before checking the action code, check that it even
exists in the frame.

Reported-by: syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0af2599c17e8d..e751cda5eef69 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3734,6 +3734,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		goto queue;
 	case WLAN_CATEGORY_S1G:
+		if (len < offsetofend(typeof(*mgmt),
+				      u.action.u.s1g.action_code))
+			break;
+
 		switch (mgmt->u.action.u.s1g.action_code) {
 		case WLAN_S1G_TWT_SETUP:
 		case WLAN_S1G_TWT_TEARDOWN:
-- 
2.40.1

