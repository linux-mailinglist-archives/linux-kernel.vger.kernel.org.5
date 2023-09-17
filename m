Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A947A35E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjIQOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjIQOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:34:54 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4E127;
        Sun, 17 Sep 2023 07:34:48 -0700 (PDT)
Received: from [185.224.57.162] (helo=akair)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qhsr9-003tmW-OQ; Sun, 17 Sep 2023 16:34:39 +0200
Date:   Sun, 17 Sep 2023 16:34:35 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Tony Lindgren <tony@atomide.com>, airlied@gmail.com,
        daniel@ffwll.ch, u.kleine-koenig@pengutronix.de, arnd@arndb.de,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Message-ID: <20230917163435.6bc68110@akair>
In-Reply-To: <9efde4d8-385d-54da-fb0d-55625d3c4571@ideasonboard.com>
References: <20230913065911.1551166-1-andreas@kemnade.info>
        <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
        <20230913124828.GL5285@atomide.com>
        <9efde4d8-385d-54da-fb0d-55625d3c4571@ideasonboard.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 13 Sep 2023 15:58:11 +0300
schrieb Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>:

> On 13/09/2023 15:48, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [230913 12:11]:  
> >> I'm somewhat sure that the upstream driver used to work on omap4
> >> sdp, which has two DSI panels. But I can't even remember what
> >> omap4 version it had.  
> > 
> > I think those were both dsi command mode panels though, not video
> > mode?  
> 
> Yes, true. If the PLL is totally wrong due to refsel, I'm sure a
> command mode panel would also fail. But it's true that video mode
> panels are more sensitive to the clock rate.
> 
hmm, still analyzing:
What works:
  OMAP5 + Pyra (Videomode display requiring some init commands) 
  some command mode stuff with OMAP4 (droid4)
 
What does not work:
  OMAP4 with some dsi videomode to something else (LVDS/DPI) converter
       if init commands are sent through dsi, then these commands fail
       with bta sync problems.

So sending init commands to video mode displays seems not to be a
principal problem.
But looking deeper at the drivers, there seem to be commands sent
to the converters to configure lanes on that side, e.g.
tc358762_write(ctx, DSI_LANEENABLE,
                       LANEENABLE_L0EN | LANEENABLE_CLEN);

There might be trouble if these are not sent in low power mode.

So probably the next analyzing step would be to check if things
are really sent in low power mode.

Regards,
Andreas
