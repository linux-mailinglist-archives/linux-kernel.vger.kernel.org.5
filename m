Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5F978C0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjH2ImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjH2Ilw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA45AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693298463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q157Ab0b7OLfZnZw3+Tm9BEAhxi0YbIjWdPL/BQhf3U=;
        b=Zh/kxomquD3cZBBuZmYz7HPCpCN/RNskf0cgm8Jcj2lGypYgZqprQAwu4LK7JXUeCRmSRK
        Hdoc14Q1+JXLmgG0Oehz1svRRGno9+N1O8b8qXRYOASMCwjFDxL6XO9/QjRSP8kyhSRmOX
        VERXqQZ2LBKVTFlsXHXwpLa7YBcViWg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-qT3q6olCOZuBtHpyKl_7Fw-1; Tue, 29 Aug 2023 04:41:02 -0400
X-MC-Unique: qT3q6olCOZuBtHpyKl_7Fw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe661c0323so28179225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298460; x=1693903260;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q157Ab0b7OLfZnZw3+Tm9BEAhxi0YbIjWdPL/BQhf3U=;
        b=j0Ck6GCWyOZ7mozsOFcz7UJ9ZPXqwGE+ULwu7FjUe5FG9GICK0I8qLYKWORi9Pt2Fl
         MpVBoPCGdtTV4F5WOwPZ/zUSYmdAaeACBpdvIHC+aCwAmiSiYp8smBbJ0mhphc5fn5on
         sO4TIOOcGoHvFYpawwkPkgLK5Zq0sgme+6OZ14yy2JnGzRMGdTDlAjp/A2ndBR+wru1l
         mVATj092n1iUPnZ8c9TLlCV1wYW+F8uIYFcCFWzc3iIUwAbMuJQmr6qRXeDShAEK14Ek
         2dvotaqcYW0XzyC1NbUOcOC8GYQMFhmCIhVUY11TlVzSvZvKx7jvz/9GBmMWIya+CA/V
         GFIQ==
X-Gm-Message-State: AOJu0YwhuHzZx4nGvs/RE5lX7gg4i/ZwzX/0SCsxMqL27xH46ITvnTV6
        ZDAVwpsmLWdx53a/DE5MRnHgnF3ePSuam5T3V1LL9km9TVoBXF5bvA0/vmExo9XIXgcWY+Bxj9M
        GRxtnbRUJdoWlwxnDLwUIm4Cj
X-Received: by 2002:a05:600c:2307:b0:3fe:687a:abad with SMTP id 7-20020a05600c230700b003fe687aabadmr20322775wmo.20.1693298460824;
        Tue, 29 Aug 2023 01:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr0o6QR4aphUwmh+kp4NdvHLJoBFExvgRu0tylkhyQ2rbFHYWe6KAKoW0+WNE05NK6Ylc0Iw==
X-Received: by 2002:a05:600c:2307:b0:3fe:687a:abad with SMTP id 7-20020a05600c230700b003fe687aabadmr20322759wmo.20.1693298460437;
        Tue, 29 Aug 2023 01:41:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c024d00b003fe2bea77ccsm13260342wmj.5.2023.08.29.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:41:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/8] drm/ssd130x: Fix screen clearing
In-Reply-To: <c19cd5a57205597bb38a446c3871092993498f01.1692888745.git.geert@linux-m68k.org>
References: <cover.1692888745.git.geert@linux-m68k.org>
 <c19cd5a57205597bb38a446c3871092993498f01.1692888745.git.geert@linux-m68k.org>
Date:   Tue, 29 Aug 2023 10:40:59 +0200
Message-ID: <87zg2atf50.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

Thanks a lot for your patch.

> Due to the reuse of buffers, ssd130x_clear_screen() no longers clears
> the screen, but merely redraws the last image that is residing in the
> intermediate buffer.
>
> As there is no point in clearing the intermediate buffer and transposing
> an all-black image, fix this by just clearing the HW format buffer, and
> writing it to the panel.
>
> Fixes: 49d7d581ceaf4cf8 ("drm/ssd130x: Don't allocate buffers on each plane update")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> ssd130x_clear_screen() is only called from
> ssd130x_primary_plane_helper_atomic_disable(), but this never happens on
> my system.
>

AFAIU this should be called if the outputs get disabled.

> Tested by adding some extra calls to ssd130x_clear_screen() at regular
> intervals.
>
> v2:
>   - New.
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 47 +++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 8 deletions(-)
>

The change makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

