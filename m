Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0B076E303
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjHCI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjHCI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:26:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3AB59C3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:23:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso6786895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691050997; x=1691655797;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJMrHXaDI2jXZZ4fTi2siSIHXafUBuzV5Qg1y6pooWA=;
        b=y+v/u9a7vIxXIW2+GWqMqxQYR1oinKq8Lgt/a4XqTLYX6clqRNeDzKwBT6e7peNEyH
         LqH+n6XD1UBTjbps2wOdvzFSFDpnjJ4dhUxDgYbJtOu+GXL+6X7K14MO10V3BCHRHNgq
         baM5dcDL+xrVgho+xCSJR6iMbS2TvnOYCAkq9gY2i1FoTGnYB4auJy/+NLku08cGj+dA
         ddjxnRCD6A9uci2aiT12WIBl8CubNbkHoFJ9p0nodGL4Wt7lDgUytiSwWLJLkhNRJ6xJ
         qM4kHGsJ4bBOuqF1i0tEA8rgXih1OEXoqeeV3bNSACQcaxWTyFmi3dDG7h2R/K9Ce6fi
         kTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691050997; x=1691655797;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJMrHXaDI2jXZZ4fTi2siSIHXafUBuzV5Qg1y6pooWA=;
        b=UIaMrJ0EtMC35cpJvS2Nambv7pDWS+ZlpMqIxeB1sbXygiIVNGL27PVoYVZl9H8xHj
         p8h3A7Ydd51LzmcvIeRku9r8wCXY806u6eXDUFs43wBudUlFs9iVwvXJGat4GmrJ6YER
         L6w586hYQsdOkqZ/CbF2fRuZvXz06C0KNvbTXN7Yf1DdjiIOz35l66hHgNc8akPFOc06
         ncWYPnQM1fGpyzlYpVv251/b0UIXorB8PUdFEG+RijEMNiBi6rKiqsjhqpMkrhLs8pGk
         9vyP2onv4yhOeL3O2uf8PoI3sGu9wpVsLirH8XCnEZzx1s0YU2cHQ3OmwW/6FcG7Kw4N
         7GJA==
X-Gm-Message-State: ABy/qLb8q2tzXP0AR1YQmA2LOtgj/OCB0gmtMiU7AS5gABhgccDKhegC
        t30bcKFvZ4xbFCNzLlULT8zUvA==
X-Google-Smtp-Source: APBJJlFMwEOpdx47TLNsl1lN03YDYUVk04bqgSbetYihaLvp4UQmnUd9EUCO/APSD+4OITuhnwpEhA==
X-Received: by 2002:a05:600c:40c:b0:3f9:70f:8b99 with SMTP id q12-20020a05600c040c00b003f9070f8b99mr6716325wmb.7.1691050997459;
        Thu, 03 Aug 2023 01:23:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fe11148055sm3539994wmr.27.2023.08.03.01.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:23:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230802074727.1.I4036706ad5e7f45e80d41b777164258e52079cd8@changeid>
References: <20230802074727.1.I4036706ad5e7f45e80d41b777164258e52079cd8@changeid>
Subject: Re: [PATCH 1/2] drm/panel: Fix kernel-doc typo for `follower_lock`
Message-Id: <169105099663.2484653.2634988255195420764.b4-ty@linaro.org>
Date:   Thu, 03 Aug 2023 10:23:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 02 Aug 2023 07:47:27 -0700, Douglas Anderson wrote:
> In the kernel doc for the `follower_lock` member of `struct drm_panel`
> there was a typo where it was called `followers_lock`. This resulted
> in a warning when making "htmldocs":
> 
>   ./include/drm/drm_panel.h:270: warning:
>   Function parameter or member 'follower_lock' not described in 'drm_panel'
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm/panel: Fix kernel-doc typo for `follower_lock`
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c0571b20fca4acebd4cb5fcfd07ca4654e9d63dd
[2/2] drm/panel: Fix todo indentation for panel prepared/enabled cleanup
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1ab2ddc4afdd84632c24b23dbe67eb4ca423dcc5

-- 
Neil

