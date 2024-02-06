Return-Path: <linux-kernel+bounces-55284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223584BA39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B321F271AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A8134CE4;
	Tue,  6 Feb 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N65wTlj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A3134721;
	Tue,  6 Feb 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234892; cv=none; b=TAK3noGrxW47tEAQS474/WL5PgM0QMzZpAdsBZFVq6NqFmvvsXyd6iIiv709YtWTeCO2ZHgfGZVN8sh9qOg+qcs+1cVA8UZmLK+GlVa7eUXlaLMPZXSRFgQw+RY9wQFb0ElArum/Lyp11BwWy3zmOGjeZyl4iLX/gHVL8XE9T+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234892; c=relaxed/simple;
	bh=JzUN8NRfEN8J79MKketfCz33yTukYvRMzD5SnRIwdf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/ITP0pryQy7fNpxOtVKZE83cBocSY6RJWd2BZf/4vzxDcgO8CADkZ18VGEYL/LVJVNUYfSeTj2vGb94pyngAq3vaIY97O5pDYwflFbwz2tUAGpHii4MQO1jmEPFj1UMAz52nF3yqO2V8R5ARwZCtytwI9Q9ea30trznhIxvF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N65wTlj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D579AC433C7;
	Tue,  6 Feb 2024 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707234892;
	bh=JzUN8NRfEN8J79MKketfCz33yTukYvRMzD5SnRIwdf8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N65wTlj5j/CVPuYM6+9wagicwPDMPhG1QVmDYuhaNv237wZB/x11+EQay27cfujQ3
	 np2usMDhFqQp21CBSFwoVnJSzp8xqb/jur4fv2dHluNKvmzrLJ5W+KcSJTEyvnoaE6
	 JAQEyRMamjkMGw7qxrYbajssAuoS7aVArHSCdTmGWE8zhYppcPAMlcjdNSfWkctPY0
	 szf1GkDjJSMipS1jKhzsVb3EZaGzD0jBejM5WRVsgQM3U9te5duKwC5ESrGeUZXZ28
	 X1jdOhk7lkOMPbL/jLImyXiuM43Bjp8/nJcP/eEyrDdO+wMYKHREHPfy6hQdthFBjp
	 vQEuDC3MJif2Q==
Message-ID: <754c1617c27660eff17bc0d7f4921c59d2471603.camel@kernel.org>
Subject: Re: [PATCH v2 9/9] ima: Record i_version of real_inode for change
 detection
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Stefan Berger
 <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, roberto.sassu@huawei.com,  brauner@kernel.org,
 miklos@szeredi.hu
Date: Tue, 06 Feb 2024 10:54:49 -0500
In-Reply-To: <CAOQ4uxhQgCqNZ_4Dy1PghCHBg7H4qaf-st2pWhXe9eq1+dsHHA@mail.gmail.com>
References: <20240205182506.3569743-1-stefanb@linux.ibm.com>
	 <20240205182506.3569743-10-stefanb@linux.ibm.com>
	 <CAOQ4uxhQgCqNZ_4Dy1PghCHBg7H4qaf-st2pWhXe9eq1+dsHHA@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 17:23 +0200, Amir Goldstein wrote:
> On Mon, Feb 5, 2024 at 8:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
> >=20
> > process_measurement() will try to detect file content changes for not-y=
et-
> > copied-up files on a stacked filesystem based on the i_version number o=
f
> > the real inode: !inode_eq_iversion(real_inode, iint->version)
> > Therefore, take a snapshot of the i_version of the real file to be used
> > for i_version number-based file content change detection by IMA in
> > process_meassurements().
> >=20
> > In this case vfs_getattr_nosec() cannot be used since it will return th=
e
> > i_version number of the file on the overlay layer which will trigger mo=
re
> > iint resets in process_measurements() than necessary since this i_versi=
on
> > number represents different state than that of the real_inode (of a
> > not-yet-copied up file).
> >=20
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_api.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/=
ima_api.c
> > index 597ea0c4d72f..530888cc481e 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/xattr.h>
> >  #include <linux/evm.h>
> >  #include <linux/fsverity.h>
> > +#include <linux/iversion.h>
> >=20
> >  #include "ima.h"
> >=20
> > @@ -250,7 +251,6 @@ int ima_collect_measurement(struct integrity_iint_c=
ache *iint,
> >         int result =3D 0;
> >         int length;
> >         void *tmpbuf;
> > -       u64 i_version =3D 0;
> >=20
> >         /*
> >          * Always collect the modsig, because IMA might have already co=
llected
> > @@ -263,16 +263,6 @@ int ima_collect_measurement(struct integrity_iint_=
cache *iint,
> >         if (iint->flags & IMA_COLLECTED)
> >                 goto out;
> >=20
> > -       /*
> > -        * Detecting file change is based on i_version. On filesystems
> > -        * which do not support i_version, support was originally limit=
ed
> > -        * to an initial measurement/appraisal/audit, but was modified =
to
> > -        * assume the file changed.
> > -        */
> > -       result =3D vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE=
_COOKIE,
> > -                                  AT_STATX_SYNC_AS_STAT);
> > -       if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> > -               i_version =3D stat.change_cookie;
> >         hash.hdr.algo =3D algo;
> >         hash.hdr.length =3D hash_digest_size[algo];
> >=20
> > @@ -302,10 +292,22 @@ int ima_collect_measurement(struct integrity_iint=
_cache *iint,
> >=20
> >         iint->ima_hash =3D tmpbuf;
> >         memcpy(iint->ima_hash, &hash, length);
> > -       iint->version =3D i_version;
> > -       if (real_inode !=3D inode) {
> > +       if (real_inode =3D=3D inode) {
> > +               /*
> > +                * Detecting file change is based on i_version. On file=
systems
> > +                * which do not support i_version, support was original=
ly limited
> > +                * to an initial measurement/appraisal/audit, but was m=
odified to
> > +                * assume the file changed.
> > +                */
> > +               result =3D vfs_getattr_nosec(&file->f_path, &stat,
> > +                                          STATX_CHANGE_COOKIE,
> > +                                          AT_STATX_SYNC_AS_STAT);
> > +               if (!result && (stat.result_mask & STATX_CHANGE_COOKIE)=
)
> > +                       iint->version =3D stat.change_cookie;
> > +       } else {
> >                 iint->real_ino =3D real_inode->i_ino;
> >                 iint->real_dev =3D real_inode->i_sb->s_dev;
> > +               iint->version =3D inode_query_iversion(real_inode);

You only want to do this if IS_I_VERSION(inode) is true. If the
underlying filesystem is doing its own thing wrt the i_version field,
calling inode_query_iversion on it may corrupt it.


> >         }
> >=20
>=20
> The commit that removed inode_query_iversion db1d1e8b9867 ("IMA: use
> vfs_getattr_nosec to get the i_version") claimed to do that because
> inode_query_iversion() did not work in overlayfs and now this commit
> uses inode_query_iversion() only for overlayfs.
>=20
> STATX_CHANGE_COOKIE does not seem to make much sense in this
> code anymore, unless it is still needed, according to original commit to
> "allow IMA to work properly with a broader class of filesystems in the fu=
ture."

I don't have a real opinion here. When I did the original patch that
switched this over to to use vfs_getattr_nosec, I didn't consider that
it could end up being called from an atomic context. Reverting that
seems like the correct thing to do if it's still broken.

If you're fine with this only working on a subset of local filesystems,
then doing something like this is probably fine:

	if (IS_I_VERSION(real_inode))
		iint->version =3D inode_query_iversion(real_inode);

..but it's not clear to me what you should do if IS_I_VERSION is false.
I guess IMA just falls back to checking the ctime in that case?
--=20
Jeff Layton <jlayton@kernel.org>

