Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99097E75D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjKJASH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345472AbjKJASD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:18:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66361FEA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:18:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso2383554a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699575477; x=1700180277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86AHDKme0oU/mK4LbTg0+f9o2KRKUMP2vouZ/vFV6kM=;
        b=IQwtUnPbH2dCJHaknEejGptQ1BrzOJNm/eryRxrywR+D9MVkUh7P/ZD8NNBed4KlqR
         Uk7POfRVnVh6y3joQm2G9Hrf7x/e/0/OdrVrDDlD0YN1CTep7+RQZPWMIntzKpUUzgif
         cNWJr76nfo5gYZlOvwm0x8SkIsXxkKy0tw5GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575477; x=1700180277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86AHDKme0oU/mK4LbTg0+f9o2KRKUMP2vouZ/vFV6kM=;
        b=LNSffIrv0qL8rkyjpNUW0UzaUTMHiBnwB021kC9vOsBvdBEWQHSkH+T2MKlFTDW7BQ
         b5Fj+e9ZEZD1DkcYze1U4bitM/SHD8ytT9FdbwljnODNHWyskbVhALzaNCqCNGuXaHTk
         QOF5lzlO/QtvliYl8KOF4Z9fb14CNZZrtIOOBhLnnvAn7M1HvRK3UvlTd8+Wy+dq2GxE
         t+zIOGZRtpDRlAa/mDwJS8VT/IxVgKA7eNR5ibbcnCwUQRYhNa44Typ3J6cJrNWrUMNe
         Q1GqhEVjMccPyV0Yg33Ou7qKgXS+gjd5N2YMUdk9UcAszMwaL+L83FGVg3RWPvR3clYl
         py9A==
X-Gm-Message-State: AOJu0Yxw6d4j17oudAf/AlE8mtNPcGgYQKlPjimjIGvX1ZCqw0cLBwLl
        R9/kCddHP3/mynL8NVp/sLjo7L8MaWI97bmZua8djQ==
X-Google-Smtp-Source: AGHT+IFkWUnmTqiYi97tonyTRWSC0265Ck3Kic/ZGWps2evTfI1BiNmveO33gxaaT1IFycCXUCK2iw==
X-Received: by 2002:a17:907:e88:b0:9ae:588e:142 with SMTP id ho8-20020a1709070e8800b009ae588e0142mr6140144ejc.67.1699575475831;
        Thu, 09 Nov 2023 16:17:55 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id lf18-20020a170906ae5200b0098d2d219649sm3222335ejb.174.2023.11.09.16.17.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 16:17:55 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so115355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:17:54 -0800 (PST)
X-Received: by 2002:a05:600c:2195:b0:404:74f8:f47c with SMTP id
 e21-20020a05600c219500b0040474f8f47cmr277112wme.5.1699575474598; Thu, 09 Nov
 2023 16:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-2-hsinyi@chromium.org>
In-Reply-To: <20231107204611.3082200-2-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Nov 2023 16:17:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UDWNhuBPBUWJNa9E7njYwxJ=zsGqMb=u5CkDGs5UkHzw@mail.gmail.com>
Message-ID: <CAD=FV=UDWNhuBPBUWJNa9E7njYwxJ=zsGqMb=u5CkDGs5UkHzw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01
 name and timing
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 7, 2023 at 12:46=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
> auo_b116xak01: T3=3D200, T12=3D500, T7_max =3D 50 according to decoding e=
did
> and datasheet.
>
> Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v5->v6: split to 2 patches.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Even though this is a fix, it's not super urgent since it'll cause
conflicts with other changes, so pushed to drm-misc-next rather than
drm-misc-fixes.

fc6e76792965 drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timin=
g
