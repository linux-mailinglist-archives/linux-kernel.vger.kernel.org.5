Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE123770181
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHDN25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjHDN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:28:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C97B1FED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:28:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbea147034so20075025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691155712; x=1691760512;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy6cMwpEJf7gKHi9mBSsBAFtdHdF/m1nv2+iWOl0BKM=;
        b=lA8UbGBHWa9eh4cUqR1ElqbUm+5BTmxCI23/n5AdIB+uLHe4iuzV8z6xg6mmqBhskL
         gVTimKIipucuk/GkaM+MUTVBYXOz1jEX2aUIcb0fW8+buxoUpaB3nxsTn2OgFs5FxEbn
         yEEoWCudu3LQl08cbBZNo8RuiQNq5bPoRQFJR6SahaWnbyEISHN8oIHd89+Q/xtlnySz
         vh2xW9leRHnBKK5jAZfZJNLuK97wjNM4mQl5/9UUR6dLVifaDeguit8Qx9ANG4Jjukyr
         EZ4zP2qy/zU/VjeGm+gqW1yL0a7x+yaaWbhPxhVT6ecLomri6ZRr0RU74ZtiOu0Bd7dN
         YIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155712; x=1691760512;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy6cMwpEJf7gKHi9mBSsBAFtdHdF/m1nv2+iWOl0BKM=;
        b=ghwvGGwv6MLt+AzFJZD0H0ucWpwTcujQv39hfJ7o3VPoNo0ceFDVOGYWTzTrj07Plb
         CG0Gy3uaYeLWIA3Kpe7Wi6o7XnQpkyZQu1twNbCtZscgxPUNDjOJ+BTCGqjhuMgU2B9p
         WtLlptcDBqmhh3L6Xqiwzu/ryM4XMVZOB7KLXP3pvcq70LJRn03qBOtSQ8ZT2zoH+Kqj
         vxS+V2oVua7slFXgsqNxaUNgO2N8J+g1giWNoc9/1drq2iuWikGWAwRXUYZLPsdh12Dr
         HtWMfL+Pnhvv2jfL0bf0EAIyZhygWY5QiRTzavgFE7uUv+2z8+oy81cZMIKBmQzPcSKo
         pPkA==
X-Gm-Message-State: AOJu0YxDrTt+6UPV3PDBUV620wsxC9w1VjyuvtdPO+2TihKjn9FXgoKv
        eNJE95vzEYgPrwn7GOH2qjw0uZX9IBoXVz1SoVMgCw==
X-Google-Smtp-Source: AGHT+IGo/+eExp68vdRycdBrLmkZgZlg8mYAJJ9wUXTn/JnhhARqgHF2RquM65OX4q76G2HMQLtkjw==
X-Received: by 2002:a1c:ed03:0:b0:3fb:a102:6d7a with SMTP id l3-20020a1ced03000000b003fba1026d7amr1452813wmh.28.1691155712555;
        Fri, 04 Aug 2023 06:28:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z22-20020a1c4c16000000b003fbb25da65bsm2376182wmf.30.2023.08.04.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:28:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20230718-feature-lcd-panel-v2-0-2485ca07b49d@wolfvision.net>
References: <20230718-feature-lcd-panel-v2-0-2485ca07b49d@wolfvision.net>
Subject: Re: [PATCH v2 0/4] drm/panel: sitronix-st7789v: add support for
 partial mode
Message-Id: <169115571153.3578872.18363696877056679557.b4-ty@linaro.org>
Date:   Fri, 04 Aug 2023 15:28:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 04 Aug 2023 15:02:31 +0200, Michael Riesch wrote:
> This series adds support for the partial display mode to the Sitronix
> ST7789V panel driver. This is useful for panels that are partially
> occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
> for this particular panel is added as well.
> 
> Looking forward to your comments!
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/4] dt-bindings: vendor-prefixes: add jasonic
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c1e98bb9e69f49e16c34c1cb48bcb5b0f0cb064a
[2/4] dt-bindings: display: st7789v: add jasonic jt240mhqs-hwt-ek-e3 display
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a5382e358e56f3bef13aae3432bec906130b2074
[3/4] drm/panel: sitronix-st7789v: add support for partial mode
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a82db60440c552b1def32ab33b642454490d850e
[4/4] drm/panel: sitronix-st7789v: add jasonic jt240mhqs-hwt-ek-e3 support
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0fbbe96bfa089c3758a7d1969ff34036d3f03d68

-- 
Neil

