Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9E7F96D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjK0A3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0A3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:29:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C21F0;
        Sun, 26 Nov 2023 16:29:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b3e2f8ec5so13275655e9.1;
        Sun, 26 Nov 2023 16:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701044979; x=1701649779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcFK3Yx/QJzJGb4Zmy6oTVxw1trZEcqb4ZIR/f9ub9Q=;
        b=hKQFC30UIayOeZXvEVmqCFwKlHxR6t5H5FgNSDtOlDbIlohCM7ensc4jWJOWvZ5Vh5
         5z6vr9Mzl6dJL3rT19Hd2BUCKPXyTtg7GjkhvPoh6Zt7XuguPGNJWrZy5vm5nRpf0hS2
         xs6kY8sj6304tNaAkAwD43+JdLfZvXFWwORvyMQzbJTQepK8kI9Yt7BNyU6u2E6qX352
         6La0wlzbraFspunXwMS9U1Rz0fZLcOW8PQROPVIz0QjTHJS918VsFY3LlSqHDUi9b+Gc
         5DGUh7zsBiMF95IFjvtWdv5sTP4AnRT7ISpn4SdtCP+I8DBOunc+EFUtQj6tPbM8ebNs
         QqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701044979; x=1701649779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcFK3Yx/QJzJGb4Zmy6oTVxw1trZEcqb4ZIR/f9ub9Q=;
        b=YrZ/E/FGGU9Gs6/sMW60KmpiU171w5kdMsOmdbZXujrptotjrw1ALgKHSLRvac4QLR
         j8hRX5mXZjTjpDW8W9jlycwIuLDzlWo83wgjchIsRak0UKbqhSdkRxcHhj+cusomeUFe
         suqGJXgYK0UZN829BnwqxjZJ0MG4e7JUDEV+lFF6zbhfWknk7N3anjEptkWzVv3Q/P4C
         g/yn8EvNQaaE7jzZYuYJm9OAlzEVd3PWXxTC3TrRtoKHsDllldT+gF/uCM/oqPn/xWsW
         oirmZWxxNn2+6fzjV1kXkbb9qV1As6mm6RcHtlANW77G0PF5J11Ds/zXHvyRW2UgmlVs
         1K6g==
X-Gm-Message-State: AOJu0YzjI++T8Re8iDbAt9XGA+Dxpgurt+wJ9i5MX5hWIgq7MOXEryuT
        UETQUb3dLHeQjkZb+zLBDbA=
X-Google-Smtp-Source: AGHT+IH0uBaB84sBRQtoWIfccLD7ghqlg8zpRMgxbcaK9sc6DFlpjLI23tKsMbLa2qjtf4jbMPK3yA==
X-Received: by 2002:a05:600c:1d24:b0:408:3696:3d51 with SMTP id l36-20020a05600c1d2400b0040836963d51mr7524526wms.4.1701044978625;
        Sun, 26 Nov 2023 16:29:38 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id i12-20020a05600c354c00b004060f0a0fd5sm11738625wmq.13.2023.11.26.16.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 16:29:38 -0800 (PST)
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
Subject: [net-next PATCH v2] net: phy: aquantia: drop wrong endianness conversion for addr and CRC
Date:   Mon, 27 Nov 2023 01:29:24 +0100
Message-Id: <20231127002924.22384-1-ansuelsmth@gmail.com>
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

Use get_unaligned_le32 instead of get_unaligned for FW data word load to
correctly convert data in the correct order to follow system endian.

Also drop the cpu_to_be32 for CRC calculation as it's wrong and use
get_unaligned_be32 instead. The word is taken from firmware and is
always LE, the mailbox will emit a BE CRC from BE word hence the
word needs to be swapped on u8 to u32 cast on LE system.
This is needed as crc_ccitt_false will recast u32 to u8 and read order
changes between BE and LE system. By using get_unaligned_be32, word is
swapped only when needed resulting in the correct CRC calculated.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311210414.sEJZjlcD-lkp@intel.com/
Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
Tested-by: Robert Marko <robimarko@gmail.com> # ipq8072 LE device
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add further explaination in commit description
- Fix wrong CRC conversion and swap only when needed

 drivers/net/phy/aquantia/aquantia_firmware.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index c5f292b1c4c8..c12e8a3acb77 100644
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
@@ -113,7 +113,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
 		u32 word;
 
 		/* FW data is always stored in little-endian */
-		word = get_unaligned((const u32 *)(data + pos));
+		word = get_unaligned_le32((const u32 *)(data + pos));
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
 			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
@@ -125,10 +125,10 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
 			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
 
 		/* calculate CRC as we load data to the mailbox.
-		 * We convert word to big-endian as PHY is BE and mailbox will
+		 * We read word as big-endian as PHY is BE and mailbox will
 		 * return a BE CRC.
 		 */
-		word = (__force u32)cpu_to_be32(word);
+		word = get_unaligned_be32((const u32 *)(data + pos));
 		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
 	}
 
-- 
2.40.1

