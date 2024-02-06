Return-Path: <linux-kernel+bounces-55205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4453184B91F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012F628F868
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F22713A24A;
	Tue,  6 Feb 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwgtWICZ"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5001350DE;
	Tue,  6 Feb 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232301; cv=none; b=jGBbQSfVcnFxH5ANmuOplpNwZGUwLr8dkNlzX01iZv8HJFnC0rIBS8KkyhAvwMy6pf27E/WHMlRPnZMi9R2XUvoptAcKHpR7aF/4w/6lkarScEE3tzzZ+xCIcq8j9M+ElGMB3G1cnRmJOrNqFNsjsCuf86T4lFoFcw/tN1wCeOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232301; c=relaxed/simple;
	bh=kfaxoQeNpM0J7vzhMmPAFIpiSCm9y9dHMnMLrGb5m+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ghc5FTZV7My1n6paG1Dvavkn7+JtIAW3tgmeZ7XhgeKEtkIa9PW1NHcmbYjZshBy4XAWmNDLYhIKwaMZ4hVysKaqDK657T9y0CV+hEHodXnUU/FNYbziFui1y/NRBXji9LvoVF9P/JLLSX69bKFai1PYDimCQa7IDnUGDqkREA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwgtWICZ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2185d368211so2878457fac.3;
        Tue, 06 Feb 2024 07:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707232299; x=1707837099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7m3nN4KaHdD/C3S03al8GMlkoTP/nChFRL53bv18L8=;
        b=DwgtWICZRF0WDR5aYRfPQCwqE0J579IkYjqknrPt0TWJdQj4/NRUq3Hc+xboqIWadH
         pHAtyqwVqVIExXMA0PSmbQA3jG+WvArafr9qni3sTyvbZ7XMeG9uG5iE6JhRxXaeyx3U
         l5yzIGlpsJFst1mY5OQRfFzmUB4WdimC8h3r38fHfm6U1Zj2Vc1G3Idj3dy6NJq9Zw7w
         p3RRlfb5TOAr6AT4QemTw4e0b38v7bBOfRuOpYLSXfMwbdrHqocDMuaRDF8CGoNiZRhi
         K5DoL57fpaUUydSunN/TSbYD3pbv03r/l5CskFOHIth2XHYSUTTCAmJr8i5mxxDtHqoZ
         VDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232299; x=1707837099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7m3nN4KaHdD/C3S03al8GMlkoTP/nChFRL53bv18L8=;
        b=ThtfG4Qd06SidGPFiA8QUFkbnmMmspusnPKXhJWbxTSG1Ls9myVPeaMvlsA8GmYC7Q
         AKs9N1JCd6GU9TxTSV2H15zaGh9BXfdqCZTd938k88KpeR+qHLjDCmwxM+hi5rDOoani
         N0Msd3kIngIw/Dhdt8KMnnrCSPXTgqDd6zqoRqAmJyi63CX8au04UfFhYk/cSEgOmKIN
         6EKkMbGEwPMDAbLRwYOXpeNKMZGbFjtv3aOs4HiESgSsbsXsvNNvmvl2g6h0zDjeDA0F
         s4RhvT6OED8Inx0HHYGVGeyo2V8QeUM3C6SEBSgCzdhX/BtOVRxzxTNpFTYb7p+aNg0h
         fu3A==
X-Gm-Message-State: AOJu0YwgK5WgXJkOVQb1ZbOes15SBmHsCZI/ZPQ+KKLGW43jkMIW3Ir6
	QAdTd5H5sX7GKssthEpTipBEmLOBEtfEBsRSd+PstspFtZgOj1IUPGrL+vMMuy/98WHZ3HjfAH5
	4889dn+PtKFC7hsNQYZMTPF5pfY0=
X-Google-Smtp-Source: AGHT+IFNScXBAMLrh/yGM17A4GNHZl8dQGspF49hLjDE1iYzOhRUEUmY+/RycFhZ6yr0/xr6ujyLAw9TigmODs0sPb4=
X-Received: by 2002:a05:6871:5813:b0:219:9253:e5aa with SMTP id
 oj19-20020a056871581300b002199253e5aamr3318308oac.8.1707232299128; Tue, 06
 Feb 2024 07:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-8-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-8-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:11:28 +0200
Message-ID: <CAOQ4uxj0jQz64KArFM3q85N7QKPgJ1RazmeW2NnY6GFDace4Qg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] fs: Rename SB_I_EVM_UNSUPPORTED to SB_I_EVM_HMAC_UNSUPPORTED
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
> Now that EVM supports RSA signatures for previously completely
> unsupported filesystems rename the flag SB_I_EVM_UNSUPPORTED to
> SB_I_EVM_HMAC_UNSUPPORTED to reflect that only HMAC is not supported.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c              | 2 +-
>  include/linux/fs.h                | 2 +-
>  security/integrity/evm/evm_main.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 460126b7e1cd..db132d437e14 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1445,7 +1445,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>          * lead to unexpected results.
>          */
>         sb->s_iflags |=3D SB_I_NOUMASK;
> -       sb->s_iflags |=3D SB_I_EVM_UNSUPPORTED;
> +       sb->s_iflags |=3D SB_I_EVM_HMAC_UNSUPPORTED;
>
>         err =3D -ENOMEM;
>         root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1823a93202bd..37306a09b4dc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1177,7 +1177,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_I_USERNS_VISIBLE            0x00000010 /* fstype already moun=
ted */
>  #define SB_I_IMA_UNVERIFIABLE_SIGNATURE        0x00000020
>  #define SB_I_UNTRUSTED_MOUNTER         0x00000040
> -#define SB_I_EVM_UNSUPPORTED           0x00000080
> +#define SB_I_EVM_HMAC_UNSUPPORTED      0x00000080
>
>  #define SB_I_SKIP_SYNC 0x00000100      /* Skip superblock at global sync=
 */
>  #define SB_I_PERSB_BDI 0x00000200      /* has a per-sb bdi */
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index c3bd88aba78c..ff659e622f4a 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -155,7 +155,7 @@ static int is_unsupported_fs(struct dentry *dentry)
>  {
>         struct inode *inode =3D d_backing_inode(dentry);
>
> -       if (inode->i_sb->s_iflags & SB_I_EVM_UNSUPPORTED) {
> +       if (inode->i_sb->s_iflags & SB_I_EVM_HMAC_UNSUPPORTED) {
>                 pr_info_once("%s not supported\n", inode->i_sb->s_type->n=
ame);
>                 return 1;
>         }
> --
> 2.43.0
>

