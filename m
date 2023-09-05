Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17D792FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjIEU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjIEU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:29:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077ACD1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:29:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so4146705a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693945754; x=1694550554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bpdw72cpSgmaX22+3FdeOvfo0LutgJ3/l7xm/56ifbU=;
        b=oM0C7dHDpFiNjhroGC1WDnI27GS4EAYt5ykUrN3jRv1+g5dh3eCf9S4w5ZzCrP0S8q
         JXDewCVmomSOFo3eOi9qlOvTxVSGrRosnotZkI+wcAF3VAzeqFGzlIT/hODcb9UrGoGh
         CAQZeA9GWv0FdVnR8hs2YOlNyWWIoE45ys6C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945754; x=1694550554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bpdw72cpSgmaX22+3FdeOvfo0LutgJ3/l7xm/56ifbU=;
        b=hSA4+0m6fH2SgkLExoyLfAwTqgNTvq0BQZtrCJ+oX1SjJ4rYkipw5T7VFRyG8FWXuR
         DOcYgtqS4Y2nnogFuP66WwSCbmCLD/UFkaUsQQuo8FtUUWfKcmHDefamxiLC8KR1OB9/
         VF3388mZMN5stWUjaZn+nT7wSl5Cbspoym6Qvc85ptftbCJGWUPw/OPm/Wghaj9YBiDl
         dAJRA6O+z0y50PVftPHaTgW/ccV/F98zEhAEVMFlItLo/JqeSIIIXKxiswfSh0Ne3Ho8
         wmnI4+FS/ZE88xOiTeEOdWbtbFrvOkEJRpqoIrxdEGpyrMp5SUsoCH6FGZLBWrO9oxRa
         T/3w==
X-Gm-Message-State: AOJu0YxrlZP1O3wC89gbqLgEvYkpIvx8GeYubeynSGNjXrU2GgTSLYXs
        WxOp2eIwNVfXsDkjfMqF2lNApt+Ez0DJHUQ6A+CbuAtQ
X-Google-Smtp-Source: AGHT+IG/bQdzgll4HRniVDsGfR3Ngcju3Nlrvu0VyRJhEtKi6hymPK3a9Rvh18OND1ijjVGFjaOY/A==
X-Received: by 2002:a17:906:cc1:b0:9a5:b875:d76 with SMTP id l1-20020a1709060cc100b009a5b8750d76mr623734ejh.28.1693945754189;
        Tue, 05 Sep 2023 13:29:14 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b0099b8234a9fesm7983329eju.1.2023.09.05.13.29.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:29:14 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso5135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:29:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1d28:b0:401:a494:2bbb with SMTP id
 l40-20020a05600c1d2800b00401a4942bbbmr6526wms.5.1693945753084; Tue, 05 Sep
 2023 13:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.13.I0a9940ff6f387d6acf4e71d8c7dbaff8c42e3aaa@changeid> <32186b941d6228a102b5e799aadf34206b58ac15.camel@pengutronix.de>
In-Reply-To: <32186b941d6228a102b5e799aadf34206b58ac15.camel@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Sep 2023 13:29:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLw3cAU0nuNuKXiu=Zbv4tVa3aa35GFaxsjO880T0pmw@mail.gmail.com>
Message-ID: <CAD=FV=WLw3cAU0nuNuKXiu=Zbv4tVa3aa35GFaxsjO880T0pmw@mail.gmail.com>
Subject: Re: [RFT PATCH 13/15] drm/imx/ipuv3: Call drm_atomic_helper_shutdown()
 at shutdown/unbind time
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 4, 2023 at 1:30=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix.d=
e> wrote:
>
> On Fr, 2023-09-01 at 16:41 -0700, Douglas Anderson wrote:
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown time
> > and at driver unbind time. Among other things, this means that if a
> > panel is in use that it won't be cleanly powered off at system
> > shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart and at driver remove (or unbind) time comes
> > straight out of the kernel doc "driver instance overview" in
> > drm_drv.c.
> >
> > A few notes about this fix:
> > - When adding drm_atomic_helper_shutdown() to the unbind path, I added
> >   it after drm_kms_helper_poll_fini() since that's when other drivers
> >   seemed to have it.
> > - Technically with a previous patch, ("drm/atomic-helper:
> >   drm_atomic_helper_shutdown(NULL) should be a noop"), we don't
> >   actually need to check to see if our "drm" pointer is NULL before
> >   calling drm_atomic_helper_shutdown(). We'll leave the "if" test in,
> >   though, so that this patch can land without any dependencies. It
> >   could potentially be removed later.
> > - This patch also makes sure to set the drvdata to NULL in the case of
> >   bind errors to make sure that shutdown can't access freed data.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Thank you,
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks! I notice that:

./scripts/get_maintainer.pl --scm -f drivers/gpu/drm/imx/ipuv3/imx-drm-core=
.c

Doesn't say drm-misc but also when I look at the MAINTAINERS file and
find the section for "DRM DRIVERS FOR FREESCALE IMX" it doesn't
explicitly list a different git tree. I guess the "shawnguo" git tree
listed by get_maintainer.pl is just from regex matching?

Would you expect this to go through drm-misc? If so, I'll probably
land it sooner rather than later. I can also post up a patch making it
obvious that "DRM DRIVERS FOR FREESCALE IMX" goes through drm-misc if
you don't object.

Thanks!

-Doug
