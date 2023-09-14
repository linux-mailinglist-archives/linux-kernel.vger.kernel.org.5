Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FFE7A0AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjINQjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D89791FDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694709501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V0YL1s0r0RMXaZzIshNhC7a9mBahQAI6QCadmD8ScPA=;
        b=VVm2cIVpvOPy1Iqaki5WFhIMu46bkNomMHLv1lzkSUSb85/fChyIWhuK8uLrGlPKwsXque
        0QywQy/fJvuRPXLKP/oAKND+Lpsjfi0L+OZ+IfWrsFsvnle9jARl4XFaj3L4JsHhiir/r9
        zRDxFgag/gahf+fCBMgsvGlCu9IedBU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-6-yp-sEYPmGZbB07lH4vFg-1; Thu, 14 Sep 2023 12:38:19 -0400
X-MC-Unique: 6-yp-sEYPmGZbB07lH4vFg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31facb07f53so523739f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709498; x=1695314298;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0YL1s0r0RMXaZzIshNhC7a9mBahQAI6QCadmD8ScPA=;
        b=mGIijuZNHfQfqqtBKuKFrVKUi9tIEDD4pzTzcFHnywAA/Ekx0bS3dnokdbvSLUYDqh
         Sgcdv2WlX4QSeonsO46pIVofBZh9XXEG+uf7fnOEJokVyIOxyjmpIcrAHbYlRomg9rv6
         kEHkOSH1NkMJRuf6IMMN6qBPyWHlymQhCvYpUO11SAreJyA3gMmHs4eUMbJgaTye9kF3
         oT1GaHGHlb2pW9pDERnNd3mrGr7PAy0xOkxesnpzw4L6cn3rsZV6+KF+nhawSc0P7sZH
         7wBkrGgguLbqY8Z1HwbcylJoEYFdj4z3xY7Nr2U5JvsEbUHh+AqBjCiKK2g7LUeLFE+b
         J3wQ==
X-Gm-Message-State: AOJu0YxMRZ5MMNtEKm2mjCyq07TcAfYRHIN1OTLGhBBUkcYDdRmRpPKt
        AUDNY0/ZQM0PGvIWvx1Sfva0nwvP1hCfmTHhFVkOG68gOAgUVj/DA+n8J7r44Lq0aH0sjYPherq
        K04nP9I/wkyzHT+7x7gW57+mb
X-Received: by 2002:adf:e84f:0:b0:313:e391:e492 with SMTP id d15-20020adfe84f000000b00313e391e492mr1880302wrn.17.1694709498617;
        Thu, 14 Sep 2023 09:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBOthBlD0bgX2N8wV+hRehTPip5ujqkbdNT+j7la9Evm0t96iLWUoZqxs1LEG97yVEpxc/lA==
X-Received: by 2002:adf:e84f:0:b0:313:e391:e492 with SMTP id d15-20020adfe84f000000b00313e391e492mr1880286wrn.17.1694709498264;
        Thu, 14 Sep 2023 09:38:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b0031f300a4c26sm2175932wrq.93.2023.09.14.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:38:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/ssd130x: Store the HW buffer in the
 driver-private CRTC state
In-Reply-To: <b4gfkcv3zdtdgcpucufwfmi7225redkxll75gr72zdirqtrrj4@u4kvevdmhtvt>
References: <20230913052938.1114651-1-javierm@redhat.com>
 <4norb2kxq4uxs3imi3qjxhyxpvnyf5cpl4sg7yyf3ydrykqhfl@cb3w4wstak7r>
 <871qf028ie.fsf@minerva.mail-host-address-is-not-set>
 <b4gfkcv3zdtdgcpucufwfmi7225redkxll75gr72zdirqtrrj4@u4kvevdmhtvt>
Date:   Thu, 14 Sep 2023 18:38:16 +0200
Message-ID: <8734zg677r.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

> On Thu, Sep 14, 2023 at 03:23:53PM +0200, Javier Martinez Canillas wrote:
>> Maxime Ripard <mripard@kernel.org> writes:
>> 
>> Hello Maxime,
>> 
>> > Hi,
>> >
>> > On Wed, Sep 13, 2023 at 07:29:25AM +0200, Javier Martinez Canillas wrote:
>> >>  static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
>> >>  	.mode_valid = ssd130x_crtc_helper_mode_valid,
>> >> -	.atomic_check = drm_crtc_helper_atomic_check,
>> >> +	.atomic_check = ssd130x_crtc_helper_atomic_check,
>> >>  };
>> >
>> > Sorry I didn't catch that sooner, but there's no reason to call that
>> > function a helper.
>> >
>> 
>> Yeah, agreed that there's no reason but others drivers already add the
>> _helper prefix for struct drm_*_helper_funcs callbacks, and I did that
>> in this driver as well to follow (what appears to be?) a convention.
>
> From a quick grep, it looks like it's the exception rather than the norm
>

Ah, I guess that was just unlucky when looking at others drivers as
reference when writing this one.

>> So I've to that now for the struct drm_crtc_helper_funcs handlers to be
>> consistent with the rest of the driver, e.g for plane:
>> 
>> static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
>> 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>> 	.atomic_check = ssd130x_primary_plane_helper_atomic_check,
>> 	.atomic_update = ssd130x_primary_plane_helper_atomic_update,
>> 	.atomic_disable = ssd130x_primary_plane_helper_atomic_disable,
>> };
>> 
>> static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
>> 	.update_plane = drm_atomic_helper_update_plane,
>> 	.disable_plane = drm_atomic_helper_disable_plane,
>> 	.reset = ssd130x_primary_plane_reset,
>> 	.atomic_duplicate_state = ssd130x_primary_plane_duplicate_state,
>> 	.atomic_destroy_state = ssd130x_primary_plane_destroy_state,
>> 	.destroy = drm_plane_cleanup,
>> };
>
> Ack.
>
> I still believe we should be removing the helper part, those are not
> helpers. But it's not a big deal anyway.
>

Probably it comes down to semantics since one could argue that are helper
functions in the driver that are used as callbacks.

But yes, I agree that if is not the norm, it's better to get rid of those.
I'll post a follow-up patch.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

