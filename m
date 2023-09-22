Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B178D7AAECA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjIVJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADD2197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695376246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZdUq4bBr+9g8/wPQcLNCnBOGM2aLPYGN/Yjl9htiv8=;
        b=OHxueu3FWwbqtfLrwVFmnvyU5GgCcOJ22Fq7OgVUcHQ6RZH7nq/0Ag/l2rCgLCM1EY1zff
        +HfMl6OZFNfxvTMxeQS/Zm+GT29uGAAnmDO7vHuntj5sqUNWE+B+bBahjVu0Erbo1SpsAr
        as9U5v/YwlS9C1mwF3rbGUowOiD8Qmg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59--OwMjsYoM_-aLn9idjT4vw-1; Fri, 22 Sep 2023 05:50:43 -0400
X-MC-Unique: -OwMjsYoM_-aLn9idjT4vw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4053f023d77so2905265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695376242; x=1695981042;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZdUq4bBr+9g8/wPQcLNCnBOGM2aLPYGN/Yjl9htiv8=;
        b=JlRwxggxRgnmSibqQ3V4kjtQ5KeFT1tWHxKtecRzVmAkmZqN7rqa+n3IBBKliCpDwe
         d79ac5A8jXif+5iygrAcwMFcsy6AnGZ7UkgZvysqnNFH09q7wsaT9Cc+Bqpy7lvH6mXC
         1A0UwIkBiRZiAzQG/ONbmHrm8NyZSGky/0vYYrIgzyvEPXjnSmLMO61ny2QwV2IIxnH0
         LYsKUJL/J4W3NZJqQfQDJFkv/eumtU83QusLdPtH8yaHFOowK8LAjLoGHdFhPp01Y1Ni
         vWP5yRiwQNK9fJwr3V39fqGNTI4hY/p6FeEHInEBZI8MHaPCcNL9xaj55tv15GE9GkDF
         MTDQ==
X-Gm-Message-State: AOJu0YyVKzREONsCS3P4TDwndE5SCc1UvdM/fH8HFS0HPClcJAXKLCgd
        /2hLMgmb9hJVhgGj38g9GwgKLbo7gf1gOwkOtmGwfXFq+A/zsNza5qv4/FqaiMNMn71WUnfcNFH
        go6JSDx1Mcfh0IBq4b3HCOZuy
X-Received: by 2002:a05:600c:2e4c:b0:405:3f06:c075 with SMTP id q12-20020a05600c2e4c00b004053f06c075mr876352wmf.6.1695376242593;
        Fri, 22 Sep 2023 02:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkca4yZ67Qrwm6oiKqUmbmS5dmwU75efDVvG95Z6Zrk7fJrIHZ6senSxziEpE9nmlan6YTvA==
X-Received: by 2002:a05:600c:2e4c:b0:405:3f06:c075 with SMTP id q12-20020a05600c2e4c00b004053f06c075mr876329wmf.6.1695376242207;
        Fri, 22 Sep 2023 02:50:42 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b003fe1630a8f0sm7019555wmb.24.2023.09.22.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:50:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
In-Reply-To: <f171c049112dfc21f0a1127edcd5717f.mripard@kernel.org>
References: <20230914195138.1518065-1-javierm@redhat.com>
 <f171c049112dfc21f0a1127edcd5717f.mripard@kernel.org>
Date:   Fri, 22 Sep 2023 11:50:41 +0200
Message-ID: <87sf76k03y.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Maxime Ripard" <mripard@kernel.org> writes:

> On Thu, 14 Sep 2023 21:51:24 +0200, Javier Martinez Canillas wrote:
>> The driver uses a naming convention where functions for struct drm_*_funcs
>> callbacks are named ssd130x_$object_$operation, while the callbacks for
>> struct drm_*_helper_funcs are named ssd130x_$object_helper_$operation.
>> 
>> The idea is that this helper_ prefix in the function names denote that are
>> 
>> [ ... ]
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

