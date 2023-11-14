Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E27EB44A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjKNP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D1112F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699977519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBNoiEiOap3tfmenjQPxW4JMLyXGdhX71AJJ3aaGQrY=;
        b=a9uKp9jMrxIdl5wKvnneqNw9JAgiSuprkh1xOPKTjqYf4aX62lM7XIuIFxUcq79+pbfhGW
        IvNSW+ZyaULCZl3b8lOirjw/qdxz3UBkcJnYvAbpe7NOe+J30Rj/ya/Xyiq0Z0GKR8DttF
        0ovwepcJXIOYzX2Gcb64M51nqiK2qP4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-0x8eE1TyPLSuPW6fcHB1dg-1; Tue, 14 Nov 2023 10:58:37 -0500
X-MC-Unique: 0x8eE1TyPLSuPW6fcHB1dg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d91b47f23so58882596d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977516; x=1700582316;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBNoiEiOap3tfmenjQPxW4JMLyXGdhX71AJJ3aaGQrY=;
        b=k6CnwHl+Q4n7438z2ot5M/N9DPCNen6YIlCXa2AiX3XilG0ZulC5rfTSfNbJWUBCaI
         mFK240A7laG251vybj7bD/NrdQlyZLVN9JVNVP4E/sbQqRVtXCLAmEJWbgrkF38YdBuN
         evOHpBIoAj0HcxfeV6nnFyzMk38sYmF/aHu2oGzFVLEAEN3eBgtRi9B3d2nq47/r1ZIz
         frqLZZLjqhVihIwOQoEu8vayu2clbZ9GzEi0px1ku4SUc9f7OWoLY2WBmPvbZZbAgZYX
         wYT0DW+pVxxYkWq6g6QPSKNjvVOQfL4TSdPHFUtmhQveyeGjHOcfzay+4L+daR17rQaW
         u4Ag==
X-Gm-Message-State: AOJu0YxS020IlKFPyEfMehr/vMXfd47EYGSbK2eXqVnK9sIdXfbr/PCK
        N2zkNNlU5agMdyPodsKTrOqZhOMlpkhL+HSE0FKpCyfoaMAgp1SPld+BRZTqE99C9dmUdU+Syy1
        7I8HU1OY3WaEEV4WihUBOk3NT2OVfZc60
X-Received: by 2002:a0c:d803:0:b0:671:9c02:cbaa with SMTP id h3-20020a0cd803000000b006719c02cbaamr2595849qvj.39.1699977516445;
        Tue, 14 Nov 2023 07:58:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcbzCxyPfkeXktmjuQ1rejnRN2Px02gUZbgnNz45wfbmVDzqfZ1kzIsL5k6QsYBr2FO6V3HQ==
X-Received: by 2002:a0c:d803:0:b0:671:9c02:cbaa with SMTP id h3-20020a0cd803000000b006719c02cbaamr2595835qvj.39.1699977516201;
        Tue, 14 Nov 2023 07:58:36 -0800 (PST)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id u6-20020a0ced26000000b0065b229ecb8dsm2999160qvq.3.2023.11.14.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:58:35 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>, stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/6] drm: Add
 drm_atomic_helper_buffer_damage_{iter_init,merged}() helpers
In-Reply-To: <c4fdfec8-aa9a-4a09-94c4-114595cf5596@suse.de>
References: <20231109172449.1599262-1-javierm@redhat.com>
 <20231109172449.1599262-3-javierm@redhat.com>
 <c4fdfec8-aa9a-4a09-94c4-114595cf5596@suse.de>
Date:   Tue, 14 Nov 2023 16:58:33 +0100
Message-ID: <8734x872dy.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Thanks a lot for your feedback.

> Hi
>
> Am 09.11.23 um 18:24 schrieb Javier Martinez Canillas:
>> To be used by drivers that do per-buffer (e.g: virtio-gpu) uploads (rather
>> than per-plane uploads), since these type of drivers need to handle buffer
>> damages instead of frame damages.
>> 
>> The drm_atomic_helper_buffer_damage_iter_init() has the same logic than
>> drm_atomic_helper_damage_iter_init() but it also takes into account if the
>> framebuffer attached to plane's state has changed since the last update.
>> 
>> And the drm_atomic_helper_buffer_damage_merged() is just a version of the
>> drm_atomic_helper_damage_merged() helper, but it uses the iter_init helper
>> that is mentioned above.
>> 
>> Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
>> Cc: <stable@vger.kernel.org> # v6.4+
>> Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
>> Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>   drivers/gpu/drm/drm_damage_helper.c | 79 ++++++++++++++++++++++++++---
>>   include/drm/drm_damage_helper.h     |  7 +++
>>   2 files changed, 80 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
>> index aa2325567918..b72062c9d31c 100644
>> --- a/drivers/gpu/drm/drm_damage_helper.c
>> +++ b/drivers/gpu/drm/drm_damage_helper.c
>> @@ -204,7 +204,8 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
>>   static void
>>   __drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
>>   				     const struct drm_plane_state *old_state,
>> -				     const struct drm_plane_state *state)
>> +				     const struct drm_plane_state *state,
>> +				     bool buffer_damage)
>
> I think it would be preferable to drop patches one and two and instead 
> add this parameter directly to drm_atomic_helper_damage_iter_init() and 
> drm_atomic_helper_damage_merged().  That's a bit of churn, but more 
> readable code.
>

Makes sense. I'll do that in v2.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

