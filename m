Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDF7EB621
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjKNSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E094
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699985211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+Ea5F9/sxF9OVzOjdMf3/GKiJbULr6v8M/iO5If8mA=;
        b=PgySCaPV7U6702rTpjynAX5Vykg1VSUbWo3v5PSGNsI/qx06dGHnC7anhrw92awqGGJeFH
        tlmcC9+fE8N3cXQXEby9ZCbw+3swPTatcAlmjWiqSJqDH19AU3GH9TY5QaeKSyRR5HCMYa
        dFnjI8mrHhsgUpr0mHzPCv5Jjz8mfJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-aOpNgmtAN3acZXbxO1LaIQ-1; Tue, 14 Nov 2023 13:06:49 -0500
X-MC-Unique: aOpNgmtAN3acZXbxO1LaIQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4090181eec2so38452935e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985208; x=1700590008;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Ea5F9/sxF9OVzOjdMf3/GKiJbULr6v8M/iO5If8mA=;
        b=D4lg2Ylx7xCCTpL5WzBGmVxrQc87iupCI6EWjgOlGUW34t/vXYlGqitcfsZgHZbxwt
         P4P8SrwTwUhpgZLiJRkrxcQPtvgs8JQ7CUieX9+hTgZyMLcvslvxPqaj2yh5Gra0MKiR
         8ibANrTA7BQ0Bsvi30NM9E89+u53JNdv1WjrfvN9b1ETSZRL1Xlw1ML/5iXAzNs4Lz0c
         fqg9ZdCs0AI3NBSjT1nMO8Ze4F9f0bz1dFlpRXn1vMRr02yx69TzRW8NAoXEFPSljD3j
         4DtHmdCHTwhNjP/V9BygzN1yZMWmhSs2g4wAp87isGQkXGdzucBJnpO0HNG9d6eErxKQ
         SN9A==
X-Gm-Message-State: AOJu0YyFh5OXMZ6OcDIP/N2aXgYVGprgNT0HUpqiOF3XBKchc5WbmFfK
        uu5qr48nKR/PeDZ1CeB+dEjcKcmG2JXwltjtbOBMD/6vFqr5iY/4nRGj4lbHkwLtdTP+xjp3NV/
        0u4Sue/cDsegkJeF362Fhecs3
X-Received: by 2002:a05:600c:5247:b0:405:39c1:a98b with SMTP id fc7-20020a05600c524700b0040539c1a98bmr8106100wmb.20.1699985208347;
        Tue, 14 Nov 2023 10:06:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENiVmHUzsZj8Er9uv42BdyJgrcXyOCc16SNziUSzQjnDVU3jq0kl5Cj3OWEcuy37bKRTjH0g==
X-Received: by 2002:a05:600c:5247:b0:405:39c1:a98b with SMTP id fc7-20020a05600c524700b0040539c1a98bmr8106082wmb.20.1699985207946;
        Tue, 14 Nov 2023 10:06:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c4d9200b004068495910csm17570724wmp.23.2023.11.14.10.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 10:06:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        dri-devel@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        linux-doc@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: Re: [PATCH 0/6] drm: Allow the damage helpers to handle buffer damage
In-Reply-To: <c28b6e4a-aea0-4de4-a194-aa1024a93476@suse.de>
References: <20231109172449.1599262-1-javierm@redhat.com>
 <9296c184-22c1-4d71-8b11-2d26f49a5790@suse.de>
 <87wmuk5mfj.fsf@minerva.mail-host-address-is-not-set>
 <c28b6e4a-aea0-4de4-a194-aa1024a93476@suse.de>
Date:   Tue, 14 Nov 2023 19:06:47 +0100
Message-ID: <87ttpo5hvs.fsf@minerva.mail-host-address-is-not-set>
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi

[...]

>>> And why does it flicker? Is there old data stored somewhere?
>>>
>> 
>> It flickers because the framebuffer changed and so the damage tracking
>> is not used correctly to flush the damaged areas to the backing storage.
>
> I think I got it from the links in patch 5.  In out other drivers, 
> there's a single backing storage for each plane (for example in the 
> video memory). Here, there's a backing storage for each buffer. On page

Correct, that's what I understood too.

> flips, the plane changes its backing storage.  Our GEM buffer is up to 
> date, but the respective backing storage is missing all the intermediate 
> changes.
>
> If I'm not mistaken, an entirely different solution would be to 
> implement a per-plane back storage in these drivers.
>

I believe so but I'm not sure if that's possible since the virtio-gpu spec
defines that the VM should send a VIRTIO_GPU_CMD_RESOURCE_FLUSH to the VMM
in the host to do an update and the granularity for that is a framebuffer.

For that reason the only solution (other than forcing a full plane update
like this patch-set does) is to implement tracking suppor for buffer damage.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

