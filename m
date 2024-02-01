Return-Path: <linux-kernel+bounces-48085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8B84570A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208A2290E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B915DBA1;
	Thu,  1 Feb 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFXudBYv"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13A15CD72;
	Thu,  1 Feb 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789473; cv=none; b=arld/fkXYjiOXN76/nAarJuTYJEeeUj7ZI/vaxYOBiwow8jlzw+AIvPA8cvxp9eKJ11cI7J4pv4t2ipi3+ioDa0NeFbONytF6Jdgov50Tco/3li7y+8ka3dykNJeWV/mWJZu5Kynp+vEnBaVoM52k905CQAYLc5muEwcDE5IrJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789473; c=relaxed/simple;
	bh=BKkgs5o3flr8DLm3fRhM8fmYE/Cis38Wwzz6W7RuFKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQc1Cl8peuMxRtkKyFUhdH1v0izQUoFTvvb22onni9iF+X3We1+srX33Ibb8pxoA5cYbYbWtOTV4uZde84E04jR9b+CEU8JBTJ7dzMfzZZL0op1oz6r/Dtszt4JD9sMK1hzG4CoeSj+uVHCqqsXzt9PYUkXf9Dc8DsXwGXq1sU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFXudBYv; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783def87c8cso55057885a.0;
        Thu, 01 Feb 2024 04:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706789470; x=1707394270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot6Gz4jMBpIlofVX53+ZXvqyeKrVY8kBh2nwQY9He9E=;
        b=eFXudBYvX2tcpFNSUP2cazwHp3jOYG+ZdrYS4wh6m4wsR9ORg/zK6R8NgJZgfvZi1T
         nyfqbPCzN9fkLyU8bMzkVy31OkediJZszk7kXAuT406rhbbh1zpGPe98+5ae5ahD8vVL
         qfGMWolbvoe3gjpGTwVbuX3ZcizxmHruR0WfML2yQmdYjB+LMYraAFHkSfBHEjbwLnPV
         7Wg86Bgd96eMPozWFgCm/ZIRHptY52G5akn/QfxXQjI7++M7MsK6eyXZaDsM+SgXEfhS
         5m8CmMc7i08QrSftbwfz0rnJmZzODWPrw/S9AiAQL3hQoBXmjGAKs168Du0mudibfb/Z
         rjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789470; x=1707394270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot6Gz4jMBpIlofVX53+ZXvqyeKrVY8kBh2nwQY9He9E=;
        b=sdGWcerYoFYS8Cqm3NwrAYdEL1C0O96QDLUFKVuuCONIQtNcYcABvs79vZkyG/fjgw
         7/RNiGpPPCMsTbod8KZXB64lghwg4q2nqv1upZqJdtgBbzyu5wLJ1rzSC4EhXVDks2BF
         5Td8hqKnhIb0WOUcLzVRewVu7DIvqe6+ckQLPn9h6AkOvCrEtb5OlFL3NFAeCnsEkqgw
         Jq0BbtszAcqcq1Cnd9tlQmrKBzoXJj3bDVSr4Wlxfi/QVxBD5eVjXjqdcjx9L7nDhxIG
         4XwXjsLcImtWB8doG501l9ehlBEgFxVbRiW4qFg+gZRNKryBiHqFdCnQvgpT5Ols5jmq
         ZdhQ==
X-Gm-Message-State: AOJu0YzReK1Okx2/fFKR/eysnm32REusatw7doCDXJrEEh4S8Ws13aOs
	UPOoSvUKpXiac8giCMMmn+h8RTeRVQ+5+srroe4QdB4eQ35WsELrZiZ3nIj76eJvUjYa0AhcA+p
	0D5hn1NtFGdoAIrSs0XVQ567nOq0=
X-Google-Smtp-Source: AGHT+IHz6LtCx2w85BoWFdo+DeI9pIZ3+8vPu7taC1c5PJhh8sKbBeBLxRBVp/IF+mUCKoIMsRCelHFrrApZQHhaDAc=
X-Received: by 2002:a05:6214:d6a:b0:686:abad:6f13 with SMTP id
 10-20020a0562140d6a00b00686abad6f13mr4705853qvs.7.1706789470211; Thu, 01 Feb
 2024 04:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com> <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
 <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com> <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com> <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com>
In-Reply-To: <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 14:10:58 +0200
Message-ID: <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:46=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 1/31/24 12:23, Amir Goldstein wrote:
> > On Wed, Jan 31, 2024 at 5:54=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> >>
> >> On Wed, Jan 31, 2024 at 4:40=E2=80=AFPM Stefan Berger <stefanb@linux.i=
bm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 1/31/24 08:16, Amir Goldstein wrote:
> >>>> On Wed, Jan 31, 2024 at 4:11=E2=80=AFAM Stefan Berger <stefanb@linux=
ibm.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 1/30/24 16:46, Stefan Berger wrote:
> >>>>>> Changes to the file attribute (mode bits, uid, gid) on the lower l=
ayer
> >>>>>> are not take into account when d_backing_inode() is used when a fi=
le is
> >>>>>> accessed on the overlay layer and this file has not yet been copie=
d up.
> >>>>>> This is because d_backing_inode() does not return the real inode o=
f the
> >>>>>> lower layer but instead returns the backing inode which holds old =
file
> >>>>>> attributes. When the old file attributes are used for calculating =
the
> >>>>>> metadata hash then the expected hash is calculated and the file th=
en
> >>>>>> mistakenly passes signature verification. Therefore, use d_real_in=
ode()
> >>>>>> which returns the inode of the lower layer for as long as the file=
 has
> >>>>>> not been copied up and returns the upper layer's inode otherwise.
> >>>>>>
> >>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>>>> ---
> >>>>>>     security/integrity/evm/evm_crypto.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integr=
ity/evm/evm_crypto.c
> >>>>>> index b1ffd4cc0b44..2e48fe54e899 100644
> >>>>>> --- a/security/integrity/evm/evm_crypto.c
> >>>>>> +++ b/security/integrity/evm/evm_crypto.c
> >>>>>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry=
 *dentry,
> >>>>>>                                  size_t req_xattr_value_len,
> >>>>>>                                  uint8_t type, struct evm_digest *=
data)
> >>>>>>     {
> >>>>>> -     struct inode *inode =3D d_backing_inode(dentry);
> >>>>>> +     struct inode *inode =3D d_real_inode(dentry);
> >>>>>>         struct xattr_list *xattr;
> >>>>>>         struct shash_desc *desc;
> >>>>>>         size_t xattr_size =3D 0;
> >>>>>
> >>>>> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY b=
ut
> >>>>> when setting CONFIG_OVERLAY_FS_METACOPY=3Dy it has to be reverted..=
  I am
> >>>>> not sure what the solution is.
> >>>>
> >>>> I think d_real_inode() does not work correctly for all its current u=
sers for
> >>>> a metacopy file.
> >>>>
> >>>> I think the solution is to change d_real_inode() to return the data =
inode
> >>>> and add another helper to get the metadata inode if needed.
> >>>> I will post some patches for it.
> >>>
> >>> I thought that we may have to go through vfs_getattr() but even bette=
r
> >>> if we don't because we don't have the file *file anywhere 'near'.
> >>>
> >>>>
> >>>> However, I must say that I do not know if evm_calc_hmac_or_hash()
> >>>> needs the lower data inode, the upper metadata inode or both.
> >>>
> >>> What it needs are data structures with mode bits, uid, and gid that s=
tat
> >>> in userspace would show.
> >>>
> >>>
> >>
> >> With or without metacopy enabled, an overlay inode st_uid st_gid st_mo=
de
> >> are always taken from the upper most inode which is what d_real_inode(=
)
> >> currently returns, so I do not understand what the problem is.
> >>
> >
> > No, I was wrong. It is the other way around.
> > d_real_inode() always returns the real data inode and you need the
> > upper most real inode.
> >
> > You can try this:
> >
> >   -     struct inode *inode =3D d_backing_inode(dentry);
> > +     struct inode *inode =3D d_inode(d_real(dentry, false));
> >
> > With the changes in:
> >
> > https://github.com/amir73il/linux/commits/overlayfs-devel/
> >
> > Not thoroughly tested...
>
> The change + 3 topmost patches cherry-picked is unfortunately are
> crashing for me.
>

I will look into it.
But anyway, the patch I suggested above is not enough exactly because
of the reason I told you earlier.

Mimi's fix ("ima: detect changes to the backing overlay file") detects
a change in d_real_inode(file_dentry(file)) in order to invalidate the
IMA cache.

Your change also invalidates EVM cache on a change in
d_real_inode(file_dentry(file)) and that makes sense.

But on "meta copy up" for example on chmod(), an upper inode with no data
is created (a metacopy) and all the attributes and xattr are copied
from lower inode.
The data remains in the lower inode.

At this point , the IMA cache and the EVM cache refer to two different inod=
es
so you cannot share the same logic with IMA cache invalidation.

My patches are meant to provide you with a helper e.g. d_real_meta_inode()
that you could use to get the upper inode in the case of a metacopy, but
IMA would still need to use the d_real_data_inode().

Is that explanation clear? Is it clear why I said that the problem is more
complicated?

Thanks,
Amir.

