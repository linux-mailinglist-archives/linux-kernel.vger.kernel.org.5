Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E279B73E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356191AbjIKWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbjIKLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:39:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08059E4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:39:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-317c3ac7339so3997047f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694432371; x=1695037171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xobEw3dWGWqa/MKJ616lGiXiH8NsToU1rm76WPlst0=;
        b=o0UCY5vZafH9Qz1ohhA/zZyXJ8vmxDxBTsFYXkLGQtGZ/ebv05FHsHSpA0xtKiar+E
         ck5bF54C3nUFD0dIh0ag5bOCBl4jKYTGYBjqxdOi0G7zsZnzxfMRU6nw2kxP1wTLMGVb
         9Jb7csZCkkIN8BNzeMIt6Ltbwxuw+ehawMeVU9WS097gmT/Zf/n3JRKt2nQxBZ/bjkX1
         8nLCKUJHcWvvsSzFl3KYF9btOVp8R2CcFEIWHZE4Flw14yyAKKla0WkdDMv4s0UVkPAR
         ppEJTp0ygOZ2IO6h93YLpQODg79FrioQlY/Uvr4TZlEHacMnZMqnOzEahYUv/CRihAJY
         2JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432371; x=1695037171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xobEw3dWGWqa/MKJ616lGiXiH8NsToU1rm76WPlst0=;
        b=NJch2DtJv1yz9gdlCcpEVx1Q/ZNxzojFWe9r68O2ReglCaheLAxrf3XVpPwrwDZ+zt
         Gn6XH3u+0rtXgB/MLKCWkhCWyfyaT4FMqHcTIqfS+Wqlc6W3bmwCjnQ2wr/uCWljTi5w
         YcXbBWEQQtx/QBpFmNPU0d3Aq4oK5oNECoOx8b4LFlJXBOW03hYB7I2rrqIIoDtSg+9N
         mnDkx98JGVuCuPQzp0xOqPfq4O2IuAs/FnLO3PmcTxAYDxSrWPsFGB87fHbwh18ZnwnD
         UmTTC99zFkk6dW26GkjOQdLO91KJwDDPs0ypO0T8Nt/uL53SfLbLjKt7xqchgfoC6X+N
         6KiQ==
X-Gm-Message-State: AOJu0YzxABBMQiRfSGngxFloCSRlS+3sCoGHYhUmDlSxL1ZG8hoi6jV4
        iOn6/UeNEMTaa4C8t1LNXBvw9A==
X-Google-Smtp-Source: AGHT+IG71SGDp/D1D4AhCLBkMhgmC1yfDcdZoDBZg1is1WJqDXuiI7ooRn5v+pBNF3d59frbXMBphQ==
X-Received: by 2002:adf:f302:0:b0:319:790e:3bc5 with SMTP id i2-20020adff302000000b00319790e3bc5mr7018815wro.41.1694432371116;
        Mon, 11 Sep 2023 04:39:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id g15-20020a056402180f00b00523b1335618sm4431003edy.97.2023.09.11.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 04:39:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/8] arm64: dts: exynos: exynos5433-tm2: switch sound card to audio-routing
Date:   Mon, 11 Sep 2023 13:39:23 +0200
Message-Id: <169443234709.34398.9426055874115362482.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
References: <20230731095730.204567-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 31 Jul 2023 11:57:23 +0200, Krzysztof Kozlowski wrote:
> "samsung,audio-routing" property is being deprecated, so switch to
> generic "audio-routing".
> 
> 

Applied, thanks!

[1/8] arm64: dts: exynos: exynos5433-tm2: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/4179ae98fd525f2895ac726fcd433e730c5e8727
[2/8] ARM: dts: samsung: exynos4212-tab3: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/fc730f1702e2a5de9ad52f98189460c0d7d75916
[3/8] ARM: dts: samsung: exynos4412-galaxy-s3: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/a1116f96688c7e2d210635ec7cb631473d8ef653
[4/8] ARM: dts: samsung: exynos4412-n710x: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/1222d604dbbbe54a9e9d5811d46f0680cc9972ce
[5/8] ARM: dts: samsung: exynos4412-odroid: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/f632a4376134722cb16c78d819505aedd9c0d8e3
[6/8] ARM: dts: samsung: exynos5422-odroid: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/c670e7c8f72f68b4fc20eb85fa6101b5ce108515
[7/8] ARM: dts: samsung: s5pv210-fascinate4g: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/04e08772a1ffa0620fbf89dfaed3a7aef724c739
[8/8] ARM: dts: samsung: s5pv210-galaxys: switch sound card to audio-routing
      https://git.kernel.org/krzk/linux/c/8edc16a1e27a941670907a94d15dbf7f68fbf8c7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
