Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE77E76318E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjGZJSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjGZJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:18:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11346423E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bc0a20b54so93590066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690362865; x=1690967665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBNaL4R2l6hdwWD/142gRI2boOE0YiHyAV9PIcKLPWI=;
        b=xBCZWSbh21eMLQfHBo7UXc3G6P7mjLXqgkKcaEH7tmgFHCRqsjX0Sn90BX0Gi2xsSz
         r2laJNx0jiCRFR7lnNMgbxkjOia9yMBdr7saDdhFBfpLQE5FCfq4EdRziLhS/KU3MtTh
         q5cwT7r7iIoy1iTpiKalgC3NFZXYNkgOp1Bni2XdLX+crgOZElPoxcSKcMqOJml7Z2FC
         kdDTEGtFHNXhYgV3tBaw2EKmhDXP6iL1yTdovjlBSW525O3r+nZylsrfcGpOab9qs6Ke
         yZdhkWpxgzyM7A+biOk9z2pOoSYQ0i8las5mu3gewwQJUmhkYfu9bHN65J08KlDb+R+G
         IeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690362865; x=1690967665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBNaL4R2l6hdwWD/142gRI2boOE0YiHyAV9PIcKLPWI=;
        b=AZgbjAV0Fm2Pznss3u7LYR8R8AecgehxSipDaE28xQWSiyCjHf7MkA6yL8UAT5rjri
         GQcqppA//3NdFWg7ivIxfLSNTgSMH14jNbkrxD5iqg+NJ1Gud7njAUZxtjVJzCiE/uW5
         jyrzXYUiDIOs1h30MM4EPYyJV1p9Tf3Vng6eDNgouN4iU3i+ZNZhskFkg2uo/HtWGT2l
         /FqcrXfdOGAU2mRWS/fDsJIsnmKksqHS0q7HiQ2tiB4EkGoL45HrgbLbRJr96936Obm4
         4nDj3Sk557+zlkwDFjSQ3m9yPSpnd+SPgk8MoBWO6gIMMl6kz7d784cWStQ13UMss/0b
         pw4A==
X-Gm-Message-State: ABy/qLa/y1MwnHBmgLOucEm57S6E2B/bVXSXQ1Bmpitlqtd+SbcxSMkm
        de4VT0bSGLfTUp1O77sGsiwOkw==
X-Google-Smtp-Source: APBJJlENHS1zX4Rvh36zpRv8rVcGgK91e8CGUWJyXMRNxPf0sEuzwMhIO9VfThOGQJHa3oTVDJpKAQ==
X-Received: by 2002:a17:906:cb:b0:99b:b2fb:27b3 with SMTP id 11-20020a17090600cb00b0099bb2fb27b3mr1341837eji.41.1690362865041;
        Wed, 26 Jul 2023 02:14:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm9384492ejb.84.2023.07.26.02.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:14:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 2/3] pinctrl: qcom: Introduce SM6115 LPI pinctrl driver
Date:   Wed, 26 Jul 2023 11:14:15 +0200
Message-Id: <169036285578.127914.3038916520706013414.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722-topic-6115_lpasstlmm-v2-2-d4883831a858@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org> <20230722-topic-6115_lpasstlmm-v2-2-d4883831a858@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 13:39:57 +0200, Konrad Dybcio wrote:
> Add support for the pin controller block on SM6115's Low Power Island.
> 
> 

Applied, thanks!

[2/3] pinctrl: qcom: Introduce SM6115 LPI pinctrl driver
      https://git.kernel.org/krzk/linux-dt/c/63f7c8445ffe6667ac4cc9720ca36ad7d407709f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
