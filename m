Return-Path: <linux-kernel+bounces-95301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9A874BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7BF2839ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E1D84FD7;
	Thu,  7 Mar 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="U0oRVyb/"
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F184FCD;
	Thu,  7 Mar 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.31.204.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806012; cv=none; b=frdj3+6OP4Lrs4drnbU/enbnoOXvcqRnvMN2ZNwZpL/m61pqqMSCnW4iBwlPfm4i+C6BKZC+fEqX4SHckzBMfx8UbLyS5Z1hK5gdXC/x9LcwghWFlOFZ2rXdFc+5pztIA7Utvhn0eE0PbJ1BmHVXhNPrquk99uLfHTQy9LXvg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806012; c=relaxed/simple;
	bh=76Jo3UVwHUPVJ1Mxh3dPGM0nxOmpEeJydflFioZTAPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6XtNifx1zOqSpGtzOpY2x7msCV/0e6XlXGxoi59zmDy6pgQ2Cs9ATXePtUUHn465yAIe+iTK4vnx3/NDdjcjPhPQugX/mjm4ZH2hjw1WMvVQc2CN6sM8phKdtaiu5nHmLHEQdSlvzME5kvuhl9xjQz8hYOm6AvMD+U4jgjI87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz; spf=pass smtp.mailfrom=nic.cz; dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b=U0oRVyb/; arc=none smtp.client-ip=217.31.204.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.cz
Received: from kandell (unknown [172.20.6.140])
	by mail.nic.cz (Postfix) with ESMTPS id A3B251C035F;
	Thu,  7 Mar 2024 10:56:58 +0100 (CET)
Authentication-Results: mail.nic.cz;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
	t=1709805421; bh=76Jo3UVwHUPVJ1Mxh3dPGM0nxOmpEeJydflFioZTAPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Reply-To:
	 Subject:To:Cc;
	b=U0oRVyb/byvyZefng+g9v35ujBi7vq6aYkmzvkKCrDxKkrm4GdejErIA4KhO0xVnT
	 WUqRgmcFvpZBesK2q11bJeZP+NENK/F4uNa1T0zLPva3uD4Ifw484KchmjTu7f5Ttu
	 hIwK7zAsQ5g2CzFLPtjyTUvjxJV5Q6v7IBTxzfwg=
Date: Thu, 7 Mar 2024 10:56:58 +0100
From: Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: George Stark <gnstark@salutedevices.com>
Cc: andy.shevchenko@gmail.com, pavel@ucw.cz, lee@kernel.org,
	vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, kabel@kernel.org, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
Message-ID: <20240307095639.b6utkbzr36liuu3p@kandell>
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
 <20240307024034.1548605-3-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307024034.1548605-3-gnstark@salutedevices.com>
X-Virus-Scanned: clamav-milter 0.103.10 at mail
X-Virus-Status: Clean
X-Rspamd-Queue-Id: A3B251C035F
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WHITELISTED_IP
X-Spamd-Result: default: False [-0.10 / 20.00];
	MIME_GOOD(-0.10)[text/plain];
	WHITELISTED_IP(0.00)[172.20.6.140];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com]
X-Rspamd-Action: no action
X-Spamd-Bar: /
X-Rspamd-Server: mail

On Thu, Mar 07, 2024 at 05:40:26AM +0300, George Stark wrote:
> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init()
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  Hello Christophe. Hope you don't mind I put you SoB tag because you helped alot
>  to make this patch happen.
> 
>  include/linux/mutex.h        | 13 +++++++++++++
>  kernel/locking/mutex-debug.c | 22 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index f7611c092db7..9bcf72cb941a 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -22,6 +22,8 @@
>  #include <linux/cleanup.h>
>  #include <linux/mutex_types.h>
> 
> +struct device;
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
>  		, .dep_map = {					\
> @@ -115,10 +117,21 @@ do {							\
> 
>  #ifdef CONFIG_DEBUG_MUTEXES
> 
> +int devm_mutex_init(struct device *dev, struct mutex *lock);
>  void mutex_destroy(struct mutex *lock);
> 
>  #else
> 
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	/*
> +	 * since mutex_destroy is nop actually there's no need to register it
> +	 * in devm subsystem.
> +	 */
> +	mutex_init(lock);
> +	return 0;
> +}
> +
>  static inline void mutex_destroy(struct mutex *lock) {}
> 
>  #endif
> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index bc8abb8549d2..c9efab1a8026 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -19,6 +19,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/interrupt.h>
>  #include <linux/debug_locks.h>
> +#include <linux/device.h>
> 
>  #include "mutex.h"
> 
> @@ -104,3 +105,24 @@ void mutex_destroy(struct mutex *lock)
>  }
> 
>  EXPORT_SYMBOL_GPL(mutex_destroy);
> +
> +static void devm_mutex_release(void *res)
> +{
> +	mutex_destroy(res);
> +}
> +
> +/**
> + * devm_mutex_init - Resource-managed mutex initialization
> + * @dev:	Device which lifetime mutex is bound to
> + * @lock:	Pointer to a mutex
> + *
> + * Initialize mutex which is automatically destroyed when the driver is detached.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
> +}
> +EXPORT_SYMBOL_GPL(devm_mutex_init);

Hi George,

look at
https://lore.kernel.org/lkml/7013bf9e-2663-4613-ae61-61872e81355b@redhat.com/
where Matthew and Hans explain that devm_mutex_init needs to be a macro
because of the static lockdep key. 

so this should be something like:

static inline int __devm_mutex_init(struct device *dev, struct mutex *mutex,
				    const char *name,
				    struct lock_class_key *key)
{
	__mutex_init(mutex, name, key);
	return devm_add_action_or_reset(dev, devm_mutex_release, mutex);
}

#define devm_mutex_init(dev, mutex)				\
do {								\
	static struct lock_class_key __key;			\
								\
	__devm_mutex_init(dev, (mutex), #mutex, &__key);	\
} while (0);


Marek

