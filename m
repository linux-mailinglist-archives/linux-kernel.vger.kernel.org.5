Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8344810BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378706AbjLMHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjLMHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:49:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C88E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:50:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1915034144so860190066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702453802; x=1703058602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvtn/gz8YL6Ce3HXfGFLuvh0AJH+XzrObcFPY0JHO+Y=;
        b=nJHOznshjaKJK+XR2lW4Qm7ZmpyY/lOx6ahMPrNJaPkCfVAfr2TXMiFmtzro9vpPJ7
         aVwz1wfx5mMahUOV6vj34Svgl5THp7iQSSLcfP8xNpUy08FEHwub578kGf2RIQvQ09xY
         uGg5aikbKP++haZmKZ5nLOri09yLiIlbbZZJgS8Cld/Cgzdbg6cbg1N3knchu+epF9Ww
         NmZys7GfQHf7K3znSqW4PsvdGYArYBMkldUzUZjSha+NYeUJA0REvT5ZidADvLRAuteR
         unSf/QbJ8rzKPUpUYsoHp5j1n7cWGyvEL046iJSThpW2xTnSGKKGIFWCwoYJNaubdCcx
         Mm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702453802; x=1703058602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvtn/gz8YL6Ce3HXfGFLuvh0AJH+XzrObcFPY0JHO+Y=;
        b=UNxYJavPhcp3E42ALy8aLcueLwh3OEUCBF3Roz1Ae70ElFf9jfwF9Royfw1M2XC5/u
         M6sPekwIszIXWiZ4qFuO4F1s6VkUu/PD9NfTzl03HaoWZJM1FrvviJrmWPcETDBo5DXT
         Vf25e4zNAMw94YcS2Cl6xxoEisEI+SX0aJldvG/Hn8AaMXf085ieVBiZA0kVDuTGIVVl
         B/WmsCrOTKcm3yTdmHj8t26dQTzBwGB8ZGnIsUDIhotEt6X1HKIXW2ShLUi/NeKMAvmj
         ZDKva0p3B7YcWQeCGwpaASfqJFM/rq1Rjy3iChQx9PN4HbmFiHPLIgKxSkYYxt+T0BS4
         1jmw==
X-Gm-Message-State: AOJu0Ywd3PcH8fohNBrBWj4UKti+GpVnvWfeuEFFNFNONHNXUPqSs1pX
        oAxkFqOIn1Xf7+WDCr2olzs2ig==
X-Google-Smtp-Source: AGHT+IEY8S5EAkfl0TgWnTfT9xclu2RZQfeyA+EIuy2UHvMlMrR/3Hv1WbUDbQq2o9H2HbQysVp8dQ==
X-Received: by 2002:a17:906:106:b0:9e3:fbab:e091 with SMTP id 6-20020a170906010600b009e3fbabe091mr5413257eje.15.1702453802327;
        Tue, 12 Dec 2023 23:50:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vt4-20020a170907a60400b00a1e1a1dd318sm7374141ejc.137.2023.12.12.23.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 23:50:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20231211114145.106255-1-jaewon02.kim@samsung.com>
References: <CGME20231211114215epcas2p226d66c6dd01a4414559272c648c3d464@epcas2p2.samsung.com>
 <20231211114145.106255-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH v4 0/2] Introduce ExynosAutov920 SoC and SADK board
Message-Id: <170245380069.18789.1595497375493388753.b4-ty@linaro.org>
Date:   Wed, 13 Dec 2023 08:50:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Dec 2023 20:41:43 +0900, Jaewon Kim wrote:
> ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
> This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
> IPs are used for safety.
> 
> This patchset is the minimal set for ExynosAutov920 SoC and SADK board.
> Currently, ramdisk console is available and Clock, UFS, and USI will be
> added after this patchset.
> 
> [...]

Applied, thanks!

[1/2] pinctrl: samsung: support ExynosAuto GPIO structure
      https://git.kernel.org/pinctrl/samsung/c/884fdaa53b38921165cd9afdb230502b4e1690b0
[2/2] pinctrl: samsung: add exynosautov920 pinctrl
      https://git.kernel.org/pinctrl/samsung/c/6cf96df77338c6a7e753229fe6d330ab60e28cda

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

