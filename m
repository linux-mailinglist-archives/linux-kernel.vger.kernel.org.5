Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E57E89E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 09:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjKKIrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 03:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 03:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E691716
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699692387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qe4AnVqkbysPosOtrXNw4qx0DGe8XSJWaRQMRFv81Ro=;
        b=UGnYMEtlzXpDJZcwqvq8dJ1Q4VqFdkf8goMURffyB6Sjukq+LYrStxnMCd/nC0X/d3p6P5
        3FnbhgYBdR2Blpi9cN3Z3s2ijVKBpHKiIL4d8JYOATvJF43x68Y1L/IOZoOxOXNwLcAq6h
        Y0hwJVuu2DhGID+puIUxqwMaXuRs/qw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-gER-iOEUOPyj6zbhm7easg-1; Sat, 11 Nov 2023 03:46:25 -0500
X-MC-Unique: gER-iOEUOPyj6zbhm7easg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084001846eso19071405e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699692384; x=1700297184;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe4AnVqkbysPosOtrXNw4qx0DGe8XSJWaRQMRFv81Ro=;
        b=fdqZCVuyJFVXXKdgR24bXlEauBQ/VPs80/uuOBtqNpSxHMkcKZNeBrifhIA3qnSVvl
         ZZxuQgvJpqVGWT1vANP9PVqKhlPTFI4sFWdRkB4P/PNb5dir1IONI2Xsa1KN2/GhYR1v
         wkXz1jCz9qRcskV6OqIy1BNCD8pGsYsucu6KARFaA7jGlwxG6UV3t/4ptSNrjF7QTSv9
         DUSp6M4YjJUcFhH45GXe02LzlFr/xwRW1GLCfESX6Gm+fjmk6TNPYjSay7yBQ37BqtNT
         9Lg1ZHraqCvxVqoe3PpUzsPiXO8nv/I4KV5MOPtlbKTfjuVrxCjLG5hsMHCfADYICyY6
         xt9A==
X-Gm-Message-State: AOJu0Yx8+xHsPwS3vWwDJP4wsn3wtTxXz1msc0iZuihb4B9IH0qB3sNt
        Wmba/N947C/umqFuf7YBdYC8Wai02HiRjEoq5xF5Hqa9FAhi0EafjPY2PP1N+jXhahIHk8bw1cv
        DZm6myESxA/MTLU4Zw259M5BI
X-Received: by 2002:a05:600c:5129:b0:409:325:e499 with SMTP id o41-20020a05600c512900b004090325e499mr1236503wms.32.1699692384461;
        Sat, 11 Nov 2023 00:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQWv9ONWQ/9v4pE27vYGxbfOnqlBRHwhWNrhiZeopvK2vqA9fqnRiJMVbSHt1YK5D+0gIa0A==
X-Received: by 2002:a05:600c:5129:b0:409:325:e499 with SMTP id o41-20020a05600c512900b004090325e499mr1236487wms.32.1699692384065;
        Sat, 11 Nov 2023 00:46:24 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id iv10-20020a05600c548a00b0040535648639sm1541957wmb.36.2023.11.11.00.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 00:46:23 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andrew Worsley <amworsley@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR FIRMWARE FRAMEBUFFERS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix failure of simpledrm probe when trying to grab FB
 from the EFI-based Framebuffer
In-Reply-To: <CA+Y=x3mF4jFX7PiJQ-1Gk9zyBE1mwZaF_GLYjSspT+mxtMn4GQ@mail.gmail.com>
References: <20231111042926.52990-1-amworsley@gmail.com>
 <20231111042926.52990-2-amworsley@gmail.com>
 <CA+Y=x3mF4jFX7PiJQ-1Gk9zyBE1mwZaF_GLYjSspT+mxtMn4GQ@mail.gmail.com>
Date:   Sat, 11 Nov 2023 09:46:22 +0100
Message-ID: <87il68ad9d.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Worsley <amworsley@gmail.com> writes:

> It's inline - part of the email - not an attachment?
>
> I can see it in the copy that went to me...
>

I see it now as another thread. There is something weird with the threading
since your first email was shown as first email in a thread with no subject.

> Andrew
>
> On Sat, 11 Nov 2023 at 15:30, Andrew Worsley <amworsley@gmail.com> wrote:

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

