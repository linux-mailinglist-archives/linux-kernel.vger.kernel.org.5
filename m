Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9347DDE10
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjKAJEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjKAJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:04:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFFF1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:04:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so10261588a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829461; x=1699434261; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAgADHr8F66v1cbu28V1cj8/cSQmipxI6WLHMltxgpQ=;
        b=RPSn18fzes6e2b/JtI1UvjoemLWI/NDclJQkEyBCcg106ZoS0agTlS1IUNIRQ9K8DX
         d6WW60yDjWgS/M8oWXq++0gKJWyk2aSME2w0FiDUKeT6XLNwlTMW4q0GGU+Cd2ZHWUNt
         Uy9sD0SObPcfvy5HvQlK89eEf7IUPqdXyyVBi7zbxQt+csgjAiDmmxiUDRu4LCKwRJQI
         9l67Tq+1xs3oWApsf59egESXDWVPRwwPy531padYqlioIYze8l2KkWoThTT0nXMHvJWw
         aw7cmPaE/0eEwx4E9fz2KrMKSkE/wkztaVUnC0shoIElApy2fxqBDYoPZMRBw27c4cOb
         3BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829461; x=1699434261;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAgADHr8F66v1cbu28V1cj8/cSQmipxI6WLHMltxgpQ=;
        b=qFgr3M3l59O5waohcb1cbLgfPV/l23lujEymZ7QQsG0miFR23SrrM2jDOkISPNW0mR
         qb0SMDXEPydNGrwnN9/b+pk9Hv4PwJstW+NchJb6QN/0Z9yfC9n8+NOZpCgqKX2dkjw3
         CZDq+/ZwdkG6O6GMxbMK7leJLwuD/NUbMnKWPb/0csEEMWskDPihIebA7pIFE2nU72SO
         wZYkSkkMc6s54jkdIokQnYVXyEuT/Qaa5+3mkVRbwujk/0CsrsHKMciChMpNYlM16x2a
         d1YabwLhv9op4W27gJa84KWSsFxaQriHXcDPN4hWN+N1cbG4fFx2Zi9DMXg6ZV0ywaXy
         2h5w==
X-Gm-Message-State: AOJu0YzdJgDZPeHgSNUkIU4xiUO6LxtJVfZrqxgkuVNCBF+1Olcn+4MS
        9xYKzFyMBpFumvgVs+6QIUlDhA==
X-Google-Smtp-Source: AGHT+IG/oxz6Hjy41Gw/rCWlijHAqZQYXIkwi5awktL6htxV3fZ98awAExkMrsPT43rS0fRw5YRBGg==
X-Received: by 2002:a17:906:dac4:b0:9ae:5120:5147 with SMTP id xi4-20020a170906dac400b009ae51205147mr1491707ejb.38.1698829461446;
        Wed, 01 Nov 2023 02:04:21 -0700 (PDT)
Received: from [127.0.1.1] ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id l25-20020a170906a41900b0099cd1c0cb21sm2152781ejz.129.2023.11.01.02.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:04:20 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH RESEND v3 0/5] PM: domains: Add control for switching back
 and forth to HW control
Date:   Wed, 01 Nov 2023 11:04:06 +0200
Message-Id: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYUQmUC/x2NsQrCMBBAf6Xc7NGkAQdnuzroKA7J5doENNVca
 YXSfzdxfPAebwPhHFng1GyQeYkSp1TAHBqgYNPIGH1h6FRntFYaRy+EYaU5P1GbQWm2R0XOQym
 cFUaXbaJQmw9Nr7b6bVixBtV5Zx7i93+8w7W/9ZczPPb9BwrOThaJAAAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=IMghRN0GHIaYwd3qOqpxrh49MQz/bpL0aj591dU6KPY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlQhSItQu7eU6tRAk2KSC1vO4XZNRtKRF3QXL6b
 e3vVamqDhGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZUIUiAAKCRAbX0TJAJUV
 VvN3EAC4Vw8ic4lltLGvppV48k2HtbT7bCdgtSOVW+ajY/kiMZfMyL43s8U0s/gEHjbfwfn2zSM
 NZO56shVcbFdLo9kwMKpVC3+3J4qK74vSgNl4nIPvOxUP3toZMPNN/ouOs4OTkvRAe6ZcM7yqjd
 7coaHqfKqDtcCAprgnpRN1A1JxxdCrapM3IYAxeZkdVecSR4OeazJAuJ1n9k4a+RFm0uDy3mnBg
 MK4YhSfRGdq5R2xzI5+KaFhNlFQ4tF6EeS31fDsH0DRpjibsezNgtZi8MrtoKCGUaTOwDCjLwoo
 QBlL/IdHpMXxU7cWqrnxcsPqBi9k+CjzH5ktI8p8KQ60k/oUoZO0iPCGBnfnPtse4k1Q0MLZOwA
 sHzLIcam9ZYmVhEP+niuuGQqy+ldNrkJ373/KhmC8xMC6XG8NeQ36ui76dJqfqoqlAlxlCio+k8
 HULfB7BgyKd3JDfPVQ0Gh7qgdxTA/qi6v2LE9pyzyKCNUFB4OMoAlfiNMxxZUSDKjYiW+2uboTe
 NNaDhPdGzpDqDK0NvMBtkTADYzk/EjUz0iN0qMTQkE2tYKztJqZTK0KZX8KNs19J/1lqR7COm4i
 jLfE4SgOt1BBT74m4et3gDO2p8aETtVHv7lw2U4UBArBSNGqy/oNXMJ35rr1dTUI5nwvT5lwBTs
 C6j6j5EBRax9w6g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a resend of v3:
https://lore.kernel.org/lkml/20230923115008.1698384-1-abel.vesa@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (1):
      PM: domains: Add the domain HW-managed mode to the summary

Jagadeesh Kona (3):
      clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
      clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
      venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode

Ulf Hansson (1):
      PM: domains: Allow devices attached to genpd to be managed by HW

 drivers/base/power/domain.c                    | 84 +++++++++++++++++++++++++-
 drivers/clk/qcom/gdsc.c                        | 32 ++++++++++
 drivers/clk/qcom/gdsc.h                        |  1 +
 drivers/clk/qcom/videocc-sc7180.c              |  2 +-
 drivers/clk/qcom/videocc-sc7280.c              |  2 +-
 drivers/clk/qcom/videocc-sdm845.c              |  4 +-
 drivers/clk/qcom/videocc-sm8250.c              |  4 +-
 drivers/clk/qcom/videocc-sm8550.c              |  4 +-
 drivers/media/platform/qcom/venus/core.c       |  4 ++
 drivers/media/platform/qcom/venus/core.h       |  1 +
 drivers/media/platform/qcom/venus/pm_helpers.c | 47 ++++++--------
 include/linux/pm_domain.h                      | 17 ++++++
 12 files changed, 165 insertions(+), 37 deletions(-)
---
base-commit: fa7d0c17278644aa691f96d08bef8001b762f9cd
change-id: 20231101-gdsc-hwctrl-13f01ea60cbd

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

