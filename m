Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ECE7BD659
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345638AbjJIJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345674AbjJIJJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:09:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16DA2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:09:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso39062325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696842556; x=1697447356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu0+ThQAo+g9milkUYpUIIdlEQpDV2pWkgKvoM+zN8s=;
        b=FzOgZiEZzez4Fb/26B6jgz5CMCq7HRnMsXpHgd9XjGj5UNTVs1clbL6+F9gYN4H1t9
         Et2d8B2yZdT+prHlHSkcv1x+jtByq0RuAeLU/edunOHp1s2t2V5y+FW+d5Hfk1wEzwfI
         ZETWvucgccToRdDEH28VYdCE0Wm695gX6JAZN/G1C2+H55jIgp1Qv+qIjLGovQ2nHfOi
         fW7yBowJejnLo2wjHfacliR8v6Ez4eRQcTP3FxLn7TmVXbuH1YrByJtvpYFO2GrSAear
         e1BxhNxnVTmaTqVviNsFDmUFqJDoBqpdQGLBlQuHm8jCXhnsqZmQpNcZTsEQjJGSVAc+
         guBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842556; x=1697447356;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu0+ThQAo+g9milkUYpUIIdlEQpDV2pWkgKvoM+zN8s=;
        b=w/aS/TTjjbY8xOzagZxYFBHCx5zCHDT7DIVzN2Zh6wYyD6QEW+NukUOLLShtxiLCph
         t83TXYoSBDbm9I9vNimmH4jeoayZ2oLjSBkiWi+Tfqjil3xbcBUgwpphPhjB19zLMC5i
         JALe/KzbBLTqLII330WVf1tv1o/5OZSyKhOXsW1I2Mfg0aR9mOZ+Il7/Rg3b1x/Hc01/
         sQExv0Rw9RKbQKteEopogQ1TdeSxMNqWIIST/w6SJhlQYYPcf+nGyV8mwupgo3+pUJqw
         u+8uqaqMcuf8YUobVv1/KpCF7yLur8iqBSxvZ4EWV7vNLkn5a8PoQw2LFdR0eiFoKyCs
         KZvA==
X-Gm-Message-State: AOJu0Ywb3FhiM8/5D8qQGMQ1xQ5Z3/x0MShT0HMnb7wWNMWL2Hb/hEgg
        /zfb9b4wti3VEauuCnCrIVR3lw==
X-Google-Smtp-Source: AGHT+IF1gfeKffTkLyBV4zT0Aa0IN2FUuZ4jVafuElp2ql/w0uc+4jVcF3RfnhlbHDzrhtAIg3iwHQ==
X-Received: by 2002:a1c:ed17:0:b0:402:f8ea:be3e with SMTP id l23-20020a1ced17000000b00402f8eabe3emr13000541wmh.7.1696842555840;
        Mon, 09 Oct 2023 02:09:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b004013797efb6sm12864525wme.9.2023.10.09.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 02:09:15 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230818-samsung-dsim-v2-0-846603df0e0a@pengutronix.de>
References: <20230818-samsung-dsim-v2-0-846603df0e0a@pengutronix.de>
Subject: Re: [PATCH v2 0/5] drm/bridge: samsung-dsim: fix various modes
 with ADV7535 bridge
Message-Id: <169684255481.1988265.17594322174846257761.b4-ty@linaro.org>
Date:   Mon, 09 Oct 2023 11:09:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 06 Oct 2023 17:07:02 +0200, Michael Tretter wrote:
> I tested the i.MX8M Nano EVK with the NXP supplied MIPI-DSI adapter,
> which uses an ADV7535 MIPI-DSI to HDMI converter. I found that a few
> modes were working, but in many modes my monitor stayed dark.
> 
> This series fixes the Samsung DSIM bridge driver to bring up a few more
> modes:
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/5] drm/bridge: samsung-dsim: add more mipi-dsi device debug information
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3683182a7254f728778452814abe2437a12502c3
[2/5] drm/bridge: samsung-dsim: reread ref clock before configuring PLL
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=eb26c6ab2a11e6c595ee88ce30c7de9578d957aa
[3/5] drm/bridge: samsung-dsim: update PLL reference clock
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=846307185f0ffbbe6b34d53b97c31c0fc392cff0
[4/5] drm/bridge: samsung-dsim: adjust porches by rounding up
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=198e54282ae560958e64328fe8f72893661b9e8b
[5/5] drm/bridge: samsung-dsim: calculate porches in Hz
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=6acb691824933535219dfd94d9d97c922f5593d2

-- 
Neil

