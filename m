Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D88E7F72DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjKXLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344684AbjKXLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:37:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F010D7;
        Fri, 24 Nov 2023 03:37:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507b9408c61so2507466e87.0;
        Fri, 24 Nov 2023 03:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700825847; x=1701430647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kv/qXR6TzzcEWtIi+A5KCJiV+bM8ZlUGTUU+Iv9EyTo=;
        b=fc5CkFx9UQ3cf4ZHffc9bUMYhpyJVM1xuH4y7qDpkTPW+br0vu+RZb8P+eqVL5yxK/
         Nvbj+mbw5PsknZJAejaR7iTSRgQaA+JcEoeYOaDSWYAT1TGtQn18+4UtkD3VHdNkda3R
         H1EkwePcmMuv9KKiF8BPWcw+udNPR62viMIFJ3IuHy6yNw++cZH2ylnxZfeJtCmmvJ2m
         qZS88kVer7N9OZtCY/sd2biVdNaw6nZ2C6kRBGQc1idtNnNAEeClmhwSdazFRQCLJeku
         1M0SOyNMISdlvbVZtMa4VLKhr4eQ3Co5oHZo7mDhXbmy7gS3nbnMO9KPFJmtrYl0QPtG
         W2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825847; x=1701430647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv/qXR6TzzcEWtIi+A5KCJiV+bM8ZlUGTUU+Iv9EyTo=;
        b=SYigrvjjnh3dJ22vI94KrhP9TI1rK8/ufIv9oK+NHhC3dRN5UN5nljQgQcudRcs0Pu
         m6N0Bxaj5+qVmLBqTivj0iaHylX8PyvKChORvqj5PxsxNvNvAiTSfGgoOSFAF69mAeaY
         IeUwJEJXHEjCI05nrw3mw6zr08lTENPMQi6nug96qB2s0WTAf/91CMt4CV0w4hSt0Jb8
         iZMe22/UN5QzxuqA7dhe02uZs2VXPUDD5VhhU+suGrI1EOS4modrINUXfjCCzXvzzGFJ
         QfPIXcethy460evZGIWIo53Ni43+skaBdI01Gm2h2QL8YYOBYUrVNO9fHVQNQwgoq5ZF
         5Ugw==
X-Gm-Message-State: AOJu0YzUmtDvUrGl6h6OwUigFVyRizOgfV+dkowRatDOK8QuqWN6LW15
        AQIsPqMAoIz/QoqAvNtLEXI=
X-Google-Smtp-Source: AGHT+IEzCZWJ3hXJoDSdyRqwBjzazZDlJEfxOI7PQcJ8htEj/5PKeCWhdKuf36Vqxu84m72Y3Ksg9A==
X-Received: by 2002:ac2:4904:0:b0:50b:a33f:548d with SMTP id n4-20020ac24904000000b0050ba33f548dmr1711746lfi.22.1700825846888;
        Fri, 24 Nov 2023 03:37:26 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h14-20020ac24dae000000b0050aa76b984esm478169lfe.264.2023.11.24.03.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:37:26 -0800 (PST)
Date:   Fri, 24 Nov 2023 14:37:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/21] dt-bindings: mips: cpu: Add I-Class I6500
 Multiprocessor Core
Message-ID: <e6fjuaya7ghhapefthc5aj47qyarw7ankb7jexvhem3m37llfn@up55fhhqo2bm>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
 <20231123152639.561231-16-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123152639.561231-16-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 04:26:32PM +0100, Gregory CLEMENT wrote:
> The MIPS Warrior I-class I6500 was announced by Imagination
> Technologies in 2016 and is used in the Mobileye SoC EyeQ5.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

One more time:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
> index cf382dea3922c..b5165cf103e94 100644
> --- a/Documentation/devicetree/bindings/mips/cpus.yaml
> +++ b/Documentation/devicetree/bindings/mips/cpus.yaml
> @@ -39,6 +39,7 @@ properties:
>        - mti,mips24KEc
>        - mti,mips14KEc
>        - mti,mips14Kc
> +      - img,i6500
>  
>    reg:
>      maxItems: 1
> -- 
> 2.42.0
> 
> 
