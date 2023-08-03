Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4514C76E6A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjHCLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjHCLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:18:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B535127
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:18:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so1483220e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691061515; x=1691666315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbHS6G+E5ew6ukOcvSxZbb7o08XJK+VVOu6GlWaMLPY=;
        b=Ezx62w0NkkQ2W7RPIfEX5KiXiIDOXDRGzvxiWHJtZ+Mo4+WiVx+4Mm0XTE/9Rc5cAx
         pcearRiloj+28lHxm83ZlODolQNNXm6XGduRwyonetEDLfzq6JBUxZ+y6gJzUSJNZNiF
         YbgpP8y1zhTGoF9tYHhmwh0GKRPDOrrhVJpa/h0+ZFQT0Pai8yP8dLuCWYJ1blv/0JBX
         sW9XzLha5rsMAeWkK4XgHF1zp/F+vLLUK9pxG21u6ZzpOnhO/cUVK0egvE1imtdVUwjk
         6Ye5daf3gxC/3zzazD6+4Too7Skwn0LxTngdUV7DVCVdj9acK+X3BLg8qpgZ7CVUCVyb
         rNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061515; x=1691666315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbHS6G+E5ew6ukOcvSxZbb7o08XJK+VVOu6GlWaMLPY=;
        b=jhmMc6UVOIlEBl7E3cGhy0Y3WWwV8ZNwN0nAhxCvHxerUqTjhPiD0yacgoosrFGDS1
         iF5tv8u+hHNAQcE08x0l3DrYIus9gethnKfEuM78lj4MuXauir67cGL2jFEQo/4SJevW
         aMHFgF29bjXxf3PJG5MIF+YcURLBKxFL6M9BmqTZ7wAV2Vb48uRHPKx5/noPU+5k/uGP
         4RbmOTB1vUpuPbCi/rX/vBQ/uLuPmw28YmBJjoT7Z+MSPdMwQhRoaB2fH0om6VMY8zXQ
         X0nPkpwTh7Dsr8x+RdYKHNeYnz2HawDvruMkBQkrKjq1IpV9ELaJ85/WewxoX8ufApaB
         zzuw==
X-Gm-Message-State: ABy/qLYeRVYfRSZ44uEC6dTBSuTq9EwfikzXjBPiZ1JDKSGV9vDSC/Jn
        BPx6cuoZmj+eeJnJZWpJhu8cLA==
X-Google-Smtp-Source: APBJJlGlLC32wnQ+ROJ9sEig2uRPBUqQcJgdNoL8amDhUgC2YK8CenUOjuw4GvfOcbt+WN+mqfRJJw==
X-Received: by 2002:a05:6512:3d91:b0:4fb:893a:d322 with SMTP id k17-20020a0565123d9100b004fb893ad322mr9200736lfv.68.1691061515201;
        Thu, 03 Aug 2023 04:18:35 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f14-20020a056512092e00b004edc72be17csm3296417lft.2.2023.08.03.04.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:18:34 -0700 (PDT)
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
Date:   Thu,  3 Aug 2023 14:18:33 +0300
Message-Id: <169106148047.4192382.5517957454190733148.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802134900.30435-1-jonathan@marek.ca>
References: <20230802134900.30435-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
      https://gitlab.freedesktop.org/lumag/msm/-/commit/42d0d253ed03

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
