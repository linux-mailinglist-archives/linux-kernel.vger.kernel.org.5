Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DBD77BCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjHNPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjHNPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C2DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff1b5c93e7so2570285e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025977; x=1692630777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0Y9xd+Pad6+mtTQhoMXOE7QF4dtRzmv/Ky6w4Tfu3A=;
        b=el4m7gi85yGJ2Rs7TYZZykxEmiPkT5ps7mvfAidVWOVRdgmMz3EaltcJ0YaUsPBjk+
         NZNPPFITHVpERzencYGVHkuUTOIROl91h0zr6rWdHGJ5o44N/3N4CcCpJQnm2ep+A0V0
         fEu1vP0xFNVuK0IT+/RyW92j0QeoAz8FUQGvHKg3+XvX4uQw9SQAkaJh4bNLh7VOfKJK
         V7hYhVLv4SNFYuBszq3nD3k3DCkeOGN6dQxW+DtsNv+CACal4ZR6rz7r+eLL5wA43Og4
         /2f2MuIoTL5BZZgpxgl2eUNEoFlD6klwF83s0ljfCGYYJg7g8Rk03tnzbteameudOj89
         wCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025977; x=1692630777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0Y9xd+Pad6+mtTQhoMXOE7QF4dtRzmv/Ky6w4Tfu3A=;
        b=KJyt9KTalQApnHfebu/6EMYwWjR1ebpeWVhey1Jkq5aR9KCTdkWr1ifg3ZI1izGbJL
         reUi+a0FNitJ9oAPGknnzAhYDqocNRc5O2Qd7HKraJkSx+1+qUkkH3tM5hFG01kttD1d
         /Z/s4rt641awBOG5x7hhkm+uJp9eFVk7Xk3/41t1mEcZDHhcOCn9LuNl8GLvGfHtrF5R
         h8CuL0YVugP12RREBmnJME0phqqdUBFNOm8QA8xL+Og8nGs8uuOTpY27iJWpspFv5pmT
         IYDVPX+dS18BdS1ckegD0xl5TsVbYDpFNzdyMrtxTSVUO1jyLQuagni8ZsjSaT/OlRa3
         IzoQ==
X-Gm-Message-State: AOJu0YwqD6d1KZORVnGGMFXyhatV7gDCYBg3RZbMgf1F6/flGOyeynHc
        n8FWWkHdntWJvR7ymCymYWvbiw==
X-Google-Smtp-Source: AGHT+IHi9E2kY4yI4UvPkkciqTuO4mcOUPSlgi8q7FjbIfZny9L0ie6U+RL7ggWXXjmgsuELBnNYSQ==
X-Received: by 2002:a05:6512:3985:b0:4fb:740a:81ae with SMTP id j5-20020a056512398500b004fb740a81aemr8217185lfu.16.1692025977110;
        Mon, 14 Aug 2023 08:12:57 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 08/13] media: qcom: camss: Use >= CAMSS_SDM845 for vfe_get/vfe_put
Date:   Mon, 14 Aug 2023 16:12:38 +0100
Message-ID: <20230814151243.3801456-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From sdm845 onwards we need to ensure the VFE is powered on prior to
switching on the CSID.

Alternatively we could model up the GDSCs and clocks the CSID needs
without the VFE but, there's a real question of the legitimacy of such a
use-case.

For now drawing a line at sdm845 and switching on the associated VFEs is
a perfectly valid thing to do.

Rather than continually extend out this clause for at least two new SoCs
with this same model - making the vfe_get/vfe_put path start to look
like spaghetti we can simply test for >= sdm845 here.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 08991b070bd61..7ff450039ec3f 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -163,7 +163,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 	int ret = 0;
 
 	if (on) {
-		if (version == CAMSS_8250 || version == CAMSS_845) {
+		if (version >= CAMSS_845) {
 			ret = vfe_get(vfe);
 			if (ret < 0)
 				return ret;
@@ -217,7 +217,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
 		regulator_bulk_disable(csid->num_supplies,
 				       csid->supplies);
 		pm_runtime_put_sync(dev);
-		if (version == CAMSS_8250 || version == CAMSS_845)
+		if (version >= CAMSS_845)
 			vfe_put(vfe);
 	}
 
-- 
2.41.0

