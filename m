Return-Path: <linux-kernel+bounces-109235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10AA88168C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C31B247B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA06A34C;
	Wed, 20 Mar 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H15/vG7q"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547456A352
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955411; cv=none; b=A2LrYEpkEfpSXR0ieWjNfUbVUZ8HaXegw0qVpTM2PtbzroLhjdu7jeJHcRjE177cm3uTMYbA00+6Ji+6FHtEAd2oZ5CPUEDvE3t4g1/vIgZ7TgmYyL1bOZMJI8gwqfbHteSP+OMFsoj9ZOOAWWXVoNNNm6tODzaEpTuwekNUePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955411; c=relaxed/simple;
	bh=OktSo1wzw1/Tkeb7gXpxEk9VZSpYD0XVPWVaHlIfXLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVojFxu9an455w7rxSwtCRAkdZjEqGBJbHWJg3K64lp2pB4s8eQwv42dCoYF0S1PKZ54oT8lPNpdLsVhy8lA5VEVNZiidLdCXCk86aBUbjw7FjzN4B4cJnXU1wYko2j9p5aVdhO8teg18g22vD1dfpt8noz1Fylw3YHXNEUrdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H15/vG7q; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so36137276.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710955408; x=1711560208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL+b5IqSmT+yiak0XO4i+W4JtR/sEZzsL6gRjLnV0bw=;
        b=H15/vG7qa1BJl+WAVEBXvPDOZEyqOItjukuwuyfXqo45SrRqeRnCg+c/A9XcU4Igx5
         Xia2L1XUdWfzbAqia0bi1F6JzvRrdP4YcyjOSucD2Pw5f4ItzGdTCHwTD9Lxnb0VdPMw
         Yty+rprYSuGl6HQeUSPdzVCEUY69UtLgXPtnuTRiq2qk0Fiywr/EtuF22UumK05cilb+
         eC+TbJBGBnp3yOt3bvTCL3knu6x1qxMysTgBXS3MMR4/Ai8LbaslK+XCUp6sDFL7paBL
         2Cz51FJIspcDZv28d83d0ZysY5dd2mXEFMWz0LFi2BWVn92abrHHwnteqQkEDpl1Vr1q
         1kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710955408; x=1711560208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL+b5IqSmT+yiak0XO4i+W4JtR/sEZzsL6gRjLnV0bw=;
        b=E/AuXv54kMiU/q5QLsUhhBvik3uBAa92satjYG6h5qByqRiaI/KpcYRSE9Y80HRA0+
         zyDbc2PY2vgYHUfE4VF7Tc0ZopuimbytKkBgiApQt9mM2MOy/Dco+IdCfriTAJdjpozn
         BhU10Yns6BqQh9AcNEqZfpXefmSgm3/tb65MrJ+zTQMrZqi/Qcld8C7I3gp1fkoBWaZg
         hCXLCEGl5CpLzDcBoWzVsZOff5TS4ju+NBvCvDGyF0A7LG2Px9rhiw9XYiPqRI0ifPen
         gck0g2xox5arcfuVuIvQHuwan0XwZkFEglzgGBYS23XA7aqVUuXXI21CrxK3YA1OA4X2
         1bPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHKVuC4rSd5wadXcEnk49cnSDfwW9oEgrgWl3N07AipQgbCXYtgHhzD683pIAFET8orXfgaf7u/rTPopiH0vbyMrMMuQrRUvzwNNmj
X-Gm-Message-State: AOJu0YyB9AHxzU5phhLAXO+AzcP3hXEY+d4tZHSBcPGynOKjZHNamoPZ
	z0t7SXCsQa+HdqRO7UFfk8xun8K1HB/1s1UqcAkSvdKAeWFGEESPKBFwQG3lvVUR9ik+ZBxLG0+
	A11qQ73cYiwl4mL3Kc/0+blvHo6ieDwH7AajW
X-Google-Smtp-Source: AGHT+IGisQjCjQt12sXnN9Jt9UbAiCVuocXkhWkDVU4b8Sz//Q1jqxXIMt0rNAmfp/Y8hIDNuFGtuTe2UbVFtwFiUv0=
X-Received: by 2002:a25:6fc5:0:b0:dd1:2f58:292b with SMTP id
 k188-20020a256fc5000000b00dd12f58292bmr13153934ybc.9.1710955408153; Wed, 20
 Mar 2024 10:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710560151-28904-15-git-send-email-wufan@linux.microsoft.com>
 <657b73a0cf531fd4291a0f780d2fcf78@paul-moore.com> <ZfpHxkmRy0oqxZVF@redhat.com>
In-Reply-To: <ZfpHxkmRy0oqxZVF@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Mar 2024 13:23:17 -0400
Message-ID: <CAHC9VhTkpSa665tesTEs8gBjaD3ahUMATGMXuGy+-unt7WL-UQ@mail.gmail.com>
Subject: Re: [PATCH RFC v15 14/21] dm verity: consume root hash digest and
 signature data via LSM hook
To: Mike Snitzer <snitzer@kernel.org>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
	axboe@kernel.dk, agk@redhat.com, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:19=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> =
wrote:
> On Tue, Mar 19 2024 at  7:00P -0400,
> Paul Moore <paul@paul-moore.com> wrote:
> > On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> > >
> > > dm-verity provides a strong guarantee of a block device's integrity. =
As
> > > a generic way to check the integrity of a block device, it provides
> > > those integrity guarantees to its higher layers, including the filesy=
stem
> > > level.
> > >
> > > An LSM that control access to a resource on the system based on the
> > > available integrity claims can use this transitive property of
> > > dm-verity, by querying the underlying block_device of a particular
> > > file.
> > >
> > > The digest and signature information need to be stored in the block
> > > device to fulfill the next requirement of authorization via LSM polic=
y.
> > > This will enable the LSM to perform revocation of devices that are st=
ill
> > > mounted, prohibiting execution of files that are no longer authorized
> > > by the LSM in question.
> > >
> > > This patch adds two security hook calls in dm-verity to save the
> > > dm-verity roothash and the roothash signature to the block device's
> > > LSM blobs. The hook calls are depended on CONFIG_IPE_PROP_DM_VERITY,
> > > which will be introduced in the next commit.
> > >
> > > Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> > > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> > > ---
> > > v2:
> > >   + No Changes
> > >
> > > v3:
> > >   + No changes
> > >
> > > v4:
> > >   + No changes
> > >
> > > v5:
> > >   + No changes
> > >
> > > v6:
> > >   + Fix an improper cleanup that can result in
> > >     a leak
> > >
> > > v7:
> > >   + Squash patch 08/12, 10/12 to [11/16]
> > >   + Use part0 for block_device, to retrieve the block_device, when
> > >     calling security_bdev_setsecurity
> > >
> > > v8:
> > >   + Undo squash of 08/12, 10/12 - separating drivers/md/ from
> > >     security/ & block/
> > >   + Use common-audit function for dmverity_signature.
> > >   + Change implementation for storing the dm-verity digest to use the
> > >     newly introduced dm_verity_digest structure introduced in patch
> > >     14/20.
> > >   + Create new structure, dm_verity_digest, containing digest algorit=
hm,
> > >     size, and digest itself to pass to the LSM layer. V7 was missing =
the
> > >     algorithm.
> > >   + Create an associated public header containing this new structure =
and
> > >     the key values for the LSM hook, specific to dm-verity.
> > >   + Additional information added to commit, discussing the layering o=
f
> > >     the changes and how the information passed will be used.
> > >
> > > v9:
> > >   + No changes
> > >
> > > v10:
> > >   + No changes
> > >
> > > v11:
> > >   + Add an optional field to save signature
> > >   + Move the security hook call to the new finalize hook
> > >
> > > v12:
> > >   + No changes
> > >
> > > v13:
> > >   + No changes
> > >
> > > v14:
> > >   + Correct code format
> > >   + Remove unnecessary header and switch to dm_disk()
> > >
> > > v15:
> > >   + Refactor security_bdev_setsecurity() to security_bdev_setintegrit=
y()
> > >   + Remove unnecessary headers
> > > ---
> > >  drivers/md/dm-verity-target.c | 73 +++++++++++++++++++++++++++++++++=
++
> > >  drivers/md/dm-verity.h        |  6 +++
> > >  include/linux/dm-verity.h     | 12 ++++++
> > >  include/linux/security.h      |  2 +
> > >  4 files changed, 93 insertions(+)
> > >  create mode 100644 include/linux/dm-verity.h
> > >
> > > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-tar=
get.c
> > > index bb5da66da4c1..e94cc6a755d5 100644
> > > --- a/drivers/md/dm-verity-target.c
> > > +++ b/drivers/md/dm-verity-target.c
> > > @@ -22,6 +22,8 @@
> > >  #include <linux/scatterlist.h>
> > >  #include <linux/string.h>
> > >  #include <linux/jump_label.h>
> > > +#include <linux/security.h>
> > > +#include <linux/dm-verity.h>
> > >
> > >  #define DM_MSG_PREFIX                      "verity"
> > >
> > > @@ -1017,6 +1019,38 @@ static void verity_io_hints(struct dm_target *=
ti, struct queue_limits *limits)
> > >     blk_limits_io_min(limits, limits->logical_block_size);
> > >  }
> > >
> > > +#ifdef CONFIG_IPE_PROP_DM_VERITY
> > > +
> > > +static int verity_init_sig(struct dm_verity *v, const void *sig,
> > > +                      size_t sig_size)
> > > +{
> > > +   v->sig_size =3D sig_size;
> > > +   v->root_digest_sig =3D kmalloc(v->sig_size, GFP_KERNEL);
> > > +   if (!v->root_digest)
> > > +           return -ENOMEM;
> >
> > Either you meant to copy @sig into @v->root_digest_sig and forgot to
> > add the code for that, or we don't need to include @sig as a parameter
> > to this function.  I'm guessing it is the former as it wouldn't make
> > sense to even have dm_verity::root_digest_sig if we weren't stashing
> > it here.
> >
> > I'd also suggest looking at kmemdup() instead of a kmalloc()/memcpy()
> > combo.
> >
> > > +   return 0;
> > > +}
> > > +
> > > +static void verity_free_sig(struct dm_verity *v)
> > > +{
> > > +   kfree(v->root_digest_sig);
> > > +}
> > > +#else
> > > +
> > > +static inline int verity_init_sig(struct dm_verity *v, const void *s=
ig,
> > > +                             size_t sig_size)
> > > +{
> > > +   return 0;
> > > +}
> > > +
> > > +static inline void verity_free_sig(struct dm_verity *v)
> > > +{
> > > +}
> > > +
> > > +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> >
> > It's been a while since I looked at this patch in the patchset, so
> > maybe I'm missing something, but in general we don't want CONFIG_XXX
> > checks in the kernel, outside of security/, that are specific to a
> > particular LSM (what happens when multiple LSMs need this?).  Please
> > use CONFIG_SECURITY instead.
> >
> > >  static void verity_dtr(struct dm_target *ti)
> > >  {
> > >     struct dm_verity *v =3D ti->private;
> > > @@ -1035,6 +1069,7 @@ static void verity_dtr(struct dm_target *ti)
> > >     kfree(v->salt);
> > >     kfree(v->root_digest);
> > >     kfree(v->zero_digest);
> > > +   verity_free_sig(v);
> > >
> > >     if (v->tfm)
> > >             crypto_free_ahash(v->tfm);
> > > @@ -1434,6 +1469,13 @@ static int verity_ctr(struct dm_target *ti, un=
signed int argc, char **argv)
> > >             ti->error =3D "Root hash verification failed";
> > >             goto bad;
> > >     }
> > > +
> > > +   r =3D verity_init_sig(v, verify_args.sig, verify_args.sig_size);
> > > +   if (r < 0) {
> > > +           ti->error =3D "Cannot allocate root digest signature";
> > > +           goto bad;
> > > +   }
> > > +
> > >     v->hash_per_block_bits =3D
> > >             __fls((1 << v->hash_dev_block_bits) / v->digest_size);
> > >
> > > @@ -1584,6 +1626,34 @@ int dm_verity_get_root_digest(struct dm_target=
 *ti, u8 **root_digest, unsigned i
> > >     return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_IPE_PROP_DM_VERITY
> > > +
> > > +static int verity_finalize(struct dm_target *ti)
> > > +{
> > > +   struct block_device *bdev;
> > > +   struct dm_verity_digest root_digest;
> > > +   struct dm_verity *v;
> > > +   int r;
> > > +
> > > +   v =3D ti->private;
> > > +   bdev =3D dm_disk(dm_table_get_md(ti->table))->part0;
> > > +   root_digest.digest =3D v->root_digest;
> > > +   root_digest.digest_len =3D v->digest_size;
> > > +   root_digest.alg =3D v->alg_name;
> > > +
> > > +   r =3D security_bdev_setintegrity(bdev, LSM_INTGR_DMV_ROOTHASH, &r=
oot_digest,
> > > +                                  sizeof(root_digest));
> > > +   if (r)
> > > +           return r;
> > > +
> > > +   return security_bdev_setintegrity(bdev,
> > > +                                     LSM_INTGR_DMV_SIG,
> > > +                                     v->root_digest_sig,
> > > +                                     v->sig_size);
> >
> > What happens if the second call fails, should we clear the
> > LSM_INTGR_DMV_ROOTHASH state in the LSM?
> >
> > > +}
> > > +
> > > +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> >
> > See my comments about CONFIG_SECURITY above.  In fact, I would suggest
> > moving this up into that part of the file so you only need one #ifdef
> > block relating to CONFIG_SECURITY.
> >
> > I would also recommend making a dummy function so we can get rid of
> > the conditional compilation in @verity_target below.  For example:
> >
> >   #ifdef CONFIG_SECURITY
> >   static int verity_finalize(struct dm_target *ti)
> >   {
> >     /* real implementation */
> >   }
> >   #else
> >   static int verity_finalize(struct dm_target *ti)
> >   {
> >     return 0;
> >   }
> >   #endif /* CONFIG_SECURITY */
> >
> > >  static struct target_type verity_target =3D {
> > >     .name           =3D "verity",
> > >     .features       =3D DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
> > > @@ -1596,6 +1666,9 @@ static struct target_type verity_target =3D {
> > >     .prepare_ioctl  =3D verity_prepare_ioctl,
> > >     .iterate_devices =3D verity_iterate_devices,
> > >     .io_hints       =3D verity_io_hints,
> > > +#ifdef CONFIG_IPE_PROP_DM_VERITY
> > > +   .finalize       =3D verity_finalize,
> > > +#endif /* CONFIG_IPE_PROP_DM_VERITY */
> > >  };
> > >  module_dm(verity);
> >
> > If you create a dummy verity_finalize() function like above you can
> > get rid of the #ifdef checks.
>
> Think it is better to leave it as-is, to avoid calling the .finalize
> hook if it isn't actually needed.

Fair enough, my personal preference is to minimize Kconfig conditional
code flow changes such as this, but I understand your point of view
and device-mapper is your code after all.

I believe the other issues still need to be addressed, but other than
that are you generally okay with the new "finalize" hook approach?

--=20
paul-moore.com

