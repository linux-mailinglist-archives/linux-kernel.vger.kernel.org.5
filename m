Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052C67EB627
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjKNSJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjKNSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A887121
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699985389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7C7wW8Bb55AP5fqpBh20EWuPiJ+kxnmpZ3Q7RhkSlhM=;
        b=aRpOE9BokjZKAr0bGVvJJCr6m3dcod1iyEH8PVFa9opQrN17itDHKDm+tV+L6IuHnsYQH1
        AfPS7dSO7omu/VtwVieL9rIInX13sNppIazWmfMP0o9cmolB29a7v2wDtzgYf1dQqU3GXV
        hKh/cUh0/2mjJf0h4Q1gGQYZHwk2dww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-qYaEBM26PqKVdKi26FpbcQ-1; Tue, 14 Nov 2023 13:09:47 -0500
X-MC-Unique: qYaEBM26PqKVdKi26FpbcQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f7384d5a2so2747244f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985386; x=1700590186;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C7wW8Bb55AP5fqpBh20EWuPiJ+kxnmpZ3Q7RhkSlhM=;
        b=X4YPxs9n5Qh6HRmC4tQFyeUpQ/2cBj6fFF4MFgzyKWECjzGgUPlysvUhxojjZOXCQ2
         We3rrSL6LUyiOS+WOeeQvAZurBRLfk9WoWCA/uNFDZajYnuZaDqCLeNxLNZWr60BLrpn
         aAfTJ4H+IRAM6Ht/UEVywCCAlTcNpdQ5+a8cfgNzNxg+1YbfwN5NZOjANDeX1EwcRrg7
         dItSXdsaM1MsISyrjxzva/EV0eBE8ykC8ndMv9APLZnlpYcPKNGmCxbLzp0QlRinYGER
         +PXatVHxlB5kKTP59uWgvR9SyKFdHmjexZTCQpuXyOTOrimFfeSJbyESY7f5zpg3t6mW
         4rZQ==
X-Gm-Message-State: AOJu0Yy4bQ/vReWcP1ZE4HwiYiMvbgDfZjjphcrT28oJc548kmI6zEDO
        6meZtbyi2ap+L8zexb3j49KSHi5ATgWb97qk0nhIzCv7ciFI0mnf1JWlezp2Clzn0WjsMaB6M5z
        T3dNFDb7FQGL/ipL3vHhVc4NZ
X-Received: by 2002:a05:6000:1567:b0:319:867e:97d7 with SMTP id 7-20020a056000156700b00319867e97d7mr9247568wrz.52.1699985386723;
        Tue, 14 Nov 2023 10:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQK+7LGbBm9NWV35d1R+NImBNQNggBVsNQ2twsZUsBZR8uiQcCCjKalWkzse4WmlZcEOZ58Q==
X-Received: by 2002:a05:6000:1567:b0:319:867e:97d7 with SMTP id 7-20020a056000156700b00319867e97d7mr9247549wrz.52.1699985386363;
        Tue, 14 Nov 2023 10:09:46 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4847000000b0032d88e370basm8419537wrs.34.2023.11.14.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 10:09:46 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     nerdopolis <bluescreen_avenger@verizon.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>, stable@vger.kernel.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: Re: [PATCH 2/6] drm: Add
 drm_atomic_helper_buffer_damage_{iter_init,merged}() helpers
In-Reply-To: <a8731f9f-3652-4efd-b40e-06a792d0fccf@suse.de>
References: <20231109172449.1599262-1-javierm@redhat.com>
 <20231109172449.1599262-3-javierm@redhat.com>
 <c4fdfec8-aa9a-4a09-94c4-114595cf5596@suse.de>
 <8734x872dy.fsf@minerva.mail-host-address-is-not-set>
 <a8731f9f-3652-4efd-b40e-06a792d0fccf@suse.de>
Date:   Tue, 14 Nov 2023 19:09:45 +0100
Message-ID: <87r0ks5hqu.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 14.11.23 um 16:58 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>> Hello Thomas,
>> 
>> Thanks a lot for your feedback.
>> 
>>> Hi
>>>
>>> Am 09.11.23 um 18:24 schrieb Javier Martinez Canillas:
>>>> To be used by drivers that do per-buffer (e.g: virtio-gpu) uploads (rather
>>>> than per-plane uploads), since these type of drivers need to handle buffer
>>>> damages instead of frame damages.
>>>>
>>>> The drm_atomic_helper_buffer_damage_iter_init() has the same logic than
>>>> drm_atomic_helper_damage_iter_init() but it also takes into account if the
>>>> framebuffer attached to plane's state has changed since the last update.
>>>>
>>>> And the drm_atomic_helper_buffer_damage_merged() is just a version of the
>>>> drm_atomic_helper_damage_merged() helper, but it uses the iter_init helper
>>>> that is mentioned above.
>>>>
>>>> Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
>>>> Cc: <stable@vger.kernel.org> # v6.4+
>>>> Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
>>>> Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
>>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>>> ---
>>>>
>>>>    drivers/gpu/drm/drm_damage_helper.c | 79 ++++++++++++++++++++++++++---
>>>>    include/drm/drm_damage_helper.h     |  7 +++
>>>>    2 files changed, 80 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
>>>> index aa2325567918..b72062c9d31c 100644
>>>> --- a/drivers/gpu/drm/drm_damage_helper.c
>>>> +++ b/drivers/gpu/drm/drm_damage_helper.c
>>>> @@ -204,7 +204,8 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
>>>>    static void
>>>>    __drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
>>>>    				     const struct drm_plane_state *old_state,
>>>> -				     const struct drm_plane_state *state)
>>>> +				     const struct drm_plane_state *state,
>>>> +				     bool buffer_damage)
>>>
>>> I think it would be preferable to drop patches one and two and instead
>>> add this parameter directly to drm_atomic_helper_damage_iter_init() and
>>> drm_atomic_helper_damage_merged().  That's a bit of churn, but more
>>> readable code.
>>>
>> 
>> Makes sense. I'll do that in v2.
>
> Instead of modifying these function interfaces, it might be even better 
> to introduce a state flag in struct drm_plane_state that you can modify 
> in the plane's atomic_check helper. Something simple like this:
>
>    if (old_fb != new_fb)
>      plane_state->ignore_damage_clips = true;
>
> in the affected drivers/planes. In drm_atomic_helper_damage_iter_init() 
> you can use it to generate a full update. This avoids the churn and is 
> in line with the overall check/commit design of the DRM framework.
>

Thanks. That indeed seems more aligned with the rest of the DRM framework.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

