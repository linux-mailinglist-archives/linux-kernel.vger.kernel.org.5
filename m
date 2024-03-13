Return-Path: <linux-kernel+bounces-100970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09E87A040
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042C81F22442
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2D8F44;
	Wed, 13 Mar 2024 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pWFsiZHJ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5916FA7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710290821; cv=none; b=EYI/G+G2k3ci0DYEaMEyucWAnlbr72outpSPRuZslMjRlVv4JzH4RAT5JldOvPYAmtWW8iyUv1ic/Fe6/R3mecbiUOMFFUK5MYI1IQTlwVmxlwNYQuPrReT3XlF28N9LmjW+cqSfizHv0rT1LwpVA1GKeUQCJ1iXvsgbO1pQPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710290821; c=relaxed/simple;
	bh=ul5scHj5JIWXIbj3a/W8NcuMaoMKAWTLOHd3ci4t0p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0XdEcbZj1XRVqLQQ1JxJEQ/TqNSsUXDXbs6tCG8lel4Psg1OiN05iXt4Gfd6gWqgZ5fd400t5oAOgWIVAxSM5WTe1Jihv7yBCjjQGIKAvWp48DBwIjw47vyzs9N99+ui5KbPw1YtKViVGo3i80lTlHskjOBbuL2HMPI6+vbj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWFsiZHJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42ee0c326e8so125231cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710290819; x=1710895619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04D6u+/MuKPrCCxQ1meOXYi6MthiRQ4bVsU1Ta9CV0=;
        b=pWFsiZHJheiXbr4ZbB37GrSFiE2iKlViaDTT7Iqwl0k4oRyVSu12cGa92coaNj/dE5
         GtiV6V4L8h+j0TFManQDgWzc2TfIXEUbPIsZtPz+Xfz2RJGUPsE5Ji69gQbIhSxwMpAY
         d+AJ27nPG/RheLGPLw9C3kv1nOSTjRFcpyCFBika+jgd3dOHoX4pyEppUt745akb4l5u
         1JxIWA/A6uE5d9H6WUj9zXHjC6QFKmn4kmh4Kmg8y33Q9qkJ2VjPk58ebZYR19ENhy4y
         6rdALcNu9MymaY076kJlUnJmG7Y6uJ7R16fI2qkdoy7sO/qFo8aK1zCqzA5xAwXU+EE/
         lv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710290819; x=1710895619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+04D6u+/MuKPrCCxQ1meOXYi6MthiRQ4bVsU1Ta9CV0=;
        b=xNPWUeRma1EQkmJ3RqF9lbqbJiIGCn7JNrWjVpsWnvkP+ZRoW1W38wgNkVIL+QCucI
         tndr1SFUa5aCGjqS+Q9p6NT62KlSQqOi6kv4Uao/h5zR/p7c8zQHq0ksNpx11A+WDN7V
         XWZEOcHiYXxBMbgi9f5X9H2gftTGbhobL549pLO+pZwkCOAArNpPZmIrSN9RZsuqs7L6
         oLvQMdwaJJ7EJVwju1s/wRQCxlLDFwn6rW4IcDteRx8JHrgDYJzjIc1c6pMoOXvIiW8h
         /DKkDwbXv3G+6HaZcD2og5vK4/4gCVihaYG4R73X3Ap2vO2VFlRxEkcUU5McVPTV6dIg
         aUfg==
X-Forwarded-Encrypted: i=1; AJvYcCWH51L9KPpPp1lhgEWAiej0mGmsJuIgYFXI0buQG9kb/mbGhpVsUSZJ62f2k4KfkdotABO05dhUZ+ifT015m/Lyd9qTfJL8CuRx2INI
X-Gm-Message-State: AOJu0YzezssgoklvoBx+feKb9Z46L+Efb5yqauTuz0G1zj5wRn43ukR8
	9V+KFpkY/O3VD2mB2nAKEBqle5Zu92Qt53kY7nJshxkk/0uWQbMM0uUdIA0emDJtdUlwN2oZXhy
	9iw/yLSgugI+gGWrpd+NbBz+dj1R52Hk1ZmfK
X-Google-Smtp-Source: AGHT+IEDNUZtHnW293+epCHuCd7X0kpy8JB6UScKG21DsvkhxYQyKtycIK7/9X0BOK18ToSUjuwEy0eQqZbYLoYTvI0=
X-Received: by 2002:ac8:5956:0:b0:42f:172b:a814 with SMTP id
 22-20020ac85956000000b0042f172ba814mr148134qtz.0.1710290818723; Tue, 12 Mar
 2024 17:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313001345.2623074-1-dianders@chromium.org> <20240312171305.1.I16aff881c9fe82b5e0fc06ca312da017aa7b5b3e@changeid>
In-Reply-To: <20240312171305.1.I16aff881c9fe82b5e0fc06ca312da017aa7b5b3e@changeid>
From: Guenter Roeck <groeck@google.com>
Date: Tue, 12 Mar 2024 17:46:44 -0700
Message-ID: <CABXOdTfNaorDgyZT8owH6ypYpZMhVpUEcK8N4Mbw2UumA8Db2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/msm/dp: Avoid a long timeout for AUX transfer if
 nothing connected
To: Douglas Anderson <dianders@chromium.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Sean Paul <sean@poorly.run>, Tanmay Shah <tanmay@codeaurora.org>, 
	Vinod Polimera <quic_vpolimer@quicinc.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:14=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:
>
> As documented in the description of the transfer() function of
> "struct drm_dp_aux", the transfer() function can be called at any time
> regardless of the state of the DP port. Specifically if the kernel has
> the DP AUX character device enabled and userspace accesses
> "/dev/drm_dp_auxN" directly then the AUX transfer function will be
> called regardless of whether a DP device is connected.
>
> For eDP panels we have a special rule where we wait (with a 5 second
> timeout) for HPD to go high. This rule was important before all panels
> drivers were converted to call wait_hpd_asserted() and actually can be
> removed in a future commit.
>
> For external DP devices we never checked for HPD. That means that
> trying to access the DP AUX character device (AKA `hexdump -C
> /dev/drm_dp_auxN`) would very, very slowly timeout. Specifically on my
> system:
>   $ time hexdump -C /dev/drm_dp_aux0
>   hexdump: /dev/drm_dp_aux0: Connection timed out
>
>   real    0m8.200s
>
> Let's add a check for HPD to avoid the slow timeout. This matches
> what, for instance, the intel_dp_aux_xfer() function does when it
> calls intel_tc_port_connected_locked(). That call has a document by it
> explaining that it's important to avoid the long timeouts.
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/msm/dp/dp_aux.c     |  8 +++++++-
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 10 ++++++++++
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_=
aux.c
> index 03f4951c49f4..de0b0eabced9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -307,7 +307,8 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_=
aux,
>          * turned on the panel and then tried to do an AUX transfer. The =
panel
>          * driver has no way of knowing when the panel is ready, so it's =
up
>          * to us to wait. For DP we never get into this situation so let'=
s
> -        * avoid ever doing the extra long wait for DP.
> +        * avoid ever doing the extra long wait for DP and just query HPD
> +        * directly.
>          */
>         if (aux->is_edp) {
>                 ret =3D dp_catalog_aux_wait_for_hpd_connect_state(aux->ca=
talog);
> @@ -315,6 +316,11 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp=
_aux,
>                         DRM_DEBUG_DP("Panel not ready for aux transaction=
s\n");
>                         goto exit;
>                 }
> +       } else {
> +               if (!dp_catalog_aux_is_hpd_connected(aux->catalog)) {
> +                       ret =3D -ENXIO;
> +                       goto exit;
> +               }
>         }
>
>         dp_aux_update_offset_and_segment(aux, msg);
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp=
/dp_catalog.c
> index 5142aeb705a4..93e2d413a1e7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -266,6 +266,16 @@ int dp_catalog_aux_wait_for_hpd_connect_state(struct=
 dp_catalog *dp_catalog)
>                                 2000, 500000);
>  }
>
> +bool dp_catalog_aux_is_hpd_connected(struct dp_catalog *dp_catalog)
> +{
> +       struct dp_catalog_private *catalog =3D container_of(dp_catalog,
> +                               struct dp_catalog_private, dp_catalog);
> +
> +       /* poll for hpd connected status every 2ms and timeout after 500m=
s */

Maybe I am missing something, but the comment doesn't seem to match
the code below.

Guenter

> +       return readl(catalog->io->dp_controller.aux.base + REG_DP_DP_HPD_=
INT_STATUS) &
> +              DP_DP_HPD_STATE_STATUS_CONNECTED;
> +}
> +
>  static void dump_regs(void __iomem *base, int len)
>  {
>         int i;
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp=
/dp_catalog.h
> index 38786e855b51..1694040c530f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
> @@ -86,6 +86,7 @@ void dp_catalog_aux_reset(struct dp_catalog *dp_catalog=
);
>  void dp_catalog_aux_enable(struct dp_catalog *dp_catalog, bool enable);
>  void dp_catalog_aux_update_cfg(struct dp_catalog *dp_catalog);
>  int dp_catalog_aux_wait_for_hpd_connect_state(struct dp_catalog *dp_cata=
log);
> +bool dp_catalog_aux_is_hpd_connected(struct dp_catalog *dp_catalog);
>  u32 dp_catalog_aux_get_irq(struct dp_catalog *dp_catalog);
>
>  /* DP Controller APIs */
> --
> 2.44.0.278.ge034bb2e1d-goog
>

