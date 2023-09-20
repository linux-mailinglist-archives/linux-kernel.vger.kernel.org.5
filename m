Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067E97A7A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjITLoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjITLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:44:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC45CF;
        Wed, 20 Sep 2023 04:44:02 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2918086AA5;
        Wed, 20 Sep 2023 13:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695210240;
        bh=vFPC4EiLCUTFUWbe59gLsrG1YBY4uTMUwAsCR3vkdZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7hvlXFfU15ZfVmeLMVsoMbU+MVAJpc5tWjxrp3jL133TawNM4vXx7jlM0Iv2xN6d
         89vral4FAv8FtD3daHX89J8aEEsZD9jRRYhJd89p57ZxI5iEP04JS/DVNBX5XnebYa
         CFUz5wrBG1qp8oLEcCLExkYSeTEO93jIqgf7sPxU5ku3iTgMNSayRQU/AxyHylL7t8
         6bR389mt4B1Ih50+Cmq77UD2RtT/+0/C4J425ft/aFCcaPI0h6AKSeSHeTrW40ukWT
         eLSsmN/lRleqCpnCbqLN2fs5oAK9tXhaW4rlC8PKY2/FMDyqWh3fvK+7ieMg4wx2BQ
         slOwZ7U9t8gqA==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 net-next 3/5] net: dsa: tag_ksz: Extend ksz9477_xmit() for HSR frame duplication
Date:   Wed, 20 Sep 2023 13:43:41 +0200
Message-Id: <20230920114343.1979843-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920114343.1979843-1-lukma@denx.de>
References: <20230920114343.1979843-1-lukma@denx.de>
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

Changes for v5:
- None
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

