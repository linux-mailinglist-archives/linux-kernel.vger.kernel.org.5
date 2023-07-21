Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C375C841
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGUNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjGUNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:50:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D9273C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3144098df56so1676668f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947415; x=1690552215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=S5dWitbnh9elOa2q9vS/O6dNz1JkoENscNstuy3J7BNYk2/m6k98E8AxiKJ9977QL0
         lNIQK2k8JE2UxkxW4th6c5WftiHUIyB4ad7eNknbEG64kQ4l3PYKxLCveUL1J2VNg0Q6
         +aaO0a6lYfije4SM6F+8KmfcM2mckMmuOeRmp+ySYNV2fTIFcquqbtvPgdoJI7ub1k6p
         9Q5Sm8/u6lVDPHdE+Hwr7mYb0V3/qAN3/fXBn+yDAdxzFVLkeGotnjp8Q1HkP1ndu/YP
         FKacxuXIPmcNETfgkQbNu7V8K6YDFzSlVT8Araax1YIHfa6gBpJblvTiCS76KRE0i7DY
         EXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947415; x=1690552215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOPR69iAQ16PRI3TWa1E2gZcgSDBVpUe2mB3Tg7XdFY=;
        b=LtU940GdV3AAoGelsxktuMoF20uy8TTiX0ltx0jlxBL68tsx60nvlJRwflgow47UAm
         RkUFvmLAKfNNu+dEWTI81mXjzftn9fQD/7VnVo8PoOtYU4mQq7dK/ca8UJ68rgoWShlc
         az44ZwhAR7WAPqORf2kzxOq9oAs5UMNOxjn+fLMO+InBAN41NB+cbdIVfasPSfo+glcg
         VbTXhZAyRyW6hEl6U3KK5CiCp3BTF/FyuaCuZIDuwYqI7uhTx33RlXSa6utoGyVu6JRI
         DwKs0ytM83/MCg7paTqczmN5v1Ruo6ZP9wH+z+DPm4Nk8xgbYyap+fAKmc09peXmwkCT
         zQiA==
X-Gm-Message-State: ABy/qLapEnjx/U7jU/w47G5T0DSxPX17dyQ+K452nI/hPJbr7cB2B6+v
        rRNGS2i6bIrW4Ue6cIYIoI35xQ==
X-Google-Smtp-Source: APBJJlGCjLrz8H3xLH2x14w+MvjfgsC8U0tQjX/MTFt887k385qXdnC92hC6tULIF0jY3g+Vo6Dpjg==
X-Received: by 2002:a5d:6047:0:b0:316:e04a:29e8 with SMTP id j7-20020a5d6047000000b00316e04a29e8mr1699793wrt.54.1689947415101;
        Fri, 21 Jul 2023 06:50:15 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:14 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 2/6] can: tcan4x5x: Remove reserved register 0x814 from writable table
Date:   Fri, 21 Jul 2023 15:50:05 +0200
Message-Id: <20230721135009.1120562-3-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mentioned register is not writable. It is reserved and should not be
written.

Fixes: 39dbb21b6a29 ("can: tcan4x5x: Specify separate read/write ranges")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/can/m_can/tcan4x5x-regmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-regmap.c b/drivers/net/can/m_can/tcan4x5x-regmap.c
index 2b218ce04e9f..fafa6daa67e6 100644
--- a/drivers/net/can/m_can/tcan4x5x-regmap.c
+++ b/drivers/net/can/m_can/tcan4x5x-regmap.c
@@ -95,7 +95,6 @@ static const struct regmap_range tcan4x5x_reg_table_wr_range[] = {
 	regmap_reg_range(0x000c, 0x0010),
 	/* Device configuration registers and Interrupt Flags*/
 	regmap_reg_range(0x0800, 0x080c),
-	regmap_reg_range(0x0814, 0x0814),
 	regmap_reg_range(0x0820, 0x0820),
 	regmap_reg_range(0x0830, 0x0830),
 	/* M_CAN */
-- 
2.40.1

