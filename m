Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F027C564C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbjJKODl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347061AbjJKODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:03:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751AAE5;
        Wed, 11 Oct 2023 07:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4D7C433CB;
        Wed, 11 Oct 2023 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032996;
        bh=N/HC4aN9VSOyAziYJUcabvcvg/4uj3ZeRvuFPX72uUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OURP0UMv6EgweTj0Rs590/LwjwTau2qo9h2IdP8oq7Lq97yicqRuDZrF8QR8zOpJk
         760QbfnousJd7q2sYcoh8cs6PFw3zNVsgoUIOTx3Zx2zTjjaaqvPaybtMOJkUNXrzm
         0bDPxJVsdOR3EEWDtJ3886RKmBArz3CXm7mTt1Yz61ImKQFzd7/gpiJ5p9rdsdvWDy
         LefCqIwwWMwFNXs0pOid5iOLu8WkDXpiMdJYDc20wkEQOKD4o0HEvjFOx3EG3iieDZ
         eRHRPoh8uTfdVGjsxjN663MzrRwnyjNZZwq6Pv4R0Q1fbkxM1scmh7UZlQ7m20Z9vA
         J7gwh9KhoByEA==
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
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v2 08/10] wifi: atmel: remove unused ioctl function
Date:   Wed, 11 Oct 2023 16:02:23 +0200
Message-Id: <20231011140225.253106-8-arnd@kernel.org>
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

This function has no callers, and for the past 20 years, the request_firmware
interface has been in place instead of the custom firmware loader.

Acked-by: Kalle Valo <kvalo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/wireless/atmel/atmel.c | 72 --------------------------
 1 file changed, 72 deletions(-)

diff --git a/drivers/staging/wireless/atmel/atmel.c b/drivers/staging/wireless/atmel/atmel.c
index 7c2d1c588156d..461dce21de2b0 100644
--- a/drivers/staging/wireless/atmel/atmel.c
+++ b/drivers/staging/wireless/atmel/atmel.c
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

