Return-Path: <linux-kernel+bounces-46899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD67F844604
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12501C24F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017612CDBF;
	Wed, 31 Jan 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdAm8kY9"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0512BF33;
	Wed, 31 Jan 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721798; cv=none; b=aH09npHOz75V07Jz8NBqUYH1IfwQVb5q2FUWWJlKWvFRq4nh2MGDG/dTsPNHNTK/AeDQ6kIh5kn3YNC8XqTg+fkiyA+3FiSBCq/wvrdOuJX4mmTY8R5fXD2ybSP5EWDg7ka0wHmcP9hzjipTRm2bKmv8L8BaTxmgjIS4X0vb4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721798; c=relaxed/simple;
	bh=UD8alDMIQlpaZZWNT9SXOnDno797CsiHPwOuAnLgCOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuCnT8qSNyJTWh7dy39ijogeiHvR6yjQADfVQI6G7w2/MEr5ecc4iLC01fMkkpXclW75wvNC1ewFEmOVpztMe1FlvCvGrkAy5lI9zr1OsHsfXFa08q2DVLE4tqqBRSywmZBXfAUoS1lxiA1EFKM2hJ/t/sT8nh6gnl6pfL6S4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdAm8kY9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68c444f9272so89546d6.3;
        Wed, 31 Jan 2024 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706721796; x=1707326596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKF9b5jRXHNEzHTqMQ0qJvRi4sqUsnU773XWw1XdDnk=;
        b=GdAm8kY9sfDSmXI5SVGhDGvIsXFUw/6x8pOP7sX8aaECvdNuA2ywqvP5TKCk0O53vc
         mSdn4qWxGqURcJ0wKcBWpqEsX/TSGsjUaB2U8riyG4uh7+TNzoVrSs4qt/636NcZgaIq
         631hUNGCCO//PPQ+MW7wYeewqd7WfD4n8FKWAN2pQIH+1T27m29uPt5Pqpt9t7A9Ftug
         bBPMez0+bnu74OVetxEiNsUnd98iJ3+Y+AVQYr3FLuli2J7ndB+zCQy1ASNocz25dvdR
         jL4phcCYxBVm+zDS5kyUn5uQlR41L0uPTSDe8SBh/M9TWwAoi56NlPlWx6S3HtObDAm6
         T1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721796; x=1707326596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKF9b5jRXHNEzHTqMQ0qJvRi4sqUsnU773XWw1XdDnk=;
        b=NSY0dRtniAQoUSELePEJlqQv41P3V/TafrqqmSj053dYad1bO2cLV7ssCCPqfNfNCv
         eTdC6KArYr6zhvLcEnwEpH4rjtuRyn3hMn2J6E++COL8NHKbUf+lATQb1bGGQCgb/jZl
         XFE7EkLZajhhf9voY4xA9ce6Q8jjEffOFZcY33PkMmxc8HDamCTggj7DIqGmEjo8Xl92
         qGm3CZUWAiXtiVyMtTx94pWzi18P7uWhvi8P85ljkQioKXhx1jtYwpjNGXJTrYhY+STy
         NVn93S/LoDnll5ofZfVfPi019kndvvvGX+bQ0cgqMTGgUoLCRy4Oy3CUvpvyzOL5v6M1
         SgyQ==
X-Gm-Message-State: AOJu0YyjafEttIis0nO6rTA7oBJVHV4vobLIhvaIdhNBuKDvEMHY/Yof
	59hCf2BkkXcXdAwHkJIPOVPZrI2hoC3+02fOGH4K02xUX3PANXirJhtfjUyE1X/xbetYkB/iEjk
	HMkvwZA2slgQXzVjiDnxWWAbWwFc=
X-Google-Smtp-Source: AGHT+IFGzRvLypDQQEjuxmXgUE4sevR6zn+YkmLLpDLWOlGJnlhYKNxFYU5S4KD85zT0SYNvZrIll0zEBmKhE/kfAOU=
X-Received: by 2002:a05:6214:21ec:b0:685:5dc8:ec9b with SMTP id
 p12-20020a05621421ec00b006855dc8ec9bmr2114438qvj.25.1706721795889; Wed, 31
 Jan 2024 09:23:15 -0800 (PST)
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
In-Reply-To: <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 19:23:03 +0200
Message-ID: <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:54=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Jan 31, 2024 at 4:40=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.=
com> wrote:
> >
> >
> >
> > On 1/31/24 08:16, Amir Goldstein wrote:
> > > On Wed, Jan 31, 2024 at 4:11=E2=80=AFAM Stefan Berger <stefanb@linux.=
ibm.com> wrote:
> > >>
> > >>
> > >>
> > >> On 1/30/24 16:46, Stefan Berger wrote:
> > >>> Changes to the file attribute (mode bits, uid, gid) on the lower la=
yer
> > >>> are not take into account when d_backing_inode() is used when a fil=
e is
> > >>> accessed on the overlay layer and this file has not yet been copied=
 up.
> > >>> This is because d_backing_inode() does not return the real inode of=
 the
> > >>> lower layer but instead returns the backing inode which holds old f=
ile
> > >>> attributes. When the old file attributes are used for calculating t=
he
> > >>> metadata hash then the expected hash is calculated and the file the=
n
> > >>> mistakenly passes signature verification. Therefore, use d_real_ino=
de()
> > >>> which returns the inode of the lower layer for as long as the file =
has
> > >>> not been copied up and returns the upper layer's inode otherwise.
> > >>>
> > >>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > >>> ---
> > >>>    security/integrity/evm/evm_crypto.c | 2 +-
> > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integri=
ty/evm/evm_crypto.c
> > >>> index b1ffd4cc0b44..2e48fe54e899 100644
> > >>> --- a/security/integrity/evm/evm_crypto.c
> > >>> +++ b/security/integrity/evm/evm_crypto.c
> > >>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry =
*dentry,
> > >>>                                 size_t req_xattr_value_len,
> > >>>                                 uint8_t type, struct evm_digest *da=
ta)
> > >>>    {
> > >>> -     struct inode *inode =3D d_backing_inode(dentry);
> > >>> +     struct inode *inode =3D d_real_inode(dentry);
> > >>>        struct xattr_list *xattr;
> > >>>        struct shash_desc *desc;
> > >>>        size_t xattr_size =3D 0;
> > >>
> > >> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY bu=
t
> > >> when setting CONFIG_OVERLAY_FS_METACOPY=3Dy it has to be reverted...=
  I am
> > >> not sure what the solution is.
> > >
> > > I think d_real_inode() does not work correctly for all its current us=
ers for
> > > a metacopy file.
> > >
> > > I think the solution is to change d_real_inode() to return the data i=
node
> > > and add another helper to get the metadata inode if needed.
> > > I will post some patches for it.
> >
> > I thought that we may have to go through vfs_getattr() but even better
> > if we don't because we don't have the file *file anywhere 'near'.
> >
> > >
> > > However, I must say that I do not know if evm_calc_hmac_or_hash()
> > > needs the lower data inode, the upper metadata inode or both.
> >
> > What it needs are data structures with mode bits, uid, and gid that sta=
t
> > in userspace would show.
> >
> >
>
> With or without metacopy enabled, an overlay inode st_uid st_gid st_mode
> are always taken from the upper most inode which is what d_real_inode()
> currently returns, so I do not understand what the problem is.
>

No, I was wrong. It is the other way around.
d_real_inode() always returns the real data inode and you need the
upper most real inode.

You can try this:

 -     struct inode *inode =3D d_backing_inode(dentry);
+     struct inode *inode =3D d_inode(d_real(dentry, false));

With the changes in:

https://github.com/amir73il/linux/commits/overlayfs-devel/

Not thoroughly tested...

Thanks,
Amir.

