Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38825766970
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjG1JzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjG1JzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598F1BF2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0GTcGQClcvNrmkODw/NhrTuC6m7/P69QHPvalFbZeU=;
        b=anLpkI2LUKIE0PLaUj/nVLaSzPbG4bjOUP/0+jeFpk2aFMBuxrxO1SGaw8F81h0EM7yYAp
        3vC6xGZ3qgW2VQqHpx//cbdGObvv3BRaH3wAgH3fKVgGI0y2wf7hvoeVJtIKL45oLNKlzs
        gUeUWhJhKOZE9tVyz1m3eUT1NRAYxLc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-KqWNz3MwNZergmi7eAU4DA-1; Fri, 28 Jul 2023 05:54:18 -0400
X-MC-Unique: KqWNz3MwNZergmi7eAU4DA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso10315585e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538058; x=1691142858;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0GTcGQClcvNrmkODw/NhrTuC6m7/P69QHPvalFbZeU=;
        b=fl/akP0C5THpN1YZ+QOy5EunzSHDZ8C4Ws1taq8phwR3nbrO1X+D0Ep4PB1Zz0Sz1z
         x2KRhei99dkaHFHX5AOInpqypJ4gU01cIMGSiErstQZ85nXrsFSgmYwVrERW8LFYP2Le
         tlL/4tjjjmk5YBBmwFHCDTkJm+o/dBOLUyZhV6OHKGU2y02p4fGmwsX4ILeJNKYWlnZy
         ZEgFvHmpKXsotijNfJCB2W2bOIFzq1+gGXfgfrfdKlfkSVOZlYO3XO2yM3m4sIdP8P/0
         rEyPtHXbkuv0GDRrJ26JL7psKxBQK15pVUkMdvfBOnpFlzJ0YyDS7t72G3q/onW+6nsj
         T0FA==
X-Gm-Message-State: ABy/qLZyPwo8FNRyWtOnaHkYhNE22xjUGZPRgCaaFrJ3bGJKBUcmNWnv
        kixqHWJ0L/Sl0bSpAP+DvDd1eaDdPVpeit965z8EwVT3TtvpzeIT8D6KsdMLrtdQ4eVlP2khUkI
        GHYM9RXM+YLKEdUjG+/6wC2HV
X-Received: by 2002:a05:600c:ac9:b0:3fa:99d6:47a4 with SMTP id c9-20020a05600c0ac900b003fa99d647a4mr1286366wmr.22.1690538057914;
        Fri, 28 Jul 2023 02:54:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRSbPD12+9qFkX5C461+2ZJKRCXjlQ8V4fPwRzoRVUqQ56eiawC1VqKnyP0ssE1MtTyyZaJg==
X-Received: by 2002:a05:600c:ac9:b0:3fa:99d6:47a4 with SMTP id c9-20020a05600c0ac900b003fa99d647a4mr1286356wmr.22.1690538057739;
        Fri, 28 Jul 2023 02:54:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fa95890484sm3812623wmf.20.2023.07.28.02.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 02:54:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/gem-fb-helper: Consistenly use drm_dbg_kms()
In-Reply-To: <7d56615fbef2d4d0e5f4c4a23f57269bf8bdb71f.1690535176.git.geert+renesas@glider.be>
References: <7d56615fbef2d4d0e5f4c4a23f57269bf8bdb71f.1690535176.git.geert+renesas@glider.be>
Date:   Fri, 28 Jul 2023 11:54:16 +0200
Message-ID: <87mszgtl87.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> All debug messages in drm_gem_framebuffer_helper.c use drm_dbg_kms(),
> except for one, which uses drm_dbg().
> Replace the outlier by drm_dbg_kms() to restore consistency.
>
> Fixes: c91acda3a380bcaf ("drm/gem: Check for valid formats")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---

Pushed to drm-misc (drm-misc-next). Thanks!

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

