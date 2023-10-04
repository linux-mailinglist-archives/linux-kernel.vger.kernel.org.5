Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A668E7B8282
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbjJDOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjJDOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:38:55 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9BDC0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:38:49 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 514B1102397;
        Wed,  4 Oct 2023 17:38:45 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 4BB9D102395;
        Wed,  4 Oct 2023 17:38:00 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 394Ebxp3003157;
        Wed, 4 Oct 2023 17:37:59 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] wifi: mac80211: fix buffer overflow in ieee80211_rx_get_bigtk()
Date:   Wed,  4 Oct 2023 17:37:40 +0300
Message-Id: <20231004143740.40933-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20231004 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'idx' is 0, then 'idx2' is -1, and arrays 
will be accessed by a negative index. 

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 net/mac80211/rx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e751cda5eef6..e686380434bd 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1868,10 +1868,13 @@ ieee80211_rx_get_bigtk(struct ieee80211_rx_data *rx, int idx)
 		key = rcu_dereference(rx->link_sta->gtk[idx]);
 	if (!key)
 		key = rcu_dereference(rx->link->gtk[idx]);
-	if (!key && rx->link_sta)
-		key = rcu_dereference(rx->link_sta->gtk[idx2]);
-	if (!key)
-		key = rcu_dereference(rx->link->gtk[idx2]);
+
+	if (idx2 >= 0) {
+		if (!key && rx->link_sta)
+			key = rcu_dereference(rx->link_sta->gtk[idx2]);
+		if (!key)
+			key = rcu_dereference(rx->link->gtk[idx2]);
+	}
 
 	return key;
 }
-- 
2.30.2

