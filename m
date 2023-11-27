Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF27FACAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjK0Vlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjK0Vl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17F1B8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701121294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ugEp/hLecd5KQ5c4t4XeynNt6sPelGpeH0b4Y4oF5aY=;
        b=iXVDmnsuIWCqrUOkDuSQWDY5kGgFtqsokp3VnDpytgar1N/oXiO4UVKK783zqfna/wRaeF
        JsI6s2kws1WDjxV+BOvzH+SMGDQRNdngoOpjZhzZKRa4UMZSB9QwT0+lxvmr8vkkQaHN56
        C8l4VyBynk5FSqHWCT067LbxOmzvA2E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-iH--zgQmPE-JCzEMO7Puqw-1; Mon, 27 Nov 2023 16:41:33 -0500
X-MC-Unique: iH--zgQmPE-JCzEMO7Puqw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-421acfe16f6so54020931cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121292; x=1701726092;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugEp/hLecd5KQ5c4t4XeynNt6sPelGpeH0b4Y4oF5aY=;
        b=h6C4ukRhCJV+4/0JaAKZA4UxkxefpTXNMeQ7e3ORIhxf8NMDXXtBpXh3AA62RW2fLO
         vrPcdLZHLpEGbSg44Rawkz41r3AHMT3hLAInUeRlGpA17K43MI2hhhd9JJpweOhA2MAd
         Nke7rPFCxrZkNJ1hEjJWFmZnTsrU7GikZfLdvatt0NaRG1FBWj1dxLMl+oo3xN29ASAw
         XMCp3FGQ4GKEIAJY8liSk6I/bC8Zn+pXhBKLRDE4hBW3zYcLTuZJqQcR+UVZE+WHo5uv
         njjZmRX+XWnXuy/0XyJm7gvqSDl48m7FNyeQ06HGMdIaLDyLOUFbn+TCJdBsikYK0OLy
         Q9HQ==
X-Gm-Message-State: AOJu0YzhOUGwmfz3BG3whffatTziV2Gxfb+G9LY1lfE37q8SFF81QZ32
        sGp/pzgX2pjJ+KQF6vsHLphcA5ShAtrCOAkWHiRoGtKBfCuKC1xrNeiZo6o0AHpA56uVjHQ4HSN
        JVNpCkJt8d/rHF2Ru/+xmZdrAOKSMPbbm
X-Received: by 2002:ac8:5f4a:0:b0:423:708a:778c with SMTP id y10-20020ac85f4a000000b00423708a778cmr16196901qta.64.1701121291872;
        Mon, 27 Nov 2023 13:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFslalZ3Mm+d5FKflLZmRPLPS2RzI4BH08Nj76UeXPXcTvFLHPJ3GE721G5hx2gALP2UW2rYQ==
X-Received: by 2002:ac8:5f4a:0:b0:423:708a:778c with SMTP id y10-20020ac85f4a000000b00423708a778cmr16196890qta.64.1701121291626;
        Mon, 27 Nov 2023 13:41:31 -0800 (PST)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id z15-20020ac8454f000000b00419732075b4sm4032574qtn.84.2023.11.27.13.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:41:31 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Mon, 27 Nov 2023 15:41:10 -0600
Subject: [PATCH net-next v2] net: phy: mdio_device: Reset device only when
 necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
X-B4-Tracking: v=1; b=H4sIAPUMZWUC/32NwQ7CIBBEf6XZs2vYJanWk/9heqh0FQ5CA4S0a
 frvIh/gbSYz82aHJNFJglu3Q5Tikgu+Gj51YOzk34Jurh5YsSZiQi8ZF7thlFRV8EaQhDXr4cq
 TKKjDJcrLrQ36gF/fy5phrIl1KYe4tbdCLf8HLoSE+mKGXj17rXtzjzLbKZ9N+MB4HMcXHbWAI
 78AAAA=
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the phy reset sequence is as shown below for a
devicetree described mdio phy on boot:

1. Assert the phy_device's reset as part of registering
2. Deassert the phy_device's reset as part of registering
3. Deassert the phy_device's reset as part of phy_probe
4. Deassert the phy_device's reset as part of phy_hw_init

The extra two deasserts include waiting the deassert delay afterwards,
which is adding unnecessary delay.

This applies to both possible types of resets (reset controller
reference and a reset gpio) that can be used.

Here's some snipped tracing output using the following command line
params "trace_event=gpio:* trace_options=stacktrace" illustrating
the reset handling and where its coming from:

    /* Assert */
       systemd-udevd-283     [002] .....     6.780434: gpio_value: 544 set 0
       systemd-udevd-283     [002] .....     6.783849: <stack trace>
     => gpiod_set_raw_value_commit
     => gpiod_set_value_nocheck
     => gpiod_set_value_cansleep
     => mdio_device_reset
     => mdiobus_register_device
     => phy_device_register
     => fwnode_mdiobus_phy_device_register
     => fwnode_mdiobus_register_phy
     => __of_mdiobus_register
     => stmmac_mdio_register
     => stmmac_dvr_probe
     => stmmac_pltfr_probe
     => devm_stmmac_pltfr_probe
     => qcom_ethqos_probe
     => platform_probe

    /* Deassert */
       systemd-udevd-283     [002] .....     6.802480: gpio_value: 544 set 1
       systemd-udevd-283     [002] .....     6.805886: <stack trace>
     => gpiod_set_raw_value_commit
     => gpiod_set_value_nocheck
     => gpiod_set_value_cansleep
     => mdio_device_reset
     => phy_device_register
     => fwnode_mdiobus_phy_device_register
     => fwnode_mdiobus_register_phy
     => __of_mdiobus_register
     => stmmac_mdio_register
     => stmmac_dvr_probe
     => stmmac_pltfr_probe
     => devm_stmmac_pltfr_probe
     => qcom_ethqos_probe
     => platform_probe

    /* Deassert */
       systemd-udevd-283     [002] .....     6.882601: gpio_value: 544 set 1
       systemd-udevd-283     [002] .....     6.886014: <stack trace>
     => gpiod_set_raw_value_commit
     => gpiod_set_value_nocheck
     => gpiod_set_value_cansleep
     => mdio_device_reset
     => phy_probe
     => really_probe
     => __driver_probe_device
     => driver_probe_device
     => __device_attach_driver
     => bus_for_each_drv
     => __device_attach
     => device_initial_probe
     => bus_probe_device
     => device_add
     => phy_device_register
     => fwnode_mdiobus_phy_device_register
     => fwnode_mdiobus_register_phy
     => __of_mdiobus_register
     => stmmac_mdio_register
     => stmmac_dvr_probe
     => stmmac_pltfr_probe
     => devm_stmmac_pltfr_probe
     => qcom_ethqos_probe
     => platform_probe

    /* Deassert */
      NetworkManager-477     [000] .....     7.023144: gpio_value: 544 set 1
      NetworkManager-477     [000] .....     7.026596: <stack trace>
     => gpiod_set_raw_value_commit
     => gpiod_set_value_nocheck
     => gpiod_set_value_cansleep
     => mdio_device_reset
     => phy_init_hw
     => phy_attach_direct
     => phylink_fwnode_phy_connect
     => __stmmac_open
     => stmmac_open

There's a lot of paths where the device is getting its reset
asserted and deasserted. Let's track the state and only actually
do the assert/deassert when it changes.

Reported-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Changes in v2:
- Mention the reset controller in the commit message (Andrew Lunn)
- Make the initial reset_state unknown (so we always ensure the reset
  gpio and controller end up in the same state) instead of
  assuming they're both out of reset after acquiring them (Andrew Lunn)
- Link to v1: https://lore.kernel.org/r/20231121-net-phy-reset-once-v1-1-37c960b6336c@redhat.com
---
 drivers/net/phy/mdio_device.c | 6 ++++++
 drivers/net/phy/phy_device.c  | 1 +
 include/linux/mdio.h          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 044828d081d2..73f6539b9e50 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -62,6 +62,7 @@ struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 	mdiodev->device_remove = mdio_device_remove;
 	mdiodev->bus = bus;
 	mdiodev->addr = addr;
+	mdiodev->reset_state = -1;
 
 	dev_set_name(&mdiodev->dev, PHY_ID_FMT, bus->id, addr);
 
@@ -122,6 +123,9 @@ void mdio_device_reset(struct mdio_device *mdiodev, int value)
 	if (!mdiodev->reset_gpio && !mdiodev->reset_ctrl)
 		return;
 
+	if (mdiodev->reset_state == value)
+		return;
+
 	if (mdiodev->reset_gpio)
 		gpiod_set_value_cansleep(mdiodev->reset_gpio, value);
 
@@ -135,6 +139,8 @@ void mdio_device_reset(struct mdio_device *mdiodev, int value)
 	d = value ? mdiodev->reset_assert_delay : mdiodev->reset_deassert_delay;
 	if (d)
 		fsleep(d);
+
+	mdiodev->reset_state = value;
 }
 EXPORT_SYMBOL(mdio_device_reset);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 478126f6b5bc..843ce2479736 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -654,6 +654,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	mdiodev->flags = MDIO_DEVICE_FLAG_PHY;
 	mdiodev->device_free = phy_mdio_device_free;
 	mdiodev->device_remove = phy_mdio_device_remove;
+	mdiodev->reset_state = -1;
 
 	dev->speed = SPEED_UNKNOWN;
 	dev->duplex = DUPLEX_UNKNOWN;
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 007fd9c3e4b6..79ceee3c8673 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -38,6 +38,7 @@ struct mdio_device {
 	/* Bus address of the MDIO device (0-31) */
 	int addr;
 	int flags;
+	int reset_state;
 	struct gpio_desc *reset_gpio;
 	struct reset_control *reset_ctrl;
 	unsigned int reset_assert_delay;

---
base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
change-id: 20231121-net-phy-reset-once-1e2323982ae0

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

