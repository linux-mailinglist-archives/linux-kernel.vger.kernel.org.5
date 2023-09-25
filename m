Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C443E7AD11E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjIYHKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjIYHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:10:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06D3D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:09:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50306b2920dso7071118e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695625797; x=1696230597; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqZK5rfK2NK1ukLToqkFpZ/nmPOVTvrQx25n2XKJyNo=;
        b=CzxG0qQw3GsFg3Oyc9/jLQtyimetLOpEJ4xl8VmT9JAhYSoJmude0ArvD9vJp+YOr3
         7+pWGFXt3tgq+ndwqzAZa8cJ+VgJ1p/HFZ+rADyJmJJAXmNwGSg7x/z7MEQjfDW9Qot6
         OCCyZCV3/37I36ZLT2AicvkwiKupCMdFVybQxJTuAhsw7ofYdMU0CY4NuOLJ9Q34FoQU
         dypU/TMO7T8PP7dISAUhHy+biKrN//ubsZPrivSuxoLrHo4EaLlPpSDB9UATTT9ioJJ0
         O0dcjBLh8pB2nN6PGQOVnxmGYsL7sHeuXt1e/qzL33wpnen7QW9fjSBTvRGWFUTfvK18
         8Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695625797; x=1696230597;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqZK5rfK2NK1ukLToqkFpZ/nmPOVTvrQx25n2XKJyNo=;
        b=aT7md4rWV/C/BVmETKbKy2ElOO2PkcngTjlCUaEUsc/BCmKJ5YfQGFwbNFAzJwns9o
         kYPQZqeamyIiHA5N/oKqPAdo482ll4YeshzO8dUb3YhWndKKmDjQxSI0gSXOrKl2Q92y
         PBh2lghnBasBUmvRhthtjnKQd8WcY0+LCB5vIQfeg5nR3Ii+IbEng3tT9bNG4Uv2rKcD
         bp8K8dowXbqMAlJBXYrO+VGU2c00nem63Kpi3HS9poLBeMY1y8JWt6arpRu7hcSI1x9c
         tWN6o4f1A55SbY916YUX6tFDe87QRSCa5ZQMcq3RyK+PpS7bazQp8+GcCkhZJXanahZJ
         YNgA==
X-Gm-Message-State: AOJu0Ywf6bil0PUgpkTteYwRVh6Ky2kOOWT9NcSJXVor9znBnbPxM6D3
        b16BiQuQPS+qrbrp19q8oKg1UA==
X-Google-Smtp-Source: AGHT+IG50fbbZdBe34ijbBMGdi2JJbwAU5TARGF5Cp2x6RxUr7HavmVYcYtcCvmLfjpZDC+IMKAHFQ==
X-Received: by 2002:a05:6512:2804:b0:4fe:3291:6b50 with SMTP id cf4-20020a056512280400b004fe32916b50mr3511955lfb.7.1695625796579;
        Mon, 25 Sep 2023 00:09:56 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id x27-20020ac259db000000b004ff6fa3f038sm1705221lfn.144.2023.09.25.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 00:09:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Sep 2023 09:09:52 +0200
Subject: [PATCH net-next v2] net: ixp4xx_eth: Support changing the MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEAyEWUC/3WNywrDIBBFfyXMulPUBKpd9T9KFnlM4kCrQW2wB
 P+9kn2Xh8M994BIgSnCvTkg0M6RvaugLg1MdnArIc+VQQnVCqNa5Lx1OSMli+/0wUl0cr7RQqZ
 VUEdboIXzGXyCo4SOcoK+Gssx+fA9n3Z5+n/RXaJEQ1qPRmiSo3q82A3BX31YoS+l/AB+VPnYt
 wAAAA==
To:     Krzysztof Halasa <khalasa@piap.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Don't just set min/max MTU: implement the interface for actually
  changing it as well.
- Link to v1: https://lore.kernel.org/r/20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 64 +++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 3b0c5f177447..18e52abc005b 100644
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
@@ -1182,6 +1191,53 @@ static void destroy_queues(struct port *port)
 	}
 }
 
+static int ixp4xx_do_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct port *port = netdev_priv(dev);
+	struct npe *npe = port->npe;
+	struct msg msg;
+	/* adjust for ethernet headers */
+	int framesize = new_mtu + VLAN_ETH_HLEN;
+	/* max rx/tx 64 byte chunks */
+	int chunks = DIV_ROUND_UP(framesize, 64);
+
+	memset(&msg, 0, sizeof(msg));
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
@@ -1232,6 +1288,8 @@ static int eth_open(struct net_device *dev)
 	if (npe_send_recv_message(port->npe, &msg, "ETH_SET_FIREWALL_MODE"))
 		return -EIO;
 
+	ixp4xx_do_change_mtu(dev, dev->mtu);
+
 	if ((err = request_queues(port)) != 0)
 		return err;
 
@@ -1374,6 +1432,7 @@ static int eth_close(struct net_device *dev)
 static const struct net_device_ops ixp4xx_netdev_ops = {
 	.ndo_open = eth_open,
 	.ndo_stop = eth_close,
+	.ndo_change_mtu = ixp4xx_eth_change_mtu,
 	.ndo_start_xmit = eth_xmit,
 	.ndo_set_rx_mode = eth_set_mcast_list,
 	.ndo_eth_ioctl = eth_ioctl,
@@ -1488,6 +1547,9 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
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

