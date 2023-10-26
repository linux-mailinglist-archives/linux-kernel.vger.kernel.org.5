Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3D7D7FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjJZJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:49:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E99D;
        Thu, 26 Oct 2023 02:49:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cacde97002so4977745ad.2;
        Thu, 26 Oct 2023 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698313752; x=1698918552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trQmZAbaoRQLYbgSGHo4E3o4LgBwFck38x5wYn9EorM=;
        b=FNjiGQOfChB8nJFNbg3MbEMKsXgc1oONjFLFRsVfwYVBzwmuxkSe8Negrdo7IR7nRB
         R1NlgucrmrLzPnNaLNjXVr4lm30Q1ZJWU7RkJ6cqUPNuyhZHS3ZlstrJV/mUdioY8FXO
         5aQs3n2PZBeB2KPtTHKBDiI1lmdSYr/tkIpCm7ZoTkZFobKgCbMhOseTVumwzqnkhFcj
         dGLO2J/qKgwIGWcVK2G11/+qeRqLQzjw907Bh+VWOu05Gpuk9jV4i13ha8I/BwBN2DFo
         sEo5Eo/7XxpiJE8nfF9b4uVleqLe8sUrQNm/A8MUpeoIXiTqw0FHFkQE81OM1rwzqdZA
         jAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313752; x=1698918552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trQmZAbaoRQLYbgSGHo4E3o4LgBwFck38x5wYn9EorM=;
        b=Z6OcUt5R0i7WA4fti9j/GbFGgg+z8cxQKCjliIyELnJA12VzN2flgDgo/aE7rUYl6F
         Y/DqXPHndZObiAPbcF7kLFTMJ5MgaRLCYX+6xzCivGJNp3UGudUpMqdqrEN+zT/z2RgK
         vG99T07GPhkA47+ADWrfMqEy3W4eSFj5CQwYvhQ5wUQgmB1hdEH03CFAFyeOFgSy7PuT
         VLjrBouA7Wiovbm4AWNNOo22pncF0p133eDY3YE+iXQFmSDBcTFKTvM3U1S0TeKN+ly7
         KVYPIw7swgEAFqjemaKDjtVcVu8S9UWdZiz3galNEQARu77LxArp/qISw/pB0SCd3yFg
         +33g==
X-Gm-Message-State: AOJu0YxABW5YZTSGfgKQw98/XGM5a9yAFvA/UGge5f7vdk7nlmPjc8zx
        Sqr8Lq1zmsjbWJC1fn8mG0I=
X-Google-Smtp-Source: AGHT+IEY6OtenDK7uCoSvT5qxvLDxbjXEYrpn2zBZno+Rv6P5yQzWR32ht2pgfIh/xPY2jg4eMpn8A==
X-Received: by 2002:a17:903:41c7:b0:1ca:b26a:9724 with SMTP id u7-20020a17090341c700b001cab26a9724mr17622651ple.12.1698313751680;
        Thu, 26 Oct 2023 02:49:11 -0700 (PDT)
Received: from localhost.localdomain ([74.48.130.204])
        by smtp.googlemail.com with ESMTPSA id ji5-20020a170903324500b001b06c106844sm10674264plb.151.2023.10.26.02.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:49:11 -0700 (PDT)
From:   Furong Xu <0x1207@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 1/1] net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs
Date:   Thu, 26 Oct 2023 17:48:56 +0800
Message-Id: <20231026094856.986796-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
in Fixed PPS mode by default.
XGMAC Core prior 3.20, corresponding PPSEN bits are read-only reserved,
always set PPSEN do not make things worse ;)

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 7a8f47e7b728..a4e8b498dea9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -259,7 +259,7 @@
 	((val) << XGMAC_PPS_MINIDX(x))
 #define XGMAC_PPSCMD_START		0x2
 #define XGMAC_PPSCMD_STOP		0x5
-#define XGMAC_PPSEN0			BIT(4)
+#define XGMAC_PPSENx(x)			BIT(4 + (x) * 8)
 #define XGMAC_PPSx_TARGET_TIME_SEC(x)	(0x00000d80 + (x) * 0x10)
 #define XGMAC_PPSx_TARGET_TIME_NSEC(x)	(0x00000d84 + (x) * 0x10)
 #define XGMAC_TRGTBUSY0			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f352be269deb..53bb8f16c481 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1178,7 +1178,7 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 
 	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
 	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
-	val |= XGMAC_PPSEN0;
+	val |= XGMAC_PPSENx(index);
 
 	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
 
-- 
2.34.1

