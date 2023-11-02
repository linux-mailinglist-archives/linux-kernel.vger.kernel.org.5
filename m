Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7800D7DF51E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjKBOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKBOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:34:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB013187
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:34:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99de884ad25so163403366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698935646; x=1699540446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgks7+Mrd9UjN3I3/bxrqGWTtSqcTUrWZCfSRhD5piA=;
        b=TzTyRA8J1+iC8+eacsN1uxeMm/8nInr5DvvAnvdj75RFOGCLg5rNGBrWBNW30ihFu1
         K0EZJrm1eV824GQ9wsD1x9zwy97FJv35zYT17Qld3e55v4reMLMCqFCOsJIcHpN7i4ke
         Zq92Bt0SxRgdDAaDrWPdoFmb6Hme6FQsviXg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935647; x=1699540447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgks7+Mrd9UjN3I3/bxrqGWTtSqcTUrWZCfSRhD5piA=;
        b=FA9uQ1/TB23LS6owHrrLeSXN1u9AyqrKYOZDTqcaDQWLplBGoRHM6SFT5tUQQ4XXdI
         iGh0V154ioAoXePakVbAsQhDQxq1Z3THWimEBMCit3AvZpt5pGoeb8aeL6kHb5HcwHyV
         mbskNffj1KU6i4BKrTx+dAooMWv5+HBvLA8LaPsBRoNQSlkCBWKvEE2XaZuJdEKA/ONt
         q/Gn3QS8kKO5Tg4K57QPmy/dYdueN47Mf9mzoPH42iFt8mi+kt1LCMkVikVBPjSYIJnK
         YR1U6EU/MOyZzc6poQkhhdu0PsT2AfNv0nejBvqDaaBvu1IYKfDtlHQEOcr/zs4r4uRR
         ZaOQ==
X-Gm-Message-State: AOJu0Yz3Zo+XwVUIWHhiTTp1TpFMNr24V5jKbDdX2SrxNsIvjendvXEp
        lArO9x8dRIt2KfOoUouBz3F27Yusr+O11f1bCCnFxw==
X-Google-Smtp-Source: AGHT+IHhWGfVtVY4grBKq0V0A2EFAYWCz+y+MzrHu4ue9Ftu/czKkBPDmssDDv7OKkf0TKsQtnyO3Q==
X-Received: by 2002:a17:906:52d7:b0:9bf:7bef:fc08 with SMTP id w23-20020a17090652d700b009bf7beffc08mr3502873ejn.56.1698935646566;
        Thu, 02 Nov 2023 07:34:06 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id t25-20020a508d59000000b00532eba07773sm2429373edt.25.2023.11.02.07.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:34:05 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so52575e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:34:05 -0700 (PDT)
X-Received: by 2002:a7b:c385:0:b0:400:c6de:6a20 with SMTP id
 s5-20020a7bc385000000b00400c6de6a20mr52452wmj.3.1698935645509; Thu, 02 Nov
 2023 07:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231101212604.1636517-1-hsinyi@chromium.org> <20231101212604.1636517-4-hsinyi@chromium.org>
 <CAA8EJpoPMkQRhCD-9SPSheiio1dH8V6BUv89MZKfZdrBzsBW-w@mail.gmail.com>
In-Reply-To: <CAA8EJpoPMkQRhCD-9SPSheiio1dH8V6BUv89MZKfZdrBzsBW-w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Nov 2023 07:33:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WHzCdiYumsxUm_am+ALqq9SOOrjf=JYHqJuiKFB+Dnsw@mail.gmail.com>
Message-ID: <CAD=FV=WHzCdiYumsxUm_am+ALqq9SOOrjf=JYHqJuiKFB+Dnsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 1, 2023 at 11:31=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 1 Nov 2023 at 23:26, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > If a non generic edp-panel is under aux-bus, the mode read from edid wo=
uld
> > still be selected as preferred and results in multiple preferred modes,
> > which is ambiguous.
> >
> > If a hard-coded mode is present, unset the preferred bit of the modes r=
ead
> > from edid.
>
> Can we skip the EDID completely if the hardcoded override is present?

Yeah, I wondered about that too. The blending of the hardcoded with
the EDID predates my involvement with the driver. You can see even as
of commit 280921de7241 ("drm/panel: Add simple panel support") that
the driver would start with the EDID modes (if it had them) and then
go onto add the hardcoded modes. At least for eDP panels, though,
nobody (or almost nobody?) actually provided panel-simple a DDC bus at
the same time it was given a hardcoded panel.

I guess I could go either way, but I have a slight bias to adding the
extra modes and just making it clear to userspace that none of them
are "preferred". That seems like it would give userspace the most
flexibility and also is closer to what we've historically done
(though, historically, we just allowed there to be more than one
"preferred" mode).

One thing we definitely want to do, though, is to still expose the
EDID to userspace even if we're using a hardcoded mode. I believe
that, at least on ChromeOS, there are some tools that look at the EDID
directly for some reason or another.


> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_modes.c       | 16 ++++++++++++++++
> >  drivers/gpu/drm/panel/panel-edp.c |  7 +++++--
> >  include/drm/drm_modes.h           |  1 +
> >  3 files changed, 22 insertions(+), 2 deletions(-)
>
> Anyway, this should be split into two patches. One for drm_modes.c,
> another one for the panel driver.

Yeah, that's probably a good idea.

-Doug
