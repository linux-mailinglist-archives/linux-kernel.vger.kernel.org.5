Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33010766BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjG1L3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjG1L3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:29:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A52B3AAA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:28:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so3472437e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690543733; x=1691148533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2Jmh76fX0cC8X5svQlpl0lqLBg/8T7Qn+TkbmMn87g=;
        b=S9h7ZBuCSi0Nut2p7zcsCvS49l7LMk2fQUD6ZCtk3vzETaAV/v/RbDrvVLeqW6KtKX
         dFAfEfF+YpNY7jutfP9MhLts8g94NsTU2yWUwRGiZDREjalRpF72DjJUPD87fuXOvpek
         db6axTaetmJVobJsOdNh5bVSpdIJv91xiwvfV/QM5cj6DSoRqW9bFjMI00ROFMcbfYXY
         gmuy4+XDI8AEPi445GKoex3AnU7NMRn2YNVDHokT7AK2CgHmvAvEFOtcnQepRhBqzCta
         JyO8cCRAr/7b6jIOi5nrjAtbUjeYzzvLQfXIf+AXNlV++0sKT1rDq/R7UI5nDKpfy64n
         uuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543733; x=1691148533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Jmh76fX0cC8X5svQlpl0lqLBg/8T7Qn+TkbmMn87g=;
        b=Vo88RxVsDz7AcRLjGDhONAv0nU7Bf3n+A1a19j5PBQRkjIwAgfAX0WBVyoH/FsO7Vs
         z2RZIaRY3LORBJr3qiiohrahN65Bk3n9+OiYKsTYLe3nS8AfGm3JkdFHsyI/zH/4Zf2U
         kQoZoXSHG6j7uawgvXDP4sl6Cl0Tq5pjVSGwz4tLTxPfH8NOZsQZC2br117GTWPoupXJ
         Co4QgItcKksS3C0n+nesD7sPt7HQeecubZEwLrS8Rr8rljJqEZLJzjX1BvYOcevYaiiM
         J2vEpM42++7iiwpLZZyWJpTDO/Ml64GT3+Xunrecg57aRe4BhTrI5Tg9hYmSggK4Doej
         6Tiw==
X-Gm-Message-State: ABy/qLaLK2Ufo0qAYV4qhP0yz+nImkwKjsCag9sYpGhsNSU2ORWKMVb+
        PZiR5XLLZUTe40iEB80h28g4Uw==
X-Google-Smtp-Source: APBJJlE8LHHYDebc1KhpOSqEnYawJSpwTyAliGv5Ek3/yrFTWhjeqVKhn92X3qglPd/utyr8ietUhA==
X-Received: by 2002:a05:6512:348f:b0:4fb:8616:7a03 with SMTP id v15-20020a056512348f00b004fb86167a03mr1331586lfr.4.1690543733205;
        Fri, 28 Jul 2023 04:28:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003fbb618f7adsm4011911wmq.15.2023.07.28.04.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 04:28:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] soundwire: qcom: handle command ignored interrupt
Date:   Fri, 28 Jul 2023 13:28:48 +0200
Message-Id: <20230728112848.67092-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728112848.67092-1-krzysztof.kozlowski@linaro.org>
References: <20230728112848.67092-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Soundwire v2.0.0 controller comes with new interrupt bit for
ignored commands.  Add code to handle it in the interrupt service
routine.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 3ae3e5896308..3061db6adac7 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -61,6 +61,7 @@
 #define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2		BIT(13)
 #define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2		BIT(14)
 #define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP		BIT(16)
+#define SWRM_INTERRUPT_STATUS_CMD_IGNORED_AND_EXEC_CONTINUED	BIT(19)
 #define SWRM_INTERRUPT_MAX					17
 #define SWRM_V1_3_INTERRUPT_MASK_ADDR				0x204
 #define SWRM_V1_3_INTERRUPT_CLEAR				0x208
@@ -792,6 +793,17 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 				break;
 			case SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP:
 				break;
+			case SWRM_INTERRUPT_STATUS_CMD_IGNORED_AND_EXEC_CONTINUED:
+				ctrl->reg_read(ctrl,
+					       ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS],
+					       &value);
+				dev_err(ctrl->dev,
+					"%s: SWR CMD ignored, fifo status %x\n",
+					__func__, value);
+
+				/* Wait 3.5ms to clear */
+				usleep_range(3500, 3505);
+				break;
 			default:
 				dev_err_ratelimited(ctrl->dev,
 						"%s: SWR unknown interrupt value: %d\n",
-- 
2.34.1

