Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E778F986
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348585AbjIAIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjIAIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:09:50 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D539CC;
        Fri,  1 Sep 2023 01:09:47 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 381875mt005504-381875mu005504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 1 Sep 2023 16:07:10 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath9k: fix null-ptr-deref in ath_chanctx_event
Date:   Fri,  1 Sep 2023 16:07:00 +0800
Message-Id: <20230901080701.1705649-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

ath_chanctx_event() error: we previously assumed 'vif' could be null

The function ath_chanctx_event can be called with vif argument as NULL.
If vif is NULL, ath_dbg can trigger a null pointer dereference.

Fix this by adding a null pointer check.

Fixes: 878066e745b5 ("ath9k: Add more debug statements for channel context")
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/net/wireless/ath/ath9k/channel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
index 571062f2e82a..e343c8962d14 100644
--- a/drivers/net/wireless/ath/ath9k/channel.c
+++ b/drivers/net/wireless/ath/ath9k/channel.c
@@ -576,7 +576,9 @@ void ath_chanctx_event(struct ath_softc *sc, struct ieee80211_vif *vif,
 		if (sc->sched.state != ATH_CHANCTX_STATE_WAIT_FOR_BEACON)
 			break;
 
-		ath_dbg(common, CHAN_CTX, "Preparing beacon for vif: %pM\n", vif->addr);
+		if (vif)
+			ath_dbg(common, CHAN_CTX,
+				"Preparing beacon for vif: %pM\n", vif->addr);
 
 		sc->sched.beacon_pending = true;
 		sc->sched.next_tbtt = REG_READ(ah, AR_NEXT_TBTT_TIMER);
-- 
2.39.2

