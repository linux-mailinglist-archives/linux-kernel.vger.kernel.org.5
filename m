Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416707E89D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 09:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjKKIX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 03:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 03:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49C3C0C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699690985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=atynAEPTfoWaTFzhCmsRpTVi62wChDn9ybU1dA1F4RU=;
        b=VylMnvUIiAGD3IPKOk9J9b6lb7q5wo7LfeSumXxosn90IzHatlZRML/SXLSjp2YxJioxzb
        1FxlBDgNkffltgGTeViVQ2TMTcvq78b5LFouGBGkeXgMGrEb9Bz30fH8NPCHjorwI5StEb
        PEsgZKAEpVsei9k2RrKK/DlPL+Ah/eg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-5uYbA0acNOaHKWoUb6FC9g-1; Sat, 11 Nov 2023 03:23:03 -0500
X-MC-Unique: 5uYbA0acNOaHKWoUb6FC9g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507a3ae32b2so2800983e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699690981; x=1700295781;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atynAEPTfoWaTFzhCmsRpTVi62wChDn9ybU1dA1F4RU=;
        b=RxAYYYT/1uQxWsyLSpkLomi6TTcDYqJ77rOZYI5vEUWU3De5VvruPqXVfPoglc3h1e
         bHsJj8t/CGuarrVd4iVp7NiUGU02xVcrgxLlRMw+FlFdNaNoMQbp09I+8XuCJ2WphgeD
         GGusQ0dxp+nvXCfme2YIlwCQ4nnJGHQd+uYBj/AIw5ErQzazjJcl8/dfFH3EPy2ZUwq9
         zvSKQa5nj+t71DJ8Vf3xwiCPuZJ2bzTwdGFbSxyjZexpwjOgyzwlHzTW6oPvB03jW6eh
         zznOcVUjzoawyufsSHK0ZBxCxsObHo6IxbgCZH4LUnDIehQJua3NRih9KzI63pL2i8Wc
         2jgg==
X-Gm-Message-State: AOJu0YxQ5ROlVJs6miFLY2OWFa+xpKyF/IfOdk1CRfYzNUgB3O/7VFqK
        U8HvB20UxShBKujjugKZ4agmqpBAEVzOWln6BxiydjpEx9BlVAJAXeuKPd+cRA18YF6+FWPD+ks
        BTIwY8g45gt5UJtdjFMdbxVaVkz0Dyzf3
X-Received: by 2002:a19:7509:0:b0:500:9a45:62f with SMTP id y9-20020a197509000000b005009a45062fmr864859lfe.8.1699690981701;
        Sat, 11 Nov 2023 00:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6nJoUNA6XRAC1D3A5wF+hzfzKU/LOq+x+G3NEN3OgJMUiAVEfgREdpR410T3zw36xrPV2bg==
X-Received: by 2002:a19:7509:0:b0:500:9a45:62f with SMTP id y9-20020a197509000000b005009a45062fmr864846lfe.8.1699690981373;
        Sat, 11 Nov 2023 00:23:01 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d63ca000000b0032d81837433sm996350wrw.30.2023.11.11.00.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 00:23:01 -0800 (PST)
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
Subject: Re:
In-Reply-To: <20231111042926.52990-1-amworsley@gmail.com>
References: <20231111042926.52990-1-amworsley@gmail.com>
Date:   Sat, 11 Nov 2023 09:22:59 +0100
Message-ID: <87o7g0aecc.fsf@minerva.mail-host-address-is-not-set>
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

Hello Andrew,

>    This patch fix's the failure of the frame buffer driver on my Asahi kernel
> which prevented X11 from starting on my Apple M1 laptop. It seems like a straight
> forward failure to follow the procedure described in drivers/video/aperture.c
> to remove the ealier driver. This patch is very simple and minimal. Very likely
> there may be better ways to fix this and very like there may be other drivers
> which have the same problem but I submit this so at least there is
> an interim fix for my problem.
>

Which partch? I think you forgot to include in your email?

>     Thanks
>
>     Andrew Worsley
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

