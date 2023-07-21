Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91475CBD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjGUPeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGUPeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:34:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64B30DD;
        Fri, 21 Jul 2023 08:34:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-521dc8ae899so2406454a12.3;
        Fri, 21 Jul 2023 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689953641; x=1690558441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+J3maWKZDLZOHu0KMClUTkcLoWuu+H0TcJ6B1ppGIM=;
        b=fmDH21f77I25libj1wRrEk4TILKZ1kLWnMOmbSvfilgvRDaX/q9nI0LnO6BRwwLGyw
         g4JnW+IFQt+HznIwYpdXczSCO43cnfYgNAcCU5ljr0kBxTgU46cr6ev4SqEIZ2yHYbZl
         /+31gkI32NDaV/JIDkwmoD/mS26kbmdXRdCJFwQ7l5ihDpRHzBRd42vr6SM2dQ+gRKoa
         RCj0DGnoWV384OkZm/EzMt3wXooPGX9thKsillns/ckLFVKOCyzMFv5ezIDO3PxdEIpj
         XfuuKMAWBPKVZiOXw7/6NTCYGPvW3oaqbjYUfWeoQlvX098jxbIdIyLkRjlYP7SKMuHc
         5JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953641; x=1690558441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+J3maWKZDLZOHu0KMClUTkcLoWuu+H0TcJ6B1ppGIM=;
        b=Ro3MFcytaO7kVIbqUU6RsW8knv9lGbWJ1shRgz5JrKzzehiJKIsGEaKx9N8QMPnLMd
         Lq+41KIhGvAo9uOS6XyqMwJYvptga3+1zPpyzHFmg6UJy7YI9QiZjECftthexPbTWpot
         C3zNisD0FiAZ7uhSkb366jBYQw7CHsyz7THPpSE54QCDOAI2dLx0g0jzzHUKpKO5YzMk
         VfK9ZyypmpBZ5uhp77Ch1SiweyuTT+jsAXmISHdY91s2cI4tEZfoZ5c3XUIky4/Gq8UL
         +nrzxKHBrlxMtcNw/kQM5ouFgKEJe5WcshdlNdGfBGsJltUNp3mWzob7yhX9IhLB7Mk8
         lieA==
X-Gm-Message-State: ABy/qLYKIqY3ohvdALQzwc9A4RQg9XOeOymcbssnROf9TUnIRCekP5/5
        tLqDMXfoGImci4+iwh8LAiQ=
X-Google-Smtp-Source: APBJJlHxHpHitpRJOlz0XvfBo0jSQ+i1+osJAXEtnMET5LtbtSRMYQN2nySPQ57QEZdfL8+yUCjgKQ==
X-Received: by 2002:aa7:c982:0:b0:51e:404:1e6d with SMTP id c2-20020aa7c982000000b0051e04041e6dmr1981954edt.38.1689953641105;
        Fri, 21 Jul 2023 08:34:01 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402064b00b0051dfa2e30b2sm2244385edx.9.2023.07.21.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:34:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Artur Weber <aweber.kernel@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v2 0/4] video: backlight: lp855x: modernize bindings
Date:   Fri, 21 Jul 2023 17:33:58 +0200
Message-ID: <168995363315.3656835.14137740606773160898.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230519180728.2281-1-aweber.kernel@gmail.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Fri, 19 May 2023 20:07:24 +0200, Artur Weber wrote:
> Convert TI LP855X backlight controller bindings from TXT to YAML and,
> while we're at it, rework some of the code related to PWM handling.
> Also correct existing DTS files to avoid introducing new dtb_check
> errors.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: adapt to LP855X bindings changes
      commit: faae0778fa10fa4e8909fe9164f06acab170f1e9

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
