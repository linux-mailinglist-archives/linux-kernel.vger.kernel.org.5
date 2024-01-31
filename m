Return-Path: <linux-kernel+bounces-46498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEC844093
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F735291F46
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95DA7D414;
	Wed, 31 Jan 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFxo4WeY"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819527BAE5;
	Wed, 31 Jan 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707728; cv=none; b=OkQE91SKXwfsRjys6nqcm3ac3bf/nFa+gD2G9dXipvQAhDJBfMFxKHO/gpdZ15LBb/nG/do64oQl/+t99FqI7hdgYiEZXi72unRT0LZWnGOANVKOlb9UjlqspLUqbRBLJd3VYiirAJ8PEQGyAWCn7qF0ZeuKJW9IkbDkViMz+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707728; c=relaxed/simple;
	bh=lIBxN2xK0RgqTSCJuiuPNWVTJjAnTDXK2hhfs4E2yZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rflESknE1uzXpEtMAr1/q/OF6OEDBoPp3MEai9EA6B+PUdwBL3AGjq1MKKUignHXpRk+VkJv431ZfUXlWetOF/lDbkviq8P+5OixbI6hlWA9xsZT9SbjiBQv/Z8y355K64q6VY+iDj5Y74apm+IhIdv0C6v4ZFTb14Vqojy6cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFxo4WeY; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso5662021276.0;
        Wed, 31 Jan 2024 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707725; x=1707312525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CInWjVijKdpWX/OivLCS5uDZMBdRZrMOuy0NJJ7JN4A=;
        b=KFxo4WeYaGCLdceXsC8bKj6kQa2k5fNOZDX8MN11i6OAEOlnAG1EHMlFysz1cnFGB8
         E1CPVDd9u7yYtp52LFujb3+owCEY2n67dswnHtxFmSG7iM0Lb9w6h+X4QvYDQUqPpCRq
         qlFc1aACoYiP6qdUet0XdeCVZIqfOg7/fzNmKAnFe2GHqxMQXAi1HvJ1mlZqUGp5ZWWF
         vmQDrgxUfMkTUCcLf8nUuKk8h+Qq1vHLx2IWQvad4gklH0Ldx3OcPrqT9/LZrIvG8o5z
         2i4gV+YuRH+V1SANIMPMCCro+oUqWMqMKbejy8iFsmj2mXfpSqg10w10gdBUySaFlqQD
         NSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707725; x=1707312525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CInWjVijKdpWX/OivLCS5uDZMBdRZrMOuy0NJJ7JN4A=;
        b=N7Our5MU74tOZ3C46A5hCW2MLJYmT4cP+tBrJPnMkkMOCnyOGnFmSwt34gshD8Z2/Z
         ZEj8OWoNURnsK1SSdU/cVlKAqBghr3X9A6VYChfyb7a8BKf1XS6DGZH7Zhz5Vjovc93A
         lU8LbmiJl6yJXElk+g3II42WBJB+Be1KBcQx9oYkNO0xmbsw//EenZIfZU/p6jaLZAgu
         quQmH+xvPOMtGk5i+rm5lfmpFzN6ArulM4NiOVPvtv0cXygDSY4mXtxsaVb0sBpwnEK7
         h394qXtVTgnDWPhl4QY0E+o8TeuYM2PXnb4Fa3jT4rS2z1PbHrOV1Tmt4cIHKqZsoWna
         feQA==
X-Gm-Message-State: AOJu0YyUPtA7v30P+FRBEGYE5korAZ7szcXHwgHftI/dX0BDVezirwRf
	wyheHZqjxaWOBitJ7QxZeT5QOH5+p05ZGZC5WVfGCC7yNLLVzhNxz2sAXOQKrmllnk99iSxsZe4
	WXnQf+vVBHN8F/CiZb3900E0rP9g=
X-Google-Smtp-Source: AGHT+IHQ5iuyQY5XSK3G4YxpBh6+91uMY5iuz65wfOW2zqJxshNOPHiQuRLcLSvsDOY1vRbVwWod7Zc2dI96wgK4kwQ=
X-Received: by 2002:a25:dccc:0:b0:dc6:b7c4:3bb0 with SMTP id
 y195-20020a25dccc000000b00dc6b7c43bb0mr1352249ybe.27.1706707725398; Wed, 31
 Jan 2024 05:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com> <20240130214620.3155380-3-stefanb@linux.ibm.com>
In-Reply-To: <20240130214620.3155380-3-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 15:28:34 +0200
Message-ID: <CAOQ4uxhVmdWf+jwKg0bPcFf0VRRqpYg9m7yDavCk4cJ4fDg2zA@mail.gmail.com>
Subject: Re: [PATCH 2/5] evm: Implement per signature type decision in security_inode_copy_up_xattr
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:46=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
> To support portable and immutable signatures on otherwise unsupported
> filesystems, determine the EVM signature type by the content of a file's
> xattr. If the file has the appropriate signature then allow it to be
> copied up. All other signature types are discarded as before.
>
> Portable and immutable EVM signatures can be copied up by stacked file-
> system since the metadata their signature covers does not include file-
> system-specific data such as a file's inode number, generation, and UUID.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/evm/evm_main.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 2555aa4501ae..22a5e26860ea 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -898,9 +898,30 @@ void evm_inode_post_setattr(struct dentry *dentry, i=
nt ia_valid)
>
>  int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
>  {
> -       if (strcmp(name, XATTR_NAME_EVM) =3D=3D 0)
> -               return 1; /* Discard */
> -       return -EOPNOTSUPP;
> +       struct evm_ima_xattr_data *xattr_data =3D NULL;
> +       int rc;
> +
> +       if (strcmp(name, XATTR_NAME_EVM) !=3D 0)
> +               return -EOPNOTSUPP;
> +
> +       /* first need to know the sig type */
> +       rc =3D vfs_getxattr_alloc(&nop_mnt_idmap, src, XATTR_NAME_EVM,
> +                               (char **)&xattr_data, 0, GFP_NOFS);


See my suggestion for post-getxattr hook:
security_inode_copy_up_xattr(name, value, size)
to avoid using nop_mnt_idmap here.

Unless it is fine to use nop_mnt_idmap in this context? not sure.

Thanks,
Amir.

