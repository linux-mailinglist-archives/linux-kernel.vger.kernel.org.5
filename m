Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8EF7A2571
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjIOSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjIOSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:17:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79071FCC;
        Fri, 15 Sep 2023 11:16:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC75C433C7;
        Fri, 15 Sep 2023 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694801815;
        bh=QQqUp4XKgQyXwHPRMB+70AKUDzS82qjfk8gBWWVgGI4=;
        h=Date:From:To:Cc:Subject:From;
        b=Yq79jB3G8IBEwWWnWZobdn6Dv325x+kOyUwQrhwpzktHSyJ6HHrnRXQHYvmOYWOPh
         gT0e2oKdogaJYnAlSYqFv5zYbSKiPsiSftkYHjSjGR+pjxGaNk7hZKn56zH3bOCSFx
         JSEh05iC5fyiG4U1VIs7g7UMiazvSKY+Vyf4Ax2XMU5/IZPk03/phNT7y+qEvMjTmH
         yT8AEElu4D1porsU9LKGu82QC3nQEL/EYaqMnvQPmRoqBhWKP/293HMA/nYqQqRnaV
         Lq6hPhMYaIGNt04csavSvpsgSl505s4DlcNVdiVeR1n7j6s2fIwFuOB9CpyRMFpWKI
         XtKv0BUO7E/xQ==
Date:   Fri, 15 Sep 2023 12:17:49 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] gve: Use size_add() in call to struct_size()
Message-ID: <ZQSfze9HgfLDkFPV@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
protection that struct_size() adds against potential integer overflows
is defeated. Fix this by hardening call to struct_size() with size_add().

Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5704b5f57cd0..83b09dcfafc4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -190,7 +190,7 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
 		       priv->rx_cfg.num_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
-					     tx_stats_num + rx_stats_num);
+					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
 		dma_alloc_coherent(&priv->pdev->dev, priv->stats_report_len,
 				   &priv->stats_report_bus, GFP_KERNEL);
-- 
2.34.1

