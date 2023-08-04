Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E51770657
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHDQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EF1994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691167903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vP0dlW9cj+ApxHox6i9vs6i/QXMBGte1ysC4SvGPpc=;
        b=WEouO3sSiuzCm6dEOJTgEFDHVeq9PnmJez7gijg0heAuPxxHt1JSiUZpenjTQvEyrhx9w8
        OQICACbpXuhFOIbCFxOCpocXp9FFIIyGgl7VOqLImv7m5XfUpyQbCWwN6i9XA8z/y8Gu/n
        iMl+kDil4+Q2MkfPeKVDdrdP732INkU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-B4_FPGVYPpuXxDp3_W4_4g-1; Fri, 04 Aug 2023 12:51:42 -0400
X-MC-Unique: B4_FPGVYPpuXxDp3_W4_4g-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a72b2a52e5so3729176b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167901; x=1691772701;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vP0dlW9cj+ApxHox6i9vs6i/QXMBGte1ysC4SvGPpc=;
        b=cAs2O3HmpnP+7GiilgRywNNMHwMS1/v8XWmrK8ALicCnea+rqyYHlHqo6Mki9UEmxX
         w5kJ4tU3ffBCIOYd3TARE/4r+dNsU3f5Oa6zwq/4Buv6z5NWsBWZo7vysA/qVu6HLR//
         z16lKy+rwtYD32lh2j6ECjuZHiwt99c5tWQsygI61w+DWCnQz6/mJxTnDvMa1Blrl2w+
         PPX1S7unSujnV6khqq+txDdnDyuLLN6hclJhfj+QPHlerQPrPNHiSjy5GOH+/RlGLV5r
         pF2Q/ERKCOMvAhTZ6ri/QkxY0nxiUqnA5x+O8Kjl8NoraT4vtFcF78hX9186c9vUY61O
         G5jw==
X-Gm-Message-State: AOJu0Yy9AWjypoL15Ytz1tPWsP0dFyRfTkGo0wPOHDI8Y89siTQmr1Gx
        b13Hp/7IlSxIXUVFl8y41bzqEi6vF7duhI4tsmfYWYnAwiIFUFH4BVkz+s/hrhZlZoZuGbBQ/Ny
        5MLbvC4tguy4QiCqnJu/J1vGE
X-Received: by 2002:a05:6808:e88:b0:3a1:d1d9:d59c with SMTP id k8-20020a0568080e8800b003a1d1d9d59cmr3264674oil.33.1691167901377;
        Fri, 04 Aug 2023 09:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTPxIsm1c2cbX9Vb17Ch6ysG77QB/wTtj/fSLqgqSPY1KXpy+17/4mg3wGKDD4xNAKQ91FXg==
X-Received: by 2002:a05:6808:e88:b0:3a1:d1d9:d59c with SMTP id k8-20020a0568080e8800b003a1d1d9d59cmr3264664oil.33.1691167901150;
        Fri, 04 Aug 2023 09:51:41 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id i10-20020a056808030a00b003a3611eb6ddsm1203016oie.19.2023.08.04.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:51:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arthur Grillo <arthurgrillo@riseup.net>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Drop select FRAMEBUFFER_CONSOLE for
 DRM_FBDEV_EMULATION
In-Reply-To: <7950bcea-0f15-da2e-e4f7-4bfa474a420f@riseup.net>
References: <20230804125156.1387542-1-javierm@redhat.com>
 <7950bcea-0f15-da2e-e4f7-4bfa474a420f@riseup.net>
Date:   Fri, 04 Aug 2023 18:51:38 +0200
Message-ID: <87pm42g38l.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur Grillo <arthurgrillo@riseup.net> writes:

> On 04/08/23 09:51, Javier Martinez Canillas wrote:
>> The commit c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev
>> emulation is enabled") changed DRM_FBDEV_EMULATION from 'depends on FB'
>> to an effective 'select FB_CORE', so any config that previously had DRM=y
>> and FB=n now has FB_CORE=y and FRAMEBUFFER_CONSOLE=y.
>> 
>> This leads to unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>> as reported by Arthur Grillo, e.g:
>> 
>> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>>   Selected by [y]:
>>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>> 
>> Arnd Bergmann suggests to drop the select FRAMEBUFFER_CONSOLE for the
>> DRM_FBDEV_EMULATION Kconfig symbol, since a possible use case could
>> be to enable DRM fbdev emulation but without a framebuffer console.
>> 
>> Fixes: c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled")
>> Reported-by: Arthur Grillo <arthurgrillo@riseup.net>
>> Closes: https://lore.kernel.org/dri-devel/20230726220325.278976-1-arthurgrillo@riseup.net
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>
> Greate patch! I was about to send the same one XD.
>
> Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

