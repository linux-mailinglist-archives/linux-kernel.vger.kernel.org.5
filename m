Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B4759F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjGSUC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524FB3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689796895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sg6wZSinxe8r2P+uFq4KgcT9vXCAHVcOICFNECpMgro=;
        b=MNhOajlcipd3Ui+uJqa05iEko9V9zDYbZL0X5Rg2azLecIjL028LfjoDpaFRu+LtOpYFEF
        1ZvmuIlti0MmQci9ciEttmwS4oq+q7HmzR/DoNl0wpKI9hs8qyMuSP5N3comsGrnOaTDmm
        vI4nIOVSisdIsZIirGGIHBMsDbP2FuY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-QWOV52wmPIqTSAS1qNVIJg-1; Wed, 19 Jul 2023 16:01:30 -0400
X-MC-Unique: QWOV52wmPIqTSAS1qNVIJg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso21355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796885; x=1690401685;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sg6wZSinxe8r2P+uFq4KgcT9vXCAHVcOICFNECpMgro=;
        b=hyqwMwJT89LFiU+0p9VWAFiLow0CpKqwqKiuUgFGnXyifAyxEx4eBBW2/lEzwVMPdt
         kdwIVidVmZ1kR/ArVeqizBmPi+9OnAldg/Ai6gQhLbSIQycfAMYJNxNrmR8oTfPSCBaI
         W62iSfmtNCWSkMf4VTN+Vr2chXtmlZhtJUWAXpT2clPAGmF06RLT2DwNpaKqoAVOgFqM
         LQHUdsax3FJYPo7UwbnkQMUeoVgwsUH24w7wmDZ9POGu1xsITSDUGA5MHQxGIMoF1Ubp
         w072avwX8X0w+4VQzxKwWzXstmO5JaC7lSXIr28LIyJl7gfZgR/zlQE/u8GUuPifLdEw
         lIcQ==
X-Gm-Message-State: ABy/qLYfZOYn8XYVupBFIrt2B3Ib1YU4ftEjpzyOdRt3FMK0JeTuZw8r
        Ss3QFqUt+871c7mQbpyK7aWhKPK/OkToQY45YB8X0sj09s5EFYAmpluHFOcwf/w3TPA+rif2Hqz
        6e3QCQKr+7g5/cc+eRcE9U6+f
X-Received: by 2002:a1c:7412:0:b0:3fb:dbd0:a7ea with SMTP id p18-20020a1c7412000000b003fbdbd0a7eamr5358870wmc.37.1689796885404;
        Wed, 19 Jul 2023 13:01:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwqBKuTLWtJTG125iBcGiKJyRQZhKpcKrRbtLnI3PtSW9DnwX2W7eJ7bjSr7Vo1B8R/7uLgA==
X-Received: by 2002:a1c:7412:0:b0:3fb:dbd0:a7ea with SMTP id p18-20020a1c7412000000b003fbdbd0a7eamr5358862wmc.37.1689796885087;
        Wed, 19 Jul 2023 13:01:25 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b00311299df211sm6074595wrw.77.2023.07.19.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:01:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 06/11] drm/tests: helpers: Create an helper to allocate
 an atomic state
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-6-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-6-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 22:01:24 +0200
Message-ID: <87ilafhdrf.fsf@minerva.mail-host-address-is-not-set>
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

> As we gain more tests, boilerplate to allocate an atomic state and free
> it starts to be there more and more as well.
>
> In order to reduce the allocation boilerplate, we can create an helper
> to create that atomic state, and call an action when the test is done.
> This will also clean up the exit path.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

