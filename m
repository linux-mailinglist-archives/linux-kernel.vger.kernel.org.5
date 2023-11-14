Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101327EAF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjKNLak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjKNL3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:49 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292AF1985;
        Tue, 14 Nov 2023 03:29:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B88B46000E;
        Tue, 14 Nov 2023 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699961347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnH2ZHMI5dsTwImD1KGet0qz4ilreT1GWjYY2D79LCc=;
        b=JZZhCAkwLMySeO8vgV2JsnvWUEIrHRJyThv0gLJGivHrKuLh62GdVSUDWcw3rdmBRPbCcA
        zYFs+i7xoUgHF5xiUm+vF3j7po1EbgFmRTBt3RyBHGuFwU8Bywa3i1jpGtgDRKr6gM/1Ln
        t9Flxjj2XTpP1YuAnoTfLLnbh7CS4BnJZStVsMRRz+aC3PZTD5am43YaDIw6XOqSzGbMGF
        /ubfTJu6B90f+3wwaeV4DESklHs2bfnumb207Mzu9NgBxnnAMRr85eow9zlwC4+mrxVibw
        oxwT2b9wPFcOE0XoDYpCpM4Z+Hf79cwpWLNBO8cAynnZfuShrAsN/I2+oflqlQ==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 12:28:42 +0100
Subject: [PATCH net-next v7 14/16] net: ethtool: ts: Update GET_TS to reply
 the current selected timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-14-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the default selected timestamp API change we have to change also the
timestamp return by ethtool. This patch return now the current selected
timestamp.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/ethtool/ts.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/net/ethtool/ts.c b/net/ethtool/ts.c
index f2dd65a2e69c..bd219512b8de 100644
--- a/net/ethtool/ts.c
+++ b/net/ethtool/ts.c
@@ -31,29 +31,13 @@ static int ts_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct ts_reply_data *data = TS_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
-	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
 
-	if (phy_has_tsinfo(dev->phydev)) {
-		data->ts_layer = PHY_TIMESTAMPING;
-	} else if (ops->get_ts_info) {
-		struct ethtool_ts_info ts_info = {0};
-
-		ops->get_ts_info(dev, &ts_info);
-		if (ts_info.so_timestamping &
-		    SOF_TIMESTAMPING_HARDWARE_MASK)
-			data->ts_layer = MAC_TIMESTAMPING;
-
-		if (ts_info.so_timestamping &
-		    SOF_TIMESTAMPING_SOFTWARE_MASK)
-			data->ts_layer = SOFTWARE_TIMESTAMPING;
-	} else {
-		data->ts_layer = NO_TIMESTAMPING;
-	}
+	data->ts_layer = dev->ts_layer;
 
 	ethnl_ops_complete(dev);
 

-- 
2.25.1

