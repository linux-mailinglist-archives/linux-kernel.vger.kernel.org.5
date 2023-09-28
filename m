Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1E7B123E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjI1FzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1FzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:55:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2FBF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:55:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b29186e20aso896260466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695880500; x=1696485300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54qiU08t2GpO/MWMIDTzBVyjApX/CcNuywPfrqlHKm4=;
        b=dJJZ4Guq+CFyIZwye+WyoJz8yQA22E8NlyN7hLBGCCtKxxhthNm843CeRamKazmdlb
         pKlwy6K6kRaw4TkqO3W66slIQgoVI8khOQGNLxCgnC7K17JVgy9rbJCNJhzUfmOJGVVa
         koPzX/scSfQf0RNyrkG87kL8/TTI5Hf9fm4/nJb89c080ZfZB3eSfFoUNDCRSq+oMytH
         KqQteGlx70HTxuQFtF7kecnrRcHCbk+RLxQsYHvkSuvaMdtsGsNx8ZnqQj8QWz+TF74/
         e7DbmPr0vY2UGPmkhz+RAcrSdBEyO7TI3m9vTHQ3cKiVhqMhcK/m1Zu3FSm+HCCGBS7C
         LiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695880500; x=1696485300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54qiU08t2GpO/MWMIDTzBVyjApX/CcNuywPfrqlHKm4=;
        b=wbY8Vh4MDAoTO91N22Sr5R8+MxZh5uygYYgZHkVjGOt0a+WR8Ta0naM/vgkMczkZvp
         2wkcxDMIe24KzzlcNsdmbP+rMnXbVQhcg5T1xVpSZrq3qKgKOGlSzUpS7+V3ZpEzL67B
         v5uWbquqk3iEUqiHV/Ip23nthVhgbVkDUD+aNEaKoFuTvvdvjfEtnKnKsG4YaXxYagzc
         5TcyDu4O28b/ZuNkoy/cKD1k0pDGqbYosv5ndh4vNIS1GzVZiFPGtulkjXLfU7nW4FwA
         L1d89EwPSDs4/vojk+UEa/Vu6VYEGst06wevwbbRtntBb2dwsKBJDM2JcsgaH/9kryP6
         90+g==
X-Gm-Message-State: AOJu0YwVgoeZf5NgjvBIvOr9DKGjosWYb7YW1m8KEs+jMzp7SQAOfOae
        0r1Eb6MhlbO9YQalf6V6KRD0sQ==
X-Google-Smtp-Source: AGHT+IEzM4GVvXhhGjAdh17D1G62ZiQP9XY8Q28w1XdHkASHmuCPrX5v/hiOPIopi46147BEe3T8Hg==
X-Received: by 2002:a17:906:769a:b0:9b2:982e:339a with SMTP id o26-20020a170906769a00b009b2982e339amr259099ejm.22.1695880499957;
        Wed, 27 Sep 2023 22:54:59 -0700 (PDT)
Received: from krzk-bin.homenet.telecomitalia.it (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906681100b00992b50fbbe9sm10355749ejr.90.2023.09.27.22.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 22:54:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controllers: Make "additionalProperties: true" explicit
Date:   Thu, 28 Sep 2023 07:54:53 +0200
Message-Id: <169588049053.10364.12898939958860054639.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925212626.1974676-1-robh@kernel.org>
References: <20230925212626.1974676-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 16:26:21 -0500, Rob Herring wrote:
> Make it explicit that child nodes have additional properties and the
> child node schema is not complete. The complete schemas are applied
> separately based the compatible strings.
> 
> 

Applied, thanks!

[1/1] dt-bindings: memory-controllers: Make "additionalProperties: true" explicit
      https://git.kernel.org/krzk/linux-mem-ctrl/c/387bb6fdd0af1f853deeb1cdd8331c07b6a66b32

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
