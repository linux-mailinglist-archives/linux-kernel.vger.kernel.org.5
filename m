Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31978E143
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbjH3VPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbjH3VPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:15:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183C110
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:15:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5008d16cc36so464920e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693430037; x=1694034837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUJsE/IbwViG0qWxyMqWmvpU5f67FtToTgIAN58/gnQ=;
        b=SU4TFEU5iPw8jHWmK8wq7KY9zoCgSHFSA3x+bPI3j9pJAvIlHHJBOY/6E9OtahIBuh
         0iaAd3OHRPx5/wl+I9RWRU5/87wwKRg6012+DDeeyIEcQLOs3jNJK8v4Fz+16APN7FAk
         /jplIHtuq3Mm41LVYu8oCeihZuyTI4en+p853JAPucR87iiYq5Y9O9/MnJkDrCIqKtyq
         nEbY2PTcRZ15/vS6DQZnLPp5dqIdnB2zkO06NQnz6n14g7EH7dX1Ma5caaEyesCY5a2o
         qHuZ/w8McnrsLkBOnRIYlgl6DLjp29chh/w2Qmjbi8/jtSf/VhM1ZLJB2c1IsYRT3JYZ
         1Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430037; x=1694034837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUJsE/IbwViG0qWxyMqWmvpU5f67FtToTgIAN58/gnQ=;
        b=E/ubl3JtUJbmjDT7USHuHI6Ur+CP2RnbHAWpsG424J/+EjNFm/uTzuWn9xHeiaI6Lr
         KK2XNRvBYM2MSRslJArmUXAlYDgwEuXOAkPmqjJBqOHawar7og9eGrf5GxdRHZTa8yR5
         qZuhgZuTc06vxq2V5MMTisPL+2JFtWPnd/eVXDjuRqneclL7xC3GCwszwUqPd6JNQ9W7
         eWcM3tLBcc1XNmGJvaUpmTTYYj73bKmFvHHOE6CV3IVYu+MhtcnHkuYSh0iZ1GQ4k93R
         bVI9AjNMzFU/+eLcnKaU7lC4aG5YaCPanR8Ose88lYgXPtQPiK7AmY+H75MZiAA1As1v
         1wnw==
X-Gm-Message-State: AOJu0YzW9gQW9mY1VXqCC3luzusJJxT12oyouLIDn7qT9OzVcMhfhPhH
        A5D2cBYBaxwbV7Wq/ZUWP5wLUQ==
X-Google-Smtp-Source: AGHT+IFuvtSZyC/ZyAVYMYRqzuHbaGDwuwbCQZ6x1uKvm1iYzoVAGQXN7HtASDV8xE7fWPnZS3n/IA==
X-Received: by 2002:a19:e04a:0:b0:500:8f66:5941 with SMTP id g10-20020a19e04a000000b005008f665941mr2475516lfj.50.1693430036872;
        Wed, 30 Aug 2023 14:13:56 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25623000000b004f37bd02a89sm2516351lff.287.2023.08.30.14.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:13:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 23:13:52 +0200
Subject: [PATCH 2/2] phy: qcom-snps-femto-v2: Add REFGEN supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-refgenphy-v1-2-892db196a1c0@linaro.org>
References: <20230830-topic-refgenphy-v1-0-892db196a1c0@linaro.org>
In-Reply-To: <20230830-topic-refgenphy-v1-0-892db196a1c0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693430032; l=869;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rkGvm/uP3o+BPrXZ9OASaeUpr1X+J5fisqT1wJhd350=;
 b=nSuP6yC0wDbMiE97URjPi35b+qJ0KBMSeb/782bW8hUoixfduLz+NGIGXGWm0pI28AQBW/tWH
 CKJTBw7V3RlBkF1jGQOQXgGAKe5MgezRkaYRhIKsZrClHrTorwABIaa
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HSPHY is (or at least can be) one of the users of the reference
voltage generating regulator.

Add it to the regulator bulk data.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..2bc9aeef26f9 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -79,7 +79,7 @@
 #define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
 
 static const char * const qcom_snps_hsphy_vreg_names[] = {
-	"vdda-pll", "vdda33", "vdda18",
+	"vdda-pll", "vdda33", "vdda18", "refgen",
 };
 
 #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)

-- 
2.42.0

