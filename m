Return-Path: <linux-kernel+bounces-80214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD681862BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64641C211AC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA7817C76;
	Sun, 25 Feb 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB1xlc07"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42C79D3;
	Sun, 25 Feb 2024 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879925; cv=none; b=Z0OiW03iCg7p3V22ngYr5OL0cJfMlx9swPQlIL0lDpc4z/e1CNrvF+B/hS5nC1s7Vvdg3YftM0bTuKk6bWolgVktGJaSzaRaOwvzzcp2uMgqyW57hyd9GRvg2t4c4kkUJDZtiXlKhqlm9bH4B+x4zM5h4TxqFu15+omjeTk+Sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879925; c=relaxed/simple;
	bh=Lm8WAuY1Y40qJ1RVfUtI8EqsUKGH8Fdkh/n4dpYLEyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOzPLZQZ66+RnT/qo7iOZbVRAutRLB3hAgbevMleqcpWuoze2RekGG+PHVICJtwU59XIp5wWW7qwx6WtZ1UbaxvLyqDzpV1su3Kj2oO1L9xSgba5Iinry389LRXQ8dbzsKA10o3ZFTaY+D7b0kuNsMMa5y8XZ/gfNGDi4Qe5YOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB1xlc07; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512b29f82d1so3016915e87.1;
        Sun, 25 Feb 2024 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708879922; x=1709484722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVBARaDhY4/ZJwxqvZSGq2HB0eTnWoqOZB0E4z9T7/A=;
        b=IB1xlc07NRYy+1PTwwHSi2HtTIKm336cvZIdacuTJCTJOd1OmH1xS5mnrXT5ld60p1
         3mhJvVbUgyn/V34PUs6wnDyQ3Piugsc2JWqgpEEJR6dnFgTYYIIS/pe5gFeoqIJQ0ba0
         gFuY4Ki2yh+0tU65Zw3tGlVQ6E8MaDh6D+ZUp6W8SbvTG/6nzuvQOmaWQ89YSHU48E7h
         BAYTPfOIjMmTu27yuhqoZpHlVR1aAzRHBHL0Bxz1MJgCUX3zmKPAXY2ntYgb2aVMlv8u
         vhnm4wyy2kH5upjxAPuhrDWhw0H0i8L5dV12Opd0VW43tz9qmy6WLFr+GFxbn0r0PSDp
         IMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708879922; x=1709484722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVBARaDhY4/ZJwxqvZSGq2HB0eTnWoqOZB0E4z9T7/A=;
        b=GTCWAmouvnTcM4CMbHMY4HY+RArGAHzfS/uBry7TGa2yIXI1Ibe4wrKucG/Ekj0OZV
         VMDWEKtGiaxcwWGS2IICBfWIdiA/fUzjWODcXmoGJA+KDbEiqxBVaaV2SUqFTzKY6+hx
         iuMGpybCcvgZ/mgXMP3rELajuhqJ0pXmEHMEhGEuaeiIy8GgUiG3klsXdFtCgVx6qzHa
         srPXKJc7G+6j3GPDjCFHoH3svJlihB++6SUO2/54EQNPHRkBExAnqyOaOeQQyNUPvEgN
         XvKwCvdPewv3frHanCSrJFtdiFjVyVzGXMi70PT6Zj1jq9zWsEWzdICgbVLoGndiiY8Z
         Y5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVHSF178LA86xprwNNnnuB2CLeEhD1bPRpXpKjbVnqGw6ZVVgHuVfZg3uwqFu6qCrgc/nudhw9EnW1i2Unu4U6YOTKRLwE8Rk8vKuvlcGvA/W/5fkN20ZNIndbXdCKFuih3e24ZQTAZxw==
X-Gm-Message-State: AOJu0Yyp7f9sZb+HY8lIwy3HXY8E1W4QeCiUYuovKHt7VcpVq1Yc/eAo
	IUuWaRYUOMWIdGw4Ordo/GFvwvoru5+6HiU/YbPHIG54g43pAlM2GSoXLb7UAcD/HrksEEc64bn
	Z7KBBPnOz5weMjf1mrXOCSftJ9D0=
X-Google-Smtp-Source: AGHT+IEgmqbO9wxfKjJgwrgk/OccX2wFSH4UyEXLgZcgtXOEMyUIPc3FHLXpzE3nabPMr+da8zY76L6BygSBRqMVwdA=
X-Received: by 2002:a05:6512:614:b0:512:e51f:b58 with SMTP id
 b20-20020a056512061400b00512e51f0b58mr3178846lfe.24.1708879921986; Sun, 25
 Feb 2024 08:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224135809.830610-1-chengming.zhou@linux.dev>
In-Reply-To: <20240224135809.830610-1-chengming.zhou@linux.dev>
From: Steve French <smfrench@gmail.com>
Date: Sun, 25 Feb 2024 10:51:50 -0600
Message-ID: <CAH2r5mvoS1+52SvT3XCPiBtOWAFyoVy3LajfQSFGOAa2h8Wy3w@mail.gmail.com>
Subject: Re: [PATCH] smb: remove SLAB_MEM_SPREAD flag usage
To: chengming.zhou@linux.dev
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, samba-technical@lists.samba.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	vbabka@suse.cz, roman.gushchin@linux.dev, Xiongwei.Song@windriver.com, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next (minor update to put "Link: ...") line
in the description

On Sat, Feb 24, 2024 at 7:58=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/smb/client/cifsfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 9cd3bb48bd3b..45e57c852f33 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1661,7 +1661,7 @@ cifs_init_inodecache(void)
>         cifs_inode_cachep =3D kmem_cache_create("cifs_inode_cache",
>                                               sizeof(struct cifsInodeInfo=
),
>                                               0, (SLAB_RECLAIM_ACCOUNT|
> -                                               SLAB_MEM_SPREAD|SLAB_ACCO=
UNT),
> +                                               SLAB_ACCOUNT),
>                                               cifs_init_once);
>         if (cifs_inode_cachep =3D=3D NULL)
>                 return -ENOMEM;
> --
> 2.40.1
>
>


--=20
Thanks,

Steve

