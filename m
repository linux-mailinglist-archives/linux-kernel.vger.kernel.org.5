Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7D785C70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjHWPrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjHWPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:47:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1DE52;
        Wed, 23 Aug 2023 08:47:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdf4752c3cso35344675ad.2;
        Wed, 23 Aug 2023 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692805639; x=1693410439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WurYBg+NZ6za3J4za8WbFatr1squSIdva6ePZIn2LvA=;
        b=hJqtfb1IpkzbqQ07XrqAxskBHiC2FZIK1Bm0JszMZC87fH9rBaqpZ8h6/aOylD6Dpw
         MxvAb6RmJOpOPKfwU3iuK3aSV3BXwTlYruAdpRMvDAGXXLlP2G0Wg85d1bIElvDZwriu
         JRtnruY8sGEtosLMg2XRrJ019twrzS065fXWDz9ATNQvFJM6hgz48e/350DTJ1TwUrk0
         Wq1K3hSEFxD/Q0DX3fZNk+ODezNGfFevU8yi6H2NdsRI/OoW95CDt+naUhJSRqeK9MxG
         IDa/U3vOFbqUMkFh2Aur823FySfdriErJNUqiThASQsWyIZ0Sc3y1oA+yCbYZHHrc6kH
         euwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805639; x=1693410439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WurYBg+NZ6za3J4za8WbFatr1squSIdva6ePZIn2LvA=;
        b=MUL3UE5vstHmZ8BDoFODCm2pq0gsqz+yQ65qRFGsP0sCcjnd/GQdu5vOKcRo5rzzZZ
         5TKnv2oyoEtXF2p3vcwUx2zym603yxTaH6kpMEg79dyqClk8sPYonSjTAfh9twsF+9aC
         vErs6A0bTKuQSqfjSR13Fw6X74vyum065JpYLW/hZn0O0r5Z9/pwK4n/xap6vCOJMqbg
         agRnAd93RYKNLQUw3wcnEgkA368MnwiZgUQfhtG5fXdtGUKYSn/iXuCQT+4zUZTsgGUK
         mZ2ccrmLIJcWbjjLAQnvE8aKXn0oamrMnJe+Qk4Jh5PpKt+iUXrUdLXUA4a25iLScxug
         ElgA==
X-Gm-Message-State: AOJu0Yy9OAzIq35tTJRlPS6WTE9Ax3N4gOyBUhuY8XNtppYE3gQD41rJ
        PK118wUNc/3aCI2AnDVFJh4=
X-Google-Smtp-Source: AGHT+IHPj2nDzISm/XvpmfNVtMUdMs/0WMgdpjwvz+U0QN/Qryj1IeUFu2ksYk/W00AtMbg3bvajVQ==
X-Received: by 2002:a17:902:e5ca:b0:1b8:8b72:fa28 with SMTP id u10-20020a170902e5ca00b001b88b72fa28mr12241242plf.58.1692805639441;
        Wed, 23 Aug 2023 08:47:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902b28200b001bda30ecaa6sm11167111plr.51.2023.08.23.08.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:47:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 08:47:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: watchdog: Add support for Amlogic-T7
 SoCs
Message-ID: <88d42a22-7e07-466e-bd03-432ff3b6d71a@roeck-us.net>
References: <20230802033222.4024946-1-huqiang.qin@amlogic.com>
 <20230802033222.4024946-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802033222.4024946-2-huqiang.qin@amlogic.com>
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

On Wed, Aug 02, 2023 at 11:32:19AM +0800, Huqiang Qin wrote:
> Update dt-binding document for watchdog of Amlogic-T7 SoCs.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> V1 -> V2: Unchanged.
> 
>  .../devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
> index f5cc7aa1b93b..443e2e7ab467 100644
> --- a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - amlogic,meson-gxbb-wdt
> +      - amlogic,t7-wdt
>  
>    reg:
>      maxItems: 1
