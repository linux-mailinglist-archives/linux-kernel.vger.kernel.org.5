Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3713752873
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjGMQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjGMQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC325273B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689266045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jqgy2NuZDpJuPq/q4dfniYMdoYxkOs252udDJ3IijVE=;
        b=DcP3IbufE1D/2F2gD3lhoIiZUEOXTyNqEjMxDSjooVJ7vETe/5jCZ2tx3lO51vLG9pT61I
        +5DLZuQOGmWa79ZXu8hoE1XDrAeYzmLxyypzw/L+MlQ3x0O1UCWxtHalgnDxhRRiBHkjBi
        NWFQ2MrxPt212aITMQfTEe9Jp+lEiTY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-rh1JnKHNM1SsYVwb9u3igw-1; Thu, 13 Jul 2023 12:34:04 -0400
X-MC-Unique: rh1JnKHNM1SsYVwb9u3igw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbdf34184eso4888065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266043; x=1691858043;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqgy2NuZDpJuPq/q4dfniYMdoYxkOs252udDJ3IijVE=;
        b=O28cilKL8zuTZgnGCECYzMQA3Tt6o2VxrHI9RzR52bFtdihjGyfNAULXtpnxs4L6j0
         JWV/13zCcz6MrgYhi03UTdoQfelsSx3rjC0OGO9R/a59zrKtjzHCjEnE7d/BiFhgbRiW
         TAAAxOT2oTpDIJ9Detqz5nmXMSA/Hdd0C3MyjpjSwbgEHCXGGsq9Fezj9zr+GXK2Eo6Q
         0dom/V747ACBoxk8BLqYFmEMlBONaJnHL+mRjoGKkuLmFjAM0Y7he/8bu/+pywYqfWGA
         lMWbkqodeqDAqfPIqNptkSsY8O5DMkkm3wEKeJC3icRctEDWm/UYe2N58GjoJFQpSbEK
         BvDQ==
X-Gm-Message-State: ABy/qLZIfWWeGyFKC/yzN3tNu1hpMUVDUHF1Y5YEIr1p2TR8MepOcc4T
        kLqcJrCgWzWHv4QoJ5qZvehY+I/03hKkpyOmoiHtk1n00xiS9FLVVJ9VVp16xRjPKAPQyOGQv5Y
        xAU3xcN2Y9et5Q0UHYVgkk9q/
X-Received: by 2002:a05:600c:224d:b0:3f7:f584:579b with SMTP id a13-20020a05600c224d00b003f7f584579bmr1820694wmm.9.1689266043322;
        Thu, 13 Jul 2023 09:34:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGB48a8/IM2uKa2p6JFLwk6Xk5qAm/U1NNQ7v8jofP8DEBAsgQXzUHUaj2EJJbJ4ewjj9iRwA==
X-Received: by 2002:a05:600c:224d:b0:3f7:f584:579b with SMTP id a13-20020a05600c224d00b003f7f584579bmr1820686wmm.9.1689266043065;
        Thu, 13 Jul 2023 09:34:03 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q21-20020a7bce95000000b003fc06169abdsm8326018wmj.2.2023.07.13.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:34:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/5] drm/ssd130x: Don't allocate buffers on each
 plane update
In-Reply-To: <CAMuHMdX3VNcP1MS_Padps2Qwy=cmAU-4=XddVj+4-1sevCuErg@mail.gmail.com>
References: <20230609170941.1150941-1-javierm@redhat.com>
 <20230609170941.1150941-5-javierm@redhat.com>
 <CAMuHMdVXhi52KfpCmnum+9t74UWP+AOLE95xQU6VV6Nz=VHk1Q@mail.gmail.com>
 <87fs5sgdfh.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWmJjGX+s=z0bBMDz0=zqZJHrGhkzWyRkmstS0eW9aiTg@mail.gmail.com>
 <87cz0vhpd1.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdX3VNcP1MS_Padps2Qwy=cmAU-4=XddVj+4-1sevCuErg@mail.gmail.com>
Date:   Thu, 13 Jul 2023 18:34:01 +0200
Message-ID: <87zg3zu5xi.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,

[...]

>> +static const struct drm_mode_config_helper_funcs ssd130x_mode_config_helpers = {
>> +        .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>> +};
>> +
>>  static const uint32_t ssd130x_formats[] = {
>>         DRM_FORMAT_XRGB8888,
>>  };
>> @@ -923,6 +927,7 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
>>         drm->mode_config.max_height = max_height;
>>         drm->mode_config.preferred_depth = 24;
>>         drm->mode_config.funcs = &ssd130x_mode_config_funcs;
>> +       drm->mode_config.helper_private = &ssd130x_mode_config_helpers;
>>
>>         /* Primary plane */
>>
>
> Thanks, that works!
>

Thanks for testing! Proper patch sent:

https://lists.freedesktop.org/archives/dri-devel/2023-July/413630.html

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

