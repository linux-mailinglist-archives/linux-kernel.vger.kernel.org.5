Return-Path: <linux-kernel+bounces-37689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF383B3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EA1C22DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2261353F7;
	Wed, 24 Jan 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGZlKiRy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE951350F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131541; cv=none; b=oxrvXJqzX434EhZJwJXf41rnoX1iS5S8KoRlnXE+zH9r7FJOWa5uu45FLy5BKssn+a0mZAgaG2E9gtKREuxAk1/Yg7S3vFONMFIahn78/4zJi6/ZPLTU58Nph/i8sx1qlKRZ/CKMnQ1vogteHMMkiMsPHT847r4lx6JX31t8LxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131541; c=relaxed/simple;
	bh=HuUOuWantkAKX+ti0Jp2nZHKDM3edFfqbLcfxdOCet8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVRjy4jg2P6oGd+RPnmj26cT27xmCoD/cQ8UskEXceCnZOQ4be6J8WN5yYK2qM+/6OA/U3b0ycPcorc5Y2n1I/qV+z2OyBow4a0FYendSLrKxAAdGUVATOiQEQmWmlzfJIE+uQ/mPS0lcpjtjwQgIz3qSNBT+x+DQfI1noQWzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGZlKiRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706131538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9avYiMTv0hqg3Mmfl01DZD9y6IDaHIlmiTGpdT11gAU=;
	b=SGZlKiRyyruZ8owoFAismsLGmLqYt38hZVCKXD58fe5HAm7c1rVTkW2KgKIjL06qTUBiNq
	2Tgk1nQu1ydU1ElB87ND0RXGf+oBO6LGJOM4l0oejGoat/nY4SEZLmlWINAGgchR//S1w3
	Bh+OwvKQQE6QYELKDbtLVbmWm1EyJM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-9Dh7MRAbPg280EmbqsZO3w-1; Wed, 24 Jan 2024 16:25:34 -0500
X-MC-Unique: 9Dh7MRAbPg280EmbqsZO3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 051EB185A782;
	Wed, 24 Jan 2024 21:25:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5FB551121306;
	Wed, 24 Jan 2024 21:25:33 +0000 (UTC)
Date: Wed, 24 Jan 2024 16:25:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, bonzini@redhat.com,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add
 (4)
Message-ID: <20240124212531.GA609846@fedora>
References: <000000000000fd588e060de27ef4@google.com>
 <20240102080315-mutt-send-email-mst@kernel.org>
 <20240104204531.GB954424@fedora>
 <CAG_fn=XmxeUePHFth5asQvHvo3=QSL4tB4yS5_3UVHWYJ=VRnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+9Fevo6zOXwDxbTS"
Content-Disposition: inline
In-Reply-To: <CAG_fn=XmxeUePHFth5asQvHvo3=QSL4tB4yS5_3UVHWYJ=VRnw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


--+9Fevo6zOXwDxbTS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:47:32AM +0100, Alexander Potapenko wrote:
> On Thu, Jan 4, 2024 at 9:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> >
> > On Tue, Jan 02, 2024 at 08:03:46AM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Jan 01, 2024 at 05:38:24AM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.ker=
nel.org..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D173df3e=
9e80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De0c7078=
a6b901aa3
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e3=
841ed075a42
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1300b=
4a1e80000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D130b037=
9e80000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6da=
a4/disk-fbafc3e6.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/=
vmlinux-fbafc3e6.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/202ca200=
f4a4/bzImage-fbafc3e6.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > Hi Alexander,
> > Please take a look at this KMSAN failure. The uninitialized memory was
> > created for the purpose of writing a coredump. vring_map_one_sg() should
> > have direction=3DDMA_TO_DEVICE.
> >
> Hi Stefan,
>=20
> I took a closer look, and am pretty confident this is a false positive.
> I tried adding memset(..., 0xab, PAGE_SIZE << order) to alloc_pages()
> and never saw
> the 0xab pattern in the buffers for which KMSAN reported an error.
>=20
> This probably isn't an error in 88938359e2df ("virtio: kmsan:
> check/unpoison scatterlist in
> vring_map_one_sg()"), which by itself should be doing a sane thing:
> report an error if an
> uninitialized buffer is passed to it. It is more likely that we're
> missing some initialization that
> happens in coredump.c
>=20
> Does anyone have an idea where coredump.c is supposed to be
> initializing these pages?
> Maybe there are some inline assembly functions involved in copying the da=
ta?

Thanks for your time looking into this!

Stefan

--+9Fevo6zOXwDxbTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWxgEsACgkQnKSrs4Gr
c8g5nggAnQrG/GK26Vn5GTy1wTUizYD03FNIfC70/y/8Rd9SrJFdeWXRMzpZ2qiv
Z6Cb3iKUk0deWxwy6XfuL2aS98DOB1kb2YbaN9cGh4tvEYNZ+zCOL0aoY6o93G6k
aUwv8tX/DoeMi92qcZjF537N5P+JjACbyRHUHpp3d1t1wM+YIaxRk4bHdCkp+F64
Hb8Uo6VCzMjJxAb6Cpmx8KtOybo+CjDTISxKyVLPcQWYQP48Ase97qJzrqM7rkLw
2EbToh3I9fesLeK90qxJUE3oaxPIjN/YVq1+LEODn2xySDethoaF8TjRYNqwSgES
at7PN1XJQXF4GI1RuvU7AzQz4MC4MQ==
=gWOt
-----END PGP SIGNATURE-----

--+9Fevo6zOXwDxbTS--


