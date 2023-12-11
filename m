Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B080C23A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjLKHmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjLKHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:42:11 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6961DF4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:42:16 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so50889651fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280534; x=1702885334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUHFpmWZqhcKOg/uv3kTOlXRnNTjkbhRIshNDjAuCao=;
        b=P7hsf3ANiat7QC1Yn+CnDjPKpqBBS16NhRNyMgxxZo4KQk+rgb1E3ujgfn2vtkBIpR
         oSqLcBqcNSfYRiTSOinqy6d6Eaaytwoq/lm7Pwae1nb8/GHCyhshI+eseUFxVVUhfk53
         XA4QvSZNEGlO+ctNm/hBS0CXyRhdsW3F/770qegKX+4PYcDY+m0+qEpXY7ej1qTiNzcM
         xdtvYEKz0tivK6tgHRXtK1/gDwQXJuDrcGXKBAM+L8rKfS+gLxhgiaJIZR7x7VQYNVFn
         yZLjjHNwxzo7HFfmM8GotkG5k8YjHl4hATBAQd7QiMkcgf7ckbiPqRvZJXsRnj1Vfb9/
         N/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280534; x=1702885334;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUHFpmWZqhcKOg/uv3kTOlXRnNTjkbhRIshNDjAuCao=;
        b=qiFUKIea8g8xTNpSxGmbIOpwNF8RVF++iETJx3IsZVri6MuCVuzmeeT44FLa3GTVY9
         A44JErkqjV+OkeKWZIXrHk5IE8m7gc4Fj+FTs6RVBWbvHsrYEL/RZfFxsaWodQDrC9Y6
         Nv5IdJ6IW0133tJP6qbOU9CMgs8M8D5Ze/if2ScPTZPrQhoDnDAU07YcAgau64RjVL/7
         K8QhlotVDqCpWQaqNeCjSydonq1p914e5ukSW+Lpr5K6A6fj0OS42YSMAX4RzeXDE4UK
         eZE9rzNiGfCAzCaELE44Ug+TsXV7k4ehAgSsx2VjqLaFguGVpcPzBoElYYQXrPiuZLW8
         mYoQ==
X-Gm-Message-State: AOJu0YxyQzz8MXg5n3hL4wDmDvhUWRw7FM6nRTu/DIc36THqYaX6OrAj
        ZAPdHpLSxTNHwFIqwKY3BBmvAQ==
X-Google-Smtp-Source: AGHT+IHjjiReYc+IayZnj+luHk8nr7NUsr8MtWRWMkSPYPwtcWJqulRHvFUHM9iJy33hIzVfFlgBgA==
X-Received: by 2002:a05:651c:2112:b0:2cb:2c27:57d9 with SMTP id a18-20020a05651c211200b002cb2c2757d9mr1349578ljq.16.1702280534712;
        Sun, 10 Dec 2023 23:42:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b002ca0217f327sm1116269ljo.65.2023.12.10.23.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:42:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231210134834.43943-1-krzysztof.kozlowski@linaro.org>
References: <20231210134834.43943-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: samsung: exynos-sysreg: combine
 exynosautov920 with other enum
Message-Id: <170228053300.12030.5356013143015298752.b4-ty@linaro.org>
Date:   Mon, 11 Dec 2023 08:42:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2023 14:48:34 +0100, Krzysztof Kozlowski wrote:
> No need to create a new enum every time we bring-up new SoC.
> 
> 

Applied, thanks!

[1/1] dt-bindings: samsung: exynos-sysreg: combine exynosautov920 with other enum
      https://git.kernel.org/krzk/linux/c/e4f027756dff6a4e2abc640f276f91219559a3c9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

