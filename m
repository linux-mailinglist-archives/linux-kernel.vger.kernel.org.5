Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85807630A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjGZI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjGZI7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:59:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406B10DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:53:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso1089578866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690361586; x=1690966386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePMoozvjCcycaiqcHeImLG9eyPBpOYe7wziGRg59LE0=;
        b=lgoMvXdgAFgWxKocPub4MrcqStSktw3AUhlwgGGUkA0hfmP3Q/iF5l4I+cYd9PuvRy
         PeXQpNrGSSfTR5tUks68UBztiBk229DnwQInlapWuRDYhapSz5kv1DlsHQ/HhToPMQ4d
         jl8G66P5pH8746e+pTWTGm7M7EnQfuc7+/V9Fucx3WFAAkAJ2KbPzmjppIiGOTMAdVXO
         aTNpYjnV6MRbY9hGMQAwX5WfQ2XgPxADwt4+2mkmmPFZEOBMNH0YWm340gYzUPvJBw4q
         b+gTl1WInwhG37dvaWfHSwom7BfpjdXtFqPvBesR8oLzSMAn2VEdvDVjGT7yOZqOIwdV
         9RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690361586; x=1690966386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePMoozvjCcycaiqcHeImLG9eyPBpOYe7wziGRg59LE0=;
        b=Cz53mkrF+skEqk2Ucj9LhfNoI3k8Q56Ok+d52ID7ojYMktRkDHlDlqEGXYCZNpmeRB
         bAF9UnMcpAxXIporspJ+AvcdVmb9GofzcJBmHObDRYpMdrqp6dZRhFxtXNCC67DN5cGv
         ld/Mqp0YwBSiTlyzUW6LMxPvD6v4R2fU3RvGMd/JLc8T+yi664hjRSPKxbqB7NwuQOGf
         90aqvD8vgFzytQkTy1gpzRuGt2+yH/hePliTSUsaOAdau14aENjv6/Fsa3E4OJfxjQ1A
         jsnB8u0B29vRdgQDQMbhzQK4c5va7j/FU6ydMOyQFSbJNwICNrfumpmIzEBKS0W4HiNZ
         f+nQ==
X-Gm-Message-State: ABy/qLZvia3Ym2TEYlfXLwGa9FZbdzRwY86rFblg1phCAt0VBPMPX6f1
        EzzuXKXXvmQL8Mhzu6QQH8Co9w==
X-Google-Smtp-Source: APBJJlGpls+c1lUCS+2vNzlVTg/p2kuFxf1wQZUfBrKhCjMicsXoy+rDSBMXj+s2s8itF2waA2rxCQ==
X-Received: by 2002:a17:907:1dd6:b0:992:48b7:99e3 with SMTP id og22-20020a1709071dd600b0099248b799e3mr1086042ejc.63.1690361585305;
        Wed, 26 Jul 2023 01:53:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id rv14-20020a17090710ce00b0099b921de301sm4606340ejb.159.2023.07.26.01.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 01:53:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ARM: dts: samsung: exynos5250-snow: use 'gpios' suffix for i2c-arb
Date:   Wed, 26 Jul 2023 10:53:01 +0200
Message-Id: <169036157563.124820.14961945548354190838.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721133246.15752-1-krzysztof.kozlowski@linaro.org>
References: <20230721133246.15752-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 21 Jul 2023 15:32:45 +0200, Krzysztof Kozlowski wrote:
> Linux drivers support both variants - gpios and gpio - but first is
> preferred.
> 
> 

Applied, thanks!

[1/2] ARM: dts: samsung: exynos5250-snow: use 'gpios' suffix for i2c-arb
      https://git.kernel.org/krzk/linux/c/4f861a9b8167ab2b4d96ed13544aa6133ae7bf55
[2/2] ARM: dts: samsung: exynos5250-snow: switch i2c-arb to new child variant
      https://git.kernel.org/krzk/linux/c/7562d91450b58d2cbb5387cc4b381088f338e635

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
