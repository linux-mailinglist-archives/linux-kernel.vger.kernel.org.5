Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402617BCEB6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbjJHOBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344807AbjJHOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:01:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A668C6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 07:01:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-505a62d24b9so4407982e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696773685; x=1697378485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n7pZomMrAHp2Dfup6BtVrM6UnZwRhQLuymH3hRrOlg=;
        b=SfBqRV8tKrJzem5H/Huv4K1/pTFDz4orQ/vEUGBb24uvCwtqUobm42vsCQ939WKX9G
         m5TUkTELqSRdn/uyaVSQZ6mL8gcoYELEEcyGvDYSREI5rwZ+bF42+itjlnZfFRqCuj2R
         yJ338ScgEbvkNP823O8Jdqk3+lCStKGbdwB8NkJ7cg5POd3dRuIxtoSZqWbHISVpkPa+
         Mekn2LPYsJrEZ4Nz+LbwMxZUiEHXow61c6/P2YPA5NSZ6DPdKgj1RqTEwm8wVYG0NqZE
         tKpCygYnT6K9ItVqsZm7gQmmT2JKgs4dv+9AZUEE6vMwo3y+IRwGi/CnRFvUJ0JkWgaN
         k2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773685; x=1697378485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n7pZomMrAHp2Dfup6BtVrM6UnZwRhQLuymH3hRrOlg=;
        b=Dk4CUDQbpbUIcCzpGLn+PXuHPi/tVHPFY5V6owh/yqnbeVWxhXVZTpVpn/hm47QS77
         RROUzth2kJ5McIQCRQ1rhxeFpmuArueWRNy2KFxQfjYWRjTE47bqlAiDXBDdR3r9gyXH
         MFkNLCZ13+Mpt4nw3D/KUu/EZUvJxOzPzgpNJuf42XFmDpTESASfdlIfIWtU0W0Z/kea
         xecFw2K4XQSUr8YP2X8rL2lsY2P8+PvT4jupt9TqWa7oFkDWYGnnaUMOedljeW8UPlHf
         UIhN4tUIj0YjK+aMrqKIO2mJuVOkVKv0kZIXuv22MbkiLY7hMu3a/a2KgLZi+/Rq3RKm
         CvdQ==
X-Gm-Message-State: AOJu0YxwaKduSu/iTckvEtrzb0XPGokpbzyaBe/WizweaioPSdAeodnP
        b1JFYTB/EgyhSyrRcZ6qS+pNmA==
X-Google-Smtp-Source: AGHT+IFDfQUAPvgY1MXQjzjFHEO2hanMo7IIqxbsR4YfDzb/+L0dZxGBT76E70tDqOjQ0yvi7d2q5Q==
X-Received: by 2002:a19:e05d:0:b0:503:3804:d2ce with SMTP id g29-20020a19e05d000000b005033804d2cemr10523580lfj.35.1696773685410;
        Sun, 08 Oct 2023 07:01:25 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q14-20020ac24a6e000000b00504211d2a73sm1080455lfp.230.2023.10.08.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:01:24 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] drm/msm: Enable widebus for DSI
Date:   Sun,  8 Oct 2023 17:01:16 +0300
Message-Id: <169677306906.2570646.12332008426708979775.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822-add-widebus-support-v4-0-9dc86083d6ea@quicinc.com>
References: <20230822-add-widebus-support-v4-0-9dc86083d6ea@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 10:42:03 -0700, Jessica Zhang wrote:
> DSI 6G v2.5.x+ and DPU support a data-bus widen mode that allows DSI
> to send 48 bits of compressed data per pclk instead of 24.
> 
> For all chipsets that support this mode, enable it whenever DSC is
> enabled as recommended by the hardware programming guide.
> 
> Only enable this for command mode as we are currently unable to validate
> widebus for video mode.
> 
> [...]

Applied, thanks!

[1/4] drm/msm/dpu: Move setting of dpu_enc::wide_bus_en to atomic enable()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/97aab03bb3fa
[2/4] drm/msm/dpu: Enable widebus for DSI INTF
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c9b7bae463bb
[3/4] drm/msm/dsi: Add DATABUS_WIDEN MDP_CTRL2 bit
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5467774e55fb
[4/4] drm/msm/dsi: Enable widebus for DSI
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4b90679c6864

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
