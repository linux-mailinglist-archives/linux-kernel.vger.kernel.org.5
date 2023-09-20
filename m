Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC87A8BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjITSrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjITSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:47:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED718A1;
        Wed, 20 Sep 2023 11:47:05 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a707bc2397so13157b6e.0;
        Wed, 20 Sep 2023 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695235625; x=1695840425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0J0SB+HxdrckHlsfA7/IFLQxnFqSrv8r/bynMG33Mg=;
        b=OtJy34PfjNvOt2i1to6O+ucxet6xnJyE8Aah4KR5/wR+now3uqJJWjFv8Y9D7WHKHC
         fL5x7Eq7pgadbfhYK5VGUrYSVbVWXJPRtp+erYp2q7vQiVrkzIcHyxhftnObQjoLEet5
         DFM8E81Oml6B5XiORq3b1FQoRVUqjIMPybt1S5H53k/tnB03P2PQ0/q+ParUgpgsPzxU
         ELzMC+T204Iu6qzW6HggPUNodne0WUUwQQ+26qJknHfiUiNcGwMQj118S+ASLnvVXEnE
         +DeRNU9zEvxqavUd4EC7Tw3y1CupqyFIXgs+m8/dNIQy7OcsO5kWFm5WYUQAlqOvfHYD
         syDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695235625; x=1695840425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0J0SB+HxdrckHlsfA7/IFLQxnFqSrv8r/bynMG33Mg=;
        b=i/+4vG3oXVmqayK6y++tgQ6/gak4N8oAnVxAKs2WauJUOTPhSb9AIZml8Gk/UOjemP
         AYwWV2Iwtp1i1BaBI+JZV4f7nEELO4sj5hbGwLb20JS3SqAJbov6iiEAMYSHWMY6ftYm
         3X/UI+Tb5Db/xZmk/tlZbg6qc8mr2pBwGqoRceuPHrwpPxLjKWqWWmXYQaBihqorFlzA
         MIqWYEXnRA3Pg8wlCNYem++id02W0cPokV7922ZbxLkZVkp0s5LanjCv5dllu1da8jyx
         lnmK7aFNFdXKNa1Ey/IlB9PS1eReBUoShJKZTRU7KnDl3xk72aPq2zrtp14Bd/31McVL
         e0qQ==
X-Gm-Message-State: AOJu0YzueRs/EAgzyPCUoNM3fpMNLdF0dFuHfle0B74OLtFchoU9tQKL
        aNA/tU6iXToDNfBDsuFtdNw=
X-Google-Smtp-Source: AGHT+IH9gK9IyX7y+Bj/PRIVToVWY5h53jyVu8uDelJTuMsZnWMWtIkQMSEwOUKSrYNPrWT4Io40uQ==
X-Received: by 2002:a05:6870:2190:b0:1d6:3e08:c150 with SMTP id l16-20020a056870219000b001d63e08c150mr3251269oae.5.1695235625088;
        Wed, 20 Sep 2023 11:47:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7290:a7f7:69b2:711b])
        by smtp.gmail.com with ESMTPSA id t20-20020a9d7754000000b006b922956cecsm6320333otl.25.2023.09.20.11.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:47:04 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     kuba@kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        l00g33k@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v2 net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent
Date:   Wed, 20 Sep 2023 15:46:47 -0300
Message-Id: <20230920184647.84316-1-festevam@gmail.com>
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

Change to mv88e6xxx_g2_eeprom_wait() to fix the timeout error when the
EEPROM chip is not present.
  
Fixes: 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Alfred,

Please test it, if you have a chance. I want to be sure that your usecase
still works well.

Changes since v1:
- Use the correct function name in the last sentence: 
"Change to mv88e6xxx_g2_eeprom_wait() to fix the timeout ..."
- Collected Florian's tag.
- Passed the net prefix in the Subject line.

 drivers/net/dsa/mv88e6xxx/chip.c    | 6 ++++--
 drivers/net/dsa/mv88e6xxx/global2.c | 2 +-
 drivers/net/dsa/mv88e6xxx/global2.h | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index a73008b9e0b3..ba906dfab055 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3012,14 +3012,16 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
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
 
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index ec49939968fa..ac302a935ce6 100644
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
index c05fad5c9f19..6d8d38944b23 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -360,6 +360,8 @@ int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip);
 int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip, int target,
 				      int port);
 
+int mv88e6xxx_g2_eeprom_wait(struct mv88e6xxx_chip *chip);
+
 extern const struct mv88e6xxx_irq_ops mv88e6097_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6250_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6390_watchdog_ops;
-- 
2.34.1

