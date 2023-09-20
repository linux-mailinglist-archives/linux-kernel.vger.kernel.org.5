Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B547A7345
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjITGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjITGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:54:37 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E411B125
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:54:20 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4Rr8Qf68G2z9rw4;
        Wed, 20 Sep 2023 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1695192859; bh=V8atDNK1E+JZZDisWMyJdt+WViZGxRZeLthL+8kYzIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hdAllFN9JuRC87+Ed7jTZjPxd+LDBIbDJwf+v0lcxy6TsYvQsavnaz/ccY+uGKo/d
         h7nc9PwWtbQKa6PYMPmB8mtC9xgKAZBoYjC0NhpUfllTfuPub86YA1BsE/zYkSKCaK
         VBg56cBZew5lkaCn2pBeIGc8qUCLGCfFs6loYGJ8=
X-Riseup-User-ID: 1F06F83D7576BE04B4DB58FA17051608CD162D04D693EEF396E0701C2059C758
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Rr8QM6tp0zFqj9;
        Wed, 20 Sep 2023 06:54:03 +0000 (UTC)
Message-ID: <8d346098-a5fa-5e58-2484-3b3a35370619@riseup.net>
Date:   Wed, 20 Sep 2023 03:54:00 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] drm/tests: Fix a use-after-free bug in
 __drm_kunit_helper_alloc_drm_device()
To:     Maxime Ripard <mripard@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, tales.aparecida@gmail.com,
        andrealmeid@riseup.net, mairacanal@riseup.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
References: <20230920-kunit-kasan-fixes-v1-0-1a0fc261832d@riseup.net>
 <20230920-kunit-kasan-fixes-v1-3-1a0fc261832d@riseup.net>
 <66zj2spgswo2adyhh2xbcefimggiyci2whxjhsygdistyyqvob@rot736yxggcw>
Content-Language: en-US
From:   Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <66zj2spgswo2adyhh2xbcefimggiyci2whxjhsygdistyyqvob@rot736yxggcw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/23 03:40, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Sep 20, 2023 at 03:11:38AM -0300, Arthur Grillo wrote:
>> In __drm_kunit_helper_alloc_drm_device_with_driver(), a drm_driver is
>> allocated with kunit_kzalloc. If the dev argument was allocated by
>> drm_kunit_helper_alloc_device, its deferred actions would access the
>> already deallocated drm_driver.
> 
> We already have a fix for that in drm-misc-fixes, could you give it a try?

Oh! I didn't see that. I just ran it, it worked! Great fix :)

Best Regards,
~Arthur Grillo

> 
> Thanks!
> Maxime
