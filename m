Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08A2763960
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjGZOkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGZOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410151990
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hJ4X5tXzpgqm5zrMMPo7T0DqV+ewqF/OMUcgOVIHXI=;
        b=QNmGOdOrQb0iD5Hp3LARZjEE6L19gA9ZIwzjL7tShATOsqHAztmkLOqjGp120ugRN7Jqum
        ii4ZG7vlDuCvsqnlKto7aoivg6O5tSnAtAD6PVMsOnq52Fep4yl08lqCsCMY2SKlHL6zv7
        fgEJdRrYf6gxRwGTwmk4of0X17XzhPU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-_79xWjZXNHykqw204n1CCw-1; Wed, 26 Jul 2023 10:39:14 -0400
X-MC-Unique: _79xWjZXNHykqw204n1CCw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbdd5d09b8so42291715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382353; x=1690987153;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hJ4X5tXzpgqm5zrMMPo7T0DqV+ewqF/OMUcgOVIHXI=;
        b=AnASYucgrNpI8C2uZLhAEMulWh9t/dW3p3ng9KoudwEQgRprtyqbkC1NuKR+PWpdrq
         T3xo0s78TA4D/3+TZk/eDKlkIpWF3AM4uWxh52IfhDXrrvQd/i/GzJKz7VfG5d9zzst8
         UmpcM4Wd38hETWCQZfg8g03+M/h/j/5i6F1Tsj5vBU6UVEMIVyd/1J8ifdUkFDngzqX/
         gOa17ujglBH3IDtuJEnKuMVEM0vXk2+DKjr0NS3FuDJdWTpqRD9futQIVswNi5X0mbYt
         Nfgfc54XdUDuYBhPkN5h3I5miwXAldjpbAFJB4iOta+VA2UTIefnFkrhbsMyiZdZa9OX
         AJlg==
X-Gm-Message-State: ABy/qLZTtohI4rUIwi0JkKgrI1oeAFOTmohLD9kHXcSxl4Wu1r8Ww/MT
        mDR2SlA8EsBC6Xb6E8S8anreMGK8GoqTONbX4PsRB/RzSnoAPHMOTyqybdqJmD3f4wDrE0QK+I0
        S0C1cjuEYFI1skPlgwG75mOszv5Lt169wD6j9K1pE6e0Lyi8rAfWAwP/3DLxW9XxE3w4hc2gcH1
        Ma/PwnWOIh
X-Received: by 2002:a05:600c:2053:b0:3fb:b2c0:fcec with SMTP id p19-20020a05600c205300b003fbb2c0fcecmr1629759wmg.24.1690382352862;
        Wed, 26 Jul 2023 07:39:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE6E1rZwubPg+oeFHipdkapvGzS/9I+KS1V3vVd0VaboFbD1hvdWcCF63EI8Mqn4lM80eI4Kw==
X-Received: by 2002:a05:600c:2053:b0:3fb:b2c0:fcec with SMTP id p19-20020a05600c205300b003fbb2c0fcecmr1629738wmg.24.1690382352559;
        Wed, 26 Jul 2023 07:39:12 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l13-20020a1ced0d000000b003fba2734f1esm2200070wmh.1.2023.07.26.07.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:39:12 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 2/2] drm/ssd130x: Allocate buffer in the plane's
 .atomic_check() callback
In-Reply-To: <20230726105433.389740-2-javierm@redhat.com>
References: <20230726105433.389740-1-javierm@redhat.com>
 <20230726105433.389740-2-javierm@redhat.com>
Date:   Wed, 26 Jul 2023 16:39:11 +0200
Message-ID: <877cqm4u0g.fsf@minerva.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Drivers are not allowed to fail after drm_atomic_helper_swap_state() has
> been called and the new atomic state is stored into the current sw state.
>
> Since the struct ssd130x_device .data_array is allocated in the encoder's
> .atomic_enable callback, the operation can fail and this is after the new
> state has been stored. So it can break an atomic mode settings assumption.
>
> Fix this by having custom helpers to allocate, duplicate and destroy the
> plane state, that will take care of allocating and freeing these buffers.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

