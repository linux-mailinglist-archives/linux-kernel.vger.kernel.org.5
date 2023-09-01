Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2F78FCA7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347986AbjIALvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjIALvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086BE70
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693569024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bh4M+0J5a4/CTD9vzV/Dp4WE5uZXZTOLGhwgiKslvu4=;
        b=VV7ZQ2OGulBSy6rmTTHNVdk36rmqPI78zJxieY/1B2k1uwpEEJOHNWtQawojAI2nL2pB+r
        B+2kgqpah+LNJDoPaJUY71XZqdxoqos4+Gh6AFY3C+ICv5wFFAb3MgfJfARWsuElrmm6LV
        cknn1Wq8AD76TAVWtOIdQ//Ns2l3rU0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-lkWeqxIUP5CML4eIWqG9jg-1; Fri, 01 Sep 2023 07:50:23 -0400
X-MC-Unique: lkWeqxIUP5CML4eIWqG9jg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bcdd6ba578so24207581fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693569021; x=1694173821;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh4M+0J5a4/CTD9vzV/Dp4WE5uZXZTOLGhwgiKslvu4=;
        b=Zd3MuowSYDRANiALVGObKuLfCj+VFx1PmEkSwPdaL6xNBl2IhUWMBldB87iIDk21o/
         FgqooAfUt3601xNVo3j3HheHGY75lFSLJs8uAvbqJVIa0cT1l82NSn5WLbmQ+OvCMuMa
         6CIk8R7RwPLC7pMnCaIYxZqmIqd0XJiX8XQXipdtPxcVq+nitzDjeAmbaHmfqfGew6oM
         FEqIVRMi/tGzIQEezA8yCn4YLmlXXBSA+SvC8trsHrqtQ8UXB265A/NYp6Hg/b3Pe0sz
         jAs7kMVVFZ6AgCVzbpcjaBpe6rMsRfAZ29v5X5/2lFc1ahbFt1h5v8r113fpC3huG+Q5
         ULxA==
X-Gm-Message-State: AOJu0YzL32xk2ySc8fX/835QYyhiYRl8ZyYJ2/nxrJeSU8WWeo1h+3bs
        k2e5ajpHQ+TbAInzpppvEFp1TfJ9jWdj6Z+3BGb+a03bijOlfpNf+ncS8fpOmh/Xvsc887Rzhs5
        oSVxBnufUj0EhBChTLCy36A+9
X-Received: by 2002:a2e:8705:0:b0:2bb:78ad:56cb with SMTP id m5-20020a2e8705000000b002bb78ad56cbmr1393667lji.37.1693569021716;
        Fri, 01 Sep 2023 04:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgWsW0wqHHo8OvbLp/1dFSUtHgnbdLiA0JJsCnLDBV1UOwRcx3dWF2DKbmXfSG1VHzLxmOiA==
X-Received: by 2002:a2e:8705:0:b0:2bb:78ad:56cb with SMTP id m5-20020a2e8705000000b002bb78ad56cbmr1393655lji.37.1693569021360;
        Fri, 01 Sep 2023 04:50:21 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e4-20020adfe7c4000000b0031c6581d55esm5027861wrn.91.2023.09.01.04.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:50:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
In-Reply-To: <a6eca431-7464-09da-333d-a40318422077@suse.de>
References: <20230830062546.720679-1-javierm@redhat.com>
 <6654778d-1f40-1775-c32c-ebf9728bc9a9@suse.de>
 <87ledqbah2.fsf@minerva.mail-host-address-is-not-set>
 <a6eca431-7464-09da-333d-a40318422077@suse.de>
Date:   Fri, 01 Sep 2023 13:50:20 +0200
Message-ID: <87cyz25czn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi
>
> Am 01.09.23 um 09:48 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Hi Javier,
>>>
>>> another idea about this patch: why not just keep the allocation in the
>>> plane's atomic check, but store the temporary buffers in a plane struct.
>>> You'd only grow the arrays length in atomic_check and later fetch the
>>> pointers in atomic_update. It needs some locking, but nothing complicated.
>>>
>> 
>> Yes, that would work too. Another option is to just move the buffers to
>> struct ssd130x_device as it was before commit 45b58669e532 ("drm/ssd130x:
>
> Adding something like a struct ssd130x_plane that holds the temporary 
> memory has the advantage of making a clear connection between the memory 
> and the plane. If nothing else, to the next programmer reading the code.
>

Ok, I'm confused now. The current version of the driver already has a
struct ssd130x_plane_state that stores the buffers:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/solomon/ssd130x.c#n144

But what you are saying is that instead of setting those pointers to NULL
in the ssd130x_primary_plane_duplicate_state() function, it can just be
allocated once and the pointers copied when duplicating the new state?

So you want me to add some locking when accesing those since will be
shared between the old and new state?

In that case another option is to just kref the buffers, I think that
should be enough?

>> Allocate buffer in the plane's .atomic_check() callback") but just make
>> them fixed arrays with the size of the biggest format.
>
> What is the size of the biggest format? I haven't read the driver code, 
> but a shadow plane can be up to 4096 pixels wide. It's 16 KiB for 
> XRGB888. Not too much, but not nothing either.
>

The shadow plane yes, but I was talking about the buffers in:

struct ssd130x_plane_state {
	struct drm_shadow_plane_state base;
	/* Intermediate buffer to convert pixels from XRGB8888 to HW format */
	u8 *buffer;
	/* Buffer to store pixels in HW format and written to the panel */
	u8 *data_array;
};

These are not the size of the shadow buffer but the of the displayed area,
that depends on the panel fixed resolution (defined in the Device Tree).

The biggest resolution for ssd130x panels is 132x64 (SSD1305 and SH1106),
so that means the biggest buffer will be 132 * 64 * R1 pitch = 1056 bytes.

> To reduce allocation and/or locking overhead, you could try to update 
> the pointers in the plane struct with RCU semantics. Plane updates would 
> use whatever pointer they saw, while the plane's atomic_check could grow 
> the memory buffers as necessary.
>

I'm still unsure the added complexity is worth it. As mentioned, the fbdev
driver also allocats the buffers on each display update and at least the
intermediate .buffer that stores the XRGB8888 -> R1 conversion is tied to
the plane, the .data_array that sends the actual data to the controller
can be argued to be tied to the CRTC.

But given that a format change doesn't trigger a CRTC mode set (as Maxime
pointed out to me) then at least the .buffer allocation can't be done in
the CRTC .atomic_check() handler.

I could move the .data_array allocatoin there or even do it at probe time,
but since the .buffer allocation would be done in the plane
.atomic_check() anyways, I would rather keep as is and have both in the
same function.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

