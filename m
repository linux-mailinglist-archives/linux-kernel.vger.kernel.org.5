Return-Path: <linux-kernel+bounces-122193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F288F34E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C4B1C2BCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128C415444F;
	Wed, 27 Mar 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DnKqWhRk"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C01534EC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711583030; cv=none; b=ug5S7dqE5aR00W7aZUjui4ngOx8qbNPMeoDFUCBCqMQHZDepxPvFbQvQpLvJMCvaiKksaz6VLumJyK9s2pCffjsWjyvho0ionCizx1Sl6mYAakA8J7CYMfiYiGlQvsBnLobdbBcx3ZcX+stspRJrwnDAougVYHVEEPhlI/EsR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711583030; c=relaxed/simple;
	bh=LHSTVg05tlSrlDZR4E07ykDqUEUkIg1dZ8Yhyx6TfZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdXJeKIHo0R0IbV1N8FhGSe+TV/Ez6Era1hsUiHwfD62NMKmKFW53TbzEFitFkSQpOnLOQVzY2Q8jABw2YLNqqtsAdPXMTRBcEPTZQx4f24jIeG3SJk7k+K5JgIAQ7+PhT8CnDhNXZlxKRPGmDyDYriGyn0qJaeBxw+ivQApMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DnKqWhRk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609f060cbafso4789127b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711583027; x=1712187827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsqU9PXjgnx5iMV4Gv2GAE/CJCMtgSBEOxF0nZeWP9w=;
        b=DnKqWhRkNNFRkN868BBDfaaMasrOZKbpuo0lu9nfxAodgZgqnBd+dl11LpF4xphv/H
         zN+cKxH7oiigp9Fq4z5ZMIVFJBoHofUnUhX5nC4xNURk6LopWDajhp75pc9WfE6wEED1
         OYLmuq5WPwu2ryBPp6X8IranWoHPIlEnh4xvx88swtCs1l/zg6KxTs9JRzMcg7+qrdiH
         v6uZjfSB6WrKiTvEgzbZP4QiZBRSMnv7ZWswLnGVLLblmVHidLOsoiH43bAmMMZhbGRb
         /Ket1pwRvZxsAeEEHHj6vyUlef2YMoi98HnZmnzPLGREBdbIPs6d5As52Upm8E0Oawq4
         OA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711583027; x=1712187827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsqU9PXjgnx5iMV4Gv2GAE/CJCMtgSBEOxF0nZeWP9w=;
        b=Hgu55rsz/A/RbvFAJaWtmQiIAbROm/RizcMl4L4Nts+KrxHg8e+wTWsnSPDZVkNaO/
         NXcwcxUTcWSumktrHe/0JPVWA7spkBz0+Lenr2CPbwL1IERPHoulJ+CQrwInF4HYu94T
         00635AT3pBppaZaPn9SLvxXGrrm6VEsLcMLij2JWhjoPSyiRWdOAjnWT6uw6Q4yAaEFS
         wJjhIujCw0AysyGicYwLsRQMhJ7W7jaKaHeSR4IDClC8o2WGMYag2ZIuLBjz9Z8NxdrA
         hj6ZpLUmvy9PBI8shbuOX4XoJy90YQJqraMMmJCrpVd0pYG2WfyCVM0SyuVz+Piho4Yd
         qIOw==
X-Forwarded-Encrypted: i=1; AJvYcCUdA5JQyqVwrrJBs0RVY6TPn3sAQssV9hB9rjlmQJdrA2+bCgealOwtzsCrOnoPP2QuZ9BJQ0Z2vgTwpvKcoNW4mO8Z/RVyg2L+YADh
X-Gm-Message-State: AOJu0Ywh0yKjzGP5zKqMN5dRuoMsCLhQ8b/3fkIepuOnuvjU9tqCzWoM
	xQtU2YQTA8fG8id8ji3XlTJPqFKjqB9yhrgPt3FNMCk2uuCx0whEPIIlG9u8rrsF1Rkq/o3epuM
	A3vglP2KBwwJXRCmSa0BgStM4/oQ9Oq8XQjgg
X-Google-Smtp-Source: AGHT+IFzJD42WxwIyDiJQ7hk0af16PEilvyKG/ivl0LgZM5S63lug/B1fRKIBhG8Khsl/MpMDLRdegs8EKQUu4OpC7E=
X-Received: by 2002:a81:8397:0:b0:611:1eee:3af3 with SMTP id
 t145-20020a818397000000b006111eee3af3mr1296551ywf.7.1711583027605; Wed, 27
 Mar 2024 16:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
In-Reply-To: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Mar 2024 19:43:36 -0400
Message-ID: <CAHC9VhRYDNoqkbkgdUSg-kYSHVbheD5NtezmVxyRakZ0-DzuSg@mail.gmail.com>
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: alison.schofield@intel.com, mic@digikod.net, 
	fabio.maria.de.francesco@linux.intel.com, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	outreachy@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:26=E2=80=AFPM Ayush Tiwari <ayushtiw0110@gmail.co=
m> wrote:
>
> Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> struct landlock_object and update the related dependencies.
>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  security/landlock/fs.c     |  2 +-
>  security/landlock/object.c | 14 ++++++++++++--
>  security/landlock/object.h |  4 ++++
>  security/landlock/setup.c  |  2 ++
>  4 files changed, 19 insertions(+), 3 deletions(-)

Hi Ayush,

Micka=C3=ABl has the final say on Landlock patches, but I had a few
comments that I've included below ...

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index fc520a06f9af..227dd67dd902 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -124,7 +124,7 @@ static struct landlock_object *get_inode_object(struc=
t inode *const inode)
>         if (unlikely(rcu_access_pointer(inode_sec->object))) {
>                 /* Someone else just created the object, bail out and ret=
ry. */
>                 spin_unlock(&inode->i_lock);
> -               kfree(new_object);
> +               kmem_cache_free(landlock_object_cache, new_object);

See my comment below, but you may want to wrap this in a Landlock
object API function.

>                 rcu_read_lock();
>                 goto retry;
> diff --git a/security/landlock/object.c b/security/landlock/object.c
> index 1f50612f0185..df1354215617 100644
> --- a/security/landlock/object.c
> +++ b/security/landlock/object.c
> @@ -17,6 +17,15 @@
>
>  #include "object.h"
>
> +struct kmem_cache *landlock_object_cache;
> +
> +void __init landlock_object_init(void)
> +{
> +       landlock_object_cache =3D kmem_cache_create(
> +               "landlock_object_cache", sizeof(struct landlock_object), =
0,
> +               SLAB_PANIC, NULL);

The comments in include/linux/slab.h suggest using the KMEM_CACHE()
macro, instead of kmem_cache_create(), as a best practice for creating
slab caches.

> +}
> +
>  struct landlock_object *
>  landlock_create_object(const struct landlock_object_underops *const unde=
rops,
>                        void *const underobj)
> @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_und=
erops *const underops,
>
>         if (WARN_ON_ONCE(!underops || !underobj))
>                 return ERR_PTR(-ENOENT);
> -       new_object =3D kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> +       new_object =3D
> +               kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOU=
NT);

If the line is too long, you might want to consider splitting the
function parameters like this:

  new_object =3D kmem_cache_zalloc(landlock_object_cache,
                                 GFP_KERNEL_ACCOUNT);

>         if (!new_object)
>                 return ERR_PTR(-ENOMEM);
>         refcount_set(&new_object->usage, 1);
> @@ -62,6 +72,6 @@ void landlock_put_object(struct landlock_object *const =
object)
>                  * @object->underobj to @object (if it still exists).
>                  */
>                 object->underops->release(object);
> -               kfree_rcu(object, rcu_free);
> +               kmem_cache_free(landlock_object_cache, object);
>         }
>  }
> diff --git a/security/landlock/object.h b/security/landlock/object.h
> index 5f28c35e8aa8..8ba1af3ddc2e 100644
> --- a/security/landlock/object.h
> +++ b/security/landlock/object.h
> @@ -13,6 +13,10 @@
>  #include <linux/refcount.h>
>  #include <linux/spinlock.h>
>
> +extern struct kmem_cache *landlock_object_cache;

This really is a decision for Micka=C3=ABl, but you may want to make
@landlock_object_cache private to object.c and create functions to
manage it as needed, e.g. put/free operations.

> +void __init landlock_object_init(void);
> +
>  struct landlock_object;
>
>  /**
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index f6dd33143b7f..a5fca4582ee1 100644

--=20
paul-moore.com

