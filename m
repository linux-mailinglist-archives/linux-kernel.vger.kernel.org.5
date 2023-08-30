Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAF78DFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjH3TX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245012AbjH3OU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CE12F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693405176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GV/8QzaCRMszcMvgwKB+jPm2RB1o5GXV7tIF+sEGovU=;
        b=irJ9KyFgKaOyy+5yyRFp3KbEW2Qu4Kmgb4rDuqWYJlME5zBfoeQ09EiidD9g+ktndTXbYZ
        Cl1SrPseaeKJGELTiK1o7t5PSMg4j4xTRKhCCVMvFsupx8RgxZwQWggxXXwA1XjGFVrqw/
        r/vE38Mb/U0MO1eOEdUCpNLidsPmajw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-5jnc0DkENoaO5txrfN5VPg-1; Wed, 30 Aug 2023 10:19:35 -0400
X-MC-Unique: 5jnc0DkENoaO5txrfN5VPg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a21e030751so61810566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405174; x=1694009974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV/8QzaCRMszcMvgwKB+jPm2RB1o5GXV7tIF+sEGovU=;
        b=Su+5yQwfg5S5djDUt1fDk0Rn7MhBZhmQNurtWoyybEui/7hhVegK4wfuIl/xWx+jfA
         NqTJI2PyPH94lhrLdNbs4NyFZY1tvt2yQb9D4Sli14TPLCXCPbG1ibUrgrzFZFLZXW61
         UL/R3jkRTKAkqaxwJ0xDZ5VE6h9uJpbtbBYWh8DrBRavWwUrjsyv6ndwdWwXVwGljkoJ
         W6IDaykz7mKwg5o/YC3oAkNeC3ZsnbwvhfCs2t/+3ER/sD7xyZjxu9zPVdFHi8jQN8vr
         vRegPsY73hZSnW6PQ8MwnvEjlEAJ1XQgNyBT19R2XuI1WROjxzuOhD/bMiaNh4Dhqiva
         WHzQ==
X-Gm-Message-State: AOJu0YwQnruFJFeE5+rQjgCQEK8irV8QjW9FP4Ve9cS26JVF+7A5ZMMN
        spWLwOkSsaVTYOB85K0r66jJHnpsJfCsGZTg5CA0GyaG4Yw2JKGDxkKTjiuT3ZYcLwYgM3U4db2
        byTtkx6SBpIOk3G/eeg+cuzPv
X-Received: by 2002:a17:906:739c:b0:9a1:c951:19f3 with SMTP id f28-20020a170906739c00b009a1c95119f3mr1414681ejl.0.1693405174419;
        Wed, 30 Aug 2023 07:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgX4N7o6LrqPe58Ba+4el88eUYu7+fOIk9nSYCp19l8FNrUVkg7t2XIL0g9pv34yH61rp8Q==
X-Received: by 2002:a17:906:739c:b0:9a1:c951:19f3 with SMTP id f28-20020a170906739c00b009a1c95119f3mr1414658ejl.0.1693405174044;
        Wed, 30 Aug 2023 07:19:34 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id ck17-20020a170906c45100b009a1a5a7ebacsm7182791ejb.201.2023.08.30.07.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:19:33 -0700 (PDT)
Message-ID: <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From:   pstanner@redhat.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Date:   Wed, 30 Aug 2023 16:19:32 +0200
In-Reply-To: <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
> >=20
> > Currently, user array duplications are sometimes done without an
> > overflow check. Sometimes the checks are done manually; sometimes
> > the
> > array size is calculated with array_size() and sometimes by
> > calculating
> > n * size directly in code.
> >=20
> > Introduce wrappers for arrays for memdup_user() and vmemdup_user()
> > to
> > provide a standardized and safe way for duplicating user arrays.
> >=20
> > This is both for new code as well as replacing usage of
> > (v)memdup_user()
> > in existing code that uses, e.g., n * size to calculate array
> > sizes.
>=20
> ...
>=20
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
>=20
> I'm wondering if this has no side-effects as string.h/string.c IIRC
> is
> used also for early stages where some of the APIs are not available.
>=20
> > @@ -6,6 +6,8 @@
> > =C2=A0#include <linux/types.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* f=
or size_t */
> > =C2=A0#include <linux/stddef.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* for NU=
LL */
> > =C2=A0#include <linux/errno.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* f=
or E2BIG */
> > +#include <linux/overflow.h>=C2=A0=C2=A0=C2=A0 /* for check_mul_overflo=
w() */
> > +#include <linux/err.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* for ERR_PTR() */
>=20
> Can we preserve order (to some extent)?

Sure. I just put it there so the comments build a congruent block.
Which order would you prefer?

>=20
> > =C2=A0#include <linux/stdarg.h>
> > =C2=A0#include <uapi/linux/string.h>
>=20
> ...
>=20
> > +/**
> > + * memdup_array_user - duplicate array from user space
>=20
> > + *
>=20
> Do we need this blank line?

I more or less directly copied the docstring format from the original
functions (v)memdup_user() in mm/util.c
I guess this is common style?

>=20
> > + * @src: source address in user space
> > + * @n: number of array members to copy
> > + * @size: size of one array member
> > + *
> > + * Return: an ERR_PTR() on failure.=C2=A0 Result is physically
> > + * contiguous, to be freed by kfree().
> > + */
>=20
> ...
>=20
> > +/**
> > + * vmemdup_array_user - duplicate array from user space
>=20
> > + *
>=20
> Redundant?

No, there are two functions:
 * memdup_array_user()
 * vmemdup_array_user()

On the deeper layers they utilize kmalloc() or kvmalloc(),
respectively.


Greetings,
P.

>=20
> > + * @src: source address in user space
> > + * @n: number of array members to copy
> > + * @size: size of one array member
> > + *
> > + * Return: an ERR_PTR() on failure.=C2=A0 Result may be not
> > + * physically contiguous.=C2=A0 Use kvfree() to free.
> > + */
>=20

