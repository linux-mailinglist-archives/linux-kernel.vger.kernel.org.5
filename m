Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3117B9849
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjJDWoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJDWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:44:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3910C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:43:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c00df105f8so4260661fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696459437; x=1697064237; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lwczMSD98fajqNb6/mKrj3RaEEEuYyEsq8ivVzfMMQ=;
        b=POYH5bxdLtDONsG8xkJhf57vUr666w/IZd8CkVh+HrM9Jgk3jXzlryB7C8j2Fec+4k
         TVvG6IIVv5bFPzX075hMTB85vcq8TehTWRwD2i75us+1yit6gVi20cECGGUGrXm2b/rz
         tQnwNOjrHe2y7N8zbnEEOI/E3o7IEfms+uS/hCAVl50nQGeflIcqh78ouiqtlREs0q/z
         ZjRcNIvvyZCcmSDf1BWPmkCQVIgZTuGIASNCnsnpr744JbgFyWT8bHSMrSnco4EmZ0+D
         5kdexPl7+g241TFGsIXyqBb6VvfHXaariezadOkzWwbH4TbFflgYO9v3Iq1JtQt7FXOl
         PlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459437; x=1697064237;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lwczMSD98fajqNb6/mKrj3RaEEEuYyEsq8ivVzfMMQ=;
        b=eGRYNl2ftw09qna8x/u9tG/5LBW/CGo4krHRpgKm/+tzP8Adf3EFwzd6XHyb7M+/cy
         3TsPZG8mfVH+Yea4CLRyRoqyMd5b70CL4/iQZRQ++RKYP4JPKFYtpzEYj4orrjKHvoaM
         wuqnvbYpTWNwH8IPAyPsmPV86aCTR8hRTCViYapUZ5pZrFFlbp1RrIFSeYpHulLAnbBs
         zMoevfU1JSj37wbpJ3gnIlWcQuXyCqh/lHFZLgGyR7VbIxr6/gK1c2WICODlvZATuqfQ
         d8GmkCCbKoe44xAU0qajNH4fhGnw41Sb9XZ8cBZUW9ms5+hGXAVD3ojuDziebUcjhe8t
         Kh8g==
X-Gm-Message-State: AOJu0YyQUNqvW4Jd/Lxs+000zd3vNQsMNRQu8ykNj/HlDZzCAe1/zb1o
        BmqHmxPh5aQuFU4llsLUtZSjug==
X-Google-Smtp-Source: AGHT+IFVBPiVbnjN/jU9NmwiTjdif63YN8GR8K1uocl6DgAhrT5E0sqBJnT5eMBGql/IHcwqlh5z5g==
X-Received: by 2002:a05:6512:10ca:b0:505:6785:d6c6 with SMTP id k10-20020a05651210ca00b005056785d6c6mr4328310lfg.54.1696459436663;
        Wed, 04 Oct 2023 15:43:56 -0700 (PDT)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id j13-20020a19f50d000000b005041b7735dbsm41646lfb.53.2023.10.04.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:43:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 05 Oct 2023 00:43:53 +0200
Subject: [PATCH net-next v4] net: ixp4xx_eth: Support changing the MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ixp4xx-eth-mtu-v4-1-08c66ed0bc69@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKjqHWUC/3XNSwrDIBgE4KsE17X4SIh21XuULtT8TYTWBLViC
 bl7xVVK6HIYvpkVBfAWAro0K/KQbLCzK6E9NchMyo2A7VAyYoRxIhnHNi9tzhjihF/xjQ1p6dD
 DAyRnqKDFw8PmOnhDDiJ2kCO6l2ayIc7+U58Srf2/0UQxxRKE0JIIoJpdn9YpP59nP9atxPa+O
 3hWPJfcKKX7zmhy8HzvxcHz4o2mApQiMGj547dt+wKpf1iPNwEAAA==
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
Changes in v4:
- Rebase on the merged patch "net: ixp4xx_eth: Specify min/max MTU"
  so it can be easily applied.
- Link to v3: https://lore.kernel.org/r/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@linaro.org

Changes in v3:
- Fix some coding style and initialization style.
- Collect Jacob's review tag.
- Link to v2: https://lore.kernel.org/r/20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org

Changes in v2:
- Don't just set min/max MTU: implement the interface for actually
  changing it as well.
- Link to v1: https://lore.kernel.org/r/20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 67 +++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 8f40287c8d58..910094ab553c 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -64,7 +64,15 @@
 
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
@@ -1183,6 +1191,54 @@ static void destroy_queues(struct port *port)
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
@@ -1233,6 +1289,8 @@ static int eth_open(struct net_device *dev)
 	if (npe_send_recv_message(port->npe, &msg, "ETH_SET_FIREWALL_MODE"))
 		return -EIO;
 
+	ixp4xx_do_change_mtu(dev, dev->mtu);
+
 	if ((err = request_queues(port)) != 0)
 		return err;
 
@@ -1375,6 +1433,7 @@ static int eth_close(struct net_device *dev)
 static const struct net_device_ops ixp4xx_netdev_ops = {
 	.ndo_open = eth_open,
 	.ndo_stop = eth_close,
+	.ndo_change_mtu = ixp4xx_eth_change_mtu,
 	.ndo_start_xmit = eth_xmit,
 	.ndo_set_rx_mode = eth_set_mcast_list,
 	.ndo_eth_ioctl = eth_ioctl,
@@ -1489,12 +1548,8 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 	ndev->dev.dma_mask = dev->dma_mask;
 	ndev->dev.coherent_dma_mask = dev->coherent_dma_mask;
 
-	/* Maximum frame size is 16320 bytes and includes VLAN and
-	 * ethernet headers. See "IXP400 Software Programmer's Guide"
-	 * section 10.3.2, page 161.
-	 */
 	ndev->min_mtu = ETH_MIN_MTU;
-	ndev->max_mtu = 16320 - VLAN_ETH_HLEN;
+	ndev->max_mtu = MAX_MRU;
 
 	netif_napi_add_weight(ndev, &port->napi, eth_poll, NAPI_WEIGHT);
 

---
base-commit: f22d2ec3d4e72d1f24153533ba0ce8fa926cdd37
change-id: 20230923-ixp4xx-eth-mtu-c041d7efe932

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

