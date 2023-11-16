Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212FB7EDC33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbjKPHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344907AbjKPHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE9197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700120779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LD5mFa7Ljzodyl4DGNnE3tN04HrOGXS/NNuwBDagln8=;
        b=Zid15TOMC+cBvGr10gBGkotPix/ciruvxBNqe05kXbMxbaHeT2LH15QRsVik+x9LUFJt6P
        nK/Mv41CsBd53PLu429+Aiuu8Cgu7kBaBatOMfvzU0D2Y2w6rautRJB1O2rIqVnC0cAQvk
        cb2M9TZJESOD74zvqeSotjrZnPpajTs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-JHaY_QM1NluVcfMrLW-tVQ-1; Thu, 16 Nov 2023 02:46:17 -0500
X-MC-Unique: JHaY_QM1NluVcfMrLW-tVQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-407da05ee50so2878205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700120776; x=1700725576;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD5mFa7Ljzodyl4DGNnE3tN04HrOGXS/NNuwBDagln8=;
        b=oBeIFhk/WICbSn8p9DRLTiiz+G8K/lsW6Kziab1dk7YE8AFnJuCh8KliLnXF8IyAU6
         tCYUBOJEi8y/NupMo8y+arW5FavfGn5+8xkNTaiXbQulvnnhxDQx2Foh24UDBnX5/m4U
         2y4kZv6j4+ER9IJu0PpUOUV9HsNVy6xepkLfPhadSr5ESYkBd4kCLHhQ6WvPlrzsybfU
         48t1EF/5/mHEmm12lJ9Tuga3i94T6QuH/cGDBtOhwemeNpJzpzl8kCSBGh13xS0rh/Ed
         WyiXwEkSIfF+RrDha8RoyMJDB3108KLv6tF326oZ1xVxQKi4pEiqWf2IC4Ssa6Ef5jHH
         DGZA==
X-Gm-Message-State: AOJu0YzEZyzQ8zDKKiZhE8EkdMRF3ce9lxk8zGQsVgdtBmslPifqaHKQ
        YavWl587attlWz0SUIuepVcqlfSNqDgyUbw7iW481fRWHbNtWpndiqfWPWYVdVxpFCzbhWuWy6r
        Lr2rHC9aLZWJX7xOr/YuKro+v
X-Received: by 2002:a05:600c:1d93:b0:406:3977:eccd with SMTP id p19-20020a05600c1d9300b004063977eccdmr11516326wms.33.1700120776413;
        Wed, 15 Nov 2023 23:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNCg5qd5AbZ0tYK0uFvI/J3tJ++zfJ/l5opv0/UGjSHKkjb6Zp4IdC4i38tjSPgJYq49xhdQ==
X-Received: by 2002:a05:600c:1d93:b0:406:3977:eccd with SMTP id p19-20020a05600c1d9300b004063977eccdmr11516314wms.33.1700120776005;
        Wed, 15 Nov 2023 23:46:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0040772138bb7sm2455636wmq.2.2023.11.15.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 23:46:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Zack Rusin <zackr@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "olvaffe@gmail.com" <olvaffe@gmail.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "nunes.erico@gmail.com" <nunes.erico@gmail.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "pekka.paalanen@collabora.com" <pekka.paalanen@collabora.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "belmouss@redhat.com" <belmouss@redhat.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "contact@emersion.fr" <contact@emersion.fr>
Subject: Re: [PATCH v2 0/5] drm: Allow the damage helpers to handle buffer
 damage
In-Reply-To: <a16a61582f90a5b490fb7681b44864a4801c830a.camel@vmware.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
 <a16a61582f90a5b490fb7681b44864a4801c830a.camel@vmware.com>
Date:   Thu, 16 Nov 2023 08:46:14 +0100
Message-ID: <87o7fu5eex.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Rusin <zackr@vmware.com> writes:

Hello Zack,

> On Wed, 2023-11-15 at 14:15 +0100, Javier Martinez Canillas wrote:

[...]

>>
>> Changes in v2:
>> - Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
>>   .atomic_check, instead of having different helpers (Thomas Zimmermann).
>> - Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
>>   .atomic_check instead of using a different helpers (Thomas Zimmermann).
>> - Set struct drm_plane_state .ignore_damage_clips in vmwgfx plane's
>>   .atomic_check instead of using a different helpers (Thomas Zimmermann).
>
> The series looks good to me, thanks for tackling this. I'm surprised that we don't

Thanks. Can I get your r-b or a-b ?

> have any IGT tests for this. Seems like it shouldn't be too hard to test it in a
> generic way with just a couple of dumb buffers.
>

Yes, I haven't looked at it but also think that shouldn't be that hard.

> z

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

