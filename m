Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A457C044A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbjJJTTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:19:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E28B93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:19:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50567477b29so7863751e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696965559; x=1697570359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvjZzz7pnTqNFU2kq8efpY866MOjCfg9gpj/PxH4/+k=;
        b=n+XQu0m7VOoFw+XDKPQpK4CUKt+osR1RtzWJXf7Wybv2DOD4r5L0z4wq9kS4a/ETU/
         6EALYpL1haL1aHsfwhDWB5zZDkXkHlkX3fMULi+UKyJ8A6rUQWCHEyLSBF3VUS7HOAb7
         96TS5IKMIMbRHnWwhEMn57T21loh755ezwwZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965559; x=1697570359;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvjZzz7pnTqNFU2kq8efpY866MOjCfg9gpj/PxH4/+k=;
        b=sVeL9fTD6PmS6j7RlVScmzkvZye9LbxK6DTor/rVeKuhSpOK8q6MkjzcYz4mKN/c20
         eKVDDBfswcK+KF+Cf9FoNRbow2i+XYlo8Bm0u3acQCzb8Lt+knaBJLVUdRJYHMUeTn8t
         3RbUEsNT9bqm3AkZt746BBjm9yoSWIlcaaRvjekuSL8Ifebp2jxMBVHiSIG8DpxbEgTq
         YQNhlhpGhSy5GIRNO6Hcr3D7lI5Fz0RSBxF39TV3AN7FH0HxU+Zagg+YI5ljnFiBMpSb
         m22+dfB0y1zcjLrYNN8CSZ+91hMoPw+8BxgrEjkL81l24GvxmYuhVIh19cAsCu0Wmq73
         X4wA==
X-Gm-Message-State: AOJu0Yz5whGZxc6CEHOvfjxzcXE9FU6LfbCbuIJ6SqpUVYMfn9BptHbz
        Fb0T/I3noNkorp8pxJ6Kr0XlQnHKfGdi7dBWoS1lSg==
X-Google-Smtp-Source: AGHT+IFq1y8usHuuOq0+zCRJnPaJsNG4I0nxxNL8AuiMb1KSaafC1SKCCoNyc4Vky58f9BXOh0ClpevLdtstLOMN0FI=
X-Received: by 2002:a05:6512:ac5:b0:500:8f66:5941 with SMTP id
 n5-20020a0565120ac500b005008f665941mr19661687lfu.50.1696965559028; Tue, 10
 Oct 2023 12:19:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Oct 2023 19:19:18 +0000
MIME-Version: 1.0
In-Reply-To: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com>
References: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 10 Oct 2023 19:19:18 +0000
Message-ID: <CAE-0n50GR2YXpZVANQEns4W5TEFoR7n80PFuoyMOs8vo=MDkgw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] incorporate pm runtime framework and eDP clean up
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2023-10-06 15:55:03)
> The purpose of this patch series is to incorporate pm runtime framework
> into MSM eDP/DP driver so that eDP panel can be detected by DRM eDP panel
> driver during system probe time. During incorporating procedure, original
> customized pm realted fucntions, such as dp_pm_prepare(), dp_pm_suspend(),
> dp_pm_resume() and dp_pm_prepare(), are removed and replaced with functions
> provided by pm runtiem framework such as pm_runtime_force_suspend() and
> pm_runtime_force_resume(). In addition, both eDP aux-bus and irq handler
> are bound at system probe time too.
>
> Kuogee Hsieh (7):
>   drm/msm/dp: tie dp_display_irq_handler() with dp driver
>   drm/msm/dp: rename is_connected with link_ready
>   drm/msm/dp: use drm_bridge_hpd_notify() to report HPD status changes
>   drm/msm/dp: move parser->parse() and dp_power_client_init() to probe
>   drm/msm/dp: incorporate pm_runtime framework into DP driver
>   drm/msm/dp: delete EV_HPD_INIT_SETUP
>   drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()
>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   4 -
>  drivers/gpu/drm/msm/dp/dp_aux.c         |  39 +++-
>  drivers/gpu/drm/msm/dp/dp_display.c     | 333 ++++++++++++--------------------

Tested-by: Stephen Boyd <swboyd@chromium.org> # Trogdor.Lazor

I ran some suspend cycles too with the lid open and closed.
