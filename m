Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7B7E3C75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjKGMQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjKGMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:15:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5846544AD;
        Tue,  7 Nov 2023 04:11:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64839C43395;
        Tue,  7 Nov 2023 12:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359105;
        bh=asByYHsdBksFuI0CrpUpI8UvGIEJQr2ZQy7TgjzrI4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0NRDTfZHt2iuR4CpiG9prrhleGQ0Y4RYu+jweQuMRW45buYtjZTxD2YsymTvTk2a
         5/ok2KT+Dg/GTTTJxGdUvRh9otpke1WhxOzTF2R7t08YV8UTCqggTJpFSMteVmUose
         pSmey9fXxUnjVVlIqZ7siGbaKndsPlPRWOna6xXU+eXK4WDWFhGy930uHcZ+dvHJuN
         O/J/PXQJXEQFnQ5b3pF5lj7NW1gV+V+FUu+z/2kfcPx0I6SC0vyGhOCgs2Hq0geWPg
         JbOgni/vhlzs3mEIqAbTT5rMexvrPNlTNOjx3oPAPQr2lDpeZNNk8odaHwqvmCwLPA
         nMO2arwnBnZow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        kernel test robot <lkp@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        maciej.fijalkowski@intel.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/18] tsnep: Fix tsnep_request_irq() format-overflow warning
Date:   Tue,  7 Nov 2023 07:10:46 -0500
Message-ID: <20231107121104.3757943-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121104.3757943-1-sashal@kernel.org>
References: <20231107121104.3757943-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerhard Engleder <gerhard@engleder-embedded.com>

[ Upstream commit 00e984cb986b31e9313745e51daceaa1e1eb7351 ]

Compiler warns about a possible format-overflow in tsnep_request_irq():
drivers/net/ethernet/engleder/tsnep_main.c:884:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
                         sprintf(queue->name, "%s-rx-%d", name,
                                                       ^
drivers/net/ethernet/engleder/tsnep_main.c:881:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
                         sprintf(queue->name, "%s-tx-%d", name,
                                                       ^
drivers/net/ethernet/engleder/tsnep_main.c:878:49: warning: '-txrx-' directive writing 6 bytes into a region of size between 5 and 25 [-Wformat-overflow=]
                         sprintf(queue->name, "%s-txrx-%d", name,
                                                 ^~~~~~

Actually overflow cannot happen. Name is limited to IFNAMSIZ, because
netdev_name() is called during ndo_open(). queue_index is single char,
because less than 10 queues are supported.

Fix warning with snprintf(). Additionally increase buffer to 32 bytes,
because those 7 additional bytes were unused anyway.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310182028.vmDthIUa-lkp@intel.com/
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20231023183856.58373-1-gerhard@engleder-embedded.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/engleder/tsnep.h      |  2 +-
 drivers/net/ethernet/engleder/tsnep_main.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
index 09a723b827c77..0a0d3d7ba63b3 100644
--- a/drivers/net/ethernet/engleder/tsnep.h
+++ b/drivers/net/ethernet/engleder/tsnep.h
@@ -123,7 +123,7 @@ struct tsnep_rx {
 
 struct tsnep_queue {
 	struct tsnep_adapter *adapter;
-	char name[IFNAMSIZ + 9];
+	char name[IFNAMSIZ + 16];
 
 	struct tsnep_tx *tx;
 	struct tsnep_rx *rx;
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 2be518db04270..c86dfbce787f1 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -973,14 +973,14 @@ static int tsnep_request_irq(struct tsnep_queue *queue, bool first)
 		dev = queue->adapter;
 	} else {
 		if (queue->tx && queue->rx)
-			sprintf(queue->name, "%s-txrx-%d", name,
-				queue->rx->queue_index);
+			snprintf(queue->name, sizeof(queue->name), "%s-txrx-%d",
+				 name, queue->rx->queue_index);
 		else if (queue->tx)
-			sprintf(queue->name, "%s-tx-%d", name,
-				queue->tx->queue_index);
+			snprintf(queue->name, sizeof(queue->name), "%s-tx-%d",
+				 name, queue->tx->queue_index);
 		else
-			sprintf(queue->name, "%s-rx-%d", name,
-				queue->rx->queue_index);
+			snprintf(queue->name, sizeof(queue->name), "%s-rx-%d",
+				 name, queue->rx->queue_index);
 		handler = tsnep_irq_txrx;
 		dev = queue;
 	}
-- 
2.42.0

