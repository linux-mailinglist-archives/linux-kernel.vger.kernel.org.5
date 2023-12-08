Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708BE80A1BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573678AbjLHLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjLHLDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:03:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BF10EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:03:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so2776489a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702033389; x=1702638189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEwLnBOC/qdcYM4M+jPElLEilL4x4aw3f3zZi3BYaWQ=;
        b=doa+Coj+S0iYPDMY+khMzcfynSwHMm2+DmVz/RZyvFyB/4jKJO8QmFVxU71/INY3Q8
         SffTS0LWw57mmOPtJ7O+ZmelHeN4FhFKITxqfL3tYZ2Sk3CqbZ2muWHmYj/ZQEeLQ3us
         yAd4s7wI2BL+MTtGH0jHlFtVHiIx7E3zoU9u6fDYHW/92MeFtssvMj+wgWThuKQZhdP/
         5mGKIAbioVlsiiN9u8Wb2p398qpVGWWTwVhZqD4ZFDkCzeMz+J7kKK8tP4X+LRpNkXdz
         dZIbi+KtYAICSu7JsyM32BqV5GAhEjzeQhxeNJ43vQKTfjCQRiyGS/iTJIfv45Pptqfe
         e07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033389; x=1702638189;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEwLnBOC/qdcYM4M+jPElLEilL4x4aw3f3zZi3BYaWQ=;
        b=PI1pFsmChK6e9/LmqvoVXtIBREskkCtr+iFj54khEAmKJe+zBH+GO2of4LAbaiHJfj
         P1a4p6pPpUoiXZBouZFzSp273k8I0/RU+nL1HvvXbCBW+mSftd0tedhE2u/sP+yZW2rg
         L3iqbBG9julOrl6gKT85Hs+/GWP4tJg2KuVIx2cJJNhNTnyncunS2xI/Ebjdd6P6ndHM
         gn2Rgb2UxsI+5ynRhHflKZYHW8SQXgxf/DQ/cc+4i0WYwd+pP72Z3T2SyCIccoE9gOmF
         hRX26d71eYuTyCAmk3sXkulhJ6v9uHDHnLGIjYSWa3jjjFQIEFHYkAYjWLyLGYsEOKfh
         /JvQ==
X-Gm-Message-State: AOJu0YwkTCto9XNGYJvVxNGYhkAZ4Hk5UHxxkfdKInhdqLBJvYWtnIKL
        cAUzJjpfHYU/Jx+ZtN+2U8ZFqg==
X-Google-Smtp-Source: AGHT+IEUCMIetzDx1rq/yfoOzbKLkqMRhi9m4z8qeP/XugdovkyE4akMeKajgqnm0Gd5Eej4Ijodhw==
X-Received: by 2002:a17:906:81c4:b0:a19:a19b:4254 with SMTP id e4-20020a17090681c400b00a19a19b4254mr1634063ejx.191.1702033389036;
        Fri, 08 Dec 2023 03:03:09 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm862184ejc.73.2023.12.08.03.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 03:03:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, Peng Fan <peng.fan@nxp.com>,
        Udit Kumar <u-kumar1@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20231117143338.1173475-1-patrick.delaunay@foss.st.com>
References: <20231117143338.1173475-1-patrick.delaunay@foss.st.com>
Subject: Re: (subset) [PATCH 0/4] stm32: add support for STM32MP25 BSEC to
 control OTP data
Message-Id: <170203338747.19730.10941929995611139048.b4-ty@linaro.org>
Date:   Fri, 08 Dec 2023 11:03:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 15:33:33 +0100, Patrick Delaunay wrote:
> Non volatile memory area is available on STM32MP25 with OTP in BSEC.
> 
> The 12 Kbits of OTP (effective) for STM32MP25x SoC Family
> are organized into the following regions:
> - lower OTP (OTP0 to OTP127) = 4096 lower OTP bits,
>   bitwise (1-bit) programmable
> - mid OTP (OTP128 to OTP255) = 4096 middle OTP bits,
>   bulk (32-bit) programmable
> - upper OTP (OTP256 to OTP383) = 4096 upper OTP bits,
>   bulk (32-bit) programmable,
>   only accessible when BSEC is in closed state.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem
      commit: d062d18d0e30e46e88a3b0f9fb2549393b7d7adf
[2/4] nvmem: stm32: add support for STM32MP25 BSEC to control OTP data
      commit: 2015e5f4d01fb76fca69047f870035e214d6d2d0

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

