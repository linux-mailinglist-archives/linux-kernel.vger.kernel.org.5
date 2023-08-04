Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80976FFD2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHDL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjHDL6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:58:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04013E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:58:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317744867a6so1686672f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 04:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691150310; x=1691755110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roPCqYVq5FoKhSTLB3DxuQDru8Tg95QBFx3xWNHBOBc=;
        b=vdFbzy+iPivOypCOS2MY/xP86T/mvKswug/NCUWqWWrxiMgBRbE7h3uPn5iTHbYAFK
         ciaS8/uhuK/UUCFMvQblvz2c6hwFA0GJSYLeQjmJK0kDMcADFsLArjJeLaiUH+H4jlHY
         DIrtpf1+USs77uLSO9QpWe6psg/bWLa1RMOlI7MRbPyQqKej/FxV7Ctnv4EmQlWFPwBA
         1zwiHA+GzVG+OKOxseTLKQPkYuUpJr//SDAdN7g3hb4uF0CNFZUhQr3L9YpFErWmUqkD
         oj35587kSsXhXKSkBuW5kfuECxr/zZvjlKW0N28ETKGB8cUc7mHt2iNQ6Lg1gdZ7byRt
         JKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691150310; x=1691755110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roPCqYVq5FoKhSTLB3DxuQDru8Tg95QBFx3xWNHBOBc=;
        b=gaV5iggrJxjMFyGqH/gDBMfH9QbybLJu5DbqCgW7LHsgvZqH6/5NITJApECi+FehXG
         k1pvZXwkNNK2XYOFn8QzbMVgk3WrzbxEf6jDPC3ioCj31Dq04IeOPUGz61r2R4jwvnOP
         9/OZIzkaiEmJltmi9RZfg3nrp0cVueXMHawp76Uy/LRXBKrLzWeMrzZ+fWtwrhZB7ipQ
         jLz3XrcDwd0xeExYHI42/qXIk7aZaBr0TqpUzlG07bJCtsxaiSiyp9sa+EApwbIetYvV
         j5HGUDBT/g2a/15egskBJVFw8uJf+x+8PpRZSFygjT5SdRHQWH5UVXo5An1J4YRxwYxJ
         n3jg==
X-Gm-Message-State: AOJu0Yxxee6lCNMtUFonxDIe/6jILPIR1DNxsQAnzz11uecpP59OfjIO
        L5b9K0O4oPUXGQclhNsmXq6C0g==
X-Google-Smtp-Source: AGHT+IHdmAs57eM0Rz7KVhiySNQUuzLMCFVU6AXXyP/fH2yGgk5lSYGIfz3aoQtQCBNs8nXrYFi6OQ==
X-Received: by 2002:adf:f8cb:0:b0:30e:5bd0:21a2 with SMTP id f11-20020adff8cb000000b0030e5bd021a2mr1278153wrq.52.1691150310046;
        Fri, 04 Aug 2023 04:58:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b0031134bcdacdsm2358350wrw.42.2023.08.04.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:58:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20230718-feature-st7789v-v3-0-157d68fb63e2@wolfvision.net>
References: <20230718-feature-st7789v-v3-0-157d68fb63e2@wolfvision.net>
Subject: Re: [PATCH v3 0/3] drm/panel: sitronix-st7789v: add panel
 orientation support
Message-Id: <169115030877.3531293.12258712491460228869.b4-ty@linaro.org>
Date:   Fri, 04 Aug 2023 13:58:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 04 Aug 2023 13:23:07 +0200, Michael Riesch wrote:
> This series adds support for orientation specification in the device
> tree to the Sitronix ST7789V panel driver.
> 
> This is can be seen as reduced version of [0] (some things of [0] have
> been implemented in more general fashion in the scope of [1], other
> things have been rejected).
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/3] drm/panel: sitronix-st7789v: fix indentation in drm_panel_funcs
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a238b5ee39e3d3581ec826cdb7b604adca37b5ea
[2/3] drm/panel: sitronix-st7789v: add panel orientation support
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b27c0f6d208d6ba269f184ed6f92c6a9908866e6
[3/3] dt-bindings: display: add rotation property to sitronix,st7789v
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e83172ec548d420f2e0b01e80a9a8cbae39bbe29

-- 
Neil

