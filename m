Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5627BE282
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377738AbjJIOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377625AbjJIOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:20:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C3012F;
        Mon,  9 Oct 2023 07:19:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C06C433CB;
        Mon,  9 Oct 2023 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696861188;
        bh=uIetETPPrykhUwCU+wNE8TYqMLdodxCmAIxFTLTQD4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dI+wMpCmEzQ6ifPAcGYZY/rDE8eZjKiUQ4hbb9jIo6GMBLAJyJP/8L2kXbuYTWxeB
         HS7p3mmUcvO1e8r5wiOMb65k/FNrE3pIzfkRlnzE1hhu5LEg0dKmFInicSsBTZJGEY
         4WM0q5FBBUL1S52l+0zysSIqaw3FeLUSonoVU5JkdZjPoxYhJgVNlb3PMKjw+4awEI
         UMfE16g9kHjpTk+Z9fHndo1qdblvWWyr6Irwk1WUSULM/G5j+9sbRKNxUekjDDUvv7
         EBUMH13/aeYkpqtOswSfIurlJjbdJZmpexrl60FL63MWXNAkQ+kcmhXJyouM09+pym
         5qKWggXhV15cA==
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
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/10] wireless: atmel: remove unused ioctl function
Date:   Mon,  9 Oct 2023 16:19:06 +0200
Message-Id: <20231009141908.1767241-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009141908.1767241-1-arnd@kernel.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function has no callers, and for the past 20 years, the request_firmware
interface has been in place instead of the custom firmware loader.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/atmel/atmel.c | 72 ------------------------------
 1 file changed, 72 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 7c2d1c588156d..461dce21de2b0 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -571,7 +571,6 @@ static const struct {
 		      { REG_DOMAIN_ISRAEL, 3, 9, "Israel"} };
 
 static void build_wpa_mib(struct atmel_private *priv);
-static int atmel_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void atmel_copy_to_card(struct net_device *dev, u16 dest,
 			       const unsigned char *src, u16 len);
 static void atmel_copy_to_host(struct net_device *dev, unsigned char *dest,
@@ -1487,7 +1486,6 @@ static const struct net_device_ops atmel_netdev_ops = {
 	.ndo_stop		= atmel_close,
 	.ndo_set_mac_address 	= atmel_set_mac_address,
 	.ndo_start_xmit 	= start_tx,
-	.ndo_do_ioctl 		= atmel_ioctl,
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
@@ -2616,76 +2614,6 @@ static const struct iw_handler_def atmel_handler_def = {
 	.get_wireless_stats = atmel_get_wireless_stats
 };
 
-static int atmel_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	int i, rc = 0;
-	struct atmel_private *priv = netdev_priv(dev);
-	struct atmel_priv_ioctl com;
-	struct iwreq *wrq = (struct iwreq *) rq;
-	unsigned char *new_firmware;
-	char domain[REGDOMAINSZ + 1];
-
-	switch (cmd) {
-	case ATMELIDIFC:
-		wrq->u.param.value = ATMELMAGIC;
-		break;
-
-	case ATMELFWL:
-		if (copy_from_user(&com, rq->ifr_data, sizeof(com))) {
-			rc = -EFAULT;
-			break;
-		}
-
-		if (!capable(CAP_NET_ADMIN)) {
-			rc = -EPERM;
-			break;
-		}
-
-		new_firmware = memdup_user(com.data, com.len);
-		if (IS_ERR(new_firmware)) {
-			rc = PTR_ERR(new_firmware);
-			break;
-		}
-
-		kfree(priv->firmware);
-
-		priv->firmware = new_firmware;
-		priv->firmware_length = com.len;
-		strncpy(priv->firmware_id, com.id, 31);
-		priv->firmware_id[31] = '\0';
-		break;
-
-	case ATMELRD:
-		if (copy_from_user(domain, rq->ifr_data, REGDOMAINSZ)) {
-			rc = -EFAULT;
-			break;
-		}
-
-		if (!capable(CAP_NET_ADMIN)) {
-			rc = -EPERM;
-			break;
-		}
-
-		domain[REGDOMAINSZ] = 0;
-		rc = -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(channel_table); i++) {
-			if (!strcasecmp(channel_table[i].name, domain)) {
-				priv->config_reg_domain = channel_table[i].reg_domain;
-				rc = 0;
-			}
-		}
-
-		if (rc == 0 &&  priv->station_state != STATION_STATE_DOWN)
-			rc = atmel_open(dev);
-		break;
-
-	default:
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
-}
-
 struct auth_body {
 	__le16 alg;
 	__le16 trans_seq;
-- 
2.39.2

