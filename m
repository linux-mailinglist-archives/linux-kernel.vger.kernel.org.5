Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879F37FC1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjK1N7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345275AbjK1N7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:59:40 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A685;
        Tue, 28 Nov 2023 05:59:46 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so68078021fa.3;
        Tue, 28 Nov 2023 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701179985; x=1701784785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1+2rF99RIlk0tjgM2uDSY6T9EFLrajDJx6/gd5QzVw=;
        b=Vp2msTLEpRyt2LSJFUCuvP8uzek8VAp25TzvVp2M8JwhK76Hey+fehlXWgyONYTUxj
         kMURVvCi9d5xOxC8EjMl20yBdTKSQxroQ/4a1mhRZEjbsvH1J3E6uquV78J7Z0HApkoi
         YS/UTMZ1jdBYQn/tZJVF0eioN8giZw1XfLFLcY/OI4jvcRqpPpDOaAUbdOTIHKcvANTM
         HPucg151lSdvJ2qswE5c9qT8xhmhlNzSqrNdlCCme74h9eTzt9ZzI0CDvMTiQ3jKTDgv
         p/f2dz9efk3PckC7SknCLbW2pxtHGSwJWjn9+o0g38koZ+xQuVMUBk3GVMWRlIM9XmSo
         gD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701179985; x=1701784785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1+2rF99RIlk0tjgM2uDSY6T9EFLrajDJx6/gd5QzVw=;
        b=fEccCJsA7neO+pXds9+sax23pP3XrFdgPCQDmnbji21DsiSIqY6E37kwqlHz2E3ytH
         ZYUCP1nHtyQKVV8W5XFFXi2GpT6jlyyH8okFuzBlvXuin9QjKR4TyqwXaGJgNKTKorv+
         JY//1vT1qp3V8hPwnzcdyUuze8Ll01kjrMgxKahEfOh0Kggst7v+bVb176BIBje7IVxs
         VnGhsyxvPiUHeGkT9BeoqQMW/AIQBg4+/RqaJ0C/AEnlAiHHHjdlaORJtAdyFZff+ej3
         qhqwz4+XHciy9srZ6+HESqcwYwhssuJM+yXEM6etXsxdiJaNv89Tof/WDWZYXVD/E4ds
         B11Q==
X-Gm-Message-State: AOJu0YyNbguA0OQVGMxelLPzkYGII4o9s3ux9dh9ZNBAPmQcpNOrIjOl
        byEoZa9l5elkrv15liBvBJM=
X-Google-Smtp-Source: AGHT+IFv4VKMOMWs3MsKFxq94yoWwi2fsDLXN0TjQ2O517oz0RblEWnGPgPHwfx8nl1TrJt/tgQ5mQ==
X-Received: by 2002:a2e:965a:0:b0:2c8:8bba:c09d with SMTP id z26-20020a2e965a000000b002c88bbac09dmr10509568ljh.9.1701179984334;
        Tue, 28 Nov 2023 05:59:44 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040588d85b3asm18395156wmb.15.2023.11.28.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:59:44 -0800 (PST)
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
Subject: [net-next PATCH v3] net: phy: aquantia: drop wrong endianness conversion for addr and CRC
Date:   Tue, 28 Nov 2023 14:59:28 +0100
Message-Id: <20231128135928.9841-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On further testing on BE target with kernel test robot, it was notice
that the endianness conversion for addr and CRC in fw_load_memory was
wrong.

Drop the cpu_to_le32 conversion for addr load as it's not needed.

Use get_unaligned_le32 instead of get_unaligned for FW data word load to
correctly convert data in the correct order to follow system endian.

Also drop the cpu_to_be32 for CRC calculation as it's wrong and would
cause different CRC on BE system.
The loaded word is swapped internally and MAILBOX calculates the CRC on
the swapped word. To correctly calculate the CRC to be later matched
with the one from MAILBOX, use an u8 struct and swap the word there to
keep the same order on both LE and BE for crc_ccitt_false function.
Also add additional comments on how the CRC verification for the loaded
section works.

CRC is calculated as we load the section and verified with the MAILBOX
only after the entire section is loaded to skip additional slowdown by
loop the section data again.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311210414.sEJZjlcD-lkp@intel.com/
Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
Tested-by: Robert Marko <robimarko@gmail.com> # ipq8072 LE device
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Add more info in commit description
- Actually propose a fixed patch
Changes v2:
- Add further explaination in commit description
- Fix wrong CRC conversion and swap only when needed

 drivers/net/phy/aquantia/aquantia_firmware.c | 24 ++++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index c5f292b1c4c8..ff34d00d5a0e 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -93,9 +93,6 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
 	u16 crc = 0, up_crc;
 	size_t pos;
 
-	/* PHY expect addr in LE */
-	addr = (__force u32)cpu_to_le32(addr);
-
 	phy_write_mmd(phydev, MDIO_MMD_VEND1,
 		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
 		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
@@ -110,10 +107,11 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
 	 * If a firmware that is not word aligned is found, please report upstream.
 	 */
 	for (pos = 0; pos < len; pos += sizeof(u32)) {
+		u8 crc_data[4];
 		u32 word;
 
 		/* FW data is always stored in little-endian */
-		word = get_unaligned((const u32 *)(data + pos));
+		word = get_unaligned_le32((const u32 *)(data + pos));
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
 			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
@@ -124,15 +122,21 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
 			      VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE |
 			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
 
-		/* calculate CRC as we load data to the mailbox.
-		 * We convert word to big-endian as PHY is BE and mailbox will
-		 * return a BE CRC.
+		/* Word is swapped internally and MAILBOX CRC is calculated
+		 * using big-endian order. Mimic what the PHY does to have a
+		 * matching CRC...
 		 */
-		word = (__force u32)cpu_to_be32(word);
-		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
-	}
+		crc_data[0] = word >> 24;
+		crc_data[1] = word >> 16;
+		crc_data[2] = word >> 8;
+		crc_data[3] = word;
 
+		/* ...calculate CRC as we load data... */
+		crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));
+	}
+	/* ...gets CRC from MAILBOX after we have loaded the entire section... */
 	up_crc = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE2);
+	/* ...and make sure it does match our calculated CRC */
 	if (crc != up_crc) {
 		phydev_err(phydev, "CRC mismatch: calculated 0x%04x PHY 0x%04x\n",
 			   crc, up_crc);
-- 
2.40.1

