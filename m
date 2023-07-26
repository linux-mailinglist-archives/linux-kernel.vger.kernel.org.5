Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41BC763186
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjGZJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjGZJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:17:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1495B9F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so1020718066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690362862; x=1690967662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eC2GKyNUZnpK7uqK0Zx9R+rGuHIRhcmkTXSZzbc8OM=;
        b=nbqj8NCyiC02131JIo6Gjk9E4rvMKdOD7vJ+E1Mql7705JaMdrD2TqvoLCTRFI+s2N
         jyx+7PZxnRr8L+pmSSE2YtyLuT44S8/OfBxzjiwzZ70rPHhcS4812OYNO4Vntlh3TvWc
         I1xCfg7Wg1n+rTmVhhUsKXemH22DY+hxhLduyxbeinEaqCJEA4l7+fX/hwHTYgI6R1Lq
         opX0xEgM270pXqRWzSRwzk9UuS68GhiJ/5pUJl1CpsJmSCqfMh3N9/pOE4lo+5khKWH0
         3tKm8a96jlgP84zzFsrMG0GiasJvXndMedZPkmV0k9veUwj0gP6tM3YTi/D+VDc5DmjM
         Tuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690362862; x=1690967662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eC2GKyNUZnpK7uqK0Zx9R+rGuHIRhcmkTXSZzbc8OM=;
        b=dX41GIzKjTAoS5rjtLvVmFaRpEAVjkL7z5bakhfyLarDkUDHN1VoSeow3ZsfWyuZ9m
         PK4ocXFZBjcNzKQGOQijExQIvaCR5YhzsUBzISTEoKGuia+lTzqxkje209RUKFxlERuU
         N7bPaXGcwzy4PyUWPRLtgQ0KIq8xJiKBELxOAmoBvjtVuW3WWQx5CMCFo+S7qDO96Kfe
         8Je8qg7R1tV2px1nF3k+N3nsd/5IAqRDCND/5IVHH0wP40ZxCZ1+/7sadeuvR7k2Coeb
         JZlJ2hORcMkSLFVhfLBVRuKDs1xSxL+dTCqDHfTJG1zxod/QwfVc5vKMlrrkZ51OYsUF
         jx/g==
X-Gm-Message-State: ABy/qLa51UNqO7HJ2+6z8AxICg3nczgicJeqmsAjr7tGchGCx0t6jhO8
        E0Yd3Pbs9imNMXAfGEIrZ4XgAw==
X-Google-Smtp-Source: APBJJlHUcLdk6RXJJHLcul52xrPBIhyw79JkWaRCNWG45lma/cv4Hw8LNQu8Zyi/AJzK6UKVJbWAyg==
X-Received: by 2002:a17:906:8a4d:b0:99b:ce9c:a923 with SMTP id gx13-20020a1709068a4d00b0099bce9ca923mr58274ejc.39.1690362862545;
        Wed, 26 Jul 2023 02:14:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906130800b00992b510089asm9384492ejb.84.2023.07.26.02.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 02:14:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add SM6115 LPASS TLMM
Date:   Wed, 26 Jul 2023 11:14:14 +0200
Message-Id: <169036285578.127914.8520775500481770991.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722-topic-6115_lpasstlmm-v2-1-d4883831a858@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org> <20230722-topic-6115_lpasstlmm-v2-1-d4883831a858@linaro.org>
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


On Mon, 24 Jul 2023 13:39:56 +0200, Konrad Dybcio wrote:
> Add bindings for pin controller in SM6115 Low Power Audio SubSystem
> LPASS).
> 
> 

Applied, thanks!

[1/3] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add SM6115 LPASS TLMM
      https://git.kernel.org/krzk/linux-dt/c/ba93d88721cced8ef8aade684fb43ee30bef2bd5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
