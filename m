Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656A57715F5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHFPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHFPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 11:43:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE3171B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 08:43:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso6131203e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691336621; x=1691941421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oWs4U2ro/t4/q4Z3II5xjIwWsnCpXNAMYIlFzVA7to=;
        b=d/KHmHcFTscfybAgeJW/vORuTjCnWcizHj3JJbdw2Uzg+gGgoRalYZsn8Hfn4GNyWL
         JFgwztEuuItCn9ikVJ2l1amtITa1Sy1ZcwhLeEcBXdIIZPiJFTpcNq+osxAiSxB6DqQ+
         uYoxDSfhQKF8e2iOEyJSh2eBoiazcHCSO+pwqdit6GG2RWBJ8Vae7zBeo3OTr6k9j3eP
         Kn9hE7BkdJyT3t8Z5x6dKmvRTbWADKq7XYMTlP0uAj+xOWp+PbqLH0B+//p0y/amSrjS
         GtIsZsB8dDb4vxMctISFAf9t5yzODAHBRlU3EiXNy8UXrzxkxJunEdvymlp7Pz2wozHw
         XLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691336621; x=1691941421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oWs4U2ro/t4/q4Z3II5xjIwWsnCpXNAMYIlFzVA7to=;
        b=ZJCk7bczzLTLj3O7oOeDMuuTYpXtzs18mGRli1bcBvN9IufUZpr4+YtRJRWmdQr7if
         ma1SlnY5V6JMhUW478pOEZyd6x6JEWZ3XcBbx+mFGPMzQ81dsgz6/7QbYxuHoS8YYLBt
         qCMZ6hOT5z26WrGWeMpc3jJDfbFxs0RnMB6/TD1l63ZeWwXfGF+cw5tvwFCmqo+b5Xth
         20IOD6mG5RCdRut/lw90HX0t8x2k3Rs+DjsK56lTbR2w28QuaKGGvAJv2WTsUTBhrhJR
         VEOk6hbt2lA9PaDgkFx9zE01HRw6yr3h2QW0bfnAgOq4fBva/2NmZBmsMftfP9nL8xyR
         3qkQ==
X-Gm-Message-State: AOJu0YwIXmSJc89qXz7Wmp0Kmak1ySxHwNC8gmkPsh7xvPty5CNiPtvp
        g3FVps9+qAnxBRxUFvS0jBxCFQ==
X-Google-Smtp-Source: AGHT+IEWCJTsvsSIf8enwv7oo2giSQDBES8kdxqCPcfEumlUYVlBTwRhmSAmKQTz+OOWgMXQu4p+3Q==
X-Received: by 2002:ac2:55af:0:b0:4fe:589a:857d with SMTP id y15-20020ac255af000000b004fe589a857dmr4116275lfg.34.1691336621334;
        Sun, 06 Aug 2023 08:43:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id d14-20020aa7d5ce000000b00522b7c5d53esm4020402eds.54.2023.08.06.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 08:43:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: exynos5433-tm2: drop redundant status=okay
Date:   Sun,  6 Aug 2023 17:43:37 +0200
Message-Id: <169133661267.27382.4777449887249443533.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731090821.104733-1-krzysztof.kozlowski@linaro.org>
References: <20230731090821.104733-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 11:08:21 +0200, Krzysztof Kozlowski wrote:
> status=okay is by default.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: exynos5433-tm2: drop redundant status=okay
      https://git.kernel.org/krzk/linux/c/d157d43754582f3981b7eefc691abc4d865430e1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
