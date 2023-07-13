Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D0075214F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjGMMcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjGMMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:32:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC59A26AC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:32:12 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3CE923F18F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689251531;
        bh=OmJAYdfXr11pAMCyImFxnsohime3j/dmz8eTaaKAUKk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EeOpKdTeWsUGMegm/tpIcxtC2im00+Rw8yg4uxkIcIu2zO+7WewGTzQOFPuYLW7r8
         +67aAoaPh6gG/Tr6Wc8oy04srXVCRi5TfXpNW/Y+l4NhsXE1e3oNo+bXqfpvK4j9Pw
         2IGe3YCbVfGe2+qM9R03sN8QjrJjF1LlZL6ktSj7SP1E3U0a386dmJEWPyEdY3dNy+
         vfpgTwn93eoqO2jxQKRGU8ZH9x2rO3CZPpH+S3rgdQuBosdMsR3D54zO0Rjro/ujDI
         bzPw3n9Ai9QDNQoAI2eBz8bGCuE63XJxl17hRotOknEO7WnB+35QRhzsv95VbM0hoC
         tnKx2Onhhm3vQ==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-403b134421cso4992041cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689251529; x=1691843529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmJAYdfXr11pAMCyImFxnsohime3j/dmz8eTaaKAUKk=;
        b=CdBH1L+NGCEWCjLbu9sK7fy75lqInBzCY8eNJMEIqqHA0ha2Rcn2sk8Avrst9PUBwn
         i+WkW+JGq33Dx0cqRA7taE0hTgiWD9VWqBJYw7uF8NBO5C6OWC+pZw2L6vkHa87ttfm9
         EcVZkVlcvTbrNywpQkm70CLUr2JFfJfu5TwsBjH8gH3BSjA8JR48Ld57llgQIG1BXtd9
         7VNiTUoUN/jHUUU0z0eEFtqV/S4s4tnzuhSljyAlXrt+6fm3KHNCgjDZ4i+GtE2WVgHJ
         s/lLWhbBl6yNMT2kDzkhcCsH1I7tWt8suo2F34NSwEveErPFSKwrrwBTSH9ZB/+QV6aX
         /7CQ==
X-Gm-Message-State: ABy/qLZ93ToTzVXyqcwGf4UO0D1dr2BHLScdFauRmNyPDNsQZwpsbyp6
        rNVJNsTkJyYq+SSHvueOEDOePJuwYUUsqlwXpsi+fEq0APV5bU4uJQ3bmPmbfOx8VxM70lhBqrN
        W1OU9Zdrlu+bzmE4g++e4EDRNkIBob7BaTpiW0voAgkwyZl+In8k3zDM3GQ==
X-Received: by 2002:a05:622a:13d3:b0:400:9346:bf36 with SMTP id p19-20020a05622a13d300b004009346bf36mr1833909qtk.17.1689251529210;
        Thu, 13 Jul 2023 05:32:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHA5vK3hxfhXcY8G5rQmLZDXTBJyd7aSNs425ysD//K9J5R9Fx3mszf1d/OFc5OhPAt3GVAQ5/HeZZIq31NJYo=
X-Received: by 2002:a05:622a:13d3:b0:400:9346:bf36 with SMTP id
 p19-20020a05622a13d300b004009346bf36mr1833884qtk.17.1689251528953; Thu, 13
 Jul 2023 05:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com> <20230704064610.292603-3-xingyu.wu@starfivetech.com>
In-Reply-To: <20230704064610.292603-3-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 13 Jul 2023 14:31:52 +0200
Message-ID: <CAJM55Z_G-OA_zmYoYueOGgYKMFHjPurJYAypTBw=P4WLkyn9Bw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/7] dt-bindings: soc: starfive: Add StarFive
 syscon module
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 08:49, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> From: William Qiu <william.qiu@starfivetech.com>
>
> Add documentation to describe StarFive System Controller Registers.
>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 93 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..0039319e91fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description:
> +  The StarFive JH7110 SoC system controller provides register information such
> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: starfive,jh7110-sys-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - enum:
> +              - starfive,jh7110-aon-syscon
> +              - starfive,jh7110-stg-syscon
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-controller:
> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
> +    type: object
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-sys-syscon
> +    then:
> +      required:
> +        - clock-controller
> +    else:
> +      properties:
> +        clock-controller: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: starfive,jh7110-aon-syscon
> +    then:
> +      required:
> +        - "#power-domain-cells"
> +    else:
> +      properties:
> +        "#power-domain-cells": false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@10240000 {
> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
> +        reg = <0x10240000 0x1000>;
> +    };
> +
> +    syscon@13030000 {
> +        compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
> +        reg = <0x13030000 0x1000>;
> +
> +        clock-controller {
> +            compatible = "starfive,jh7110-pll";
> +            clocks = <&osc>;
> +            #clock-cells = <1>;
> +        };
> +    };
> +
> +    syscon@17010000 {
> +        compatible = "starfive,jh7110-aon-syscon", "syscon";
> +        reg = <0x17010000 0x1000>;
> +        #power-domain-cells = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35e19594640d..58ba04bd0bc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20127,6 +20127,12 @@ S:     Supported
>  F:     Documentation/devicetree/bindings/mmc/starfive*
>  F:     drivers/mmc/host/dw_mmc-starfive.c
>
> +STARFIVE JH7110 SYSCON
> +M:     William Qiu <william.qiu@starfivetech.com>
> +M:     Xingyu Wu <xingyu.wu@starfivetech.com>
> +S:     Supported
> +F:     Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> +
>  STARFIVE JH71X0 CLOCK DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
>  M:     Hal Feng <hal.feng@starfivetech.com>
> @@ -20164,6 +20170,7 @@ STARFIVE SOC DRIVERS
>  M:     Conor Dooley <conor@kernel.org>
>  S:     Maintained
>  T:     git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> +F:     Documentation/devicetree/bindings/soc/starfive/
>  F:     drivers/soc/starfive/
>
>  STARFIVE TRNG DRIVER
> --
> 2.25.1
>
