Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28D7FEE39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbjK3LqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjK3LqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:46:08 -0500
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 03:45:07 PST
Received: from shmail0.sohard.de (shmail0.sohard.de [87.140.57.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7B1989;
        Thu, 30 Nov 2023 03:45:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by shmail0.sohard.de (Postfix) with ESMTP id A9425BE08E3;
        Thu, 30 Nov 2023 11:35:41 +0000 (UTC)
Received: from shmail0.sohard.de ([127.0.0.1])
 by localhost (shmail0.sohard.de [127.0.0.1]) (amavis, port 10032) with ESMTP
 id RrOfBY0s_N0T; Thu, 30 Nov 2023 11:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by shmail0.sohard.de (Postfix) with ESMTP id 4435EBE08E4;
        Thu, 30 Nov 2023 11:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at shmail0.sohard.de
Received: from shmail0.sohard.de ([127.0.0.1])
 by localhost (shmail0.sohard.de [127.0.0.1]) (amavis, port 10026) with ESMTP
 id lIGlhNebZmyJ; Thu, 30 Nov 2023 11:35:41 +0000 (UTC)
Received: from protest9.fue.sohard.de (protest9.fue.sohard.de [192.168.144.82])
        by shmail0.sohard.de (Postfix) with ESMTPSA id 1F967BE08E3;
        Thu, 30 Nov 2023 11:35:41 +0000 (UTC)
From:   Thomas Reichinger <thomas.reichinger@sohard.de>
Cc:     Thomas Reichinger <thomas.reichinger@sohard.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arcnet: restoring support for multiple Sohard Arcnet cards
Date:   Thu, 30 Nov 2023 12:35:03 +0100
Message-Id: <20231130113503.6812-1-thomas.reichinger@sohard.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe of Sohard Arcnet cards fails,
if 2 or more cards are installed in a system.
See kernel log:
[    2.759203] arcnet: arcnet loaded
[    2.763648] arcnet:com20020: COM20020 chipset support (by David Woodho=
use et al.)
[    2.770585] arcnet:com20020_pci: COM20020 PCI support
[    2.772295] com20020 0000:02:00.0: enabling device (0000 -> 0003)
[    2.772354] (unnamed net_device) (uninitialized): PLX-PCI Controls
...
[    3.071301] com20020 0000:02:00.0 arc0-0 (uninitialized): PCI COM20020=
: station FFh found at F080h, IRQ 101.
[    3.071305] com20020 0000:02:00.0 arc0-0 (uninitialized): Using CKP 64=
 - data rate 2.5 Mb/s
[    3.071534] com20020 0000:07:00.0: enabling device (0000 -> 0003)
[    3.071581] (unnamed net_device) (uninitialized): PLX-PCI Controls
...
[    3.369501] com20020 0000:07:00.0: Led pci:green:tx:0-0 renamed to pci=
:green:tx:0-0_1 due to name collision
[    3.369535] com20020 0000:07:00.0: Led pci:red:recon:0-0 renamed to pc=
i:red:recon:0-0_1 due to name collision
[    3.370586] com20020 0000:07:00.0 arc0-0 (uninitialized): PCI COM20020=
: station E1h found at C000h, IRQ 35.
[    3.370589] com20020 0000:07:00.0 arc0-0 (uninitialized): Using CKP 64=
 - data rate 2.5 Mb/s
[    3.370608] com20020: probe of 0000:07:00.0 failed with error -5

commit 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")
changes the device name of all COM20020 based PCI cards,
even if only some cards support this:
	snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);

The error happens because all Sohard Arcnet cards would be called arc0-0,
since the Sohard Arcnet cards don't have a PLX rotary coder.
I.e. EAE Arcnet cards have a PLX rotary coder,
which sets the first decimal, ensuring unique devices names.

This patch adds two new card feature flags to indicate
which cards support LEDs and the PLX rotary coder.
For EAE based cards the names still depend on the PLX rotary coder
(untested, since missing EAE hardware).
For Sohard based cards, this patch will result in devices
being called arc0, arc1, ... (tested).

Signed-off-by: Thomas Reichinger <thomas.reichinger@sohard.de>
---
 drivers/net/arcnet/arcdevice.h    |  2 +
 drivers/net/arcnet/com20020-pci.c | 89 ++++++++++++++++---------------
 2 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevic=
e.h
index 19e996a829c9..b54275389f8a 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -186,6 +186,8 @@ do {									\
 #define ARC_IS_5MBIT    1   /* card default speed is 5MBit */
 #define ARC_CAN_10MBIT  2   /* card uses COM20022, supporting 10MBit,
 				 but default is 2.5MBit. */
+#define ARC_HAS_LED     4   /* card has software controlled LEDs */
+#define ARC_HAS_ROTARY  8   /* card has rotary encoder */
=20
 /* information needed to define an encapsulation driver */
 struct ArcProto {
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20=
020-pci.c
index c580acb8b1d3..7b5c8bb02f11 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -213,12 +213,13 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		if (!strncmp(ci->name, "EAE PLX-PCI FB2", 15))
 			lp->backplane =3D 1;
=20
-		/* Get the dev_id from the PLX rotary coder */
-		if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
-			dev_id_mask =3D 0x3;
-		dev->dev_id =3D (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
-
-		snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		if (ci->flags & ARC_HAS_ROTARY) {
+			/* Get the dev_id from the PLX rotary coder */
+			if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
+				dev_id_mask =3D 0x3;
+			dev->dev_id =3D (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
+			snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		}
=20
 		if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) =3D=3D 0xFF) {
 			pr_err("IO address %Xh is empty!\n", ioaddr);
@@ -230,6 +231,10 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			goto err_free_arcdev;
 		}
=20
+		ret =3D com20020_found(dev, IRQF_SHARED);
+		if (ret)
+			goto err_free_arcdev;
+
 		card =3D devm_kzalloc(&pdev->dev, sizeof(struct com20020_dev),
 				    GFP_KERNEL);
 		if (!card) {
@@ -239,41 +244,39 @@ static int com20020pci_probe(struct pci_dev *pdev,
=20
 		card->index =3D i;
 		card->pci_priv =3D priv;
-		card->tx_led.brightness_set =3D led_tx_set;
-		card->tx_led.default_trigger =3D devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-tx",
-						dev->dev_id, i);
-		card->tx_led.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:green:tx:%d-%d",
-						dev->dev_id, i);
-
-		card->tx_led.dev =3D &dev->dev;
-		card->recon_led.brightness_set =3D led_recon_set;
-		card->recon_led.default_trigger =3D devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-recon",
-						dev->dev_id, i);
-		card->recon_led.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:red:recon:%d-%d",
-						dev->dev_id, i);
-		card->recon_led.dev =3D &dev->dev;
-		card->dev =3D dev;
-
-		ret =3D devm_led_classdev_register(&pdev->dev, &card->tx_led);
-		if (ret)
-			goto err_free_arcdev;
=20
-		ret =3D devm_led_classdev_register(&pdev->dev, &card->recon_led);
-		if (ret)
-			goto err_free_arcdev;
-
-		dev_set_drvdata(&dev->dev, card);
-
-		ret =3D com20020_found(dev, IRQF_SHARED);
-		if (ret)
-			goto err_free_arcdev;
-
-		devm_arcnet_led_init(dev, dev->dev_id, i);
+		if (ci->flags & ARC_HAS_LED) {
+			card->tx_led.brightness_set =3D led_tx_set;
+			card->tx_led.default_trigger =3D devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-tx",
+							dev->dev_id, i);
+			card->tx_led.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:green:tx:%d-%d",
+							dev->dev_id, i);
+
+			card->tx_led.dev =3D &dev->dev;
+			card->recon_led.brightness_set =3D led_recon_set;
+			card->recon_led.default_trigger =3D devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-recon",
+							dev->dev_id, i);
+			card->recon_led.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:red:recon:%d-%d",
+							dev->dev_id, i);
+			card->recon_led.dev =3D &dev->dev;
+
+			ret =3D devm_led_classdev_register(&pdev->dev, &card->tx_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			ret =3D devm_led_classdev_register(&pdev->dev, &card->recon_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			dev_set_drvdata(&dev->dev, card);
+			devm_arcnet_led_init(dev, dev->dev_id, i);
+		}
=20
+		card->dev =3D dev;
 		list_add(&card->list, &priv->list_dev);
 		continue;
=20
@@ -329,7 +332,7 @@ static struct com20020_pci_card_info card_info_5mbit =
=3D {
 };
=20
 static struct com20020_pci_card_info card_info_sohard =3D {
-	.name =3D "PLX-PCI",
+	.name =3D "SOHARD SH ARC-PCI",
 	.devcount =3D 1,
 	/* SOHARD needs PCI base addr 4 */
 	.chan_map_tbl =3D {
@@ -364,7 +367,7 @@ static struct com20020_pci_card_info card_info_eae_ar=
c1 =3D {
 		},
 	},
 	.rotary =3D 0x0,
-	.flags =3D ARC_CAN_10MBIT,
+	.flags =3D ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
=20
 static struct com20020_pci_card_info card_info_eae_ma1 =3D {
@@ -396,7 +399,7 @@ static struct com20020_pci_card_info card_info_eae_ma=
1 =3D {
 		},
 	},
 	.rotary =3D 0x0,
-	.flags =3D ARC_CAN_10MBIT,
+	.flags =3D ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
=20
 static struct com20020_pci_card_info card_info_eae_fb2 =3D {
@@ -421,7 +424,7 @@ static struct com20020_pci_card_info card_info_eae_fb=
2 =3D {
 		},
 	},
 	.rotary =3D 0x0,
-	.flags =3D ARC_CAN_10MBIT,
+	.flags =3D ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
=20
 static const struct pci_device_id com20020pci_id_table[] =3D {
--=20
2.34.1

