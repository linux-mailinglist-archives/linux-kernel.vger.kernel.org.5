Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3AE759DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjGSS4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGSS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99115E5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689792956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F50ZRNO2TGVX8Kl6rozSN2J4zAo6+Tkfm50rtvi7/ZE=;
        b=MilGMNO18pXAGKXTuhvKFXgQmvQBSCPZfIKprHaXp/3j1aLXscXnXnYgRM3y+HP/h7JLou
        SYETlQdxXBipZ+/DauYDjHeroODFSiofxzRdMENG1RQicigahs94LOboRGHgw7e+gEeK0k
        xcPnbM1kttCUi2Z0BVdnV3Frp1oTFPI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-_U1cWmyyMCCpJWDPENE1Ng-1; Wed, 19 Jul 2023 14:55:55 -0400
X-MC-Unique: _U1cWmyyMCCpJWDPENE1Ng-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa976b8b6fso44450585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792936; x=1690397736;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F50ZRNO2TGVX8Kl6rozSN2J4zAo6+Tkfm50rtvi7/ZE=;
        b=RgsugGnf/WNmUDEbYuJbd/vt9UBT6lpHPdsxYEwF+2WJEtu5G0mXZvjYECmySkdx+4
         zzqWW86OROYNb+U55E/El84XRCYBHk56nXnsQlZTrKbBf+bN59mvT85NHRDEaPxmkIr0
         diIF/r7nk//KdaFrCyfwwJW2ZWZLgkWZ8ifmtGTRuMND9zkS3F0HRgr3MkYQdG3URQGl
         OUQ9rTbO9vJfREJEOGjiCroMTxKRxfhHTezpR1HPNiRBzz7mOYI+gsmEoj1EF1ssDUdl
         J0rHNVM7O3NyrUprMQd1/Il+EeV4JuotwjYmgXuxUaCuLe/hcETvtgBvcjnmoxi8DJAe
         sNPA==
X-Gm-Message-State: ABy/qLaXrJi9/5j8E8A1bwpt6u1ZifhWYhTTK9Eh2f2xI3Ch31q9Ha3B
        xkENBZ0B+meKhTVs8rFgH/UCW3krJ2qjW64ayw7pujzI6WZudbfQrkf9VMhSWpx7nm/X2RIbPf7
        b1pmHZW0HJeZgrgZRr9zCTZRCq3QteKbk
X-Received: by 2002:a7b:c4d6:0:b0:3fc:70:2f76 with SMTP id g22-20020a7bc4d6000000b003fc00702f76mr194185wmk.20.1689792936733;
        Wed, 19 Jul 2023 11:55:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG2QS5yjSN+Zf0H8nEynLm3JsHawoJtVXOZv5yrZtAf7/B2P3zvonHgb0nSCS39LrTPJFwvyw==
X-Received: by 2002:a7b:c4d6:0:b0:3fc:70:2f76 with SMTP id g22-20020a7bc4d6000000b003fc00702f76mr194175wmk.20.1689792936411;
        Wed, 19 Jul 2023 11:55:36 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b003fba6a0c881sm2240800wmc.43.2023.07.19.11.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:55:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 03/11] drm/tests: modes: Remove call to
 drm_kunit_helper_free_device()
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-3-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-3-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 20:55:35 +0200
Message-ID: <87v8efhgt4.fsf@minerva.mail-host-address-is-not-set>
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

> Calling drm_kunit_helper_free_device() to clean up the resources
> allocated by drm_kunit_helper_alloc_device() is now optional and not
> needed in most cases.
>
> Remove it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

