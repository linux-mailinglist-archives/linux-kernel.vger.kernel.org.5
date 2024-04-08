Return-Path: <linux-kernel+bounces-134865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A15E89B808
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C501C21621
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E920319;
	Mon,  8 Apr 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVAOBaIw"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFB2B9BB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559356; cv=none; b=BzoYkH/Kd9NEvQyzcNC7lk2p+CR9fUXUolhZB0U5cWIZ6ny/Dtv6oVD1sIPNBG57YLFOU0f6o9mPXdX/ZNFbcVkusYQP9VIR++D0IqOtc62uQPpXVQcglS8HSBmiHZxwK/VJmslRDdHM3VKWhn2c+tXbmwgaHDqit+KudPHpmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559356; c=relaxed/simple;
	bh=KiL5NK1zEz9PbV0+Ph8O0V6ZiOSvtAFLDmRrhTbxNlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+MONJXbJQj5ur/R5NjkZagf+HIg04e5XCYFFqkoN5lK7V4gfcwUPKEn+lUmiQuCpQbBmmKObyo2nk/ZFCE0al2ZWe3T0v6XH8Hq9xe0Bvstavgrl9vWzZfvCT8RCuVULheftdLvRsUy7zJbQRcjY9fGqWBJ9HxgiLCOgUh7/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PVAOBaIw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-432f421c56bso21086311cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712559352; x=1713164152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiL5NK1zEz9PbV0+Ph8O0V6ZiOSvtAFLDmRrhTbxNlw=;
        b=PVAOBaIwGb9PPQq4280Zs2dqBAgZEVhToo8amcLTIcQBABb4AFguVqdsqvXdTevO7k
         UUk4jAiyiGkACdkdpwFxn+44V9S0NkuLIsA4rwO1qw17ZJ2tedWcAZX21rpiSp8fWyBD
         R47ZJW8X2itCVGHTCDxX91WylN3OBM6qS/PnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559352; x=1713164152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiL5NK1zEz9PbV0+Ph8O0V6ZiOSvtAFLDmRrhTbxNlw=;
        b=YQKrirwNpKL6/kefRamdkqNxK8zIHFhpQLDpVT/ZVbkcKg5DEYSXSrevdjUZ656nGJ
         7rKj28RFCNXEn/ZyRHHs8acVq2lMujSyiWHldnXeNarMc0tEPktqgEC7QBle+sk1XlH9
         IO2j8tfkUl+1by2S7QoeZiaRp0OHRAAzg/JZvm8E1R+rBnizuLysWv0WqdRBx2IPP5If
         WTk8BMGB4KLM4CtNtxH5cLEbFWH/YhG1kpOoL+1Ok5iYJPOXltpRl6CfEN4Gqe0wR+vA
         FBZ2O4ZIhlFM9npOaAGACX9PbfH2a4Icg6uK5/m3O58fHzTmZVRL8zh2qjiftZe1/BsB
         fZHA==
X-Forwarded-Encrypted: i=1; AJvYcCWSXIuV+7Co2JkGAMB7RiwHhL0J2NQzOIb4Nle6ROil9m5mGu3ds8ixU/uuCBxeJsGzezGRsCPKbq1gY4PLpodjLJXsl5Jhx0XQxIXP
X-Gm-Message-State: AOJu0Ywv8VXhLecFwWn0ZOBpLbqtJimA6XvzLYz+yWpw0k9LYHU7e2z/
	lfg6N0/z6yjW60sZOCitR6GmNPBFGv3WzWcXxNEJtBHxdGox16I2CXeWNJuEOI0HnWMiBB/Txad
	Ghg==
X-Google-Smtp-Source: AGHT+IESfmWpQAKynfp3mxOJySRJwP3SOrcG1XhRjwgzlsH209U78Z0zudAZJKL3n9phyMc+6fhW+A==
X-Received: by 2002:a05:622a:190a:b0:434:6652:7271 with SMTP id w10-20020a05622a190a00b0043466527271mr7362882qtc.56.1712559352191;
        Sun, 07 Apr 2024 23:55:52 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id kc13-20020a05622a44cd00b00433002038a2sm3424794qtb.44.2024.04.07.23.55.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:55:51 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4348110e888so193101cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 23:55:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRs+TtNAttnDu91Rvq97uqn/LiwvjwxCC3N6m06yCPAVlLAnS9aUy9hGaxRz/NwkydekEMo/Hg5xKHrSZUX2ErsmvYt4bSnZGGTl3R
X-Received: by 2002:a05:622a:40cc:b0:431:4e0b:d675 with SMTP id
 ch12-20020a05622a40cc00b004314e0bd675mr440115qtb.18.1712559350887; Sun, 07
 Apr 2024 23:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215631.3804796-1-dianders@chromium.org>
 <20240325145626.3.I552e8af0ddb1691cc0fe5d27ea3d8020e36f7006@changeid> <CAJMQK-iu6Z5kfEij1K8TdAxpCOoR3FL_gfRQMT2LS=e9o6C6qg@mail.gmail.com>
In-Reply-To: <CAJMQK-iu6Z5kfEij1K8TdAxpCOoR3FL_gfRQMT2LS=e9o6C6qg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 7 Apr 2024 23:55:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1MRRdeP36j3SF3Wrp+iwd5R9aUKHDSbp38Hg6Pni-aw@mail.gmail.com>
Message-ID: <CAD=FV=X1MRRdeP36j3SF3Wrp+iwd5R9aUKHDSbp38Hg6Pni-aw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm-panel: If drm_panel_dp_aux_backlight() fails,
 don't fail panel probe
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Pin-yen Lin <treapking@chromium.org>, 
	Prahlad Kilambi <prahladk@google.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 5:07=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Mon, Mar 25, 2024 at 2:57=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > If we're using the AUX channel for eDP backlight and it fails to probe
> > for some reason, let's _not_ fail the panel probe.
> >
> > At least one case where we could fail to init the backlight is because
> > of a dead or physically missing panel. As talked about in detail in
> > the earlier patch in this series, ("drm/panel-edp: If we fail to
> > powerup/get EDID, use conservative timings"), this can cause the
> > entire system's display pipeline to fail to come up and that's
> > non-ideal.
> >
> > If we fail to init the backlight for some transitory reason, we should
> > dig in and see if there's a way to fix this (perhaps retries?). Even
> > in that case, though, having a panel whose backlight is stuck at 100%
> > (the default, at least in the panel Samsung ATNA33XC20 I tested) is
> > better than having no panel at all.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Pushed to drm-misc-next:

b48ccb18e642 drm-panel: If drm_panel_dp_aux_backlight() fails, don't
fail panel probe

