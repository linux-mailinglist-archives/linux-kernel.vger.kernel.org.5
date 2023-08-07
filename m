Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F98771D99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjHGJ4C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjHGJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:56:00 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE2F4;
        Mon,  7 Aug 2023 02:55:59 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1bc05bece1dso489537fac.1;
        Mon, 07 Aug 2023 02:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691402158; x=1692006958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM29zdZVBVOCSCNWC+N4/pn42HvEOpSp0FjiUfhyV+c=;
        b=WG0LPz2O6tJSd7aohQHE15fGr1TEfsj9aE+Sucy4Ibz4YC4K3Eoonla84sn9S9R8I5
         zEC5DO9u3I0KsA8YpDKr4c0IwQgZ42W8NBtkN+yIqxRZqcoSsdtYS+K3NBHkrj/OVCXd
         r8uHgwKdUOIdPU65xHyHoz4BnSDCspLnfaClzZ6tnw+38jTr1LK9TU9sjgCpkojQGP8B
         iYgNCFbRv1+zr/MgqY27vo/8HrfT7kdStroxzTc5pXxMGoG5qWE3g6zp3ruhxCpgootc
         C8XYpN7q6tclBLAb/ITBjWT+PngBsIY2R+MqkhCFFOXJMykYfhU8E3lrtUYs0ZDji4tb
         tuDg==
X-Gm-Message-State: AOJu0YzRPckUNUTtgTa+hVafUv/FAYSqjVl4hZCaUIFqoCs+DQyxtM5j
        VcKEbEyWNtfPPt9cWtoJuxZJDuHBRZIsjUYHbwQ=
X-Google-Smtp-Source: AGHT+IFHIvYl74pw4UZh36FUG3o40lXvym9lMWxwRL/SxHlVB7wTSMG9tn/tEdRQ5gFzwoxUxtwe3BVZMSdpSLITRrE=
X-Received: by 2002:a05:6870:c091:b0:1bf:9170:89ef with SMTP id
 c17-20020a056870c09100b001bf917089efmr9642566oad.4.1691402158480; Mon, 07 Aug
 2023 02:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230804214051.136268-1-robdclark@gmail.com>
In-Reply-To: <20230804214051.136268-1-robdclark@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 11:55:43 +0200
Message-ID: <CAJZ5v0iy+qD7J+UvFkG+ErLmYGk7ZvG2HY2vvWFiwA95jQ-yPA@mail.gmail.com>
Subject: Re: [RFC] PM / QoS: Decouple request alloc from dev_pm_qos_mtx
 (alternative solution)
To:     Rob Clark <robdclark@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 11:41 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Similar to the previous patch, move the allocation out from under
> dev_pm_qos_mtx, by speculatively doing the allocation and handle
> any race after acquiring dev_pm_qos_mtx by freeing the redundant
> allocation.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> This is an alternative to https://patchwork.freedesktop.org/patch/551417/?series=115028&rev=4
>
> So, this does _slightly_ change error paths, for ex
> dev_pm_qos_update_user_latency_tolerance() will now allocate
> dev->power.qos in some error cases.  But this seems harmless?

It is harmless AFAICS.

> A slightly more complicated version of this could conserve the
> previous error path behavior, but I figured I'd try the simpler
> thing first.

Good choice!

>  drivers/base/power/qos.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 1b73a704aac1..c7ba85e89c42 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -920,8 +920,12 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
>  int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>  {
>         struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate();
> +       struct dev_pm_qos_request *req = NULL;
>         int ret = 0;
>
> +       if (!dev->power.qos->latency_tolerance_req)
> +               req = kzalloc(sizeof(*req), GFP_KERNEL);
> +
>         mutex_lock(&dev_pm_qos_mtx);
>
>         dev_pm_qos_constraints_set(dev, qos);
> @@ -935,8 +939,6 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>                 goto out;
>
>         if (!dev->power.qos->latency_tolerance_req) {
> -               struct dev_pm_qos_request *req;
> -
>                 if (val < 0) {
>                         if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
>                                 ret = 0;
> @@ -944,17 +946,15 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>                                 ret = -EINVAL;
>                         goto out;
>                 }
> -               req = kzalloc(sizeof(*req), GFP_KERNEL);
>                 if (!req) {
>                         ret = -ENOMEM;
>                         goto out;
>                 }
>                 ret = __dev_pm_qos_add_request(dev, req, DEV_PM_QOS_LATENCY_TOLERANCE, val);
> -               if (ret < 0) {
> -                       kfree(req);
> +               if (ret < 0)
>                         goto out;
> -               }
>                 dev->power.qos->latency_tolerance_req = req;
> +               req = NULL;
>         } else {
>                 if (val < 0) {
>                         __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
> @@ -966,6 +966,7 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>
>   out:
>         mutex_unlock(&dev_pm_qos_mtx);
> +       kfree(req);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_qos_update_user_latency_tolerance);
> --

Yes, something like this, please!
