Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634FA768146
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjG2TPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG2TPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A010C0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690658104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKZ/m4E32pk0OxOiOqNXBVn4dQjxooPCr2VH/BSIu+M=;
        b=R+p0R/ObhkehR6Z9t6FQK4hvVNtmZ0V3CnrmRwoCt14HRSOw67u5GLcrHwFz/mlOsovahe
        WC6gdaw+UJg8X8PTc2Ovon7rRYGO/CVpZcQNSq4GKGqih9AVysWDY0sDtXSvyUPsUNDKDN
        mkTjh2iazpdDjVUuqqkdBoAqtBgCWDA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-wpDkqNqENuCWfpB0uQRYuQ-1; Sat, 29 Jul 2023 15:15:02 -0400
X-MC-Unique: wpDkqNqENuCWfpB0uQRYuQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso16913915e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690658101; x=1691262901;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKZ/m4E32pk0OxOiOqNXBVn4dQjxooPCr2VH/BSIu+M=;
        b=WzeQwZEmazRHo7U4iNWlab3fXRfsF2wFG698i1Cq1WAVVSvBtLq1qswYiwvsTH6DRk
         Ydgmad0ofJFy3qSEpFgUYnq8QqUkaidq57QYA2pAycypViHOiMdfmWINflwYbydQt1an
         +FATTw6BYfJ6sUVWBT0f5hEixOV71F98SImQwIQFE/J5nrprZzMD97dRtxTG8T/Gc7KS
         YlFhu+9hkK4FiJbh3VQHjs/0PRLumyYNwGzhFPaUOB8bZdGzzoI67lMyzs0nQVtJBFmz
         XPNC2G9R/u6r6ec6BGYTiQ5rhho/oi3c9INRAVq8f6yFsj1Mu9h5SS0y3D7Okg7idPbF
         O8Sg==
X-Gm-Message-State: ABy/qLbQjQpL+J7EXLSHKOOHx20NctIsydhMP7YPQ+8q+U/5KjDLHjAl
        hYzlF9OkbXkmS26Ds78SZ9IsnoAUui9MkuQp7C33SGOVeBHCsTW4Fa/9bL+vTZqCoo1BN8bBQiZ
        qNBi8fF0acJE8FDK6i/OHKQKL8GL3o5Kb
X-Received: by 2002:a05:600c:2109:b0:3fa:97ad:2ba5 with SMTP id u9-20020a05600c210900b003fa97ad2ba5mr2065636wml.31.1690658101111;
        Sat, 29 Jul 2023 12:15:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHLZUj9UpcJLJhL8ZYAVAlut578FF7QHxlwqAv3EfIOrRcqB9xm3wue0QZcrC5Ib1KR/6X0hA==
X-Received: by 2002:a05:600c:2109:b0:3fa:97ad:2ba5 with SMTP id u9-20020a05600c210900b003fa97ad2ba5mr2065633wml.31.1690658100845;
        Sat, 29 Jul 2023 12:15:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe587000000b00314172ba213sm8122621wrm.108.2023.07.29.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 12:15:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 resend 2] drm/armada: Fix off-by-one error in
 armada_overlay_get_property()
In-Reply-To: <a4d779d954a7515ddbbf31cb0f0d8184c0e7c879.1689600265.git.geert+renesas@glider.be>
References: <a4d779d954a7515ddbbf31cb0f0d8184c0e7c879.1689600265.git.geert+renesas@glider.be>
Date:   Sat, 29 Jul 2023 21:14:59 +0200
Message-ID: <871qgqy1fw.fsf@minerva.mail-host-address-is-not-set>
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

> As ffs() returns one more than the index of the first bit set (zero
> means no bits set), the color key mode value is shifted one position too
> much.
>
> Fix this by using FIELD_GET() instead.
>
> Fixes: c96103b6c49ff9a8 ("drm/armada: move colorkey properties into overlay plane state")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Compile-tested only.
>
> v2:
>   - Add Reviewed-by.
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

