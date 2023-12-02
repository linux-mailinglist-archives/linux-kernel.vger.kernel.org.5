Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB3801EE0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjLBVlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:41:12 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D45E8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:41:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bf1e32571so80802e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701553277; x=1702158077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWlbs0KWaBVaE8N6qVsZVkB13N3rqr1ujf1GT2aj7Uc=;
        b=vETsaeuMD4B1CzCswjXZvGbaX/f6xyORqYLh9ajeNs7zlN+AH0M97nelXCUmyk9p7/
         I01qFyYjwNp4hTUy6gtCpoB7WX5cgQgufgFEeVjX2upimyHeCYPekTugnqLjF8tVofyN
         Ih952FWbW8tAhJeaaTkHvVxowjUsAve/gCEUy1DuZ5cE72/oB3DT4w/88jD/g/jZlB4h
         JUwVTlG3jaQwLZmaEqykOe9dmlBnYlVS0yIr99lwm+LE7+30uDoe5ADaQR2keUAFQ5Yl
         Mk4VQsfKqnszsq//oDTmLccbv+DfkpEvCLs8Da6PLhbgFSkkYqiePeaupHV4nuJxdkH3
         d1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701553277; x=1702158077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWlbs0KWaBVaE8N6qVsZVkB13N3rqr1ujf1GT2aj7Uc=;
        b=Ua+I5jGNLh5Qwy6Wulf+f9CMa9rw4bzsry5ce50HLz1JmBrvdp1KW17zofhKaPGoJk
         lSz2efjfNjomTqKTnaZjCpHe4ZiR7ptzuRtw3qM+3abTzrQZYNIfa3mex059w/nlvPQh
         UA222/C5hjo4vSgev5qDz7g5enn0myjdQa+Tsd4A1sMd5q2rva3V897o/nudvjoXAfN5
         zUxi2ff2pLisN1bdoVCBqkEoCMQwHKXZnEIyem9wCDc5kD8BtSQv6wkk0T+Ljzp0qitD
         xYG0iDeNtB3HsyaCRikL/crLs0G2kRDQnOYKkRX4gbGhGzE/WZo4RCk5rObo90JZUgDk
         p5ag==
X-Gm-Message-State: AOJu0Yx1CTslLn5ftbfR6Hrfm/D5jT4Ykn727ClA+0/hkeX8KXLJGAXx
        DqiEB1kEAA+O3kdBzKCyYaIC1A==
X-Google-Smtp-Source: AGHT+IE4fJCooRxy/WvcclobOdpHuXuNKEXkbUoo4PErcRVQclKZm/XLN5PrK52OLiSuV17YyY06tA==
X-Received: by 2002:a05:6512:2151:b0:50b:f2c5:56b2 with SMTP id s17-20020a056512215100b0050bf2c556b2mr7119lfr.47.1701553277170;
        Sat, 02 Dec 2023 13:41:17 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k39-20020a0565123da700b0050bf06eb35esm78810lfv.86.2023.12.02.13.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:41:16 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sebastian Wick <sebastian@sebastianwick.net>
Subject: Re: (subset) [PATCH RFC v7 00/10] Support for Solid Fill Planes
Date:   Sat,  2 Dec 2023 23:41:13 +0200
Message-ID: <170155324921.2215646.4829699354481827834.b4-ty@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com>
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Oct 2023 15:32:50 -0700, Jessica Zhang wrote:
> Some drivers support hardware that have optimizations for solid fill
> planes. This series aims to expose these capabilities to userspace as
> some compositors have a solid fill flag (ex. SOLID_COLOR in the Android
> hardware composer HAL) that can be set by apps like the Android Gears
> test app.
> 
> In order to expose this capability to userspace, this series will:
> 
> [...]

Applied to drm-misc-next, thanks!

[01/10] drm: Introduce pixel_source DRM plane property
        commit: e50e5fed41c7eed2db4119645bf3480ec43fec11
[02/10] drm: Introduce solid fill DRM plane property
        commit: 85863a4e16e77079ee14865905ddc3ef9483a640
[03/10] drm: Add solid fill pixel source
        commit: 4b64167042927531f4cfaf035b8f88c2f7a05f06
[04/10] drm/atomic: Add pixel source to plane state dump
        commit: 8283ac7871a959848e09fc6593b8c12b8febfee6
[05/10] drm/atomic: Add solid fill data to plane state dump
        commit: e86413f5442ee094e66b3e75f2d3419ed0df9520
[06/10] drm/atomic: Move framebuffer checks to helper
        commit: 4ba6b7a646321e740c7f2d80c90505019c4e8fce
[07/10] drm/atomic: Loosen FB atomic checks
        commit: f1e75da5364e780905d9cd6043f9c74cdcf84073

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
