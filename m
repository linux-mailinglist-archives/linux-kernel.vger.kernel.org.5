Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC6754647
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGOChU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOChS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:37:18 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314563599;
        Fri, 14 Jul 2023 19:37:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a3e1152c23so2016164b6e.2;
        Fri, 14 Jul 2023 19:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689388636; x=1691980636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZWD5wI7aQZtKows5JDdwDPppTOpPhqsw3nsGnyPx3k=;
        b=TKvzFu9skGmveaSJeAz9sONeaofvnO7I1WWHu6U4T3YrUK1zyAq7TeN7X7GUXZ8ZAv
         Q+VgFEYQPjeCFNQMjnPkRgzImVoRAbKtFGSFu2o/gyR/zw5Az3OVFLqt8L7w2oA8qa9I
         YP/I+Gs5lOyANe61w9p5XJbGHvT7uvzyfACVqgq4ICRNeu82Lb4Xeehd68RnbaHdsSlI
         11gPdpw03yEygNEhYf845USg33yUpLHx92LolDFebQIbicuEaayn87j6xZnZNCf69AaZ
         N523OJ9NUNjRIWIxmhWEyEyIk/ornYTelB1W1YWISMvonbl2crjZaMwCTPJeqEO1k1Bv
         lahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689388636; x=1691980636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZWD5wI7aQZtKows5JDdwDPppTOpPhqsw3nsGnyPx3k=;
        b=iHFXEUN1wTOov7nXhRwst+KAxYzqgl5QSSxbDIkoziUuyvD1A2ULYrpnWXcG+FxNPz
         RjQ5JtaFsxuF83brPtfCvnE5dyuxLFAaFNRPSOSKEI4pmNkM416wRLXjZe6ym1NvDou9
         dN10ETMPEd4MYEGZS/crJWxa5tNA7lEX0AojYaQchVZbGB0YzEd4MVi3jvsT/NHTJMPq
         KGU91+zJbpPdijCgRR6w1lAqvwOg8deb4OWqI99PQq3IjUSDTAlvdEF020uO5Ckhj0fo
         nVgMDp7+yC7eUD/vXH/TJwFhg0gcjgDumNATndT7r6c8lcp/al1bomyPMSH8wQ/aUxxz
         6A3Q==
X-Gm-Message-State: ABy/qLYchIDwiusUYrj6tTxi1fbVct9xm6q9oonRerb+57ILCbh6jXsA
        AjTzJaOkzpNGEZ/ioEFPqmc=
X-Google-Smtp-Source: APBJJlGypWlkZIQjrlEbOxsFsR/hnteWZWQ8FU1ls+Ph5ZV8KUGrZ9WnQHB39A77zZpkyX6KgeR2+A==
X-Received: by 2002:a05:6808:574:b0:3a3:ed19:8a25 with SMTP id j20-20020a056808057400b003a3ed198a25mr7437604oig.3.1689388636308;
        Fri, 14 Jul 2023 19:37:16 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.132])
        by smtp.gmail.com with ESMTPSA id p6-20020a637f46000000b0055adf339c35sm8151029pgn.31.2023.07.14.19.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:37:15 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     claudiu.beznea@microchip.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v5] pwm: atmel: Enable clk when pwm already enabled in bootloader
Date:   Sat, 15 Jul 2023 10:36:53 +0800
Message-Id: <20230715023653.56872-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The driver would never call clk_enable() if the PWM channel was already
enabled in bootloader which lead to dump the warning message "the PWM
clock already disabled" when turning off the PWM channel.

Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
the PWM channel was already enabled in bootloader.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/pwm/pwm-atmel.c | 50 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index cdbc23649032..4dd6e1319343 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -36,7 +36,7 @@
 #define PWM_SR			0x0C
 #define PWM_ISR			0x1C
 /* Bit field in SR */
-#define PWM_SR_ALL_CH_ON	0x0F
+#define PWM_SR_ALL_CH_MASK	0x0F
 
 /* The following register is PWM channel related registers */
 #define PWM_CH_REG_OFFSET	0x200
@@ -464,6 +464,45 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
+static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
+{
+	unsigned int i, cnt = 0;
+	int ret = 0;
+	u32 sr;
+
+	sr = atmel_pwm_readl(atmel_pwm, PWM_SR) & PWM_SR_ALL_CH_MASK;
+	if (!sr)
+		return 0;
+
+	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
+		if (sr & (1 << i))
+			cnt++;
+	}
+
+	if (!on)
+		goto disable_clk;
+
+	for (i = 0; i < cnt; i++) {
+		ret = clk_enable(atmel_pwm->clk);
+		if (ret) {
+			dev_err(atmel_pwm->chip.dev,
+				"failed to enable clock for pwm #%d: %pe\n",
+							i, ERR_PTR(ret));
+
+			cnt = i;
+			goto disable_clk;
+		}
+	}
+
+	return 0;
+
+disable_clk:
+	while (cnt--)
+		clk_disable(atmel_pwm->clk);
+
+	return ret;
+}
+
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
@@ -496,16 +535,23 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.npwm = 4;
 
+	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
+	if (ret < 0)
+		goto unprepare_clk;
+
 	ret = pwmchip_add(&atmel_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
-		goto unprepare_clk;
+		goto disable_clk;
 	}
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
 	return ret;
 
+disable_clk:
+	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
+
 unprepare_clk:
 	clk_unprepare(atmel_pwm->clk);
 	return ret;
-- 
2.25.1

