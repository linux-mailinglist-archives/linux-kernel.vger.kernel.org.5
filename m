Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E14753805
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjGNK0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjGNKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C12738
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689330313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=99CCQV0ZC6Z3v4KeeI3589CkCiweHnTBxIfE2i437hQ=;
        b=JOCCIArKzXDq6BW0BpUmi1Ehy5YgfwkHkKY0oPL1/5ly32swNeZiiXJ402fbW2yBlh0P5z
        6IOZQW7nzlaAlG1clqlolG8qn6/Opvv2HLEWGCbrlQc4MlwvXCplnGQ7ZBYCIQLdgxQPxy
        b9rKYHImOCLpBj9DA3gvJA2nSWPHLFQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-cTHc2Qy9MBysMgJ8-oCtEg-1; Fri, 14 Jul 2023 06:25:11 -0400
X-MC-Unique: cTHc2Qy9MBysMgJ8-oCtEg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so10094485e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689330310; x=1691922310;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99CCQV0ZC6Z3v4KeeI3589CkCiweHnTBxIfE2i437hQ=;
        b=HTfzwyt48LiXI7S0hK/SeVEzssWPNs3ju3wmeNqXjmPHIZGYMhqXKFdKUB5FZgOX9f
         YpmBNKnOJBnJS28FzIb7WlpmVq8KxeO1FHGJZOol5XCPlhrp6PJ4p/fUcMhZv57hqw2V
         ggMGqTtMic/IIyp5+QrZjjqu9kcKrhoX7QsppWGV9lPHdP0P3LTmSRhZx3ahORxnBaUO
         +JPvkle93gzqlfV8jJBnuNuk4YrOxF4Y3t7LF2h29BlFBh7PzzNkaLE6lEo8E9CLOYDG
         xD9B0AiecCB2Q8y5gXrXtOA00/ZUJ6NDuIhsCBWcQUPCzL8aPjRvRMxhViRyzftHAgJE
         JQAw==
X-Gm-Message-State: ABy/qLYxAWMK1DKzi2u89z85CgV3gvEZAJHhbNnT7y14cPXN/SUFYjhz
        2aZpliAu7hamasXzK/Efp6X2GuXpinE5WCnrcumqHDQ9ra1EVta5u0TEmS3wT2czT35JhVS0tpM
        bKJLPpTw81baejHWdhFpPYGbv
X-Received: by 2002:a1c:f704:0:b0:3f5:fff8:d4f3 with SMTP id v4-20020a1cf704000000b003f5fff8d4f3mr4492216wmh.7.1689330310670;
        Fri, 14 Jul 2023 03:25:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGcKXPZt/8xOGKWRtDHFsQt08ITixr5RAQtfS/O8OJsznodQIIOTbvwv/Fuw2cdRvp5PQbbpg==
X-Received: by 2002:a1c:f704:0:b0:3f5:fff8:d4f3 with SMTP id v4-20020a1cf704000000b003f5fff8d4f3mr4492201wmh.7.1689330310365;
        Fri, 14 Jul 2023 03:25:10 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c378400b003fc3b03e41dsm917198wmr.0.2023.07.14.03.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:25:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 6/8] drm/fb-helper: Pass buffer format via
 drm_fb_helper_surface_size
In-Reply-To: <00790d022752b672a28256db7b9393eca0801b99.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <00790d022752b672a28256db7b9393eca0801b99.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 12:25:09 +0200
Message-ID: <87cz0uu6wq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> drm_fb_helper_single_fb_probe() first calls drm_fb_helper_find_sizes(),
> followed by drm_fbdev_generic_helper_fb_probe():
>   - The former tries to find a suitable buffer format, taking into
>     account limitations of the whole display pipeline,
>   - The latter just calls drm_mode_legacy_fb_format() again.
>
> Simplify this by passing the buffer format between these functions
> via a new buffer format member in the drm_fb_helper_surface_size
> structure.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

[...]

> -	drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
> +	drm_info(dev, "surface width(%d), height(%d), bpp(%d) and format(%p4cc)\n",

You are promoting a debug printout here to info but that change is not
mentioned in the commit message. If you think this will be useful, maybe
do it as a separate patch ?

The rest of the patch looks good to me though.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

