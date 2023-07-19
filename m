Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1A759DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjGSS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGSS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF32CE5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689793012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FslhBD4l5T2qkRClAbGtLS/oR8F6Mx0QNWHGPPx2ZXc=;
        b=RzccCOUlUHeMsSoSIvQMKRwoMP4shv95cb7CLLOeXS23pjIh2L7n1Kd4OmR2Smakc5IqmQ
        L80PH6rp1r3zGsobTiumv6J9NaH4HbR4M3yn+waFjIHtXQOg+V6XcUG71AaNS3AoSdsMWi
        YtvFEdGkGk+luv1PqxvNDtrJv6kDW34=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-zyHZyH4MNvCKLAYuVvPJrw-1; Wed, 19 Jul 2023 14:56:50 -0400
X-MC-Unique: zyHZyH4MNvCKLAYuVvPJrw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314394a798dso19918f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793009; x=1690397809;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FslhBD4l5T2qkRClAbGtLS/oR8F6Mx0QNWHGPPx2ZXc=;
        b=MW3ddtGv1QpYPrt38LpEI6iq+JoUcuw0ABEsOYFOFS0dSKIIMUlgwtrQCLKYBNI47m
         cF49vix3gZz2161o9ODwv0mY9kBrc3sbxE/s+bNZBZpw2Ap3MVEBc58Ixkf3SabfbdBU
         aPxrxzxi6YRk1mBybP17xNO39trwcF+1/ts4XR5EwmegUYVJHEpMAjpPugJu6xXAOV/I
         O9CAEqsyP4v/1eGT41qlPvjHm6qTrrCnhnl8sjk6UEddtO1U1581Lkv8urdxsYt4KiHY
         fmNoOpeIhwT2ojSNEj3C3aXCN02y917wkeWQUig8nrqDpGXl0Xtea9ffvtx4KIw5bcvn
         140w==
X-Gm-Message-State: ABy/qLY7mujGXkkY2j1ZbK7xw66RVWelsJ8kpvVxANAlSa65fHa17JZx
        TytXEdunPoE3cDvCTPlqiQcQCRJgcSeOxWHZXgMt1hpmOkYE4H+OpPgc8D/zf/PzTSenR6Xubk3
        48WJHAkwNR6inRNQ7S1aui3FY
X-Received: by 2002:a05:6000:1813:b0:30f:c050:88dd with SMTP id m19-20020a056000181300b0030fc05088ddmr735917wrh.8.1689793009135;
        Wed, 19 Jul 2023 11:56:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGhFBq0y3+l95btRu979XI6LgGj62Asu0X0co6wuTkKKmz+b9NDsz2UvdgOLASIra+8Cr9Esw==
X-Received: by 2002:a05:6000:1813:b0:30f:c050:88dd with SMTP id m19-20020a056000181300b0030fc05088ddmr735909wrh.8.1689793008883;
        Wed, 19 Jul 2023 11:56:48 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fc01189b0dsm2321805wmi.42.2023.07.19.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:56:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/11] drm/tests: probe-helper: Remove call to
 drm_kunit_helper_free_device()
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-4-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-4-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 20:56:48 +0200
Message-ID: <87sf9jhgr3.fsf@minerva.mail-host-address-is-not-set>
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

I wonder if makes sense to just squash 2-3 and this one as a single patch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

