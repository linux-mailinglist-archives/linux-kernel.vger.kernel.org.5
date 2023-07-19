Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8BC759F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGSUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGSUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10429189
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689797027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOM+wVNXILroEPxWjZwTznoH+LNSt31Zm8n0YzaUK5g=;
        b=hGudsZR4Ido8A91iYcaZyzxZs+O37P5dhGl7U57uVnQOKNom5pB0um5A+0HvBVu3u7UX0v
        +inhvtuRgDHrAlRUc33KgrCzcumiYyl3JrZvJ2K1w6bIdyfY2Yh42gg33rRVCg+Ayype0I
        TJ7jK1l93xFOkjjKXh7cJTuX1t2/Vbs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-DtbF0ownO3CltvPkvvNWDg-1; Wed, 19 Jul 2023 16:03:45 -0400
X-MC-Unique: DtbF0ownO3CltvPkvvNWDg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313c930ee0eso16677f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797024; x=1690401824;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOM+wVNXILroEPxWjZwTznoH+LNSt31Zm8n0YzaUK5g=;
        b=cKcpPJrk3JIPI4fzS6bwiwapc4Dmf8j54E55/uGG3rj+iXWnc4+tD1XUu/BUN+Equ/
         NjHoUQlf8vgVr16wFIuM6xQLR2M1tMAACeKoXMJhmIMk7qqga7NhC3TyuRZg8WmzjaiJ
         qj6SpZImcJa/QXiouTeyChjARRBIEiLL8n0cWDOZRpUG96EB5aEPF9i/sfBPA6EKQ22I
         WPnKloMbxS/1c2JUdLcU49FGcMUb9KKcF6HWCq5PRiVQWYuS7LdOrZur8tBKbQfMkClE
         WSFp3IKTiZZAFnmtNEVfVh4kW8CThT0+kep9cK4givA99qMY68wp3eqyFrrNuddjn5z2
         Tsug==
X-Gm-Message-State: ABy/qLZYTVXzLiPZJO3eHpLvEMq1I8r2qB5deTPbiX2PqaEZasOWjTNH
        nLQIyrc0bG4LUyaH7x1QTxhE1wrWI0K96i8D+hEsTxtC8ZJRwhmBZOraWxh+x6KJq3+fs/2M10O
        mHLAXHcY+e8nfV9ZI0qsL6WOF
X-Received: by 2002:adf:db0c:0:b0:313:f0d7:a46 with SMTP id s12-20020adfdb0c000000b00313f0d70a46mr789090wri.3.1689797024472;
        Wed, 19 Jul 2023 13:03:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGzzDZoz+M1nWmzfGQ9tUM7klp05pIpgXPL8g9e6TDjrSUcrsAGwbAAePLAglpY5MtIGYFYpg==
X-Received: by 2002:adf:db0c:0:b0:313:f0d7:a46 with SMTP id s12-20020adfdb0c000000b00313f0d70a46mr789073wri.3.1689797024169;
        Wed, 19 Jul 2023 13:03:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13-20020a1c6a0d000000b003fbdbd0a7desm2373198wmc.27.2023.07.19.13.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:03:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 08/11] drm/vc4: tests: mock: Use a kunit action to
 unregister DRM device
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-8-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-8-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 22:03:43 +0200
Message-ID: <87cz0nhdnk.fsf@minerva.mail-host-address-is-not-set>
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

Maxime Ripard <mripard@kernel.org> writes:

> The *_mock_device functions allocate a DRM device that needs to be
> released using drm_dev_unregister.
>
> Now that we have a kunit release action API, we can switch to it and
> don't require any kind of garbage collection from the caller.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

