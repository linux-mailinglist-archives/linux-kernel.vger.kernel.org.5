Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E56A75D79C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGUWk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjGUWkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E835B1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689979175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=djeVFkwc7o11bqagTdpCOjfKwmcqowaFNZyoMjR9tzs=;
        b=STOtfBz6xAoS1ZwLnT9bsI6Ip9aS1NxHDC5MsOToM3cqyVi1vL541XR51nu/mNUUjRjml0
        3dC+tYwQ8YlwSOpclDwZ/qz35afG+DgLg/hL1fEZMTxmBOoZyr4U27XfNNASv0TFswnFxA
        FdmpHv7wr4OR2q3K5dHoOrRjDQ6R/P4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-5SRaz3e6O7q1ZiRNv4SI2Q-1; Fri, 21 Jul 2023 18:39:33 -0400
X-MC-Unique: 5SRaz3e6O7q1ZiRNv4SI2Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa8cd898e0so14671105e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689979172; x=1690583972;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djeVFkwc7o11bqagTdpCOjfKwmcqowaFNZyoMjR9tzs=;
        b=l02oohllfsrnYu2id8grvhX++zVuKoO4qj4tVaN2MQubVsU0x781BSBwAoLvO58nTg
         UhRm7gYM3ikSgxaLJyM43uI5G1DOznVu+ykkB1epZu2XrxRxE3QVwnlNExGAIH7WBQJM
         f+ZUwlZOVneeeZlYR3H8ee1r1Dcs2KEWSieWozjGMvK+cN6FvnbIfSH6GRLT7RclUP+6
         q1KyMjmmIgQn1W7EW1S22IawPfN/w3LkpuplokTQg06+2J+Ik6S356/nt2SzCq79elKg
         Hk7xlNeeqaIhcvy1oLhrc/aRcOTow1vrLDYak1z8FrznT8mL7p7w7QABwRFPfR4+lmFr
         OKww==
X-Gm-Message-State: ABy/qLZg85ycypCLtxgvQ/vpXCxKAXr0TiX7hCNJWZd4PMV8htj8/HhL
        1J9Qv2OS4V2pBqingxg5Cd9KUNqPxz7K7Lwo1XdvoPduMWEmKoDiW36YnudE9GnGzyye6jR53FM
        f+a0OpcIh+Vr4V02/gA7ZSiKZ
X-Received: by 2002:a5d:688a:0:b0:313:e591:94ec with SMTP id h10-20020a5d688a000000b00313e59194ecmr2492210wru.67.1689979172737;
        Fri, 21 Jul 2023 15:39:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFU19gbuGBPfn5GFP+ZJOAcjjr+4pjs4xq8gM4c2hidS9MPYgB6irSpOLn1E2i5bapMMgOciw==
X-Received: by 2002:a5d:688a:0:b0:313:e591:94ec with SMTP id h10-20020a5d688a000000b00313e59194ecmr2492200wru.67.1689979172460;
        Fri, 21 Jul 2023 15:39:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b0031272fced4dsm5316385wro.52.2023.07.21.15.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:39:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/ssd130x: Fix pitch calculation in
 ssd130x_fb_blit_rect()
In-Reply-To: <874jm69631.fsf@minerva.mail-host-address-is-not-set>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <54deec2ec533e90544faa8c60a0c2518c58f3e9c.1689252746.git.geert@linux-m68k.org>
 <87r0pau99o.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdVAXPqjSNGMrZQ2g8FNNL4f7PbdoUCi17g9YOdoqmjFpQ@mail.gmail.com>
 <874jm69631.fsf@minerva.mail-host-address-is-not-set>
Date:   Sat, 22 Jul 2023 00:39:30 +0200
Message-ID: <87v8ecubx9.fsf@minerva.mail-host-address-is-not-set>
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

Hello Geert,

> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>

[...]

>>
>> My point is that the 8 as used here is related to the number of bits per pixel,
>> not to the page height.  The page height might also be impacted by the
>> number of bits per pixel, but that is orthogonal.
>>
>
> Ah, I see what you mean. Yes, you are right. We can later add a
> different variable when adding support for controllers using R4.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc (drm-misc-next) since this fix is independent of the
rest of the patches. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

