Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC137759F55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGSUJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGSUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5948792
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689797321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iM0CuWzlzu6pdYi/6cJkA8MQCu3DxXUjouE+j/kSvnQ=;
        b=NFTl61zd1nwddSGg8TafABZ8+UzW3hXUbcWbsR49I6oFiNCR1doz3QOWMpgSGLWH6og095
        amyHJlO67ugjajXMqKhsI7f90lJbJX95ExLpoJ5J9JqFSt8DC5/Y1S8H7mn6JPSx3gWsqX
        +2y+msvBRFgODhPjEqNncB5gCqcwEXg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-3McoVUipMuGkl2m0_JOawQ-1; Wed, 19 Jul 2023 16:08:40 -0400
X-MC-Unique: 3McoVUipMuGkl2m0_JOawQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fccf211494so10440e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797318; x=1690402118;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM0CuWzlzu6pdYi/6cJkA8MQCu3DxXUjouE+j/kSvnQ=;
        b=N56MifUgy+VbpeLGW+ssQs/LpKKQpY1NhexQUDAef2eUgYMa4AHn/1iG6Il98JmQbU
         nhFaSs0GDJOLgBmi/w6l5p62G+cFAdO5TBHbWLF7enF1DZISSkEV/OYwDEvvAPYugNTt
         Ai8w3j/jSRUUpmKo2tKp8vV0UWobBUEIrdENMQNzMHHw5rDThFUc5Pu2SzbfWkevaxN9
         AW2W0J/WSt3d+XijftzTEUK25ItQeN/wDZvUULjzi4Z4jZrJmrm8OGQUL00jAWNTOYVz
         8tCgUH1Ey9RvOrzxTnopvjMansrY2KDf0afx+s1r8RLPQLMz8WfemWTO1w789nKiIGpt
         WRXg==
X-Gm-Message-State: ABy/qLY7zNcmHfwxBcxJZbR6ketQNNNkiMtC9vJ49IdgyT88ab3pabg9
        S+ZZvIJVn8e3+ZLKkhFKEB0vl8C4RCKUOz4iqaDMFwJFXLxsDhLr4z7nLsD8l/QeBpUEXbpSNZM
        EnXA0+1Lqr7cW39dHMTwuJagz4VlR8nt4
X-Received: by 2002:a05:6512:33d0:b0:4f6:2317:f387 with SMTP id d16-20020a05651233d000b004f62317f387mr870475lfg.35.1689797318552;
        Wed, 19 Jul 2023 13:08:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFc25d7ighZVtdSRxpwgArEzNOn94MS4yvSo0iGHAnJzSp1NeM1GJCTXANqXaeQnuA7j2/kdQ==
X-Received: by 2002:a05:6512:33d0:b0:4f6:2317:f387 with SMTP id d16-20020a05651233d000b004f62317f387mr870455lfg.35.1689797318171;
        Wed, 19 Jul 2023 13:08:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t10-20020a1c770a000000b003faef96ee78sm2431167wmi.33.2023.07.19.13.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:08:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 11/11] drm/vc4: tests: pv-muxing: Document test scenario
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-11-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-11-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 22:08:37 +0200
Message-ID: <874jlzhdfe.fsf@minerva.mail-host-address-is-not-set>
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

> We've had a couple of tests that weren't really obvious, nor did they
> document what they were supposed to test. Document that to make it
> hopefully more obvious.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

