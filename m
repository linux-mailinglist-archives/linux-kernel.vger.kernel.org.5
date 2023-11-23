Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8597F55E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjKWB2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWB2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:28:13 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33412A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:28:18 -0800 (PST)
Received: from i5e86192d.versanet.de ([94.134.25.45] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r5yVb-0005Lp-5S; Thu, 23 Nov 2023 02:27:59 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Jonker <jbx6244@gmail.com>,
        David Airlie <airlied@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: rk3066_hdmi: include drm/drm_atomic.h
Date:   Thu, 23 Nov 2023 02:27:57 +0100
Message-Id: <170070269347.1892155.2069947154071292981.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122221838.3164349-1-arnd@kernel.org>
References: <20231122221838.3164349-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 23:18:29 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without this header, the newly added code fails to build:
> 
> drivers/gpu/drm/rockchip/rk3066_hdmi.c: In function 'rk3066_hdmi_encoder_enable':
> drivers/gpu/drm/rockchip/rk3066_hdmi.c:397:22: error: implicit declaration of function 'drm_atomic_get_new_connector_state'; did you mean 'drm_atomic_helper_connector_reset'? [-Werror=implicit-function-declaration]
>   397 |         conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                      drm_atomic_helper_connector_reset
> drivers/gpu/drm/rockchip/rk3066_hdmi.c:397:20: error: assignment to 'struct drm_connector_state *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>   397 |         conn_state = drm_atomic_get_new_connector_state(state, &hdmi->connector);
>       |                    ^
> drivers/gpu/drm/rockchip/rk3066_hdmi.c:401:22: error: implicit declaration of function 'drm_atomic_get_new_crtc_state'; did you mean 'drm_atomic_helper_swap_state'? [-Werror=implicit-function-declaration]
>   401 |         crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                      drm_atomic_helper_swap_state
> drivers/gpu/drm/rockchip/rk3066_hdmi.c:401:20: error: assignment to 'struct drm_crtc_state *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>   401 |         crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
>       |                    ^
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: rk3066_hdmi: include drm/drm_atomic.h
      commit: f4814c20d14ca168382e8887c768f290e4a2a861

Very puzzling, I did testbuild with the atomic conversion in place
and also re-did it again to before applying this patch and didn't get
the mentioned error - not sure what I might have done differently to
create a dufferent reszkt,

In any case, I applied the fix.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
