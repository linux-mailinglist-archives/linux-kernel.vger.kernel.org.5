Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE078DF6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjH3TRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245468AbjH3PQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:16:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03B21A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so51980065e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693408589; x=1694013389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDUjhNsZiKuiQHQHANm264fa/+Px+b5VJ7MlnK/AAX8=;
        b=HQzHNxAPNqgPUiCbt2Mb/fHWWjH1lEu3w9iT0MiF7ZaUrpPL4VpcU3wdgROTAbDtif
         BBiuetDGn+FyV/f/A44dPXbTncbEfu95DB7pJviL9UWjQY1eDlMFYK4UPxsAi6FhuH3/
         65Q2WePwRm498+VOVrgQpYBOgnZqJ4EJGFZ0oMJcmeE0eZrkIDosYc6eiwj/UaM8pjn+
         FbP90e1GYiRqsHkW9ilf/gd66lOXaERd5vUJWtd9vRBffLxyTcycHFQqM093nzkfWVax
         /utKuj0E4GN0OmuX9MT4iOCtQJOJ7SumXdDP+hE42n7yTlb1gi8O5jUG3TVH/i7fwxk4
         C5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408589; x=1694013389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDUjhNsZiKuiQHQHANm264fa/+Px+b5VJ7MlnK/AAX8=;
        b=Q8LYG9jMh0QDkEv2c+jtBYAFgbIeo3cUkjbsRzYG8Q58u6pmMh6tzfBg8FBl4KB04G
         bKLRjwxfX2R/Oj06/+wFinK+9z1zjf8pUUzISrnttG1LYt6FKcNniH18r/DHctB6t27g
         zLD2n/mAxB0JF/ntzi7MndIhmU9kti686MZlYc4tifV4UnScT6b7na66/8Jcq5A8UeJR
         Zctzc7luMgat6eUKvjQTUsftWdrVXOOFE5TZEcimhxv+l+ufQhewaml2w0HhjwUZKe7T
         QBHEfHbAFs3bKQKxcljxZDAr7TdghJ1In/HI62UtSBMVmrf/TG4/aFbvbuY50AL7+/FJ
         4D+w==
X-Gm-Message-State: AOJu0Yx4XtF4eoHLCx7+eJcLpw3j96KOZRZe2U9+neIV0enkCITT1k5a
        xcS5nFXlI0WhuQ/83VSPbaUF9w==
X-Google-Smtp-Source: AGHT+IE9UqrL+pPJP8W2yTx9xqQ4WDHOKHVlKEroNve58lNQAMRLQBg5uzkYo4wAbnbWJdjNwG1UjQ==
X-Received: by 2002:a5d:4e43:0:b0:317:5182:7b55 with SMTP id r3-20020a5d4e43000000b0031751827b55mr1910128wrt.42.1693408589200;
        Wed, 30 Aug 2023 08:16:29 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d4d90000000b0030fd03e3d25sm16989961wru.75.2023.08.30.08.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:16:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 09/10] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater than 3
Date:   Wed, 30 Aug 2023 16:16:14 +0100
Message-ID: <20230830151615.3012325-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
References: <20230830151615.3012325-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VC_MODE = 0 implies a two bit VC address.
VC_MODE = 1 is required for VCs with a larger address than two bits.

Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 45c7986d4a8d0..140c584bfb8b1 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -449,6 +449,8 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
 
 	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
+	if (vc > 3)
+		val |= 1 << CSI2_RX_CFG1_VC_MODE;
 	val |= 1 << CSI2_RX_CFG1_MISR_EN;
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
 
-- 
2.41.0

