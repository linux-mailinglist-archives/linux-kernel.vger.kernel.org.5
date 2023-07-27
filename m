Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19B7657FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjG0Psa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjG0Ps2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB8E2686
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690472857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQK975Q3UCxrDp8lGcKZZKIqwI2vHYZMtaPHzBySI8Y=;
        b=XTN+irqSHGwdv7jmCnEqdd+6u18KF5QekODX5nl32HROkADC0uNzZzqQNBq/G/uwy30pi0
        hV0wY3whWE7g44qJE2yHKU/YSOAxM3eSm0OYn0VHTdwITwk7Yci2eCiUfKDa0YGYUJcxqi
        AdXMog4GVSHVDNmzLUkMLBk27guwU7M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-0UapSJkfM4yjnTEsUiVNfQ-1; Thu, 27 Jul 2023 11:47:36 -0400
X-MC-Unique: 0UapSJkfM4yjnTEsUiVNfQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f2981b8364so613555f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690472855; x=1691077655;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQK975Q3UCxrDp8lGcKZZKIqwI2vHYZMtaPHzBySI8Y=;
        b=k5xjgspzYu1xBZ/m+AJDw62SZDPrmtdQceLXzFvDVk0gpjA2FmXf6tx11XZk0lcvDv
         BQrvWYg6D8DDUcIR8W/XRrfU+6tu6rsPjMxh3z9jI6aEuo7aCL7hXMHP1W0xwz5+Zf57
         5omchowvz6dqj5BcS/6ljAUMtF/BFRoCXZwYHqfLjO0gpvZhpZXr9xPUjrQns8NAvPQg
         kDnqQbX1fhp4WU1d274yiVkHBQCP7Bqkxo8+TbpS8dY13yWEU+OXsr4STqBOTSzw125X
         EGv+AExDmCckS/La/LqaMZOshWVWLFCJR9qSDO0tEqhNHyYjoJe+EVxvb1kd83Qn3Owx
         EYYQ==
X-Gm-Message-State: ABy/qLYwlMjiwtPy/3oYhhH07r6AJKzJan2nYNFo0rUqe7AtjKeISQzC
        Ou2g7LzfcYrk1x9eT7KkRMB5x7x8/FLctLb9lAQlkvahNWnTWJWHpY8BndtiL5qshMKU8zR4qzA
        TZWE1TCKTlaWmQ8j/ljUj3djc
X-Received: by 2002:a05:6000:1111:b0:313:f61c:42ab with SMTP id z17-20020a056000111100b00313f61c42abmr2259820wrw.56.1690472854992;
        Thu, 27 Jul 2023 08:47:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG60W7O9hB86VxOl6UThIIW1lacXUNHxKNHaxiNPNwewm5qhXaPHuBBkzmkEyFN9uiAy2MS3g==
X-Received: by 2002:a05:6000:1111:b0:313:f61c:42ab with SMTP id z17-20020a056000111100b00313f61c42abmr2259806wrw.56.1690472854640;
        Thu, 27 Jul 2023 08:47:34 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020adffcce000000b00316eb7770b8sm2456191wrs.5.2023.07.27.08.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:47:34 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Use shadow-buffer helpers when managing
 plane's state
In-Reply-To: <87y1j1tme2.fsf@minerva.mail-host-address-is-not-set>
References: <20230727140453.577445-1-javierm@redhat.com>
 <0ce32153-cfc0-e701-3863-803fcdb897ff@suse.de>
 <87y1j1tme2.fsf@minerva.mail-host-address-is-not-set>
Date:   Thu, 27 Jul 2023 17:47:33 +0200
Message-ID: <87o7jxs6ei.fsf@minerva.mail-host-address-is-not-set>
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

> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
> Hello Thomas,
>
>> Hi Javier
>>
>> Am 27.07.23 um 16:04 schrieb Javier Martinez Canillas:
>>> The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
>>> .atomic_check() callback") moved the buffers allocation to be done in
>>> the primary plane's .atomic_check() callback.
>>> 
>>> But it missed that since the driver uses a shadow-buffered plane, the
>>> __drm_gem_{reset,duplicate,destroy}_shadow_plane() helper functions
>>> must be used in the struct drm_plane_funcs handlers.
>>> 
>>> This was missed because the mentioned commit did not remove the macro
>>> DRM_GEM_SHADOW_PLANE_FUNCS, which leads to the custom plane's atomic
>>> state management handlers to not be used.
>>> 
>>> Fixes: 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's .atomic_check() callback")
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Reported-by needs to be followed by
>>
>> Closes: <url>
>>
>> where <url> would point to Arnd's bug report on dri-devel.
>>
>
> Ah, I thought checkpatch complaining about it but since we already add a
> Link: with dim, didn't know what to add there. Makes sense to add Arnd's
> report indeed.
>
> I can include it when applying instead of posting a v2 if you don't mind.
>

Pushed to drm-misc (drm-misc-next), adding:

Closes: https://lore.kernel.org/dri-devel/20230727122412.2464210-1-arnd@kernel.org

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

