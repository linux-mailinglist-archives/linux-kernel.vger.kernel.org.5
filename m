Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCC7DA84E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjJ1RvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJ1RvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 13:51:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BBDED;
        Sat, 28 Oct 2023 10:51:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c2a0725825so498635066b.2;
        Sat, 28 Oct 2023 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698515479; x=1699120279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbiy2rE6nG2vgOrPLXT+XY5radBmO87tG9FKYMDiE3w=;
        b=ECBsbe3TF4niDGRMaSWn9rwumD2wUGFA64Sw6A7rJ+AZ23/0nLTzDg0YaT/QTZkRVB
         IneNGAqfGlxrnSEprTxTE/pI2EFqjtNmFkinauGnDyMEj2VdBixe/ro/F3nTCN3e+CkG
         wkqDKHL8H6PdEqPUgW9B8/0XoSVdOLPwpngZCf+O3fOM2xMnr83+M4aK8D3yKRR4N3to
         kOF280UFhnxywjhuBeEV1jZhWmt2dLaZmx/oDLd6taIugpvkqnIUrkn98+2AUZ4FR5sq
         /msX0gmvU9fDYav2Mmp64KMgC5BQBap/T7s26q8reh39KH0HPIsciaO99m6KRLl9WT7P
         tRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698515479; x=1699120279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbiy2rE6nG2vgOrPLXT+XY5radBmO87tG9FKYMDiE3w=;
        b=vHwtunkw5cKasfWfrqStCwDDtgL20wvXPDPWu99ymrbkBgujLtB/2LmTDbp/djXpAG
         Mu6Afvb9YA4cvGpUAJ6ppfh/XVdmgG46w8b/TE3UKo2q9NZYCFnqic+LxS28gH3WBPS7
         wCJY5AzcLjVSkP6L5ko0QRXdK1+LXVsHHk7EBGMaDvq7mi7oR0tvD3FjrCT+gj03RRG9
         f008z7IBXc49EM8z99W7ruDqItSSKr1GJJmO51O9zoM3cM/Gda+brbTvVA7ouYzUW3Cn
         zfEaYZzglBljW6Hzd1IrPY1rYQ2K6XnrGJsuKy8KsLKCq/gIT27V80bFFoUclpOTiYtf
         o5zQ==
X-Gm-Message-State: AOJu0Yz7YaPZQKOCJzJajmYaDUquR4TYNT6T6wPLCdXqVKX48zp4NGI+
        ztxD6Ni7hpfjqOQ6SVu+Dow=
X-Google-Smtp-Source: AGHT+IH5bb7Gh8p3N+4kRD0kWR/qH2LSYMq1swofkA1wnFWgoknMdICr8O5bjhJIaMUi4VARaCmpsw==
X-Received: by 2002:a17:907:96a5:b0:9be:5ab2:73c0 with SMTP id hd37-20020a17090796a500b009be5ab273c0mr4505784ejc.8.1698515478452;
        Sat, 28 Oct 2023 10:51:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:d7d0:94ba:33ce:cfd8])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709064a8600b00977cad140a8sm3070593eju.218.2023.10.28.10.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 10:51:18 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     conor+dt@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, afd@ti.com,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, n2h9z4@gmail.com, skhan@linuxfoundation.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH v3] dt-bindings: watchdog: davinci-wdt: convert txt to yaml
Date:   Sat, 28 Oct 2023 19:51:15 +0200
Message-Id: <20231028175115.98844-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027-antennae-aftermath-b11ede90737f@spud>
References: <20231027-antennae-aftermath-b11ede90737f@spud>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! 
Thank you for your review. 

>On Fri, 27 Oct 2023 at 16:14, Conor Dooley <conor@kernel.org> wrote:
>Hey,
>
>On Thu, Oct 26, 2023 at 09:53:13PM +0200, Nik Bune wrote:
>> Convert txt file to yaml.
>> Add maintainers list.
>> Mark clock as required property, by reviewer's suggestion.
>> Add power-domains as optional property, by reviewer's suggestion.
>>
>> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
>> ---
>>
>> Changes in 3 (according to review comments):
>> - Added Andrew Davis <afd@ti.com> into maintainers list.
>> - Added power-domains property.
>>
>> v2 patch: https://lore.kernel.org/all/20231024195839.49607-1-n2h9z4@gmail.com/
>>
>>
>>  .../bindings/watchdog/davinci-wdt.txt         | 24 ---------
>>  .../bindings/watchdog/ti,davinci-wdt.yaml     | 52 +++++++++++++++++++
>>  2 files changed, 52 insertions(+), 24 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
>> deleted file mode 100644
>> index aa10b8ec36e2..000000000000
>> --- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
>> +++ /dev/null
>> @@ -1,24 +0,0 @@
>> -Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
>> -
>> -Required properties:
>> -- compatible : Should be "ti,davinci-wdt", "ti,keystone-wdt"
>> -- reg : Should contain WDT registers location and length
>> -
>> -Optional properties:
>> -- timeout-sec : Contains the watchdog timeout in seconds
>> -- clocks : the clock feeding the watchdog timer.
>> -        Needed if platform uses clocks.
>> -        See clock-bindings.txt
>> -
>> -Documentation:
>> -Davinci DM646x - https://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
>> -Keystone - https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
>> -
>> -Examples:
>> -
>> -wdt: wdt@2320000 {
>> -     compatible = "ti,davinci-wdt";
>> -     reg = <0x02320000 0x80>;
>> -     timeout-sec = <30>;
>> -     clocks = <&clkwdtimer0>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
>> new file mode 100644
>> index 000000000000..17c824f2fc7d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/watchdog/ti,davinci-wdt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
>> +
>> +description: |
>> +  Documentation:
>> +  Davinci DM646x - https://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
>> +  Keystone - https://www.ti.com/lit/ug/sprugv5a/sprugv5a
>> +
>> +maintainers:
>> +  - Andrew Davis <afd@ti.com>
>> +
>> +allOf:
>> +  - $ref: watchdog.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,davinci-wdt
>> +      - ti,keystone-wdt
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    description:
>> +      A phandle and PM domain specifier as defined by bindings of
>> +      the power controller specified by phandle.
>> +      See Documentation/devicetree/bindings/power/power-domain.yaml for details.
>
>I think you missed Rob's comment in reply to Andrew, about constraining
>and ordering the power-domains:
>https://lore.kernel.org/all/20231026203037.GA327324-robh@kernel.org/
>
>Cheers,
>Conor.

I didn't get what should be done with respect to the comment above:
Should we wait for the response from Andrew, 
or should we skip and remove the the power-domains definition for this binding, 
or add "maxItems: 1" to power-domains definition?

Thanks, Nik. 

>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    watchdog@2320000 {
>> +        compatible = "ti,davinci-wdt";
>> +        reg = <0x02320000 0x80>;
>> +        timeout-sec = <30>;
>> +        clocks = <&clkwdtimer0>;
>> +    };
>> --
>> 2.34.1
>>
