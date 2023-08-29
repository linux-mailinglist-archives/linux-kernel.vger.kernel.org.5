Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED078CEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbjH2VTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjH2VTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373FCE4E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693343790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsrqElhKNPNFgbdwVrAQrRLanlnRhnvN8+BVbNKQ4M0=;
        b=HStmvFcNVW1hPdfrXmMlV05gX3TByTJ4CfKUGvCI0Ty+ePnuZon4466LdMLdIbs1hu39qh
        Dc5WraS7/EmfLLb/L385iobQjCOwK2MhPpPld50dD+FCg9eU3eZmJkIh7s+voPWMu/BboA
        bbTCsJFyPJgckPBbp30DSTlbBPlyvhQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-AeZvATk6N_OrGAk0tIpbPA-1; Tue, 29 Aug 2023 17:16:28 -0400
X-MC-Unique: AeZvATk6N_OrGAk0tIpbPA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so32626155e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693343787; x=1693948587;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsrqElhKNPNFgbdwVrAQrRLanlnRhnvN8+BVbNKQ4M0=;
        b=ObBKQMaZp/TEmTC9hORbcQ164KeN4zVG4zsMXZXfL2iPQ4yJt1UEpGCe780XvC4zQ3
         flOXhRnmFNhHZzrnsnJ4eUWjhK5pfUyp7DJYiKTJO7CV5ZKhk/UWzgdDcb67KIE18YcK
         /oUsW50yO4WA91fghDkEHG0GqOlHGpEeubdMy6f/RVMSkY0QwOiBB4pjXuWgHECsCx/a
         zL6x6ToZrGbna8oZ8XBPb0NuGae4vj/Px27er9tFFECd7IKmVxUnof+Tr7/AMWNGGlav
         /aOwGI90a1SNwlS6uyz7gUiLMwCfV2qOdgiQaM1vJqnhv4Gsw3Lb1RnVByykamIAjJXb
         8aFw==
X-Gm-Message-State: AOJu0YymsARdL4DfhzmBkxgkKCkKKZFvSpojktsYrihiBrBC1dHeCWbw
        SlGVMloFsUjWZqwQ52OhIMJlCZZp2kIveAaUma3Ix8N9amQaYWYWg97IuoBUrUZeXv8clgIAMmi
        WThSD1ub4EWi6wigqVlxUi1MYb/6J5tzT
X-Received: by 2002:a05:600c:218f:b0:401:b204:3b85 with SMTP id e15-20020a05600c218f00b00401b2043b85mr308615wme.36.1693343787057;
        Tue, 29 Aug 2023 14:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Aqi5DaDFyulOBCrzSHSRQGwWVva7rQc36ObDSjCjpkMfHtbpiF/HJdWZ2OqD3Gc072E03A==
X-Received: by 2002:a05:600c:218f:b0:401:b204:3b85 with SMTP id e15-20020a05600c218f00b00401b2043b85mr308599wme.36.1693343786711;
        Tue, 29 Aug 2023 14:16:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c299300b003fe539b83f2sm79038wmd.42.2023.08.29.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:16:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/8] drm/ssd130x: Use bool for ssd130x_deviceinfo flags
In-Reply-To: <87wmxeteyk.fsf@minerva.mail-host-address-is-not-set>
References: <cover.1692888745.git.geert@linux-m68k.org>
 <285005ff361969eff001386c5f97990f0e703838.1692888745.git.geert@linux-m68k.org>
 <87wmxeteyk.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 29 Aug 2023 23:16:25 +0200
Message-ID: <874jkhczx2.fsf@minerva.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> The .need_pwm and .need_chargepump fields in struct ssd130x_deviceinfo
>> are flags that can have only two possible values: 0 and 1.
>> Reduce kernel size by changing their types from int to bool.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Tested-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

