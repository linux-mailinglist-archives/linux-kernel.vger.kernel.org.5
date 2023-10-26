Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000057D7D13
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjJZGyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZGyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:54:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE6129;
        Wed, 25 Oct 2023 23:54:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso7745131fa.1;
        Wed, 25 Oct 2023 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698303250; x=1698908050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srvEl7OZJoPuWUItHjd1Kt+4fj+b0eLI3nZeUM1n7J8=;
        b=T0AbLenZidaRxojCcVAzlbxm/DweKPvKCFLljwmVQc2FWfQh/iGKAzCyWaQL19n1lB
         Yx4LbVRkH4+c5NzS0h7j5xUxCaJt8meDl0+624x4BGiyc8OnwmYoVP6X/xBzY/F/3I5H
         u1lFD0ZkGaVkyVS/Zsm6zNC2/u2DppMMmMamnu1/gbU7pm8fgilYLnKIcjLKTw+uAGBe
         ceumc5Z25ZrhhusKM7sa1gS1+zh49bG73GkRwdk3CB9hNZLbMjiyD+Q3u5W0L1mLTJem
         UZLzqWhpGw8ZHHucRnKmUS7hcfiyNZd8jCFAQDt91SSZHAL4peUEtYTra1YEOxg3gmfG
         hZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698303250; x=1698908050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srvEl7OZJoPuWUItHjd1Kt+4fj+b0eLI3nZeUM1n7J8=;
        b=Pztw7IfvM//t35afF8/Xa3dfbNdtFBuLyZ48BdLpyKxf6aiPo4QhjXokwzQyeeZcZ8
         ZSXioQ6p1eZMCOwPp/ZKV15p8S2ucKGuWlifonFoWdL+gSXeFNpZqofiTppK/MYyKENt
         8g1PPjWrcRQAbrsKtrXS8VHCEMN7z1HAETjg1opZKeOinjpDRt249Y/qxrcmOHEh22h7
         MRwWNgPsRjgIlquwKwO/CR+6Gg1dfBAkwHMbGJQnEfI2vY98YYoRBCmZ6q1oHsn2h0VU
         EsoUApgwnKXicKHmeaEhxB8asvMKGSXXTwbzaJdK2DsbafaJ4AhzMAxXV3NCLf+WQe/P
         4X1w==
X-Gm-Message-State: AOJu0YzVlvJBKchFOJEt+Dxf/SgOaxTnW8S0M2AZZnIWXuLqVUu1bBVy
        GApUJHxjJo4r4NrKSgTz06Q=
X-Google-Smtp-Source: AGHT+IF3/j5S7BAqjTOB9zlrbZQcOywG0uYzXAE3wYNmYEQ3zKrG/HMMag7Ul+n/8rgWy5pfKBFizQ==
X-Received: by 2002:a2e:a9a2:0:b0:2c2:9536:baff with SMTP id x34-20020a2ea9a2000000b002c29536baffmr15286873ljq.29.1698303249705;
        Wed, 25 Oct 2023 23:54:09 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0040839fcb217sm1671560wmb.8.2023.10.25.23.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:54:09 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: microchip: ksz9477: Fix spelling mistake "Enery" -> "Energy"
Date:   Thu, 26 Oct 2023 07:54:08 +0100
Message-Id: <20231026065408.1087824-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 2534c3d122e4..b102a27960e1 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -83,7 +83,7 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
 
 	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s\n", port,
 		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
-		pme_status & PME_WOL_ENERGY ? " \"Enery detect\"" : "");
+		pme_status & PME_WOL_ENERGY ? " \"Energy detect\"" : "");
 
 	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
 }
-- 
2.39.2

