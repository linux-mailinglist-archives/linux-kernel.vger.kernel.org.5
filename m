Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22312761F91
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjGYQwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGYQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC22D2D69
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690303818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReBcQaJh4ciBZ53LwBH/iMnMAzVIg5ii3SO9ToZLyw4=;
        b=Q+hLVlwnf1PN5jlq1YP3QJHZn+DXD2UzAHQl9OWWwBWLSqaPGZZgOa97sIbHwni17SNo73
        28NY8B/uOHJEICovcdZ8Nu9jovTl2vWawC78+6/KlaymYvkEmno/PhxJt8jgSG1iSAeInU
        kZNMnMEt8eiBnfa9te+DBv3gmJJcNSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-_vxV8mRFPi6QzaYowyWSCw-1; Tue, 25 Jul 2023 12:50:13 -0400
X-MC-Unique: _vxV8mRFPi6QzaYowyWSCw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fd2e59bc53so15804765e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303812; x=1690908612;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReBcQaJh4ciBZ53LwBH/iMnMAzVIg5ii3SO9ToZLyw4=;
        b=UcGLQSsJdCB471AN+088dT9spvOci7/HeHQZeEh68PBNhpgvvYTG12nNhaarWRzOuz
         8F+ffLZJ4C3y8REQbzSrbdGEoI8uK3yynWXXdWDE2W4kk6Nur6sVHvUHR+f+CjteYvuW
         yT1MTzsCTisJoZWHzpfQFjY6w4hcbsx5egJEwRnQ3aLTJ1Q8kcXm06BSyNtVLTHYeI6J
         D/0Vq7sd43TEZTLfom51/C8c0D33HHJg+Tx6haZOPyaEk3iAcsYfJdVC9yKU+dRJ+rqe
         bR+UBNhs7qYIlscRZaSIZY6lz1HtuQ8LCku14WEujZhnm+SXbKIeR/6fN9OkhcGzbC3I
         fn0Q==
X-Gm-Message-State: ABy/qLbnEbJe6nHSaBwA7t5OCbEvSSLS3INsf57/qbvIaPl5q/ghdJUX
        DNOXLAKTY1flgtYqO7ooBZ8SXiJISMNxyETCgAMEWOsGw6QuUqWrZe0K/zykcVvkCnezsxUnF+t
        tQmiWOzfT2+Zao5Byu1ResuEc
X-Received: by 2002:a1c:750f:0:b0:3fb:e4ce:cc65 with SMTP id o15-20020a1c750f000000b003fbe4cecc65mr8474616wmc.25.1690303812289;
        Tue, 25 Jul 2023 09:50:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHN82DdekK0zitC8eYAyRNRTQ+aka1Hte/M4lbyqh0MgYS8XBWVNfmNZPV6nkNQ6F6sXzyn3A==
X-Received: by 2002:a1c:750f:0:b0:3fb:e4ce:cc65 with SMTP id o15-20020a1c750f000000b003fbe4cecc65mr8474601wmc.25.1690303811924;
        Tue, 25 Jul 2023 09:50:11 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc851000000b003fc00212c1esm13464147wml.28.2023.07.25.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:50:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
 <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
Date:   Tue, 25 Jul 2023 18:50:10 +0200
Message-ID: <877cqoj5q5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Tue, Jul 25, 2023 at 6:07=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert+renesas@glider.be> writes:
>> > If CONFIG_FB_CORE=3Dy but CONFIG_FB=3Dn, the frame buffer bootup logos=
 can
>> > no longer be enabled.  Fix this by making CONFIG_LOGO depend on
>> > CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
>> > logo code to depend on the presence of real frame buffer device driver=
s.
>>
>> Indeed.
>>
>> > Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and =
FB_CORE symbols")
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > ---
>> >  drivers/video/Kconfig      | 2 +-
>> >  drivers/video/logo/Kconfig | 2 +-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> > index e5b1cc54cafa10d5..b694d7669d3200b1 100644
>> > --- a/drivers/video/Kconfig
>> > +++ b/drivers/video/Kconfig
>> > @@ -63,7 +63,7 @@ if VT
>> >       source "drivers/video/console/Kconfig"
>> >  endif
>> >
>> > -if FB || SGI_NEWPORT_CONSOLE
>> > +if FB_CORE || SGI_NEWPORT_CONSOLE
>> >       source "drivers/video/logo/Kconfig"
>> >
>> >  endif
>> > diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
>> > index 6d6f8c08792dc897..b7d94d1dd1585a84 100644
>> > --- a/drivers/video/logo/Kconfig
>> > +++ b/drivers/video/logo/Kconfig
>> > @@ -5,7 +5,7 @@
>> >
>> >  menuconfig LOGO
>> >       bool "Bootup logo"
>> > -     depends on FB || SGI_NEWPORT_CONSOLE
>> > +     depends on FB_CORE || SGI_NEWPORT_CONSOLE
>> >       help
>> >         Enable and select frame buffer bootup logos.
>>
>> Should then move this option to drivers/video/fbdev/core/Kconfig ?
>
> No, all logo options are in their own file.
>

Yes. I meant to move drivers/video/logo/ to drivers/fbdev/core/logo and to
source its Kconfig from drivers/fbdev/core/Kconfig, since it now depends
on FB_CORE.

But I see now that it also depends on SGI_NEWPORT_CONSOLE, so having those
in drivers/video/logo makes sense indeed.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

