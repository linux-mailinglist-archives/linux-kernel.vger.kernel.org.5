Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C06790CCB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbjICPhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:37:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E6C7;
        Sun,  3 Sep 2023 08:37:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1e128135aso3073755ad.3;
        Sun, 03 Sep 2023 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693755447; x=1694360247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DfTZHovIdUMYDGPmEpLo2QSNP9WxkZc/VjLrGHKaVw=;
        b=fwT3FSD7fTPx/j86WS7SFMxQ8HWf15qLapuHKDiqAgtDpA9r5cdjaM5oZOeWEPWzhi
         aonSbKlsuQe1riNWFptTAw6hHrfG3d2UObfg2kw/y2dVV3QA8RRLk5MSUhrDIBRyrzdr
         NqGTP852TV4MOdMa70o+86+OU9djIm71jxDW2JyFbZ7DxQpg5pjJsSxpy24H5AJ3xzig
         6S18uNVKvvCfcbsrKvLkGCCKReaJkBSX0sR9aA1jDZWmmkxBbo4FFFEQ329nuv1ZL/2t
         YoZZEsAalbhG8trLe8zz+UwaOA6zbTbdDS6pyCutEcS814WaBWDcOpAsSj8X9fvwgVW3
         LOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693755447; x=1694360247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DfTZHovIdUMYDGPmEpLo2QSNP9WxkZc/VjLrGHKaVw=;
        b=BeMkJOEQOToSu8MRyMWP1lpkpi5ol7GAaIzpxDn9qqCuN+3lHMq/8qTIfMgL/ZWV3M
         iOb+SkIMpqcUeHYO09kaqTD27iVNFOXm+dQSiBTkskBK2FKziKXgGQNYCLbR1F1WzfDk
         wNr7lltY2vohoGCckfTAcIp+H6wWVxad+q/7uLjyaY7KEQSvXrRVNOj8NqSro/swRzkH
         h5FKB9L2Gou5m/aTNBfQiZ4IuaGpkjphB67kbzP21B0MZeDGGOkpt5h0Vo/dmPVDqUtV
         O6LQTDxRfxwPunygcOW1Vrz1DTZo6jHsM5vG5Y77GVXnVuiRBCmcXCVBZNhqi6CXImiR
         C+Sg==
X-Gm-Message-State: AOJu0YzHQ86XxddneW36zYDaR6QR0LOXHDZznGwAhBvwzLVuDlOWSNEF
        riuQEU0jL1maAzS/GK8l4g4=
X-Google-Smtp-Source: AGHT+IE5Z1iNZPydnLBYJhgD3sVTgJOvwuUpePMXEwNvGIyos7aJM3kzjjf4Kq9Pm6xgerSsySzi1w==
X-Received: by 2002:a17:902:b490:b0:1b8:b3f9:58e5 with SMTP id y16-20020a170902b49000b001b8b3f958e5mr5831083plr.38.1693755446919;
        Sun, 03 Sep 2023 08:37:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1011:af96:d1f8:ecc9:8e40:2f2])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001b03cda6389sm6015697plo.10.2023.09.03.08.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:37:26 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that can never be negative
Date:   Sun,  3 Sep 2023 21:07:20 +0530
Message-Id: <20230903153720.3801-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

In struct mpc512x_psc_spi, the variable 'irq' is declared as an
unsigned int. The comparison of variable 'irq'  with signed int
operand is incorrect. Also, the return value from the call to
platform_get_irq(pdev,0) is int and it is assigned to an unsigned
int variable 'irq', thus redeclaring the type of variable 'irq'
to signed int.

This fixes warning such as:
drivers/spi/spi-mpc512x-psc.c:493:5-13:
WARNING: Unsigned expression compared with zero: mps -> irq < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the commit message

---
 drivers/spi/spi-mpc512x-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 99aeef28a..5cecca1be 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -53,7 +53,7 @@ struct mpc512x_psc_spi {
 	int type;
 	void __iomem *psc;
 	struct mpc512x_psc_fifo __iomem *fifo;
-	unsigned int irq;
+	int irq;
 	u8 bits_per_word;
 	u32 mclk_rate;
 
-- 
2.25.1

