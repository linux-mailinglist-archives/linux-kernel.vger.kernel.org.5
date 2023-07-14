Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782A9753728
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjGNJxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjGNJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E4110
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689328390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KlmnwrOAUra2AoR+OJzQ3RSTdF5SRC5OBuyPhzlD+D4=;
        b=gRPvk++efwUgOOlFoZmkn8wjLSM8NVGkrU/6ZQLWSIK1RBB9mY2j6Yiw2syW1spqbjziwI
        vWsJSEX674Ui3x3LhdoH0MEit1s56v3kFO26ozqVOTsM08H0MK4K1HOOsPReWk4/fzWuRD
        Iq96Vz/zF5Cv3jocDgGmbc8EagvFoXA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-NcL-6kFDM4K_eAap1bky8A-1; Fri, 14 Jul 2023 05:53:08 -0400
X-MC-Unique: NcL-6kFDM4K_eAap1bky8A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fb416d7731so9207655e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328387; x=1691920387;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlmnwrOAUra2AoR+OJzQ3RSTdF5SRC5OBuyPhzlD+D4=;
        b=XktLwLCrvDnBul24nqBr8cKac/xMIuP7FyVfl3yDFp4SdiqJw4y6eR6LRay46k8wlb
         HyrGzMhmsoJf7joO7YV69awuecXhZX5CRKiRmV6pROBayiOW0IMg1BBeTv+1eJ89mMLh
         K9aNeo9NTeJJlLhGf01XGaBopaqgpjMbKsYUt4r8pya16AacTTurh2gJKmQHEMUzWoO1
         xkhdA7VKCXBbmbuQ66UoU4fAYe37nMa8UzHn+0K8WiWQnVilhmhXxZkoPVOJ2Z5hksm8
         AiLih9Iq7O2Sac/DC66RP8W/Hj5A7QlZCU6rD3b4hh2C9slOl3IevMMnq6+SJIOaG6JE
         IXxQ==
X-Gm-Message-State: ABy/qLaWNnUYQxDEgSVXpEMTaHKApxmIYhYGsE8gKyGvGukiFOzAi8Jn
        keZVw1CgkCWQ3/0isYfHt70wL2T9ObBpv8YUn/Iy43FRk7wy/kd/c3w+h1IvnV525q1B+NClU+S
        HeCo2Khs5UxPNQPUK7nm+Y878ZJYCq3mv
X-Received: by 2002:a1c:730c:0:b0:3fb:b890:128b with SMTP id d12-20020a1c730c000000b003fbb890128bmr3533490wmb.27.1689328387425;
        Fri, 14 Jul 2023 02:53:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHvOU+9K7pwTaUjbeyVj4C118cz2Lb7TksNLyej8j96izGIKkwzzu/6INZY3dAM1ldj6NHi3w==
X-Received: by 2002:a1c:730c:0:b0:3fb:b890:128b with SMTP id d12-20020a1c730c000000b003fbb890128bmr3533477wmb.27.1689328387167;
        Fri, 14 Jul 2023 02:53:07 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b003143c532431sm10406287wrd.27.2023.07.14.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:53:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 3/8] drm/ssd130x: Bail out early if data_array is
 not yet available
In-Reply-To: <c1030f3a445ee130c6a582fe10431c90018278e5.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <c1030f3a445ee130c6a582fe10431c90018278e5.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 11:53:06 +0200
Message-ID: <87lefiu8e5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Calling ssd130x_buf_alloc() from ssd130x_encoder_helper_atomic_enable()
> is too late, causing a NULL pointer dereference:
>
>     ssd130x_update_rect.isra.0+0x13c/0x340
>     ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
>     drm_atomic_helper_commit_planes+0xfc/0x27c
>
> Work around that by checking if data_array is valid.
>
> Obviously this needs a better fix...
>

This should be fixed by [0] so we can drop this patch from the set.

[0]: https://lists.freedesktop.org/archives/dri-devel/2023-July/413630.html

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

