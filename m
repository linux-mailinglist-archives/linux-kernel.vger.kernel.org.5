Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F676ACC9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjHAJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjHAJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:19:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D4944B5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:17:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so44061255e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690881456; x=1691486256;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNhI+9VQvWbiJBwN1rE6OrRPhOX1EdA1Xn7je9kaQf8=;
        b=upxHVZn58HFzd0k+OMuD5NU/TpL6b/xYEFEHoZmFzEqWvAP444F+aDXHB1G7pc2VzR
         SRE9JW+4wT7wTPEfDrdMi8kzKbtl3632+aynPLlEb7wM2HSFaq/TTzsThyTOU0WMtZo9
         bCgRzzf3c95VN5lnU3qHXMv9ZMCI0Tl8M9Ix/krTa5R/8Ate5eYyYMlXE0BFrV4F3JrN
         ID5IcKRGCu4CM/f1FMmaQdv8isVbS+1SZLM3ErNoUYO16Cn2R5AyDecjQ9ypTJwgRo2G
         PMZ57mf9DRsXGVIGGxi7WUGJGt0SGiXvjBzgllRxBFV4ddkeDTkZdn7jo8ZrlI813VW9
         LUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690881456; x=1691486256;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNhI+9VQvWbiJBwN1rE6OrRPhOX1EdA1Xn7je9kaQf8=;
        b=A65zOV+1IrBW6EQ/URhZ++y4AomcBa0HFpa/Odi3D3MduNjwcUWYSSm/MdnDhvfcMF
         5iSqvCSOHGTSu40ZRzSHcrWTa8UyzI8mB2SYRokBPR8Kb31C2F7hH/ntYvD6S5Rnhhih
         ULddR6aYBpt8quTh1zO5wPDdKP6cLbv4IdLCUB1SFaCx+FjgPiANUwGV3ohFY8HBT8Lb
         LQ7N29IdrhjIZqAcMC+3QOxdb5S6mxXkZkowQ4nWtAi6JeuMmcN7OrDj5CaxuQoATTSA
         mp7NQ2e4slVmWeV1WUjwL7D5rrDwAOdGJLYGxH0kKnwGUaFH9WMR86/AcSVqEgofGzi5
         FgYA==
X-Gm-Message-State: ABy/qLZ3aDQGiMOcrEhz9odJArwpgJFwn7bcjlCvNBbBUikxguCBOFJu
        GtcOlBwXs7f3qAyftwXtEHvo1g==
X-Google-Smtp-Source: APBJJlGUtKBun7QGdW0Syq7pYELabUOBAfMqSTMjItKjZmxXLaBeWWkjT7/UL5CMxkfLCNkC1RVjJg==
X-Received: by 2002:a05:600c:1d9e:b0:3fe:20f1:fb2 with SMTP id p30-20020a05600c1d9e00b003fe20f10fb2mr1840135wms.6.1690881455734;
        Tue, 01 Aug 2023 02:17:35 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fbc9b9699dsm13575810wml.45.2023.08.01.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:17:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801064025.17381-1-quic_kbajaj@quicinc.com>
References: <20230801064025.17381-1-quic_kbajaj@quicinc.com>
Subject: Re: [PATCH v6 0/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Message-Id: <169088145482.47901.8484654769480683561.b4-ty@linaro.org>
Date:   Tue, 01 Aug 2023 10:17:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Aug 2023 12:10:23 +0530, Komal Bajaj wrote:
> Changes in v6 -
>  - Removed '|' from description in binding.
>  - Removed the header inclusion under the example in the binding.
>  - Removed devm_pm_runtime_enable() api as there is no pm runtime handlers or users
>    in this driver as of now.
>  - Not keeping Bjorn's reviewed tag as removing the above mentioned api.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
      commit: 050cd7f49580f2710a11edbc11be5a7ec5b4d8ab
[2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
      commit: 9c7f2bce8a0e26d162ba8de6706b2c0557bb63cd

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

