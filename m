Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449667F3900
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjKUWLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjKUWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D6194
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700604658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gdwjKLBCPHbhmKdp+NaAgsF4FPxnedN47CRRapavUMU=;
        b=P8n8hB8XASfj9wNNqBMB+G4g/Kj+C9KpOgYZ+Fm7o2VTPe3rPbZk24eM0osJK2SOICIc+N
        5gSgRUKTSZLJSKsHBYe4mMa/+6cw1LAhMuVKr3slh3/X3iS31KJnKTBZ4roc/wD+3X1y90
        PpZjYnT4R4xd+qif+QqUmLoqOXECn/g=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-kGY4MumHOveW-lvnKMNNHg-1; Tue, 21 Nov 2023 17:10:57 -0500
X-MC-Unique: kGY4MumHOveW-lvnKMNNHg-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-da03390793fso7400888276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700604656; x=1701209456;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdwjKLBCPHbhmKdp+NaAgsF4FPxnedN47CRRapavUMU=;
        b=PvdbXTySzsXI/iswX75bHblPL6KntzlpCrPJPDiVAbJDt/1ksLW0B5hqAFBZVXRAJK
         HYDcmW3kL+UEWTSz/uknKzQWP2Lf0lQO9qsFYFIphSa1vkCd4R4Bg731oAsNp20tKY+G
         jIZaPjRnXChVg54TohWKYPNYW6PpQ5d/XPYCOwwOKsXGpMBJ/Ei79gSigpLvw8hnG/iZ
         SIx4AXYmoFc6gwk8Ih03xDhXQG2aXw+xYRC0d9VwA1YiSc6OqHYcDk7a59pJDJsQ33wh
         LJ7OzoxMrM8+Vko1N8kUmNHJmvLGwa0QWUQ7nU9voolXJV62imkSg0JNPLXkxSSSL33i
         8btQ==
X-Gm-Message-State: AOJu0YzjqA5Tn+QjAaNwwA5TW4Prm+eGRIbQ2SpbNg6VgdB+IKJtAUga
        dYMxYICOeNADsdAqYg0TzQM2/+bk+gCQFz7J/3RUBzA6d8vQ8d8URVzF1H940ZxBThKAXoOp7bH
        iv5vx0ITBlPpC/3UYZUxo5hoH
X-Received: by 2002:a25:6a42:0:b0:daf:936f:4547 with SMTP id f63-20020a256a42000000b00daf936f4547mr324092ybc.19.1700604656380;
        Tue, 21 Nov 2023 14:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE090DqFilJY7Grpyrn6Z8VnqvMejJY8JbukGhhcycTVKzgxbz8+AeQIpmf/uCRmVju8tO5Q==
X-Received: by 2002:a25:6a42:0:b0:daf:936f:4547 with SMTP id f63-20020a256a42000000b00daf936f4547mr324079ybc.19.1700604656021;
        Tue, 21 Nov 2023 14:10:56 -0800 (PST)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id c19-20020a056214071300b00670fd658739sm4321099qvz.38.2023.11.21.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:10:55 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Tue, 21 Nov 2023 16:10:37 -0600
Subject: [PATCH net-next] net: phy: mdio_device: Reset device only when
 necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-net-phy-reset-once-v1-1-37c960b6336c@redhat.com>
X-B4-Tracking: v=1; b=H4sIANwqXWUC/x2MQQ6DMAwEvxL5jCXsXNp+BXFAdAFfDEpQlQrl7
 025zUize1FGMmR6hYsSPpZt9ybSBZq3yVewvZuT9hpFVNhx8rF9OSE32n0GCzRqfD50Qk9teCQ
 sVu7Tgf69o5w01voDrFYUdW4AAAA=
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
This patch isn't the prettiest thing in the world, but the myriad of
call paths that lead to touching the reset gpio is proving daunting to
me. I originally tried to remove some of the reset calls in various
places, but after staring at the different call paths I decided this was
safer, I am not confident I covered all the corner cases when going
about this by removing the extra phy_device_reset/mdio_device_reset
calls.
---
 drivers/net/phy/mdio_device.c | 5 +++++
 include/linux/mdio.h          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 044828d081d2..d2b9e62edaaa 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -122,6 +122,9 @@ void mdio_device_reset(struct mdio_device *mdiodev, int value)
 	if (!mdiodev->reset_gpio && !mdiodev->reset_ctrl)
 		return;
 
+	if (mdiodev->reset_state == value)
+		return;
+
 	if (mdiodev->reset_gpio)
 		gpiod_set_value_cansleep(mdiodev->reset_gpio, value);
 
@@ -135,6 +138,8 @@ void mdio_device_reset(struct mdio_device *mdiodev, int value)
 	d = value ? mdiodev->reset_assert_delay : mdiodev->reset_deassert_delay;
 	if (d)
 		fsleep(d);
+
+	mdiodev->reset_state = value;
 }
 EXPORT_SYMBOL(mdio_device_reset);
 
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
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231121-net-phy-reset-once-1e2323982ae0

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

