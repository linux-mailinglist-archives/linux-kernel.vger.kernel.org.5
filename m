Return-Path: <linux-kernel+bounces-48293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C468459B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD102831A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C35D48B;
	Thu,  1 Feb 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKmB78BH"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4786635;
	Thu,  1 Feb 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796734; cv=none; b=EAprTVnTdahBcs9xKiOH5Sh+xz/Eon/5SEZVGQiJp5S3gvE4jsacggpAY/tIR45geykvtfIEfavCEnMNnTwciFPiP82krZOjWjl4zHBWfnuoKmWKsN2CFvvje8dFfXfhe9zJiHe7RAWzr9UFMkaSLhRxYeQgNJjmftkTA890XA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796734; c=relaxed/simple;
	bh=5xaPFnCX2vbnYTtHhR9j0p4bpLju6y8WFIdeZ7FdK00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRXnOAI+ZgbLGurxV+QysJA6gCZU4XjR2GVaoya8F5AIcHNS44fEA2NRi66eFYY+PkcBu392l6WmLUjXJu6VGILegU5RY9kvYHCPrCp8qz5hyEwwNPKFIdCveuSDuDMb5dSOZaIYSr4jIquaga3yptmxC08B1Za4X0QN1NaHteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKmB78BH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6818aa08a33so6428956d6.0;
        Thu, 01 Feb 2024 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796731; x=1707401531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPhh82PWJJRNuo2DYhsWkVt875ScokpwrfvAzdKKAp8=;
        b=VKmB78BHIrKGhAkihQbZKGTORJ+QXm40HVPop03GL3drwbxKhz6upekDzZHp//LXBU
         gPHoeK9tq4FtC+H2Kr10E/x+PTW/ezQ0CvA0HekCSVQajzixji2vCYOrpDLkXTNGcXAM
         7OQGVHF8WRIt/XaDNUqcjWus9jv13/7px1qa3pN/xXVBeW3ubtpGQ0XuzWd3GvcMIG2n
         Lg2+A99eP9spupCUCp8k3s8+dUydS6vaHNMP5+cM+EYKD5k05VL9CpjdMYyhAmMifdQk
         I1Fm2R3GK3ffb8eUgvO7A2wsFvAnJIT5ybmRzf8I5mrAvNt/xWp37VwUQKGl7cjeq9es
         RGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796731; x=1707401531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPhh82PWJJRNuo2DYhsWkVt875ScokpwrfvAzdKKAp8=;
        b=e1fc2u60qHWG2v0adRtf+UhTKt2s/bYrnR5vndpmmUMgHSNfRXIBib64nZM8Y7VqL9
         hMFHqJSY35xGMCZUArSUBp8nXW/Z3j9b1lVCKwlLn5LV+MWbCYJwy3UUAFe83Y2DEndi
         OutHMTR5EIuhKIX14YBRS0OYRzAnwHgecB782xaFzxJk2mf6ZwZ+8hs8x1Q2Q685bwSG
         lM3ZWMFvfK7/rNcRU+GIqnuQlJZssYbvHzRL1rcbsQzFFLN6SdnhPmN8hgo1Jtl3NRl9
         ZxkFraAIxcjF1jqeBpAWhvtNgCVfHQkHkzcHJUSNTwmczCkhVjig/vR7FhmyVVAQMpO2
         OJEA==
X-Gm-Message-State: AOJu0YwSDI7HomH3t7omhtAodbmsiNH8Rfma4qtGGOD2A4VFR7LhhB9m
	Ad/eVaSNRS5Jb7IHF/tttPuF7tkrhHnQoZSDLw44HwL81Xz8tXnEf3a/qeaAvAdkU87JBcblvn3
	8MRD6c3vLagPfU+0P/bXFc6baigA=
X-Google-Smtp-Source: AGHT+IGQxr75O1L121ESBq5a7/TmtQXO/pX79DrTt6euTijTzh4ghWHxd9hGbQ+IA+5MgvG2zFcMP2PoVG+ADQI7gCU=
X-Received: by 2002:a0c:f5c8:0:b0:68c:5520:281e with SMTP id
 q8-20020a0cf5c8000000b0068c5520281emr8410698qvm.16.1706796730303; Thu, 01 Feb
 2024 06:12:10 -0800 (PST)
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
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
 <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com> <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
 <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com>
In-Reply-To: <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 16:11:58 +0200
Message-ID: <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:37=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
>
>
> On 2/1/24 07:10, Amir Goldstein wrote:
> > On Wed, Jan 31, 2024 at 7:46=E2=80=AFPM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >>
> >>
> >>
> >> On 1/31/24 12:23, Amir Goldstein wrote:
> >>> On Wed, Jan 31, 2024 at 5:54=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> >>>>
> >>>> On Wed, Jan 31, 2024 at 4:40=E2=80=AFPM Stefan Berger <stefanb@linux=
ibm.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 1/31/24 08:16, Amir Goldstein wrote:
> >>>>>> On Wed, Jan 31, 2024 at 4:11=E2=80=AFAM Stefan Berger <stefanb@lin=
ux.ibm.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 1/30/24 16:46, Stefan Berger wrote:
> >>>>>>>> Changes to the file attribute (mode bits, uid, gid) on the lower=
 layer
> >>>>>>>> are not take into account when d_backing_inode() is used when a =
file is
> >>>>>>>> accessed on the overlay layer and this file has not yet been cop=
ied up.
> >>>>>>>> This is because d_backing_inode() does not return the real inode=
 of the
> >>>>>>>> lower layer but instead returns the backing inode which holds ol=
d file
> >>>>>>>> attributes. When the old file attributes are used for calculatin=
g the
> >>>>>>>> metadata hash then the expected hash is calculated and the file =
then
> >>>>>>>> mistakenly passes signature verification. Therefore, use d_real_=
inode()
> >>>>>>>> which returns the inode of the lower layer for as long as the fi=
le has
> >>>>>>>> not been copied up and returns the upper layer's inode otherwise=
.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>>>>>> ---
> >>>>>>>>      security/integrity/evm/evm_crypto.c | 2 +-
> >>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/inte=
grity/evm/evm_crypto.c
> >>>>>>>> index b1ffd4cc0b44..2e48fe54e899 100644
> >>>>>>>> --- a/security/integrity/evm/evm_crypto.c
> >>>>>>>> +++ b/security/integrity/evm/evm_crypto.c
> >>>>>>>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dent=
ry *dentry,
> >>>>>>>>                                   size_t req_xattr_value_len,
> >>>>>>>>                                   uint8_t type, struct evm_diges=
t *data)
> >>>>>>>>      {
> >>>>>>>> -     struct inode *inode =3D d_backing_inode(dentry);
> >>>>>>>> +     struct inode *inode =3D d_real_inode(dentry);
> >>>>>>>>          struct xattr_list *xattr;
> >>>>>>>>          struct shash_desc *desc;
> >>>>>>>>          size_t xattr_size =3D 0;
> >>>>>>>
> >>>>>>> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY=
 but
> >>>>>>> when setting CONFIG_OVERLAY_FS_METACOPY=3Dy it has to be reverted=
..  I am
> >>>>>>> not sure what the solution is.
> >>>>>>
> >>>>>> I think d_real_inode() does not work correctly for all its current=
 users for
> >>>>>> a metacopy file.
> >>>>>>
> >>>>>> I think the solution is to change d_real_inode() to return the dat=
a inode
> >>>>>> and add another helper to get the metadata inode if needed.
> >>>>>> I will post some patches for it.
> >>>>>
> >>>>> I thought that we may have to go through vfs_getattr() but even bet=
ter
> >>>>> if we don't because we don't have the file *file anywhere 'near'.
> >>>>>
> >>>>>>
> >>>>>> However, I must say that I do not know if evm_calc_hmac_or_hash()
> >>>>>> needs the lower data inode, the upper metadata inode or both.
> >>>>>
> >>>>> What it needs are data structures with mode bits, uid, and gid that=
 stat
> >>>>> in userspace would show.
> >>>>>
> >>>>>
> >>>>
> >>>> With or without metacopy enabled, an overlay inode st_uid st_gid st_=
mode
> >>>> are always taken from the upper most inode which is what d_real_inod=
e()
> >>>> currently returns, so I do not understand what the problem is.
> >>>>
> >>>
> >>> No, I was wrong. It is the other way around.
> >>> d_real_inode() always returns the real data inode and you need the
> >>> upper most real inode.
> >>>
> >>> You can try this:
> >>>
> >>>    -     struct inode *inode =3D d_backing_inode(dentry);
> >>> +     struct inode *inode =3D d_inode(d_real(dentry, false));
> >>>
> >>> With the changes in:
> >>>
> >>> https://github.com/amir73il/linux/commits/overlayfs-devel/
> >>>
> >>> Not thoroughly tested...
> >>
> >> The change + 3 topmost patches cherry-picked is unfortunately are
> >> crashing for me.
> >>
> >
> > I will look into it.
> > But anyway, the patch I suggested above is not enough exactly because
> > of the reason I told you earlier.
> >
> > Mimi's fix ("ima: detect changes to the backing overlay file") detects
> > a change in d_real_inode(file_dentry(file)) in order to invalidate the
> > IMA cache.
> >
> > Your change also invalidates EVM cache on a change in
> > d_real_inode(file_dentry(file)) and that makes sense.
> >
> > But on "meta copy up" for example on chmod(), an upper inode with no da=
ta
> > is created (a metacopy) and all the attributes and xattr are copied
> > from lower inode.
> > The data remains in the lower inode.
> >
> > At this point , the IMA cache and the EVM cache refer to two different =
inodes
>
> You mean they refer to different inodes because IMA cares about file
> content ("data remains in the lower inode:) and EVM cares about the
> metadata ("an upper inode with no data is created")? If so, I agree

Correct.

> since the following line after copy-up with meatacopy enabled shows the
> proper GID is in the backing inode not the one return from
> d_real_inode(). If we knew that a meta copy has been done we could call
> d_backing_inode() in this case for access to mode bits, uid, and gid.
>

You should be able to use
d_real_meta_inode(dentry) !=3D d_real_inode(dentry) to figure that out.

> +       printk(KERN_INFO "real: GID: %d  backing: GID: %d\n",
> +              from_kgid(&init_user_ns, d_real_inode(dentry)->i_gid),
> +              from_kgid(&init_user_ns, d_backing_inode(dentry)->i_gid));
> +
>
>  > so you cannot share the same logic with IMA cache invalidation.
>
> I thought we we would have to share the same logic since IMA and EVM
> would have to refer to the same inode also since IMA and EVM are
> strongly connected. So the file_inode(file), which is typically used for
> finding the iint, should be the same 'high level' inode for both EVM and
> IMA I thought. A different inode could then be used for file data and
> metadata.
>
> >
> > My patches are meant to provide you with a helper e.g. d_real_meta_inod=
e()
>
> The patch providing this isn't there yet in overlayfs-devel, right?

It's there just not spelled out with these helper names:

d_real_meta_inode(d) :=3D d_inode(d_real(dentry, false))
d_real_data_inode(d) :=3D d_inode(d_real(dentry, true))
d_real_inode(d) :=3D d_real_data_inode(d)

I think this use case is pretty specific to EVM, so I don't think
I will actually define these d_real_*_inode() helpers.

>
> > that you could use to get the upper inode in the case of a metacopy, bu=
t
> > IMA would still need to use the d_real_data_inode().
>
> That would be fine since we are only changing EVM code in this case.

Yes, using those overlayfs APIs requires understanding of what they mean
and knowing how to test the affected use cases.
This is not something very common for other subsystem developers.

> >
> > Is that explanation clear? Is it clear why I said that the problem is m=
ore
> > complicated?
>
> I think I understand it.
>

I think I am also starting to understand the expectation from IMA/EVM
over overlayfs ;)

Anyway, let me see if I can fix the problem in my WIP branch.

Thanks,
Amir.

