Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046637B4C53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjJBHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjJBHLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E40BB7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50307759b65so24792863e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230709; x=1696835509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf4pBGrQWkR1d9eK2zpSoqoXnEaG6SjbMffIpQ2BPaw=;
        b=a9PHG0EQXmCCjdJQjSWWcnyzH3GR7ES6XFfXuXPqeDrus0am8EWLcIAi/FJ1s8QA+C
         Zoaq/01hmxKKc6loBm0qwVVE3RBK4B6LYtIvZ1LS3vyfSYzFQakcpcNhQsMPt72OZKtp
         /iGAB+2M5IWNF0umjJWUymEYn9KprmfiBYKTak04vnfgNzQy73bNF7ggJ/3xodyC96Oy
         lG7nzPi41os6ZcIhjdNIcZz84pnhy0HvGlD/Pughdtq3Je+09n1brE20Zn1Lr5EtixwB
         /vnVT85CYOC/09bs1VqAJv1d1ArcW29ZudQLE4AAJVDd2bgWuarZXu/MJe9oUq7RvHH4
         MQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230709; x=1696835509;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf4pBGrQWkR1d9eK2zpSoqoXnEaG6SjbMffIpQ2BPaw=;
        b=RQJFTYqsrvmTEE+5D7EqDUXLNj3EL8/d+Bjiy9PLQkXq/aWkx1F1TSFRnLiyv5gTmx
         xY5MGbFOmvx38HoJRPl1aFO1J5KWNZRuduITZ1mHNtpLDspQoq5UPT1w7W3sxoypNcGY
         QkWvbope38YooyrC+08IkgdezaCp6hyxhkCAuW9klDoYGS6X4YJBeMzfQ8+OJY9LeXZN
         UOPZ4lliZkdeAEqcfsyMiaot+ykiYmYNMNY3+FcPCcUywtARwVDbJ3DfUEuseVnX2pbF
         Y2toBw3/B8wuqodzbtnGtbSHKB4hUh5OZZmuaTc4ZL3dVynIbz+u8yGU2F4QQstKWyza
         ctpA==
X-Gm-Message-State: AOJu0YyXoezI8y5eL+Ql4aoc0V0BvrlnngQAlBpXUPtz90Ir4sM8nsbh
        CCrWFXtfHMKF++WGgVDnDygjPA==
X-Google-Smtp-Source: AGHT+IFUICv27iaz43fcdoCHCn19XLHU3Rfo2it3wCUxSjFwQc8FYbO4saa6ycVFUA2qgmxP3Qx5Kw==
X-Received: by 2002:a05:6512:2355:b0:502:ffff:feff with SMTP id p21-20020a056512235500b00502fffffeffmr9767677lfu.58.1696230708264;
        Mon, 02 Oct 2023 00:11:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231001-drm-dlpc3433-maple-v1-1-7d71170c010b@kernel.org>
References: <20231001-drm-dlpc3433-maple-v1-1-7d71170c010b@kernel.org>
Subject: Re: [PATCH] drm/bridge: dpc3433: Convert to use maple tree
 register cache
Message-Id: <169623070743.3600226.3322691055025945880.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 01 Oct 2023 01:42:24 +0200, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: dpc3433: Convert to use maple tree register cache
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9a9f6fb5205a6cb189147bca1264311c4bf45163

-- 
Neil

