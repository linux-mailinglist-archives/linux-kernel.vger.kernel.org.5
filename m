Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1F8120D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjLMVmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0BAD5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702503763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdKw+cJKuYBtq2AfhtjjClQUyyHxxJix2Fa9xvak1zc=;
        b=iC04CCUDXj9Lb7m/l3CXoDw4ZICPIqd3iZ2bZeFN+2fGqroYq3dZpHAbskjWNwALz6zypI
        M3Dpaj9CZ3DR2cWH+ATUgO74g8oVLqhRujbaI7u5Uynnrsnjkqa2I/4eow/Yt5EGkj2hHI
        TwgVAHi4C0A8/HxSfCTNLNKiI4Dio68=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-kM9HWGimPFudV0upeK-Efw-1; Wed, 13 Dec 2023 16:42:42 -0500
X-MC-Unique: kM9HWGimPFudV0upeK-Efw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5e302b65cc7so7362157b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702503761; x=1703108561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdKw+cJKuYBtq2AfhtjjClQUyyHxxJix2Fa9xvak1zc=;
        b=BpSH4o2ellqNsDAYxKNaTwmlVayvxLUFOZragTZidOoG5D6ZV4sfpd8ayOUPD2yMgf
         n9upNIFijVlBLmE1uCyCZPOU9LE5AB3ThMhBeXx3fEHG9JFAt88YJTuMuYjCtVmHOEeE
         D2CqWUEJToYk7h59I0Zcuurdg4wpuiqPVpsk91yIIcRbPN6RHoRfj8tDSJ73BbXqJlyl
         QjLUB0Jrhq6H6gEGYUtYSQ+HS5qehQjarvr2ONPB9bwtN+y7sRw9z2CkBXBzSv9ZuKKb
         h+nL9YVS3Qf4Of1YZl5Q0Uam4YFKHJNc20q5ORCl/BEsKlkjBPdMtPs2+neQgun8IXDW
         sCZw==
X-Gm-Message-State: AOJu0Yz46RtTwO1ZcqkNKZZ9ubfbsdXOcEc2KZ4MW/wGw4RTJwvWvXhT
        SzO9fefq74Ti+9XdEoq0VlUnhs7XlZHnlRXekLazSOqweFLtbpbppYkArkVtcQ/Mmf116rPS5Cj
        ZYr9k0Z9auZOFkyBwMOzh84+gx4GeN3781Vo9U/uE
X-Received: by 2002:a25:1342:0:b0:db7:dacf:4d5b with SMTP id 63-20020a251342000000b00db7dacf4d5bmr3860237ybt.87.1702503761254;
        Wed, 13 Dec 2023 13:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMEg4Tsu94LACqll5uZbZm49OGUoCP7PdYVrYGA6B+PQrDt/ww0kz01Mhbqj0nE+zvkBqP3ZMIkKunRmRhT3g=
X-Received: by 2002:a25:1342:0:b0:db7:dacf:4d5b with SMTP id
 63-20020a251342000000b00db7dacf4d5bmr3860229ybt.87.1702503760942; Wed, 13 Dec
 2023 13:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20231212232659.18839-1-npache@redhat.com> <CA+fCnZeE1g7F6UDruw-3v5eTO9u_jcROG4Hbndz8Bnr62Opnyg@mail.gmail.com>
In-Reply-To: <CA+fCnZeE1g7F6UDruw-3v5eTO9u_jcROG4Hbndz8Bnr62Opnyg@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
Date:   Wed, 13 Dec 2023 14:42:15 -0700
Message-ID: <CAA1CXcBdNd0rSW+oAm24hpEj5SM48XGc2AWagRcSDNv96axQ9w@mail.gmail.com>
Subject: Re: [PATCH] kunit: kasan_test: disable fortify string checker on kmalloc_oob_memset
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org,
        vincenzo.frascino@arm.com, dvyukov@google.com, glider@google.com,
        ryabinin.a.a@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 7:34=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Wed, Dec 13, 2023 at 12:27=E2=80=AFAM Nico Pache <npache@redhat.com> w=
rote:
> >
> > similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
> > FORTIFY_SOURCE") the kernel is panicing in kmalloc_oob_memset_*.
> >
> > This is due to the `ptr` not being hidden from the optimizer which woul=
d
> > disable the runtime fortify string checker.
> >
> > kernel BUG at lib/string_helpers.c:1048!
> > Call Trace:
> > [<00000000272502e2>] fortify_panic+0x2a/0x30
> > ([<00000000272502de>] fortify_panic+0x26/0x30)
> > [<001bffff817045c4>] kmalloc_oob_memset_2+0x22c/0x230 [kasan_test]
> >
> > Hide the `ptr` variable from the optimizer to fix the kernel panic.
> > Also define a size2 variable and hide that as well. This cleans up
> > the code and follows the same convention as other tests.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/kasan/kasan_test.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> > index 8281eb42464b..5aeba810ba70 100644
> > --- a/mm/kasan/kasan_test.c
> > +++ b/mm/kasan/kasan_test.c
> > @@ -493,14 +493,17 @@ static void kmalloc_oob_memset_2(struct kunit *te=
st)
> >  {
> >         char *ptr;
> >         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> > +       size_t size2 =3D 2;
>
> Let's name this variable access_size or memset_size. Here and in the
> other changed tests.

Hi Andrey,

I agree that is a better variable name, but I chose size2 because
other kasan tests follow the same pattern.

Please let me know if you still want me to update it given that info
and I'll send a V2.

Cheers,
-- Nico

>
> >         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> >
> >         ptr =3D kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >         OPTIMIZER_HIDE_VAR(size);
> > -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, 2));
> > +       OPTIMIZER_HIDE_VAR(size2);
> > +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, size2))=
;
> >         kfree(ptr);
> >  }
> >
> > @@ -508,14 +511,17 @@ static void kmalloc_oob_memset_4(struct kunit *te=
st)
> >  {
> >         char *ptr;
> >         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> > +       size_t size2 =3D 4;
> >
> >         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> >
> >         ptr =3D kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >         OPTIMIZER_HIDE_VAR(size);
> > -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, 4));
> > +       OPTIMIZER_HIDE_VAR(size2);
> > +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, size2))=
;
> >         kfree(ptr);
> >  }
> >
> > @@ -523,14 +529,17 @@ static void kmalloc_oob_memset_8(struct kunit *te=
st)
> >  {
> >         char *ptr;
> >         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> > +       size_t size2 =3D 8;
> >
> >         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> >
> >         ptr =3D kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >         OPTIMIZER_HIDE_VAR(size);
> > -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, 8));
> > +       OPTIMIZER_HIDE_VAR(size2);
> > +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, size2))=
;
> >         kfree(ptr);
> >  }
> >
> > @@ -538,14 +547,17 @@ static void kmalloc_oob_memset_16(struct kunit *t=
est)
> >  {
> >         char *ptr;
> >         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> > +       size_t size2 =3D 16;
> >
> >         KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
> >
> >         ptr =3D kmalloc(size, GFP_KERNEL);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > +       OPTIMIZER_HIDE_VAR(ptr);
> >         OPTIMIZER_HIDE_VAR(size);
> > -       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, 16));
> > +       OPTIMIZER_HIDE_VAR(size2);
> > +       KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, size2)=
);
> >         kfree(ptr);
> >  }
> >
> > --
> > 2.43.0
> >
>
> With the fix mentioned above addressed:
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
>

