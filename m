Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944CE804047
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjLDUlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjLDUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:40:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA2E4689
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:37:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B237C433C8;
        Mon,  4 Dec 2023 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722254;
        bh=nhCeI26hcpW5/oosaG+qmXvejiJHo+d668SX+e0y/Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJ5MawFn7OpPe6Bs/F5pvgicEeGq+oEm4sStLCRAyatiaUoqe1vybgvUhuuHpiPaH
         1pEWC66UgVTrEklBjbxl4BzRRT0jdPoAHgtPfgH8BcMOGqLZ80xpQJFIdNEiMKN9Eg
         0YMzQSswnli195lWGRLR4kraE+jfOICzkD4Dl9XsTokCAVPWd5CNWtZGlSHV8a/dJk
         iOJnColMBcCNczi82dbEKN7sk4/HxwJRWNB4Berqt7u3tvqpWEDT8S2KFJktVWblYd
         D+QqFpGdo9Bbxumee/GiCqw/e934BUqiI8YJyyD5vmgf3XfQIO/oemYWqBck1WH11t
         r4+DLQp/JhZ4g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/3] wifi: cfg80211: lock wiphy mutex for rfkill poll
Date:   Mon,  4 Dec 2023 15:37:20 -0500
Message-ID: <20231204203723.2094942-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203723.2094942-1-sashal@kernel.org>
References: <20231204203723.2094942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.262
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
index f7228afd81ebd..0be87b46c1b33 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -216,7 +216,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
+	wiphy_lock(&rdev->wiphy);
 	rdev_rfkill_poll(rdev);
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
-- 
2.42.0

