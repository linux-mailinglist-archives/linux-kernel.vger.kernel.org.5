Return-Path: <linux-kernel+bounces-46564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54884415B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15D21C20AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0082897;
	Wed, 31 Jan 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/Fbq7TT"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD28768F8;
	Wed, 31 Jan 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709979; cv=none; b=b58d/LQ6FexIkPlfKZJwpRz7ISFz3I2ft7aMDCBgGg8OVeYL8OFCC8dpDvRkVbtKf8NvvWPl3umALkaGcKjcCIppGt9IV0tcd9VDxCAgWn8YR5UcSuHL4nSXc8+93BJ3qEI7YahozRhzWDaYRkTxR4+EaeUj/X7gYsqtGUkXz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709979; c=relaxed/simple;
	bh=G0kyAZ0knYajTJWEvMpmTnJbQyeiZVah60Pu6fI4O6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUeeQiiqRtFY7zJwQi6LXP5PjWNx+5AW1CL3E9y4XP6/ZXP0YwIQfnyDnyvvXs0WGo2MkGaF1SmTcvgHOoyQIoVxOI8Ap35sEcqTvUrZklkYU0qWHQsa3IgZx2Dd6s8t8AEuLnj8xG78NIW9CC+dkzoCcYXYv7HGntfxKFTiSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/Fbq7TT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-686a92a8661so35939386d6.0;
        Wed, 31 Jan 2024 06:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706709976; x=1707314776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dkh36EExK6t1wawSJGvixoBnmXelA9dYFxogTrOyZY=;
        b=d/Fbq7TTAO8JtB9DsVf14MzVqsqhDpytGzsOUFfecRfmI6ugbl7xxLQTa27Hd1o2/A
         NIWVZAnx0/Tff3/7Cz71aJTuA7CA94sg7/oxESV7nbqSAamahkLr+tEB5Y40CXyKtTpA
         1qvxq22QJqQ//GXkixseBeJ7zQckwUMN1vl2eceNr5+UM55SKkVXLtFSqBmzh9ZApd5b
         YhSRs3HmDUh6wNVvHVuup2qtdWHJTqUjuQeUbN0AWDSPENFVF8/vL1AyJjm3YxIKUWzR
         0RLiW4oTsQTJY3yxaRoenrJNrZl2ezGMwX3kMNe+9JXnksq8gjL7tpxhu6ofL2Gr9hSW
         Dvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709976; x=1707314776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dkh36EExK6t1wawSJGvixoBnmXelA9dYFxogTrOyZY=;
        b=taChAQnWq4rc1EzD0Q8v6HBbhiZPiW7tv/GdaJZFP0zFpKJhVzGLjwsprilyosO530
         hPN+PFH+CMVMSzWhWX9M4s3U4LfqX79qZBzuqbMi+aw52y3Gnm8NCD3ilwcr2h57EXSd
         D+aVmNPVz/aCCQI90HarP4zyYTMcnY9+mf7+p1SxueHtUUltTjAfAKNrtZTbLZ7sB04m
         0faoT66z5UJzj8BaUnAKGIogFJ2lQzbEW++fPJq3Erfs5NPcC/ZzuVw0N5oTd2OqRt2F
         MZ+brOb13NfoSDhbYRRUlLDMkB6ECYwTmJFjmCJspRslbkWVI9DBHgPDdNx+4gLJ1S25
         T4Pw==
X-Gm-Message-State: AOJu0YxwbxTriJQ3Ht04Me85XwkWHAF4veinCtDWh3XE40iDkHks+Zuz
	yezvr7kv6LzsdQT4+TVHpKd8/mb0Lupx0ZRJ+HHwQ/5/xlf5PPugg4o2FA2Lmq+Yhg4BnQr5nce
	EMdsT18cKm2AD67GYJZptrHKJV5Y=
X-Google-Smtp-Source: AGHT+IGvoyXyWBOGOuWy9l4yzL1aHxWayBHJA5Zg4k30/AJq0lOWbGIwYNK0YOxDyEDVIJfCpXoUc2em7lfpAm1iLQg=
X-Received: by 2002:a05:6214:d6c:b0:68c:4f1c:d33b with SMTP id
 12-20020a0562140d6c00b0068c4f1cd33bmr2003556qvs.37.1706709976293; Wed, 31 Jan
 2024 06:06:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com> <20240130214620.3155380-6-stefanb@linux.ibm.com>
In-Reply-To: <20240130214620.3155380-6-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 16:06:05 +0200
Message-ID: <CAOQ4uxikngPf5t9zmJqV3SKkdmMm6ZwF095uoa6HLN-yAkdnSQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509
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
> Unsupported filesystems currently do not enforce any signatures. Add
> support for signature enforcement of the "original" and "portable &
> immutable" signatures when EVM_INIT_X509 is enabled.
>
> The "original" signature type contains filesystem specific metadata.
> Thus it cannot be copied up and verified. However with EVM_INIT_X509
> and EVM_ALLOW_METADATA_WRITES enabled, the "original" file signature
> may be written.
>
> When EVM_ALLOW_METADATA_WRITES is not set or once it is removed from
> /sys/kernel/security/evm by setting EVM_INIT_HMAC for example, it is not
> possible to write or remove xattrs on the overlay filesystem.
>
> This change still prevents EVM from writing HMAC signatures on
> unsupported filesystem when EVM_INIT_HMAC is enabled.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/evm/evm_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index e96d127b48a2..f49609dfcbc7 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -192,7 +192,11 @@ static enum integrity_status evm_verify_hmac(struct =
dentry *dentry,
>                      iint->evm_status =3D=3D INTEGRITY_PASS_IMMUTABLE))
>                 return iint->evm_status;
>
> -       if (is_unsupported_fs(dentry))
> +       /*
> +        * On unsupported filesystems with EVM_INIT_X509 not enabled, ski=
p
> +        * signature verification.
> +        */
> +       if (!(evm_initialized & EVM_INIT_X509) && is_unsupported_fs(dentr=
y))
>                 return INTEGRITY_UNKNOWN;
>

Are the names is_unsupported_fs() and SB_I_EVM_UNSUPPORTED still
a good description of what overlayfs is after this change?
Is EVM really not supported on overlayfs after this change?

Would you consider a better descriptive name, for the helper and flag,
at least as descriptive as SB_I_IMA_UNVERIFIABLE_SIGNATURE?

Thanks,
Amir.

