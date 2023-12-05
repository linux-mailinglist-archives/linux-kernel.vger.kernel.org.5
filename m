Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55DB8044FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbjLECeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjLECeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:34:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD35130
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:34:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50be58a751cso3344306e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701743650; x=1702348450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUs2VYvk6Ti9rO4s4jPnLIpH7Phymi/5Rx2uYOP145Y=;
        b=U1UwV78rleSAip2ISpqm8RxB7L5xAP23NsCSvrv59Cf0wWPmmayaY+ReVUWtC5XL+Q
         wEAnblh77Xo71CepQljQIquj4aKCo3UAS+TxHJ8MOVpey0sKgzrI/4q+4oLEM5YpnKpC
         gDtJpCEBkFgJYNFkz9XVYbZKdc1xbCnsusJBic8UYxOwb2YZbvkN5ixKflzm+HunZNQX
         0uPRdnARDGoYqrAkl5UrHLlhTnZ3/K3ibGGOCdU2C7Zx4U175/GZKYGRrj6Cd9hmFkMb
         9+MoJoy/HjKl3yM2KoaLGqjtKORAZRtrQZKx4ay97kG2J99Uhj1+nUrK9GPOlk4zeHNC
         3N/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701743650; x=1702348450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUs2VYvk6Ti9rO4s4jPnLIpH7Phymi/5Rx2uYOP145Y=;
        b=j1TSk9W6kiuHa7nscPRjh2z1tIcxI+lgtNlFUsbCRQcH8ZbcV9X98yAKdKIt3yWykM
         XCFk7tcQmYyjr8qNsuEgUlewP48V3gNqJTEtPAzUdu/D5sLnAzSD+D3zhM49TKF3tvKq
         3dMb6uFBPJeR5GYcO62WpWh144s32Hqjw+nhuHRsuVc3MFPMO4mJIch+YCEyz03RzACf
         GPV621iAfcLuPK6IuMz6wM2aoDEo+Om4EvQIff193iFDiGBWdDQFS+GSADNComnVyV9v
         QIYcV3CCY0MpeR6NkV1hzb7frvwdK4nJtPspX25bMxscdWaBDMOIOWjcEu7xzBUAXy8x
         vEuw==
X-Gm-Message-State: AOJu0YxQ8Zx0FTZ0OmtdISe9dKOCwJSFoyZMCW2WbPuudFNT5N2Ri4Dk
        LuLhV/IKk5nPLr9UKwizq6muYg==
X-Google-Smtp-Source: AGHT+IE30tkOKHs/2LeruE1buPYxVdVFdUT9POrsHNxulaN52CoGY5B35l52Wgkk0pxu8LTzdgUPHA==
X-Received: by 2002:a05:6512:3da1:b0:50b:ec8c:6697 with SMTP id k33-20020a0565123da100b0050bec8c6697mr2021251lfv.128.1701743650074;
        Mon, 04 Dec 2023 18:34:10 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bi3-20020a0565120e8300b0050aa6bd6d8csm1415483lfb.178.2023.12.04.18.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:34:09 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/8] drm/msm: Introduce display support for SM8650
Date:   Tue,  5 Dec 2023 05:34:06 +0300
Message-Id: <170174354263.1582017.12643932401792527185.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030-topic-sm8650-upstream-mdss-v2-0-43f1887c82b8@linaro.org>
References: <20231030-topic-sm8650-upstream-mdss-v2-0-43f1887c82b8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2023 11:36:22 +0100, Neil Armstrong wrote:
> The SM8650 MDSS is very close from the MDSS 9.0.0 found
> on the SM8550 SoC, with the following difference:
> - DSI PHY 2.8.8, no significant differences
> - DPU 10.0.0:
>   - Enhanced max_linewidth to 8k
>   - PINGPONG_8 & PINGPONG_9
>   - MERGE_3D_4
>   - DSC_4 & DSC_5, DSC_NATIVE_42x on DSC0/1
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: display: msm-dsi-phy-7nm: document the SM8650 DSI PHY
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0014a4ad6c08
[2/8] dt-bindings: display: msm-dsi-controller-main: document the SM8650 DSI Controller
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8adc26fcebae
[3/8] dt-bindings: display: msm: document the SM8650 DPU
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3e135a7700f9
[4/8] dt-bindings: display: msm: document the SM8650 Mobile Display Subsystem
      https://gitlab.freedesktop.org/lumag/msm/-/commit/cbcef056fa40
[5/8] drm/msm/dpu: add support for SM8650 DPU
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b94747f7d8c7
[6/8] drm/msm: mdss: add support for SM8650
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e6488c2a3541
[7/8] drm/msm: dsi: add support for DSI-PHY on SM8650
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3a73e376cff3
[8/8] drm/msm: dsi: add support for DSI 2.8.0
      https://gitlab.freedesktop.org/lumag/msm/-/commit/fec254cc752d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
