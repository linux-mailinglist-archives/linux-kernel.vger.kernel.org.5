Return-Path: <linux-kernel+bounces-103915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDA87C681
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFED1F21D58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E12125CD;
	Thu, 14 Mar 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ObHhqVDy"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48B111A2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459517; cv=none; b=KoU1NMyMGBWn+13zELQxOIfxYfuJ+vHtqBTTbtR06zjzvRWV/LSIIoZY6JGaQ0VAN/u4oqPhywO+PNifCsQiLDd4KEtt9p1iUKW4b1BSMX006HFqru1ZqqfJvC6mrnZH0juUyYr0mXJHibrRcA3brHqBoRBgrhg+UQrWfH2J3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459517; c=relaxed/simple;
	bh=b6hMDBOUHYVvp7TYHuvyzWx7CcPaqJ0juLMKBRJPNVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TInVQVRWL8mu7yNlNvz6/q9VtYBrnGw6It6dH5iU7Un4GpdCqoX7dEIYm6DPak0s4xV0OsIhp6cGuP94hfFDrfyzEeMyqlsh2ia+thwSh+Ai1TrpEm4PA8sCX5X4nrypqyjX14ryYvdSe2B+FT6f4AsgoHUhlsCbqYMoVVX777Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ObHhqVDy; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74435c428so1394249276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710459514; x=1711064314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2flT0SdHZ7q0eVlgQtj+A0ROMrjTL6rE3iscntdkYF0=;
        b=ObHhqVDy7qFgf7goxV2+j6FsP+1CLJgwKtgMRHkB+O4dqGvdW8CaB8XrnZMSzV6rdm
         oTvihuhwxXK+R+kzgyguxm/O4jhXSdh78Xn4y+O1o1DT6OclvrfdzESxITh75mE/pu3c
         gwU8reQQgaedm6IAITfGgEBYXzK8S7KS7wXq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710459514; x=1711064314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2flT0SdHZ7q0eVlgQtj+A0ROMrjTL6rE3iscntdkYF0=;
        b=MEZelNXWN6nAv2Ylw9Z9VtwsmAcjPkRNaFrzIfayKRFyxGicOe8JWugPozDZGHf799
         D1rrNn+EC1rWf/T2IZx+gJLtk1/CKj+jTzFGX2Q65ErH8rzTiKhTGYe8mdIziPwqQucs
         9LS9dyjx0wHW8CX28qW3KJP9LbLIn4ule9FI3xjGlDOezMtUhj5tNrLMnfMj3d0PhKvV
         q7cVQ3pGnNSw49nrJuSyMpf6nac2N9gAQYJ74jZL1lpJlORYzbmR4U0jnjNnvHcfhWLc
         uNHW8FfvrjMqYRTopsCsrrIhrm5+UcE8cxAuhF/G56KqDmGVltvaarlnonNuOTosUzSN
         A/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3vGdqLamZKqD8MFRPqgIpwNq1zokbul3xrjcHkEv8O/IR1jz3l1KhSsruNK2PTKeObSyTCMddHVmgHs+LkXrcKZsLX+lg/g3Cxb4g
X-Gm-Message-State: AOJu0YwnxNQScp0zmqE7Zmqbq7rLLkSyh7LIr1Xc5fnelj+2gIughfJi
	Xwbhj9uKwFZh3jX9BjZhsxW2Pj34DvOiAfrYynuUXig+n7Qk2XNPVoW9ALLy2ZGJEi8uPEsweHI
	=
X-Google-Smtp-Source: AGHT+IGGINGgia8bWWht5gR1hRJ62zZWov50y3GXuln/Aj+3WcbCdJOl8GBP9+vZ8UgV6acXa8+rFw==
X-Received: by 2002:a25:bfd1:0:b0:dc2:5553:ca12 with SMTP id q17-20020a25bfd1000000b00dc25553ca12mr3258592ybm.14.1710459514088;
        Thu, 14 Mar 2024 16:38:34 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id bp33-20020a05622a1ba100b0042f3ee1443csm1322247qtb.10.2024.03.14.16.38.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 16:38:33 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-428405a0205so75111cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:38:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZWMk3ZR2QNIui0LnPWOxmguY17F8Il7G7h6nRxsadLaG1RoHwk793xpqLXeeNoaqjYnr+grEnTQp1RsY7hj5QW9swsCXWBEvX/7OB
X-Received: by 2002:a05:622a:1391:b0:430:a5ed:fccf with SMTP id
 o17-20020a05622a139100b00430a5edfccfmr263222qtk.28.1710459130165; Thu, 14 Mar
 2024 16:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313001345.2623074-1-dianders@chromium.org>
 <20240312171305.1.I16aff881c9fe82b5e0fc06ca312da017aa7b5b3e@changeid> <d6ac0328-3d3d-75bc-09b9-ed0190a6a8c5@quicinc.com>
In-Reply-To: <d6ac0328-3d3d-75bc-09b9-ed0190a6a8c5@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Mar 2024 16:31:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XKc81S9M_Aem0fJhmCnFq458vFg3S-4aJNEvUCcQE3bQ@mail.gmail.com>
Message-ID: <CAD=FV=XKc81S9M_Aem0fJhmCnFq458vFg3S-4aJNEvUCcQE3bQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/msm/dp: Avoid a long timeout for AUX transfer if
 nothing connected
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Guenter Roeck <groeck@chromium.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>, 
	Tanmay Shah <tanmay@codeaurora.org>, Vinod Polimera <quic_vpolimer@quicinc.com>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 13, 2024 at 1:41=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicin=
c.com> wrote:
>
>
>
> On 3/12/2024 5:13 PM, Douglas Anderson wrote:
> > As documented in the description of the transfer() function of
> > "struct drm_dp_aux", the transfer() function can be called at any time
> > regardless of the state of the DP port. Specifically if the kernel has
> > the DP AUX character device enabled and userspace accesses
> > "/dev/drm_dp_auxN" directly then the AUX transfer function will be
> > called regardless of whether a DP device is connected.
> >
>
> I do see
>
> "
> * Also note that this callback can be called no matter the
> * state @dev is in and also no matter what state the panel is
> * in. It's expected:
> "
>
> I understand about the host state that we need to allow the transfers by
> powering on if the host was off.
>
> But I wonder why we should allow the transfer if the sink is not
> connected because it will anyway timeout.

We shouldn't! That's what this patch is about. ;-)


> Does it make sense to have get_hpd_status() from the aux dev and not
> issue the transfers if the sink was not connected?
>
> This is more of questioning the intent of drm_dp_helpers to allow
> transfers without checking the sink status.

It's a good question. I guess some of this just comes from the
abstraction that we currently have.

Thinking about this, the ideal would be to somehow query back to the
"drm_connector" since it already has a "->detect" function. ...but we
can't really do this since the AUX bus needs to be able to do
transfers early before all the DRM components aren't initialized. This
is, for instance, how the eDP panel code queries the EDID while being
probed.

We could consider adding a new callback to "struct drm_dp_aux" that
would allow checking the HPD status, but it feels to me like this adds
unneeded complexity. We'd be adding a callback that people need to
think about just to avoid them adding an "if" statement to their AUX
transfer routine. I'm not totally convinced.

Interestingly, we actually _could_ use the infrastructure I just
introduced in commit 8df1ddb5bf11 ("drm/dp: Don't attempt AUX
transfers when eDP panels are not powered") here, at least if we're in
the DP case and not the eDP case. When we're in the DP case there is
no panel involved so the DP driver itself knows when things are
"powered". For now I'm _not_ going to do this since it feels to me
like the "if" test makes it clearer what's happening, but yell if you
want me to change it.


> > For eDP panels we have a special rule where we wait (with a 5 second
> > timeout) for HPD to go high. This rule was important before all panels
> > drivers were converted to call wait_hpd_asserted() and actually can be
> > removed in a future commit.
> >
> > For external DP devices we never checked for HPD. That means that
> > trying to access the DP AUX character device (AKA `hexdump -C
> > /dev/drm_dp_auxN`) would very, very slowly timeout. Specifically on my
> > system:
> >    $ time hexdump -C /dev/drm_dp_aux0
> >    hexdump: /dev/drm_dp_aux0: Connection timed out
> >
> >    real    0m8.200s
> >
>
> IIUC, we want to timeout faster by not bailing out if not connected right=
?

Correct. I can try to clarify the commit message for v2 to make this
more obvious.


> > Let's add a check for HPD to avoid the slow timeout. This matches
> > what, for instance, the intel_dp_aux_xfer() function does when it
> > calls intel_tc_port_connected_locked(). That call has a document by it
> > explaining that it's important to avoid the long timeouts.
> >
> > Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/gpu/drm/msm/dp/dp_aux.c     |  8 +++++++-
> >   drivers/gpu/drm/msm/dp/dp_catalog.c | 10 ++++++++++
> >   drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
> >   3 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/d=
p_aux.c
> > index 03f4951c49f4..de0b0eabced9 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> > @@ -307,7 +307,8 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *d=
p_aux,
> >        * turned on the panel and then tried to do an AUX transfer. The =
panel
> >        * driver has no way of knowing when the panel is ready, so it's =
up
> >        * to us to wait. For DP we never get into this situation so let'=
s
> > -      * avoid ever doing the extra long wait for DP.
> > +      * avoid ever doing the extra long wait for DP and just query HPD
> > +      * directly.
> >        */
> >       if (aux->is_edp) {
> >               ret =3D dp_catalog_aux_wait_for_hpd_connect_state(aux->ca=
talog);
> > @@ -315,6 +316,11 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *=
dp_aux,
> >                       DRM_DEBUG_DP("Panel not ready for aux transaction=
s\n");
> >                       goto exit;
> >               }
> > +     } else {
> > +             if (!dp_catalog_aux_is_hpd_connected(aux->catalog)) {
> > +                     ret =3D -ENXIO;
> > +                     goto exit;
> > +             }
> >       }
> >
> >       dp_aux_update_offset_and_segment(aux, msg);
> > diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/=
dp/dp_catalog.c
> > index 5142aeb705a4..93e2d413a1e7 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> > @@ -266,6 +266,16 @@ int dp_catalog_aux_wait_for_hpd_connect_state(stru=
ct dp_catalog *dp_catalog)
> >                               2000, 500000);
> >   }
> >
> > +bool dp_catalog_aux_is_hpd_connected(struct dp_catalog *dp_catalog)
> > +{
> > +     struct dp_catalog_private *catalog =3D container_of(dp_catalog,
> > +                             struct dp_catalog_private, dp_catalog);
> > +
> > +     /* poll for hpd connected status every 2ms and timeout after 500m=
s */
> > +     return readl(catalog->io->dp_controller.aux.base + REG_DP_DP_HPD_=
INT_STATUS) &
> > +            DP_DP_HPD_STATE_STATUS_CONNECTED;
> > +}
>
> This method of checking HPD status works for devices which use internal
> HPD block to control the HPD (like sc7180/sc7280) but not for devices
> where HPD is controlled outside the MSM DP controller like sc8280xp,
> sc835-/sm8450 etc etc which use pmic_glink and DP driver only receives
> the hpd status using the dp_bridge_hpd_notify() callback.
>
> If we want to make this generic, we have to do something like:
>
> dp_hpd_unplug_handle() notifies the dp_aux.c module that status is
> disconncted and we should bail out
>
> dp_hpd_plug_handle() notifies dp_aux.c module that status is connected
> again and we allow the aux transfers.

Ah, good point about devices where HPD comes from elsewhere. OK, using
dp_hpd_plug_handle() and dp_hpd_unplug_handle() and having it notify
"dp_aux.c" seems to work OK for the external DP case (at least the one
on trogdor). It didn't work when I tested it on eDP but I can make
this rule just for non-eDP since they don't have the same issues.

-Doug

