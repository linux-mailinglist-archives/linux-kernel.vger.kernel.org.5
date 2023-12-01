Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A74800683
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377982AbjLAJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377855AbjLAJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:04:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F2128
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:04:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AB7C433C7;
        Fri,  1 Dec 2023 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701421479;
        bh=atyrbWt1APFwyakv3t85xJ2Im36Fb7nRp4IPSv5aSwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d2/GeTv5fmEHAm0HeO/YrJA1NnZg9OhpV5zCEMH+MHmVcDU6/Ef1MbZTT4rY1SqoV
         PH1Hk/oTngCJ4CyyMr0B/NdOU5A20BzceTolDt+CUrAQLpFjikE++aMXjnM/U5kMeR
         T5LRPEjX4u5EqcVOLq+x69c46Slxx72iplptDgL9f9+DstJn3+Mwe1Qpu6gIiQpabj
         Jf1nB526Rso2bqW+f6WuFCAB3CNt8SJBtauBpKWwIL5tQdg5IokVf7KeijskhJomxt
         gdREw3LJkAF6rmQwe2VlQtRna/bDC2y0n4Ph2/BbTM99iRatOycPHyl12Zof0TwtCy
         /8ZJ/oU+/LsSw==
MIME-Version: 1.0
Date:   Fri, 01 Dec 2023 10:04:33 +0100
From:   Michael Walle <mwalle@kernel.org>
To:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
In-Reply-To: <20231113164344.1612602-1-mwalle@kernel.org>
References: <20231113164344.1612602-1-mwalle@kernel.org>
Message-ID: <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The FORCE_STOP_STATE bit is unsuitable to force the DSI link into LP-11
> mode. It seems the bridge internally queues DSI packets and when the
> FORCE_STOP_STATE bit is cleared, they are sent in close succession
> without any useful timing (this also means that the DSI lanes won't go
> into LP-11 mode). The length of this gibberish varies between 1ms and
> 5ms. This sometimes breaks an attached bridge (TI SN65DSI84 in this
> case). In our case, the bridge will fail in about 1 per 500 reboots.
> 
> The FORCE_STOP_STATE handling was introduced to have the DSI lanes in
> LP-11 state during the .pre_enable phase. But as it turns out, none of
> this is needed at all. Between samsung_dsim_init() and
> samsung_dsim_set_display_enable() the lanes are already in LP-11 mode.
> The code as it was before commit 20c827683de0 ("drm: bridge:
> samsung-dsim: Fix init during host transfer") and 0c14d3130654 ("drm:
> bridge: samsung-dsim: Fix i.MX8M enable flow to meet spec") was correct
> in this regard.
> 
> This patch basically reverts both commits. It was tested on an i.MX8M
> SoC with an SN65DSI84 bridge. The signals were probed and the DSI
> packets were decoded during initialization and link start-up. After 
> this
> patch the first DSI packet on the link is a VSYNC packet and the timing
> is correct.
> 
> Command mode between .pre_enable and .enable was also briefly tested by
> a quick hack. There was no DSI link partner which would have responded,
> but it was made sure the DSI packet was send on the link. As a side
> note, the command mode seems to just work in HS mode. I couldn't find
> that the bridge will handle commands in LP mode.
> 
> Fixes: 20c827683de0 ("drm: bridge: samsung-dsim: Fix init during host 
> transfer")
> Fixes: 0c14d3130654 ("drm: bridge: samsung-dsim: Fix i.MX8M enable flow 
> to meet spec")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Let me know wether this should be two commits each reverting one, but 
> both
> commits appeared first in kernel 6.5.

Are there any news?

-michael
