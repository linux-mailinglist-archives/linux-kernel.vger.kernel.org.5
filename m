Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0417A7EC2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbjKOMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKOMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:44:25 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394B11F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:44:21 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-daf26d84100so5359304276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700052261; x=1700657061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDeEkereiAIAe0FUqdP5N5yF0qKzFi4/lgt4oMPVPJ8=;
        b=KTzIJI0vyEipdbl3RkmUBghLdhKIxCGjx08IvDLQGYLSXpiLWzV4zsn06xPqFp6Kul
         x5MVsLJNM6FjzzPIahMYN7P6uXvPDjN5e5nlkDwCikUZjqpkamIVPmwdaRIcFCt3C1cK
         YXnG6jpFSR8GlA/XbjeTJb2DRkgZfLYPfXu8sVA3WeEAriT1k7WFSgu7CBO4rF132lqE
         dbLUlkACf0Cqoc9XHcR1S8+lbOZtCfl12k1PUqL9S+fwvZav4ynkEkhyOniWf0zF2mlS
         TfJvEeimiXIokpbiG2DjyFn+xB8teNJMaAUgZmmBErDq2NgKdmGT9hD0IT7ayoIpr3MO
         X8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700052261; x=1700657061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDeEkereiAIAe0FUqdP5N5yF0qKzFi4/lgt4oMPVPJ8=;
        b=Os5OhGqpaa3Bmtt2DO7auJq8o4CmweIUsItjLUwK6TI2k6atU7eWAAe0U3UvqhwLei
         T1iYBlYwtHzXBpvu4EuBKbOZ1MK2nzLfnaVzDkjLztx69pEK0IbGIu636O8PEhRp6c4+
         JictLvXxxf2mRFglg88qtt5fKGJSmPRwKDv4PZRevWNAcozYdZQ7q702mlK6hKgJiMDQ
         tGsXxLvwSjEmjebtR7ckH0e3X269xUY+wbjir7emiWGOqpvhbL3yO7tGH1RrMoC12/dl
         UKZfTK4vXH75W1pvyF7DQL+iefEyFmAOIH++1hygyrqDaoiTax347PkvwcPvTGagI8iO
         y6lg==
X-Gm-Message-State: AOJu0YxS1RmidSawOz+itHqyoymUEg/zil/Ta1ZDEgRdjjh3fS37A9/P
        OjkS7KCfkLqwVCs77Kz/DEbpww==
X-Google-Smtp-Source: AGHT+IFfGb6mZX8mGeMVlXdfJR95sgELctz4H5+vZhgwUg6VNMf7lb1HDhee3lSbcSQuhkvaW9Ckxg==
X-Received: by 2002:a25:ca53:0:b0:c4b:ada8:8b86 with SMTP id a80-20020a25ca53000000b00c4bada88b86mr11872481ybg.64.1700052260882;
        Wed, 15 Nov 2023 04:44:20 -0800 (PST)
Received: from krzk-bin.. ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id pz28-20020ad4551c000000b00677af708ebfsm504920qvb.126.2023.11.15.04.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 04:44:20 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: (subset) [PATCH v2 06/12] dt-bindings: pinctrl: samsung: add exynosautov920 binding
Date:   Wed, 15 Nov 2023 13:44:13 +0100
Message-Id: <170005224375.13297.8512275766999804911.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115095609.39883-7-jaewon02.kim@samsung.com>
References: <20231115095609.39883-1-jaewon02.kim@samsung.com> <CGME20231115095854epcas2p457e0eedcd0b4a001eba8fba012f73920@epcas2p4.samsung.com> <20231115095609.39883-7-jaewon02.kim@samsung.com>
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


On Wed, 15 Nov 2023 18:56:02 +0900, Jaewon Kim wrote:
> Add compatible string for exynosautov920 pin controller.
> 
> 

Applied, thanks!

[06/12] dt-bindings: pinctrl: samsung: add exynosautov920 binding
        https://git.kernel.org/pinctrl/samsung/c/fe8741faa3d9b4dd187708fed937da2766b29da4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
