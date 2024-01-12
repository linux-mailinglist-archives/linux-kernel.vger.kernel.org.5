Return-Path: <linux-kernel+bounces-25084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F30D82C779
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE231F23AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235018E00;
	Fri, 12 Jan 2024 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aarsen.me header.i=@aarsen.me header.b="dOIx4QCu"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370C18E07
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aarsen.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aarsen.me
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TBcJS4RwMz9sb5;
	Fri, 12 Jan 2024 23:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aarsen.me; s=MBO0001;
	t=1705099992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFzu3NgjfMFZmq8jvH7R3F6/VXMH/hfZeTvzde0WbXo=;
	b=dOIx4QCu2tEhzhYdIfvD1PHclO7wOxYjGbVf5aDxFaJ/ey2kPIUzz09Ipg7fA0980KTJsl
	3cMcj2hJQvS8+zfp76vwxlOYij1hYZo367v34fDPwi9ZP999UudwYzziz35QVQW4VViZVc
	7or7Gv/89BDeqxdjn1MLMPqldtzAOPlyD4lxxDfOSrjMdpz5wEruFXra+aKxkLD2tZaq0o
	aXcbVGyOlwnzwicWPlyAHC7fDpEKzXf8KBiCq8owLvBnpTqE+onX6xzLFnH9A/XnhiwkOX
	Iwf4v3E8ewch8orDJIj0Q5SxT/PytGAqhoC9ud0ZEKUQFrJIL1notgfbn5xarw==
References: <86r0inmpbm.fsf@aarsen.me>
 <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <2154236.1705051203@warthog.procyon.org.uk>
From: Arsen =?utf-8?Q?Arsenovi=C4=87?= <arsen@aarsen.me>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Date: Fri, 12 Jan 2024 22:35:34 +0100
In-reply-to: <2154236.1705051203@warthog.procyon.org.uk>
Message-ID: <8634v2jh9s.fsf@aarsen.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4TBcJS4RwMz9sb5

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


David Howells <dhowells@redhat.com> writes:

> Arsen Arsenovi=C4=87 <arsen@aarsen.me> wrote:
>
>> >  (2) Constructors and destructors.  Nests of implicit code makes the c=
ode less
>> >      obvious, and the replacement of static initialisation with constr=
uctor
>> >      calls would make the code size larger.
>>
>> This also disallows the primary benefit of C++ (RAII), though.  A lot of
>> static initialization can be achieved using constexpr and consteval,
>> too.
>
> Okay, let me downgrade that to "I wouldn't allow it at first".  The prima=
ry
> need for destructors, I think, is exception handling.

I'm not sure I agree, the amount of 'goto err' constructs in the kernel
seems to indicate otherwise to me.  This feels like the exact same code,
except more error prone.

> And don't get me wrong, I like the idea of exception handling - so
> many bugs come because we mischeck or forget to check the error.

C++ also provides possible alternative avenues for solving such
problems, such as, for instance, an expected type with monadic
operations: https://en.cppreference.com/w/cpp/utility/expected

IIRC, using std::expected in managarm (where we previously used the IMO
far less nice Frigg expected type) is what initially prompted me to
start enabling the use of a lot of libstdc++ in kernel contexts, and
indeed, it is enabled there:
https://gcc.gnu.org/cgit/gcc/tree/libstdc++-v3/include/Makefile.am#n25

>> It is incredibly useful to be able to express resource ownership in
>> terms of automatic storage duration.
>
> Oh, indeed, yes - but you also have to be careful:
>
>  (1) You don't always want to wait till the end of the scope before relea=
sing
>      resources.

One could move a resource out, or call a function akin to the 'reset()'
method of std::unique_ptr.

>  (2) Expressing ownership of something like a lock so that it is automati=
cally
>      undone may require extra memory is currently unnecessary:
>
> 	struct foo {
> 		struct rwsem sem;
> 	};
>
>
> 	myfunc(struct foo *foo)
> 	{
> 		...
> 		struct foo_shared_lock mylock(foo->sem);
> 		...
> 	}
>
>      This looks like a nice way to automatically take and hold a lock, bu=
t I
>      don't think it can be done without storing the address of the semaph=
ore
>      in mylock - something that isn't strictly necessary since we can fin=
d sem
>      from foo.

The compiler can often get rid of it.  Here's an example:
https://godbolt.org/z/1W7bnYY7a

Simple enough wrapper classes like these combined with a modern
compilers IPA and inlining can really do magic :-)

>  (3) We could implement a magic pointer class that automatically does
>      reference wangling (kref done right) - but we would have to be very
>      careful using it because we want to do the minimum number of atomic =
ops
>      on its refcount that we can manage, firstly because atomic ops are s=
low
>      and secondly because the atomic counter must not overflow.

With move semantics, this could be quite effective and general.  The
shared_ptr from the standard library, for instance, won't bump
reference counts if moved.  And temporaries are automatically moved.

You could make the class move-only so that *all* reference incrementing
requires a method call (and hence, is clear and obvious), while still
permitting auto-decrementing and preventing reference leakage.

>> >  (5) Function overloading (except in special inline cases).
>>
>> Generic code, another significant benefit of C++, requires function
>> overloading, though.
>
> I know.  But I was thinking that we might want to disable name mangling i=
f we
> can so as not to bloat the size of the kernel image.  That said, I do lik=
e the
> idea of being able to have related functions of the same name with differ=
ent
> arguments rather than having to name each one differently.

Hmm, I can understand the symbol table size being an issue.

>> >  (7) 'class', 'private', 'namespace'.
>>
>> 'class' does nothing that struct doesn't do, private and namespace serve
>> simply for encapsulation, so I don't see why banning these is useful.
>
> Namespaces would lead to image bloat as they make the symbols bigger.
> Remember, the symbol list uses up unswappable memory.

Ah, I was not aware of this restriction of the kernel (my understanding
was that the symbol table is outside of the kernel image).  That poses a
problem, yes.  I wonder if a big part of the symbol table (or even the
entirety of it) could be dropped from the kernel.  I must say, I do not
know why the kernel has it, so I cannot speak on this issue.

> We use class and private a lot as symbols already, so to get my stuff to
> compile I had to #define them.  Granted there's nothing intrinsically
> different about classes and we could rename every instance of the symbol =
in
> the kernel first.

I see.  That is quite understandable then, especially if temporary.

> When it comes to 'private', actually, I might withdraw my objection to it=
: it
> would help delineate internal fields - but we would then have to change
> out-of-line functions that use it to be members of the class - again
> potentially increasing the size of the symbol table.

This is what I like about it too.

>> >  (8) 'virtual'.  Don't want virtual base classes, though virtual funct=
ion
>> >      tables might make operations tables more efficient.
>>
>> Virtual base classes are seldom useful, but I see no reason to
>> blanket-ban them (and I suspect you'll never notice that they're not
>> banned).
>
> You can end up increasing the size of your structure as you may need mult=
iple
> virtual method pointer tables - and we have to be very careful about that=
 as
> some structures (dentry, inode and page for example) we have a *lot* of
> instances of in a running kernel.

I retract what I said about virtual classes - I had, indeed, forgotten
about that issue (but, again, I doubt anyone will miss them ;-) ).

>> >  (2) Direct assignment of pointers to/from void* isn't allowed by C++,=
 though
>> >      g++ grudgingly permits it with -fpermissive.  I would imagine tha=
t a
>> >      compiler option could easily be added to hide the error entirely.
>>
>> This should never be useful.
>
> It's not a matter of whether it should be useful - we do this an awful lo=
t and
> every case of assigning to/from a void pointer would require some sort of
> cast.

I see.  That could pose significant trouble.

Ideally, nearly all uses of void* could be lost sooner or later, as C++
has a more flexible (despite being stricter) type system.

Have a lovely day!

> David


=2D-
Arsen Arsenovi=C4=87

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOYEARYKAI4WIQT+4rPRE/wAoxYtYGFSwpQwHqLEkwUCZaHCz18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0RkVF
MkIzRDExM0ZDMDBBMzE2MkQ2MDYxNTJDMjk0MzAxRUEyQzQ5MxAcYXJzZW5AYWFy
c2VuLm1lAAoJEFLClDAeosSTfN4A/2x4kuET1fRRSAiEKkAFptXwLOvtJS+Kfla+
b5JZNMqXAQC3y8t48Cfop96k2NC0NXiJyOLnf6eUpbX3eMpTSb3OBQ==
=hUdU
-----END PGP SIGNATURE-----
--=-=-=--

