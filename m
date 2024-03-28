Return-Path: <linux-kernel+bounces-123116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF3890254
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59FEB2386A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7312F5BB;
	Thu, 28 Mar 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0RoR5jKm"
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757525763
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637599; cv=none; b=RBwli8nTVY3CCEsDimlEyezQ+wQlezPXLYEVFb/4OAmuecWxwXb4r3zci93s0ooU9mvWw2vfweMSWNq0ZVa5spHp5fMoGZM23vKlV4qgpguYBKldC3BbNhtHvSt2OOgzNfIcJkBKzFToeyFdGy5B417OuLC3KdGLm8XqLveWktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637599; c=relaxed/simple;
	bh=m6ExSO75re8+h+0kqgmc3taw/nhfvJpWp0RzVChKUD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSIyJLkQbv21Z0McJAGR0MOKt7wMoE+cgkFp6mm9IG66YQwRdaZBxNPepTi1cIyqVoq91jthRzhf3lvU3mQ+Xc+BxrHl/bg9HdhFUGo8zV5gbnTCpPkBtww4OmVi2TeC47V59yOgxVTSRSmPwH8g9qQKUby0xLx21dujBjtD1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0RoR5jKm; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V55tK0jHzzh88;
	Thu, 28 Mar 2024 15:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711637112;
	bh=m6ExSO75re8+h+0kqgmc3taw/nhfvJpWp0RzVChKUD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0RoR5jKmSZESMEyzyyfqQCBdDMidK2YEM0S6giPp/MumsJXKnukq6p0yh+n8lBUDh
	 +Ly2A2jkpU9UJdKMMJ6cjtSIPEwpe4ycoBks2M1+RnFT/H4YsiMgWes0h2Ema/J11K
	 C0XwLrdz1/Cpkjimu+R6Lc8YtVwHzWf4nOEcEtsg=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V55tJ47G7zsZc;
	Thu, 28 Mar 2024 15:45:12 +0100 (CET)
Date: Thu, 28 Mar 2024 15:45:12 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, alison.schofield@intel.com, 
	fabio.maria.de.francesco@linux.intel.com, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, outreachy@lists.linux.dev, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <20240328.aiPh0phaJ6ai@digikod.net>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <CAHC9VhRYDNoqkbkgdUSg-kYSHVbheD5NtezmVxyRakZ0-DzuSg@mail.gmail.com>
 <ZgUh7cIQIsOgvWpw@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgUh7cIQIsOgvWpw@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
X-Infomaniak-Routing: alpha

The subject should start with "landlock: Use" instead of "LANDLOCK: use"

On Thu, Mar 28, 2024 at 01:23:17PM +0530, Ayush Tiwari wrote:
> Hello Paul
> Thanks a lot for the feedback. Apologies for the mistakes. Could you
> help me in some places so that I can correct the errors, like:
> On Wed, Mar 27, 2024 at 07:43:36PM -0400, Paul Moore wrote:
> > On Wed, Mar 27, 2024 at 7:26 PM Ayush Tiwari <ayushtiw0110@gmail.com> wrote:
> > >
> > > Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> > > struct landlock_object and update the related dependencies.
> > >
> > > Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> > > ---
> > >  security/landlock/fs.c     |  2 +-
> > >  security/landlock/object.c | 14 ++++++++++++--
> > >  security/landlock/object.h |  4 ++++
> > >  security/landlock/setup.c  |  2 ++
> > >  4 files changed, 19 insertions(+), 3 deletions(-)
> > 
> > Hi Ayush,
> > 
> > Mickaël has the final say on Landlock patches, but I had a few
> > comments that I've included below ...
> > 
> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > index fc520a06f9af..227dd67dd902 100644
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -124,7 +124,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> > >         if (unlikely(rcu_access_pointer(inode_sec->object))) {
> > >                 /* Someone else just created the object, bail out and retry. */
> > >                 spin_unlock(&inode->i_lock);
> > > -               kfree(new_object);
> > > +               kmem_cache_free(landlock_object_cache, new_object);
> > 
> > See my comment below, but you may want to wrap this in a Landlock
> > object API function.
> Sure. I will definitely implement this.
> > 
> > >                 rcu_read_lock();
> > >                 goto retry;
> > > diff --git a/security/landlock/object.c b/security/landlock/object.c
> > > index 1f50612f0185..df1354215617 100644
> > > --- a/security/landlock/object.c
> > > +++ b/security/landlock/object.c
> > > @@ -17,6 +17,15 @@
> > >
> > >  #include "object.h"
> > >
> > > +struct kmem_cache *landlock_object_cache;
> > > +
> > > +void __init landlock_object_init(void)
> > > +{
> > > +       landlock_object_cache = kmem_cache_create(
> > > +               "landlock_object_cache", sizeof(struct landlock_object), 0,

No need for the "_cache" name suffix.

> > > +               SLAB_PANIC, NULL);
> > 
> > The comments in include/linux/slab.h suggest using the KMEM_CACHE()
> > macro, instead of kmem_cache_create(), as a best practice for creating
> > slab caches.
> > 
> Sure. Apologies I didn't see that, I tried to implement it from scratch
> using the reference from linux memory management APIs.
> > > +}
> > > +
> > >  struct landlock_object *
> > >  landlock_create_object(const struct landlock_object_underops *const underops,
> > >                        void *const underobj)
> > > @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
> > >
> > >         if (WARN_ON_ONCE(!underops || !underobj))
> > >                 return ERR_PTR(-ENOENT);
> > > -       new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> > > +       new_object =
> > > +               kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);
> > 
> > If the line is too long, you might want to consider splitting the
> > function parameters like this:
> > 
> >   new_object = kmem_cache_zalloc(landlock_object_cache,
> >                                  GFP_KERNEL_ACCOUNT);
> > 
> 
> Sure. I didn't do as it was below the 100 columns limit, but will
> definitely implement it.

Please just use clang-format.

> > >         if (!new_object)
> > >                 return ERR_PTR(-ENOMEM);
> > >         refcount_set(&new_object->usage, 1);
> > > @@ -62,6 +72,6 @@ void landlock_put_object(struct landlock_object *const object)
> > >                  * @object->underobj to @object (if it still exists).
> > >                  */
> > >                 object->underops->release(object);
> > > -               kfree_rcu(object, rcu_free);

Is it safe?

According to commit ae65a5211d90 ("mm/slab: document kfree() as allowed
for kmem_cache_alloc() objects"), no change should be needed (and it
must not be backported to kernels older than 6.4 with CONFIG_SLOB). This
way we can avoid exporting landlock_object_cache.  Please add a note
about this commit and the related warning in the commit message.

> > > +               kmem_cache_free(landlock_object_cache, object);
> > >         }
> > >  }
> > > diff --git a/security/landlock/object.h b/security/landlock/object.h
> > > index 5f28c35e8aa8..8ba1af3ddc2e 100644
> > > --- a/security/landlock/object.h
> > > +++ b/security/landlock/object.h
> > > @@ -13,6 +13,10 @@
> > >  #include <linux/refcount.h>
> > >  #include <linux/spinlock.h>
> > >
> > > +extern struct kmem_cache *landlock_object_cache;
> > 
> > This really is a decision for Mickaël, but you may want to make
> > @landlock_object_cache private to object.c and create functions to
> > manage it as needed, e.g. put/free operations.
> > 
> Okay. I didn't make it private as I was using it in fs.c to use
> kmem_cache_free, but if this is supposed to be private, I can modify the
> approach and expose it via some function, not directly exposing
> landlock_object_cache.

Yes, that would be better.

> > > +void __init landlock_object_init(void);
> > > +
> > >  struct landlock_object;
> > >
> > >  /**
> > > diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> > > index f6dd33143b7f..a5fca4582ee1 100644
> > 
> > -- 
> > paul-moore.com
> I will make all the changes you mentioned, and as you said, I will
> wait for Mickael's say.

Agree with Paul and Greg unless commented otherwise. Thanks

