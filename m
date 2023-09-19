Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF17A5EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjISJzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjISJzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:55:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21319B6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:54:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso700821766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695117251; x=1695722051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmXgnmvOiVfooj4M23wQXodnaTVsRKoq6QYvvY7fqHM=;
        b=RgQyoqUm11pRry9dUDKqKUxVvTI2uVecQ2JniY1b3jBaAKIkQB3UZb6B3YcCKXUXaf
         OT6KuGJuX0mDfVrGdMKsYB5ZyO5oY5/Q5Q2iTNdm5LZZeGW67c2fNvtmlJIWeUncBlyq
         XLua7I+5+CQ1K9KC9Z3e9kxqYf/zhl0vsIVU2iZkxLgACELaFfggRdSzq9JVj5gFTDpM
         yLPJUltHgzM49H2mY4Mkp8aSHbWg/E5UvU0QB30jTg1u2p/+oaaILpIG8rHGNBZFVj9K
         FCaXn1/F3e73NHlCXn4a7TX0RG9iapgjtGEyL4xlh225FEKIei0klikQj+UN1Pjambrr
         9YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695117251; x=1695722051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmXgnmvOiVfooj4M23wQXodnaTVsRKoq6QYvvY7fqHM=;
        b=iy/ZXu315+0TNKW4y4FOvikSQiJwLxumUrwMqtjbBzXJxdIPa81CHGXfd4UmtBJIoL
         bbORuNXQAr3xaFN9Jz8n8eKarpUBLkqRLREF5ASV62D0ToO8EOA9sV3jIOesx8aktWHo
         2OiW+4yLs0b0ET1aYmgwWuIgvPFRVdutWDrR6jtQnpjkumQ7enprQBNpTyI8iLsNA25L
         F/zmItA5lz776mmIRjBBRXXdKHrO3YObqE+TkaxcL/9aPL27cS21V9mSBqYvsuYZEGER
         b+Wbjfvt0+3mcx8Ia7lE4ZA+V/OizZEROdps7AIFal2mmx0wNDxIeRcFGEo69qgIAr1W
         3yrA==
X-Gm-Message-State: AOJu0YwQig2TL8O2mhJX9OI1gj0+EqigFfbGB63y4d7Y+nn/AhzVAlED
        Cdh4dfn1OUfChYmvRZTnCI7r/A==
X-Google-Smtp-Source: AGHT+IFD+/JR8bBXkKzRaOn6uW69Q1H71e3hBw6gpkPpcO6ABZxmcJoEcS7N9t36yAyaScr+LBt+gA==
X-Received: by 2002:a17:907:a07c:b0:992:bc8:58e4 with SMTP id ia28-20020a170907a07c00b009920bc858e4mr6491327ejc.20.1695117250517;
        Tue, 19 Sep 2023 02:54:10 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906198b00b009926928d486sm7521855ejd.35.2023.09.19.02.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:54:09 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sean Anderson <sean.anderson@seco.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] can: tcan4x5x: Fix id2_register for tcan4553
Date:   Tue, 19 Sep 2023 11:54:01 +0200
Message-Id: <20230919095401.1312259-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix id2_register content for tcan4553. This slipped through my testing.

Reported-by: Sean Anderson <sean.anderson@seco.com>
Closes: https://lore.kernel.org/lkml/a94e6fc8-4f08-7877-2ba0-29b9c2780136@seco.com/
Fixes: 142c6dc6d9d7 ("can: tcan4x5x: Add support for tcan4552/4553")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8a4143809d33..ae8c42f5debd 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -125,7 +125,7 @@ static const struct tcan4x5x_version_info tcan4x5x_versions[] = {
 	},
 	[TCAN4553] = {
 		.name = "4553",
-		.id2_register = 0x32353534,
+		.id2_register = 0x33353534,
 	},
 	/* generic version with no id2_register at the end */
 	[TCAN4X5X] = {
-- 
2.40.1

