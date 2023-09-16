Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4710E7A2CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbjIPAqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbjIPAq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:46:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6D23C01
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:44:15 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76dc77fd024so173609585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694824917; x=1695429717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+UPUIgbgZmSTHC431gPSH3MLS9277uNHFZc/nQdeHJ0=;
        b=MU20/CROqO4cl+L7a3ag/6rnL1+wj0ffm8UXb/81eDwAkRqNvD8dOe94UoYtB4ZwtC
         N00CXW7VvZKxnIg7ImlBWVcwWGrfa04yoZBcrg+1MfkJVnRR671MX2F725tbOJd02hss
         xL2wlJGov6d0Nr6rOmWLRWICqcsXrxRhW8+8wMuGsBWn1Ee6KVNXQMY40IKbxNEUy/TU
         C2M5JWeyE+KU1jkiYyfvb7ninaw6FfzVEY/8IRWmKBDaJ5vq/uAxKc3XukIEUwK5uIC2
         2066n91QVIkdhX0VXfqIZcexkthrPRbuqPysnUINA3dQIcj/zPz3zJq3/ceVnW8GjKbb
         CDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824917; x=1695429717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UPUIgbgZmSTHC431gPSH3MLS9277uNHFZc/nQdeHJ0=;
        b=IATrSkV5/WgsQBEnnYdgjFTXbOCYR3W+DGUtOhPkCNKrS+oE55bohHoo9GCbreORC9
         meaansl3PiJujFXA4/1VFYzdrgPpAs5jXdsrV5bxcdocOx92McujflXf6LeD3/+hQhFU
         puTpHWVk/WjzGGdEdSwX7bqPU83unot+lZ8kPjsLbbIRmoFHtaKBqATWLCBsYy9jbc/r
         ylw75szdKMn7hLcut/IVNrwX6lc3RqSjOv99NVAAg2xXA6ieFSAPaTqr7sPVtyXfuk7a
         eXBOfJDoLjIYWVglVhqjL25Ws0MFcSkv7S3jsm1F9sl14tgBDRkTE2mBajc6GCq9CU26
         CG9A==
X-Gm-Message-State: AOJu0YxuMaRLakbK/bTJlJxZAecU+2sE2/2ZozEfZ4CudMQWhu9NYP5X
        Qv43Kw8ZSSlXTE029EfRSOg3wuN72CDj7scRaT7Opw==
X-Google-Smtp-Source: AGHT+IFct/9WnLc6rXu5KxRB4OXuXrpbd7b28NNSjfm+Rf+bcVJPjE7rZEfbDB+LKjwSbqtiKRR8XcDWna50TruCOlU=
X-Received: by 2002:a05:620a:2944:b0:76e:f0f6:d5b with SMTP id
 n4-20020a05620a294400b0076ef0f60d5bmr3563294qkp.54.1694824917500; Fri, 15 Sep
 2023 17:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com> <1694813901-26952-4-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1694813901-26952-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Sep 2023 03:41:46 +0300
Message-ID: <CAA8EJprG8HuhDHV9k5_4+vkejnYmwmg61isZXT7EsBCbGP0pJA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] drm/msm/dp: use drm_bridge_hpd_notify() to report
 HPD status changes
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sept 2023 at 00:38, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Currently DP driver use drm_helper_hpd_irq_event(), bypassing drm bridge
> framework, to report HPD status changes to user space frame work.
> Replace it with drm_bridge_hpd_notify() since DP driver is part of drm
> bridge.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Also see the comment below.

> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 18d16c7..59f9d85 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -356,26 +356,10 @@ static bool dp_display_is_sink_count_zero(struct dp_display_private *dp)
>                 (dp->link->sink_count == 0);
>  }
>
> -static void dp_display_send_hpd_event(struct msm_dp *dp_display)
> -{
> -       struct dp_display_private *dp;
> -       struct drm_connector *connector;
> -
> -       dp = container_of(dp_display, struct dp_display_private, dp_display);
> -
> -       connector = dp->dp_display.connector;
> -       drm_helper_hpd_irq_event(connector->dev);
> -}
> -
>  static int dp_display_send_hpd_notification(struct dp_display_private *dp,
>                                             bool hpd)
>  {
> -       if ((hpd && dp->dp_display.link_ready) ||
> -                       (!hpd && !dp->dp_display.link_ready)) {
> -               drm_dbg_dp(dp->drm_dev, "HPD already %s\n",
> -                               (hpd ? "on" : "off"));
> -               return 0;
> -       }
> +       struct drm_bridge *bridge = dp->dp_display.bridge;
>
>         /* reset video pattern flag on disconnect */
>         if (!hpd)

Note, this part (resetting the video_test and setting of is_connected)
should be moved to the dp_bridge_hpd_notify() too. Please ignore this
comment if this is handled later in the series.

> @@ -385,7 +369,7 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
>
>         drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>                         dp->dp_display.connector_type, hpd);
> -       dp_display_send_hpd_event(&dp->dp_display);
> +       drm_bridge_hpd_notify(bridge, dp->dp_display.link_ready);
>
>         return 0;
>  }
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
