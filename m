Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE37630A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGZI7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGZI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:59:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC919AD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:53:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so1554477a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690361587; x=1690966387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y323VqrnUwbgFr3AWb69nYFgPXshHmv3xK/j+qJy0Bg=;
        b=Xfj/4PSo4GwepbrqH4ykwdWq2F3+aV9+IwCm0z0na6qALSSvFky5z/aDJjzySbo8xf
         rb0gc8He5P3H0AQFdfQsakIc4/6km7FAGGWGYQVURdtmpkN7YsomsMD7xgvL7zOCvEaP
         gVqzVgEhGBN/zbM+4mdju9H9V05u2avVS7KrPearyxsIcOs0vN6kZiVIoy3hNLEG53px
         A7jAGYO5IFdGEJ4XkvMycqSaZ4qacog8mhjWxx3OJnizcqxWRB9aNKln6aG1WGgpfleO
         DDnpy6KWwh3ZRACV0/UhJiwVASCqgfkKkxmqY/7DxEZPL8mbNOIRPf5kei2uFRhRy+gg
         G5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690361587; x=1690966387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y323VqrnUwbgFr3AWb69nYFgPXshHmv3xK/j+qJy0Bg=;
        b=QrHAobI3GmIDGdezO5L7n0IWWD+Cz7IQOkN/ZWepFASO0XOcD+fL/7pDWqzUEoYaRO
         P+63xEtB6aHHqGePaSR8ZDb0oPzmFgs0fL2cxrZieOHLlCgV8tNCfFx4xfTRVbO7KHfU
         K3heGAL5J2cZwIROCIncMW1dtesjvB96lnDvbqTUnRic5hLAuaR7Pdla8dueX/HqKTMX
         5S9AhPrtM2PkkB+ULb3wO24YrZwq6gC/s0HyHKRMDZizBMrjoVEd5aBEhqhPVb4ri5r2
         Hbj63r8lk4sZv1knDXHzq5lzkW9i2EV4TNXx1B0OPHuPfvpJzsy8xULFxEfasvkSYpGg
         /sAg==
X-Gm-Message-State: ABy/qLapvlnxCb3k88lZqv30X4xbt49oBhChVhmGxhp6LxQpL3SLjd8K
        tSP6/TMoCUGXBCgGhO+2HOKfaQ==
X-Google-Smtp-Source: APBJJlGJkcswTgOcEC/0azVT1I0P9EPqZI5ur9E7qHLTgnW7AEp7IKoSN5ESxsx2FVdpiE8O5+jd6Q==
X-Received: by 2002:a17:907:d01:b0:978:8979:c66c with SMTP id gn1-20020a1709070d0100b009788979c66cmr6659274ejc.18.1690361587522;
        Wed, 26 Jul 2023 01:53:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id rv14-20020a17090710ce00b0099b921de301sm4606340ejb.159.2023.07.26.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 01:53:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, replicant@osuosl.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: samsung: exynos4412-midas: add USB connector and USB OTG
Date:   Wed, 26 Jul 2023 10:53:02 +0200
Message-Id: <169036157564.124820.10583684522543257497.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230723142417.97734-1-krzysztof.kozlowski@linaro.org>
References: <20230723142417.97734-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 23 Jul 2023 16:24:17 +0200, Krzysztof Kozlowski wrote:
> Add full description of USB-MUIC (MAX77693 MUIC) and MUIC-MHL
> connections, along with proper USB connector and OTG mode for DWC2 USB
> controller.
> 
> This fixes dtc W=1 warnings:
> 
>   Warning (graph_child_address): /i2c-mhl/hdmi-bridge@39/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: samsung: exynos4412-midas: add USB connector and USB OTG
      https://git.kernel.org/krzk/linux/c/57f706bf73079379a9e9f5490c94c2473077bb2e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
