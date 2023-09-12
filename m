Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7230079CB26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjILJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjILJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70DBB10D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694509434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ie1aGQaIRbrMT6CzFJ4g1wwT2IOjL485vR9yiGwk0w=;
        b=bXRbJ9ngcM/b+Ht+/cstznQ3985xqCN3l+GWXmKWmfUlXslNpFr0gniCrBDDrst3gJI6o+
        DpJHahgVS4cma7Sa1Romy1vwWKh75yU3e0FXno4l5/X3OTBxYz/Pve229qGzxrU6LXzCQS
        V5iinGglYmRBtlRZNSHJVam4S+P9LRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-r_OPJfivNWygrvU9DDWK5A-1; Tue, 12 Sep 2023 05:03:53 -0400
X-MC-Unique: r_OPJfivNWygrvU9DDWK5A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-402d63aeea0so44238565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509432; x=1695114232;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ie1aGQaIRbrMT6CzFJ4g1wwT2IOjL485vR9yiGwk0w=;
        b=w4i7eoxXXATdWIGg38kfX7MMy14YAFumxB80uvEVWgd0zE8+UnNoXGtUT5gNdFZk4i
         cn3MOcCMoBZPYsoGb1tHfmG67IY9H5nO1TKCU6d6lY90RCeFKj/7U8rCPaCWAogKxnD2
         c4VdclZmI0nTJLIHuhu/b5LxNRoGt2ABw6CmG7UFw39p0GMulTrsozF1RiM7hqWIGm55
         xEllIR201Em5Wvmt+E/gAvdautOu8TT53f+wgetNp1pevRryvF7/XqV61Gbvmb0ijvqk
         gYUBsRWcOzT9kTbabypza7waGEZWZtscUCPYh/oN/3t2r0uaeCe1+vfNUvD54sSJNbyp
         vMuQ==
X-Gm-Message-State: AOJu0YwcXT7jScDhrMkf82DHfZh37lcpE1D930W5chl41uo5jq/4GRAN
        h+H2i6DSiVawcvYDu89wU6agANg3iSmpegm54X8c+ovyrWFuXyhE+TlG0HHua3EmdY+UngZElFt
        392WngDYnZMIGSa9h0zvu5DyaKwIOg5TK
X-Received: by 2002:a7b:ce07:0:b0:3fb:e4ce:cc65 with SMTP id m7-20020a7bce07000000b003fbe4cecc65mr10555499wmc.25.1694509432036;
        Tue, 12 Sep 2023 02:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8kSp3LWlS416Fsrz1DxxVgbcqE0KhWdg1a+7byaaHFe448CF3O2UiGIrVuazKuDWQYhyPQQ==
X-Received: by 2002:a7b:ce07:0:b0:3fb:e4ce:cc65 with SMTP id m7-20020a7bce07000000b003fbe4cecc65mr10555477wmc.25.1694509431640;
        Tue, 12 Sep 2023 02:03:51 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b00402d34ea099sm15524966wmf.29.2023.09.12.02.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:03:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/ssd130x: Store the HW buffer in the
 driver-private CRTC state
In-Reply-To: <x75lakzrl2awslaid5ffneepxusej7b7ojvz36bgpdwriztcru@h4bvwr2oeaov>
References: <20230910094041.715408-1-javierm@redhat.com>
 <x75lakzrl2awslaid5ffneepxusej7b7ojvz36bgpdwriztcru@h4bvwr2oeaov>
Date:   Tue, 12 Sep 2023 11:03:50 +0200
Message-ID: <874jjz3gqx.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

Thanks for your feedback!

> Hi,
>
> On Sun, Sep 10, 2023 at 11:40:28AM +0200, Javier Martinez Canillas wrote:

[...]

>>  static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
>> -			       struct ssd130x_plane_state *ssd130x_state,
>> -			       struct drm_rect *rect)
>> +			       struct drm_rect *rect, u8 *buf,
>> +			       u8 *data_array)
>>  {
>>  	unsigned int x = rect->x1;
>>  	unsigned int y = rect->y1;
>> -	u8 *buf = ssd130x_state->buffer;
>> -	u8 *data_array = ssd130x_state->data_array;
>
> That's just a matter of taste I guess, but I would pass the crtc_state
> pointer there instead of an opaque byte array (without any boundary).
>

Interesting that you mentioned, I was actually on the fence on this. The
reason why I passed an opaque byte array was that Geert had it in his R1
series and wanted to align with the changes that he was doing in that set:

https://lists.freedesktop.org/archives/dri-devel/2023-August/419935.html

But I'm OK of with passing the state pointers instead. BTW, you said
crtc_state but is plane_state since the function uses both buffers.

[...]

>>  
>> @@ -671,6 +664,10 @@ static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
>>  	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>>  	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>>  	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
>
> You can have CRTC-less commits if you only modify a property of the
> plane for example. drm_atomic_get_new_crtc_state will retrieve the CRTC
> state in the global state passed as an argument, but will not make any
> effort to retrieve the current CRTC state if it's not part of that commit.
>

Oh, I see. I wasn't aware of this.

> You should add a call to drm_atomic_get_crtc_state in your atomic_check
> hook to pull the CRTC state if it's not there so you can rely on it
> here.
>

Got it. I'll fix that in v2.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

