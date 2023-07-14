Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0D753B89
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjGNNJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNNJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561FC30EB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689340117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jlF+0VvtD6KedYYZA+25RR268o+QB6ezDCMPRnzrAU=;
        b=NF2GNH8Ol+p4vhfOVvb2+9B2OlmY4XmjnDyrKkPFaasy0iTQj0ZHmJev5A9+OJLJJD3dNo
        EEUPNGEJHBtKZ/Mp4YnRgfLE4w+JG2sqwTvtpBrVY9n7+xGvWn4bA7EzLFUmpgBP8cNE6R
        UUhbFHP9RX+OkkoL8oUAUXlU3XYVtTs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-JdBytWFlM4mr05SXXgvntg-1; Fri, 14 Jul 2023 09:08:35 -0400
X-MC-Unique: JdBytWFlM4mr05SXXgvntg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbe356b8deso10606255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689340114; x=1691932114;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jlF+0VvtD6KedYYZA+25RR268o+QB6ezDCMPRnzrAU=;
        b=kGqDAFSc+7xYQbGjFdGp8BRsX1jdIqlm2jQgCyaCwhYaA0SnAFYvEdR0ixjNZTmiQ3
         /ux60LastHknGBeVQoVu9q26UGDoGrzYgeBvImaO5PBtwTF5IrDnWLkSLBUBW376uOfd
         NNuUXYHA2sHp7ZCajO8TFzaUtmYKkdjSBqfSMWwpJss+Zxd1sqqxF2Zy47WBRTr9FGsq
         DP6tfTAdUojPbFQ3DAJcFpyulhfVLpkLuWrCmCsBbSt1Md5JiaYydYPXD2WscnxxWtvV
         8d6gZwclxKO2KZev1F+lRaF5LekpG8swNdJR0P2wprJ/f2c1/lbqQledBUvQC0PzJQW5
         UsGw==
X-Gm-Message-State: ABy/qLb6HCUYp5/QzVSTXcEP8SlDlCg1f0Vbgvb4x7f4XKwU8kFJgg88
        pE+iGlOebNzBIvCUfpTUaXDQ4uOG010ComioYDQ3DgFlahORjiYXh5AH+uGPVwqIiFX6J0DzEbf
        jwH1MVahCE/dFaxWpy2i9aLtq88c9fjqm
X-Received: by 2002:a7b:cd97:0:b0:3f7:a552:2ec7 with SMTP id y23-20020a7bcd97000000b003f7a5522ec7mr3917342wmj.33.1689340114563;
        Fri, 14 Jul 2023 06:08:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhsMqIQp/IzuO0MIXq2cAlM4A//WRLZpuNqFOjCnyF5tfR2O7yTuBRFdgW1Y3m8IXRT5F1Gg==
X-Received: by 2002:a7b:cd97:0:b0:3f7:a552:2ec7 with SMTP id y23-20020a7bcd97000000b003f7a5522ec7mr3917326wmj.33.1689340114257;
        Fri, 14 Jul 2023 06:08:34 -0700 (PDT)
Received: from localhost (208.red-88-2-40.staticip.rima-tde.net. [88.2.40.208])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c12cb00b003fc3b03e41esm1197974wmd.1.2023.07.14.06.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:08:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] drm/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <CAMuHMdUrqwQAaNFONO0KOktrRY_twpktAP6=AeKv_8jjdb5_fA@mail.gmail.com>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <72746f6d9c47f09fc057ad7a4bbb3b7f423af803.1689252746.git.geert@linux-m68k.org>
 <87ilamu7e3.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdV1MXexXuRuvW2ap5KA51q_3h9X8jXdYXtFb2RF-BBLnw@mail.gmail.com>
 <875y6macxu.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUrqwQAaNFONO0KOktrRY_twpktAP6=AeKv_8jjdb5_fA@mail.gmail.com>
Date:   Fri, 14 Jul 2023 15:08:33 +0200
Message-ID: <87351qabe6.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,

[...]

>> >
>> > The display should not be updated after .remove(), so I think plain
>> > devm_kcalloc() should be fine.
>>
>> That was precisely my point, that there could be atomic commits even after
>> the driver has been removed (e.g: if using DRM fbdev emulation, user-space
>> can keep the /dev/fb0 opened and continue updating the framebuffer. That's
>> not released until the fd is closed and struct fb_ops .fb_destroy called.
>>
>> But that's a general rule in DRM, any user-visible resource must not be
>> allocated using device managed resources and instead use the drm_device
>> managed resources helpers. To make sure that are not released until the
>> last call to drm_dev_put():
>
> These buffers are not user-visible, so they should not be accessed
> after .remove().  When these are accessed, the next step would be
> to write the buffer data to the device, which would also fail miserably,
> as the regmap, GPIO, and regulator are hardware resources managed
> through devm_*().
>

Right, given that we do the shadow buffer -> native buffer copy, I thought
of it as if as a user-visible (well, user-accessible I guess) but you are
correct that's not and trying to write to the device will fail anyways.

So devm_* should be enough indeed and if there are problems with that, it
would be a different bug in the driver to fix.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

