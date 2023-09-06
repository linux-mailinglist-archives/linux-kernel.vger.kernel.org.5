Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCED79399A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbjIFKNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjIFKNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFBCCC7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xy4eWyuN+rU6FwER3ViJST19W+Gl/EjN/zwdPzrORYw=;
        b=dsLsZyqnHeOkEgL5LhaEmcmBBnMtNZXzoI4QLegtQ/hG5tvRj5ey57DQVV/+B7PIxqXICG
        SxGh/B3v/Or6bdrGnpywc1/nLX0IN32LaP9MidTktx/vqRUzMoZdUxhqszAap1+kKtt7W0
        X0IoeuhkQ/2X3XN7XNSUgM9RyQD1DYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-ozrn4U6ONeyZ939HxbWtkA-1; Wed, 06 Sep 2023 06:12:40 -0400
X-MC-Unique: ozrn4U6ONeyZ939HxbWtkA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fef3606d8cso22277795e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995158; x=1694599958;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy4eWyuN+rU6FwER3ViJST19W+Gl/EjN/zwdPzrORYw=;
        b=YbPgpy1/3U1YHd2R1J8CuQOHxoZ7KdMWQGZIxOINQ56sEsfyn4TrbdgdjDNU6lEhuD
         srxwxeJSYUwX+pIInzIADPt+a9bIuz981eIzR/zOXje0pxkeOBfwr5LLbt4jOdYWLG/T
         v0O7Yw+/ZkemxHXPb8BK4u/Q8/ZF1/Q//CB4u0knfDchIHeFM0gKY6YC+xLs8Kr0u3a3
         xdaYDU7xNXUwQTRk6Y/Mp5N0Z8GSOQH4JEK/7E813iHJEkCPiGyYXl+Rnm+T8XLM9aJl
         bWFUUj3HPTvRVyFlp8JV9fjj178XpB5AqBxSgP8+tFSAVz8sDGy/JwvGSy2QQ3/ofpMt
         YQmg==
X-Gm-Message-State: AOJu0Yy6CbFz0lHdAIppEdohL79kM1hvLMEC0A396iX5D9/oLbT/HdxA
        rAAK+hEWEU7hG40DSHYKyBXqSh4iYzgWXQ9wzna9tEwZvpwBNUuvGHLTll01ss0OfEsOrO+O4gV
        X17ij+RO+Bn3Gq8eJDUUMFNnf
X-Received: by 2002:a05:600c:21cd:b0:3fe:22a9:910 with SMTP id x13-20020a05600c21cd00b003fe22a90910mr1909283wmj.14.1693995158623;
        Wed, 06 Sep 2023 03:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcggVqQOJrShKfnNaPe4sc3f0Ds8yksigPQVjo0N6T3K/Fdg/hTediwZLUXkfmqjeXlqBpsQ==
X-Received: by 2002:a05:600c:21cd:b0:3fe:22a9:910 with SMTP id x13-20020a05600c21cd00b003fe22a90910mr1909265wmj.14.1693995158375;
        Wed, 06 Sep 2023 03:12:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4b10000000b0031981c500aasm20073022wrq.25.2023.09.06.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:12:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/7] fbdev/core: Build fb_logo iff CONFIG_LOGO has been
 selected
In-Reply-To: <20230829142109.4521-6-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-6-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:12:37 +0200
Message-ID: <87cyyv4nl6.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Only build fb_logo.c if CONFIG_LOGO has been selected. Otherwise
> provide empty implementations of the contained interfaces and avoid
> using the exported variables.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Ah! You are doing in this patch exactly what I mentioned in my previous
email :)

I would just squash this patch with #4, but up to you.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

