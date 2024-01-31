Return-Path: <linux-kernel+bounces-47059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEA8448B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D9B1C23151
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C543FE47;
	Wed, 31 Jan 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4hzoWcK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3F3FB39;
	Wed, 31 Jan 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732452; cv=none; b=Vt6B3ueld0QRLyn8pYYehEntTb0bI5MoIxSv7WVrVfcCMeut7NaQls0Fpw5cppr+5EC3O6ZMeNVyz+3z+6A2tzZkYsnUgISGJ8HTyqBmJKATRz6NEFX21hfzqXwAc+lQRyuUCl5Lw+uVujHSGablcsMLgNGmlBUPJJosYzNdYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732452; c=relaxed/simple;
	bh=jZewVfEeg5K9SkK5UySM3h5rrkjoCak4+ZjrIOKh0cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KN7VmHDqS7RRXXP06hpsEcJRuqz3ffnxt3Z0Xh/LhIwai37jJkB2GQ4qg9xzx/jpgr1OwilpDu7/7PSH/4Sh8BiZpxv88UA/JI7OOpGjTTzuThN+QK/Blev9ZlZoPxMiX5paLN0v2JVCZ+PeAx1LfGSRDSJIBpSG7FEnKrvnKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4hzoWcK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5111e5e4e2bso183676e87.3;
        Wed, 31 Jan 2024 12:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706732448; x=1707337248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeIsgl8+EFYn5S6ni1qvspvfCQnicxx3gHZ+U13Srac=;
        b=R4hzoWcKKoyTVosqeyrKm3ShYUvpt+koT41ICXht4vNEVDg46l3YUjETZsZpOR+BIM
         fjF3ZC/ceyDAucyBmqRYchkVLN/mgp7EaAEL/dz4S7qI4kAMbcd9VydRid9SGx7/5nis
         A4AoIUqraeJ4X6AJFOAU0rFnc2Y/Hf/0FY+FTQKmjn0R082NY1M0H+RW3OCldbbWWyjl
         /ly8DfLUsFrw81nkN3QrV8klBn4VdP//YVp3vA9Proy05Y+OBADBlbka9N8i9qTZ22Jp
         hGk2iItKNfmZ86z3Zlf+qRHAaznfhz7RkiyI5uwR+87o1vyMbiF6QhHo+cskodpSXoA3
         Xz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732448; x=1707337248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeIsgl8+EFYn5S6ni1qvspvfCQnicxx3gHZ+U13Srac=;
        b=sCuhjgzO8h/Lx2xvdOYqWDk/WlWQB1sGRBiH3om4B3gxVNEo92ZXkJ1Rz96W5fAdTe
         XvWEH6+CUMtn9WUMC2JD5hGihTt7xLENYZTvgi68IGZcPoM1WkJn2G3EY2t5KZvsUPFT
         J2KdDzTXRq4MIl3Tm/Kpc/ESBPsNhH+JkSvMiAJ1gm0cH5Vw9j0vmOKZxdv++gSc7Q1E
         waFfJqpAtTG9YNMKfBEZ2bHyZO/9vcjZHsai7e8/9N5Hgd1A9lMkux7AVNkoDzsQkQJF
         vgd98ZNmk79AxlLG6zEw5E2/NrQHRPEz0LwM6iqPINsE/zhJA+yVMdsiDlvpqvXaAdyZ
         Oquw==
X-Gm-Message-State: AOJu0YyoxhL0dlJRNQPof6BbT0WC9BstUpKYTPENVxvKoKZelAQ6116p
	fSzron8OTbdhC/txuDN0O+zFUPlcDs31rME0X7iR1bS5jYONSmpmwo7pVMY8BS4Lu3t/YlG+fUo
	62Ds61MtAbvLllHkimZ8TZ8Gqhyg=
X-Google-Smtp-Source: AGHT+IFctTMEsBEALITPd9P9JYlZ+E6XiMU7oZunjT4jHOqSTOqn77q3mWKKZy/qhtYsP7ZUL8dO7lVf8n5NdeS5c6w=
X-Received: by 2002:a05:6512:1394:b0:511:fb6:b1a0 with SMTP id
 fc20-20020a056512139400b005110fb6b1a0mr207585lfb.52.1706732448077; Wed, 31
 Jan 2024 12:20:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571c33b3-8378-49fd-84e1-57f622ef6db5@moroto.mountain>
In-Reply-To: <571c33b3-8378-49fd-84e1-57f622ef6db5@moroto.mountain>
From: Steve French <smfrench@gmail.com>
Date: Wed, 31 Jan 2024 14:20:36 -0600
Message-ID: <CAH2r5mvFYd0bjajnNVwMzdmKwbMGwgrbxUV9+4-FOBxe5Ejx+A@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Fix a NULL vs IS_ERR() check in wsl_set_xattrs()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch.  Thx.

Added Paulo's RB and added to cifs-2.6.git for-next


On Wed, Jan 31, 2024 at 1:17=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> This was intended to be an IS_ERR() check.  The ea_create_context()
> function doesn't return NULL.
>
> Fixes: 1eab17fe485c ("smb: client: add support for WSL reparse points")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/smb/client/reparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
> index ce69d67feefa..d4d2555ebd38 100644
> --- a/fs/smb/client/reparse.c
> +++ b/fs/smb/client/reparse.c
> @@ -225,7 +225,7 @@ static int wsl_set_xattrs(struct inode *inode, umode_=
t mode,
>         }
>
>         cc =3D ea_create_context(dlen, &cc_len);
> -       if (!cc)
> +       if (IS_ERR(cc))
>                 return PTR_ERR(cc);
>
>         ea =3D &cc->ea;
> --
> 2.43.0
>
>


--=20
Thanks,

Steve

