Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD97F6D02
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjKXHnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKXHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:43:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0827D40
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:43:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso213991866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700811792; x=1701416592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyUAYuQRX6aMv+61STKF6DNySvEa6Ul2fK+eQe9Bzg4=;
        b=AzPHkjBEeShulv8K4LG1wkczHy/A8/2BBb+G3x73Ct7DXxdxZCq+z9J8DeOAhTP5ga
         oyLKKhMVOUjara2VTKqxnfDjZHYeu01Q+i1dhvcsArhjRwqL2ZSp+PuFg057GkC2roTC
         a5dXiUHxPtjCANxRJ46DlQDppshETp42Xqj00xaPr6OfyEMEZiU7bk7lT5H8kft6agv6
         27MGK2wkKUHWam4sc8dMD8HvaQt1voOGWXAo5aSzctEHH3oPvXrVefxhgA6v4yWv6eIp
         AmuIcsGXsCUWi9s02VvqYRSmXpWyQHBQyvFIEvOvPZUkrTEcg4kHDQbIGPoQ1A8YuYwt
         LL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811792; x=1701416592;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyUAYuQRX6aMv+61STKF6DNySvEa6Ul2fK+eQe9Bzg4=;
        b=Y7qovHdKVi6Tt46SjxgqagLXnPvDtUNCZ8+vmuEkUomj0LxSF5kYTXzPB/o2wl10bJ
         nqfrEtV+gM8P5Z5sW22uYH2JTzrYzCo31NmiwyqQUDcZeOwjk165OKD356tSKfVvme8l
         2jtgGVyrWVe9WHAR1qNUQFqc6/DXMw0oOKR6XMhefq7cyKnFZx2UBwnnvI701djix9OY
         hE7j40NO7I4pIkzGc6/gVmhQ4ThinHYa6MwmBsALAl8DObk65pfPN5JP0UvE5XI5VcgU
         SVp6PbS5wAEAFQXLsywxDdPZou/CS+xFm2Uv92iLmd7znKhp28q1G+SpGzDwG9oYAAwO
         Hjlg==
X-Gm-Message-State: AOJu0YxGjm0Nvt9PsLMs1Wt3P2139QMhAle5Mr4cAH0ap02P7cuKHuWp
        dgjtst3LeEaTrehI3sKCYQawQA==
X-Google-Smtp-Source: AGHT+IGnXq0BeOtlIbT4kEQh7doVHdDRII4iYS9KqxdWl5+fcxpPtU+60o/O2lPRB2xTa/94ly1y0A==
X-Received: by 2002:a17:906:2707:b0:a04:c9c4:8fc with SMTP id z7-20020a170906270700b00a04c9c408fcmr1296326ejc.18.1700811792060;
        Thu, 23 Nov 2023 23:43:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id q13-20020a1709060e4d00b009fe16be6a65sm1739448eji.63.2023.11.23.23.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:43:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        semen.protsenko@linaro.org, Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <20231122200407.423264-2-krzysztof.kozlowski@linaro.org>
References: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
 <20231122200407.423264-2-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 2/3] arm64: dts: exynos850: use Exynos7
 fallbacks for pin wake-up controllers
Message-Id: <170081179070.5541.8769953964405999458.b4-ty@linaro.org>
Date:   Fri, 24 Nov 2023 08:43:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2023 21:04:06 +0100, Krzysztof Kozlowski wrote:
> Exynos850 pin controller capable of wake-ups is still compatible with
> Exynos7, however it does not mux interrupts. Add Exynos7 compatible
> fallback to annotate that compatibility and match the bindings.
> 
> 

Applied, thanks!

[2/3] arm64: dts: exynos850: use Exynos7 fallbacks for pin wake-up controllers
      https://git.kernel.org/krzk/linux/c/2d8f82dd322fbaafc9c1a70d70efb6efe42c973b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

