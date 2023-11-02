Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4D17DF567
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjKBO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjKBO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:56:05 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FD187
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:56:03 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 53AC1207BF;
        Thu,  2 Nov 2023 15:56:01 +0100 (CET)
Date:   Thu, 2 Nov 2023 15:55:59 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 10/10] drm/tidss: Fix atomic_flush check
Message-ID: <ZUO4f/OjdYW4Paxu@francesco-nb.int.toradex.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
 <20231101-tidss-probe-v1-10-45149e0f9415@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-tidss-probe-v1-10-45149e0f9415@ideasonboard.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:17:47AM +0200, Tomi Valkeinen wrote:
> tidss_crtc_atomic_flush() checks if the crtc is enabled, and if not,
> returns immediately as there's no reason to do any register changes.
> 
> However, the code checks for 'crtc->state->enable', which does not
> reflect the actual HW state. We should instead look at the
> 'crtc->state->active' flag.
> 
> This causes the tidss_crtc_atomic_flush() to proceed with the flush even
> if the active state is false, which then causes us to hit the
> WARN_ON(!crtc->state->event) check.
> 
> Fix this by checking the active flag, and while at it, fix the related
> debug print which had "active" and "needs modeset" wrong way.

Candidate for stable? Add a Fixes tag?

Francesco

