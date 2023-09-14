Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5011A79F95B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjINEF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjINEFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:05:24 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 441A81FD0;
        Wed, 13 Sep 2023 21:05:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4C3C2606080EF;
        Thu, 14 Sep 2023 12:05:11 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH wireless-next 5/9] ath6kl: remove unnecessary (void*) conversions
Date:   Thu, 14 Sep 2023 12:05:10 +0800
Message-Id: <20230914040510.1169941-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void *) to (struct ath6kl *) or
(struct ath6kl_cookie *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/ath/ath6kl/main.c | 4 ++--
 drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/ath/ath6kl/main.c
index d3aa9e7a37c2..8f9fe23e9755 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -852,14 +852,14 @@ void ath6kl_tgt_stats_event(struct ath6kl_vif *vif, u8 *ptr, u32 len)
 
 void ath6kl_wakeup_event(void *dev)
 {
-	struct ath6kl *ar = (struct ath6kl *) dev;
+	struct ath6kl *ar = dev;
 
 	wake_up(&ar->event_wq);
 }
 
 void ath6kl_txpwr_rx_evt(void *devt, u8 tx_pwr)
 {
-	struct ath6kl *ar = (struct ath6kl *) devt;
+	struct ath6kl *ar = devt;
 
 	ar->tx_pwr = tx_pwr;
 	wake_up(&ar->event_wq);
diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index a56fab6232a9..80e66acc5cf6 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -708,7 +708,7 @@ void ath6kl_tx_complete(struct htc_target *target,
 				 packet->endpoint >= ENDPOINT_MAX))
 			continue;
 
-		ath6kl_cookie = (struct ath6kl_cookie *)packet->pkt_cntxt;
+		ath6kl_cookie = packet->pkt_cntxt;
 		if (WARN_ON_ONCE(!ath6kl_cookie))
 			continue;
 
-- 
2.30.2

