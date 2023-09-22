Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA84D7AB26A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjIVMsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjIVMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:48:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6B122;
        Fri, 22 Sep 2023 05:48:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690f8e63777so519830b3a.0;
        Fri, 22 Sep 2023 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695386887; x=1695991687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YreuQV9TVXASi37k349PBK731vPz1+dNCWfG46LGxt8=;
        b=XBSF0VcrOG+tUFCtPdmQUNX5TdfcsFlT+yFHjGReTXyb5zJdphhdM2o7MVz0I7tsKt
         IX9YtkaTQsyN9eu1RiXlV8UOC7AMnC01aYUjXzcVSuGma+iu/vjA/QFdqj2+MhjQq+//
         ZtD3GJghJmZdo03+VgEM7Wlp1WRw7s+034zlJ8UeL8TnZo/QpfI0rEbnxLLhwDr7UHJk
         Sk6EWVVE065G3/gkY2iMJCWh8KWfgipiJMZ697yOl0882SGomVE1txRvwtnF28OK/TT/
         7Q030RwCjXI5EAZRKExT/VJuFPMgaANSc2TLEeYUyZtJ23OxAerdr75gibT6U08YdlM2
         lt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386887; x=1695991687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YreuQV9TVXASi37k349PBK731vPz1+dNCWfG46LGxt8=;
        b=GXldnqaCuLNbS6ZM9GA4YDPptsUu6udnvCc/nyqb/OyoSAEC/DDIeaG5IjUfAz8ykn
         eVJ4TnBUtbp/rkSkpYiI1D0uE1YpIAsqj4yIPYBXzv1rVrvdyQR3sc7WD202mocUBIkq
         r4Z0sLUs8b8EIHpBXh5ba+VVpfEQrOUEaClVDvBN3fd744vjJ3SWwnGP0mCnF3iIA7DY
         88DcYaK7vLEk7K+QX7KU+muP3Sar+5FYod/vLQpmZqN1xMLXjUeksQYbthRm7AS4FwEc
         8taZt1I/4M44ryeYt5jbDjHMy1h8Rs7H17KonzeyfFrpa9Ppb9xKFBHNGVLif3Wt0+vb
         5Mcw==
X-Gm-Message-State: AOJu0Yxwvr67oKNoDhF/uJ9Xp2su6BT6SDfGn9avknOtS4xFtcrG22rq
        PRhTXCHU1yuSw/6lB5cdi3U=
X-Google-Smtp-Source: AGHT+IEl40Ar7FNp0WYIzmwvLxe0pwk6XRJucozStSVy7ZH4q84k7FhBR5X+arc8MswqMlh8e7LrKw==
X-Received: by 2002:a05:6a21:789b:b0:15d:721e:44d8 with SMTP id bf27-20020a056a21789b00b0015d721e44d8mr3990770pzc.4.1695386887233;
        Fri, 22 Sep 2023 05:48:07 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2546:6c99:4de0:9123])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b00682669dc19bsm3099371pfa.201.2023.09.22.05.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:48:06 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     kuba@kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        l00g33k@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v3 net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent
Date:   Fri, 22 Sep 2023 09:47:41 -0300
Message-Id: <20230922124741.360103-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Since commit 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done
before HW reset") the following error is seen on a imx8mn board with
a 88E6320 switch:

mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM done

This board does not have an EEPROM attached to the switch though.

This problem is well explained by Andrew Lunn:

"If there is an EEPROM, and the EEPROM contains a lot of data, it could
be that when we perform a hardware reset towards the end of probe, it
interrupts an I2C bus transaction, leaving the I2C bus in a bad state,
and future reads of the EEPROM do not work.

The work around for this was to poll the EEInt status and wait for it
to go true before performing the hardware reset.

However, we have discovered that for some boards which do not have an
EEPROM, EEInt never indicates complete. As a result,
mv88e6xxx_g1_wait_eeprom_done() spins for a second and then prints a
warning.

We probably need a different solution than calling
mv88e6xxx_g1_wait_eeprom_done(). The datasheet for 6352 documents the
EEPROM Command register:

bit 15 is:

  EEPROM Unit Busy. This bit must be set to a one to start an EEPROM
  operation (see EEOp below). Only one EEPROM operation can be
  executing at one time so this bit must be zero before setting it to
  a one.  When the requested EEPROM operation completes this bit will
  automatically be cleared to a zero. The transition of this bit from
  a one to a zero can be used to generate an interrupt (the EEInt in
  Global 1, offset 0x00).

and more interesting is bit 11:

  Register Loader Running. This bit is set to one whenever the
  register loader is busy executing instructions contained in the
  EEPROM."

Change to using mv88e6xxx_g2_eeprom_wait() to fix the timeout error
when the EEPROM chip is not present.
  
Fixes: 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Alfred,

Please test it, if you have a chance. I want to be sure that your usecase
still works well.

Changes since v2:
- Remove the definition of mv88e6xxx_g1_wait_eeprom_done() as it is 
now unused.

Changes since v1:
- Use the correct function name in the last sentence: 
"Change to mv88e6xxx_g2_eeprom_wait() to fix the timeout ..."
- Collected Florian's tag.
- Passed the net prefix in the Subject line.

 drivers/net/dsa/mv88e6xxx/chip.c    |  6 ++++--
 drivers/net/dsa/mv88e6xxx/global1.c | 31 -----------------------------
 drivers/net/dsa/mv88e6xxx/global1.h |  1 -
 drivers/net/dsa/mv88e6xxx/global2.c |  2 +-
 drivers/net/dsa/mv88e6xxx/global2.h |  1 +
 5 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 52a99d8bada0..ab434a77b059 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2958,14 +2958,16 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 		 * from the wrong location resulting in the switch booting
 		 * to wrong mode and inoperable.
 		 */
-		mv88e6xxx_g1_wait_eeprom_done(chip);
+		if (chip->info->ops->get_eeprom)
+			mv88e6xxx_g2_eeprom_wait(chip);
 
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
 		usleep_range(10000, 20000);
 
-		mv88e6xxx_g1_wait_eeprom_done(chip);
+		if (chip->info->ops->get_eeprom)
+			mv88e6xxx_g2_eeprom_wait(chip);
 	}
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 2fa55a643591..174c773b38c2 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -75,37 +75,6 @@ static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
 }
 
-void mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip)
-{
-	const unsigned long timeout = jiffies + 1 * HZ;
-	u16 val;
-	int err;
-
-	/* Wait up to 1 second for the switch to finish reading the
-	 * EEPROM.
-	 */
-	while (time_before(jiffies, timeout)) {
-		err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &val);
-		if (err) {
-			dev_err(chip->dev, "Error reading status");
-			return;
-		}
-
-		/* If the switch is still resetting, it may not
-		 * respond on the bus, and so MDIO read returns
-		 * 0xffff. Differentiate between that, and waiting for
-		 * the EEPROM to be done by bit 0 being set.
-		 */
-		if (val != 0xffff &&
-		    val & BIT(MV88E6XXX_G1_STS_IRQ_EEPROM_DONE))
-			return;
-
-		usleep_range(1000, 2000);
-	}
-
-	dev_err(chip->dev, "Timeout waiting for EEPROM done");
-}
-
 /* Offset 0x01: Switch MAC Address Register Bytes 0 & 1
  * Offset 0x02: Switch MAC Address Register Bytes 2 & 3
  * Offset 0x03: Switch MAC Address Register Bytes 4 & 5
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index c99ddd117fe6..1095261f5b49 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -282,7 +282,6 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
-void mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 937a01f2ba75..b2b5f6ba438f 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -340,7 +340,7 @@ int mv88e6xxx_g2_pot_clear(struct mv88e6xxx_chip *chip)
  * Offset 0x15: EEPROM Addr (for 8-bit data access)
  */
 
-static int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip)
 {
 	int bit = __bf_shf(MV88E6XXX_G2_EEPROM_CMD_BUSY);
 	int err;
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 7e091965582b..d9434f7cae53 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -365,6 +365,7 @@ int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip);
 
 int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip, int target,
 				      int port);
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip);
 
 extern const struct mv88e6xxx_irq_ops mv88e6097_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6250_watchdog_ops;
-- 
2.34.1

