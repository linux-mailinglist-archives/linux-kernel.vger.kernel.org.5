Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE47855B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjHWKpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjHWKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:45:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C603E54
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:44:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so236523f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692787497; x=1693392297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqMIPbw/+sU9M8KXenkrEeBNzKEqFkNbCna30dgzLCE=;
        b=HHuD0yRtb6li0CIt08gznOJSExeLkcRi9lF4E7+HpNgr1tPAA0ba1ZzSjkSl4a5d8d
         SvAu6Nzz5iOcBm3xRtQRf2amhqAGeLZFCkpWr8Tz71EZ4HaeVLgVNETCOOStJrFtK+WZ
         sTUkumfLQM5lbKZJ4f/VCqkgl2NvK86A5vc7jvnHUSi8vjZe6/Ygqeo6IMghUfSgiDtk
         dcLHaTG4C3fB37gYHlRKWw2OyiawsCtAIwQZW7+nDgIVuPeJPwR990xosoVZPI0g4m8T
         gvn0sRQETTIp1gjivGm9wj+Iw40YVRaDvFjwl3t3Fk2/WhCUatUjIoCw/lticfUgnUcY
         jKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787497; x=1693392297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqMIPbw/+sU9M8KXenkrEeBNzKEqFkNbCna30dgzLCE=;
        b=TgSFYvJT8948q4VNjcCSPlRZoSWP9gWD8X6bswX/V02MFwmgOrsOUZwReOVz+FAMsE
         jOyi7VXbF+8KqaI6/NixxTghrfZe2WeUcKYApeshFwHttwFCVyO0OR3cQsWqr+Uf9kpG
         KjoF5SZlkJh7F9qtG4rU6Rs5gFCmktOuTDNOLzycUayS/pNljgTWWFFesJKa/sTOv5sr
         Z2Isu6kbfdpgX4yX8Qd3i7Sz+IJOa259rG4ohQcZPaQ7OgiMhrr9lDtlQpti/3xDDzwN
         +wAcheZbLv1Ict2VtgUoXt3GyzOYMtn1WcbagxPX/u6mz5LfJ02HcSnIGe70jftiEMLS
         canA==
X-Gm-Message-State: AOJu0YxPEeWhMNCa+Kf7ttwA/0tOpHOvgd9AfiBuN83WDcW/X5J1hZum
        De/c8eFRDk0MYln8l4sMzBQvQw==
X-Google-Smtp-Source: AGHT+IGvqIkHBEWAIKtUtnUjKtr6E0LhjgO+LHZmNx5lQWLUxDPZon0nnlq785htbPPFwvN3gUZQRw==
X-Received: by 2002:adf:ec8a:0:b0:317:de66:259b with SMTP id z10-20020adfec8a000000b00317de66259bmr9560761wrn.15.1692787497210;
        Wed, 23 Aug 2023 03:44:57 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm6281213wrq.95.2023.08.23.03.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:44:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] media: qcom: camss: Assign the correct number of RDIs per VFE
Date:   Wed, 23 Aug 2023 11:44:35 +0100
Message-ID: <20230823104444.1954663-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each Video Front End - VFE - has a variable number of Raw Data Interfaces -
RDIs associated with it.

The CAMSS code started from a naive implementation where a fixed define was
used as a control in a for(){} loop iterating through RDIs.

That model scales badly. An attempt was made with  VFE_LINE_NUM_GEN2 and
VFE_LINE_NUM_GEN1 to differentiate between SoCs but, the problem with that
is "gen1" and "gen2" have no meaning in the silicon. There is no fixed
constraint in the silicon between VFE and RDI, it is entirely up to the SoC
designers how many VFEs are populated and how many RDIs to associate with
each VFE.

As an example sdm845 has VFE version 175 and sm8250 VFE version 480.
sdm845 has 2 VFEs with 4 RDIs and 1 VFE Lite with 4 RDIs.
sm8250 has 2 VFEs with 3 RDIs and 2 VFE Lite with 4 RDIs.

Clearly then we need a more granular model to capture the necessary data.

The defines have gone away to be replaced with per-SoC data but, we haven't
populated the parameter data with the real values.

Let's call those values out now

msm8916:
1 x VFE
3 x RDI per VFE (not 4)

msm8996:
2 x VFE
3 x RDI per VFE (not 4)

sdm660:
2 x VFE
3 x RDI per VFE (not 4)

sdm845:
2 x VFE
4 x RDI per VFE (not 3)
1 x VFE Lite
4 x RDI per VFE Lite (not 3)

sm8250:
2 x VFE
3 x RDI per VFE (not 4)
2 x VFE Lite
4 x RDI per VFE

This more complex and correct mapping was not possible prior to passing
values via driver data. Now that we have that change in place we can
correctly map VFEs to RDIs for each VFE.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index ce0d86e45fe48..c8b8ad176ee2b 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -124,7 +124,7 @@ static const struct resources vfe_res_8x16[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	}
 };
 
@@ -265,7 +265,7 @@ static const struct resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	},
 
 	/* VFE1 */
@@ -284,7 +284,7 @@ static const struct resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	}
 };
 
@@ -446,7 +446,7 @@ static const struct resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	},
 
 	/* VFE1 */
@@ -468,7 +468,7 @@ static const struct resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	}
 };
 
@@ -627,7 +627,7 @@ static const struct resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 	},
 
 	/* VFE1 */
@@ -648,7 +648,7 @@ static const struct resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 	},
 
 	/* VFE-lite */
@@ -668,7 +668,7 @@ static const struct resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe_lite" },
 		.interrupt = { "vfe_lite" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 	}
 };
 
@@ -796,7 +796,7 @@ static const struct resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = 4,
+		.line_num = 3,
 	},
 	/* VFE1 */
 	{
@@ -815,7 +815,7 @@ static const struct resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = 4,
+		.line_num = 3,
 	},
 	/* VFE2 (lite) */
 	{
-- 
2.41.0

