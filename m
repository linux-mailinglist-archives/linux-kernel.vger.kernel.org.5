Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E267669C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjG1KET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjG1KDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D704535B6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9uBh6FMvfeDKYc8dvTUQUg/D36NNqMboTJZgEA5t70=;
        b=NhdTBWxS5zR1hpSMFz0ovjNKayFZuMdr9Ia+UJXS92OtxtnMCdsxoWcggPNmIPsvytudVs
        WCG+b/ggyLRvIW44zHMMoNAiZnbiTKmumvZF8CbEo7ibPVKNVFy+9sJr5jVsSs8hXMRTyv
        bJL0UN4PkKDt+6wUBDTtp7/9hpWsJp0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-kyJWvHp-NESdxCvq9yAY8g-1; Fri, 28 Jul 2023 06:03:09 -0400
X-MC-Unique: kyJWvHp-NESdxCvq9yAY8g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbab56aac7so10927145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538588; x=1691143388;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9uBh6FMvfeDKYc8dvTUQUg/D36NNqMboTJZgEA5t70=;
        b=IwMWffamBEWUsYsPaamP8zdGNyPj+WTgdODUykImJtF+/RtxMD3w2vAnBszu2IMkbs
         b+Mpy2spUjLzl4lxD2KBNrq8DOqfjsZY1ikJGY9UKc4vLWIr7eUb3Ql0pW7HM0xi/4FX
         jaXuM2eNjRhTjH/AtBqkH0vSFfKr2qrGnznODtcl6ps6TtGl5W3goB/giWpITKI1FG0U
         HTYIGN0cS4Bqq1PqYe5NgzGHuQZY0xC2dv8+bYOZb16Xg5SR/nMDTOMPHKPRsyQKj5uF
         TcfCu8N02uCTkMoH7u9RRZlXf4230pkSqZ97v0+1udY5NBpilsN7qAbmuq83QwRy4SjV
         e01g==
X-Gm-Message-State: ABy/qLbT9w4c6BVDuqn2SgpXz8X1k7NfHzco1t0WxA44n7x5vb30hfEO
        dhrMh3mxMy9S2FjMiLRSi25ibmwvXFSWaraJbJ++WZDrk2n0uNHRbwxBQXnDhj2S4ILnEXi0dGo
        WUubZJlonjX96Rd8PkcHbFGTk
X-Received: by 2002:a05:600c:20f:b0:3fe:785:ac0b with SMTP id 15-20020a05600c020f00b003fe0785ac0bmr1222138wmi.5.1690538588605;
        Fri, 28 Jul 2023 03:03:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHtdYABsrhIonVjfx9OTENY+L0T6vf82VlJ9iuT/7Og+9ZVj9h0aqYiRuknX63TfNx/AP5fxg==
X-Received: by 2002:a05:600c:20f:b0:3fe:785:ac0b with SMTP id 15-20020a05600c020f00b003fe0785ac0bmr1222130wmi.5.1690538588357;
        Fri, 28 Jul 2023 03:03:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c20d100b003fba6709c68sm3763721wmm.47.2023.07.28.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:03:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <e4142b7cc9aad9975de1bc6b1c7d86ccee487e4c.1690535997.git.geert+renesas@glider.be>
References: <e4142b7cc9aad9975de1bc6b1c7d86ccee487e4c.1690535997.git.geert+renesas@glider.be>
Date:   Fri, 28 Jul 2023 12:03:07 +0200
Message-ID: <87tttoxsis.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> If CONFIG_FB_CORE=y and CONFIG_FB=n, the frame buffer bootup logos can
> no longer be enabled.  Fix this by making CONFIG_LOGO depend on
> CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
> logo code to depend on the presence of real frame buffer device drivers.
>
> Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

