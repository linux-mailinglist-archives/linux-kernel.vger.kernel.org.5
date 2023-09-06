Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725AE793506
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjIFFrl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 01:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIFFrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:47:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C515DD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:47:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qdlNy-0003L2-Ug; Wed, 06 Sep 2023 07:47:30 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qdlNx-004MDD-Pt; Wed, 06 Sep 2023 07:47:29 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qdlNx-0002Fq-0r;
        Wed, 06 Sep 2023 07:47:29 +0200
Message-ID: <d56dfb568711b4b932edc9601010feda020c2c22.camel@pengutronix.de>
Subject: Re: [RFT PATCH 13/15] drm/imx/ipuv3: Call
 drm_atomic_helper_shutdown() at shutdown/unbind time
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Date:   Wed, 06 Sep 2023 07:47:29 +0200
In-Reply-To: <CAD=FV=WLw3cAU0nuNuKXiu=Zbv4tVa3aa35GFaxsjO880T0pmw@mail.gmail.com>
References: <20230901234202.566951-1-dianders@chromium.org>
         <20230901164111.RFT.13.I0a9940ff6f387d6acf4e71d8c7dbaff8c42e3aaa@changeid>
         <32186b941d6228a102b5e799aadf34206b58ac15.camel@pengutronix.de>
         <CAD=FV=WLw3cAU0nuNuKXiu=Zbv4tVa3aa35GFaxsjO880T0pmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Di, 2023-09-05 at 13:29 -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 4, 2023 at 1:30 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > 
> > On Fr, 2023-09-01 at 16:41 -0700, Douglas Anderson wrote:
> > > Based on grepping through the source code this driver appears to be
> > > missing a call to drm_atomic_helper_shutdown() at system shutdown time
> > > and at driver unbind time. Among other things, this means that if a
> > > panel is in use that it won't be cleanly powered off at system
> > > shutdown time.
> > > 
> > > The fact that we should call drm_atomic_helper_shutdown() in the case
> > > of OS shutdown/restart and at driver remove (or unbind) time comes
> > > straight out of the kernel doc "driver instance overview" in
> > > drm_drv.c.
> > > 
> > > A few notes about this fix:
> > > - When adding drm_atomic_helper_shutdown() to the unbind path, I added
> > >   it after drm_kms_helper_poll_fini() since that's when other drivers
> > >   seemed to have it.
> > > - Technically with a previous patch, ("drm/atomic-helper:
> > >   drm_atomic_helper_shutdown(NULL) should be a noop"), we don't
> > >   actually need to check to see if our "drm" pointer is NULL before
> > >   calling drm_atomic_helper_shutdown(). We'll leave the "if" test in,
> > >   though, so that this patch can land without any dependencies. It
> > >   could potentially be removed later.
> > > - This patch also makes sure to set the drvdata to NULL in the case of
> > >   bind errors to make sure that shutdown can't access freed data.
> > > 
> > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > 
> > Thank you,
> > Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Thanks! I notice that:
> 
> ./scripts/get_maintainer.pl --scm -f drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> 
> Doesn't say drm-misc but also when I look at the MAINTAINERS file and
> find the section for "DRM DRIVERS FOR FREESCALE IMX"

That should probably say "IMX5/6" nowadays. There are a lot more i.MX
that do not use IPUv3 than those that do.

> it doesn't explicitly list a different git tree.

I used to send pull requests from git.pengutronix.de/git/pza/linux,
same as for the reset controller framework. I might still have to do
that for changes in drivers/gpu/ipu-v3 that need coordination between
drm and v4l2, but usually pure drm/imx/ipuv3 changes are pushed to drm-
misc.

> I guess the "shawnguo" git tree listed by get_maintainer.pl is just
> from regex matching?

The "N: imx" pattern in "ARM/FREESCALE IMX / MXC ARM ARCHITECTURE", I
think.

> Would you expect this to go through drm-misc? If so, I'll probably
> land it sooner rather than later. I can also post up a patch making it
> obvious that "DRM DRIVERS FOR FREESCALE IMX" goes through drm-misc if
> you don't object.

Yes, both would be great.

regards
Philipp
