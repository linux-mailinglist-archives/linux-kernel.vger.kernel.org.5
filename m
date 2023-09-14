Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9EA7A0F26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjINUom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjINUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:44:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB42120;
        Thu, 14 Sep 2023 13:44:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bfb17435e4so22512061fa.0;
        Thu, 14 Sep 2023 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694724275; x=1695329075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGJpt2wJkIR4MQJAzc96tFmQzqc/CQBVOhIv8wDwAYE=;
        b=ruPE46ibVme2AXEW7PXuvSASUTj6essHetQQJr7sDYMXJV2yFO+MEWvu9oYhn/jn6/
         uxbsDhuh3FFHZ7xtIL5QnoXd3KWk35JknbvaF0UrZwsIJ/mloXKYkUDxgPFqZrfDvsDW
         9uPg+cGIiQ90uo4qAGdyXPBZcbMXtOXBnKL7eSm6ryCTsyTvc8sxl1iPE1flVz6wubQ4
         BUKLfIMQYVnhzFSbtVyljJsEp5cAxKlPEjD3moY23oMcFtkmi4M7QI9hk5tkpNHRx021
         jcuI5KYKQ9RBBK64m0Mj53msMmJdO7H2QFApj91NfyAWq0EF3FTpkkGtAsaNQJLf0RtU
         3Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724275; x=1695329075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGJpt2wJkIR4MQJAzc96tFmQzqc/CQBVOhIv8wDwAYE=;
        b=aw0ah4nwwk9bIiuhr6HlldJMxN+mjgkS3YuhQNZS91ZB8SP8syfFksfmNeIOv4252g
         LQqg3Y1Xw3qgscRvRYPwgOTAQGwZF72DGy33a6Jns53yswIda/8y2VYs31DOBGqYaNb7
         jbdPp6QlXaW+d3OBjdztsLn3II0riYZUVLDmcq6OqlUvE0fyXaZcLtw5UhQS4e57q9cZ
         XMB6i+qcC/Jt6agCdBUDpnGOxkzXD31QxoMpYaUiNoJauQylo/utaqZbig1PKw6BNnHS
         yMAR3Ay55+Lt31mr505vA9mqpQL3qBHYI/gn3OOILzqd1a1jWB3wtdBXi2NfDP4N4wOs
         2/iA==
X-Gm-Message-State: AOJu0YzFBvdDoqWC2OSiCiKBonwEfwC9+ZBNnlZCbe2mBx6BvTSx7yno
        w/5EFAtUTFSXKGkGeSZgSyEME8zkJmGzznc+
X-Google-Smtp-Source: AGHT+IETPtOzXU0Nd+S8djM58NlJ+Sc+WunET0zuRYBwPOgezcTukkxAzx0/GQwvAzZVYB8A6arxmw==
X-Received: by 2002:a05:6512:3e0a:b0:4f8:e4e9:499e with SMTP id i10-20020a0565123e0a00b004f8e4e9499emr6230360lfv.12.1694724274569;
        Thu, 14 Sep 2023 13:44:34 -0700 (PDT)
Received: from localhost.localdomain ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id a28-20020ac2521c000000b005008cd93961sm396848lfl.192.2023.09.14.13.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 13:44:34 -0700 (PDT)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hilda Wu <hildawu@realtek.com>, Max Chou <max.chou@realtek.com>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] Bluetooth: btrtl: reuse define enumeration values
Date:   Thu, 14 Sep 2023 23:44:04 +0300
Message-Id: <20230914204404.1253141-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtlbt_parse_firmware function sets project_id defined like unnamed
integer constant. But later in the code (btrtl_set_quirks) project_id
is compared against values in btrtl_chip_id enumeration.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/bluetooth/btrtl.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 84c2c2e1122f..018d86410b88 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -60,7 +60,8 @@ enum btrtl_chip_id {
 	CHIP_ID_8723B,
 	CHIP_ID_8821A,
 	CHIP_ID_8761A,
-	CHIP_ID_8822B = 8,
+	CHIP_ID_8703B = 7,
+	CHIP_ID_8822B,
 	CHIP_ID_8723D,
 	CHIP_ID_8821C,
 	CHIP_ID_8822C = 13,
@@ -631,20 +632,20 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		__u16 lmp_subver;
 		__u8 id;
 	} project_id_to_lmp_subver[] = {
-		{ RTL_ROM_LMP_8723A, 0 },
-		{ RTL_ROM_LMP_8723B, 1 },
-		{ RTL_ROM_LMP_8821A, 2 },
-		{ RTL_ROM_LMP_8761A, 3 },
-		{ RTL_ROM_LMP_8703B, 7 },
-		{ RTL_ROM_LMP_8822B, 8 },
-		{ RTL_ROM_LMP_8723B, 9 },	/* 8723D */
-		{ RTL_ROM_LMP_8821A, 10 },	/* 8821C */
-		{ RTL_ROM_LMP_8822B, 13 },	/* 8822C */
-		{ RTL_ROM_LMP_8761A, 14 },	/* 8761B */
-		{ RTL_ROM_LMP_8852A, 18 },	/* 8852A */
-		{ RTL_ROM_LMP_8852A, 20 },	/* 8852B */
-		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
-		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
+		{ RTL_ROM_LMP_8723A, CHIP_ID_8723A },
+		{ RTL_ROM_LMP_8723B, CHIP_ID_8723B },
+		{ RTL_ROM_LMP_8821A, CHIP_ID_8821A },
+		{ RTL_ROM_LMP_8761A, CHIP_ID_8761A },
+		{ RTL_ROM_LMP_8703B, CHIP_ID_8703B },
+		{ RTL_ROM_LMP_8822B, CHIP_ID_8822B },
+		{ RTL_ROM_LMP_8723B, CHIP_ID_8723D },
+		{ RTL_ROM_LMP_8821A, CHIP_ID_8821C },
+		{ RTL_ROM_LMP_8822B, CHIP_ID_8822C },
+		{ RTL_ROM_LMP_8761A, CHIP_ID_8761B },
+		{ RTL_ROM_LMP_8852A, CHIP_ID_8852A },
+		{ RTL_ROM_LMP_8852A, CHIP_ID_8852B },
+		{ RTL_ROM_LMP_8852A, CHIP_ID_8852C },
+		{ RTL_ROM_LMP_8851B, CHIP_ID_8851B },
 	};
 
 	if (btrtl_dev->fw_len <= 8)
-- 
2.40.1

