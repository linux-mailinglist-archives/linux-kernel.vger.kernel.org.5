Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839AC79788C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbjIGQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242277AbjIGQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:48:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5121FE5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:48:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-501eec0a373so1866309e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105248; x=1694710048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12+DTZFXkG2owWWbljTCuZqxlyIGQ8q+rzU2uqt9NvI=;
        b=ig1X5qr1nIfOvTeCoBq79J7gV7gffGovSCD1sQM9R15YQSQoPycdxOStFUu+hm7ong
         HhW5alc5By7EbhH3OD4SjWhRCUX6B8uUeslW25m5CXkvdv9MyrlVVR8S5hFwo0wKqioA
         oVFQrR1SxX1w77BN9gAPnCv5MMIF2/LEKm9rlFcXOPb6StXU3C46zv5Yxby70/v6i/HL
         clYIw3joP8lB0ENNqLElrkIX41AH9QUEe/MKSv/wmqGweyTusqb/B95LLOqHqjoRp47k
         t9szyZkaG1vkbZgwufi6ri86KeI40jDC77NR4QddpPb/4oho+ZYIsXKmqGffNav32DfU
         2Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105248; x=1694710048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12+DTZFXkG2owWWbljTCuZqxlyIGQ8q+rzU2uqt9NvI=;
        b=YepWVbNO6UX7FsOV+/RfjYH+cdzIZa31h9dtLSjzkEHSIZefeSM5imMI/+CmKxwQOi
         FgaFLdWqAgTgbplEihkMI1PwIrAHk4HBwx1EYR/8FXAWxpzF/wHgweV8kMCgP4ePqvmE
         dkfiGxFNpcdpGd9unU+0zkjhLkXNmJjvUfS0Z4u/AbUAd/U/3x7apXpPK/9tcHofa8MK
         +P3+5unVShHZkTUx3URwg4yk9kpZnDov0ER73mzBqH8Q/V6vhsRn5WqJvfMjEcYutmDl
         eEB3wAh0BeFj/QqY86A7diFFo3EEyhfhHOVuUEuovDQXIxhKhauj0cEDb3eoRVubfaR8
         EjZQ==
X-Gm-Message-State: AOJu0YxAytI7USHlswzq2LS6I3JkpedK4+at/w4qERiy75WVV2yiHScj
        ZJ2G/dSOuN444rFX8Ih1PRe5YNRDwerrxxt+Sb0=
X-Google-Smtp-Source: AGHT+IEmqQIeynZQq8tWIXW+dw0WlocG78ZMWRShFxQCtRvuNcFwkxJ1oTDZoxEq9Fho2wtuqLBuVQ==
X-Received: by 2002:a5d:4538:0:b0:31c:e933:9590 with SMTP id j24-20020a5d4538000000b0031ce9339590mr5053146wra.33.1694105070513;
        Thu, 07 Sep 2023 09:44:30 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm23822145wrr.49.2023.09.07.09.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:44:29 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/17] media: qcom: camss: Functionally decompose CSIPHY clock lookups
Date:   Thu,  7 Sep 2023 17:44:05 +0100
Message-ID: <20230907164410.36651-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
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

The csiphyX_timer and csiX_phy values need not be hard-coded. We can
functionally decompose the string matching inside of a loop.

Static string values are brittle, difficult to extend and not required
anyway since the camss->res->csiphy_num value informs us of the number
of CSIPHYs and hence the set of potential clocks for a given CSIPHY.

In simple terms if we have five CSIPHYs we can have no more and no less
than five csiphy_timer clocks. Similarly csi_phy core clocks have a 1:1
relationship with the PHY they clock.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../media/platform/qcom/camss/camss-csiphy.c  | 37 ++++++++++++-------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 18f9a4defb2a4..87d6d65aa90cf 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -536,6 +536,15 @@ static int csiphy_init_formats(struct v4l2_subdev *sd,
 	return csiphy_set_format(sd, fh ? fh->state : NULL, &format);
 }
 
+static bool csiphy_match_clock_name(const char *clock_name, const char *format,
+				    int index)
+{
+	char name[15]; /* csiphyXX_timer\0 */
+
+	snprintf(name, sizeof(name), format, index);
+	return !strcmp(clock_name, name);
+}
+
 /*
  * msm_csiphy_subdev_init - Initialize CSIPHY device structure and resources
  * @csiphy: CSIPHY device
@@ -550,7 +559,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
 {
 	struct device *dev = camss->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int i, j;
+	int i, j, k;
 	int ret;
 
 	csiphy->camss = camss;
@@ -656,19 +665,19 @@ int msm_csiphy_subdev_init(struct camss *camss,
 		for (j = 0; j < clock->nfreqs; j++)
 			clock->freq[j] = res->clock_rate[i][j];
 
-		if (!strcmp(clock->name, "csiphy0_timer") ||
-		    !strcmp(clock->name, "csiphy1_timer") ||
-		    !strcmp(clock->name, "csiphy2_timer") ||
-		    !strcmp(clock->name, "csiphy3_timer") ||
-		    !strcmp(clock->name, "csiphy4_timer") ||
-		    !strcmp(clock->name, "csiphy5_timer"))
-			csiphy->rate_set[i] = true;
-
-		if (camss->res->version == CAMSS_660 &&
-		    (!strcmp(clock->name, "csi0_phy") ||
-		     !strcmp(clock->name, "csi1_phy") ||
-		     !strcmp(clock->name, "csi2_phy")))
-			csiphy->rate_set[i] = true;
+		for (k = 0; k < camss->res->csiphy_num; k++) {
+			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
+								      "csiphy%d_timer", k);
+			if (csiphy->rate_set[i])
+				break;
+
+			if (camss->res->version == CAMSS_660) {
+				csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
+									      "csi%d_phy", k);
+				if (csiphy->rate_set[i])
+					break;
+			}
+		}
 	}
 
 	return 0;
-- 
2.41.0

