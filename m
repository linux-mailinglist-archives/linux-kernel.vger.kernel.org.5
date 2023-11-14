Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F17EB097
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjKNNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjKNNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:10:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7C19D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:10:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so3865370f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699967434; x=1700572234; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kylEPySB/5FfOKILQp0wcgiznvVbaF9pAdNSaICh0gU=;
        b=1EhKFpv9vfdMGmBcW+Z6TL893F2Hhzoh1GYxTxra5II3v/4wLitzg9OdchqrJa72lB
         UUcga1gdhNnJ8ECeWztSYTaEusHoSoiSm/VXYa2o+Ov2pmh1V+yYlbr95WlXzbPBURB2
         fm0K3sI9kYbkraDxuPKPwVhp7mT7f7FsBZ2ljDLSm8ByFZ8VgBXIUdFXrYyREWuWzTNH
         C5d/taRxg1GuMUWmkhBc52FGzsWYe6JiXBRrnAAhmtSQyojaL708yvIGzYvjfNVMR6Et
         Y/AY5kXf7RClVstmBGvFEC85gZaUt++X/5KYV0jOin6ZZadaow+1+3GJhS4kVRuYoVQg
         vXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699967434; x=1700572234;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kylEPySB/5FfOKILQp0wcgiznvVbaF9pAdNSaICh0gU=;
        b=TiOQ8RiDpCRYVKs9i/mFF0qfZVJrWLNc1xr292qswa5G7C0HFrFh9aLT2a9J26CcBV
         RWWpH9KZaSnA3HK4DnvA3hCtAWl3GY05jfz0QE20V9ad3zFhrTMVYwU1ZJV7NI0u/zMK
         FS4pgMOCenTxz4w09qno+D2XPFkC2bg1W+DIDxNQLLRKEwOXYREjJOrmnCEYET7309Jc
         rivHhi9ferjHwJ5RSMHP2jZVDL3AFCpOyH09d/wE+MlPww9zv7HpWt7tzUvrRisLmqUb
         lyaAKG0N8dIBsg6BYfCanw/S0NguJHKPy4tZz4Sj/XpfwNjmKJaCV/Cv8vx3jOvy90HD
         A6xw==
X-Gm-Message-State: AOJu0YwvaqoJ8QY/D2pn/YvDTdDPbL4+wXhmenaXm6I0yJ5koWbmAL4P
        BB3NTvmQXEvXMDpHe56cj4LcUQ==
X-Google-Smtp-Source: AGHT+IGziU1soHXdOrIYoiZhkJ3lrSemdXNvFyCejd2ntbWKzDN90NoFHYrl0P9aRWDq0a+dBQ2I1w==
X-Received: by 2002:a05:6000:4024:b0:32d:b991:1a71 with SMTP id cp36-20020a056000402400b0032db9911a71mr7443849wrb.0.1699967433842;
        Tue, 14 Nov 2023 05:10:33 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:8fe7:3223:c57b:4b01])
        by smtp.gmail.com with ESMTPSA id i20-20020a5d5234000000b003196b1bb528sm7843980wra.64.2023.11.14.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:10:33 -0800 (PST)
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
 <eab3869c-7529-484d-983f-dd85ecfbeb0b@linaro.org>
 <1j34xdcwf4.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH V6 0/4] Add C3 SoC PLLs and Peripheral clock
Date:   Tue, 14 Nov 2023 14:07:16 +0100
In-reply-to: <1j34xdcwf4.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1jleb0bhvb.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 10 Nov 2023 at 18:50, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Fri 10 Nov 2023 at 14:20, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
>> On 06/11/2023 09:55, Xianwei Zhao wrote:
>>> The patchset adds support for the peripheral and PLL clock controller
>>> found on the Amlogic C3 SoC family, such as C302X or C308L.
>>> 
>>> Changes since V5 [3]:
>>>  - Fix some typo and modify formart for MARCO. Suggested by Jerome.
>>>  - Add pad clock for peripheral input clock in bindings.
>>>  - Add some description for explaining why ddr_dpll_pt_clk and cts_msr_clk are out of tree.
>>> Changes since V4 [10]:
>>>  - Change some fw_name of clocks. Suggested by Jerome.
>>>  - Delete minItem of clocks.
>>>  - Add CLk_GET_RATE_NOCACHE flags for gp1_pll
>>>  - Fix some format. and fix width as 8 for mclk_pll_dco.
>>>  - exchange gate and divder for fclk_50m clock.
>>>  - add CLK_SET_RATE_PARENT for axi_a_divder & axi_b_divder.
>>>  - add CLK_IS_CRITICAL for axi_clk
>>>  - Optimized macro define for pwm clk.
>>>  - add cts_oscin_clk mux between 24M and 32k
>>>  - add some missing gate clock, such as ddr_pll.
>>
>> Where are all these versions? Please provide links.
>
> I have provided some guidance offline at the request of Amlogic.
>
> This should have been v4 and the cover-letter should have summarized the
> change from v3 to this. Unfortunately it was sent as v6 :/
>
>>
>> Best regards,
>> Krzysztof

While labeling this v6 was a mistake, please continue from there:
next to be v7. Don't reset to v4 or v5. If more versions are needed, I
don't want to end up with 2 v6 on the list, that would be even more
confusing.

Thanks
