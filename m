Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3EC7BCEBE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbjJHOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344831AbjJHOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:01:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26353C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 07:01:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50435a9f800so4782996e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696773686; x=1697378486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSMUdpgtTg04OpFZxfxSUvT4pwJGZAYPeTOexRIr+Ds=;
        b=ZaF7WLvaSTRCyOqPouUAV/H36xzPfWUriPc01EHczkl4v1Dj/+6MKx/9Bsxl0LIJAZ
         +oF2jlhvAJgw+J9jyipad4J090HJTUq1MfOlFM5dpf4IRnxlksS+GsfaSLj9VDoMaXlz
         IW/eKNdCmjMMaRSTRF3f7E/oVAl2pmhNb7lTIOY4pb3w7grcNrNxsMDQLbPdvb+N9Igr
         868V70ZH7LgZCw8z83IJxNjoh+UfnCQThZmDk4qApOog9VX53pq2oAL/J5+qieeurVgf
         vRIcodLPxA7qZIaV0sNbXKSTN+2TBw3xpPUaAtA8MjELvxM/e6W3gB8XTe4+gLjuRVio
         P9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773686; x=1697378486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSMUdpgtTg04OpFZxfxSUvT4pwJGZAYPeTOexRIr+Ds=;
        b=t9NYEFw/Z8upTwaW5vx1sChe80p6VrW4ukp3+ZNOYPwK3PhuXfFB2KhJwf+34F7U7a
         EqcIimvLZsjOYBkk2yu4OkSqnVP8Q3NMGu9JN+K/pYaoSnU/lxfH/2SCLpJcAIm0kC/o
         eiogNK+OpqcqwetY8X22jCWam5D8jcgzvI0GyHW5940Ng5BEy/u/vOW7Lwe4Ul6HjNqK
         9XhRkTjj+qMKUUU+qKl7CjE4i/h67AxhbOwwfOcUgPUl/3ICHA+8qiALx0PPb0fyD7W+
         c706JdD5keo9trDtLgG2gSGkey+dI/lS4hv+ASw+Pej3A3KYOL1MDUccZnL196ZwZZlw
         1YQg==
X-Gm-Message-State: AOJu0Yx1JN0PzLVxgwgUCmtUXxr2JiEMmZ866Q1x/W+sQ11MM8r+nZke
        U/T4FpNz4WWmNOl82yam64Af+A==
X-Google-Smtp-Source: AGHT+IGxfVDd6z3b4aL3PVKq8C7Mjb21gUGAEM9IbcbsGG5OCtfSfwwara4kEgcUl8RPGr9RfAl4FA==
X-Received: by 2002:ac2:4a81:0:b0:4fb:8585:eefe with SMTP id l1-20020ac24a81000000b004fb8585eefemr9557457lfp.57.1696773686418;
        Sun, 08 Oct 2023 07:01:26 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q14-20020ac24a6e000000b00504211d2a73sm1080455lfp.230.2023.10.08.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:01:25 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: msm: Add missing unevaluatedProperties on child node schemas
Date:   Sun,  8 Oct 2023 17:01:17 +0300
Message-Id: <169677325602.2570975.10339984139706350311.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925212434.1972368-1-robh@kernel.org>
References: <20230925212434.1972368-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 16:24:24 -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> 

Applied, thanks!

[1/2] dt-bindings: display: msm: Add missing unevaluatedProperties on child node schemas
      https://gitlab.freedesktop.org/lumag/msm/-/commit/08bf97ab16f3
[2/2] dt-bindings: display: msm: Make "additionalProperties: true" explicit
      https://gitlab.freedesktop.org/lumag/msm/-/commit/55bbcadccdec

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
