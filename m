Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79E7705D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjHDQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:23:45 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E10B2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:23:44 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4RHWHM5dTWz9s85;
        Fri,  4 Aug 2023 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1691166224; bh=yj/NtQVL/5pckzchWFeTqV07FxZmKDUAGX0wWU89jLg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NCgilNop9Fmhkvxn+SaUlEf4IcPR969tQfY/NxPfTpeYlhU9re0W85W8tGz0jZdBz
         QWCH8rX/oGS8W6bfV1m0hOByACYsFJ85AIZHvZ4pdlm1EwGhWOFfUz5aiXit/TsM3g
         vV6KmQSM2IQOdLFDBWpcg5Fd4KZibHxKKlLCq8k0=
X-Riseup-User-ID: CCB0F5F6610A68CF3473715B13107F061FAE88A70EC307CB023BB524DE7FFE5C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4RHWHH44MmzFpb1;
        Fri,  4 Aug 2023 16:23:39 +0000 (UTC)
Message-ID: <7950bcea-0f15-da2e-e4f7-4bfa474a420f@riseup.net>
Date:   Fri, 4 Aug 2023 13:23:36 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm: Drop select FRAMEBUFFER_CONSOLE for
 DRM_FBDEV_EMULATION
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20230804125156.1387542-1-javierm@redhat.com>
Content-Language: en-US
From:   Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <20230804125156.1387542-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/23 09:51, Javier Martinez Canillas wrote:
> The commit c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev
> emulation is enabled") changed DRM_FBDEV_EMULATION from 'depends on FB'
> to an effective 'select FB_CORE', so any config that previously had DRM=y
> and FB=n now has FB_CORE=y and FRAMEBUFFER_CONSOLE=y.
> 
> This leads to unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
> as reported by Arthur Grillo, e.g:
> 
> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>   Selected by [y]:
>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
> 
> Arnd Bergmann suggests to drop the select FRAMEBUFFER_CONSOLE for the
> DRM_FBDEV_EMULATION Kconfig symbol, since a possible use case could
> be to enable DRM fbdev emulation but without a framebuffer console.
> 
> Fixes: c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled")
> Reported-by: Arthur Grillo <arthurgrillo@riseup.net>
> Closes: https://lore.kernel.org/dri-devel/20230726220325.278976-1-arthurgrillo@riseup.net
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Greate patch! I was about to send the same one XD.

Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>

Best Regards,
~Arthur Grillo

> 
>  drivers/gpu/drm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index b51c6a141dfa..2a44b9419d4d 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -135,7 +135,6 @@ config DRM_DEBUG_MODESET_LOCK
>  config DRM_FBDEV_EMULATION
>  	bool "Enable legacy fbdev support for your modesetting driver"
>  	depends on DRM
> -	select FRAMEBUFFER_CONSOLE if !EXPERT
>  	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
>  	default y
>  	help
