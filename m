Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0A7F7697
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjKXOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32D19A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700836909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3K50cOwL2e/Sm1/EHsvbvDxOsSWvo2nEBpLvx7bOk4=;
        b=PBy8hZ6EJ0euPNSqD89Imsp9PBGz8mANQ/QlvBRg083JyLxjyA9tVl0luwKdXEaakLxbYf
        Y86ANGZMhh/OVE3JtYxzvd4AlzRlqmjsuLF2T++r+g+pA730mIpW4Lg0RrzaaSP1YK8dcP
        Uw9CChysuio3dLNRQiigzif2G2BRlD0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-4Z_lieBzMYK5v8K2WX9Dzg-1; Fri, 24 Nov 2023 09:41:47 -0500
X-MC-Unique: 4Z_lieBzMYK5v8K2WX9Dzg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332e82bb756so595170f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836906; x=1701441706;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3K50cOwL2e/Sm1/EHsvbvDxOsSWvo2nEBpLvx7bOk4=;
        b=b4txK57tuTrCtBg8wMNMAMyqmS+BOyBOxeXz0b1JdNffbXNqVGFC1quOxlgCAlu70I
         REFJ2U9qj7vcOhnR+x4LAlzhIxfR9Zeqrjj38+vUBamMQ3BRvfUxxs+nV5qrqNRBxojX
         e4mzH9tUpEq4U4+VXXXYF+caF7/80spm1WZhmNt+bIH3mI2LMXwp3Iovao6hzy75ElkP
         IB+X48L+Z1B4P61OUhDmPOn9HEDScGbjtzEaJ9Ccj9Q5VIP7JSrCkfpbpHhDrxzgKO7l
         FISqTLmsMbM3NlujttLL30eS782ygUzHtOLVApe13NEwpLnBL3zNrET/y6tXqs2Lfhlf
         TW1A==
X-Gm-Message-State: AOJu0YxabLDiSzx7ygUtAIVlO2QjCoW1FJfjxWDPfI94A2TJA9nenQva
        Gdu6zC9QQWcTPsZ5111SdHHmuMGOzQxLTSSu/C9FOg4T9R3jqkkKVSChVLw54NHpds9cZvRr1RF
        a0sasCf5Czy7tFuTT80fMImBO
X-Received: by 2002:adf:ff92:0:b0:332:eacf:c9d7 with SMTP id j18-20020adfff92000000b00332eacfc9d7mr2292961wrr.8.1700836906403;
        Fri, 24 Nov 2023 06:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE53BbITSRE5erDBMKhplTxbIjo+7N2xRO0vWBt96X5OYz91Q7KP0WC4vmV1rL31vNgSjrYww==
X-Received: by 2002:adf:ff92:0:b0:332:eacf:c9d7 with SMTP id j18-20020adfff92000000b00332eacfc9d7mr2292920wrr.8.1700836906054;
        Fri, 24 Nov 2023 06:41:46 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s15-20020adf978f000000b00332d41f0798sm4514822wrb.29.2023.11.24.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 06:41:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc:     zackr@vmware.com, contact@emersion.fr, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, krastevm@vmware.com,
        spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
In-Reply-To: <20231023074613.41327-1-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
Date:   Fri, 24 Nov 2023 15:41:44 +0100
Message-ID: <87h6lbcixj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Esteve <aesteve@redhat.com> writes:

> v6: Shift DRIVER_CURSOR_HOTSPOT flag bit to BIT(9), since BIT(8)
> was already taken by DRIVER_GEM_GPUVA.
>
> v5: Add a change with documentation from Michael, based on his discussion
> with Pekka and bump the kernel version DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
> might be introduced with to 6.6.
>
> v4: Make drm_plane_create_hotspot_properties static, rename
> DRM_CLIENT_CAP_VIRTUALIZED_CURSOR_PLANE to DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
> and some minor stylistic fixes for things found by Javier and Pekka
> in v3.
>
> v3: Renames, fixes and cleanups suggested by Daniel, Simon and Pekka
> after v2. There's no major changes in functionality. Please let me know
> if I missed anything, it's been a while since v2.
>
> Virtualized drivers have had a lot of issues with cursor support on top
> of atomic modesetting. This set both fixes the long standing problems
> with atomic kms and virtualized drivers and adds code to let userspace
> use atomic kms on virtualized drivers while preserving functioning
> seamless cursors between the host and guest.
>
> The first change in the set is one that should be backported as far as
> possible, likely 5.4 stable, because earlier stable kernels do not have
> virtualbox driver. The change makes virtualized drivers stop exposing
> a cursor plane for atomic clients, this fixes mouse cursor on all well
> formed compositors which will automatically fallback to software cursor.
>
> The rest of the changes until the last one ports the legacy hotspot code
> to atomic plane properties.
>
> Finally the last change introduces userspace API to let userspace
> clients advertise the fact that they are aware of additional restrictions
> placed upon the cursor plane by virtualized drivers and lets them use
> atomic kms with virtualized drivers (the clients are expected to set
> hotspots correctly when advertising support for virtual cursor plane).
>
> Link to the IGT test covering this patch (already merged):
> https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>
> Mutter patch:
> https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>
> Michael Banack (1):
>   drm: Introduce documentation for hotspot properties
>
> Zack Rusin (8):
>   drm: Disable the cursor plane on atomic contexts with virtualized
>     drivers
>   drm/atomic: Add support for mouse hotspots
>   drm/vmwgfx: Use the hotspot properties from cursor planes
>   drm/qxl: Use the hotspot properties from cursor planes
>   drm/vboxvideo: Use the hotspot properties from cursor planes
>   drm/virtio: Use the hotspot properties from cursor planes
>   drm: Remove legacy cursor hotspot code
>   drm: Introduce DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

