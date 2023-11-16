Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA97EDF35
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjKPLJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345078AbjKPLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:09:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81727187;
        Thu, 16 Nov 2023 03:09:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A14DC433C8;
        Thu, 16 Nov 2023 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700132983;
        bh=YLOPG/dfau4Y6nKS1EnNrpTxtMUZK5zJEUgptsdiajY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9wTzMrqJhMqM+fxK6gMrs7lkzOVG5DVhq+4nI6SQ2Znaw5iIzJfsEntvyprofL7O
         6F81ebZVs0xifRuWxUuh3EqqajNulv8u6bND0xFoNH2vP3VmDDMtHiOaPVsYUReCZc
         3cEpAtAd86/tBozdwxUKYoucWHXUxF5uS5gTKsxo9FpBTLhSB4Qf0eQK93nj3LATzO
         8sMt5MUihEHysXhXcm22k479GrB1rLu5C0MGJnua1DxujuMJPOr/lTu78HaM5DdA3q
         7dSXJvUmTagSjQlLpLLI4wYvVks3NaxZvUWWnuT2trVS9TrMWi7yINrx49H2w8Bo7u
         zig2Tn3+/cP/Q==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH net 1/2] net: ti: am65-cpsw-nuss: Fix devlink warning on module removal
Date:   Thu, 16 Nov 2023 13:09:29 +0200
Message-Id: <20231116110930.36244-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116110930.36244-1-rogerq@kernel.org>
References: <20231116110930.36244-1-rogerq@kernel.org>
MIME-Version: 1.0
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

devlink_port_unregister() should be called after unregister_netdev()
so that the devlink_port->type is set to DEVLINK_PORT_TYPE_NOTSET
and avoids the below warning.

[   48.511030] WARNING: CPU: 2 PID: 683 at net/devlink/port.c:1077 devl_port_unregister+0x80/0xa8

CC: stable@vger.kernel.org # v6.6+
Fixes: 58356eb31d60 ("net: ti: am65-cpsw-nuss: Add devlink support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ece9f8df98ae..cbbede094b2c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3011,13 +3011,13 @@ static int am65_cpsw_nuss_remove(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_unregister_notifiers(common);
 
 	/* must unregister ndevs here because DD release_driver routine calls
 	 * dma_deconfigure(dev) before devres_release_all(dev)
 	 */
 	am65_cpsw_nuss_cleanup_ndev(common);
+	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 	am65_cpsw_disable_serdes_phy(common);
-- 
2.34.1

