Return-Path: <linux-kernel+bounces-55270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42884B9FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A69285957
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB16134742;
	Tue,  6 Feb 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRCQM48t"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98554130E30;
	Tue,  6 Feb 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234291; cv=none; b=eGSfhoNAakdEYC7ua9n8TTmA1LtIyBHwZUMiIf4qV0YuBQ3lJNZ659I1wvj3XpGjvH57MCJrt6NGW9+9iquqdq5T76NvCR0dPgKJ8UMiK6BACQrh0Dc0UVxT8OVBUMi3mv8Nvv05NNGU8bKOzFrYBMfuySnUrJagYafwxABnd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234291; c=relaxed/simple;
	bh=20rBJPvW0ki5HAC6tEqivD7tcdOAj9/l8qbYGLquaDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKMtpb+tryyRKdFrmgS0+nOOSoEYZFbYQ36TUB+E/k2WZTK+thT1zM8ujXOJdZOcjSFGApN8KWqnBKpcvgQ5F2bN4oBvkvXdU5NejiJk7GLxORWT9eGVUS+QaN7sJdNfxwWF9bVwI4z+o8Gxws8sfysCIDZ6kr4/+LRiBHW5W8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRCQM48t; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783d84ecb13so381046885a.0;
        Tue, 06 Feb 2024 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707234288; x=1707839088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEVnp7BLgdz+RNJeBn2lM+4rzpBiVnnsB0k+LnFpYpU=;
        b=IRCQM48ty4MBCmjDjx82DWUIKxjrqtgomAq3s5136xlI7gS30JcOSACVxZ3YlQgnlF
         Mkf0B7PyNjKTl7zCUaFv4xDi8nFJATl2RVad8ewUYcM/kRWJPkU/ugcD0RZAtTDsJymn
         PPaaMB2nH6JYW/EX8fWQdy3vQFVR66cazxtnIN57OYj2f6jKfsXwUieCYFWkBUD/7jmw
         UJaqL+n6D1A+TqIWd/CrfgqW5YGQcBUc2z71PmeqmvTw+aLJof0lvXaJy06Qww75a9J5
         uKrVOsmQMhRm1YdUK90uKa9aK+YGE5covZjWb+aDu6wJW4O0tGWHXz4zDHtJYZc9oN7Z
         rZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707234288; x=1707839088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEVnp7BLgdz+RNJeBn2lM+4rzpBiVnnsB0k+LnFpYpU=;
        b=wWuuq4aSp11AQWSFB3whFJSk8/UAHlf+htp1zA2SSQlFQ3LWDrmXckL6v3I7qQdOHF
         EOwt8fo51HPCvN7g07qj8G211E9wmmLx/k6+kgafOUF1zMorX6WsE0B2VhGHnx0Gtmnw
         7zonT94IS/xfyygyBvinCndxoDR+ObugBraJwZy5ipgSQv8EuhfIsovc89RiWMWy+G8K
         Kic7tgDx0pGKy/en9ksYuYb7SetmmRxvMq3lDpmfrLsIZ+ml1P1Nc7fFzN+/xpOqsy9F
         OxphXK9p3aAVwNy+C8+0LvN++sn2DPNe1ynfQZOtEk2lboSdlfrEQzzWYgB+jXPcRWcZ
         cs0A==
X-Gm-Message-State: AOJu0Yz4NKUNFG1tIxN17eMS9YSzyJeOOnOl/3vvykX9FcnTWWlldS4x
	8k7Cv0PJK9Xg5xt7NKUYDggMXvGb+YQY/IuILgU6+kGz4gjDXThqAdLq4AY831pWqTcnoLAGmkL
	TlRB2YvUjOeO8qWFgnhHzEdu/QMA=
X-Google-Smtp-Source: AGHT+IHQ1TtI2QK5lG3OHm5V73qLiLrvk3UwD4oZu4jitN1NzNMsx7OkSmGjv9Y0dzJ8/ZezqimM9yvvnIisMRx8BTI=
X-Received: by 2002:ad4:5d67:0:b0:68c:3df9:c3c9 with SMTP id
 fn7-20020ad45d67000000b0068c3df9c3c9mr2955221qvb.2.1707234288358; Tue, 06 Feb
 2024 07:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-5-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-5-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:44:36 +0200
Message-ID: <CAOQ4uxgbURYypK1Ycib8ojrRvZGtQYBMF6CwY86DDSWqMVHW2Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] ima: Reset EVM status upon detecting changes to
 the real file
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, brauner@kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
> Piggyback the resetting of EVM status on IMA's file content detection tha=
t
> is triggered when a not-yet-copied-up file on the 'lower' layer was
> changed. However, since EVM only cares about changes to the file metadata=
,
> only reset the EVM status if the 'lower' layer file is also the one holdi=
ng
> the file metadata.
>
> Note that in the case of a stacked filesystem (e.g., overlayfs) the iint
> represents the file_inode() of a file on the overlay layer. The data in
> the in iint must help detect file content (IMA) and file metadata (EVM)
> changes occurring on the lower layer for as long as the content or
> metadata have not been copied up yet. After copy-up the iit must continue
> detecting them on the overlay layer.
>
> Changes to the file metadata on the overlay layer are causing an EVM
> status reset through existing evm_inode_post_sattr/setxattr/removexattr
> functions *if* an iint for a file exist. An iint exists if the file is
> 'in (IMA) policy', meaning that IMA created an iint for the file's inode
> since the file is covered by the IMA policy.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/evm.h               | 8 ++++++++
>  security/integrity/evm/evm_main.c | 7 +++++++
>  security/integrity/ima/ima_main.c | 5 +++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 840ffbdc2860..eade9fff7d0b 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -66,6 +66,8 @@ extern int evm_protected_xattr_if_enabled(const char *r=
eq_xattr_name);
>  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>                                      int buffer_size, char type,
>                                      bool canonical_fmt);
> +extern void evm_reset_cache_status(struct dentry *dentry,
> +                                  struct integrity_iint_cache *iint);
>  #ifdef CONFIG_FS_POSIX_ACL
>  extern int posix_xattr_acl(const char *xattrname);
>  #else
> @@ -190,5 +192,11 @@ static inline int evm_read_protected_xattrs(struct d=
entry *dentry, u8 *buffer,
>         return -EOPNOTSUPP;
>  }
>
> +static inline void evm_reset_cache_status(struct dentry *dentry,
> +                                         struct integrity_iint_cache *ii=
nt)
> +{
> +       return;
> +}
> +
>  #endif /* CONFIG_EVM */
>  #endif /* LINUX_EVM_H */
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 565c36471408..81c94967f136 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -721,6 +721,13 @@ static void evm_reset_status(struct inode *inode)
>                 iint->evm_status =3D INTEGRITY_UNKNOWN;
>  }
>
> +void evm_reset_cache_status(struct dentry *dentry,
> +                           struct integrity_iint_cache *iint)
> +{
> +       if (d_real_inode(dentry) !=3D d_backing_inode(dentry))

Is this really needed?
You get here after checking (real_inode !=3D inode) already

> +               iint->evm_status =3D INTEGRITY_UNKNOWN;
> +}
> +
>  /**
>   * evm_revalidate_status - report whether EVM status re-validation is ne=
cessary
>   * @xattr_name: pointer to the affected extended attribute name
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index f1a01d32b92a..b6ba829c4e67 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -26,6 +26,7 @@
>  #include <linux/ima.h>
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
> +#include <linux/evm.h>
>
>  #include "ima.h"
>
> @@ -297,6 +298,10 @@ static int process_measurement(struct file *file, co=
nst struct cred *cred,
>                     !inode_eq_iversion(real_inode, iint->version)) {
>                         iint->flags &=3D ~IMA_DONE_MASK;
>                         iint->measured_pcrs =3D 0;
> +
> +                       if (real_inode =3D=3D d_inode(d_real(file_dentry(=
file),
> +                                                        D_REAL_METADATA)=
))
> +                               evm_reset_cache_status(file_dentry(file),=
 iint);

Technically, you'd also need to store iint->real_meta_{dev,ino}
when calculating EVM to be sure if the metadata inode had changed,
because there is a possibility that file was not copied up yet, but the fil=
e
is a metacopy in a middle layer and the lower data is in another layer.

Think file metadata was copied from lower to upper layer, then the
upper layer was made a middle layer and another upper layer added
on top of it.

In this situation, real_inode is in the lower layer, real_meta_inode is in
the middle layer and after copy up of metadata, real_meta_inode will
become in the upper layer.

Not sure if this use case is interesting to EVM.

Thanks,
Amir.

