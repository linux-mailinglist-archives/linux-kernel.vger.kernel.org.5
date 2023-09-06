Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7547279405F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbjIFP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjIFP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:28:25 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BD172E;
        Wed,  6 Sep 2023 08:28:21 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9C4FB86907;
        Wed,  6 Sep 2023 17:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694014100;
        bh=T/KQl1HywPi4vYo0yqw4JCxbizw+aauG7ITE4o6W/po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNH2m7lpRt1sE3H1hlQJlMX+ukZfFJv51L2Nnn4qFH5hRtm8wPFl4LpnPoM4h0pi9
         xGqfVwBFVZx1G2N4xknbN7siGWKZY4hD0mW/dkcz0fNe9rrSzzzFllH32jlN9Mo2Mv
         U37Y7xtVZFFKjpdsQ5SLTw5NEGA4B0eET764AhGo9crZj35ND2RSC0NdSqcddm3HZs
         Qo/OYIdm9wsHFgQG6lXICsiwFQoS6RJJ9zr+eHvLeZEk/l/8cKITe3GCDP2fLQaZ3G
         cttP/bICmElQ6ilYeXNP4rfnhFRygT2vcvAlUoaM1pbfaPMytmGnftM9hhM57uSLbq
         X4Xp1d928Hncg==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [[RFC PATCH v4 net-next] 1/2] net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
Date:   Wed,  6 Sep 2023 17:28:00 +0200
Message-Id: <20230906152801.921664-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906152801.921664-1-lukma@denx.de>
References: <20230906152801.921664-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KSZ9477 has support for HSR (High-Availability Seamless Redundancy).
One of its offloading (i.e. performed in the switch IC hardware) features
is to duplicate received frame to both HSR aware switch ports.

To achieve this goal - the tail TAG needs to be modified. To be more
specific, both ports must be marked as destination (egress) ones.

The NETIF_F_HW_HSR_DUP flag indicates that the device supports HSR and
assures (in HSR core code) that frame is sent only once from HOST to
switch with tail tag indicating both ports.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Use ksz_hsr_get_ports() to obtain the bits values corresponding to
  HSR aware ports

Changes for v3:
- None

Changes for v4:
- Iterate over switch ports to find ones supporting HSR. Comparing to v3,
  where caching of egress tag bits were used, no noticeable performance
  regression has been observed.
---
 net/dsa/tag_ksz.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index ea100bd25939..3632e47dea9e 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -293,6 +293,14 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 	if (is_link_local_ether_addr(hdr->h_dest))
 		val |= KSZ9477_TAIL_TAG_OVERRIDE;
 
+	if (dev->features & NETIF_F_HW_HSR_DUP) {
+		struct net_device *hsr_dev = dp->hsr_dev;
+		struct dsa_port *other_dp;
+
+		dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
+			val |= BIT(other_dp->index);
+	}
+
 	*tag = cpu_to_be16(val);
 
 	return ksz_defer_xmit(dp, skb);
-- 
2.20.1

