Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02E7916C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352899AbjIDMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbjIDMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:02:37 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBB1B7;
        Mon,  4 Sep 2023 05:02:33 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2046F8684C;
        Mon,  4 Sep 2023 14:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693828952;
        bh=B9gqDbm3tIBLoslh6Yhvjy+urXpXmexvewmKiIKOz8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyD8bNu6K4zsj1fcSq4W0IjMiV3eOiG+RdVRI6IVRR32S6WjHjeUOyiaUPbjsG4Nq
         sqehWszQHmJJ8UGfY+c4InI7iITu/GwhfQh+iyarQ2JS9pPELZp1K/e/rHMo6AAyqW
         ejbPw6RfqBEili+GgnFseAz++4/vqzZ95+yHalxm2wPhNZuTkpqns2cNXm/sJsE98y
         bz4+o92rCRs4uMO86tYJY0gxvyrJEz2gpBn+++8Lp+QzrBlZjZxdYbonIjDUsB8DoZ
         Gh9Mo2GZGGB/ndwyg3m/7+e23LesjntEndUCvV65B2y8CcsWI55mdIrQ9lS1dhqdMO
         TF//IAwP9r+qg==
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
Subject: [PATCH v3 RFC 2/4] net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
Date:   Mon,  4 Sep 2023 14:02:07 +0200
Message-Id: <20230904120209.741207-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904120209.741207-1-lukma@denx.de>
References: <20230904120209.741207-1-lukma@denx.de>
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
Changes for v2:
- Use ksz_hsr_get_ports() to obtain the bits values corresponding to
  HSR aware ports

Changes for v3:
- None
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

