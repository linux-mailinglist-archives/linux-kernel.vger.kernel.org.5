Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83076E336
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjHCIfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjHCIfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:35:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30C7290
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:32:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-317c3ac7339so306522f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691051524; x=1691656324;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIBfxub9CM01UtScGp+GlDrmpYqPbe9y/M/0ui+FdrA=;
        b=u03rVYohPugy5ggUV+yVILLHwa/fApSrXPMLwWpf964VAaPXySwveplGmdXdDuCKVW
         AEjP9snX0q8hSemntEF1DNi6yBDMfqOp8vxtD94PhM2DwBi7MIeJ10tzTirXCwGO/NeW
         Ve5tmUQ6nWk7RRJA8HYWQ6yRs2uHNWNSv6N8S+E6kSVLIv8GuL9adgB6sMUPnTPb8JKa
         Daamc38M7HEuHfyIGoxJSOk4r1BNq2DXqHbPuo+KPz+1nV6R2TQ9pwVyfXrryalsypXt
         A3Y7IBCYyMLDTZBLbv8jzrIrsMG2duRIWCjgi/2TYE7QFZ6KxZBRWBDSyonwXIAMqdz6
         sLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051524; x=1691656324;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIBfxub9CM01UtScGp+GlDrmpYqPbe9y/M/0ui+FdrA=;
        b=DqhexPZh4zixD85Sm6qRlIrPoHgRTm5FMzvnYDwxJHBWHseCZuTqT82mrFthsZp8qX
         8ORZGrNTRSBY6jS5VGu8MspcymeZT30prlPn3S+UnLcGg0q48auG8QnZxTSfqGBYCEC9
         CuoaDnl7fuLH++3dqOqxVhauxYqWKSK7T4P7qQOHubVrOUj7Yo/b1sJgli3GFztsOpu8
         ekTaDWY9oiX1DESBIZaP+qQtWrjCN0Dzw9JHnOSWOOi7jsjhNBFtPWETWbtPw7PvdHZl
         qboFOt7CCyf6zZyo3OjsYHdcIqulSTnobhg1/NMRG7A7CZhi1J5KcgGEke5dYPPi/OMB
         RS/A==
X-Gm-Message-State: ABy/qLbLghSZrqwUeY/YNa2Fj4jSl2e3Nd0KsHwBg9CCVHh/zyQql8VN
        DXuudB8EzUrEaumK2xFh63PtlA==
X-Google-Smtp-Source: APBJJlHh7x7hfbVuixT27Kq22dQd+UEZdFISupP7IvnKRnCX3W9nWlXJcIc6br+n6dnAt0vliCQ04A==
X-Received: by 2002:a5d:498c:0:b0:317:5b5f:3348 with SMTP id r12-20020a5d498c000000b003175b5f3348mr5633469wrq.71.1691051523868;
        Thu, 03 Aug 2023 01:32:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d60c1000000b00317afc7949csm6676364wrt.50.2023.08.03.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:32:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pin-yen Lin <treapking@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230727100131.2338127-1-treapking@chromium.org>
References: <20230727100131.2338127-1-treapking@chromium.org>
Subject: Re: [PATCH] drm/bridge: it6505: Check power state with
 it6505->powered in IRQ handler
Message-Id: <169105152304.2528955.6714983966012972300.b4-ty@linaro.org>
Date:   Thu, 03 Aug 2023 10:32:03 +0200
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

On Thu, 27 Jul 2023 18:01:10 +0800, Pin-yen Lin wrote:
> On system resume, the driver might call it6505_poweron directly if the
> runtime PM hasn't been enabled. In such case, pm_runtime_get_if_in_use
> will always return 0 because dev->power.runtime_status stays at
> RPM_SUSPENDED, and the IRQ will never be handled.
> 
> Use it6505->powered from the driver struct fixes this because it always
> gets updated when it6505_poweron is called.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/bridge: it6505: Check power state with it6505->powered in IRQ handler
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e9d699af3f65d62cf195f0e7a039400093ab2af2

-- 
Neil

