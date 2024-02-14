Return-Path: <linux-kernel+bounces-65875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A38C855326
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569E22938DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F913AA5E;
	Wed, 14 Feb 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmG5T9yC"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EC134738
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938431; cv=none; b=qdgKtJF2rKhG08oLKySx02A91IQDXTAqO8y87n0+V+ucdZyMYOEF9/nodAYZbOgfzt7zU5wGh2atPpcAmNpGj0td2KEbjyvUXKH6ed7jpsy3ip3FFEhXPLrxGRO6lChtVV9MeI+2SUjSoq70YPNmdDUmo1TSCTT0MCnLBmwW6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938431; c=relaxed/simple;
	bh=ywy9whWYwZRcUvzsB2Kq9UU/4CXmTdpich4QQ2qzTD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8Gozsr1WBEj4UbpoSNbq60PHsXfhR2WlwDvegWkO8oTjlNjEkymaLqJ55+MafoZQswOemCgXT0W3DRkie6xRlQMPpiFxRXovo81AyCS8DQpgYcuP+HjCNAinD7TTkeOrgL/jfSJoqFPRkTbgNSGD3VfUTPrVXA1tScwMGqcbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RmG5T9yC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so25189276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707938427; x=1708543227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B73bS06AIkXzjnqoVP2qP94tAmB+abCne/7xyPl1XbQ=;
        b=RmG5T9yChCDZyZ1L9ta8EteYXxkmXUaHqLqIl88lhsNgM/tVzS6vXlTlh847er1aF6
         pydVXHYKYRQ9wcEhjXe+gYJUjHgIABYeSAMgWbMA2jHK87ZBMNZDrwLMSSDfdmnMGubF
         Kqpc84LUSHyt3hUvQ1ePV4aZyNqsRA0o9PMxxHINxjv8Sy+oHakNKKDuR8fietc+BlMa
         KcVk4DguRYs1rPCitMv3hkqc4UFB4dJzJHKOGQmkX2nhBznOOheGFCR3nxCrqU1cjqAz
         lAib9ruN1NPyDUK6+4yYBAhnH/b5JOr4s+24lnT3zNslvAUJ2keZQONwiPNJxWX2EppR
         wgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938427; x=1708543227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B73bS06AIkXzjnqoVP2qP94tAmB+abCne/7xyPl1XbQ=;
        b=cxt9EbhGKdescSAprZM+YQoJNbCe0kagjkCyeTqhLW4PAapXt8rkAjU8gokC5QE51j
         aX+0dmw0itwhjNKNYQzLB+lunTuhmrjMFSS6pWE27hRgUgzLDdaEYVxwnufwMKCR7kPg
         bI6O2k7kwLekkQZZC+TjZExVWkYaU6nnCmoQpFgiimCetWxNgUgZRC6vmcHF+G1p+5eW
         K8uPFhXeVIMvb7sWn8JpSy9IQPpIJGqoFcbgNiX/SHIzbeddO7KTCLtiqw5Qjw+POZ4N
         jmXIJd+7vwV4bqARDw1hb8UDODySIk6oTmnww/9izLeVp+ydUZWMPMe60TI7xv1SPg0z
         kkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO6q9L7mMy3yw3M99ThIQxj+C2MACyQyKQWCBKSnDFdvu/O8gbSB894mH5dQGzQtTQIxXK50MkA+zDMmfoMyKrqyZE4zsOTR3aqLjZ
X-Gm-Message-State: AOJu0YzAdIEut2WOYmsZvXYSdgwklJmXhyFd5vdDO/ayDahS1u5dfxAL
	n17FcZ8RjU7IKRa41kvF0AtjhYBl2fVaXwnwmw7YzNSjIRQea76J8k5MtfUZSmkkCagB4H5vVjv
	1LadZhVTy/Dre+ouavBBtHq5bxUT3O5vh83723w==
X-Google-Smtp-Source: AGHT+IE9s7xRxFgyDDO/OOi6qfcHjatwcC09w9tCG2wbS1m6yq9DQHisEE7YMYJmWehqqbTOKLKef79RBRk0hbjJOXU=
X-Received: by 2002:a25:4156:0:b0:dbd:5bfa:9681 with SMTP id
 o83-20020a254156000000b00dbd5bfa9681mr3218536yba.37.1707938427173; Wed, 14
 Feb 2024 11:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org> <1cb90bff-ce5b-c6d1-a3df-24f6306f833a@quicinc.com>
In-Reply-To: <1cb90bff-ce5b-c6d1-a3df-24f6306f833a@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 14 Feb 2024 21:20:16 +0200
Message-ID: <CAA8EJpotiHKT_NYphDs0-vhpvsybgTW281XDYbteUx8qOX=v4g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: make "vblank timeout" more useful
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 20:02, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/8/2024 6:50 AM, Dmitry Baryshkov wrote:
> > We have several reports of vblank timeout messages. However after some
> > debugging it was found that there might be different causes to that.
> > To allow us to identify the DPU block that gets stuck, include the
> > actual CTL_FLUSH value into the timeout message and trigger the devcore
> > snapshot capture.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Changes in v2:
> > - Added a call to msm_disp_snapshot_state() to trigger devcore dump
> >    (Abhinav)
> > - Link to v1: https://lore.kernel.org/r/20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index d0f56c5c4cce..a8d6165b3c0a 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -489,7 +489,8 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
> >               (hw_ctl->ops.get_flush_register(hw_ctl) == 0),
> >               msecs_to_jiffies(50));
> >       if (ret <= 0) {
> > -             DPU_ERROR("vblank timeout\n");
> > +             DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
> > +             msm_disp_snapshot_state(phys_enc->parent->dev);
>
>
> There is no rate limiting in this piece of code unfortunately. So this
> will flood the number of snapshots.

Well... Yes and no. The devcoredump will destroy other snapshots if
there is a pending one. So only the console will be flooded and only
in case when MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE is enabled.

>
> Short-term solution is you can go with a vblank_timeout_cnt and reset it
> in the enable() like other similar error counters.
>
> long-term solution is we need to centralize these error locations to one
> single dpu_encoder_error_handler() with a single counter and the error
> handler will print out the error code along with the snapshot instead of
> the snapshot being called from all over the place.
>
>
>
> >               return -ETIMEDOUT;
> >       }
> >
> >
> > ---
> > base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> > change-id: 20240106-fd-dpu-debug-timeout-e917f0bc8063
> >
> > Best regards,



-- 
With best wishes
Dmitry

