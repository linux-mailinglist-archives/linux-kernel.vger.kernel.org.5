Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847787B0E44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjI0Vlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjI0Vlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:41:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE4511F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:41:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5041cc983f9so19665857e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695850890; x=1696455690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZPhCbxws0N6c+RxZtsL4OLtzT2jJtD2gNaLRXE6jZk=;
        b=X4E8ZJInMKf9xiOm1BpuKjvUzoEO4cmna+W9GWPVwEIibguhsjIicw3jk5dPz2WAo3
         FIokgD+M89zjfMrdHRkHLWs2zOc0kHXZuygKR3FgocXnmeKFnhb1gsyEfu0bh4MIXKas
         E++kcGOn4pAQLXKHf/ZFIOfsmHmcmjmL4SAts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850890; x=1696455690;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZPhCbxws0N6c+RxZtsL4OLtzT2jJtD2gNaLRXE6jZk=;
        b=mX9nOKfKu3SXF9woiTIFwOG4kqjt55kIDlLmz8XU9wTyuF88B5LDLFjaT40ha+LIaY
         5UaPFbycMod4ADrjsrrViP3DIm/HQQOpElA74f3RV7Xa1mcBMsccUAlIEJt1X2LIOOCN
         6RdtQ4KqLfH9P5z7ZzyGpcmUTCOFrxKN/uHERc7UtLO3of93SSZ2Nn2PCgb2kp8AoD4t
         w87z4kJRHgKAfucm9a9ml0BcINVuvYEwWgci8+2zcq6oFQZSW9NWmL2LffvDEiFa82hq
         DBf1PsEQbNQfKV2CXHGWERclYZrCpnw2R1TOqMLSDX26jrmrvDVVUirjUjxI8Oy8Ii1p
         pgpw==
X-Gm-Message-State: AOJu0YxHwfT+7VBzzKcJ6mL5ok9rg7RcyantmOtg1msKh77QR8mjBZbr
        TyIm1S+1+pvM585fccWKMexura3TxO21EfrQtNUYFg==
X-Google-Smtp-Source: AGHT+IFWMD3WqTjjVpi0l63bw4jdnCFGNGz+jsmvkSy1ubVGWSZDX9PFKymKxC9und2e4VwY9YkPdw+kH9e4OxSiqRo=
X-Received: by 2002:a05:6512:3089:b0:504:31a0:f9e2 with SMTP id
 z9-20020a056512308900b0050431a0f9e2mr3398152lfd.58.1695850890154; Wed, 27 Sep
 2023 14:41:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Sep 2023 16:41:29 -0500
MIME-Version: 1.0
In-Reply-To: <65566a68-3510-2e5f-7d57-e4dba08c008c@quicinc.com>
References: <1694813901-26952-1-git-send-email-quic_khsieh@quicinc.com>
 <1694813901-26952-7-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJpqPXoFX4LXyXYgfh07Vpxg-KgD8VBR6x5bXf4GOJmbOtw@mail.gmail.com>
 <2f98d5f1-57c1-d9fe-cb1c-b975db057287@quicinc.com> <CAA8EJpr2wRq6Txi7YAQpJKa_9UGqH_nmHzvVOaAPkwOrtDg4Tw@mail.gmail.com>
 <CAE-0n53dqHONzMTd_ZC-fKWTzDVq6Wqwo4OFZMUcghZ5SD5RhA@mail.gmail.com> <65566a68-3510-2e5f-7d57-e4dba08c008c@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 27 Sep 2023 16:41:29 -0500
Message-ID: <CAE-0n51Ep4zBx6bswL4Yb+F0+8dW+L2kaKQaZBi-91jsVqm_9Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm/msm/dp: add pm_runtime_force_suspend()/resume()
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, dianders@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@gmail.com, agross@kernel.org,
        andersson@kernel.org, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abhinav Kumar (2023-09-22 18:35:27)
> On 9/22/2023 2:54 PM, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2023-09-19 02:50:12)
> >>
> >> This should be hpd_notify, who starts link training, not some event.
> >
> > I think this driver should train the link during atomic_enable(), not
> > hpd_notify() (or directly from the irq handler). The drm_bridge_funcs
> > talk a bit about when the clocks and timing signals are supposed to be
> > enabled. For example, struct drm_bridge_funcs::atomic_pre_enable() says
> > the "display pipe (i.e.  clocks and timing signals) feeding this bridge
> > will not yet be running when this callback is called". And struct
> > drm_bridge_funcs::atomic_enable() says "this callback must enable the
> > display link feeding the next bridge in the chain if there is one."
> >
> > That looks to me like link training, i.e. the display link, should
> > happen in the enable path and not hpd_notify. It looks like link
> > training could fail, but when that happens I believe the driver should
> > call drm_connector_set_link_status_property() with
> > DRM_MODE_LINK_STATUS_BAD. The two callers of that which exist in the
> > tree also call drm_kms_helper_hotplug_event() or
> > drm_kms_helper_connector_hotplug_event() after updating the link so that
> > userspace knows to try again.
> >
> > It would be nice if there was some drm_bridge_set_link_status_bad() API
> > that bridge drivers could use to signal that the link status is bad and
> > call the hotplug helper. Maybe it could also record some diagnostics
> > about which bridge failed to setup the link and stop the atomic_enable()
> > chain for that connector.
>
> Doing link training when we get hpd instead of atomic_enable() is a
> design choice we have been following for a while because for the case
> when link training fails in atomic_enable() and setting the link status
> property as you mentioned, the compositor needs to be able to handle
> that and also needs to try with a different resolution or take some
> other corrective action. We have seen many compositors not able to
> handle this complexity.

The chrome compositor handles this case[1]. If the link status is set to
bad and there are non-zero number of modes on a connected connector it
resets the status to good to try again.

> So the design sends the hotplug to usermode only
> after link training succeeds.

I suspect this is why my trogdor device turns off after rebooting when I
apply a ChromeOS update with the lid closed and DP connected. Userspace
wants to know that a display is connected, but this driver is still link
training by the time userspace boots up so we don't see any drm
connector indicating status is connected. No drm connectors connected
means the OS should shutdown.

>
> I do not think we should change this design unless prototyped with an
> existing compositor such as chrome or android at this point.

Is this driver used with android?

[1] https://source.chromium.org/chromium/chromium/src/+/main:ui/ozone/platform/drm/gpu/hardware_display_plane_manager_atomic.cc;l=114;drc=67520ac99db89395b10f2ab728b540eef0da8292
