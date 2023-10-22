Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF5E7D237D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjJVPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:19:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B90F4;
        Sun, 22 Oct 2023 08:19:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7789aed0e46so176735285a.0;
        Sun, 22 Oct 2023 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697987961; x=1698592761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmSfe58FfVT1+C5BDfWt5zaNsraT3ia/sP6v6KkffFo=;
        b=KBLZ88Aiv2ZHtpomUHwExfmgCScpEe5auOh5on9De+5JWbcUdJJNfuNvF95hnQTSbR
         NClHioRXr6wPajPBRa+9Wq5nBmKZTtBKu0R5A5jqe5Dz9RZ37D8BHRDN7oVV3Xh7mgVF
         jZE/K2Yk9YUUm4ZK/sLwDu4A9b6Ek8edipmGKmemXe6JVXaZQo/Yi7oH0Q3VreXxl6C3
         kS47Ty+mqGwSXgYT5eUeDVObJbloQQ+mRxs3IaONj1H3XgJAUdsGO0TnPUiZRpYFJeJh
         LBTYUppDV+28YaKIfeLyzRGjtBYWcydWuy5WZt0gphflSCFdvPhHQu8ojdiAZJd5n7LQ
         jIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697987961; x=1698592761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmSfe58FfVT1+C5BDfWt5zaNsraT3ia/sP6v6KkffFo=;
        b=JRcHccqP3ynaiIvggexbQDcmNUMeWhKHDxyTC26SmjNRW63DnyXtjd+fAawMt4S+bW
         G3XNdoBPi1gUZkfueUUdNxjr6Vazl8mp7ZIrCD2rdtrpq1LwstyftTxDd2FHXiyekjHc
         UcbaKCMxZ0ubNw60/v48R0o64ayP6plmxwcoRhg/BvnI8Ic0sEo7YIAIiHzugZZZuY0G
         9OGy4Uy4rkn+rzht2aQAXu5+1VSo4NNemtluaXZB6sPXE1jskJzCFJcLfm7dMDvB0AFH
         c5+ZcJfnlB85+UycNEJAdkeEO/3ckNdoOtNGGeVftyHRcZA6wh8P6ghDQV+mcGjR8P1q
         dYVQ==
X-Gm-Message-State: AOJu0YzjAsN+JZRl5NzfjAcmjHRAjfxIV60G+6wDAV4nrlSUwCwGFZ47
        tB2sBLayq7tm14oTHCKB+isk9dB+9jI=
X-Google-Smtp-Source: AGHT+IE/gA5UWq6LlbsX9oa0mqiocbWbKDzKWG4G9OkV3eAIis0M+5aj+qluWlzuCINq7/rYWjEW/A==
X-Received: by 2002:a05:620a:444c:b0:777:27f9:7e54 with SMTP id w12-20020a05620a444c00b0077727f97e54mr9324065qkp.50.1697987960936;
        Sun, 22 Oct 2023 08:19:20 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:a07c:e734:336b:c675])
        by smtp.gmail.com with ESMTPSA id m26-20020ae9e01a000000b007726002d69esm2084375qkk.10.2023.10.22.08.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 08:19:20 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     netdev@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] net: ethernet: davinci_emac: Use MAC Address from Device Tree
Date:   Sun, 22 Oct 2023 10:19:11 -0500
Message-Id: <20231022151911.4279-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a device tree entry called "local-mac-address"
which can be filled by the bootloader or manually set.This is
useful when the user does not want to use the MAC address
programmed into the SoC.

Currently, the davinci_emac reads the MAC from the DT, copies
it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
it by reading from registers in the SoC, and falls back to a
random MAC if it's still not valid.  This completely ignores any
MAC address in the device tree.

In order to use the local-mac-address, check to see if the contents
of priv->mac_addr are valid before falling back to reading from the
SoC when the MAC address is not valid.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
V2:  Rebase, add R-B tag, and post stand-alone for netdev branch, since
     the device tree patch has already been accepted via the omap tree.

     
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 23f8bc1cd20d..b0950a318c42 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1928,18 +1928,20 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		goto err_free_rxchan;
 	ndev->irq = rc;
 
-	rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);
-	if (!rc)
-		eth_hw_addr_set(ndev, priv->mac_addr);
-
+	/* If the MAC address is not present, read the registers from the SoC */
 	if (!is_valid_ether_addr(priv->mac_addr)) {
-		/* Use random MAC if still none obtained. */
-		eth_hw_addr_random(ndev);
-		memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
-		dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
-			 priv->mac_addr);
+		rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);
+		if (!rc)
+			eth_hw_addr_set(ndev, priv->mac_addr);
+
+		if (!is_valid_ether_addr(priv->mac_addr)) {
+			/* Use random MAC if still none obtained. */
+			eth_hw_addr_random(ndev);
+			memcpy(priv->mac_addr, ndev->dev_addr, ndev->addr_len);
+			dev_warn(&pdev->dev, "using random MAC addr: %pM\n",
+				 priv->mac_addr);
+		}
 	}
-
 	ndev->netdev_ops = &emac_netdev_ops;
 	ndev->ethtool_ops = &ethtool_ops;
 	netif_napi_add(ndev, &priv->napi, emac_poll);
-- 
2.40.1

