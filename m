Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085897D0443
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346628AbjJSV4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjJSV43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:56:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A7116
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:56:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c603e235d1so25326066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697752586; x=1698357386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvYs4y8luRIIMWCMTq8xHgd9BsFfOMy25z0twVyGFoo=;
        b=d4r/XsbiCMfoPmDIDVMZ5DBjZjDE2BqHG+5d3qSD3W6pGmqEEfLiv+Q/XTDSwc+3zT
         s5LNho0pV+AfN/IHOzDrwESiahRurhzzcarnT82xFKW0VOfY/IqphDDS0GTRTPmNNnl4
         z3XX5j93C1ul0ORlEkKLxD7swoMJueEljpjt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752586; x=1698357386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvYs4y8luRIIMWCMTq8xHgd9BsFfOMy25z0twVyGFoo=;
        b=HLTtZT18lupWsG9SMF3/lpDj6tzdgyidfkRKG9TKYTaedm3/xSnn86bGEbqW7b6olV
         ckS6DDqzrrrQB3BX4JFsRzgl86uVsGawuALklpUAdLXK3hnQ+gCg6FxkPCnAgd+p4Rbh
         DsQwqhACzRvFq2Ks2JDqX1K/ihE3h9ugjoVGc0yWXqT9hFphaal/B5+vsUOUk8QKZyyt
         6KEENAShpCPG+dcTGF5EA31Ab23nBW0i4g1xzwmXeGVZ3pnZAbjY5a2FjF6x2zCbdU9u
         Zz/VnEbJJeZvH817917HRDQvLlugkAcVQ9cReBlPA5YexEtRN8I0+zzvOso2Ed/AT25m
         IqkA==
X-Gm-Message-State: AOJu0YzhjhLKS7xNl3y0I2bQniVUObIzvG1kouk0UK3VClZLB7DKHzkn
        32FMlbdVh/MTzQMLrJdFIxqF7O2Tk9hqTEBgpHQ+XbXC
X-Google-Smtp-Source: AGHT+IHUBVqPZPBW/WzRcLxtMyf3pFUxMVgMC69k0Wckr5W4AviWQoVYRdCdtsR5SZl8iNPzoOsRoQ==
X-Received: by 2002:a17:907:72d0:b0:9bf:b5bc:6c50 with SMTP id du16-20020a17090772d000b009bfb5bc6c50mr2532105ejc.4.1697752586092;
        Thu, 19 Oct 2023 14:56:26 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709063b5000b0099c53c44083sm249510ejf.79.2023.10.19.14.56.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 14:56:26 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so1699a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:56:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1d:b0:3f7:3e85:36a with SMTP id
 m29-20020a05600c3b1d00b003f73e85036amr31430wms.7.1697752224208; Thu, 19 Oct
 2023 14:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091844.804310-1-yangcong5@huaqin.corp-partner.google.com>
 <20231013091844.804310-3-yangcong5@huaqin.corp-partner.google.com> <CAD=FV=UVP22ANJD5xEB6MRHCDjXN6SZhQWQshPxwhi51YRkEjQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UVP22ANJD5xEB6MRHCDjXN6SZhQWQshPxwhi51YRkEjQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 19 Oct 2023 14:50:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UV_yX=wBDMY1LhENfMYSbcZ=8xiCnQ6P3NXWdCHbn+zw@mail.gmail.com>
Message-ID: <CAD=FV=UV_yX=wBDMY1LhENfMYSbcZ=8xiCnQ6P3NXWdCHbn+zw@mail.gmail.com>
Subject: Re: [v4 2/3] drm/panel: ili9882t: Avoid blurred screen from fast sleep
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 13, 2023 at 2:43=E2=80=AFPM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Fri, Oct 13, 2023 at 2:19=E2=80=AFAM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > At present, we have found that there may be a problem of blurred
> > screen during fast sleep/resume. The direct cause of the blurred
> > screen is that the IC does not receive 0x28/0x10. Because of the
> > particularity of the IC, before the panel enters sleep hid must
> > stop scanning, as i2c_hid_core_suspend before ili9882t_disable.
> > If move the ili9882t_enter_sleep_mode function to ili9882t_unprepare,
> > touch reset will pull low before panel entersleep, which does not meet
> > the timing requirements.. So in order to solve this problem, the IC
> > can handle it through the exception mechanism when it cannot receive
> > 0x28/0x10 command. Handling exceptions requires a reset 50ms delay.
> > Refer to vendor detailed analysis [1].
> >
> > Ilitek vendor also suggested switching the page before entering sleep t=
o
> > avoid panel IC not receiving 0x28/0x10 command.
> >
> > Note: 0x28 is display off, 0x10 is sleep in.
> >
> > [1]: https://github.com/ILITEK-LoganLin/Document/tree/main/ILITEK_Power=
_Sequence
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
>
> As talked about in response to the previous version [1], we can work
> to see if we can improve the sequencing. However, for now this seems
> fine.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> [1] https://lore.kernel.org/r/CAD=3DFV=3DW_LT9mPYKjaKP3OvUDeNpsZxkhVN9NP_=
hQ+Es6Fe3dVw@mail.gmail.com

Pushed to drm-misc-next:

5820a1932ce8 drm/panel: ili9882t: Avoid blurred screen from fast sleep
