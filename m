Return-Path: <linux-kernel+bounces-122023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED95288F0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CB91F29226
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85D1534F1;
	Wed, 27 Mar 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l8Rn6UNA"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E120DF1;
	Wed, 27 Mar 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574919; cv=none; b=uPgoJOdjlvz0Pai+ehrBZMAazC8TuKFQPnFrD2D0NydSO+70eJoKk+LEm3wZn1r2Eyx1V7vS57mBpFkb6xPmt/kowFpUMdkHpac2XXNBQ9VBxJh86d7/mwaob0W66BO4E5nWZvle9q+W1i5pZeMqygr+aAnUzAiEDVt7QQAseRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574919; c=relaxed/simple;
	bh=W32MUgIqaGh13w+iDuYAwjGFaRPCymDNIE0Az86m6sU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d45kUEjofn+9NBw/z9mOPAfTkc0saTIrgI0yTiwP67w9qmiSuAe3OjNRmmIDmI3KLG2mzwiLdRdhxtZDmGYRYksKAwApW1r5Ayid9piE7NroDYf24mnNif61KQb5sYJX301pGfGuNpSBFEa0Fe7ZGccdPUzi9ekZYJvBGuNGUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l8Rn6UNA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MFYQmoUrcQloaBNBs8abCrEkISK3AqZ58HKKo9Dwa7w=;
	t=1711574918; x=1712784518; b=l8Rn6UNA5e8BK6puaNhplIxUIDMAN+m80aWDEUrQL+LWicA
	jcRwYpJtQxr5bbePTr1H6roxIf1F9PA+1BaA9QV+3FCvoY6IXAxyjj6Cx5WE2LTRV3xfHixstQtog
	oS9/l5p24EodlgjMp3HmdrgOfA9tmDmXPZ5d63fxtvThiPAJ+Fog6vsGAMjR64kwNr+UOT5qlnfZj
	PaZ6qANNwKUx0e6beBMaIvu1gQzxZjIJy8DadM2gPYx+pTvVqmp32VQQ1HO5BEfPRpMgTo6NxB2ZL
	2eLID6AD/gI0c7fwz+RUP2i8aGecKLx7G3c27yhzZhF0K77N+dnLxj4aF2eU1I4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpap1-0000000HOyv-0JxP;
	Wed, 27 Mar 2024 22:28:35 +0100
Message-ID: <0e7af4cb0dc19be7cc0267256284a70ceb250b38.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] using guard/__free in networking
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Peter Zijlstra
	 <peterz@infradead.org>, linux-kernel@vger.kernel.org
Date: Wed, 27 Mar 2024 22:28:33 +0100
In-Reply-To: <87h6grbevf.fsf@cloudflare.com>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	 <20240325190957.02d74258@kernel.org>
	 <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
	 <20240326073722.637e8504@kernel.org>
	 <0dc633a36a658b96f9ec98165e7db61a176c79e0.camel@sipsolutions.net>
	 <87h6grbevf.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-03-27 at 21:25 +0100, Jakub Sitnicki wrote:
> On Tue, Mar 26, 2024 at 04:33 PM +01, Johannes Berg wrote:
> > > Is it also present in Rust or some such?
> >=20
> > I have no idea. I _think_ Rust actually ties the data and the locks
> > together more?
>=20
> That is right. Nicely explained here:
>=20
> https://marabos.nl/atomics/basics.html#rusts-mutex

Right.

Thinking about that, we _could_ even add support for drop_guard()?

With the below patch to cleanup.h, you can write

void my_something(my_t *my)
{
..
	named_guard(lock, mutex)(&my->mutex);
..
	if (foo)
		return -EINVAL; // automatically unlocks
..
	// no need for lock any more
	drop_guard(lock);
..
	// do other things now unlocked
}


Is that too ugly? Maybe it's less Java-like and more Rust-like and
better for Jakub ;-)

In some sense that's nicer than scoped_guard() since it doesn't require
a new scope / indentation, but maybe Peter already thought about it and
rejected it :-)


Patch follows, though maybe that should be rolled into the 'base' CLASS
definition instead of defining another "_drop" one for named_guard()?

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..31298106c28b 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -106,7 +106,27 @@ typedef _type class_##_name##_t;					\
 static inline void class_##_name##_destructor(_type *p)			\
 { _type _T =3D *p; _exit; }						\
 static inline _type class_##_name##_constructor(_init_args)		\
-{ _type t =3D _init; return t; }
+{ _type t =3D _init; return t; }						\
+typedef struct class_##_name##_drop##_t {				\
+	class_##_name##_t obj;						\
+	void (*destructor)(struct class_##_name##_drop##_t *);		\
+} class_##_name##_drop##_t;						\
+static inline void							\
+class_##_name##_drop##_destructor(class_##_name##_drop##_t *p)		\
+{									\
+	if (p->obj)							\
+		class_##_name##_destructor(&p->obj);			\
+	p->obj =3D NULL;							\
+}									\
+static inline class_##_name##_drop##_t					\
+class_##_name##_drop##_constructor(_init_args)				\
+{									\
+	class_##_name##_drop##_t t =3D {					\
+		.obj =3D _init,						\
+		.destructor =3D class_##_name##_drop##_destructor,	\
+	};								\
+	return t;							\
+}
=20
 #define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
 typedef class_##_name##_t class_##_name##ext##_t;			\
@@ -163,6 +183,11 @@ static inline class_##_name##_t class_##_name##ext##_c=
onstructor(_init_args) \
 #define guard(_name) \
 	CLASS(_name, __UNIQUE_ID(guard))
=20
+#define named_guard(_name, _class) \
+	CLASS(_class##_drop, _name)
+
+#define drop_guard(_name) do { _name.destructor(&_name); } while (0)
+
 #define __guard_ptr(_name) class_##_name##_lock_ptr
=20
 #define scoped_guard(_name, args...)					\


