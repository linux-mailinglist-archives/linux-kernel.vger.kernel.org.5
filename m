Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA347F4B16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbjKVPiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344676AbjKVPib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:38:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172413870;
        Wed, 22 Nov 2023 07:36:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835F3C433C8;
        Wed, 22 Nov 2023 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667384;
        bh=vg0gZW/kYHaGlq1b3En8GtKgeQNXg5LaC5m+cMKTlFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCYx48eTfVjy918Oemhj5cdjRiVaxcJyjlcgAmw8PxGcYKY45AExRINI8Y2Pdw6UW
         X4eJk1lysmT8KKyf/0vLPfJZkqgKcPaAmbj1bIHsS5w76UyjoDk5YaLNMB0ZlYDZpS
         armnvfj2zqmszGPqVA3t6jMLsbKPWoD6136lEI6GF+8Vmywm0gFfWnMD7SflxiR2JQ
         /RaGD6rYDnp0GbCobCpoArCRxdIHPx8Nx/q/fGnQDeNqAvZOUMdOvWaVR7NRoAsrYV
         kWgTkkKCB1E4Zx/tKIJJocIlxI4KFT88kafPLT21gml0a8kzZisbrPZhWDqTHyAFyN
         8xhShI6MXoqfQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Pakhunov <alexey.pakhunov@spacex.com>,
        Vincent Wong <vincent.wong2@spacex.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, mchan@broadcom.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/6] tg3: Increment tx_dropped in tg3_tso_bug()
Date:   Wed, 22 Nov 2023 10:36:03 -0500
Message-ID: <20231122153610.853350-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153610.853350-1-sashal@kernel.org>
References: <20231122153610.853350-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.261
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

[ Upstream commit 17dd5efe5f36a96bd78012594fabe21efb01186b ]

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremented accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20231113182350.37472-2-alexey.pakhunov@spacex.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index fb2543b6cec10..4cfb0d0ee80cc 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7896,8 +7896,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	do {
 		nskb = segs;
-- 
2.42.0

