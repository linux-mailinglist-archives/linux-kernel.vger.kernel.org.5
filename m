Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D53C778FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHKMra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHKMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31D26A0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E440660FF2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6BBC433C7;
        Fri, 11 Aug 2023 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691758047;
        bh=GE7ZMP9v/gDUOwzKlfXTMDj+6ZkOrPLgpFbs/jrO4HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEiUHu10rdaKXu9a1csq8PosycxnnY1CC1EwVZ4R9Fn2K8Ae044Rk/yNt1WHhh03P
         c81mDwaFUdgg21jG+1q+12fo5VkbbWzEotn8+646VtzOXw8HvBvVJFjnPjgeYls4W0
         fZH/NV0V6yDrr87HG/gLtcxAn4KCzDNwtncpLW7AwnusqNtQaGrYj/HHU7dUwXFUAB
         V0A3K2os/9vo+2uc4Opjg+ZQKizvPo4CRulsbvNmK+UgIQKTC+6Ahsp8h7UzxMYnnl
         q+fkBoe6tjEETMohgAS5pOM2Zfb0sMlOEjV5B4A1fE6VROmrI3uMm367lWg76/ICSJ
         dVwKbtgnthFQw==
From:   Robert Foss <rfoss@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Robert Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Adam Ford <aford173@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org,
        Aleksandr Nogikh <nogikh@google.com>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: bridge: for GENERIC_PHY_MIPI_DPHY also select GENERIC_PHY
Date:   Fri, 11 Aug 2023 14:47:12 +0200
Message-ID: <169175799304.286760.13826671365637873464.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804030140.21395-1-rdunlap@infradead.org>
References: <20230804030140.21395-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 20:01:37 -0700, Randy Dunlap wrote:
> Three DRM bridge drivers select GENERIC_PHY_MIPI_DPHY when GENERIC_PHY
> might not be set.  This causes Kconfig warnings and a build error.
> 
> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
>   Depends on [n]: GENERIC_PHY [=n]
>   Selected by [y]:
>   - DRM_NWL_MIPI_DSI [=y] && DRM_BRIDGE [=y] && DRM [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
>   - DRM_SAMSUNG_DSIM [=y] && DRM [=y] && DRM_BRIDGE [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
> 
> [...]

Applied, thanks!

[1/1] drm: bridge: for GENERIC_PHY_MIPI_DPHY also select GENERIC_PHY
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=96413b355a49



Rob

