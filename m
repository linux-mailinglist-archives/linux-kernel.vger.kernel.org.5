Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17457D41B5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjJWVam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjJWVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9A497
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698096593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1k2Vg92RJrxv+gYLNepXp/tJyAR04nx8wa9wG6p0is=;
        b=CwjHaK++8fyEHoRWsDpAqoVJFLY17ifamAoZwS5lLWV3uGMk7KtSWx3t+oez0Dy/ofoLIQ
        VjhFXi5/4jyR8h0W82KKyGuop6o72xXiUDB5VIxsvEcmadULN7QNHBJ5egpv1nR02FK8j1
        ZJsCdvLUiKm9lyMzUO+uET2yOx3eZWE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-p0JPo5wsMpSbECmSy8HaPw-1; Mon, 23 Oct 2023 17:29:41 -0400
X-MC-Unique: p0JPo5wsMpSbECmSy8HaPw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so23179605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698096580; x=1698701380;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1k2Vg92RJrxv+gYLNepXp/tJyAR04nx8wa9wG6p0is=;
        b=tVaRamofngOfyqzP82gjrxMRNHWS/bsVx3M4ZRYgd1/gLiXNhxnTYpqociO7KlWPka
         yiE7za7pb25ujEDFmMk5LzydSTKpnGCBWLaxk0ylF+SB4kyl/kjMn2Br3Nv0kBqvEdHl
         ox1ro1n1FVjxk3DcSfTkwVEywqku8FCGxYxGBWW3Qlx2PXYdXrPo6p4MLNyRv3DjIl4V
         HW9HhxLBXkbypmxdR2DwnlKvU/irai4/A44xSDJa9RSxZT9iH3gohBVFQOYNUauaXlA8
         xnArLs02ModnIAjfKZopMra5+cp3/AaUbJAqrwmF07shNURn1DyTM4vrD6vtnqSD0yqM
         TQ1g==
X-Gm-Message-State: AOJu0Yzd7tVaN9+upFJXJnCE5slkRq33sB/o0T7Up986nABW3KpNqwEZ
        GJavKHzB/ANZsuwv4qy6Vzmg0fBeCVxOW9qL1JEfBcDGpiiTLUQ/4GRp3dNJBRltUynk68hSSIJ
        VZO+gJtPYnBdOdRb1oxnpSMVm
X-Received: by 2002:a05:600c:45ca:b0:408:575e:f24f with SMTP id s10-20020a05600c45ca00b00408575ef24fmr5647876wmo.28.1698096580662;
        Mon, 23 Oct 2023 14:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwIqmyWxHtLCEV9sJcM7Mm48Qpb+Y1PSoNkRJSeRh4CaGlNviwDWwltxau6u5GNETKD69b9g==
X-Received: by 2002:a05:600c:45ca:b0:408:575e:f24f with SMTP id s10-20020a05600c45ca00b00408575ef24fmr5647840wmo.28.1698096580275;
        Mon, 23 Oct 2023 14:29:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c218700b00407efbc4361sm14963606wme.9.2023.10.23.14.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:29:39 -0700 (PDT)
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
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 9/9] drm: Introduce documentation for hotspot properties
In-Reply-To: <20231023074613.41327-10-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <20231023074613.41327-10-aesteve@redhat.com>
Date:   Mon, 23 Oct 2023 23:29:39 +0200
Message-ID: <87h6mh10zg.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Esteve <aesteve@redhat.com> writes:

> From: Michael Banack <banackm@vmware.com>
>
> To clarify the intent and reasoning behind the hotspot properties
> introduce userspace documentation that goes over cursor handling
> in para-virtualized environments.
>
> The documentation is generic enough to not special case for any
> specific hypervisor and should apply equally to all.
>
> Signed-off-by: Zack Rusin <zackr@vmware.com>

The author is Michael Banack but it's missing a SoB from them.
I don't think there's a need to resend for this, can be added
when applying. But either Michael or Zack should confirm that
is the correct thing to do for this patch.

The doc itself looks great to me and it clarifies a lot about
cursor hotspots.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

