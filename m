Return-Path: <linux-kernel+bounces-95878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8D875467
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6700B1C2292E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F312FF6C;
	Thu,  7 Mar 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="HB2lzJd8"
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFB161;
	Thu,  7 Mar 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.31.204.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829866; cv=none; b=WxbFCWHjntcIFgCzvf5ZHsQWrotCU7jjMBCprn1NmQyWKIvKnjNjpeDFZeudZPPB0BZaeexnvxz8hObxFMqVrHtF6kVPcsHNu/0g1GyAsjv45nogBB/eNFzI7iSU7abDIFPEV65CrxqmoIRk/2XNlOARYD5N6LjF0NNWLFVbLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829866; c=relaxed/simple;
	bh=Eas23TLQr46xZHt7gYs24YdP69SZOXFeMT3pAmuT6DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1Tx6iP7aUWYysvGSP4EwvzS30hXG4zvAcCP6BdSQF4MFw8390qJwteuUVjLXIj+HWOmPe47ptTpayyNAFmDQi96WL/QnsI7x4pW3T6Y7MQITjeYdSSArsQzpdGVUd2YUZUro/upbrkT347aC2a0kgniuIIoUWEFzliECHE7NEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz; spf=pass smtp.mailfrom=nic.cz; dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b=HB2lzJd8; arc=none smtp.client-ip=217.31.204.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.cz
Received: from dellmb (unknown [IPv6:2001:1488:fffe:6:8747:7254:5571:3010])
	by mail.nic.cz (Postfix) with ESMTPSA id A47281C0343;
	Thu,  7 Mar 2024 17:44:15 +0100 (CET)
Authentication-Results: mail.nic.cz;
	auth=pass smtp.auth=marek.behun@nic.cz smtp.mailfrom=marek.behun@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
	t=1709829857; bh=Eas23TLQr46xZHt7gYs24YdP69SZOXFeMT3pAmuT6DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Reply-To:
	 Subject:To:Cc;
	b=HB2lzJd8YaauT0cp2xxF7qnSe160360ygc3/6mKcJ6jsvmOsiTLbnAxeyrs9YjbEP
	 OwAWP919IXltZucSQtWWo0tE8W7jlC/dnh4Lzj+z7/LdLyKZe45dImbmU5XdR9De3e
	 yqDV2Ltcib7negRha3QKDE+cvoHBAWz+YSLpUeiM=
Date: Thu, 7 Mar 2024 17:44:14 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Waiman Long <longman@redhat.com>
Cc: George Stark <gnstark@salutedevices.com>, andy.shevchenko@gmail.com,
 pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, hdegoede@redhat.com,
 mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, nikitos.tr@gmail.com,
 kabel@kernel.org, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Subject: Re: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
Message-ID: <20240307174414.4059d7ee@dellmb>
In-Reply-To: <3d95ab40-2df5-4988-87be-568a628a0561@redhat.com>
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
	<20240307024034.1548605-3-gnstark@salutedevices.com>
	<20240307095639.b6utkbzr36liuu3p@kandell>
	<3d95ab40-2df5-4988-87be-568a628a0561@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at mail
X-Virus-Status: Clean
X-Rspamd-Queue-Id: A47281C0343
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.10 / 20.00];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
	WHITELISTED_IP(0.00)[2001:1488:fffe:6:8747:7254:5571:3010];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com]
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Rspamd-Server: mail

On Thu, 7 Mar 2024 08:39:46 -0500
Waiman Long <longman@redhat.com> wrote:

> On 3/7/24 04:56, Marek Beh=C3=BAn wrote:
> > On Thu, Mar 07, 2024 at 05:40:26AM +0300, George Stark wrote: =20
> >> Using of devm API leads to a certain order of releasing resources.
> >> So all dependent resources which are not devm-wrapped should be deleted
> >> with respect to devm-release order. Mutex is one of such objects that
> >> often is bound to other resources and has no own devm wrapping.
> >> Since mutex_destroy() actually does nothing in non-debug builds
> >> frequently calling mutex_destroy() is just ignored which is safe for n=
ow
> >> but wrong formally and can lead to a problem if mutex_destroy() will be
> >> extended so introduce devm_mutex_init()
> >>
> >> Signed-off-by: George Stark <gnstark@salutedevices.com>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   Hello Christophe. Hope you don't mind I put you SoB tag because you =
helped alot
> >>   to make this patch happen.
> >>
> >>   include/linux/mutex.h        | 13 +++++++++++++
> >>   kernel/locking/mutex-debug.c | 22 ++++++++++++++++++++++
> >>   2 files changed, 35 insertions(+)
> >>
> >> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> >> index f7611c092db7..9bcf72cb941a 100644
> >> --- a/include/linux/mutex.h
> >> +++ b/include/linux/mutex.h
> >> @@ -22,6 +22,8 @@
> >>   #include <linux/cleanup.h>
> >>   #include <linux/mutex_types.h>
> >>
> >> +struct device;
> >> +
> >>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >>   # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
> >>   		, .dep_map =3D {					\
> >> @@ -115,10 +117,21 @@ do {							\
> >>
> >>   #ifdef CONFIG_DEBUG_MUTEXES
> >>
> >> +int devm_mutex_init(struct device *dev, struct mutex *lock);
> >>   void mutex_destroy(struct mutex *lock);
> >>
> >>   #else
> >>
> >> +static inline int devm_mutex_init(struct device *dev, struct mutex *l=
ock)
> >> +{
> >> +	/*
> >> +	 * since mutex_destroy is nop actually there's no need to register it
> >> +	 * in devm subsystem.
> >> +	 */
> >> +	mutex_init(lock);
> >> +	return 0;
> >> +}
> >> +
> >>   static inline void mutex_destroy(struct mutex *lock) {}
> >>
> >>   #endif
> >> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug=
c
> >> index bc8abb8549d2..c9efab1a8026 100644
> >> --- a/kernel/locking/mutex-debug.c
> >> +++ b/kernel/locking/mutex-debug.c
> >> @@ -19,6 +19,7 @@
> >>   #include <linux/kallsyms.h>
> >>   #include <linux/interrupt.h>
> >>   #include <linux/debug_locks.h>
> >> +#include <linux/device.h>
> >>
> >>   #include "mutex.h"
> >>
> >> @@ -104,3 +105,24 @@ void mutex_destroy(struct mutex *lock)
> >>   }
> >>
> >>   EXPORT_SYMBOL_GPL(mutex_destroy);
> >> +
> >> +static void devm_mutex_release(void *res)
> >> +{
> >> +	mutex_destroy(res);
> >> +}
> >> +
> >> +/**
> >> + * devm_mutex_init - Resource-managed mutex initialization
> >> + * @dev:	Device which lifetime mutex is bound to
> >> + * @lock:	Pointer to a mutex
> >> + *
> >> + * Initialize mutex which is automatically destroyed when the driver =
is detached.
> >> + *
> >> + * Returns: 0 on success or a negative error code on failure.
> >> + */
> >> +int devm_mutex_init(struct device *dev, struct mutex *lock)
> >> +{
> >> +	mutex_init(lock);
> >> +	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
> >> +}
> >> +EXPORT_SYMBOL_GPL(devm_mutex_init); =20
> > Hi George,
> >
> > look at
> > https://lore.kernel.org/lkml/7013bf9e-2663-4613-ae61-61872e81355b@redha=
t.com/
> > where Matthew and Hans explain that devm_mutex_init needs to be a macro
> > because of the static lockdep key.
> >
> > so this should be something like:
> >
> > static inline int __devm_mutex_init(struct device *dev, struct mutex *m=
utex,
> > 				    const char *name,
> > 				    struct lock_class_key *key)
> > {
> > 	__mutex_init(mutex, name, key);
> > 	return devm_add_action_or_reset(dev, devm_mutex_release, mutex);
> > }
> >
> > #define devm_mutex_init(dev, mutex)				\
> > do {								\
> > 	static struct lock_class_key __key;			\
> > 								\
> > 	__devm_mutex_init(dev, (mutex), #mutex, &__key);	\
> > } while (0);
> >
> >
> > Marek =20
>=20
> Making devm_mutex_init() a function will make all the devm_mutex share=20
> the same lockdep key. Making it a macro will make each caller of=20
> devm_mutex_init() have a distinct lockdep key. It all depends on whether=
=20
> all the devm_mutexes have the same lock usage pattern or not and whether=
=20
> it is possible for one devm_mutex to be nested inside another. So either=
=20
> way can be fine depending on the mutex usage pattern. My suggestion is=20
> to use a function, if possible, unless it will cause a false positive=20
> lockdep splat as there is a limit on the maximum # of lockdep keys that=20
> can be used.

devm_mutex_init() should behave like other similar function
initializing stuff with resource management. I.e. it should behave like
mutex_init(), but with resource management.

mutex_init() is a macro generating static lockdep key for each instance,
so devm_mutex_init() should also generate static lockdep key for each
instance.

Marek

