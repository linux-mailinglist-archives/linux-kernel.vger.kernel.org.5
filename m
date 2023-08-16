Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD377E468
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjHPO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjHPO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:58:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902C269F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:58:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so98286431fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692197878; x=1692802678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/Dhb70OK4hEGD5pj/9T1Ud8kYLrafnZW6YW0Jaj+4w=;
        b=GSbRu6Lwj5436wM5tdbSf4MtNpZI4hlWLLvF5zhtg/sFo3YPqZSp8zfOtrPqi7NVkT
         EwSs4eqa+yKmSXx2DMbI+oKfNOQmsHTC1PzrKUdtp/fa3fAujrBKtVzD3BVrYdqpMsDV
         a3V19ukrZcDgVPhcn1cUW03TQDW+qRvoDqIDNkfXjHKvFu+g5Mf8Zr6RjuePfn76naXd
         To0IWQlFVBiENzPqkOzq27GHVbbMFUCo0/HSrAMeOvHmLWJbnan7m1MPaOOVY1MmcYfC
         FAOKwxeCrNQAMgrsToZvO4xSTI/p3VRNFlShTCj7LFULu5gDpj6eBBGOKyM/0oZQdf2p
         efzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197878; x=1692802678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/Dhb70OK4hEGD5pj/9T1Ud8kYLrafnZW6YW0Jaj+4w=;
        b=i8TxI67kMEvAzG+8uaErXFigV11+DpCz85K5hjWciJYSeMpNHjqVaNaNd9zmAOYAED
         xSoD2c2vnuVyFoiutbogpsfdwa2QhBv9NupRFgxinm6d68FIFGysHCSfCFLIO7RM5nk7
         ilhFtykNsnVMtMdnft32aP6aqOnIxKUMvYApCedc5l0eh/r8su7jfTXHw/bwJJXYSw8I
         c7N9zhAhota+p7KH3dWOVd5o6bP8CwyvfO/Q9yjy+xAgeaA4XXUp5N+l9lBrX+9HZFII
         T7fq1cp9ClPEUWd99cS1ZhzqfA5V3hUvPXjJ8LXyDYwuIs6Yhj0eG76YWuVyABZwKrtC
         EDGw==
X-Gm-Message-State: AOJu0YxqggRaO0DkjXlp9oVVHyEPguynCfqbJfYeuTO2mJex3IOlmQRg
        PPug8mEbovsHRvTMKGZ9m4kpgA==
X-Google-Smtp-Source: AGHT+IEnM9PXE7B4AuNAxxSv1zZwFLpPB1WCSVeswBWNfAQ+cCEVR/xjs/m5wCSsEtxdn+/Sml1Eew==
X-Received: by 2002:a2e:b04d:0:b0:2b6:e6cc:9057 with SMTP id d13-20020a2eb04d000000b002b6e6cc9057mr1719538ljl.51.1692197878654;
        Wed, 16 Aug 2023 07:57:58 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm8610403ejq.190.2023.08.16.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:57:58 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: [PATCH v2 5/6] clk: qcom: videocc-sm8550: Use HW_CTRL_TRIGGER instead of HW_CTRL for GDSC
Date:   Wed, 16 Aug 2023 17:57:40 +0300
Message-Id: <20230816145741.1472721-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145741.1472721-1-abel.vesa@linaro.org>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
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

From: Jagadeesh Kona <quic_jkona@quicinc.com>

HW_CTRL moves the GDSC to HW control mode as part of GDSC enable itself.
Use HW_CTRL_TRIGGER flag instead of HW_CTRL flag for video GDSC's to
switch the GDSC to HW/SW control modes only when consumer requested to
switch GDSC mode using dev_pm_genpd_set_hwmode.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 drivers/clk/qcom/videocc-sm8550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index 3bb136ec31b1..504b2ef264eb 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -324,7 +324,7 @@ static struct gdsc video_cc_mvs0_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs0c_gdsc.pd,
-	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
 };
 
 static struct gdsc video_cc_mvs1c_gdsc = {
@@ -349,7 +349,7 @@ static struct gdsc video_cc_mvs1_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.parent = &video_cc_mvs1c_gdsc.pd,
-	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | HW_CTRL_TRIGGER,
 };
 
 static struct clk_regmap *video_cc_sm8550_clocks[] = {
-- 
2.34.1

