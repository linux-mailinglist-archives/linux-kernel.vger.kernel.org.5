Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66E87A999D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjIUSQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjIUSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:16:24 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28F8D720F1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:33:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9C055809E;
        Thu, 21 Sep 2023 11:35:46 +0000 (UTC)
Date:   Thu, 21 Sep 2023 14:35:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/mipi-dsi: Fix detach call without attach
Message-ID: <20230921113545.GR5285@atomide.com>
References: <20230921-dsi-detach-fix-v1-1-d0de2d1621d9@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-dsi-detach-fix-v1-1-d0de2d1621d9@ideasonboard.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [230921 10:51]:
> mipi_dsi_host_unregister() will call two functions for all its DSI
> peripheral devices: mipi_dsi_detach() and mipi_dsi_device_unregister().
> The latter makes sense, as the device exists, but the former may be
> wrong as attach has not necessarily been done.
> 
> To fix this, track the attached state of the peripheral, and only detach
> from mipi_dsi_host_unregister() if the peripheral was attached.
> 
> Note that I have only tested this with a board with an i2c DSI
> peripheral, not with a "pure" DSI peripheral.

Thanks this fixes the deferred probe warning I've been seeing:

Tested-by: Tony Lindgren <tony@atomide.com>
