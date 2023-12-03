Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F88022E8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjLCL07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjLCL0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CBDCB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bb8ff22e6so4838810e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602804; x=1702207604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CutiCj2Gbdjhjf4p8E3J7URGYQoAelVBh1hnzF3CKz4=;
        b=z06945sL4gM/Sis/mwXFMvEiQCiDbESsOuo6QYcugBV/RcupOufq9mpuxGgXusfoCe
         Gb4trAdPFc/UhA0FBGRQBph4lEqlPdFGk8D0tNhVzrevDkkB8eUiouyuW6XfMz0t/76m
         hCRhoQ5yU6AM7bZxbzBBN/Njm0dusbbdSLWN1S8qHLVe9FX7o2qANkXZhHv0xZ94yu8n
         Un5FU+JGldiMQu82+oJA+Ove7sK+GPcyFN649nWS+Q2EmEcwyVvzuUkVpQV41Lo6v6rm
         ke5VQeupy7h6G6ByMAF6IP9L0mLsw/U1b4HYqDH2EK9c7s9yATPPqRMijHNiKtvXFPKj
         jHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602804; x=1702207604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CutiCj2Gbdjhjf4p8E3J7URGYQoAelVBh1hnzF3CKz4=;
        b=QzCMSamwWfhdbrul7kKgLm9a5jejrqK8SWtI3fL16ez7PqHvXZB+B8heolWCgKDVHU
         XLo4vVRT7Vnnqu+DtSRHghr/xsVU6g7wTEzcPRkBhMNwWZTTzS93xKua06lyTokIVVSE
         Ek717xBP3hYoXXqRKkF6JLtsXVpSipiUlioees5B/Q8z5Tx8WE0FCdIE9E+LZechpugC
         G6fg0nqiY8OoiFiVC9eNrRGPls7YYqFZ2Pf2YBzunr1/NrxUU0F4OgOP9rLOrlFmYxVZ
         1TwQ6bK95g0HmEJkwdObyvHITH6nMn7dSdPXA5Pk1EmgbdWhkykwuTdcd/UGJS8By97e
         8Lrg==
X-Gm-Message-State: AOJu0Yzc9+TVPBJoi0IYNkQUZuZTgsflHKXUC+CrxRoj/gBoR351DXmV
        nuZOUxCOj1YCrcLElDmM8gLz3A==
X-Google-Smtp-Source: AGHT+IELMw8begnWYh1JEtImLoAtELXxBFAf/X/9fgbdLPplqzXs4SKOzVzWMZ7fy3T1VGTk+k7SVg==
X-Received: by 2002:a05:6512:3189:b0:50b:e6e0:cae9 with SMTP id i9-20020a056512318900b0050be6e0cae9mr1168768lfe.26.1701602804382;
        Sun, 03 Dec 2023 03:26:44 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:43 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/7] incorporate pm runtime framework and eDP clean up
Date:   Sun,  3 Dec 2023 14:26:29 +0300
Message-Id: <170160265539.1305159.10276635989020703494.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1701472789-25951-1-git-send-email-quic_khsieh@quicinc.com>
References: <1701472789-25951-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Dec 2023 15:19:42 -0800, Kuogee Hsieh wrote:
> The purpose of this patch series is to incorporate pm runtime framework
> into MSM eDP/DP driver so that eDP panel can be detected by DRM eDP panel
> driver during system probe time. During incorporating procedure, original
> customized pm realted fucntions, such as dp_pm_prepare(), dp_pm_suspend(),
> dp_pm_resume() and dp_pm_prepare(), are removed and replaced with functions
> provided by pm runtiem framework such as pm_runtime_force_suspend() and
> pm_runtime_force_resume(). In addition, both eDP aux-bus and irq handler
> are bound at system probe time too.
> 
> [...]

Applied, thanks!

[1/7] drm/msm/dp: tie dp_display_irq_handler() with dp driver
      https://gitlab.freedesktop.org/lumag/msm/-/commit/82c2a5751227
[2/7] drm/msm/dp: rename is_connected with link_ready
      https://gitlab.freedesktop.org/lumag/msm/-/commit/aa1131204e58
[3/7] drm/msm/dp: use drm_bridge_hpd_notify() to report HPD status changes
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e467e0bde881
[4/7] drm/msm/dp: move parser->parse() and dp_power_client_init() to probe
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9179fd9596a4
[5/7] drm/msm/dp: incorporate pm_runtime framework into DP driver
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5814b8bf086a
[6/7] drm/msm/dp: delete EV_HPD_INIT_SETUP
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2b3aabc9caa2
[7/7] drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e2969ee30252

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
