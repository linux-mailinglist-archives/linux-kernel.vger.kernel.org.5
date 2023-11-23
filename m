Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B67F63B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjKWQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjKWQMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:12:15 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD999D65
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:12:20 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a0dd02364so1778846d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700755940; x=1701360740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGyQEtxcPZXDfK5MLunRkVEU0dG6NY5S9HKgUKbsr1Y=;
        b=DKoCw+MHJS0U+4NYeqOj347Wc1dH5pN2oYybdIXkQr0udFII+4/v9lGpKV9deTcGM2
         tPBfeoqEcEsplKO8Ux3wWL5SxaWswHJnipc22D5w6KK3JV5siH4EPZ07E5DewFs9hZMS
         SnXho2oeUnJSXcPauCclQZz7TtVUDWTMFYwbmVE+tusiNRcl464lwXGUs4bxhzUee7Z+
         4YSkyji1UtZl4HMlfYu3O+DSD6Xw9MB8OTWSRurY2EmD9uYO+JDrbnPScEg+6tNBGYqC
         CKDCG7c07yvUIC89mjhxaalAYBCr0iz4hq6tpfIpIykND4o1YWcCJsMUm7M2ks+FeS1/
         9/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755940; x=1701360740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGyQEtxcPZXDfK5MLunRkVEU0dG6NY5S9HKgUKbsr1Y=;
        b=RVGnV5n5mhVFoqqroJomEtXzkBXZxowxItq8X4RO/EDmlgslD6LssY8oszJw2PNUKy
         C/ItZj+0BYTApU1LX0fsLiuGR+097kj4g8scr7pxcZXcJT1dIh2MmMlONUUADOtHYP3p
         3k0oE3KJdBzwZyPqJx671n/uW0Y7kDRwdeswDqmk7z2RvZDuI2KmxGptafIg7HvjhleS
         XbFQKAkbIdNcnVmjOzW2/mfFnFyHGnUVE0z++OHBtqhLry1mRAb4ebMbD7tyuQjUlSER
         aplCSnEgHIEaBuT6GL8xX1gnl8lByrRJ0AkIQX3CCUDFAK6ULaFyd+nvoW+1Fdk3qZj7
         O9iw==
X-Gm-Message-State: AOJu0Yz+qdZmmf6wF3ijx4BDgCzFdjr+LL77pdsbkOqzazaLFWmsCtbt
        xE68zKVqCGrAM2CvyY2Sdd8b7R5p0WJSQsYPlNBfDXJJoDfyww==
X-Google-Smtp-Source: AGHT+IFf92rQ7Iiv6WS+3q0acJTP9/j2IzOmmhqe6Em2KAoTKcA9LyHepmXhNDvx76jaLNiTaV6rjfAxwkYjqXRBPS0=
X-Received: by 2002:a05:6214:21e2:b0:672:aecf:581a with SMTP id
 p2-20020a05621421e200b00672aecf581amr6478936qvj.47.1700755939932; Thu, 23 Nov
 2023 08:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20231122231202.121277-1-andrey.konovalov@linux.dev> <ZV7whSufeIqslzzN@feng-clx>
In-Reply-To: <ZV7whSufeIqslzzN@feng-clx>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 23 Nov 2023 17:12:08 +0100
Message-ID: <CA+fCnZcAnZh7H901SZFsaU=-XrpUeeJwUeThMpduDd1-Wt0gsA@mail.gmail.com>
Subject: Re: [PATCH mm] slub, kasan: improve interaction of KASAN and
 slub_debug poisoning
To:     Feng Tang <feng.tang@intel.com>
Cc:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 7:35=E2=80=AFAM Feng Tang <feng.tang@intel.com> wro=
te:
>

Hi Feng,

> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -870,20 +870,20 @@ static inline void set_orig_size(struct kmem_cach=
e *s,
> >                               void *object, unsigned int orig_size)
> >  {
> >       void *p =3D kasan_reset_tag(object);
> > +     unsigned int kasan_meta_size;
> >
> >       if (!slub_debug_orig_size(s))
> >               return;
> >
> > -#ifdef CONFIG_KASAN_GENERIC
> >       /*
> > -      * KASAN could save its free meta data in object's data area at
> > -      * offset 0, if the size is larger than 'orig_size', it will
> > -      * overlap the data redzone in [orig_size+1, object_size], and
> > -      * the check should be skipped.
> > +      * KASAN can save its free meta data inside of the object at offs=
et 0.
> > +      * If this meta data size is larger than 'orig_size', it will ove=
rlap
> > +      * the data redzone in [orig_size+1, object_size]. Thus, we adjus=
t
> > +      * 'orig_size' to be as at least as big as KASAN's meta data.
> >        */
> > -     if (kasan_metadata_size(s, true) > orig_size)
> > -             orig_size =3D s->object_size;
> > -#endif
> > +     kasan_meta_size =3D kasan_metadata_size(s, true);
> > +     if (kasan_meta_size > orig_size)
> > +             orig_size =3D kasan_meta_size;
>
> 'orig_size' is to save the orignal request size for kmalloc object,
> and its main purpose is to detect the memory wastage of kmalloc
> objects, see commit 6edf2576a6cc "mm/slub: enable debugging memory
> wasting of kmalloc"
>
> Setting "orig_size =3D s->object_size" was to skip the wastage check
> and the redzone sanity check for this 'wasted space'.

Yes, I get that.

The point of my change was to allow slub_debug detecting overwrites in
the [kasan_meta_size, object_size) range when KASAN stores its free
meta in the [0, kasan_meta_size) range. If orig_size is set to
object_size, writes to that area will not be detected. I also thought
that using kasan_meta_size instead of object_size for orig_size might
give the reader better understanding of the memory layout.

> So it's better not to set 'kasan_meta_size' to orig_size.

I don't have a strong preference here: slub_debug and KASAN are not
really meant to be used together anyway. So if you prefer, I can
revert this change and keep using object_size as before.

> And from the below code, IIUC, the orig_size is not used in fixing
> the boot problem found by Hyeonggon?

No, this is a just a partially-related clean up. It just seemed
natural to include it into the fix, as it also touches the code around
a kasan_metadata_size call.

Thanks!
