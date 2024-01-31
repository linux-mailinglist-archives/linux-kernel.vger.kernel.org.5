Return-Path: <linux-kernel+bounces-46476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFD844045
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C0C1F26FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507C7BAEC;
	Wed, 31 Jan 2024 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVEQGekf"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1D7866D;
	Wed, 31 Jan 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706987; cv=none; b=XRQFMK9/4bWMaY9Oy79HghU2/XjsVdJ+087askYJQIa02oYEjR6yKqH86KKngvu4XEVquI5CJnQN1OpawlZy9PSC7KVVSh4FZu9Eu2it7MZ52rQ/t84msoN0K6o7jQeYrG3u1E97qfW5epPxmQzdjZ7wnODgNxKG2UkxuN1JgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706987; c=relaxed/simple;
	bh=jbMaNkr1bTYPXRhgukPeSj3N79rSuP6MAAxEWCK1YVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is8o/9lviSwbzqtfgG4dnEhS1kCjilXqRxQcGrBlaN0GCko4KCYcvYjDAzh3R5tgZiwJjJDAMflln85ExHvkCTqY8RvNBGGunhkZ2TAhOl7SljCp7Acid0f8+7auAqJanPqBDOG6WWW0uVKfDmkt3tRcXL4Es5384Ukuq8LdHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVEQGekf; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6818aa07d81so34218806d6.0;
        Wed, 31 Jan 2024 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706706985; x=1707311785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VH5uYYk0MxykRHzUiex1lRzuDUS57P3V7ajJDCHXAY=;
        b=OVEQGekfW7/MJyOEPRuv2/wPWAzHKFX0hVRfXqfdWDeF6Zgf1vLIKWYTLWtCDVspBS
         msjhaAagh4j8ZRmc991tbrgjeIjVLwaflv4OBGWZCWMhTCN2EyMOKxXfn41sbh02nR4W
         CxGvBCrpRi73M6tHx+2b7/2SLngUZMXgXPxttZLYSYxul5U9C8Ar/f+7JpmGjuUoTTvb
         ERkMj+aoL0YFqJQfhnQ6aozW2MQn8prtAL1fy1Zz1l/5pDLpFwQWDOmAvA/yk0OflT2V
         g6JrblnYPJAux2wR9CJrAx/AKOMDp5/FCmvjYV6NijUz/DAX7TWl9Jgo7uMXcM1dFIgz
         SRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706985; x=1707311785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VH5uYYk0MxykRHzUiex1lRzuDUS57P3V7ajJDCHXAY=;
        b=KyHcs7kKDzlG/Rak2/2+XekY/GrBwjTz/yBjmvZc/eyA/mQMFGM29OTwdAlNFnoZd6
         OPLnFSGCUawRLVy/r+cBdksq+Irlo7EdHlAvz9mUdApxNPGOk426ZTEa2zWqBLPeuMlC
         hLzoMHavp+CrrhEHjgHlF7igbXQCD1xZ4TT69e4jXmqHzuNCMrVacCIWfwEuL/vrNZ/s
         snx6wgOe6Nrm1ofOjDklHGE8+jIahzOuRxhhb0LXkJ3Z3qv/zCuj4w7Wl/3Z1ST/LyaA
         K4wjIYpfeRVnPMyPwTB8jaDtkossgdYio3qHSv1g+2gEAGNIHiFv/+G63OdUUX9PYRa5
         Vvpw==
X-Gm-Message-State: AOJu0YxBT7TtNGKLwDmwuu68jXY22+arbnhC/5xBrKELVs8bqJ79jgkG
	69boJ5uXWgLubBPjakZ4FGmcdNuOrAT+ViKxrq5SxuBibqpo0UpwrhmzJHAkeCmP06LjC0/q6OJ
	F8Nrj29o4L8IQAbHXPYF6zJaXIWXv8GnSOSg=
X-Google-Smtp-Source: AGHT+IH0ikF6yoZwytwWB7RZWy0RSBrrB+eLztoCMsKSE9pSBTVUmsNiaZ3Q0DiJ/Pf8yrIq+7n4meL7OwNYLVbhNf0=
X-Received: by 2002:ad4:5ce9:0:b0:686:7256:c9f4 with SMTP id
 iv9-20020ad45ce9000000b006867256c9f4mr1663225qvb.9.1706706985131; Wed, 31 Jan
 2024 05:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com> <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
In-Reply-To: <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 15:16:13 +0200
Message-ID: <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:11=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 1/30/24 16:46, Stefan Berger wrote:
> > Changes to the file attribute (mode bits, uid, gid) on the lower layer
> > are not take into account when d_backing_inode() is used when a file is
> > accessed on the overlay layer and this file has not yet been copied up.
> > This is because d_backing_inode() does not return the real inode of the
> > lower layer but instead returns the backing inode which holds old file
> > attributes. When the old file attributes are used for calculating the
> > metadata hash then the expected hash is calculated and the file then
> > mistakenly passes signature verification. Therefore, use d_real_inode()
> > which returns the inode of the lower layer for as long as the file has
> > not been copied up and returns the upper layer's inode otherwise.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >   security/integrity/evm/evm_crypto.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/e=
vm/evm_crypto.c
> > index b1ffd4cc0b44..2e48fe54e899 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
> >                                size_t req_xattr_value_len,
> >                                uint8_t type, struct evm_digest *data)
> >   {
> > -     struct inode *inode =3D d_backing_inode(dentry);
> > +     struct inode *inode =3D d_real_inode(dentry);
> >       struct xattr_list *xattr;
> >       struct shash_desc *desc;
> >       size_t xattr_size =3D 0;
>
> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY but
> when setting CONFIG_OVERLAY_FS_METACOPY=3Dy it has to be reverted...  I a=
m
> not sure what the solution is.

I think d_real_inode() does not work correctly for all its current users fo=
r
a metacopy file.

I think the solution is to change d_real_inode() to return the data inode
and add another helper to get the metadata inode if needed.
I will post some patches for it.

However, I must say that I do not know if evm_calc_hmac_or_hash()
needs the lower data inode, the upper metadata inode or both.

The last time you tried to fix ovl+IMA, I asked for documentation
of what data/metadata is protected with EVM and how are those
protections supposed to work across overlayfs copy up, when the
data and metadata are often split between 2 and myabe event 3
differnt inode.

From the current patch set, I still don't understand what is the expected
behavior before and after copy up of data/metadata-only.

Thanks,
Amir.

