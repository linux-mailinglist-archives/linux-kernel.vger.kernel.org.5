Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6074E770E42
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHEHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHEHGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:06:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A603C2D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:06:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso384532666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 00:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691219192; x=1691823992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLy2zpn9Lnu2H/nmLFIrpp790ZjeUXR+eIzMBYXrhEc=;
        b=Zumk6uZ/c0ICEU18QG2RWH7Z4r4cG9NhzfQiBEXUbIuUi/d5omHYwKyHFOqqhMV1k8
         wuTfWDdCdL74f3MlFQxROSz9oxjCPdjeuy3QL/fJVodwer2yWLAVIaxHpOKDSxlERChO
         pVhMctX68qGoW7X09KLTeIv/0htyPXZdPSYXS60WyOp58j/5Br2q3VzA4+8mXJmQrTKe
         5zuT1OqYVV7VJWTrGgO9NVUduoCvQ4dUqp0jM/rqx1I0WL8L9Tn3a3kn/+IOCkqNuA5G
         ZdUFIYZ6GU0O+UB0be+7sF3Z30akapfHB2nv/7turV8GN2Fo+Yx+5vduUmim8FacTXpL
         9Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691219192; x=1691823992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLy2zpn9Lnu2H/nmLFIrpp790ZjeUXR+eIzMBYXrhEc=;
        b=YlA4sZOISpgB4PWA3yE0A/VuxwXSPbVYogpqjgm/LO3cgm6CaE6zHJB4CIZJO5pG7D
         A4cPOw0tXDPfwW3CFblh4MAOiTLdSW0WfMro90oHO7eJoPYFC2/ist/QfFiOHLR37KW1
         1Ul0r84XbaH+8u4fVsQenpG1Q+6mm1pMEBoYp1jfm1Q5bTE3AfD3GxKVZ/yGm5FwyftS
         ooOGXJew2g7DucinxxswmHmRGKtk3yLdZtB9ei1ec0lCU1imVXDM0A07xNXOu5GGrlMQ
         TiigNh6nCbTGmoqldvcLBuR1TkTXdbcXnblmGw0dx5uACQjb+zvZH0uZn7qL+JjnuzYM
         aRAQ==
X-Gm-Message-State: AOJu0YwqXz/APdQqgqsUjhB47sq0rEvKe3Q+9FkcR4mqRO3Ojv10mwt2
        mkQSmKOxg7fPjig6dvyD28CYFA==
X-Google-Smtp-Source: AGHT+IG7ldLoJ6w4ELBD2Ar8XZBFz5HltlSWWfAFC1DfeyMLSVRcEBCcrggMuVCGwQxpFlzzekcAeQ==
X-Received: by 2002:a17:907:781a:b0:99b:d693:cb8e with SMTP id la26-20020a170907781a00b0099bd693cb8emr3307118ejc.71.1691219191662;
        Sat, 05 Aug 2023 00:06:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906780400b00992d0de8762sm2291980ejm.216.2023.08.05.00.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 00:06:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     krzysztof.kozlowski+dt@linaro.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Gupta <sumitg@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bbasu@nvidia.com
Subject: Re: [Patch] memory: tegra: add MC client for Tegra234 GPU
Date:   Sat,  5 Aug 2023 09:06:28 +0200
Message-Id: <169121918559.5180.1296669409655941937.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801121023.27841-1-sumitg@nvidia.com>
References: <20230801121023.27841-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Aug 2023 17:40:23 +0530, Sumit Gupta wrote:
> Add the Non-ISO MC client for the Tegra234 GPU to the
> tegra234_mc_clients table.
> 
> 

Applied, thanks!

[1/1] memory: tegra: add MC client for Tegra234 GPU
      https://git.kernel.org/krzk/linux-mem-ctrl/c/35bd78cf252245f11dd1c9d5f1b414c25e727b5a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
