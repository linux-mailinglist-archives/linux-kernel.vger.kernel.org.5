Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D0E7A0582
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbjINNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbjINNYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDEF91FDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694697839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uFwzQssh5fc2VAqJw0Fiz1bE1/NvSD7FuRwvnyf3cNo=;
        b=WBGJdSG9IBoVaLH1aXGQVnoF0TTLYqKy8KX4HcRY81hVMyYRIYzKD/GoUWPHjJJ24MoY/a
        TD1eOilvxC39rgSAME9nFGzvJGZAiVLMUFoMNJrQZVfqfV89OjiQPBZWW8o/8PZRhKITgi
        80dfqxDH9W65CYJ/pie5Tiozody+5b0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-eM4KZqX0Ni-Toq0wOTEORw-1; Thu, 14 Sep 2023 09:23:56 -0400
X-MC-Unique: eM4KZqX0Ni-Toq0wOTEORw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c5c762f97so667088f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697834; x=1695302634;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFwzQssh5fc2VAqJw0Fiz1bE1/NvSD7FuRwvnyf3cNo=;
        b=PAK51e0Wc75QbWsL3b9AHy2BdhzJvo/TThh8Zx7JLogcei+yjL9qxQhKdyBFk3ie3P
         pL9WGzJYNe07wOF5GwcFB849CTk1aR9Xx3TzBP0QJJ6QkCremiXarpE2Nvq0Peklomy8
         S4O649NB67trePYrsM055m3J2dRdYIf85dvylokZZ+RtS9Ep2TZTQZS48thnHAuAHFqB
         eDAo/voFDWgILPS/N5sgJ1VJIQjr0puwu3GZT/U25gMR/qh9Cu3l0GRMzPey6KCPzuSC
         dN77U4YM0WZUc6HVMVGhYzsR+H4bALMZYDf/+6woCnOrRItili/TR0vVnwhX+mVs/d9N
         JfNQ==
X-Gm-Message-State: AOJu0YyBp5SIJTTk6pRl+JmBRZyiefaw5YxrfxfDHLHf97qMiEzQTnJ0
        g8tcyGeEJHosY1WhnFdRnsujaeTDgVH1AyFvmIAyHuu41NwEAGLyPTve2DkL785UGpv4b6HxFgY
        WywWwAaS9oMi32otZFYr6/HcT
X-Received: by 2002:adf:a45c:0:b0:31f:d52a:82b4 with SMTP id e28-20020adfa45c000000b0031fd52a82b4mr1962680wra.57.1694697834743;
        Thu, 14 Sep 2023 06:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV6PIj0s5P5W7Ebly6ktcl1cL+Olu/RKBWGxM4016ZL3sE37WLvQXfMuCZC/k6rZ1Jgt5cMw==
X-Received: by 2002:adf:a45c:0:b0:31f:d52a:82b4 with SMTP id e28-20020adfa45c000000b0031fd52a82b4mr1962661wra.57.1694697834368;
        Thu, 14 Sep 2023 06:23:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w16-20020adfec50000000b0031ad5470f89sm1755283wrn.18.2023.09.14.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:23:54 -0700 (PDT)
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
In-Reply-To: <4norb2kxq4uxs3imi3qjxhyxpvnyf5cpl4sg7yyf3ydrykqhfl@cb3w4wstak7r>
References: <20230913052938.1114651-1-javierm@redhat.com>
 <4norb2kxq4uxs3imi3qjxhyxpvnyf5cpl4sg7yyf3ydrykqhfl@cb3w4wstak7r>
Date:   Thu, 14 Sep 2023 15:23:53 +0200
Message-ID: <871qf028ie.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> Hi,
>
> On Wed, Sep 13, 2023 at 07:29:25AM +0200, Javier Martinez Canillas wrote:
>>  static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
>>  	.mode_valid = ssd130x_crtc_helper_mode_valid,
>> -	.atomic_check = drm_crtc_helper_atomic_check,
>> +	.atomic_check = ssd130x_crtc_helper_atomic_check,
>>  };
>
> Sorry I didn't catch that sooner, but there's no reason to call that
> function a helper.
>

Yeah, agreed that there's no reason but others drivers already add the
_helper prefix for struct drm_*_helper_funcs callbacks, and I did that
in this driver as well to follow (what appears to be?) a convention.

So I've to that now for the struct drm_crtc_helper_funcs handlers to be
consistent with the rest of the driver, e.g for plane:

static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
	.atomic_check = ssd130x_primary_plane_helper_atomic_check,
	.atomic_update = ssd130x_primary_plane_helper_atomic_update,
	.atomic_disable = ssd130x_primary_plane_helper_atomic_disable,
};

static const struct drm_plane_funcs ssd130x_primary_plane_funcs = {
	.update_plane = drm_atomic_helper_update_plane,
	.disable_plane = drm_atomic_helper_disable_plane,
	.reset = ssd130x_primary_plane_reset,
	.atomic_duplicate_state = ssd130x_primary_plane_duplicate_state,
	.atomic_destroy_state = ssd130x_primary_plane_destroy_state,
	.destroy = drm_plane_cleanup,
};

> With that fixed (and feel free to fix while applying)
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
>
> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

