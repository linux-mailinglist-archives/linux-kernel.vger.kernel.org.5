Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57857FC3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjK1TDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjK1TDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC57D66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701198203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7fxhtCiZKd6JnIB//hIKwp+z4CDot8wjhjF2B4UWc4=;
        b=cl8FPrGJr9nGHTMJTnZ1I5Yprxyfl/1wKUh7POQGkT21rSFr2ItJ2JEXgvu6y1iKM/IGx4
        81F/+koyGu9W0SyFD5l1flIyVkKoOVf0ZKHssi0QJR3li+5x0p50drw6vLHsBhjCy7ycG+
        cvbGGJp9e4jEPnXjw93rtX9P4Ag62uM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-howbzoDZOGeFsAw5e4V5ZQ-1; Tue, 28 Nov 2023 14:03:21 -0500
X-MC-Unique: howbzoDZOGeFsAw5e4V5ZQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33306c2a005so1400770f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198200; x=1701803000;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7fxhtCiZKd6JnIB//hIKwp+z4CDot8wjhjF2B4UWc4=;
        b=TnnbYH2fcMAL/NgUDA0y0fNWLkOa5HoGljbwlRl15apFcZOeWErcpvVs8d6B0ArxtL
         KFEGn7vlvhxKr7D2X9fYC5CZTXi9Svd2F5wKHuSJoX1jpaK2E42gMtwpWXn7436cMj92
         CTMir94GgXlTQzUKbf9FDb91f9SGp6rMHnMoe1yHjjqWCl1JDzRsO6eMpiotAUEl/aRr
         8Zubjbwqm2BFaPHrfpoMwRmNFSSPz+0rvYu+T5VRXTm30amashE6BvkIRh7KPH2aBwm3
         FwQ3BWdVUYgXr1ChiXATfWkzcYETey1W51Aqgz9+T+OjaPeKqoVRSpWadWbWrI4JUX5m
         VO/Q==
X-Gm-Message-State: AOJu0YyXlKJBYyHt7Hx98K0L8RwMSkhuzo4QXJWpbGaeYCJokFp/aRCH
        1VocWrNQnwGUbu5q24w63z/vmRv3UvNpttboB0BwwXsahPSTvYyPbGxecddF721ro5FzIfteaPx
        EsBjeBuJNgDOwfTtma6nJfEng
X-Received: by 2002:a05:6000:2a6:b0:332:f501:8b44 with SMTP id l6-20020a05600002a600b00332f5018b44mr9536218wry.0.1701198200332;
        Tue, 28 Nov 2023 11:03:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJqPO3wUdCQkqTIxQaKE7gUDOBcDnVqGZttWHciV3/WIgYoBUxR7C7Qe/kNwOdFtf3erAVwg==
X-Received: by 2002:a05:6000:2a6:b0:332:f501:8b44 with SMTP id l6-20020a05600002a600b00332f5018b44mr9536191wry.0.1701198200032;
        Tue, 28 Nov 2023 11:03:20 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t5-20020adff045000000b00332e6a0e9f4sm14388974wro.75.2023.11.28.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:03:19 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
In-Reply-To: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
Date:   Tue, 28 Nov 2023 20:03:19 +0100
Message-ID: <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
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

Hello Geert,

> The Imagination Technologies PowerVR Series 6 GPU is currently only
> supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency on
> ARCH_K3, to prevent asking the user about this driver when configuring a
> kernel without Texas Instruments K3 Multicore SoC support.
>
> Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Indeed. Although I wonder what is the supposed policy since for example
the DRM_PANFROST symbol only depends on ARM || ARM64 and others such as
DRM_ETNAVIV don't even have an SoC or architecture dependency.

In any case, I agree with you that restricting to only K3 makes sense.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

