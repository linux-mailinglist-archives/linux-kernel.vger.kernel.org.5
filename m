Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8180AF45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574830AbjLHWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjLHV75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:59:57 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFD1708;
        Fri,  8 Dec 2023 14:00:04 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fa1c3755afso1218403fac.1;
        Fri, 08 Dec 2023 14:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072804; x=1702677604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNPRU0FNU7QKtEQcMllHcv0YAtO+zJjy7ZQCkfvhnHc=;
        b=vQJmI0NuWCt6c90ypigLd0WMXIv1LqhnA56h4uxn8cwqxOKrxZVyaZ0mM/mmqwgQiu
         UQpUxSDWs7scg+xem+HWMdsdIsI9HiX4RcNSa04wdVeRW/U1T53zHSAv+jB5le8NN3E7
         atVOuv6xbrz/knzR1EZ7XIwYmyhkt3NxP69vXiR0A3uGFMJ+4HDWbwF26LtXSR0SP+lT
         ueMr2rlmRYkwmEW4d6APaSqknWRkqt3RDdZQuU16LUN7/z9A5dORDzmJmJj7erKpvre9
         p090Q6pmKodavEcHUgDR63hp2oV8kn3uvR7MJWtKyd4xHHcnV0aK8BUUYnO5r1YrOZTh
         9cqg==
X-Gm-Message-State: AOJu0YwWINU9KU+CnH13ZnkAKhNod7tBMXQIY1Xo+mwcOP+3NUhvx8EU
        gVfflsM5ZPGrz1Qrkq5Bnw==
X-Google-Smtp-Source: AGHT+IEZhSY6G/TyluC+ct9+exH9dx3QLmpi6Wrof4HsaI8jDGw2gC+wh0RS4B73rQHe14EDAfUUVg==
X-Received: by 2002:a05:6870:239f:b0:1fa:df5e:48be with SMTP id e31-20020a056870239f00b001fadf5e48bemr396047oap.15.1702072803500;
        Fri, 08 Dec 2023 14:00:03 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ho13-20020a056870498d00b001fb3a053eaesm620436oab.34.2023.12.08.14.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:00:02 -0800 (PST)
Received: (nullmailer pid 2876137 invoked by uid 1000);
        Fri, 08 Dec 2023 22:00:01 -0000
Date:   Fri, 8 Dec 2023 16:00:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3] media: dt-bindings: ov8856: decouple lanes and link
 frequency from driver
Message-ID: <170207280134.2876077.6594221825258184727.robh@kernel.org>
References: <20231208195253.130470-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208195253.130470-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Dec 2023 20:52:53 +0100, Krzysztof Kozlowski wrote:
> The data lanes and link frequency were set to match existing Linux driver
> limitations, however bindings should be independent of chosen Linux
> driver support.
> 
> Decouple these properties from the driver to match what is actually
> supported by the hardware.
> 
> This also fixes DTS example:
> 
>   ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [360000000] is too short
> 
> Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-interfaces schemas")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v3:
> 1. Drop link-frequencies entirely (Sakari)
> 2. Add Conor's ack
> 
> Changes in v2:
> 1. Rework approach: decouple bindings from driver instead of fixing
>    DTS example (Sakari)
> ---
>  .../devicetree/bindings/media/i2c/ov8856.yaml | 24 +++++++++----------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

