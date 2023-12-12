Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D280F9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377679AbjLLWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjLLWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D57BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702418891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JgXI5UIKJL7dbS8b+Hf6bo875B74UsFwJXhGTMPd+EY=;
        b=F2T5Phi0sZx6T2qwtdKQ4qSCN1woAkh5iCAxC0d7P1JU/wkhgozOGE82Sny1mjpMQg7N6f
        zkDWNrFQcnLjZTOFzVA++C4QMblzoU/E/OC5a6JH1QawKXjXFya/7zURDbHcp7N7cQuNZS
        siobTiRMhAknk9M1zFOSl5opq/urQ7Y=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-FGJqIN62NJuuUZUt8Bzu6w-1; Tue, 12 Dec 2023 17:08:09 -0500
X-MC-Unique: FGJqIN62NJuuUZUt8Bzu6w-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9f55676a1so6483651b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702418869; x=1703023669;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgXI5UIKJL7dbS8b+Hf6bo875B74UsFwJXhGTMPd+EY=;
        b=UWlWoy13vh3BuI5m2pUoyhF/jtBacHwkbEQhAoi9D3wpkiuFnthjE6I4P5GUJExWfV
         W+89b+LZPuL9RRfjNq21qSh7vIOulBnbRUz0g2WcJRYl11nIBf6GwsklH2WHZfRsDpKA
         1QTojvGwhHR+yYy+SSapZ/uDGDvho1oSuxfUdyKM8hDLYIEmEFxvRKfc8uhtNq1BQiUI
         A0KE7DS5AizGOjAALuzlOMetQDJa6UTuFrchIJm53BMplu1UbBCWawaURDVS5uaBJ4/Q
         O5/wRxxVuLOp3ZvE6nQgYQipq3arNcVkvLA29BLtduSqc3C++tFrFxoed9MV8ddd/CFK
         QWnw==
X-Gm-Message-State: AOJu0YwTEtGcYFAubdPtc3b+GTaxvFHjXUdNNt/s+bVlMBdOoHO97aG4
        h05c6VQeQqd8sao2dEKlYDzb9Fk54bq/5H62TV9C/MPz4d6eN9571vj/wguBNOrMFMB/3i2US7I
        vit0Q8nBNYEsgc6C7qus4Dcz5
X-Received: by 2002:a05:6808:209e:b0:3b9:e153:a610 with SMTP id s30-20020a056808209e00b003b9e153a610mr8737935oiw.59.1702418869222;
        Tue, 12 Dec 2023 14:07:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtw7FuNg8Jv86PnntE72uDRmRCeMl3n1edea3kl2mjP+to1GFjP45n9Zyb+l0LFAF59fAojA==
X-Received: by 2002:a05:6808:209e:b0:3b9:e153:a610 with SMTP id s30-20020a056808209e00b003b9e153a610mr8737914oiw.59.1702418868875;
        Tue, 12 Dec 2023 14:07:48 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id ml5-20020a056214584500b0067a3ad49979sm669638qvb.96.2023.12.12.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:07:48 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Tue, 12 Dec 2023 16:07:36 -0600
Subject: [PATCH net-next v4] net: stmmac: don't create a MDIO bus if
 unnecessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-stmmac-no-mdio-node-v4-1-c121068ccd17@redhat.com>
X-B4-Tracking: v=1; b=H4sIAKfZeGUC/22PzarDIBBGX6W4vgZ/kjbpqu9Ruhh1kghVg4q0l
 Lx7rYvLvdDVzMfHHM68SMJoMZHz4UUiFpts8DX0PweiV/ALUmtqJoIJybk40ZSdA019oM7YUKd
 Byo2aDIwgBjORerlFnO2jUa/EY6YeH5ncajPH4GheI8IvlY1s5HUZ+o7z4yAppyou94taDJZuu
 3+Aq005xGezLKJhm5Bgx69CRVSKlFID9pPiGi4RzQq508E1jyL/Qr5/VT4qslfjic1Cwaz+QfZ
 9fwOaHS72PQEAAA==
To:     Serge Semin <fancer.lancer@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a MDIO bus is created if the devicetree description is either:

    1. Not fixed-link
    2. fixed-link but contains a MDIO bus as well

The "1" case above isn't always accurate. If there's a phy-handle,
it could be referencing a phy on another MDIO controller's bus[1]. In
this case, where the MDIO bus is not described at all, currently
stmmac will make a MDIO bus and scan its address space to discover
phys (of which there are none). This process takes time scanning a bus
that is known to be empty, delaying time to complete probe.

There are also a lot of upstream devicetrees[2] that expect a MDIO bus
to be created, scanned for phys, and the first one found connected
to the MAC. This case can be inferred from the platform description by
not having a phy-handle && not being fixed-link. This hits case "1" in
the current driver's logic, and must be handled in any logic change here
since it is a valid legacy dt-binding.

Let's improve the logic to create a MDIO bus if either:

    - Devicetree contains a MDIO bus
    - !fixed-link && !phy-handle (legacy handling)

This way the case where no MDIO bus should be made is handled, as well
as retaining backwards compatibility with the valid cases.

Below devicetree snippets can be found that explain some of
the cases above more concretely.

Here's[0] a devicetree example where the MAC is both fixed-link and
driving a switch on MDIO (case "2" above). This needs a MDIO bus to
be created:

    &fec1 {
            phy-mode = "rmii";

            fixed-link {
                    speed = <100>;
                    full-duplex;
            };

            mdio1: mdio {
                    switch0: switch0@0 {
                            compatible = "marvell,mv88e6190";
                            pinctrl-0 = <&pinctrl_gpio_switch0>;
                    };
            };
    };

Here's[1] an example where there is no MDIO bus or fixed-link for
the ethernet1 MAC, so no MDIO bus should be created since ethernet0
is the MDIO master for ethernet1's phy:

    &ethernet0 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy0>;

            mdio {
                    compatible = "snps,dwmac-mdio";
                    sgmii_phy0: phy@8 {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0x8>;
                            device_type = "ethernet-phy";
                    };

                    sgmii_phy1: phy@a {
                            compatible = "ethernet-phy-id0141.0dd4";
                            reg = <0xa>;
                            device_type = "ethernet-phy";
                    };
            };
    };

    &ethernet1 {
            phy-mode = "sgmii";
            phy-handle = <&sgmii_phy1>;
    };

Finally there's descriptions like this[2] which don't describe the
MDIO bus but expect it to be created and the whole address space
scanned for a phy since there's no phy-handle or fixed-link described:

    &gmac {
            phy-supply = <&vcc_lan>;
            phy-mode = "rmii";
            snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
            snps,reset-active-low;
            snps,reset-delays-us = <0 10000 1000000>;
    };

[0] https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
[1] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
[2] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/rockchip/rk3368-r88.dts#L164

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Changes in v4:
- Add a line about why it is advantageous to avoid creating the unused
  bus (Andrew Lunn)
- Use sizeof(var) instead of sizeof(struct ...) (Serge)
- Describe sa8775p MDIO controller in SoC dtsi (Andrew Lunn)
- New patch to handle disabled MDIO bus in stmmac

Changes in v3:
    - Keep logic out of stmmac_probe_config_dt() since it's already massive (Serge)

Changes in v2:
    - Handle the fixed-link + mdio case (Andrew Lunn)
    - Reworded commit message
    - Still handle the "legacy" case mentioned in the commit
    - Bit further refactoring of the function for readability

- Link to v3: https://lore.kernel.org/r/20231207-stmmac-no-mdio-node-v3-1-34b870f2bafb@redhat.com
- Link to v2: https://lore.kernel.org/r/20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com
- Link to v1: https://lore.kernel.org/netdev/20230808120254.11653-1-brgl@bgdev.pl/
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 91 +++++++++++++---------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 1ffde555da47..70eadc83ca68 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -296,62 +296,80 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 }
 
 /**
- * stmmac_dt_phy - parse device-tree driver parameters to allocate PHY resources
- * @plat: driver data platform structure
- * @np: device tree node
- * @dev: device pointer
- * Description:
- * The mdio bus will be allocated in case of a phy transceiver is on board;
- * it will be NULL if the fixed-link is configured.
- * If there is the "snps,dwmac-mdio" sub-node the mdio will be allocated
- * in any case (for DSA, mdio must be registered even if fixed-link).
- * The table below sums the supported configurations:
- *	-------------------------------
- *	snps,phy-addr	|     Y
- *	-------------------------------
- *	phy-handle	|     Y
- *	-------------------------------
- *	fixed-link	|     N
- *	-------------------------------
- *	snps,dwmac-mdio	|
- *	  even if	|     Y
- *	fixed-link	|
- *	-------------------------------
+ * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree.
+ * @np: devicetree node
  *
- * It returns 0 in case of success otherwise -ENODEV.
+ * The MDIO bus will be searched for in the following ways:
+ * 1. The compatible is "snps,dwc-qos-ethernet-4.10" && a "mdio" named
+ *    child node exists
+ * 2. A child node with the "snps,dwmac-mdio" compatible is present
+ *
+ * Return: The MDIO node if present otherwise NULL
  */
-static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
-			 struct device_node *np, struct device *dev)
+static struct device_node *stmmac_of_get_mdio(struct device_node *np)
 {
-	bool mdio = !of_phy_is_fixed_link(np);
 	static const struct of_device_id need_mdio_ids[] = {
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{},
 	};
+	struct device_node *mdio_node = NULL;
 
 	if (of_match_node(need_mdio_ids, np)) {
-		plat->mdio_node = of_get_child_by_name(np, "mdio");
+		mdio_node = of_get_child_by_name(np, "mdio");
 	} else {
 		/**
 		 * If snps,dwmac-mdio is passed from DT, always register
 		 * the MDIO
 		 */
-		for_each_child_of_node(np, plat->mdio_node) {
-			if (of_device_is_compatible(plat->mdio_node,
+		for_each_child_of_node(np, mdio_node) {
+			if (of_device_is_compatible(mdio_node,
 						    "snps,dwmac-mdio"))
 				break;
 		}
 	}
 
-	if (plat->mdio_node) {
+	return mdio_node;
+}
+
+/**
+ * stmmac_mdio_setup() - Populate platform related MDIO structures.
+ * @plat: driver data platform structure
+ * @np: devicetree node
+ * @dev: device pointer
+ *
+ * This searches for MDIO information from the devicetree.
+ * If an MDIO node is found, it's assigned to plat->mdio_node and
+ * plat->mdio_bus_data is allocated.
+ * If no connection can be determined, just plat->mdio_bus_data is allocated
+ * to indicate a bus should be created and scanned for a phy.
+ * If it's determined there's no MDIO bus needed, both are left NULL.
+ *
+ * This expects that plat->phy_node has already been searched for.
+ *
+ * Return: 0 on success, errno otherwise.
+ */
+static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
+			     struct device_node *np, struct device *dev)
+{
+	bool legacy_mdio;
+
+	plat->mdio_node = stmmac_of_get_mdio(np);
+	if (plat->mdio_node)
 		dev_dbg(dev, "Found MDIO subnode\n");
-		mdio = true;
-	}
 
-	if (mdio) {
-		plat->mdio_bus_data =
-			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
-				     GFP_KERNEL);
+	/* Legacy devicetrees allowed for no MDIO bus description and expect
+	 * the bus to be scanned for devices. If there's no phy or fixed-link
+	 * described assume this is the case since there must be something
+	 * connected to the MAC.
+	 */
+	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
+	if (legacy_mdio)
+		dev_info(dev, "Deprecated MDIO bus assumption used\n");
+
+	if (plat->mdio_node || legacy_mdio) {
+		plat->mdio_bus_data = devm_kzalloc(dev,
+						   sizeof(*plat->mdio_bus_data),
+						   GFP_KERNEL);
 		if (!plat->mdio_bus_data)
 			return -ENOMEM;
 
@@ -471,8 +489,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
-	/* To Configure PHY by using all device-tree supported properties */
-	rc = stmmac_dt_phy(plat, np, &pdev->dev);
+	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
 	if (rc)
 		return ERR_PTR(rc);
 

---
base-commit: e9e952f599f2af1b11c9c5a032d8639ec4c6e4ef
change-id: 20231127-stmmac-no-mdio-node-1db9da8a25d9

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

