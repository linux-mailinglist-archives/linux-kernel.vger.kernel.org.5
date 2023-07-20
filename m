Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BEE75AB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGTJip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGTJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:37:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26862F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:32:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991da766865so107451966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689845534; x=1692437534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zw3bdOgURyGZIIE9jpH5JtTpJ3WaiiUVFo6x2TqJrlg=;
        b=NM61oky2WpWNmPn9JR/sNPqgSvsN/awLuT+IZG9HQjGdUWRPU0NCCdVSebojvXrlVx
         lPdkVv9JQcoV3Z9fo6iEqymssPeF4WADUu92trATw82IaQP2IoZTcbgjAUhydoZtRqDP
         EfnlqMQrw6xw7VWodHAC/CmRJaQ+COqbVZoqy5abFX0/ptoV2pFmzIU/dE9osq8TBdVp
         P6QNox/H8qN84IjvUnwiOPEatv+VB/80O3+XK461HpICdetzPpmlnZTVo9pz/1MtjPTB
         EYMHfVZ145y5IMGi8SKmqOO30xTob09chPTtyt4JpsbENFLnmunu1TAMVWW333Lijndh
         K10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689845534; x=1692437534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw3bdOgURyGZIIE9jpH5JtTpJ3WaiiUVFo6x2TqJrlg=;
        b=DOOFtgoQs3pBbJm4e3OVBp942Ex2WvHFCAv9AQv7lbSrF6P06K8cp7DsiHY7tRu+rv
         xIGmFpNE0dgy7LJ2IGkFv21dO9csQmyVLM4SfyLrCyX8nWNENrZa20oM18M44TfxWe/j
         5B4CIUIAPiwmGcmZA/mLZCQF2hRh+7vEd7I4jTL8QrwnAoJeclQEHo5P35pgQ4WJB1XX
         7wcbA8GaK5pp79EuS2APxEC9X6q3pHJyZKl/OetiQ7tZ9KrR7rkYdV1ywVUNhasq17Q/
         eH9SPWxUaBcHw5/83zQ4BTqWbJSNJwpIc7vNT/y5JaU5SNKj30y3mafJy9DXnxWImUOZ
         yIsA==
X-Gm-Message-State: ABy/qLZuFNMUTJ0CraFRrKjSga+gwuWd9XUKaLjQV/ADJvzh1ttVLgt2
        YHDAcgLjRM9m6+VWz+jBIvsiHasdNHfAH1OTzNo=
X-Google-Smtp-Source: APBJJlE43eipzZ1egWwNTBOXwhW52noTrldVfENXVIc1LoMlYeyn6gBmCyKcncjwJoZ0UtJOoqRW7g==
X-Received: by 2002:a17:907:7eaa:b0:979:dad9:4e9 with SMTP id qb42-20020a1709077eaa00b00979dad904e9mr6123529ejc.50.1689845534461;
        Thu, 20 Jul 2023 02:32:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dt15-20020a170906b78f00b00991bba473e1sm430204ejb.3.2023.07.20.02.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:32:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: samsung: Explicitly include correct DT includes
Date:   Thu, 20 Jul 2023 11:32:09 +0200
Message-Id: <168984552538.79008.14079472296169361189.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714175147.4068046-1-robh@kernel.org>
References: <20230714175147.4068046-1-robh@kernel.org>
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


On Fri, 14 Jul 2023 11:51:46 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: Explicitly include correct DT includes
      https://git.kernel.org/krzk/linux/c/4c4458375c5633954eda8fb9e7d31d56836b2bbd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
