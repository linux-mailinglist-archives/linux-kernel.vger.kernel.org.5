Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DA8802ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjLDJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjLDJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7DE100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701682794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjxQsqndp2YNOEtpcHkzhSj4Ex7oFFPfHpZ5413ZYNE=;
        b=iS1gnsiiwx34kuHRxzOqBEam0MsDlivn4H1/nL/Ffm8xfQgevREv5INbVgsHEgwIEF1cB9
        z0eF3D2Yfua2ioPm2GES7y4rl0PQK1wvE7fJjhf/59BYKk4Cv2HZmY82fKEAbEM8RAv+P6
        dKVCfV/kFWUiP5fS015rbprBhzxnAss=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Quaz1C4UP0Cg3ZegEoZngg-1; Mon, 04 Dec 2023 04:39:52 -0500
X-MC-Unique: Quaz1C4UP0Cg3ZegEoZngg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b39377136so31725955e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682791; x=1702287591;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjxQsqndp2YNOEtpcHkzhSj4Ex7oFFPfHpZ5413ZYNE=;
        b=s5xHfhM1boLEctn32zP67aBf1kcxVvBPXa0FgBHtQV6gxRW8fE8sPj2NQ4U20hKfra
         oOesekf9NYrh962TzP23OKpWPtDWZKVzQON5wxrGY7trnYstDagHMOXiWWj2LR7O8ckG
         O5DPzxekGSqUHud6Ljhs40mihgOVdnA8kOpqGiDDne9sf4wpmCJG3hv8lLrpHJKg005p
         sksrbyFeHMjc7NAACp0Hjr3MzadkgVtYfmMzdCk9SSB2psc45WsPyPZEgtA0HSyWcAEX
         HGtKo9HXljj7uVLzEopBRMA7fICX/VN2oSXHHa7urJ7Uk9SZ7xFErw8614bxF82suWPi
         qmzw==
X-Gm-Message-State: AOJu0YwRjmrB9Dfol32UqOOE44ol3m4yQNhb08OoStiDGM1rv9iNat9o
        NvCUdVpo9xNjsecJPjE2TKJ4BFDt3eg2zjB5Uitp9QAzwATllxOdKK+WtBm8Ud3kP/lAKkToNWN
        yCLdZRysu5tT02hA3jCSl3TSA
X-Received: by 2002:a7b:c2b2:0:b0:40b:5e59:ea12 with SMTP id c18-20020a7bc2b2000000b0040b5e59ea12mr2222052wmk.177.1701682791038;
        Mon, 04 Dec 2023 01:39:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExL00bqqXgrqIQyIEewRdVX5DUBUHVJDjGkpysRiiHgP6pn1w5E/Kzz/sPmNtx04t6PJhBKA==
X-Received: by 2002:a7b:c2b2:0:b0:40b:5e59:ea12 with SMTP id c18-20020a7bc2b2000000b0040b5e59ea12mr2222041wmk.177.1701682790651;
        Mon, 04 Dec 2023 01:39:50 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m40-20020a05600c3b2800b004042dbb8925sm18119091wms.38.2023.12.04.01.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:39:50 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, devicetree@vger.kernel.org,
        Sergio Lopez <slp@redhat.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Andrew Worsley <amworsley@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
In-Reply-To: <CAL_JsqJbZ736iV+bRbSNNaimkbJLpB9MbeKLSct16Yi67ttFcw@mail.gmail.com>
References: <20231113085305.1823455-1-javierm@redhat.com>
 <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
 <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
 <CAMj1kXG7Xyk0ys9j-XRo7Rr8gYz1qJE8fFSixBOwVbm-pjeX+A@mail.gmail.com>
 <874jhj1fm3.fsf@minerva.mail-host-address-is-not-set>
 <58672ab8-99bf-4a2a-af79-031d1e8fcba0@suse.de>
 <87fs0mxlyp.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJbZ736iV+bRbSNNaimkbJLpB9MbeKLSct16Yi67ttFcw@mail.gmail.com>
Date:   Mon, 04 Dec 2023 10:39:49 +0100
Message-ID: <87a5qqxq56.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

Hello Rob,

> On Fri, Dec 1, 2023 at 4:21=E2=80=AFAM Javier Martinez Canillas

[...]

>> >> I don't have a better idea than this patch but maybe Thomas or Sima d=
o?
>> >
>> > At SUSE, we've carried such a patch in our repos for some time. It wor=
ks
>> > around the double-framebuffer problem in a similar way. [1]
>> >
>>
>> Thanks for the information. I see that your patch is basically mine but
>> doing it unconditionally while this one only does the sysfb_disable() if
>> a "simple-framebuffer" DT node has been found.
>>
>> > As Javier mentioned, we do track the framebuffer ranges for EFI/VESA/OF
>> > framebuffers in the graphics aperture helpers. Fbdev has done this for
>> > decades, and the current codebase extends and harmonizes this
>> > functionality among fbdev and DRM drivers.
>> >
>> > WRT DT vs EFI: AFAIK the EFI support on affected platforms looks at the
>> > DT to set up the EFI framebuffer. So IMHO the DT is the authoritative
>> > source on the framebuffer.
>> >
>>
>> Agreed. Sima Vetter also mentioned on IRC that they think this patch is
>> the least bad option. Rob, Ard any thoughts? Maybe we can land this as
>> a fix and then figure how this could be better handled in the long term?
>
> What about moving the DT setup code here to sysfb? Then we just setup
> the right thing up front.
>

Right now sysfb is pretty platform agnostic, in the sense that just looks
at the screen_info global struct and uses it to add the platform data that
contains the firmware provided framebuffer.

How the screen_info was filled (e.g: by the Linux EFI stub using the GOP
or the x86 early boot code using VESA) is transparent to sysfb. For this
reason adding platform specific logic there, like finding OF nodes, is not
desirable.

I also suggested to Thomas to move the DT setup code to sysfb but he said
that would be the wrong approach for the reason mentioned above. Please
correct me Thomas if I'm misremembering here.

> However, there might be one other issue with that and this fix. The DT
> simplefb can have resources such as clocks and regulators. With
> fw_devlink, the driver won't probe until those dependencies are met.
> So if you want the framebuffer console up early, then you may want to
> register the EFI framebuffer first and then handoff to the DT simplefb
> when it probes (rather than registering the device).
>
> But I agree, probably better to take this patch now and have those
> quirks instead of flat out not working.
>

If we do that what's the plan? Are you thinking about merging this patch
through your OF tree or do you want to go through drm-misc with your ack?

> Rob
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

