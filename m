Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04197C4C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjJKIAM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjJKIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:00:09 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F792
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:00:08 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7e5dc8573so2427487b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011207; x=1697616007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJXeUKTthXt8M2vbMgjrZC204wLHYXruTCm+pLMNj8I=;
        b=LtDvy5Mk8Kij/g35IWi++/anwf7xKojh1HE/XP/k0+ZJF0EoWpBmnEkdC2n9dHXA5g
         ldyk5rYVQmUGqSNxi1nwS6fGg1EcTdk8OIHI5/u6oSHI59gentAAnta5aroUSISwvBc0
         5m/X7QbfAGBswoefe6douLJPJB7uAcSqi1zhbe7FkRLzlTz5A+Kl2nELWVtzxxp4hZJn
         NS8024hw9DZK5r3bcmL84+iI4C9m4c4X6zzdyfhca/j4tog7bKtm4dsHbWgnRa09CtLE
         IvvjxKTtILFhj2xW3KCH0A5zwGtSzQwHDK3/dbq7O57GI4prl77nOGZ20jnHibOMal1m
         i0Dw==
X-Gm-Message-State: AOJu0Yz/iscqaBtfaNz4b1hl8fl1VM1Gx6eOJ72XnCPK2Eslr9w26RCx
        4lRvK72u+/TJaUP399MGjDtBcwOFGthBBA==
X-Google-Smtp-Source: AGHT+IGBA2+kUMjCNbhYyemijwavBfHA3mnkuE9eU7gQR75Y9i5TbVxDPf1sKo1fCr2CkrnLz7XGlg==
X-Received: by 2002:a81:d54b:0:b0:59b:cfe1:bcf1 with SMTP id l11-20020a81d54b000000b0059bcfe1bcf1mr20392540ywj.44.1697011207555;
        Wed, 11 Oct 2023 01:00:07 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id d184-20020a0ddbc1000000b00586108dd8f5sm4971955ywe.18.2023.10.11.01.00.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:00:07 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59f6441215dso80974827b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:00:07 -0700 (PDT)
X-Received: by 2002:a81:5bd5:0:b0:589:f9f0:2e8c with SMTP id
 p204-20020a815bd5000000b00589f9f02e8cmr20463475ywb.48.1697011207007; Wed, 11
 Oct 2023 01:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231009183522.543918-1-javierm@redhat.com> <20231009183522.543918-5-javierm@redhat.com>
In-Reply-To: <20231009183522.543918-5-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Oct 2023 09:59:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmzUx6iOhSSfNz4NyMZ0vY6Md6cn86S0BjOjhzzPuO=g@mail.gmail.com>
Message-ID: <CAMuHMdWmzUx6iOhSSfNz4NyMZ0vY6Md6cn86S0BjOjhzzPuO=g@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/ssd13xx: Use drm_format_info_min_pitch() to
 calculate the dest_pitch
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Mon, Oct 9, 2023 at 8:36 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Don't assume bpp of 1 and instead compute the destination pitch using the
> intermediate buffer pixel format info when doing a format conversion.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/drivers/gpu/drm/solomon/ssd13xx.c
> +++ b/drivers/gpu/drm/solomon/ssd13xx.c
> @@ -148,6 +148,8 @@ struct ssd13xx_plane_state {
>         struct drm_shadow_plane_state base;
>         /* Intermediate buffer to convert pixels from XRGB8888 to HW format */
>         u8 *buffer;
> +       /* Pixel format info for the intermediate buffer */
> +       const struct drm_format_info *fi;

This is really intermediate, as it is removed again in the next patch :-)

In fact 60% of this patch is changed again in the next patch.
So perhaps combine this with the next patch?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
