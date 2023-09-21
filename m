Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B807A9BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjIUTF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjIUTEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5254BBF3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2a24TVSLI/ISUJje8TKidtXyBUQe4xENgDvq1thGRYk=;
        b=NlpZfeL6jxlkZLCAwfPBAqBId/aI9rSl7zmhXRdfn8VGfm88cmygaJrA0xd6L7863LoYbH
        5MNQBB5p7qQTxlfAT3xVNEAOf7ssNZ/3AFkDy20nRgof172XBlchoBAaVTuXRlhIX8rOz3
        /WghunTh4U+VVK5DxZacvdBWMyFPAIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-iGyNz9BYNNu28d6CjkflBQ-1; Thu, 21 Sep 2023 04:23:45 -0400
X-MC-Unique: iGyNz9BYNNu28d6CjkflBQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40526a782f7so5406925e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 01:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695284624; x=1695889424;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a24TVSLI/ISUJje8TKidtXyBUQe4xENgDvq1thGRYk=;
        b=Ez6rxdIj+PdbDpexvMc3hLpTS4Im/8fZvYABDqshWhWxedw9Vjbo6+eBWeDT7fjpTS
         ij4cuNmE8009VIid2ylsil38HIzKJmVzowK2sOW2OHih4AqslIXpTKUIKl/8SW0xNVkS
         joWn8Q9UlXvrBe695dsrzGl6/4P87la9mWuEjGSXeGLbPMT6l4NqOE+XlVuKE8ffcJ9e
         Jgokj1GtrkGFF5xUcnXu/LZ5NF6umV7JluYO+WjyBdjbA51B1t1onebwmOUq/I+H8Cd2
         6Q1yCn30bQr58HFy8Io257iWxSiGA49HtV8AlGmW3y/7uKCwRrBJzT+9bQvDBErLQuMI
         QiiA==
X-Gm-Message-State: AOJu0YzfEK6GwbruUyZg7lWZM0d1q9IHazxqL0aRCh7IPHSWrzoRdn15
        XEzaGrI4wsX/pvVNHfGebXK+MfLzDMkm+UMBHBCDci6N4l5JjvAP15E4o3Ft2qQ8psuHS/UQz7t
        lVp4cq+5flxj9+p1PMDI22EBg
X-Received: by 2002:a05:600c:20c1:b0:3fe:1679:ba7b with SMTP id y1-20020a05600c20c100b003fe1679ba7bmr4939534wmm.24.1695284624093;
        Thu, 21 Sep 2023 01:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGlPOfVc6+NVtnxGMl+uEHFTePMh01hmYsAi7mZMUCQ5GxvG/QCdlDyActQ6KVS/yLXVCyzQ==
X-Received: by 2002:a05:600c:20c1:b0:3fe:1679:ba7b with SMTP id y1-20020a05600c20c100b003fe1679ba7bmr4939520wmm.24.1695284623713;
        Thu, 21 Sep 2023 01:23:43 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c23-20020a7bc857000000b003fefca26c72sm1247813wml.23.2023.09.21.01.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:23:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
In-Reply-To: <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com>
References: <20230914195138.1518065-1-javierm@redhat.com>
 <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
 <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set>
 <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
 <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com>
Date:   Thu, 21 Sep 2023 10:23:42 +0200
Message-ID: <878r90kk8h.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert and Maxime,

> Hi Maxime,
>
> On Thu, Sep 21, 2023 at 9:44=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
>> On Mon, Sep 18, 2023 at 09:19:07AM +0200, Javier Martinez Canillas wrote:
>> > Thomas Zimmermann <tzimmermann@suse.de> writes:
>> > > Am 14.09.23 um 21:51 schrieb Javier Martinez Canillas:
>> > >> The driver uses a naming convention where functions for struct drm_=
*_funcs
>> > >> callbacks are named ssd130x_$object_$operation, while the callbacks=
 for
>> > >> struct drm_*_helper_funcs are named ssd130x_$object_helper_$operati=
on.
>> > >>
>> > >> The idea is that this helper_ prefix in the function names denote t=
hat are
>> > >> for struct drm_*_helper_funcs callbacks. This convention was copied=
 from
>> > >> other drivers, when ssd130x was written but Maxime pointed out that=
 is the
>> > >> exception rather than the norm.
>> > >
>> > > I guess you found this in my code. I want to point out that I use the
>> > > _helper infix to signal that these are callback for
>> > > drm_primary_plane_helper_funcs and *not* drm_primary_plane_funcs. The
>> > > naming is intentional.
>> >
>> > Yes, that's what tried to say in the commit message and indeed I got t=
he
>> > convention from drivers in drivers/gpu/drm/tiny. In fact I believe the=
se
>> > function names are since first iteration of the driver, when was meant=
 to
>> > be a tiny driver.
>> >
>> > According to Maxime it's the exception rather than the rule and sugges=
ted
>> > to change it, I don't really have a strong opinion on either naming TB=
H.
>>
>> Maybe that's just me, but the helper in the name indeed throws me off. I=
n my
>> mind, it's supposed to be used only for helpers, not functions implement=
ing the
>> helpers hooks.

I agree with your definition of helpers. But more importantly for me is
what you mentioned, that most DRM drivers aren't using this convention
of concatenating  the driver name + struct type name + callback name.

>
> With several callbacks using the same (field) name, it is very helpful
> to name the actual implementation by combining the struct type name
> and the field name.  Anything else confuses the casual reader.

Both options have cons and pros (e.g: quickly figuring out to what struct
callback is associated as you said), but the reason I posted this patch is
to attempt making the driver more consistent with the rest of the drivers.

> Perhaps the real question is whether the structures should have "helper"
> in their name in the first place?
>

Indeed. I never fully understood why the DRM/KMS objects callbacks are
split in drm_$object_funcs and drm_$object_helper_funcs structs. AFAIU
is because the former is the minimum required and the latter is to add
additional custom behavior ?

I read this section of the documentation but still isn't clear to me:

https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html

> Just my 2=E2=82=ACc as a DRM novice...
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

