Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348E75B74E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGTTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGTTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:00:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F91739
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:00:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so1815747e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689879619; x=1690484419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ujTh5UmKEDSKTenMtxBAdE9mDjrAQ930PzSC8IqC6Q=;
        b=xghr8q17c18wW7dXqb9NO2Qr2e+RjU6Uk5qefPuNxmbKkgEhryRnuVs3B05XuukZ/p
         XredteMRHtxGIBczNrlW3mplnMeidO17FnyicvSXFRUrsckF/NkDRGb4MhTkf0aRP9Ov
         tKQ/YBJYpffXwLmqGou35EkB52zmtkLIBkNLRmW1BGCnJvm5SN+bgEDa8oOXIbvWrYkF
         pqlgh+5Ust1O677xT4CIv/qjFpYXvZJXDbSuLXw7wp1k6CrfsXop5jv81fdgO6Il6j8z
         43yymq99GwPYKxIMGfW9glaOh3EyZDjJMCcDtY5gwEWFhO/fu1BjXkfzo4D95FHqY2sg
         TC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879619; x=1690484419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ujTh5UmKEDSKTenMtxBAdE9mDjrAQ930PzSC8IqC6Q=;
        b=YXa8lKObMlG/IuTXKgdt76G7jir5HrxtGyyYAdbUgIfNlyQXbtRDd/67nlsHDe/1c4
         40F/SPItKCRm8kLFasxbqpKcz3GXSPKUU4yAdtmN6Ra3jFN0GuVuWVjPWuwZxP3aMHuR
         68j5XdCDN77Dy/d1cc0kL48HHOzcd3wKv+zCLfBBoouaiTUfCs5r75AX7YVmTSdzRoDb
         Vvaz0SnEb3hOqzFZjw3dKFxqxhiA/TC0r+zuWGncNhm/sJ7HqDOCwhAuc2kve1V6oAN1
         T51Nom2HhM/Roivtus0nT0kHsTkuA4me8/tUzkDGu0YHVgTYIceeJ6cGe2pTbmwX4RSl
         0r/g==
X-Gm-Message-State: ABy/qLauo6BsPPehjY15oZ2YGp7mIM7a6uLMqF4VDPQqYw3ydvzizOwn
        5Dw8nzZVOfBC+cn4opgNmSnTHQ==
X-Google-Smtp-Source: APBJJlGT7g82L+Hkwe8xj95tuxpUpxZWcf2IaXzPx9bPpdXMBveogBFlZKgmneiMXJunYel+lZG4Rg==
X-Received: by 2002:a05:6512:2015:b0:4fd:c923:db5e with SMTP id a21-20020a056512201500b004fdc923db5emr2682237lfb.21.1689879618531;
        Thu, 20 Jul 2023 12:00:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7d796000000b0051e2a5d9290sm1104842edq.77.2023.07.20.12.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:00:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Artur Weber <aweber.kernel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] ARM: dts: samsung: fix Exynos4212 Tab3 makefile entries
Date:   Thu, 20 Jul 2023 21:00:14 +0200
Message-Id: <168987960900.215967.4720344822144706929.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720141537.188869-1-krzysztof.kozlowski@linaro.org>
References: <20230720141537.188869-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 20 Jul 2023 16:15:37 +0200, Krzysztof Kozlowski wrote:
> Makefile targets are DTB, not DTS.
> 
> 

Applied, thanks!

[1/1] ARM: dts: samsung: fix Exynos4212 Tab3 makefile entries
      https://git.kernel.org/krzk/linux/c/838cf5a4377b9af926731cc68876e9c081873ea6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
