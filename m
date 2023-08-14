Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69977BCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjHNPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjHNPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90A10C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so7073537e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025975; x=1692630775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu5wgrby+aWezgOUb3gHoMCl+XR0Y7Fji2fknL0oJ5Q=;
        b=vjcLYDP61hU7VME07h7zl4x07VmWeOyVjlag6OshKhFfj+Ynp2HzTFOLxgiYdzNq4L
         qiZhrGTRAUN/kZHD8I5cmqsFiUii1xznAPn14I0neq4F1dXhIHBIOkJcptU0VThW4Ram
         bk/qarbDSx637L+OIQ1wAF3vUVocl+TuA7A0zGv0UJj9y2lA1T2YXUjcqRP54oT6dEpO
         reJ4SLVg7ZcpbyS+0EOwBDKRXCjTneP+yDwJz60J6tDrawcDa9DowT0W+YfOu28uV6yv
         CMf8fjTMqDBgl8bs2XqN5/C4t69NnVPBYNKlp2rqRs42ALZYMGrO9OGy51ig7qmU75tV
         3uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025975; x=1692630775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu5wgrby+aWezgOUb3gHoMCl+XR0Y7Fji2fknL0oJ5Q=;
        b=ivmwZu8dmrTtMHJ+e6xM/qzbH39qK02x0tEKzYZJvZthbfFcpW3SuC/blQg0cJvVXr
         OZbO6kML4gTDu6t8jHyVYCgXq6waJg0aK3mO0XyI6uvwGSF7+wXDSWFn9RWnF5wiv1pU
         ZF9ocHqPGOcxfZyQgjf1SuZqZWe0ANZRiVDAoXI3mRYcDG+wqhs0xNlBSpwus+RTWeaE
         flzymubGgDJHES4IVyNuMlynrsEJy0w5nMJ+B6BZK1RkoM20DG2EokTTuOjrTnkOhvXY
         91FRS3j0CITlNFEW2Kjo+NNCLg1ZYhPZKF0T2pKfM7Mllh1H4/j247JKpm0JbgJuiapZ
         0Mrw==
X-Gm-Message-State: AOJu0YyB2Ob2hxMK7oUHooGM8x6fMmz8BKVLESNEx3DFYmAQ1s5cnxhQ
        NOxWNW/fvsLOk7ITPtRoyavXpg==
X-Google-Smtp-Source: AGHT+IFZHTTYDCNMVdAnggwH+bH0hlimo9VZAlH0SWZbdqRoddr5Wl4rRJITKc0lO0lzM1X8LMxBmw==
X-Received: by 2002:a05:6512:3da0:b0:4f8:71cc:2b6e with SMTP id k32-20020a0565123da000b004f871cc2b6emr8958353lfv.33.1692025975644;
        Mon, 14 Aug 2023 08:12:55 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:54 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 07/13] media: qcom: camss: Assign the correct number of RDIs per VFE
Date:   Mon, 14 Aug 2023 16:12:37 +0100
Message-ID: <20230814151243.3801456-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---
 drivers/media/platform/qcom/camss/camss.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 0e39d123a2113..6114ea15fd4a0 100644
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

