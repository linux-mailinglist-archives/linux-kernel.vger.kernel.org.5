Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277CF7ACB88
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjIXTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjIXTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:02:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2919F1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405524e6769so15854925e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695582134; x=1696186934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADa9CTc7Mm0plkUbp7+s7MaEsuDZ1Hcc8R6xm7NWcuc=;
        b=lrGuLcau78dp5RrGwYfY6MvRX3YaXO9MZZ/Dzs29m60UKHG1o91FDIJIza3krYpGmm
         zbPrgzCka4+NbePGr/B0vMY6jdF7YHZy7/xKO22zNqSxCiOGYc/+YXf62hCRY4mnJKOs
         c1qXjnDRuKZSP/pwkQzoSPZDsGc1Zll+ZNcrWxJdza+NQLgACRbnntLXHTVNwyqBLdUg
         xEWfHFBpLlDHuDe/B00Yb6s7Y0z1YY7hBW5bbnD7dZzWT+13K5PVxN684e7lPezzjcFJ
         GqhpjEEUAXtpMT6K9fxDHFI8kfnLotGbwjEnFYmYwaRYYqy4wPUS+YwyUCz6lUnchxc3
         eAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695582134; x=1696186934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADa9CTc7Mm0plkUbp7+s7MaEsuDZ1Hcc8R6xm7NWcuc=;
        b=XrjESxKy2shlp8czCfqJmvxeoJPj2TRLS5UEoS+qn5WZzBqv804bg8S7T5Xs6miGr4
         0VWxzzKFPXmAsJ9se/8vZdPN/FQWG6Cy31CD4spsuvdUi4MqAdvq0/Sz4ZUfEmAP0Jkp
         PBeRUdyKuDYSWqHkqVmik0eRKzERXF+6v3QQF5TjUZ3MBuoxbEl+GLyShVNA88/lDjEG
         aC4VUru4OzqAhyBYuMbs2jhtaqM8RD9tFF9HnzDk0xlncGQc1ies4Qbyvex0VcIxLpN3
         LxMaHUO11qXZjMEvwKuMMNx/1TG13vZj5kkeplIxVPEVb2uUL1EWIym2JRDQ3NRvl8x2
         g3uA==
X-Gm-Message-State: AOJu0YyXAPIb3sno7HJXx3H1FtmuEIyef7DJ6z+g9PhMB0QV6IT91If3
        OqYN6LzIrUv0sm9KjGmaAwYz1w==
X-Google-Smtp-Source: AGHT+IHnH8FwuVSfP4cEIj4663STrnMRTMgkALP6Q2CmPnysXrCog9SKo46U9k2ZhHyKdGLPvbOn0g==
X-Received: by 2002:a05:600c:22c9:b0:3fe:da37:d59 with SMTP id 9-20020a05600c22c900b003feda370d59mr3543430wmg.4.1695582134179;
        Sun, 24 Sep 2023 12:02:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm12980507wmh.35.2023.09.24.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:02:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ARM: dts: mediatek: add missing space before {
Date:   Sun, 24 Sep 2023 21:02:01 +0200
Message-Id: <169558197844.54884.9059102157573367426.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705150006.293690-1-krzysztof.kozlowski@linaro.org>
References: <20230705150006.293690-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 05 Jul 2023 17:00:05 +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> 

Patches were waiting long enough on the lists. I assume there are no objections,
at least none were shared, and this just slipped through the cracks. I applied
to my tree for further soc pull request, but if anyone wants to take it
instead, let me know.

Applied, thanks!

[1/2] ARM: dts: mediatek: add missing space before {
      https://git.kernel.org/krzk/linux-dt/c/f673ab0ceb8dc8ccd291db9bbc200dbd8cd399f4
[2/2] arm64: dts: mediatek: add missing space before {
      https://git.kernel.org/krzk/linux-dt/c/a9c740c57f977deb41bc53c02d0dae3d0e2f191a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
