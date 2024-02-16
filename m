Return-Path: <linux-kernel+bounces-69249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B285863B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A951C22269
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC3137C3B;
	Fri, 16 Feb 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qorFVVK0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021491369AA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112194; cv=none; b=Y4E/N0trPcA+OsxrwmhwkOyOOfGvQkQswl4peISzwsrqjBGAyk9MlKTCvZ8wIglt8AlkkyccN+nJkjSxEtmEKMz75HOFjAlbWpZCAkrbz/H9NCVW9bVLZgK/XCjAC2FZtLlkAQtfO5wRYJdRjggQgquQTQv4SkcI2U1nusmRADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112194; c=relaxed/simple;
	bh=zoaMVN5WsEZ7tHCBpQ2AebI1jsm3Rure9cJ8nlN0tco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GsZl9w0BOoxheP1T5veS645P9dZPtcmGb/0PMdbXUBzg/WR0ycUdRM+t4c1YjRm115DxwQjLDidbIeSZ5vafTTYHFf+ogs4UcEsSi5EKL/zz6oFVuXBTnfadfpougqlF8aVxcv+oEap8YeWLT9uCFJG8NOjZ4X687akh6XCGrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qorFVVK0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd703b721dso1677514276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708112191; x=1708716991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfgjHKYjHP2121FLeMU5tIKbfb7QyfojO45shr+5tbw=;
        b=qorFVVK0Q8b6iSxaWdfmiILpC/j0QPYNpTkN4628VpHoYmzOTjwD0CAC7vZm5Ed35G
         zHE1fMxQ/WASZsLYRp59rNlS+or80KoOfmJGhhxHScdjF7H9h4Cr6i1ZKFtEbohsxRIg
         Fz/3hpEDJRCR3aYn22RrCx/aRP2xKQ8rB+ggu9JmjaQTvljHeuZM4M2sPsn7/6p4X+9R
         XJVVrdqZfDsH2OlZXRV0BA96ZsvUXjA72nAyuv0JZJzwNwEZHU5t/CcsnBCjkxuOyFvj
         89LQJhq6uPfRB7ya5HmPV1rqWyGV0BBrT5a4M+zfJaM+wNFqM52Z03QkRedJVbfyjJec
         VU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112191; x=1708716991;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfgjHKYjHP2121FLeMU5tIKbfb7QyfojO45shr+5tbw=;
        b=XoNwhwNkZIWwpvWjdgFEyk0JUgByBzdNvtbeBid8KkU7LIrhKwqWj9WGQRROQJkECy
         WPw4WJOY6KkiG2+gN8IfwquaH2AWqs7dISD1W2Puv0kVLuKgBEr+XwPovW9hkklurVSL
         rB5xhyYMPgC/m52s+RlgtBC8gFgVQq89i153y9KsOv/6wBnavJslRXmmvcILJzIq+DJs
         sR7zcaSETn2AAVlJx6fsr2lIw21FG48CjoqSYxSOQI4ZBZ7TI0FBJC3t0ZtjluLJeSr5
         rXQItxFRILWbZrEfe8zcqMvcklqI/Q5jNIWVqlbM3PPYWisGa+Q3hvLrYFXrkyw1G/Kr
         MttA==
X-Forwarded-Encrypted: i=1; AJvYcCU2j6b6plUlKE+j9oVhS4iEfjW8GTpFKOYLX+5T+jiZDgJYKHPumpcuvBApHMPD9BMz/rOwsBvomT+kumJXHalMRu/jdk9V6M2erkNX
X-Gm-Message-State: AOJu0YwaYwXacn8Uy4qpKJigP4D4HeS1uO65mDXOx7phF8R0vZea2Onp
	hvPY6Z+3CJe8wNbOslLcZIbxyd2o7v95L4OJasJ7oi9MC2zZ6RI3ug27bg/37vfr0/NmXA/5OhJ
	loE+UlMiJ6S8N45FFsA==
X-Google-Smtp-Source: AGHT+IGkoSHjnXot+loB1N5ZuNRt5N8VxUGJ6/UFaoxop8ccs97PBa1BIdb79SyTS7sUrIplfqaWWprqqLC4kVNf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1504:b0:dcc:8be2:7cb0 with
 SMTP id q4-20020a056902150400b00dcc8be27cb0mr351960ybu.0.1708112190960; Fri,
 16 Feb 2024 11:36:30 -0800 (PST)
Date: Fri, 16 Feb 2024 19:36:29 +0000
In-Reply-To: <CAGsJ_4x6z48N9Sq1V8Bn16eSdRAjBcy3=O_a2iizg=D-tPng=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216040815.114202-1-21cnbao@gmail.com> <20240216040815.114202-3-21cnbao@gmail.com>
 <Zc8dEn7eqFmC_Kcd@google.com> <CAGsJ_4x6z48N9Sq1V8Bn16eSdRAjBcy3=O_a2iizg=D-tPng=Q@mail.gmail.com>
Message-ID: <Zc-5IcVmJgJs_4nr@google.com>
Subject: Re: [PATCH v2 2/3] mm/zswap: remove the memcpy if acomp is not sleepable
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, zhouchengming@bytedance.com, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, linux-kernel@vger.kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 11:10:04PM +1300, Barry Song wrote:
> On Fri, Feb 16, 2024 at 9:30=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Fri, Feb 16, 2024 at 05:08:14PM +1300, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > Most compressors are actually CPU-based and won't sleep during
> > > compression and decompression. We should remove the redundant
> > > memcpy for them.
> > >
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  mm/zswap.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 350dd2fc8159..6319d2281020 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -168,6 +168,7 @@ struct crypto_acomp_ctx {
> > >       struct crypto_wait wait;
> > >       u8 *buffer;
> > >       struct mutex mutex;
> > > +     bool is_sleepable;
> > >  };
> > >
> > >  /*
> > > @@ -716,6 +717,7 @@ static int zswap_cpu_comp_prepare(unsigned int cp=
u, struct hlist_node *node)
> > >               goto acomp_fail;
> > >       }
> > >       acomp_ctx->acomp =3D acomp;
> > > +     acomp_ctx->is_sleepable =3D acomp_is_sleepable(acomp);
> >
> > Just one question here. In patch 1, sleepable seems to mean "not async"=
.
> > IIUC, even a synchronous algorithm may sleep (e.g. if there is a
> > cond_resched or waiting for a mutex). Does sleepable in acomp terms the
> > same as "atomic" in scheduling/preemption terms?
>=20
> I think the answer is yes though async and sleepable are slightly
> different semantically
> generally speaking. but for comp cases, they are equal.
>=20
> We have two backends for compression/ decompression - scomp and acomp. if=
 comp
> is using scomp backend, we can safely think they are not sleepable at
> least from the
> below three facts.
>=20
> 1. in zRAM, we are using scomp APIs only - crypto_comp_decompress()/
> crypto_comp_compress(),  which are definitely scomp, we have never consid=
ered
> sleeping problem in zram drivers:
> static int zram_read_from_zspool(struct zram *zram, struct page *page,
>                                  u32 index)
> {
>         struct zcomp_strm *zstrm;
>         unsigned long handle;
>         unsigned int size;
>         void *src, *dst;
>         u32 prio;
>         int ret;
>=20
>         handle =3D zram_get_handle(zram, index);
>         ...
>         src =3D zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>         if (size =3D=3D PAGE_SIZE) {
>                 dst =3D kmap_local_page(page);
>                 memcpy(dst, src, PAGE_SIZE);
>                 kunmap_local(dst);
>                 ret =3D 0;
>         } else {
>                 dst =3D kmap_local_page(page);
>                 ret =3D zcomp_decompress(zstrm, src, size, dst);
>                 kunmap_local(dst);
>                 zcomp_stream_put(zram->comps[prio]);
>         }
>         zs_unmap_object(zram->mem_pool, handle);
>         return ret;
> }
>=20
> 2. zswap used to only support scomp before we moved to use
> crypto_acomp_compress()
> and crypto_acomp_decompress() APIs whose backends can be either scomp
> or acomp, thus new hardware-based compression drivers can be used in zswa=
p.
>=20
> But before we moved to these new APIs in commit  1ec3b5fe6eec782 ("mm/zsw=
ap:
> move to use crypto_acomp API for hardware acceleration") , zswap had
> never considered
> sleeping problems just like zRAM.
>=20
> 3. There is no sleeping in drivers using scomp backend.
>=20
> $ git grep crypto_register_scomp
> crypto/842.c:   ret =3D crypto_register_scomp(&scomp);
> crypto/deflate.c:       ret =3D crypto_register_scomp(&scomp);
> crypto/lz4.c:   ret =3D crypto_register_scomp(&scomp);
> crypto/lz4hc.c: ret =3D crypto_register_scomp(&scomp);
> crypto/lzo-rle.c:       ret =3D crypto_register_scomp(&scomp);
> crypto/lzo.c:   ret =3D crypto_register_scomp(&scomp);
> crypto/zstd.c:  ret =3D crypto_register_scomp(&scomp);
> drivers/crypto/cavium/zip/zip_main.c:   ret =3D
> crypto_register_scomp(&zip_scomp_deflate);
> drivers/crypto/cavium/zip/zip_main.c:   ret =3D
> crypto_register_scomp(&zip_scomp_lzs);
>=20
> which are the most common cases.

Thanks for explaining. Ideally we should be able to catch any violations
with proper debug options as you mentioned. Please include more info the
commit message about sleepability, a summarized version of what you
described above.

