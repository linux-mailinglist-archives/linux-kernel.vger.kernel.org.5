Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15478E188
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbjH3Vkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbjH3Vkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015D194
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693431480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBV0HnyI31Hv2AWMsxadgPSfaYJpOZDq2RNuu2t2Z+8=;
        b=Sii7o0qcuwUGQJSz+ZnYZl0x3txDnt5Oqr7pMzZ5BVaXmxyEsk93PAzwjWxIS+rwMyd0J4
        a/H+EFgPtWiSYxhGljWO0CzApJJHtyD7dmTFq0yPSg4Iv8RkfCyr72fIpma54/nD6L03/y
        XnPa2z1QHRo4rV1tSJKt8hrVwIercPA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-1yG1VppTPqmInWynvsc84Q-1; Wed, 30 Aug 2023 15:15:31 -0400
X-MC-Unique: 1yG1VppTPqmInWynvsc84Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a1c4506e1eso98158266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422930; x=1694027730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBV0HnyI31Hv2AWMsxadgPSfaYJpOZDq2RNuu2t2Z+8=;
        b=VYDmf4Km95ovU4P3r8qTI7t99c8ievBvN79liFWQ20VX2Hi9Y0h/6l3veKzp1JriNz
         4lnabUBNYXrdpvnobEo9/jEerFl8A9w03QmC2Mhine7d76umcuRM6ysSgMByyNsv1CO8
         CjSOri4VL7tjRpU/jfOt+novcYPhbrUDJiwFNpWDoiwzoAtzCOvE3bECcMuiu6gKbHTl
         ZY+u32bB5mMt75Vn/RBTZbjiKmjua09bgT6RUU2RmyTQPcEZbntYSgccffeojd/HXRLT
         JtRx7EFZinp7/0qxsaJZ9Er/3yr2kXK14fw1WwNWvUt90EmfLmgaPe2cRbyclaYC76f7
         njiA==
X-Gm-Message-State: AOJu0YzfM/I4Zp4jeeA3c0dEqy2bjsB/B9NDZoREIBqYORiebw91A5Ch
        T2os4eJzN0uRLGplOahG2lr3e88rYihGAWTYnDspeWMhcDXl5iKz/2TlS1tmLPIskDFl1uEXXdV
        qtNRBrrqr5siE/3RY8WaJRYkU
X-Received: by 2002:a05:6402:51c8:b0:523:37cf:6f37 with SMTP id r8-20020a05640251c800b0052337cf6f37mr2290527edd.4.1693422930284;
        Wed, 30 Aug 2023 12:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjUvAuvkykbuXvqA8bQi1z8q8Gj4+iVBJgsW7l3Dh0c5JlqxFhMaKRno+cvmE8+cDwXXn9mg==
X-Received: by 2002:a05:6402:51c8:b0:523:37cf:6f37 with SMTP id r8-20020a05640251c800b0052337cf6f37mr2290516edd.4.1693422929985;
        Wed, 30 Aug 2023 12:15:29 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id i9-20020aa7c709000000b0052a198d8a4dsm7116533edq.52.2023.08.30.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:15:29 -0700 (PDT)
Message-ID: <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
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
Date:   Wed, 30 Aug 2023 21:15:28 +0200
In-Reply-To: <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
         <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
         <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 17:29 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 5:19=E2=80=AFPM <pstanner@redhat.com> wrote:
> > On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner
> > > <pstanner@redhat.com>
> > > wrote:
>=20
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > >=20
> > > I'm wondering if this has no side-effects as string.h/string.c
> > > IIRC
> > > is
> > > used also for early stages where some of the APIs are not
> > > available.
> > >=20
> > > > @@ -6,6 +6,8 @@
> > > > =C2=A0#include <linux/types.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* for size_t */
> > > > =C2=A0#include <linux/stddef.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fo=
r NULL */
> > > > =C2=A0#include <linux/errno.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* for E2BIG */
> > > > +#include <linux/overflow.h>=C2=A0=C2=A0=C2=A0 /* for check_mul_ove=
rflow() */
> > > > +#include <linux/err.h>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* for ERR_PTR() */
> > >=20
> > > Can we preserve order (to some extent)?
> >=20
> > Sure. I just put it there so the comments build a congruent block.
> > Which order would you prefer?
>=20
> Alphabetical.
>=20
> compiler.h
> err.h
> overflow.h
> ...the rest that is a bit unordered...
>=20
> > > > =C2=A0#include <linux/stdarg.h>
> > > > =C2=A0#include <uapi/linux/string.h>
>=20
> ...

I mean I could include my own in a sorted manner =E2=80=93 but the existing
ones are not sorted:

/* SPDX-License-Identifier: GPL-2.0 */
#ifndef _LINUX_STRING_H_
#define _LINUX_STRING_H_

#include <linux/compiler.h>	/* for inline */
#include <linux/types.h>	/* for size_t */
#include <linux/stddef.h>	/* for NULL */
#include <linux/errno.h>	/* for E2BIG */
#include <linux/stdarg.h>
#include <uapi/linux/string.h>

extern char *strndup_user(const char __user *, long);

We could sort them all, but I'd prefer to do that in a separate patch
so that this commit does not make the impression of doing anything else
than including the two new headers

Such a separate patch could also unify the docstring style, see below

>=20
> > > > +/**
> > > > + * memdup_array_user - duplicate array from user space
> > >=20
> > > > + *
> > >=20
> > > Do we need this blank line?
> >=20
> > I more or less directly copied the docstring format from the
> > original
> > functions (v)memdup_user() in mm/util.c
> > I guess this is common style?
>=20
> I think it's not. But you may grep kernel source tree and tell which
> one occurs more often with or without this (unneeded) blank line.


It seems to be very much mixed. string.h itself is mixed.
When you look at the bottom of string.h, you'll find functions such as
kbasename() that have the extra line.

That's not really a super decisive point for me, though. We can remove
the line I guess


P.


>=20
> > > > + * @src: source address in user space
> > > > + * @n: number of array members to copy
> > > > + * @size: size of one array member
> > > > + *
> > > > + * Return: an ERR_PTR() on failure.=C2=A0 Result is physically
> > > > + * contiguous, to be freed by kfree().
> > > > + */
>=20
> ...
>=20
> > > > +/**
> > > > + * vmemdup_array_user - duplicate array from user space
> > >=20
> > > > + *
> > >=20
> > > Redundant?
> >=20
> > No, there are two functions:
> > =C2=A0* memdup_array_user()
> > =C2=A0* vmemdup_array_user()
> >=20
> > On the deeper layers they utilize kmalloc() or kvmalloc(),
> > respectively.
>=20
> I guess you misunderstood my comment. I was talking about kernel doc
> (as in the previous function).
>=20
> > > > + * @src: source address in user space
> > > > + * @n: number of array members to copy
> > > > + * @size: size of one array member
> > > > + *
> > > > + * Return: an ERR_PTR() on failure.=C2=A0 Result may be not
> > > > + * physically contiguous.=C2=A0 Use kvfree() to free.
> > > > + */
>=20
>=20

