Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51707B0F01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjI0WrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0WrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:47:12 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15697AF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:47:12 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4RwsDv1j1yzDrC8;
        Wed, 27 Sep 2023 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1695854831; bh=/Pd+jbQgjXxvJFiFvl8XHiAPsLHoECvAtB0P395RyoM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oFxYb0qbD+EY/nl6QyxObqHuDVP9VPKTQVAg/QlHBJkFxYeRLsLa0qcHJJwDx89Sa
         dS7Yvl+W3UV8SSgfRews+Z5+rFIj9zZDXpVKte0SindWG3mdotSjMjSYNDnLuK+pcq
         ghPF1af+D408TE/L87mCPGU7lm/dPtP/Q5uHeCOo=
X-Riseup-User-ID: A76B4125B13CD2D5C4BEDEE0FF071F678073E3FA7577C825E82F9064E316479A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4RwsDq6TPCzJnJT;
        Wed, 27 Sep 2023 22:47:07 +0000 (UTC)
Message-ID: <771e3ddf-aa15-5ff9-9689-ec0e02bc803a@riseup.net>
Date:   Wed, 27 Sep 2023 19:47:05 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/tests: Fix kunit_release_action ctx argument
To:     Arthur Grillo <arthurgrillo@riseup.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
References: <20230920-kunit-kasan-fixes-v1-0-1a0fc261832d@riseup.net>
 <20230920-kunit-kasan-fixes-v1-1-1a0fc261832d@riseup.net>
Content-Language: en-US
From:   Maira Canal <mairacanal@riseup.net>
In-Reply-To: <20230920-kunit-kasan-fixes-v1-1-1a0fc261832d@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

On 9/20/23 03:11, Arthur Grillo wrote:
> The kunit_action_platform_driver_unregister is added with
> &fake_platform_driver as ctx, but the kunit_release_action is called
> pdev as ctx. Fix that by replacing it with &fake_platform_driver.
> 
> Fixes: 4f2b0b583baa ("drm/tests: helpers: Switch to kunit actions")
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Do you need me to apply this patch to drm-misc-fixes?

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/tests/drm_kunit_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 3d624ff2f651..3150dbc647ee 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -118,7 +118,7 @@ void drm_kunit_helper_free_device(struct kunit *test, struct device *dev)
>   
>   	kunit_release_action(test,
>   			     kunit_action_platform_driver_unregister,
> -			     pdev);
> +			     &fake_platform_driver);
>   }
>   EXPORT_SYMBOL_GPL(drm_kunit_helper_free_device);
>   
> 
