Return-Path: <linux-kernel+bounces-24459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE082BCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DC5285FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DE455C08;
	Fri, 12 Jan 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCZSUw9B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8B55786
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705051214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFCnt6ErpVFV4GTEGJv+0uoaTEerLHKtckzk9mX53Mk=;
	b=cCZSUw9BZHK25RQFsAO0upQbMNwPtbKcJsVA//uKHYDKyfJ43AfGwsD6Tf93VNHX0EO1i5
	9kqupceF6UA4MzNvPaj684DgJn1WVxG18LKw+VtvYxz0Oa8MkEQenIY+z/HrQSQqYIDpak
	mnkIV+IUxpQ4bLlC77uuA0IiSdXecPM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-Naw5CbTwNYuQoPwdRbiGDQ-1; Fri,
 12 Jan 2024 04:20:05 -0500
X-MC-Unique: Naw5CbTwNYuQoPwdRbiGDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD27B38425B3;
	Fri, 12 Jan 2024 09:20:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 41CD93C25;
	Fri, 12 Jan 2024 09:20:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <86r0inmpbm.fsf@aarsen.me>
References: <86r0inmpbm.fsf@aarsen.me> <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
To: Arsen =?us-ascii?Q?=3D=3Futf-8=3FQ=3FArsenovi=3DC4=3D87=3F=3D?= <arsen@aarsen.me>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jan 2024 09:20:03 +0000
Message-ID: <2154236.1705051203@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Arsen Arsenovi=C4=87 <arsen@aarsen.me> wrote:

> >  (2) Constructors and destructors.  Nests of implicit code makes the co=
de less
> >      obvious, and the replacement of static initialisation with constru=
ctor
> >      calls would make the code size larger.
>=20
> This also disallows the primary benefit of C++ (RAII), though.  A lot of
> static initialization can be achieved using constexpr and consteval,
> too.

Okay, let me downgrade that to "I wouldn't allow it at first".  The primary
need for destructors, I think, is exception handling.  And don't get me wro=
ng,
I like the idea of exception handling - so many bugs come because we mische=
ck
or forget to check the error.

> It is incredibly useful to be able to express resource ownership in
> terms of automatic storage duration.

Oh, indeed, yes - but you also have to be careful:

 (1) You don't always want to wait till the end of the scope before releasi=
ng
     resources.

 (2) Expressing ownership of something like a lock so that it is automatica=
lly
     undone may require extra memory is currently unnecessary:

	struct foo {
		struct rwsem sem;
	};


	myfunc(struct foo *foo)
	{
		...
		struct foo_shared_lock mylock(foo->sem);
		...
	}

     This looks like a nice way to automatically take and hold a lock, but I
     don't think it can be done without storing the address of the semaphore
     in mylock - something that isn't strictly necessary since we can find =
sem
     from foo.

 (3) We could implement a magic pointer class that automatically does
     reference wangling (kref done right) - but we would have to be very
     careful using it because we want to do the minimum number of atomic ops
     on its refcount that we can manage, firstly because atomic ops are slow
     and secondly because the atomic counter must not overflow.

> >  (5) Function overloading (except in special inline cases).
>=20
> Generic code, another significant benefit of C++, requires function
> overloading, though.

I know.  But I was thinking that we might want to disable name mangling if =
we
can so as not to bloat the size of the kernel image.  That said, I do like =
the
idea of being able to have related functions of the same name with different
arguments rather than having to name each one differently.

> >  (7) 'class', 'private', 'namespace'.
>=20
> 'class' does nothing that struct doesn't do, private and namespace serve
> simply for encapsulation, so I don't see why banning these is useful.

Namespaces would lead to image bloat as they make the symbols bigger.
Remember, the symbol list uses up unswappable memory.

We use class and private a lot as symbols already, so to get my stuff to
compile I had to #define them.  Granted there's nothing intrinsically
different about classes and we could rename every instance of the symbol in
the kernel first.

When it comes to 'private', actually, I might withdraw my objection to it: =
it
would help delineate internal fields - but we would then have to change
out-of-line functions that use it to be members of the class - again
potentially increasing the size of the symbol table.

> >  (8) 'virtual'.  Don't want virtual base classes, though virtual functi=
on
> >      tables might make operations tables more efficient.
>=20
> Virtual base classes are seldom useful, but I see no reason to
> blanket-ban them (and I suspect you'll never notice that they're not
> banned).

You can end up increasing the size of your structure as you may need multip=
le
virtual method pointer tables - and we have to be very careful about that as
some structures (dentry, inode and page for example) we have a *lot* of
instances of in a running kernel.

> >  (2) Direct assignment of pointers to/from void* isn't allowed by C++, =
though
> >      g++ grudgingly permits it with -fpermissive.  I would imagine that=
 a
> >      compiler option could easily be added to hide the error entirely.
>=20
> This should never be useful.

It's not a matter of whether it should be useful - we do this an awful lot =
and
every case of assigning to/from a void pointer would require some sort of
cast.

David


