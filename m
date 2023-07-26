Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45E176319D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjGZJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjGZJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:18:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6872709
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98377c5d53eso1023804966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690362871; x=1690967671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fk7i5bQAJr07YyKh76/8O6OztU2SbJcyOHEnuaDv3bw=;
        b=P+rVX4ms6l+sKxD6dS+weINuQvPKRoyvv3wc9Dhaea/+ftSWOHkfJcf6LAvcLMa7gk
         t9elhcZFsuxwjf5EFQXhQkY/w5tQGQ+Uoffq5KtpfuALvvr8cAjPhJpVBVvOzVMAd36y
         QevTQ4ry6nijQvIbS7jNKsuE2NkqHZo12vuB0rHSY32/PyiwCc1goiLD7bCUWYzO8G2n
         UItG7jYmzIfhJd7PV4o5ksExVsM4hXdRohXhnZOr1DGuMqeEss7JZxd1B/WSd0CVjh/u
         7EKDGs4w03aYHDRQr/u9WrX4d8HCZC+xZ5buaiC9zOkWZJXgUjmKA9uF+1E2XhFq6VXN
         yS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690362871; x=1690967671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk7i5bQAJr07YyKh76/8O6OztU2SbJcyOHEnuaDv3bw=;
        b=J6nKyIHFeAAVKyT5gOP0rD7lG2FbpYJO4ymhYgC7y/mI9BcxDdE9JJT5LvZONqKm17
         FxcINfmfDclPTgGcx0JClfDXKtnmmFpvjNlSsuTRnJ7cZ0aIsMATovOA7compISKabzf
         knoNvAZMKMQdlQ8uILdUy6onTVWpN3TwcvUtmK9/52hxBFR2fyyvaR4bm04U2M/T0udI
         i3MCEfHPFpcDiC8TX+oB5kvyXihj7UR7rtErle/KDIyf6KC2kBwqJwyRQIZYqYNPQHji
         PwQQRI1Ss6u5TX5FuvwQ3B+xDxSPyebIWp7qz6yd0C8fF//FfEbkj9S82sIpnrTInmp9
         K2Wg==
X-Gm-Message-State: ABy/qLZHpzSfaj2gvMNujolA7sr2Pa2SAwfNF0WghIhhW90p/OPdFrkv
        0RCmyRQj8ruHrvltm0opF0eBuA==
X-Google-Smtp-Source: APBJJlEZzqiLGtY7i68uveOMtCr/P9iDDdKgv5h1StpH29ideFo6Muj51mPd4SgnFQ0WWi9T5jrr+Q==
X-Received: by 2002:a17:907:a064:b0:993:f8b2:d6fa with SMTP id ia4-20020a170907a06400b00993f8b2d6famr1094370ejc.21.1690362871004;
        Wed, 26 Jul 2023 02:14:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm9384492ejb.84.2023.07.26.02.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:14:30 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v3 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS TLMM
Date:   Wed, 26 Jul 2023 11:14:18 +0200
Message-Id: <169036285577.127914.11011181994412029245.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719192058.433517-2-krzysztof.kozlowski@linaro.org>
References: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org> <20230719192058.433517-2-krzysztof.kozlowski@linaro.org>
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


On Wed, 19 Jul 2023 21:20:57 +0200, Krzysztof Kozlowski wrote:
> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
> driver is similar to SM8250 LPASS pin controller, with difference in one
> new pin (gpio14) belonging to swr_tx_data.
> 
> 

Applied, thanks!

[2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS TLMM
      https://git.kernel.org/krzk/linux-dt/c/be9f6d56381d995f600524ad99fa8a9cc5bd5c49

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
