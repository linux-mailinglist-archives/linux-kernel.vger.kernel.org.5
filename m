Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26D7E47B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjKGR6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjKGR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:58:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD9C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:58:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so906253866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699379885; x=1699984685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGXr30B7ae9S2k+FMAtadT8oxyML17udu5CvmGuW3q4=;
        b=aTdk1Y4kT+szYNQ4jfd1n7qzWbf/BYLqwbm31essGfJs2WtzaG0d5MtWStYPXnHgMm
         5YF3chh9ZtqLVDBJUyHR2ZoJ50c2gArnI6c9DbWfNVQUEKPc0WXh2GDvuDdVlhq9Z7Xt
         caVrVFMbzzNGzdInGnxsyEQe/GuYGmma2NCo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379885; x=1699984685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGXr30B7ae9S2k+FMAtadT8oxyML17udu5CvmGuW3q4=;
        b=BMNNJJ6j7IuEg+Y5hJt0fPtP07l0HXkqfTzdgrbMjqEViFLx4K8j6zl10jW7INzKyW
         ixvBmCN9cd6QRtLOdv6L+jdOM9mSoCzP8EPWcUZ8F+3mPzjzueIj4+fsFAxzXSy8ltLG
         +eXCdFSfhh2GG73LPUxCV5iFNFh1TQR37L5eeP/J8rP2Zs1+FidLh9o0CC9RAe7VwGVt
         netg5sdR9T0z240Xwn+rsv/1OrIMEehsgw/DtkbjoJqfJXh11pIbmD+i0LIFUIdwR93S
         WRuqEtikBjo/RfDRfxpgLxCCsxHshjobXFKtrWex5YfUWl2isAofVjBfUBUUQNXOCC6G
         LG3g==
X-Gm-Message-State: AOJu0YyEWDCRjUwm5z+GNVApWLNtMJSzYI4x5jMxFkhDMyo0omIXAA6u
        +YNv7VC9652vcEnWxhr3ZgBueK17GEnjQj8fBsE4/yHi
X-Google-Smtp-Source: AGHT+IFSxHUeDFw/3Gy2t6BSb9hGEk8NGfjamTskXc3KUzLKnOLQwzbnaoDynzAlLcOCctCsxsObaw==
X-Received: by 2002:a17:907:7254:b0:9bd:f3b0:c087 with SMTP id ds20-20020a170907725400b009bdf3b0c087mr17280229ejc.2.1699379885249;
        Tue, 07 Nov 2023 09:58:05 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id b25-20020a1709062b5900b009c3827134e5sm1290744ejg.117.2023.11.07.09.58.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:58:04 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so365a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:58:04 -0800 (PST)
X-Received: by 2002:a05:6402:5410:b0:545:2e6:cf63 with SMTP id
 ev16-20020a056402541000b0054502e6cf63mr60142edb.6.1699379884098; Tue, 07 Nov
 2023 09:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20231107000023.2928195-1-hsinyi@chromium.org> <20231107000023.2928195-5-hsinyi@chromium.org>
In-Reply-To: <20231107000023.2928195-5-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Nov 2023 09:57:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WpZt0MsQ3Yi01+hMmBgL7Z-S_+sjUipopM6qTQkgOY8g@mail.gmail.com>
Message-ID: <CAD=FV=WpZt0MsQ3Yi01+hMmBgL7Z-S_+sjUipopM6qTQkgOY8g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] drm/panel-edp: Avoid adding multiple preferred modes
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

On Mon, Nov 6, 2023 at 4:00=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> If a non generic edp-panel is under aux-bus, the mode read from edid woul=
d
> still be selected as preferred and results in multiple preferred modes,
> which is ambiguous.
>
> If both hard-coded mode and edid exists, only add mode from hard-coded.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v4->v5: remove inapplicable comments.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
