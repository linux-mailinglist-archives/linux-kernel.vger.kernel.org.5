Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF29375AC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGTKnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE185171B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689849746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s8/QNK9aMUaZdF5PbcawFqcpmmy8WkA3CGA4nPhCcCE=;
        b=HYLk1YOpmNJVWmugdqAIJcWt3j91RAZ0vKAdN+JAcJNlPAm/3mUuz5Ut36MwntmeUQmAiY
        gprpPTKb5WSyOot80lklzfVGf6cQMh0+2k62QTEDskYvDIt+rwZofjQHu2zpG1lkxd5HXP
        cZOWfNHOBxRHBz9bOB9/ka/kTumDt5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-akr8w9otM2219EkUuhg6wA-1; Thu, 20 Jul 2023 06:42:24 -0400
X-MC-Unique: akr8w9otM2219EkUuhg6wA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315a03cae87so814729f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689849743; x=1690454543;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8/QNK9aMUaZdF5PbcawFqcpmmy8WkA3CGA4nPhCcCE=;
        b=X4ljVRclhVT0i/hgeIKlLsNgd9yOoH8s6BZtMvZcMLVCG9I8Q1p/H/z/aii5zdUpTc
         BqPkakYMNKPTbWFmHXBeiIdsP35WQz2WXH85jmIqnd6Vsz7Nm2NH71/J/EpM1UcZqtqk
         CnIfq4PCzu5m7ug0dsYbFNscM64QbzevqOLkTPRBzl5DeQSFinlqo8iIG9SxeHZylo9w
         wXnqv1Pm8zp9zdRw4H/7F/R/j83+6+6nTQ1ivJTooqR3vqa119lZgCEuvlHc1MzkuxIe
         idK+Awuzsz0Ta3YYotnoTIf2dIEFQVVIkLyeLVFqp0gbHKQpbgZ3Qp6/ioSfCj2opDXm
         zD6w==
X-Gm-Message-State: ABy/qLbdX68ooeJ6WR6O+IaJvEr9gSmvbpQTJABsWLPjUREqo1kRpsy0
        DdiXEY4SjY75Fr7OIieZwOPMz60RZto7fQug1yiH+ESxlW/BeCZVB4ObkAQGc6BValJABDhy9Mb
        Et9JIGZHb5giktnOcYDYxx9M1YvxB3ytE
X-Received: by 2002:a5d:684b:0:b0:314:3e96:bd7e with SMTP id o11-20020a5d684b000000b003143e96bd7emr2366482wrw.4.1689849743445;
        Thu, 20 Jul 2023 03:42:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMNc4DgpuEF386zoNSiKXYMeDCfdF3dk3DGXK5Uhi37HIkp4KWrrVHNkylycNEbWdq0OXybA==
X-Received: by 2002:a5d:684b:0:b0:314:3e96:bd7e with SMTP id o11-20020a5d684b000000b003143e96bd7emr2366467wrw.4.1689849743156;
        Thu, 20 Jul 2023 03:42:23 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d6e0a000000b003141e9e2f81sm987499wrz.4.2023.07.20.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:42:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
In-Reply-To: <c5khbm4v2ynjgcfhin2htixkyuycfydr6rie5irnyu6gytxg6q@4ghg4ufjgnfx>
References: <20230717163027.480918-1-javierm@redhat.com>
 <c5khbm4v2ynjgcfhin2htixkyuycfydr6rie5irnyu6gytxg6q@4ghg4ufjgnfx>
Date:   Thu, 20 Jul 2023 12:42:21 +0200
Message-ID: <87pm4mj242.fsf@minerva.mail-host-address-is-not-set>
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

Maxime Ripard <mripard@redhat.com> writes:

Hello Maxime,

Thanks a lot for your feedback.

> Hi,
>
> On Mon, Jul 17, 2023 at 06:30:22PM +0200, Javier Martinez Canillas wrote:
>> Geert reports that the following NULL pointer dereference happens for him
>> after commit 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each
>> plane update"):
>> 
>>     [drm] Initialized ssd130x 1.0.0 20220131 for 0-003c on minor 0
>>     ssd130x-i2c 0-003c: [drm] surface width(128), height(32), bpp(1)
>>     and format(R1   little-endian (0x20203152))
>>     Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>     Oops [#1]
>>     CPU: 0 PID: 1 Comm: swapper Not tainted
>>     6.5.0-rc1-orangecrab-02219-g0a529a1e4bf4 #565
>>     epc : ssd130x_update_rect.isra.0+0x13c/0x340
>>      ra : ssd130x_update_rect.isra.0+0x2bc/0x340
>>     ...
>>     status: 00000120 badaddr: 00000000 cause: 0000000f
>>     [<c0303d90>] ssd130x_update_rect.isra.0+0x13c/0x340
>>     [<c0304200>] ssd130x_primary_plane_helper_atomic_update+0x26c/0x284
>>     [<c02f8d54>] drm_atomic_helper_commit_planes+0xfc/0x27c
>>     [<c02f9314>] drm_atomic_helper_commit_tail+0x5c/0xb4
>>     [<c02f94fc>] commit_tail+0x190/0x1b8
>>     [<c02f99fc>] drm_atomic_helper_commit+0x194/0x1c0
>>     [<c02c5d00>] drm_atomic_commit+0xa4/0xe4
>>     [<c02cce40>] drm_client_modeset_commit_atomic+0x244/0x278
>>     [<c02ccef0>] drm_client_modeset_commit_locked+0x7c/0x1bc
>>     [<c02cd064>] drm_client_modeset_commit+0x34/0x64
>>     [<c0301a78>] __drm_fb_helper_restore_fbdev_mode_unlocked+0xc4/0xe8
>>     [<c0303424>] drm_fb_helper_set_par+0x38/0x58
>>     [<c027c410>] fbcon_init+0x294/0x534
>>     ...
>> 
>> The problem is that fbcon calls fbcon_init() which triggers a DRM modeset
>> and this leads to drm_atomic_helper_commit_planes() attempting to commit
>> the atomic state for all planes, even the ones whose CRTC is not enabled.
>> 
>> Since the primary plane buffer is allocated in the encoder .atomic_enable
>> callback, this happens after that initial modeset commit and leads to the
>> mentioned NULL pointer dereference.
>
> I think that's where the problem lies: you must not allocate a buffer in
> atomic_enable.
>
> After drm_atomic_helper_swap_state(), the new commit is being applied
> and you aren't allowed to fail, and an allocation can fail.
>
> Everything needs to be prepared by the time _swap_state is called, and
> it's one of the point of atomic_check.
>
> So you need to allocate your buffer there, and use it in whatever
> atomic_commit related hook you need it in.
>
> The typical way of doing this would be to create a custom state
> structure that embeds the global one, create your own reset,
> atomic_duplicate_state and atomic_destroy_state implementations, and
> store the buffer pointer there.
>

I see. That makes totally sense to me. I'll do that in v4 then!

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

