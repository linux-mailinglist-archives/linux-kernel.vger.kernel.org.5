Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF37E285D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKFPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjKFPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8069B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699283573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyNTZV5EWEbVcsjEEcix1QYAz8PWV6uUt3nEay8zko8=;
        b=arAZ36Z8+Pc7rD+wrq+z6rEEDYRYS2y4CCBUoAdMInKVuoS5ikw+SuOh6b0DrkFQw0lq/u
        RiTa3bqw+uz/H7x2D428Irr5rcuSUKrkbbr4FrlyJCbqzpUIXeLpRq09JHWK1MbiLpVYwT
        uZZvLmwNCRf9QqSQRSkWVOBCgpzchus=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-U_KvfnrtMueHEGc7fzGvcA-1; Mon, 06 Nov 2023 10:12:52 -0500
X-MC-Unique: U_KvfnrtMueHEGc7fzGvcA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso326286966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283571; x=1699888371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyNTZV5EWEbVcsjEEcix1QYAz8PWV6uUt3nEay8zko8=;
        b=Yc5kZISAPIar8gzGKE/cTnm0R5BCVAMUTVyNpaP8yJ5IFmJblsmTb9SjuD6WrPNlkB
         fnZWafIAZ0gRkhZkNaHcvqUox0NLHj4NRI/fMgs+dgDXfi7W7wmSVvGAaF6RB4Hv34jN
         0wnIqTPXzDQ/na97VIiaSvHce5ifqxs4DLj7tAw+HvhdBiev4R1DFgSjpsjK5z8eGwG9
         3d0ZPYRHxhFbRx92nQJh/ZmnVIIoenn5ZbLfY3OozpMJ+6itH5rwiqonTZD6SEQfYfii
         14QmXG/icLRe+jZslsm7NHm4QOL5a7QbkDfAa2Uz/NcEhtBPihFG406z+jk6mKqHTXnu
         heNg==
X-Gm-Message-State: AOJu0Yx/KwFXIrkt5GiNCU0DYOVPBqtPBIDoCE/T1CnvxH9RjBJJi2Xn
        L2BCGahaajidFAdAbR9VQeseN+9Yp5aztIkAAB32vGPFuz+Ul4LdX/xUMcjDXumO8D3T/SQMcEO
        3X9gqRg5fCM7/HdI3ctVTFg0mJP6Rr+7Ay1bPWOtl
X-Received: by 2002:a17:907:9811:b0:9dd:7ccf:77f8 with SMTP id ji17-20020a170907981100b009dd7ccf77f8mr7562491ejc.20.1699283571256;
        Mon, 06 Nov 2023 07:12:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2YEM5ISvIiyX5pdjuegtQ5SrrbIrBKyeYx0DojFwg+/s7On1aAWyRlcVDxxj3a+zujzRpSSTVBh3dtBe/Xmo=
X-Received: by 2002:a17:907:9811:b0:9dd:7ccf:77f8 with SMTP id
 ji17-20020a170907981100b009dd7ccf77f8mr7562474ejc.20.1699283570957; Mon, 06
 Nov 2023 07:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20231103161635.1902667-1-aahringo@redhat.com> <20231103185414.GD8262@noisy.programming.kicks-ass.net>
 <CAK-6q+hQnTgmO_2qfNDzyYW36T1aH+a5q285G+Rfo+sN4dfEfA@mail.gmail.com> <20231106111104.GK8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231106111104.GK8262@noisy.programming.kicks-ass.net>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 6 Nov 2023 10:12:39 -0500
Message-ID: <CAK-6q+iwqjkuxVqt6hMw3uoq0UsZxvx_x2rdLDtsBSdURpjv-g@mail.gmail.com>
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Mon, Nov 6, 2023 at 6:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Fri, Nov 03, 2023 at 03:20:08PM -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Fri, Nov 3, 2023 at 2:54=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Fri, Nov 03, 2023 at 12:16:34PM -0400, Alexander Aring wrote:
> > >
> > > > diff --git a/lib/refcount.c b/lib/refcount.c
> > > > index a207a8f22b3c..e28678f0f473 100644
> > > > --- a/lib/refcount.c
> > > > +++ b/lib/refcount.c
> > > > @@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
> > > >  }
> > > >  EXPORT_SYMBOL(refcount_dec_not_one);
> > > >
> > > > +bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lo=
ckptr),
> > > > +                           void (*unlock)(void *lockptr),  void *l=
ockptr)
> > > > +{
> > > > +     if (refcount_dec_not_one(r))
> > > > +             return false;
> > > > +
> > > > +     lock(lockptr);
> > > > +     if (!refcount_dec_and_test(r)) {
> > > > +             unlock(lockptr);
> > > > +             return false;
> > > > +     }
> > > > +
> > > > +     return true;
> > > > +}
> > > > +EXPORT_SYMBOL(refcount_dec_and_lockptr);
> > >
> > > This is terrible, you're forcing indirect calls on everything.
> > >
> >
> > Okay, I see. How about introducing a macro producing all the code at
> > preprocessor time?
>
> __always_inline should work, then you get constant propagation for the
> function pointer.
>

Thanks, it is always good to learn something new.

> But indeed, perhaps a macro is more convenient vs the irq flags
> argument. You'll then end up with something like:
>
> #define __refcount_dec_and_lock(_ref, _lock, _unlock) \
> ({      bool _ret =3D false; \
>         if (!refcount_dec_not_one(_ref)) { \
>                 _lock; \
>                 if (!refcount_dec_and_test(_ref)) { \
>                         _unlock; \
>                 } else { \
>                         _ret =3D true; \
>                 } \
>         } \
>         _ret; \
> })
>
>
> bool refcount_dec_and_spinlock_irqsave(refcount_t *r, spinlock_t *lock,
>                                        unsigned long *flags)
> {
>         return __refcount_dec_and_lock(r, spin_lock_irqsave(*lock, *flags=
),
>                                           spin_unlock_irqrestore(*lock, *=
flags));
> }

I was thinking of solving the additional flags parameter with
prototype and argos macros e.g. TRACE_EVENT() is doing it, but this
version looks much better.
I will send a patch and do similar things with _kref_put_lock().

- Alex

