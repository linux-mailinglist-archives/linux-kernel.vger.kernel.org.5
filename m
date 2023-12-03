Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0B8022C0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjLCL0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjLCL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:34 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B1114
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:40 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f42ccb55so9276351fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602799; x=1702207599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRBX9qjaYScewEyAGN3ZWpm24vfD1L73uIHC1C0KO4Y=;
        b=v6yd0E2fG3g0sluCyynDyQNWieQPP+it6n392fqQzQXspBtgc1C6soPqFge8W6JHtP
         mVmF84TQMCBR1EyoxwtLnktpTDJfRfI3m0mfCVJgOwuTecDJVqzsOmOWTzuP+Cz9O0NS
         FZc/5BqdSg70JsdUTAqZa9phxzoKNt93BZHEPypXFB3y6pkiSRZn6nq0kqZkH+LuEk7T
         imuy+dJp4Xr2y1VAqBKlPB1coVx1kMUywIPffD4Q2faxDOhz1D8cNaqlHTBty/+jfW8E
         7rXDDxAP9Z+uT/OFRdYnjpVl2pzvgbOdvegCwxj3274Fi1FWVhjTxlawOFpmr2gipR5O
         wrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602799; x=1702207599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRBX9qjaYScewEyAGN3ZWpm24vfD1L73uIHC1C0KO4Y=;
        b=jk4Tz/0AxyTkKq+3rdiNtcMfAhX/Yf0PZHFYFB9YyccOS7jSs4sGrjQZS4+rYjFRrE
         hVRn56f8fQ0VxF0JcrH0bGIxjU72YoCSWDqv1h1ZwYN+lEC6P4jO7FagEooQAEKrRqsp
         kZ2QfZtAirinBMlCneFCbybODWaZVpSrEwv1XXXF1thgvorAqZyG++7Rj2E6JVFNGfHs
         MlYOBZsPUI91wvqPrf68y/7d5mVl7yh8CoT3Q0ThtAFq64e9Nf3atZLB/mtan2wV3Orn
         FEoboKbtkONQ/C+RkGPPKak//073MWJBpagswBEjbZqvBqtqMLGvYd4vgC2Z/dy5s7zO
         Ti6A==
X-Gm-Message-State: AOJu0Yw+PHBvWyH7kvd17OE2MDQ+xRREFI/L4IXHXWvPp7Ku8GyUisG3
        fQGx7xZwKChPKPNCO9xB03WUVQ==
X-Google-Smtp-Source: AGHT+IEo2kVrDxKWsLCcwvE8hl19v/Tnab9g7q9epanULPqx4nYnbkuhxAF8ZygQf6iwFdwfxMYOiw==
X-Received: by 2002:ac2:442f:0:b0:50b:d764:6e9c with SMTP id w15-20020ac2442f000000b0050bd7646e9cmr1980872lfl.76.1701602798822;
        Sun, 03 Dec 2023 03:26:38 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:38 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v3 00/12] RB1/QCM2290 features
Date:   Sun,  3 Dec 2023 14:26:23 +0300
Message-Id: <170160265544.1305159.7127586815591334441.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
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


On Wed, 29 Nov 2023 15:43:57 +0100, Konrad Dybcio wrote:
> This series brings:
> - interconnect plumbing
> - display setup
> 
> for QCM2290/QRB2210 and
> 
> - CAN bus controller
> - HDMI display
> - wifi fw variant name
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: display: msm: qcm2290-mdss: Use the non-deprecated DSI compat
        https://gitlab.freedesktop.org/lumag/msm/-/commit/25daacc60394
[02/12] dt-bindings: display: msm: Add reg bus and rotator interconnects
        https://gitlab.freedesktop.org/lumag/msm/-/commit/a1ed5860efd3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
