Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72F37C5635
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346977AbjJKODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjJKOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:02:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882FB8;
        Wed, 11 Oct 2023 07:02:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57007C433CD;
        Wed, 11 Oct 2023 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032978;
        bh=5o5h5CgRG4H4Z5qjk2eknSticE7hPec++pW0EBNapec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWVOdK03/KwWJmBcC+LI8aDOa3bDpFqUIrBwFqpe3tZwQOVJvD85Tb918ZCwLvjcA
         p/PH9RLQoG3abHY/EYhuW9aidUAbgTHvt6tog9Uy4YkANKUd5IPWNe1UR8qUurGJqh
         HsDWm/uH4U3VLAlOQBnhd5o3rrbPx5xi6r14OdqH0wGjXlcmiIHMNWZg1oBLCPk2/E
         GQZFYEobq+8Wg/9NDW0IQShbNuJGpaNJEc165SF06oH1XzBMmxoWKeQzrJnTHN2Wn4
         yRKDcjwL1+lJkuL7r8x3q4mg4FnQRjKCK+GdP/uAvpflLOFGQG7DLaBmusEtZbGWLb
         w6MmltWuXESBQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 03/10] ethernet: sp7021: fix ioctl callback pointer
Date:   Wed, 11 Oct 2023 16:02:18 +0200
Message-Id: <20231011140225.253106-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011140225.253106-1-arnd@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
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

The old .ndo_do_ioctl() callback is never called any more, instead the
driver should set .ndo_eth_ioctl() for the phy operations.

Fixes: fd3040b9394c5 ("net: ethernet: Add driver for Sunplus SP7021")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/sunplus/spl2sw_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 391a1bc7f4463..bb4514f4e8157 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -199,7 +199,7 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_start_xmit = spl2sw_ethernet_start_xmit,
 	.ndo_set_rx_mode = spl2sw_ethernet_set_rx_mode,
 	.ndo_set_mac_address = spl2sw_ethernet_set_mac_address,
-	.ndo_do_ioctl = phy_do_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl,
 	.ndo_tx_timeout = spl2sw_ethernet_tx_timeout,
 };
 
-- 
2.39.2

