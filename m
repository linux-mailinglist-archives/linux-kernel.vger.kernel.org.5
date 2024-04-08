Return-Path: <linux-kernel+bounces-135932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA5A89CD41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D951C21F70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E44147C6B;
	Mon,  8 Apr 2024 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaWTXJ1M"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C7B146589
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610762; cv=none; b=m8TpGDJEdK4v7GC/XH5u8Yq4spsCeXnEgifHoXFaam034azYHK47KN/tlLmVNwpPEJwpt0SXuB0VF1ht/a4mux+noDZ/+BARUUVBGmDbqMimZPDw8fe1MtC9e190q6bugxLITFWwtdQe6iRpVx2zC+NjnoTfp32MayFxJrhKHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610762; c=relaxed/simple;
	bh=qz0pO531sSXrogVn/Vl5zJ3xyWp2ey83hNZGuhaLAQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRFmwKwRALWF5z/y5+aeAPBh1HAwo88dkh6Qbie9KTmlCVJbqXW1KnNisx79iXSUsDfawu2OZgEdn5tViagOvTG2mtv0bD/GARJg5VSMmMJ4AtLpHyGb+94KYecPOtZJIDwZouamo9LAtgxDLuxf6I98vzR8N0xe5TVG+LgLwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaWTXJ1M; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso5076702276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712610760; x=1713215560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBrxiDN+ULxbnCCnTUMH5YTkPO5nOoeHOIDnN4HClJ4=;
        b=zaWTXJ1Mqd82X+tmnv12XPq3hxyyu4By1MXdGwPpUySolmMgtSvhmL/wVgEzyhdUh0
         i4mQV0q6MjVRSsQsTBFC5jbZWVuuSPviWv2dHr4ZShapM3JYr6p/g+hB8FQz97/Ficj/
         97MyQXZ103LiuFtNvpU4eenyJyKsgHMAW/FVQhwCdzvsC7/7mkV19v0yLE1XxeqFnnqw
         ybDXbjEbfkXqH3NZUVN9bZ80CFyFnknzrlZ7e63qcHLiIVQAKfF+yFHrepEvi/fYLiFC
         uabKoe536+uCsvjqPO/Zp2swd9Cb4nttFUB6tD6N9sNuXSozfLLddr+lhQ/EvNLib6Mb
         nzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712610760; x=1713215560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBrxiDN+ULxbnCCnTUMH5YTkPO5nOoeHOIDnN4HClJ4=;
        b=tZk9QwhmDwDBW2UDKPwG6I1hSfmg9Ls/WI3K3dhzrDgV4Z352XkFKiKv/c9dE+uJZ+
         9eLR0Ylvh+YexHGhxjes7550xJ8c7z+K2mGx4FUjB3Klpz5NlGWoItJXBqfh8JvjdToW
         MCEPhdGwXoRTNx1HaVzWKdKbn+xeW9mDi25gZBABVVZ3RqX6UgkWIFR6UJfkM0FER0Z3
         tGjWeqOIVLUYUzhUIg5eGvtsYJS5gzm5bzBIPRtYvtd+HVTeoDTgjjE8L9imJOPvUJpJ
         GXxBofLWzHvFxpASxUS39ZsHxAkPGl0ZQbN5gVAfpBIkGWUWdfkKEkDwBCK95sIdXZuf
         8Q7A==
X-Forwarded-Encrypted: i=1; AJvYcCVt5pSQtS/sn/mSqeFySfua5AgRx7XdE42pMVPOVFr3VjRKnL49WhubNsG0r2nKIw32LFlFqjnEMLB9yu2egOco1eAbOz37xTC+vB82
X-Gm-Message-State: AOJu0YzAwJ+mFjbRK2DysH0B8rsOw/mJJwy0nL+r9zC+lMwwLAWwGujA
	yHRdgO8eIsQV8Ug9VpHlcs9XQN7X5GQOeZ2Il52qxRoCF65WBpWGywCEBMllP/7ZO2xK3Egf8V3
	9PuWByRXZh6JKmYlHU+/FFWq6Ut6ZxJ5FCEF3Pw==
X-Google-Smtp-Source: AGHT+IGUtPs2bxn4LCc/SfMEak15ny1LfMS1EZP8voj+mW2yhz5Ps8Wmq7WrbyBNgcMmoOcdV4akQje6j/9yMTON+Vw=
X-Received: by 2002:a5b:c03:0:b0:dd1:2f58:6a2e with SMTP id
 f3-20020a5b0c03000000b00dd12f586a2emr8065386ybq.9.1712610760058; Mon, 08 Apr
 2024 14:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406031548.25829-1-quic_abhinavk@quicinc.com>
 <ale6wbwzkfagcg2q6glb4vsxu3pthhkk3tquv2ixlatbdryqvh@xscsq2h6emho> <01cb1c0d-a801-37f9-2f55-2bbd8d3a68b9@quicinc.com>
In-Reply-To: <01cb1c0d-a801-37f9-2f55-2bbd8d3a68b9@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 9 Apr 2024 00:12:28 +0300
Message-ID: <CAA8EJprzH0LiWNx9Udt6og3G063odY6ccvaAgsNS1r3zG8TmdA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: call dp_hpd_plug_handle()/unplug_handle()
 directly for external HPD
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, freedreno@lists.freedesktop.org, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	dri-devel@lists.freedesktop.org, seanpaul@chromium.org, swboyd@chromium.org, 
	quic_jesszhan@quicinc.com, quic_bjorande@quicinc.com, johan@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 22:43, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 4/7/2024 11:48 AM, Bjorn Andersson wrote:
> > On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
> >> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > [..]
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index d80f89581760..bfb6dfff27e8 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -1665,7 +1665,7 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
> >>              return;
> >>
> >>      if (!dp_display->link_ready && status == connector_status_connected)
> >> -            dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> >> +            dp_hpd_plug_handle(dp, 0);
> >
> > If I read the code correctly, and we get an external connect event
> > inbetween a previous disconnect and the related disable call, this
> > should result in a PLUG_INT being injected into the queue still.
> >
> > Will that not cause the same problem?
> >
> > Regards,
> > Bjorn
> >
>
> Yes, your observation is correct and I had asked the same question to
> kuogee before taking over this change and posting.

Should it then have the Co-developed-by trailers?

> We will have to handle that case separately. I don't have a good
> solution yet for it without requiring further rework or we drop the
> below snippet.
>
>          if (state == ST_DISCONNECT_PENDING) {
>                  /* wait until ST_DISCONNECTED */
>                  dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
>                  mutex_unlock(&dp->event_mutex);
>                  return 0;
>          }
>
> I will need sometime to address that use-case as I need to see if we can
> handle that better and then drop the the DISCONNECT_PENDING state to
> address this fully. But it needs more testing.
>
> But, we will need this patch anyway because without this we will not be
> able to fix even the most regular and commonly seen case of basic
> connect/disconnect receiving complementary events.

Hmm, no. We need to drop the HPD state machine, not to patch it. Once
the driver has proper detect() callback, there will be no
complementary events. That is a proper way to fix the code, not these
kinds of band-aids patches.

> >>      else if (dp_display->link_ready && status == connector_status_disconnected)
> >> -            dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> >> +            dp_hpd_unplug_handle(dp, 0);
> >>   }
> >> --
> >> 2.43.2
> >>



-- 
With best wishes
Dmitry

