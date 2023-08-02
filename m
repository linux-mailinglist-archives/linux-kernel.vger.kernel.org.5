Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED45F76CFEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjHBOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjHBOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:19:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04704270F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:19:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so11113653e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690985987; x=1691590787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4wZsqR8LbrTTZv7kmk4RZ3s9EZmYRoAu6PO3sMdZUs=;
        b=VBAjZfSLPDTNwu0CV0rv4G5xg10wHSM/383f45p5UkzIDihYnJOVr7SFrEPpej4o++
         qhzsZLmUhm+Y1CguDPHbBSgmSYg4iV1qJA0JQ9pLeE4cUt386BnzSwesNCsvYS5selB8
         Wst0rOLT902/p2+bofyLyC1+iF4yvjOlIqGikNxnuuuwHodxfIKGfMcXDGwGejpBnSts
         Zs4hPiQ0F42FIkA4Yucbx6U/ajplONI6YvxD1jAxDvvO5/rmLntQ0Cq+ScNsyl3zCumv
         cygBhCtVrvN2zcJk9uEKlDvuk7Z6tJZTG0hGg4ItUPkBqmDOtY9tnQxfmsfolnvuvMEz
         72GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985987; x=1691590787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4wZsqR8LbrTTZv7kmk4RZ3s9EZmYRoAu6PO3sMdZUs=;
        b=e56sGYjMLhC6yOCfvbpiQ2b2Bxa6/X0Ihb41ZlRhnWllrgZhxg7IrpbRZLc7v0ILuf
         feqj4wyKq92Jn1p6bJoeUV11P8IdcvY9nertbDT5s/48i+N4AUJhL8U2CymRqXp67aQv
         pu/MJ3IWabYA9CLwsFhcgk1a413II9zgaHVXJNAkn/7gZO3UT5edemCeG1Xv3dT9mrJR
         b2CeJXi5DNnK5y0ipCha2o/R0qkXZNubcwdw5xw90IDMyGpfQ7mtqLkHMSi7ZJJ+Npd7
         /9AS8oGXfr4Q0Jp9tvOcYHZzT5n9ut3GYDdSyR15r5yWfnWipkMG+rIdOJxdUfSk1ZqH
         jlTw==
X-Gm-Message-State: ABy/qLbBh+kg0acwyhjddGQ/uiW9kDeYutHPd0JuDH83Di9b2247x5On
        W1KmRvCRiiryP9zdhDZ38rFyBw==
X-Google-Smtp-Source: APBJJlHXFkd0l2Dl0uCDbmr5c23DuUa47sXDSuioFO/K6TtLmZZkga2NjOJcXcM347Gwl2VJkTXPJA==
X-Received: by 2002:a05:6512:3694:b0:4fe:193a:e15c with SMTP id d20-20020a056512369400b004fe193ae15cmr4097594lfs.40.1690985987197;
        Wed, 02 Aug 2023 07:19:47 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p15-20020a19f00f000000b004fdfd4c1fcesm2952851lfc.36.2023.08.02.07.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 07:19:46 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     freedreno@lists.freedesktop.org, Jonathan Marek <jonathan@marek.ca>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: increase memtype count to 16 for sm8550
Date:   Wed,  2 Aug 2023 17:19:46 +0300
Message-Id: <169098596277.4187657.1718002880741720691.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802134900.30435-1-jonathan@marek.ca>
References: <20230802134900.30435-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Aug 2023 09:48:53 -0400, Jonathan Marek wrote:
> sm8550 has 16 vbif clients.
> 
> This fixes the extra 2 clients (DMA4/DMA5) not having their memtype
> initialized. This fixes DMA4/DMA5 planes not displaying correctly.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: increase memtype count to 16 for sm8550
      https://gitlab.freedesktop.org/lumag/msm/-/commit/08bfcdc2c358

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
