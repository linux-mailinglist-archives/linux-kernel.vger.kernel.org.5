Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084ED7B0ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjI0WNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:13:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD88FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:13:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50307759b65so19835766e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695852780; x=1696457580; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4o04zX1PQmfEMIWCBtx3WpuptkLPmUQ26jN5D5PP4KU=;
        b=s4sOAbCn4I+NvAq46K0lMT+pIr7gSQLFHwKI25w3yAmVUsAX/CHhspA7x1mGiJV47S
         M3YY8uZ1ddG/b4ayay2afNi2/7kFba6R4/u35eoBHnMxf0E8Y42Apzj+bNURnm9atxhd
         HtPKc8idyVg0I3IBx3G+s2/AIfWiIKr4E+tWsbieRh3Rv0ulttwB08Bg7hpCKA7MgRoM
         zE+cqiipnmiDJiHDwhUem0X5a32W85CgoZjoGDjc6+dUESwXyy//M+ywczh1HT5U5paa
         RIMDG9DZOQR4XXffz+EmFZdtScqcmKP2Y8gaR+6C7iXGb0k71BxJOopJSDByEsKCLuoC
         Okzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695852780; x=1696457580;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o04zX1PQmfEMIWCBtx3WpuptkLPmUQ26jN5D5PP4KU=;
        b=FHOA/OEnuWQLqlNSmaCUBbVFVdd4m1F1DAkr7Skuzttv9uh51L18mRlVNL4gzB/SA6
         k7qw5pRawrN4yGH3vecyZOJ3OkLY1vkvOZJo55OFIIQCw0iNqpr+utjsHmOgpNGAI0xL
         2thD8vBcBUOCAz3VXz3kKNUYZnhU9rFWfC/KU3jyFo5rV+FalrwbEaute7UfEVvQOPFT
         J5MdtgFeIDvqHkiyDJmf7tcsecN/LL+nA8JEIztBvdf/S1ltU/2UyfODvlzfHGCPjtiK
         w/oaoiO3Q8I7CTW3EKbVWiYs8wZ66Ikr2+dNcUpg0CvbZLky9qvrdA02nqweZiwbI8CY
         vsUw==
X-Gm-Message-State: AOJu0YwblKen1IpXzpCDe9/bmrU/jXueRbzRPsh80KPkFuQFSprscbK3
        5v7eMHmo5IzaRiOviP5wLAE3nB4Uytp6fBzUt5w=
X-Google-Smtp-Source: AGHT+IFggn2TsJ/lc1oyY7CPbyTwiAJwUaav5Tgt/ENvAW5Y2Vy0Vk7tSNHnPTZnIkpiPet4bDKkJw==
X-Received: by 2002:a19:7b1d:0:b0:503:905:c5a3 with SMTP id w29-20020a197b1d000000b005030905c5a3mr2437090lfc.35.1695852780212;
        Wed, 27 Sep 2023 15:13:00 -0700 (PDT)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b00502e2347ef0sm2793521lft.193.2023.09.27.15.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 15:12:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 00:12:56 +0200
Subject: [PATCH net-next v3] net: ixp4xx_eth: Support changing the MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOeoFGUC/3WNywrCMBQFf6Vk7ZU8Wtq48j/ERZJe24CmJYkhU
 vrvhqwUcTkcZs5GAnqLgZyajXhMNtjFFRCHhphZuQnBjoUJp1xQyQXYvLY5A8YZHvEJhrZs7PG
 GUnBSpNXjzeYavBCHERzmSK5lmW2Ii3/Vp8Tq/i+aGDCQOAxa0gGZ5ue7dcovx8VPtZX4p9/9+
 Lz4QgqjlO47o+mXv+/7G6MyOA/3AAAA
To:     Krzysztof Halasa <khalasa@piap.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we don't specify the MTU in the driver, the framework
will fall back to 1500 bytes and this doesn't work very
well when we try to attach a DSA switch:

  eth1: mtu greater than device maximum
  ixp4xx_eth c800a000.ethernet eth1: error -22 setting
  MTU to 1504 to include DSA overhead

After locating an out-of-tree patch in OpenWrt I found
suitable code to set the MTU on the interface and ported
it and updated it. Now the MTU gets set properly.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Fix some coding style and initialization style.
- Collect Jacob's review tag.
- Link to v2: https://lore.kernel.org/r/20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org

Changes in v2:
- Don't just set min/max MTU: implement the interface for actually
  changing it as well.
- Link to v1: https://lore.kernel.org/r/20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 65 +++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 3b0c5f177447..910094ab553c 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/net_tstamp.h>
@@ -63,7 +64,15 @@
 
 #define POOL_ALLOC_SIZE		(sizeof(struct desc) * (RX_DESCS + TX_DESCS))
 #define REGS_SIZE		0x1000
-#define MAX_MRU			1536 /* 0x600 */
+
+/* MRU is said to be 14320 in a code dump, the SW manual says that
+ * MRU/MTU is 16320 and includes VLAN and ethernet headers.
+ * See "IXP400 Software Programmer's Guide" section 10.3.2, page 161.
+ *
+ * FIXME: we have chosen the safe default (14320) but if you can test
+ * jumboframes, experiment with 16320 and see what happens!
+ */
+#define MAX_MRU			(14320 - VLAN_ETH_HLEN)
 #define RX_BUFF_SIZE		ALIGN((NET_IP_ALIGN) + MAX_MRU, 4)
 
 #define NAPI_WEIGHT		16
@@ -1182,6 +1191,54 @@ static void destroy_queues(struct port *port)
 	}
 }
 
+static int ixp4xx_do_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct port *port = netdev_priv(dev);
+	struct npe *npe = port->npe;
+	int framesize, chunks;
+	struct msg msg = {};
+
+	/* adjust for ethernet headers */
+	framesize = new_mtu + VLAN_ETH_HLEN;
+	/* max rx/tx 64 byte chunks */
+	chunks = DIV_ROUND_UP(framesize, 64);
+
+	msg.cmd = NPE_SETMAXFRAMELENGTHS;
+	msg.eth_id = port->id;
+
+	/* Firmware wants to know buffer size in 64 byte chunks */
+	msg.byte2 = chunks << 8;
+	msg.byte3 = chunks << 8;
+
+	msg.byte4 = msg.byte6 = framesize >> 8;
+	msg.byte5 = msg.byte7 = framesize & 0xff;
+
+	if (npe_send_recv_message(npe, &msg, "ETH_SET_MAX_FRAME_LENGTH"))
+		return -EIO;
+	netdev_dbg(dev, "set MTU on NPE %s to %d bytes\n",
+		   npe_name(npe), new_mtu);
+
+	return 0;
+}
+
+static int ixp4xx_eth_change_mtu(struct net_device *dev, int new_mtu)
+{
+	int ret;
+
+	/* MTU can only be changed when the interface is up. We also
+	 * set the MTU from dev->mtu when opening the device.
+	 */
+	if (dev->flags & IFF_UP) {
+		ret = ixp4xx_do_change_mtu(dev, new_mtu);
+		if (ret < 0)
+			return ret;
+	}
+
+	dev->mtu = new_mtu;
+
+	return 0;
+}
+
 static int eth_open(struct net_device *dev)
 {
 	struct port *port = netdev_priv(dev);
@@ -1232,6 +1289,8 @@ static int eth_open(struct net_device *dev)
 	if (npe_send_recv_message(port->npe, &msg, "ETH_SET_FIREWALL_MODE"))
 		return -EIO;
 
+	ixp4xx_do_change_mtu(dev, dev->mtu);
+
 	if ((err = request_queues(port)) != 0)
 		return err;
 
@@ -1374,6 +1433,7 @@ static int eth_close(struct net_device *dev)
 static const struct net_device_ops ixp4xx_netdev_ops = {
 	.ndo_open = eth_open,
 	.ndo_stop = eth_close,
+	.ndo_change_mtu = ixp4xx_eth_change_mtu,
 	.ndo_start_xmit = eth_xmit,
 	.ndo_set_rx_mode = eth_set_mcast_list,
 	.ndo_eth_ioctl = eth_ioctl,
@@ -1488,6 +1548,9 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 	ndev->dev.dma_mask = dev->dma_mask;
 	ndev->dev.coherent_dma_mask = dev->coherent_dma_mask;
 
+	ndev->min_mtu = ETH_MIN_MTU;
+	ndev->max_mtu = MAX_MRU;
+
 	netif_napi_add_weight(ndev, &port->napi, eth_poll, NAPI_WEIGHT);
 
 	if (!(port->npe = npe_request(NPE_ID(port->id))))

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230923-ixp4xx-eth-mtu-c041d7efe932

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

