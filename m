Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5077F35C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjKUSPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjKUSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:15:10 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4613193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:15:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00191363c1so280376966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700590502; x=1701195302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3jeSqyUsXuR0G429BNK/7gdoytWLHrpF12cSBcFFIQ=;
        b=JpuSryqdWS3kojgFyrDjtNfGRvYuLAmu6btqMswLLZ1Tm2wZkGK/PSCT+FB+dBHVd9
         +pyrjEee4u4qv5bb/t276w0xueaqCapfTr6EFA8b9Z6ppW4b2K2ofKhzyjzyNfGFwhdW
         /VTV7iMsfglDYgGt/iLAYfXBXH0DxHo4Vks6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700590502; x=1701195302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3jeSqyUsXuR0G429BNK/7gdoytWLHrpF12cSBcFFIQ=;
        b=r/IpwdWQEBtVHXskJm2Ucpsp6suJ5nr3v/iVELARteomsTiuZPjJAzLcqxrSKeWsFu
         M3AczqvBJOC7jN35c3jVVGbCScY8N8S8Ik8AxevdIeKMZbN1qgbgO0i9y9YMp0tdhc7K
         4a3zkQRFLqC4meBAtyCxlLh0H68m/8AL7GfEGS6/TOPmJS+bV29RHY58hb27x4E5uJf1
         POTiVtdQbnpUpoU44gRXHVWpBUVmWa4UrUCmEWfioBpkWqytMQHqSNjIuns6LVsi5uYw
         8kUamd7OOtd9wrE63RWCVM/1TK+/8TY1ekWv7sVWpl7uPFcdaW2/GSwQjX+o6hJ0q6MB
         Wy8w==
X-Gm-Message-State: AOJu0YzYQCYWSVR4UGyPVdBV0WlSODSQXnOYxxgUYU+AowLUgMmqeoOa
        dG11La4UPr3CsDjbejpZrDTh/tlwajXD4XQ7PDpnZ+U+
X-Google-Smtp-Source: AGHT+IHfC7gn2MRNkjn2il9R8QnxyoY53T9qcrrMxli6tD/ej8rj70o8BQkbFbhtr+KDg3FBIeKXHA==
X-Received: by 2002:a17:906:2253:b0:a00:4162:5d98 with SMTP id 19-20020a170906225300b00a0041625d98mr3487086ejr.19.1700590502000;
        Tue, 21 Nov 2023 10:15:02 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id k13-20020a170906158d00b009920e9a3a73sm5559886ejd.115.2023.11.21.10.15.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 10:15:01 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b2993e167so5575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:15:01 -0800 (PST)
X-Received: by 2002:a05:600c:1c1f:b0:3f4:fb7:48d4 with SMTP id
 j31-20020a05600c1c1f00b003f40fb748d4mr3601wms.3.1700590500881; Tue, 21 Nov
 2023 10:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20231120020109.3216343-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WKMrnAqYNHpcKw4=X75Ts_cCkoXZKQ+b7G1pXstUCMRg@mail.gmail.com>
In-Reply-To: <CAD=FV=WKMrnAqYNHpcKw4=X75Ts_cCkoXZKQ+b7G1pXstUCMRg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Nov 2023 10:14:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UxN9vgWM9e1n_1pqcOJqzhhVtE7H2h+XMf0o_Mo7Jz5g@mail.gmail.com>
Message-ID: <CAD=FV=UxN9vgWM9e1n_1pqcOJqzhhVtE7H2h+XMf0o_Mo7Jz5g@mail.gmail.com>
Subject: Re: [PATCH V3] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@google.com>, zhouruihai@huaqin.com,
        David Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 20, 2023 at 10:05=E2=80=AFAM Doug Anderson <dianders@google.com=
> wrote:
>
> Hi,
>
> On Sun, Nov 19, 2023 at 6:01=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The refresh reported by modetest is 60.46Hz, and the actual measurement
> > is 60.01Hz, which is outside the expected tolerance. Adjust hporch and
> > pixel clock to fix it. After repair, modetest and actual measurement we=
re
> > all 60.01Hz.
> >
> > Modetest refresh =3D Pixel CLK/ htotal* vtotal, but measurement frame r=
ate
> > is HS->LP cycle time(Vblanking). Measured frame rate is not only affect=
e
> > by Htotal/Vtotal/pixel clock, also affected by Lane-num/PixelBit/LineTi=
me
> > /DSI CLK. Assume that the DSI controller could not make the mode that w=
e
> > requested(presumably it's PLL couldn't generate the exact pixel clock?)=
.
> > If you use a different DSI controller, you may need to readjust these
> > parameters. Now this panel looks like it's only used by me on the MTK
> > platform, so let's change this set of parameters.
> >
> > Fixes: 1bc2ef065f13 ("drm/panel: Support for Starry-himax83102-j02 TDDI=
 MIPI-DSI panel")
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Chage since V2:
> >
> > - Update commit message.
> >
> > V2: https://lore.kernel.org/all/20231117032500.2923624-1-yangcong5@huaq=
in.corp-partner.google.com
> >
> > Chage since V1:
> >
> > - Update commit message.
> >
> > V1: https://lore.kernel.org/all/20231110094553.2361842-1-yangcong5@huaq=
in.corp-partner.google.com
> > ---
> >  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> As per previous discussions, this seems OK to me. I'll give it one
> more day for anyone to speak up and then plan to land it.

Pushed to drm-misc-fixes:

cea7008190ad drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
panel HFP and HBP
