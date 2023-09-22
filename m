Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED17AB2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjIVNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjIVNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:31:38 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3C196;
        Fri, 22 Sep 2023 06:31:31 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B21728644E;
        Fri, 22 Sep 2023 15:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695389490;
        bh=gXmkSM/rvnMffX+oLeFRannNXAcxtFi0FsuPk+VjC1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YujyD3VP92tkry6nKslIit6LDIpyAqgcQgFHszD3GqoDVy8MOT3Vznuj3kHGfMUwf
         GphYmtCaBAMqWCq+yBSPyIAirCe+zAEihb7g0A961h7fGAJ6AFWNjEV99uiPLwSo4o
         pcK2xyZmwMZyAqRCTbeLU2rbnTcq2y1SM3P6XZe0N3uLJLd5VuukO0fsMjQHzNEbnQ
         F+QIRdpJET6tPeDmvU4JxscqYqxlpJR3JO2Ul2MaJG/YX0+GCU0eIdiGRiEDacQ/c2
         bv5D9ddjds59wWrKcGkPT8i6uaQXLdiktRnjo+1YVtJbrIfK0briOZkLx1/hgG+0sW
         01bfpOirBQZ7Q==
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
        Lukasz Majewski <lukma@denx.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v6 net-next 3/5] net: dsa: tag_ksz: Extend ksz9477_xmit() for HSR frame duplication
Date:   Fri, 22 Sep 2023 15:31:06 +0200
Message-Id: <20230922133108.2090612-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230922133108.2090612-1-lukma@denx.de>
References: <20230922133108.2090612-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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

Changes for v6:
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

