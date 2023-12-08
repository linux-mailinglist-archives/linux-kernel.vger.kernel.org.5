Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244CA809896
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572912AbjLHBZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444228AbjLHBZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:25:17 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB9E1719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:25:23 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so18490611fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701998721; x=1702603521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z8ttjuthA9TvzbZIjtwgrrvCWpxqoAfEEPAXm+j5bk=;
        b=CnltOroDgJbdxJrIbtpO8VIY3iNY3BRG4niewFN/JOgGGQD45HnB9xOR/LBIiAGqhB
         kca/A169opJrx4uDR4k4kTuKIbCufI2NnBbGekM8O5bNDvAJz1WI0/b1KTJ9b6ETerqT
         h4RqMNL0SSlXIJxe3D4h+gGJ9Y2HLqgi9i936SLcr+pCwGJgRfaSLQZwRnsckL3I0mT3
         xy0GEopU9vfR13JlUIABMWTXECyndINzP948Gcs8iH2joCh8LiBaSTbj6sM5z18+VQic
         SSLVtNcQiQyZC911vLvnRQWcHvu//kzxptHGvpgR85YEeYtTmPhBm4GNk1eL2s3hnYIj
         y+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998721; x=1702603521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/z8ttjuthA9TvzbZIjtwgrrvCWpxqoAfEEPAXm+j5bk=;
        b=BriXK/FqWAtKcaJ9sRcEpQM7gDRg4F3O79TdWeckNmhIwfVldf7eWzZatJy4Tfkn1o
         Te4bk4c6Uql20b8hhue8N96UfCFULhB8H0cNElWkNAeTmSl9q/vsX3a3L2Vka04o5w6w
         cLgokJaLsoQYzpsa7flyz/EPX/09Cxod9vYvwCpm9TRong9ZjgK5ZoxIc+vclrd6DR7/
         s7yZt4O/+Mu8FaGOITm5SbiEcsjkg3qDPvcBugBPm2wq9wcbKksi3ljysonQXOr4H6A3
         pbbuDAer/uPKpbnrIRmQ5ACoc02EyFL5y2aNXEtE3XSlC/J2TYztc0ov41fzSCRhQekG
         hlAA==
X-Gm-Message-State: AOJu0YwrVkExo6RnA9Lxa9dbZWYUiSt4FZFgN6kEsDXFJ51kYBO2xjaj
        pDxJVpzuuLpS2M+qeWE3o6Pl3w==
X-Google-Smtp-Source: AGHT+IED1aYK3F3bcWEyFFjhG4PnuYCSof6Qej8fBdgpS3Q3VImntL1MaQ3H87zPoqDDxO/1vki0ng==
X-Received: by 2002:a2e:a407:0:b0:2c9:feda:3923 with SMTP id p7-20020a2ea407000000b002c9feda3923mr1320753ljn.77.1701998721804;
        Thu, 07 Dec 2023 17:25:21 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g26-20020a2ea4ba000000b002c9f58169a8sm88639ljm.120.2023.12.07.17.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:25:21 -0800 (PST)
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: qcom: sm8650: add support for DisplayPort Controller
Date:   Fri,  8 Dec 2023 04:25:19 +0300
Message-Id: <170199868358.3399536.1110149612486448094.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207-topic-sm8650-upstream-dp-v1-0-b762c06965bb@linaro.org>
References: <20231207-topic-sm8650-upstream-dp-v1-0-b762c06965bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 07 Dec 2023 17:37:16 +0100, Neil Armstrong wrote:
> This adds support for the DisplayPort Controller found in the SM8650
> SoC, but it requires a specific compatible because the registers offsets
> has changed since SM8550.
> 
> This also updates the SM8650 MDSS bindings to allow a displayport subnode,
> and adds the necessary changes in the SM8650 DTSI to declare the DisplayPort
> Controller.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: display: msm: dp-controller: document SM8650 compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/157fd368561e
[2/3] drm/msm/dp: Add DisplayPort controller for SM8650
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1b2d98bdd7b7

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
