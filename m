Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C540777839
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjHJMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjHJMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1EE54
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32CB7615F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78B0C433C8;
        Thu, 10 Aug 2023 12:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691670334;
        bh=1f1uo4HhIlgH6LQc+YKtqnOOYeuciSTPT0zrCjcnXio=;
        h=From:To:Cc:Subject:Date:From;
        b=AerNdbBBddvE2On+cYp4dMdrRdmJXjHtrNolxFfAV6vrZ2QzZ1qT0twkSqjmM23yC
         K5fy8gieyWVpD5iQoxXB0jSUKvbzzKe9BORAnv0WHXgirr0mUJKYdAeEkBbkEw2WhR
         27HVE3jF6a/HaNxFGrLK5dR6KsuhFT/ecpVn2QgZTW9fCLPO7DCRTggzjdq9fBTR48
         BzvpjUAJ5KcEs5Gmgyc1Z9Kn3Yy05orERx1bhHepK0A18Jo3rXnoMVktfxTLjNCFjr
         ZhSdNpD3GJBtyvtMtgL2G5/ffwXQso5G+mFSH92Rcw5LObLD7JEvwFrfHQPjzR8WNO
         3h4ggjR0pZfaQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
        Petr Machata <petrm@nvidia.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liang He <windhl@126.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ethernet: ldmvsw: mark ldmvsw_open() static
Date:   Thu, 10 Aug 2023 14:25:15 +0200
Message-Id: <20230810122528.1220434-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The function is exported for no reason and should just be static:

drivers/net/ethernet/sun/ldmvsw.c:127:5: error: no previous prototype for 'ldmvsw_open' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/sun/ldmvsw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index 734a817d3c945..a9a6670b5ff1f 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -124,7 +124,7 @@ static void vsw_set_rx_mode(struct net_device *dev)
 	return sunvnet_set_rx_mode_common(dev, port->vp);
 }
 
-int ldmvsw_open(struct net_device *dev)
+static int ldmvsw_open(struct net_device *dev)
 {
 	struct vnet_port *port = netdev_priv(dev);
 	struct vio_driver_state *vio = &port->vio;
@@ -136,7 +136,6 @@ int ldmvsw_open(struct net_device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ldmvsw_open);
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void vsw_poll_controller(struct net_device *dev)
-- 
2.39.2

