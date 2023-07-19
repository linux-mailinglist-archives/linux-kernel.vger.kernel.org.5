Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920BD759F48
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGSUFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjGSUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF821FDF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689797101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/pTuM7M9vX1ufC1fpmoVaAmiz4C6dhPIINuHgLpo2o=;
        b=Aop8gbNdTslnhbDkvoyPq1DODARJ/MQyr129ilbRm7ksnPi8u9r8P6i8ktnmhbpdKTxFq7
        cydb2eD7RvS/vI63ntYUuQ0lXmuWeUvPW+CmMOAAMd7wHU2ljepfgXz3XQ8X65scHUt+fq
        NS2L3GCj8XQnhjrT4w/wrp94LMHAmek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-OjJNBLT5M-GQQ2rEhKmv1Q-1; Wed, 19 Jul 2023 16:05:00 -0400
X-MC-Unique: OjJNBLT5M-GQQ2rEhKmv1Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe4cecd66so66215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797099; x=1690401899;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/pTuM7M9vX1ufC1fpmoVaAmiz4C6dhPIINuHgLpo2o=;
        b=MQ17bFM5drNMOd3bJfmgRHB+0mClfNJvpo/eviApsWl3T9vlVWLOXXMIuXVxRU5ua6
         9VZ8TmvoQerMeLYOUY7tPdzkMFwK6eXKINXhF6kga/jQPsC32mbnxQluZ+EYQXhf/GUU
         VJUOwVZ0IOf4ZDEswVAVELhkbdUgJDTWX5Y1j3ZYrYRaeu3yywElcVJvjXwZxvfYANwT
         /Qm82wNs8ra+lYXIYlPeviTJHsSPcR3mCYSv0FT3KjnXUP/poOVCQ1E1nCBmYWUx34HT
         WcqIauhSFsxQWwsglW4FUVS+uFibBG8C/x4DgFCBanRMJ9KmNLheBWhEX0uILWZqvwwN
         8oxw==
X-Gm-Message-State: ABy/qLbvB169SqUjycnM6pyEn90gjvcnOZMHdU45sS5l8yMmwYDDns8m
        6fpvu/Cqvz65PfF0tvYNgjU1lKc3I+kXr/KS5qcHHEAs9Gabhp0npcRlOaUvyxD1Ds2+5ckpMtH
        mnxdhpQrib1lBQ6wS4wI1LuDr
X-Received: by 2002:a5d:4a49:0:b0:314:1a98:ebc0 with SMTP id v9-20020a5d4a49000000b003141a98ebc0mr685708wrs.26.1689797099230;
        Wed, 19 Jul 2023 13:04:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFi0JY22d+kOHK5fHGqO+y4CtL8B9jTcDDC0m6+bbYWaVo5QzVUkwkdAF9IoCd2V8xLw0B20w==
X-Received: by 2002:a5d:4a49:0:b0:314:1a98:ebc0 with SMTP id v9-20020a5d4a49000000b003141a98ebc0mr685693wrs.26.1689797098975;
        Wed, 19 Jul 2023 13:04:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003f90b9b2c31sm2383353wmc.28.2023.07.19.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:04:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 09/11] drm/vc4: tests: pv-muxing: Switch to managed
 locking init
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-9-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-9-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 22:04:58 +0200
Message-ID: <87a5vrhdlh.fsf@minerva.mail-host-address-is-not-set>
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

> The new helper to init the locking context allows to remove some
> boilerplate.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

