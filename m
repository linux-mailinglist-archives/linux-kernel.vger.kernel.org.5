Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC558022CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjLCL0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLCL0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:36 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702FDC1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:42 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9fe0b5b28so2319291fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602801; x=1702207601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbKwG3bsiy6N+N1DD1CLsj/Q/q+O1WSIDYwjhlWFEhk=;
        b=JauP0zVecpmeZ+z3RHcYpN1DjW9X4kafDK7mSEZVT1zhnTgQ2C1Ckq8OgAUJyKVpgd
         2zgCVkWnnBHURo535WjBhsVlhCgRzLWGyGg+IxtEt0NJDF2oEc3j4X1kBUgcBdzYlYA1
         tgU/f0A/rS8WHargiY2biCD4fPtP5LivyCGr0R9YvVcxIZo5RV0uCAuQZfY/lHaoxhLH
         CxFv7qfr9KYJ7bObd6nDAuAgQXr+aw7vQkKcZLnwO2w1gaRwAsOevKdImrf6wFR4x6CY
         HCffs+pEi1FEDGyzWAz7XA0/ajHjFB26lsBIVhpIKb+iZANt6YuMF6vd8GHTkPsH+avs
         YJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602801; x=1702207601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbKwG3bsiy6N+N1DD1CLsj/Q/q+O1WSIDYwjhlWFEhk=;
        b=s6aID/TbFozrPgPzsNa9jX60Uq/jVAuFqtHu/O4gUAXfhKiqOKNE6hXpGubMzsM1Fv
         06J189zkZT3ptf1MN7jDqOXhbomjiTtPBlsg3NCqPDWff5KYsdZAhRbd+Sx31JNTXVbo
         qgWzrnAaA1Z2DljbKRYveUxyLFLg+Z/SfHFMPFkdHYQv8GkhoK43fGk52YhSd/i/1jCF
         EYP1VUdSekDFI40iQq5wJdB2aP30GBd61qgWlGivGROcnLCZ2nnMIgHFOIEE0ON92f1P
         ooGe992gPAzQaNrxhn67oaxJZCgVklGAjIXeBIiCFYuQqNj2ZG6TENmV7XU1QKUMcvjC
         UaPA==
X-Gm-Message-State: AOJu0YwfxjFbzEnb1v25qkSgd7ZLjM/7654O5qkqvJLDrZQvDc0rAOmG
        dHgrY1AKLRs3tbg+0zxTZ4Rrug==
X-Google-Smtp-Source: AGHT+IHXObFn5iWeVaQxMjM8NCWQ1Rahby/WyhApUWMTJIT7Qf7SFVR14cwLp/UcG7bQecH6ZqyZlg==
X-Received: by 2002:a19:8c48:0:b0:50b:d764:9691 with SMTP id i8-20020a198c48000000b0050bd7649691mr1631354lfj.117.1701602800856;
        Sun, 03 Dec 2023 03:26:40 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:40 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,sm8250-mdss: add DisplayPort controller node
Date:   Sun,  3 Dec 2023 14:26:25 +0300
Message-Id: <170160265545.1305159.1208126196892932328.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107103600.27424-1-krzysztof.kozlowski@linaro.org>
References: <20231107103600.27424-1-krzysztof.kozlowski@linaro.org>
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


On Tue, 07 Nov 2023 11:36:00 +0100, Krzysztof Kozlowski wrote:
> Document the DisplayPort controller node in MDSS binding, already used
> in DTS:
> 
>   sm8250-xiaomi-elish-boe.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('displayport-controller@ae90000' was unexpected)
> 
> 

Applied, thanks!

[1/1] dt-bindings: display/msm: qcom,sm8250-mdss: add DisplayPort controller node
      https://gitlab.freedesktop.org/lumag/msm/-/commit/52e36770b174

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
