Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07B7A26DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjIOTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjIOTDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:03:16 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B3D2D4D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:02:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59c0d002081so9493107b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694804556; x=1695409356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=euz/IHIc0mhpSJvprvTibU0nvlspa5qnPH9if5eZjIU=;
        b=GhDNDZgzjkY7uroEzoTvMLvLvekeX52OO1wkLynYCawICliC+hFE61sl4spp4idvvQ
         DIyandwCWjvPXcAOoJudVV+xh5+a9bQubWQbP6l5YVUujbeGn1u/uXHhpSDuXSbj6ygW
         9Gau4B4+n9PfjmdkQJC+OLL8saqedv3l+yj5P2xLCSxmqkK/KlEBpGgwhQsLer3U14ro
         vUXuh5nOjfnT5B+kjAv6hVCdzQH0fJkXkwMdP0nYb0+ANsn8Dal3Hs6630ZlKVScPBMo
         wEb4PMGkpAYwE0HsS5OU9XS/P255SbJLIyI0B8KATIhsw5I0Ln2juQNsoLZUZB9AB3wP
         yHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804556; x=1695409356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euz/IHIc0mhpSJvprvTibU0nvlspa5qnPH9if5eZjIU=;
        b=v7mL3Jdo+r2k4O3UydjYADHUi2ulZMLrn150B06chPs+cFOC8ftT/+moX/Li+6OqA7
         1Eg0gxl1gtW6M2Sr7zWePq2r3ToLvbh40BjCWvfvdi2Tg22GZUzp/kYq4++PWES4mbY8
         jg8erbAU/BPdc6g5yU9EIXhiGVUJk+7N15SoP9QELYCXLWPQpmBcL/JI0wlQcEtV/XTF
         MtLwO2GPGayqdZH70PMMwCN2hFrnZS/W4b4EcyhVF9AqrNKKX03Q9ojWVQGEcCt5ZRTQ
         TV4/N+6YzXLqAXMp8Q/ICTjOWKW+2XWotwdgfJ5pCIvE2+Lza+mEVnOl/wuOazl9JE4o
         08yw==
X-Gm-Message-State: AOJu0YwVYsqjKWm5yHdvWkho/bV8EerYXPjMyQ2qgS5Spshm9wFHm+Mt
        8rIBD6ZWexMNaCxXPDCEAVCNQ8y/PIyExYI564du9Q==
X-Google-Smtp-Source: AGHT+IHjvbgo6WAOZyaLXnz4gisXVihpdX/YxZz482tKbWXr6KliN8j5UIIdtWwak5bLhfxaD9Fmf6SeDLlP6dEFAas=
X-Received: by 2002:a25:8250:0:b0:d81:43ea:d018 with SMTP id
 d16-20020a258250000000b00d8143ead018mr2631057ybn.42.1694804555819; Fri, 15
 Sep 2023 12:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183010.32077-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20230915183010.32077-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 15 Sep 2023 22:02:24 +0300
Message-ID: <CAA8EJpp-eK1spEBSJtT0YtRkJtSL6MWPyxN5c4AB-1MJMJXs9A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: skip the wait for video mode done if not applicable
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Hai Li <hali@codeaurora.org>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 21:30, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> dsi_wait4video_done() API wait for the DSI video mode engine to
> become idle so that we can transmit the DCS commands in the
> beginning of BLLP. However, with the current sequence, the MDP
> timing engine is turned on after the panel's pre_enable() callback
> which can send out the DCS commands needed to power up the panel.
>
> During those cases, this API will always timeout and print out the
> error spam leading to long bootup times and log flooding.
>
> Fix this by checking if the DSI video engine was actually busy before
> waiting for it to become idle otherwise this is a redundant wait.
>
> Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 0c4ec0530efc..31495e423c56 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1075,9 +1075,21 @@ static void dsi_wait4video_done(struct msm_dsi_host *msm_host)
>
>  static void dsi_wait4video_eng_busy(struct msm_dsi_host *msm_host)
>  {
> +       u32 data;
> +
> +       data = dsi_read(msm_host, REG_DSI_STATUS0);
> +
>         if (!(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO))
>                 return;

We can probably skip reading REG_DSI_STATUS0 if the host is in CMD mode.
LGTM otherwise.

>
> +       /* if video mode engine is not busy, its because
> +        * either timing engine was not turned on or the
> +        * DSI controller has finished transmitting the video
> +        * data already, so no need to wait in those cases
> +        */
> +       if (!(data & DSI_STATUS0_VIDEO_MODE_ENGINE_BUSY))
> +               return;
> +
>         if (msm_host->power_on && msm_host->enabled) {
>                 dsi_wait4video_done(msm_host);
>                 /* delay 4 ms to skip BLLP */
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
