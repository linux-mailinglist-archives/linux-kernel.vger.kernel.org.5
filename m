Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029E7F4DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjKVRI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:08:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E719D;
        Wed, 22 Nov 2023 09:08:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507bd644a96so9978396e87.3;
        Wed, 22 Nov 2023 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700672901; x=1701277701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ52W3J/jfzoeorOH8Ble/lO+B/yKqULSEksr4WVARc=;
        b=iFHhaUS3//ueHEzInFv71arqDiGBZLiJLlj2DqSTNLUneM5Axsic+SVCMJ0EJ40LwB
         DvnvZ8768RaaEn2n7ZxZm/Onpf82KSMHS7Ui3fBYSqWr77gSZmQXKeMCLY/NF4xjILCy
         IxLoFY+FJ1J3FCp5wPgQYUMCV781RVWEMATBnfIXa7/jH+kxYsdFFuJb5qy6M7xgpwcF
         YmF42MS/lnT6fUQKwi87H63pIJHMrp+RiAm1ez9w/Px5J4B9hvGO8bosH06aiT7pUOix
         C6veArUuyC6HVc1Y8eATprs7gXhqLjfjVMoMXQ9BDQm5H5HPLLVnpSZkV8ZcaV4Khi8q
         aq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700672901; x=1701277701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJ52W3J/jfzoeorOH8Ble/lO+B/yKqULSEksr4WVARc=;
        b=oaOfb5Yx5GaXqhList1fQxLyGZMb+0EtaLxY/+KFcUThxqp/N+lT4Mhck3AzfQICHB
         iXLlKyFObQtSkMwbZelmrHdVI3QzmStGWxfOSn1VPIdS9Vx8TyPCLvtQNnt8f66YZOPh
         krQia4zq5EQWCB1T42AsDDK3cSBRKq5+WLruKOQY/no/IPA8VLu/5BAe3mn/CFnBxkkt
         ANUye1B4wiJT2aR4i2mgeSLCH2DAnPI+iofBS76LGqb6q0y0PrTTgAF8W+hTl6mL85ns
         cJZ5RB2Wsu9vTyITzBUMoTUYgtsL15wVHTMih2HXBS4cIak4K9w7tEkyFsG3MicnA2Pz
         FWhQ==
X-Gm-Message-State: AOJu0Yxbuj0F9+0Djoqrjb57puXjNjwbrQt4sbIrLygHDjs8aVtiYbe0
        8DzXKak1yExOKiHMv2L8IbowYXUz7+tZKA==
X-Google-Smtp-Source: AGHT+IGrwRkApwIBUyU9Aa1YdurUlYYXcVbsmm8KFLXK1aHU1NRLk57RYde/DEQLfuRuL+h6mXKZ/g==
X-Received: by 2002:ac2:5a0f:0:b0:509:e5a4:2b03 with SMTP id q15-20020ac25a0f000000b00509e5a42b03mr2335132lfn.13.1700672900288;
        Wed, 22 Nov 2023 09:08:20 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l6-20020a5d5606000000b00331698cb263sm17503819wrv.103.2023.11.22.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:08:19 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [net-next PATCH] net: phy: aquantia: drop wrong endianness conversion for addr and CRC
Date:   Wed, 22 Nov 2023 18:08:13 +0100
Message-Id: <20231122170813.1222-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On further testing on BE target with kernel test robot, it was notice
that the endianness conversion for addr and CRC in fw_load_memory was
wrong and actually not needed. Values in define doesn't get converted
and are passed as is and hardcoded values are already in what the PHY
require, that is LE.

Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
_swab32 instead, the word is taked from firmware and is always LE, the
mailbox will emit a BE CRC hence the word needs to be always swapped and
the endianness of the host needs to be ignored.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311210414.sEJZjlcD-lkp@intel.com/
Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
Tested-by: Robert Marko <robimarko@gmail.com> # ipq8072 LE device
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Replacement of net: phy: aquantia: make mailbox interface4 lsw addr
mask more specific

 drivers/net/phy/aquantia/aquantia_firmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index c5f292b1c4c8..bd093633d0cf 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -93,9 +93,9 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
 	u16 crc = 0, up_crc;
 	size_t pos;
 
-	/* PHY expect addr in LE */
-	addr = (__force u32)cpu_to_le32(addr);
-
+	/* PHY expect addr in LE. Hardcoded addr in defines are
+	 * already in this format.
+	 */
 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
 		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
 		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
@@ -128,7 +128,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
 		 * We convert word to big-endian as PHY is BE and mailbox will
 		 * return a BE CRC.
 		 */
-		word = (__force u32)cpu_to_be32(word);
+		word = __swab32(word);
 		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
 	}
 
-- 
2.40.1

