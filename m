Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4976BE7B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHAUe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHAUeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:34:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E41FFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:34:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b974031aeaso94580841fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1690922060; x=1691526860;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8CNOi8uqBp0VRqFV2aTvXXvJ9qTZ+ISs6tIho5/zJFc=;
        b=jMrHmV0Fn1J9LZX9Q+oeZzwky5JFNfzWGfl20uxacjMXNtznmhPw8NwvkhfKZKSVfX
         pTST3SKomLEg5fSrIYfG5qdOrruHjXAMeqUOwOf5Nvlz3CWa7wtHQOAiVeQtNnkKvjP3
         nM6IWZpAy8L0ZweWxA86FHgwrCc+Hejj8ZCqDS/d3LEbYYFQyCdT1ig5jB7t/NmS8SBb
         3PzLN4AFCvSpGIt8XgG4LYwS2NB/jWPhZZMwsd+0sqnu7FhFlgG2Zu6unnMh/zDpuDqQ
         DgazoF46QIbM+8aqEyKytvSGnN9Dg8yt26oMfafamHGxVe8AAtf7jkVlY9H473FsqtDT
         D8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690922060; x=1691526860;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CNOi8uqBp0VRqFV2aTvXXvJ9qTZ+ISs6tIho5/zJFc=;
        b=Vwy1c5957usC4UO3h4hPdLGfiRLmlfHtw0syCpScpU8CCu3dRX5EYonvJZolIqm1wY
         LjXPir1mFZQANQX1kIHznOwqgpkNAuuPt7FbXcJe/WwAVF7poaaNevJk0SJ5vO0QYlX1
         m75b1Y6ANV5jtK0IWmNrlofa9WRcG+AHuFGP+V5gOCoH7C4MS5wSQG7z3BQdiVojvlbT
         sh9CQgjPYIRCB4Qegn9zzhu96wNAm/ft9dOKKdn/PNECCIRbZ3Vfd9ZN447xg4XG9V60
         WELUYTPOaRCTnZD8QnmMXG8Zjmu9Razeh3+tfitcDNsZ1sKt7Q0Z+lNvIEyAu3rSQlVX
         WAyA==
X-Gm-Message-State: ABy/qLZf25hRe9oUd4IYkL06F79qUGB1I1EL0sH2zu+zbIOz7zjMz7OB
        SBlC4Rv9AMKGg9Byu+JPfzjVsdiJrX1bv9uY4eER
X-Google-Smtp-Source: APBJJlE46sMvarfXUzqQY3u0s+ouqvsQOql4QLvrIpO8sJ5a0ka8FFJgcq8qtRzSEWzNqKvDaXV4X5I1x4D2G4JRLjU=
X-Received: by 2002:a2e:8256:0:b0:2b6:df5d:8e05 with SMTP id
 j22-20020a2e8256000000b002b6df5d8e05mr3245440ljh.33.1690922059651; Tue, 01
 Aug 2023 13:34:19 -0700 (PDT)
MIME-Version: 1.0
From:   Da Xue <da@libre.computer>
Date:   Tue, 1 Aug 2023 16:34:08 -0400
Message-ID: <CACqvRUZYH2NkOooE78SK6=Ow07y=YnE2QOSNzyb99rV4vSvxpQ@mail.gmail.com>
Subject: [PATCH net] net: mdio-mux-meson-gxl: set RESERVED0 bit in REG2
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first RESERVED register bit needs to be set in order for the PHY
to come up. Otherwise the ethernet device stays in "No Carrier".
There's no associated documentation for this register bit in the
Amlogic datasheets, only the default value to set for the entire
register.

This register bit is normally set in u-boot so it is not noticed in
Linux. During my testing with u-boot net disabled, this problem crops
up.

Signed-off-by: Da Xue <da@libre.computer>
---
 drivers/net/mdio/mdio-mux-meson-gxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c
b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 76188575ca1f..210a52d98112 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -17,6 +17,7 @@
 #define  REG2_LEDACT           GENMASK(23, 22)
 #define  REG2_LEDLINK          GENMASK(25, 24)
 #define  REG2_DIV4SEL          BIT(27)
+#define  REG2_RESERVED0                BIT(28)
 #define  REG2_ADCBYPASS                BIT(30)
 #define  REG2_CLKINSEL         BIT(31)
 #define ETH_REG3               0x4
@@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct
gxl_mdio_mux *priv)
         * The only constraint is that it must match the one in
         * drivers/net/phy/meson-gxl.c to properly match the PHY.
         */
-       writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+       writel(REG2_RESERVED0 | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
               priv->regs + ETH_REG2);

        /* Enable the internal phy */
-- 
2.39.2
