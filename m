Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901A78C0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjH2JDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjH2JCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1EB5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693299716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgdzgbOX3BwA1qsFQOYjucBlp+9396nKB8ZCFY6QyUM=;
        b=M7IG6tI4KWAPaTWTRR/MAsjBp7lL7+2W5+/xWTXpyDMDfSI60hsIQnzV7Bu+m6U/7VZ4ki
        uuyxyzOd8+zSY2n8XpOngPMT94swhR5UM9P9vbuBTNxdfZbeI9IauItjrIcxlZUEL3ng/p
        Z1cngPYtxBRk93v46f2PoYXQ8Rx4O9I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-ZZIxSzqpMm2MZnRYrsizkw-1; Tue, 29 Aug 2023 05:01:55 -0400
X-MC-Unique: ZZIxSzqpMm2MZnRYrsizkw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fef27968adso28317425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693299714; x=1693904514;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgdzgbOX3BwA1qsFQOYjucBlp+9396nKB8ZCFY6QyUM=;
        b=gzJ+2525wGPALLJCnOLNuCJN4k5U7rwhNAYkYHUvALelEDWAQ4MvyR9mr0IFXv6rs4
         Y+ejUHAWczArY/AhnSYa3LFrXWCWNUIlBSK2zda8zgvtNmYAZTXCLu+K9BusIqsyK5Nt
         4j/yxl4YRxGKs3Fi/wauCyr4Rfzrye+2RZ9LbRLEmVfX5M/CklNG+OdjnkTLybS2h/TS
         5ehnrYaYwU+IvxFgb7ZtosJtJEO1z4ayNgCAAYioFKGkjFDwzUrc78tXIZ3oqAZXS0/T
         xcr9jfBYG+J1PSpSkBxHdrLcwnJokjbESzDWmwe7IZbCzZ4w1tWIdOAuPtOUcT8dKmmO
         WQKQ==
X-Gm-Message-State: AOJu0YxetTGftFP3vahkAarZyLiH+ESHSalJxew5/ghFkpCQOv9EPjjH
        kexDtlz80bLp4B3OV96bBMB7VyuvKMmoAYlS4VUkW/gq7w3kTpsKynAis//OD1zxcH7rrUHSmuv
        I9a1kMGUrSs9x2HiNklfalVLd
X-Received: by 2002:a05:6000:1001:b0:313:eee0:89a4 with SMTP id a1-20020a056000100100b00313eee089a4mr19955842wrx.12.1693299714227;
        Tue, 29 Aug 2023 02:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7519sgRuQahIjqmDIMpfo+pIFgWCd1xrVbXj5n+yxQWh+8JQX1GBtrdrGKcwK47RXFui/Cw==
X-Received: by 2002:a05:6000:1001:b0:313:eee0:89a4 with SMTP id a1-20020a056000100100b00313eee089a4mr19955828wrx.12.1693299713945;
        Tue, 29 Aug 2023 02:01:53 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4406000000b003143c6e09ccsm13098590wrq.16.2023.08.29.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 02:01:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 4/8] drm/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <d5f342b5382653c1f1fb72dbedb783f9ea42416e.1692888745.git.geert@linux-m68k.org>
References: <cover.1692888745.git.geert@linux-m68k.org>
 <d5f342b5382653c1f1fb72dbedb783f9ea42416e.1692888745.git.geert@linux-m68k.org>
Date:   Tue, 29 Aug 2023 11:01:52 +0200
Message-ID: <87ttsite67.fsf@minerva.mail-host-address-is-not-set>
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

> The native display format is monochrome light-on-dark (R1).
> Hence add support for R1, so monochrome applications not only look
> better, but also avoid the overhead of back-and-forth conversions
> between R1 and XR24.
>
> Do not allocate the intermediate conversion buffer when it is not
> needed, and reorder the two buffer allocations to streamline operation.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Rework on top op commit 8c3926367ac9df6c ("drm/ssd130x: Use
>     shadow-buffer helpers when managing plane's state") in drm/drm-next.
>     Hence I did not add Javier's tags given on v1.
>   - Do not allocate intermediate buffer when not needed.
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

