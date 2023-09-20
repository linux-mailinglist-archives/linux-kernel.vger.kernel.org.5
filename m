Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9A7A89F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjITRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjITRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:02:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EE399
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:02:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404314388ceso303495e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695229338; x=1695834138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn2Ngd3ukFjoHjH9W9ENbDDoYAtr6LLLpGel78I6ZB0=;
        b=RGi5AzZpWffU/qw5uYI5RpPeQL/3JEYiUG24PK5yhJIuE85ltNp7jBV778Hm1NE0gD
         twkRve7nMeRvY8IjSOrD7I/J9cYbO8PZSL7AQ8KOZ45euHN4jXEk5Ey2Xo20MBtj1+h3
         UX7tSQFJFfv1AoDnMblpmMe1nnui4Puy+x++THvhdQMAIpPHUHNUn/asg21wlxaqorn/
         vdVfQ2aq00baZRSZzh+IZldAYFnSyEzI7vTWbB5CQ55029UuMmGjDzQj+x/YIBRuzlan
         WzocklUMQeN1BBUXRtch5C1YPHooLdTTmPOxEx8nmTqf1tiuhPYGl8xHjOfAlHC1Lvjx
         oacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229338; x=1695834138;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jn2Ngd3ukFjoHjH9W9ENbDDoYAtr6LLLpGel78I6ZB0=;
        b=CC0fVFVYkdbsqmvcxH/I8MebdULyCwUhFD8efXD9omw+szqikwiiDU8dK2ENvAxhy8
         8CoIksbfSBwMFx+aIWQpXuxVonYyXGZqqijlbLghs1xBQxVmT6Jf50lHzld8fZf6Z1DI
         ecNv0T7RSUazElhtucHi7hO+s8G7FkZvBu6oc89Px/G6qA9WS7VVdO/yhUkb1X/1N3bi
         4T9gPM7h3JKaI1vhIvlSWIUFme/yZcdzWWvqzBVk7S3aSrEnU1XyqNHh0NRTe7KhuSNa
         PahA107MfIUUxspsKyoxmSJ7RCQuuuaJtAOYKba43GC2RpFpYNj/EJaa4qaRVcCKtMk3
         lQrQ==
X-Gm-Message-State: AOJu0YxSkOyNso8nVD0MULzKJclSTkJDKKn9wsrBanSnlpFuyo4TGKN9
        EqE/Kdo8YRvYdCwfcA53oexuqA==
X-Google-Smtp-Source: AGHT+IHQwC4CCE0u7zaSVVROxrBB4EbV/lQdgjnSt+j2QBhsWsgfuJK8PN2PW5lRoOHFRGdAEdvUKg==
X-Received: by 2002:a7b:cbc5:0:b0:402:ee72:2314 with SMTP id n5-20020a7bcbc5000000b00402ee722314mr2918067wmi.3.1695229338096;
        Wed, 20 Sep 2023 10:02:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c248900b003fee849df23sm2441693wms.22.2023.09.20.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:02:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     andrzej.hajda@intel.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, ulf.hansson@linaro.org, victor.liu@nxp.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, ehristev@collabora.com, wenst@chromium.org
In-Reply-To: <20230920082727.57729-1-angelogioacchino.delregno@collabora.com>
References: <20230920082727.57729-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] drm/bridge: panel: Fix device link for
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Message-Id: <169522933708.2429100.2452577965890146025.b4-ty@linaro.org>
Date:   Wed, 20 Sep 2023 19:02:17 +0200
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

On Wed, 20 Sep 2023 10:27:27 +0200, AngeloGioacchino Del Regno wrote:
> When external bridges are attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR,
> the panel bridge may also get the same flag, but in the .attach()
> callback for the panel bridge a device link is added only when this
> flag is not present; To make things worse, the .detach() callback
> tries to delete the device link unconditionally and without checking
> if it was created in the first place, crashing the kernel with a NULL
> pointer kernel panic upon calling panel_bridge_detach().
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: panel: Fix device link for DRM_BRIDGE_ATTACH_NO_CONNECTOR
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=887878014534186cc50dbd16a62e744ad217b4b1

-- 
Neil

