Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367FB7696B3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGaMqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGaMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:46:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E2810F0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:45:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so41315975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690807546; x=1691412346;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZR18Xj99HGOD1PDk2Wg3AoA7XuLUWWBfQUMdU0ykAY=;
        b=jgvt699AzMVlxBH1oI2qowHO2B2mkSF5UBl7C6x3uE+V+7CXitS/vDrUwVNm4sjn7A
         hYWqdaTLy0kSJwdomx4xQgMck79czHorgg6+3JupHIGLsOTbX0XMbShgajp9JT8YP+Z4
         iGnJv9Wi3ATuAD/rhPvOTCp2jFZffrI5knghLZAdGIrq3+YQpopxA7itc+zCnnWLV2pB
         asjqZ4Mz1oPYkTfTemqY3ntBXeqKJT411x5DQMU/SbzKUwGrExPu02ciL+ylmGuhmVVT
         bnxCXDj+mepnM3PD8aQ7adWDinXC3470xSbC8ADmvKn/32xl9bknJfeHHx1TO/YicqiB
         jGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807546; x=1691412346;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZR18Xj99HGOD1PDk2Wg3AoA7XuLUWWBfQUMdU0ykAY=;
        b=gKEy3Z6bGqJ2dFCta9YYhlJLUsfWPRMwi4rPkqKYb5a6yRTs+mc140yut9dOrJzLd4
         opZCHv/GdCuRZ+gX/KfG89lFjQp9zC0ilfKh8mHN3qgVqyRa2uD43HZuvnHg9xFixQ+g
         NOANUxGV5gyegPFNZauqjxCQhv3lKj1jSFyPhtOD6eB1gyARXqX+gxcFJVYj/84PWE9a
         v3eQSxPH0CvBOtgZBVcbSJC3aa79IvFYzjfbqSvrWRSS6r4R3QbAC6pp6E3gsc5qHqZc
         SecI/Nud4Q/BUyLIx/P8nusqDHvPnGfhg0JrNzA+9EYt++3oMWVs+LFciRqvQpuSB3Dq
         9BFw==
X-Gm-Message-State: ABy/qLZMJNii8Of0hvJjzzj9dvEnBFfLyPVbS+//l5Msb7Se3k/ztfTQ
        RpnFwXnQZfb8rHWVe2YUklPFjg==
X-Google-Smtp-Source: APBJJlFOCYdoGZugE0LD+eK8NwPii03aq8NdDzG7hI3uuNB7Ncsp30TabHxmxmI8t53MEh1yuMWeFw==
X-Received: by 2002:a7b:cc91:0:b0:3fe:2102:8083 with SMTP id p17-20020a7bcc91000000b003fe21028083mr1660224wma.26.1690807546572;
        Mon, 31 Jul 2023 05:45:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s21-20020a1cf215000000b003fc00892c13sm11117068wmc.35.2023.07.31.05.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:45:46 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230719130940.659837-1-arnd@kernel.org>
References: <20230719130940.659837-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/panel: r66451: select CONFIG_DRM_DISPLAY_DP_HELPER
Message-Id: <169080754563.253642.4338546109176180391.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 14:45:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jul 2023 15:09:21 +0200, Arnd Bergmann wrote:
> The newly added driver only builds when DRM_DISPLAY_DP_HELPER is enabled:
> 
> x86_64-linux-ld: drivers/gpu/drm/panel/panel-visionox-r66451.o: in function `visionox_r66451_enable':
> panel-visionox-r66451.c:(.text+0x105): undefined reference to `drm_dsc_pps_payload_pack'
> 
> Select both CONFIG_DRM_DISPLAY_DP_HELPER and CONFIG_DRM_DISPLAY_HELPER to
> ensure the helper function is always available.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: r66451: select CONFIG_DRM_DISPLAY_DP_HELPER
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a1865d3b98c97d25cbfbba4318180f5cfe8ec22d

-- 
Neil

