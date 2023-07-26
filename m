Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2667631A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGZJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjGZJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:18:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1F32135
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e39784a85so163592366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690362869; x=1690967669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC2tHCYKHwgxaEUWfpPQiubm5LumCbOxn96mJg0qmV0=;
        b=J2Qmd2Ob1hznxEQMDEhdJ0RA9WiYRy6Cg5juEYS0nNUgyoVcspcPyXnvhSm4X1HpV3
         117DgPsmdVBl5f15DlK6raUwqAJr0tKWvvwmdbYwJwzhyUzK2qtt82SXl8+vLxLMqt83
         1JHMOvmvPz7zPKiuHqQOUaTA/GnFVR6wN27mwdlYj0M596zMatC954PoXN4Z4QZBon6z
         1g0MN3UUqpNDf7oyGqCUJCopq+B0B+Z3OFQBEkS48SvnIjDKr0mKPToBjpNSTKiZHKtu
         Bl2KbMm/++7/vcB2G/5Co0/My5e1XKtANavAIRV1OzrRCIqaa/pqihfzK/zKX1yv2oOi
         RUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690362869; x=1690967669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC2tHCYKHwgxaEUWfpPQiubm5LumCbOxn96mJg0qmV0=;
        b=N9eiqp/yZgu7VIFBn3A7il44+fBB0Xw/V2GqcClA4z6z9081jN5WlF14/wcsjeaJej
         xw86rHxjhmg0Wdny8w8hR6B6JhSB+k2Es0rD31t1pZzoMHyanz2H2cz74YjrQGZAZARD
         3OfEzmXjENTZH6ZV6j5A9q4eOPBRolKRAN4E/y4WxdJPXIQXj33iJNS0QBDEnyDm1jva
         JWmbCaIysosmO4DXJROHFVz2HJJW8l4zmS3JZ3Vnww3zEwo9utYaUfu6y3ZWnIMbqBb+
         koH408zYZgf/D+/LsJnTrAB5btUqQmfCXLPWBsizPa1rlBgCR+0I3JWIprtqtaeNWRNC
         XxWA==
X-Gm-Message-State: ABy/qLZ/CiGQMMZAI5K4Zv+Au+SFRud0Onwunl3dHPTtWBwxCwfyKzca
        piVaKP6wMWY6kruzWCgE+isG2Q==
X-Google-Smtp-Source: APBJJlFw/2DFQSOvPSHKmYW0Sc3HrdXpAVTVqatn4vIVl/ZWALS0pkUOwDlgCoFTHszWbVACCPulUQ==
X-Received: by 2002:a17:907:971a:b0:98d:4b97:acc8 with SMTP id jg26-20020a170907971a00b0098d4b97acc8mr5368327ejc.25.1690362869156;
        Wed, 26 Jul 2023 02:14:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm9384492ejb.84.2023.07.26.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:14:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v3 1/3] dt-bindings: pinctrl: qcom,sm8350-lpass-lpi: add SM8350 LPASS TLMM
Date:   Wed, 26 Jul 2023 11:14:17 +0200
Message-Id: <169036285577.127914.9465194201914884488.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org>
References: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 21:20:56 +0200, Krzysztof Kozlowski wrote:
> Add bindings for pin controller in SM8350 Low Power Audio SubSystem
> (LPASS).
> 
> 

Applied, thanks!

[1/3] dt-bindings: pinctrl: qcom,sm8350-lpass-lpi: add SM8350 LPASS TLMM
      https://git.kernel.org/krzk/linux-dt/c/2b4e7a87276eb90c562e84450ced77f17f98b8b5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
