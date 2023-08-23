Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC3A785C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjHWPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjHWPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:46:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C571717;
        Wed, 23 Aug 2023 08:45:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf55a81eeaso26878265ad.0;
        Wed, 23 Aug 2023 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692805522; x=1693410322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgyeGdbslhNv497sxSi9T9F8ibgrZruUJHbypuA4l6Y=;
        b=jixuxBy6dLyqzAugK26aoYw0LHQTx9DCcGP9ZOAzYpSmA3crvbg6NPiyoC4P6lFTgU
         R1w8rNe43s2U/PV3ehvtlmAeDWIE93dhMXJNiyRUmM8K6B7jp71JoTE3AMMXa/EojZr+
         vGR3WY2zfn6q1ZOZVMfixe6WWpWpf6Pl+c+EFBx0GILy52cD4x3zaQUOQvwNs0nrhBbe
         oku0F6PnEUZbaI8P3rhWH6XeZJ9FUhB+B7AidlpWhG0gpd1fNu3nhZZQgPaHgBG6u/jG
         JLPeiKY3z7GfzEfSd4UKGr0AIsHoxbd1l9vX1V8It7YLtECvMoxBfUqu5oTCFp9YGfaB
         TK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805522; x=1693410322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgyeGdbslhNv497sxSi9T9F8ibgrZruUJHbypuA4l6Y=;
        b=LRVLsp6B7C/wRunb6NvQNioIWAEQ1rplyQhzlC6P9iWxMPxYVyFtNplBi4NU8VrxZU
         4bnHUACq05gjoz/lqZZN5IgiHtGsPLQAyE2Wpb8RcKROu3iT84fwKlAhdu2gYJLtP+gD
         zmh12XsHHqyq/h7RWp8n3dm4TkX69Di58uevfTSywMvH17eppHgSd58GWXT66MR+/M5B
         ea0BNW0lKBGvC39Ev6tY36H9sDxbQeeCvKANze1TZSkRSjYy+nBrUBUIrd+uXPDZq9nk
         DuhuT+k02jGWAaE/PJNSv8p62uZx7l6OFxeKDd/8pS5ofWnIGHgrfbiVM27UwAIhbGDa
         hu9g==
X-Gm-Message-State: AOJu0YynSDDiYIhWkDKhJMnnnx9lpFXXHXNfL21n9Kkaxmpug9quAy99
        avrC3oQ/kJXz5nIYAZ/W5/8=
X-Google-Smtp-Source: AGHT+IHoxUe6KTbUqRFXtM8YgfcSwLH7IdrqQeJIEYuWOh354lKGc750/NspA/0hl92k8FhJo7DrrQ==
X-Received: by 2002:a17:902:b617:b0:1be:f76e:7664 with SMTP id b23-20020a170902b61700b001bef76e7664mr9480732pls.29.1692805522050;
        Wed, 23 Aug 2023 08:45:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902744500b001bdc5023783sm11131773plt.179.2023.08.23.08.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:45:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 08:45:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: qcom-wdt: document IPQ5018
Message-ID: <79414186-3c5f-4166-a81a-6b346e544253@roeck-us.net>
References: <20230816161455.3310629-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816161455.3310629-1-robimarko@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:13:59PM +0200, Robert Marko wrote:
> Document the IPQ5018 watchdog compatible.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 6d0fe6abd06a..5046dfa55f13 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,kpss-wdt-ipq4019
> +              - qcom,apss-wdt-ipq5018
>                - qcom,apss-wdt-ipq5332
>                - qcom,apss-wdt-ipq9574
>                - qcom,apss-wdt-msm8994
