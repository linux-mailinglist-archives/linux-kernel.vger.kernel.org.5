Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA987C4D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjJKIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32193
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697013439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7J164Jv856pwHwwnBhSJ7e6PzthL3kRqEqL41tQ+DM=;
        b=KxZiU2QW8Vpc4StTiYYPtcspNTQhJeW+XnRg9iZqt3VqQ+uqap6QpzLwUQNoYIb3GTgRt2
        gXjN3spsyIE71K9W1hMbyqsW0TywjPhW//XSYPWLESvC7+7Hos4VzRhX+nfLfbiL2QQd1Q
        K1FC76OK2Q7yP4vYMPwQyIP+RjuMC2A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-llKCFs0TPlebHCUyFElKyw-1; Wed, 11 Oct 2023 04:37:03 -0400
X-MC-Unique: llKCFs0TPlebHCUyFElKyw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4074f9d17a5so18173665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013422; x=1697618222;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7J164Jv856pwHwwnBhSJ7e6PzthL3kRqEqL41tQ+DM=;
        b=XOJcIH5b4QLR9FXQ3Dsh8DMD/qP6NpnBrFU59tWAxor78XF/khEbhf/DeaG7aUa+ej
         7l1Z9tDGK2MV39m+NTSA3TExUwJDg8r2MD6Pdzhuo7EVuKVe2iWoJRTbPg7Sncq8oZE4
         JmtVIzWbD2bmnSIPHYvLKEH7s/v2ojtERlmdHbfBjf5tBo8FcE9IHQfL9lO+hwwE9j02
         Hk7fPFY5V/COqokHS5qqou1zIzBXbvMZEK1COYUaWMWaWg946kc8wkVOLzkzMTh6V4g/
         7zvHEpQhIKyhRcBB4dtkmKNJaD3IREgXiV5JyGlE3vhc78ORUQT2GtcduV3Yy/v/UO5z
         D+tw==
X-Gm-Message-State: AOJu0YySZt0GkGqUR/nDpn3dXQSHBZwRq/mOFT+Qz48lpgw1fyjBAcf1
        49oF4OIib8XpAIjQIeja3EfJwzWm2f7yCYRIMHJ4MBKlIY/hHZdRwJX0erhVpNuiY8cUUmt56OM
        1xFvvavl5NCHY4GgRDJ8rGrk5
X-Received: by 2002:a5d:6549:0:b0:319:6caa:ada2 with SMTP id z9-20020a5d6549000000b003196caaada2mr17296327wrv.47.1697013422249;
        Wed, 11 Oct 2023 01:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLdbdkbYyfLcflQYmxxFwpoj7vs8zsEEpQXxYh+0xujwPn0ZUzvlgXcWRbym9VmYKIK7f2lA==
X-Received: by 2002:a5d:6549:0:b0:319:6caa:ada2 with SMTP id z9-20020a5d6549000000b003196caaada2mr17296309wrv.47.1697013421899;
        Wed, 11 Oct 2023 01:37:01 -0700 (PDT)
Received: from localhost ([185.124.31.160])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm14727110wrm.64.2023.10.11.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:37:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/8] drm/ssd13xx: Use drm_format_info_min_pitch() to
 calculate the dest_pitch
In-Reply-To: <CAMuHMdWmzUx6iOhSSfNz4NyMZ0vY6Md6cn86S0BjOjhzzPuO=g@mail.gmail.com>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-5-javierm@redhat.com>
 <CAMuHMdWmzUx6iOhSSfNz4NyMZ0vY6Md6cn86S0BjOjhzzPuO=g@mail.gmail.com>
Date:   Wed, 11 Oct 2023 10:37:00 +0200
Message-ID: <87mswpsggj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Mon, Oct 9, 2023 at 8:36=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Don't assume bpp of 1 and instead compute the destination pitch using the
>> intermediate buffer pixel format info when doing a format conversion.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thanks for your patch!
>
>> --- a/drivers/gpu/drm/solomon/ssd13xx.c
>> +++ b/drivers/gpu/drm/solomon/ssd13xx.c
>> @@ -148,6 +148,8 @@ struct ssd13xx_plane_state {
>>         struct drm_shadow_plane_state base;
>>         /* Intermediate buffer to convert pixels from XRGB8888 to HW for=
mat */
>>         u8 *buffer;
>> +       /* Pixel format info for the intermediate buffer */
>> +       const struct drm_format_info *fi;
>
> This is really intermediate, as it is removed again in the next patch :-)
>
> In fact 60% of this patch is changed again in the next patch.
> So perhaps combine this with the next patch?
>

I actually had it like that but then thought that maybe someone would say
that should be a separate patch :) I will squash it then.

> Gr{oetje,eeting}s,
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

