Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D6A77A3B1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 00:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjHLWdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 18:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHLWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 18:33:52 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10D1985
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 15:33:54 -0700 (PDT)
Received: from i53875bbf.versanet.de ([83.135.91.191] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qUxB1-0002Ra-IZ; Sun, 13 Aug 2023 00:33:43 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>
Cc:     Mark Yao <markyao0591@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drm/rockchip: Fix crtc duplicate state and crtc reset
 funcs
Date:   Sun, 13 Aug 2023 00:33:42 +0200
Message-ID: <2475986.usQuhbGJ8B@diego>
In-Reply-To: <17046b61-5188-28e3-41fc-dad36d76584f@kwiboo.se>
References: <20230621223311.2239547-1-jonas@kwiboo.se>
 <17046b61-5188-28e3-41fc-dad36d76584f@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

Am Samstag, 12. August 2023, 16:18:05 CEST schrieb Jonas Karlman:
> Please consider reviewing and merging this series [2], and also [3].

during the last months my testfarm aquired some issues, I'm still
working on fixing, so my testing is way limited right now.

> drm/rockchip: Fix crtc duplicate state and crtc reset funcs
> [2] https://lore.kernel.org/all/20230621223311.2239547-1-jonas@kwiboo.se/

Though this one looked easy and when going through the code looked
quite right.


> drm/rockchip: vop: Add NV15, NV20 and NV30 support
> [3] https://lore.kernel.org/all/20230618220122.3911297-1-jonas@kwiboo.se/

I guess I need to track down someone on IRC to tell me if these new NVxx
types look correct, because I don't have too much clue about those drm-formats
yet. Hopefully I'll get to that on monday.


Heiko


> On 2023-06-22 00:33, Jonas Karlman wrote:
> > This series fixes a reset of state in duplicate state crtc funcs for VOP
> > driver, a possible crash and ensure crtc reset helper is called in VOP2
> > driver.
> > 
> > Patch 1 use kmemdup instead of kzalloc to duplicate the crtc state.
> > Patch 2 change to use crtc and plane cleanup helpers directly.
> > Patch 3 adds a null guard for allocation failure.
> > Patch 4 adds a crash guard for empty crtc state.
> > Patch 5 adds a missing call to crtc reset helper.
> > 
> > This is the next part of an ongoing effort to upstream HDMI 2.0 support
> > used in LibreELEC for the past 3+ years.
> > 
> > Changes in v2:
> > - Handle possible allocation failure in crtc reset funcs
> > - Collect r-b tags
> > 
> > This series is also available at [1].
> > 
> > [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20230621-duplicate-state
> > 
> > Jonas Karlman (5):
> >   drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs
> >   drm/rockchip: vop: Use cleanup helper directly as destroy funcs
> >   drm/rockchip: vop: Fix call to crtc reset helper
> >   drm/rockchip: vop2: Don't crash for invalid duplicate_state
> >   drm/rockchip: vop2: Add missing call to crtc reset helper
> > 
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c  | 24 +++++-------
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 39 ++++++++++----------
> >  2 files changed, 28 insertions(+), 35 deletions(-)
> > 
> 
> 




