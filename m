Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011B6759F32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGSUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGSUCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA641FE9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689796922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F50ZRNO2TGVX8Kl6rozSN2J4zAo6+Tkfm50rtvi7/ZE=;
        b=gM7AGlWQgx7nTFxZOlUwUk+PpnPM30xxmn32fUnBs4UOa09hVRcz65LNrlaqiG0KYgWDLP
        NpqbCZcFIs/HfrFqwVn6ByK2TJ0xCy/zMRFmDq8HLrjJ9CPPHSG/Z1wv1eOZiHh/biFTpa
        Ufo/oujcsfjpYguB9efM92xPlSJvWcU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-a9Hn62OjNlSam_jeapiYAA-1; Wed, 19 Jul 2023 16:02:01 -0400
X-MC-Unique: a9Hn62OjNlSam_jeapiYAA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314291caa91so9087f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796919; x=1690401719;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F50ZRNO2TGVX8Kl6rozSN2J4zAo6+Tkfm50rtvi7/ZE=;
        b=Xtuwf4f/l3dH3elg1UpSIpSqErsBKH7gWeRTr60mBSAD6OVrBKdfwDGx2EDSossc+T
         J/lWHY+F2G1QLTgE870XU+1NrDYR2bjvQJm3a26Ah03AAIidgMjWZC2me6p2GYyEFUy1
         5bA9OVB41FNQrAv5ONhfJUZ6terqelLkp/D8qK1S3tOzbzT9auUZeJvbtbRkZAtHbcch
         HV69eFjlFL2SSRpEwYrxkeSy3PABFiB8hEPwLdTJyUe76YsP/rLdqNhSfhwXw7mmu61V
         LEU1gMmjDTqISKXVdqQ6BwsZgRHi47ZJjpJaGsyoXSsos1L8aYWEvQDAi/zxRlvw4cFD
         yO0g==
X-Gm-Message-State: ABy/qLYyrhhvB59rjhg9ky8/myN91pFnH5a/5ferfTCgEhSrIMgdApP5
        MNTTIKeDuL1EXUtxVXty0yHEb13bJoTROOoP+SIpANPnHZHWX99+KSKsAuDnXyfw+05WqbLxWV4
        hQEk2ETv0XxT2T6SGOCnjckMj
X-Received: by 2002:adf:cc8a:0:b0:313:ee3e:50c5 with SMTP id p10-20020adfcc8a000000b00313ee3e50c5mr667541wrj.20.1689796919488;
        Wed, 19 Jul 2023 13:01:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEh6qh2D+HDhq3T4nhad60k5o+fElA385D8f/zxvzb2G1xHV5DYobxgxRQ1y8JlPIHpCqcuDw==
X-Received: by 2002:adf:cc8a:0:b0:313:ee3e:50c5 with SMTP id p10-20020adfcc8a000000b00313ee3e50c5mr667526wrj.20.1689796919290;
        Wed, 19 Jul 2023 13:01:59 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b0030c4d8930b1sm6122653wrr.91.2023.07.19.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:01:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 07/11] drm/vc4: tests: pv-muxing: Remove call to
 drm_kunit_helper_free_device()
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-7-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-7-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 22:01:58 +0200
Message-ID: <87fs5jhdqh.fsf@minerva.mail-host-address-is-not-set>
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

