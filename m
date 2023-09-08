Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F498798CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbjIHSSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbjIHSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:17:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1611FE5;
        Fri,  8 Sep 2023 11:17:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F90AC116B8;
        Fri,  8 Sep 2023 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196895;
        bh=XODDTN7vRoEHOpmYQf6ue9p4+3JcrLCDM534vfS8aVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgTHOXA1zBTbnXyNaOJp+AVu9/oGkmiRsX5L5GEK5eblOFJINu1DVDZyQRTh7jN+S
         NvTbq3WM9lmJEFTTeJhghQ2Bruhpv2n1S74cA5axEXhaeuQ1g3i+f2Sbv9wFI3uyMe
         7fsNnui0IwGh3B5wAqrSQlar7YyOBryY14gSkBn5eYILfO04qjbtg7PnRQ6862k13G
         dB942sOI1ojUo2YWMjcvoVutznCwWvezhKNM2snPSFpuF0h0c3ZuXYqymaSOslDUKL
         R1UgK3+qbt1u7WWl9WA8liXusvNFNn7bVDR3QHww0nDRgh0lMLQVJZc6JrspcLgh2O
         G6YEdnaZ6f7ug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>, GONG@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, chris.snook@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 30/45] alx: fix OOB-read compiler warning
Date:   Fri,  8 Sep 2023 14:13:11 -0400
Message-Id: <20230908181327.3459042-30-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

[ Upstream commit 3a198c95c95da10ad844cbeade2fe40bdf14c411 ]

The following message shows up when compiling with W=1:

In function ‘fortify_memcpy_chk’,
    inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |    __read_overflow2_field(q_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to get alx stats altogether, alx_get_ethtool_stats() reads
beyond hw->stats.rx_ok. Fix this warning by directly copying hw->stats,
and refactor the unnecessarily complicated BUILD_BUG_ON btw.

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230821013218.1614265-1-gongruiqi@huaweicloud.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/alx/ethtool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index b716adacd8159..7f6b69a523676 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -292,9 +292,8 @@ static void alx_get_ethtool_stats(struct net_device *netdev,
 	spin_lock(&alx->stats_lock);
 
 	alx_update_hw_stats(hw);
-	BUILD_BUG_ON(sizeof(hw->stats) - offsetof(struct alx_hw_stats, rx_ok) <
-		     ALX_NUM_STATS * sizeof(u64));
-	memcpy(data, &hw->stats.rx_ok, ALX_NUM_STATS * sizeof(u64));
+	BUILD_BUG_ON(sizeof(hw->stats) != ALX_NUM_STATS * sizeof(u64));
+	memcpy(data, &hw->stats, sizeof(hw->stats));
 
 	spin_unlock(&alx->stats_lock);
 }
-- 
2.40.1

