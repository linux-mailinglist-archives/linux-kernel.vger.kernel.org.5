Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3245178EBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbjHaLTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbjHaLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:18:56 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8077CF4;
        Thu, 31 Aug 2023 04:18:52 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 058F08656C;
        Thu, 31 Aug 2023 13:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693480731;
        bh=Qjprq4rjy8cLXyviY7njAa3McqK5erY6hM62N5dwybA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlbRS9bx1sJTrwhcHJGmDKye9bXTM3xAjp7vBBIeChSk/w3B5Ti54ueddeovf9FZP
         XzrnDr5AgDi3S5Hc1z6YOPGyfzZ5EC0mJFTBk1PUW8/u7+U2wElsG/1anLP6+3Rx6q
         WoyIPnBOJJn5HqCXNFE2oepVg+cjCk80/osqdH+fpzUe+87wWQ6ePL6DGDJrLeRU99
         woupNMdPOV4Nl7vHbgK4OPy8fsx2iXM6y9jIRjZkmWS02ef+FqL1+FPeEK7s6WKQku
         ZMZPxie90y2YzFnC6nJzX6usRe+xJoJTRodHCOyyuRz20VwoLjikHTk+HUS0wZEbKi
         jNEDKozWeJgVA==
From:   Lukasz Majewski <lukma@denx.de>
To:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/4] net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
Date:   Thu, 31 Aug 2023 13:18:25 +0200
Message-Id: <20230831111827.548118-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230831111827.548118-1-lukma@denx.de>
References: <20230831111827.548118-1-lukma@denx.de>
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

Moreover, according to AN3474 application note, the lookup bit (10)
should not be set in the tail tag.

Last but not least - the NETIF_F_HW_HSR_DUP flag indicates that the device
supports HSR and assures (in HSR core code) that frame is sent only once
from HOST to switch with tail tag indicating both ports.

Information about bits to be set in tag is provided via KSZ generic
ksz_hsr_get_ports() function.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
- Use ksz_hsr_get_ports() to obtain the bits values corresponding to
  HSR aware ports
---
 drivers/net/dsa/microchip/ksz_common.c | 12 ++++++++++++
 include/linux/dsa/ksz_common.h         |  1 +
 net/dsa/tag_ksz.c                      |  5 +++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d9d843efd111..579fde54d1e1 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3421,6 +3421,18 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
+u16 ksz_hsr_get_ports(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+
+	switch (dev->chip_id) {
+	case KSZ9477_CHIP_ID:
+		return dev->hsr_ports;
+	}
+
+	return 0;
+}
+
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
diff --git a/include/linux/dsa/ksz_common.h b/include/linux/dsa/ksz_common.h
index 576a99ca698d..fa3d9b0f3a72 100644
--- a/include/linux/dsa/ksz_common.h
+++ b/include/linux/dsa/ksz_common.h
@@ -50,4 +50,5 @@ ksz_tagger_data(struct dsa_switch *ds)
 	return ds->tagger_data;
 }
 
+u16 ksz_hsr_get_ports(struct dsa_switch *ds);
 #endif /* _NET_DSA_KSZ_COMMON_H_ */
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index ea100bd25939..903db95c37ee 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -293,6 +293,11 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 	if (is_link_local_ether_addr(hdr->h_dest))
 		val |= KSZ9477_TAIL_TAG_OVERRIDE;
 
+	if (dev->features & NETIF_F_HW_HSR_DUP) {
+		val &= ~KSZ9477_TAIL_TAG_LOOKUP;
+		val |= ksz_hsr_get_ports(dp->ds);
+	}
+
 	*tag = cpu_to_be16(val);
 
 	return ksz_defer_xmit(dp, skb);
-- 
2.20.1

