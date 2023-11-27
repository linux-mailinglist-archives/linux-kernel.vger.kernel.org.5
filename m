Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9307FAEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjK0Xwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0Xwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:52:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781BE4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:52:39 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2212FBEB;
        Tue, 28 Nov 2023 00:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701129123;
        bh=C9lSmPriSk8Tc76cOcwMIOxTOOqylhc2gUk3ucAQ1V4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FD3b28vcSL8lSle4SioXsQNDO1puHVgNTsJSvh2CBllaDucwh/EdrVLjzbWgnHxan
         IbFEd6Ph5h9FqGiFahdXCOuDohY8kV8FvsSQKKQZCeWiMEhtY6YmJ72Y5fmSTvrlDK
         sXNILFju6nh5WtQ9jCg7n29JWh1Tpe3SPZwBJ3ps=
Date:   Tue, 28 Nov 2023 01:52:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/3] Revert panel fixes and original buggy patch
Message-ID: <20231127235244.GD31314@pendragon.ideasonboard.com>
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <20231127232542.GB25590@pendragon.ideasonboard.com>
 <CACRpkdYWjHbgWQc46hGM3bg+5nf4NiveEZJmHrnx0X-=XsUDLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYWjHbgWQc46hGM3bg+5nf4NiveEZJmHrnx0X-=XsUDLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:36:15AM +0100, Linus Walleij wrote:
> On Tue, Nov 28, 2023 at 12:25 AM Laurent Pinchart wrote:
> > On Tue, Nov 28, 2023 at 12:10:18AM +0100, Linus Walleij wrote:
> > > This series reverts the attempts to fix the bug that went
> > > into v6.7-rc1 in commit 199cf07ebd2b
> > > "drm/bridge: panel: Add a device link between drm device and panel device"
> > > and then it reverts that patch as well.
> > >
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > > Linus Walleij (3):
> > >       Revert "driver core: Export device_is_dependent() to modules"
> > >       Revert "drm/bridge: panel: Check device dependency before managing device link"
> > >       Revert "drm/bridge: panel: Add a device link between drm device and panel device"
> >
> > To preserve bisectability, you should revert in the opposite order.
> 
> You mean apply patch 2, then 1, then 3 so the kernel builds after each
> revert?
> 
> Yeah that's a good idea, I don't know if I should apply these though, better
> someone else do it since I screwed up too much.
> 
> Another option is to just squash the reverts into one, that bisects too :/

I thought the commits have been applied to drm-misc in a bisectable
order in the first place, but that doesn't seem to be the case :-(
Reverting "driver core: Export device_is_dependent() to modules" last
seems to be the best option in this case. I wouldn't squash them.

-- 
Regards,

Laurent Pinchart
