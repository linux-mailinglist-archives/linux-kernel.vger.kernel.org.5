Return-Path: <linux-kernel+bounces-72349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E57FD85B251
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0B11F25660
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31956B90;
	Tue, 20 Feb 2024 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzkDHMSe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F354FA0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407287; cv=none; b=egMs+XI045N4lMZSMn5GMylkRpDDiLNDSJedojqEoisU51ubKaV0x932lHgSvGcVgFi8KfoSK18oo+XJdTwluMK6pUQfEsdCfiTbVGYhQP6GPVGe9xVXU4MnANNiKmMkSJYsqh9eY4KiZsGqrQ4XR+pimVKyUxFv7GLpAjEodhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407287; c=relaxed/simple;
	bh=mop83OIjGvlyQKTszs6fXqIdbAFxOAfrawHvH8iN+3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoHognIJuBoaokdJKL96a7mJRX1or5N6RJPsKi9Is2S9wBhGMDDIzrdhiiF84DIlXPLUPhSrSuJjc0QxYgUAq+kJuk5POLEe3gFgGECh5wIIon4aVxyqJzDd84wwPmDP+FbPZF61z+XTYqD5XsR3Fl4XKhU5FwS+Nvw5podePW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzkDHMSe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so3478296a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708407284; x=1709012084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoWmb9bttNW0nof/0Sb31QT+U+oz83qpMX0kXDyv0do=;
        b=OzkDHMSeZBIYd14GUQ4+JE5AE+uJmo/A3qfoqJpBpX4f+uphAyVBkLfgQAzeDv/DTv
         kciX9YvE1JP4Vwu7sxeLK6DnvfuzUE7Wh5JFyH7OvjvyA/YtIa1NLXnmPbKah+FfEbBc
         Mhp2359wdJtHM7hXpeDXFAiHTxq19EgGfRHASza4a+pMa8ABVAubP6gFldO0ThqUP+Rh
         9DDYqgV1sEJcVAPrMsTaOOJjy/1R63ZqhwbhS4fdqhI/RyIGHvzrLwOfd/imppstzLKB
         GTDhjHT/DQdox7SWbEJC+O+PGjIZHuosr6ZwzNLadFIov78HVFylSP768+rMFgqkz63Q
         NORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708407284; x=1709012084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoWmb9bttNW0nof/0Sb31QT+U+oz83qpMX0kXDyv0do=;
        b=CkIUXyFQvZkPHqkLmIWOoGvp7kVDcc3H+H+tZu5WmgaoFlQ+bPqg6QxDEPlXdNXFuW
         2ue5EMWdqAr9PYI8e+GD/N5SqVEMhl1H8aceRGDWsykzoOdfJ7kHfEAeSS1N+mnHyPcr
         g3PSaXlD1QkCXQryzKgF/30PkDHLSaqLQpwr8z5GcYYjHakhcCyrsXu12EiyUA4Oc+jF
         PCR0Dyq/1F8lq94Gwhl6R86s5y2g9czasPEfeYdAQbTX86LidXSxd0nVtNlQaZfa4gn5
         X8kmSDWpFBC1MbyE1X4yuQzWaF/Ote3Z7DJNamadSKXBk9yp15iTUPC1S0c27Cv4hfvw
         5wDA==
X-Forwarded-Encrypted: i=1; AJvYcCWKKmCRKl62/156xHnFj5YjjzBxYANx5VBveaQ9XeSTmC069mr1aNiiuKri6ZZ9YSIkEMm7PgL+CMwKjxdic+5x324eq56kCWoYAkgH
X-Gm-Message-State: AOJu0YwkJz1UQYZ2oRg5bVPJ19XO/IKSbOi4GAPE9Tpca0LYGF4+uENH
	XQ9uTQ83/8qLsOom3Mk9sK5hkmy0HwNa71Q7lij9e28Yf5l1GwjNWsRZc+zm2M65J5tJnEqmtZL
	oHAweapJzv2uFqcbiagnmU/O8lE7agVjDGjs=
X-Google-Smtp-Source: AGHT+IGdrCHsE18s3ly+kaKcQ2Z4iB0NPd0IprBDTBeUn6RlIZDknxVmEcWfHgRnDLlbI2mf9FtXEF4ylJu+CSAmebE=
X-Received: by 2002:a05:6402:34f:b0:564:66d3:530f with SMTP id
 r15-20020a056402034f00b0056466d3530fmr3281939edw.28.1708407284152; Mon, 19
 Feb 2024 21:34:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org> <ZcGoWAsl08d5-U0g@google.com>
 <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org> <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
 <17c9e85a-54b6-4e1c-b95f-262c771b0f1d@kernel.org> <4bcf0a1c-b21d-4735-bf57-b78439a65df5@kernel.org>
In-Reply-To: <4bcf0a1c-b21d-4735-bf57-b78439a65df5@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 20 Feb 2024 13:34:32 +0800
Message-ID: <CAHJ8P3+25FxdpqWNW53yyiLLG8J7LnMAeYr_DV3ARF9-3LCUUg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: unify the error handling of f2fs_is_valid_blkaddr
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 10:36=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/2/19 22:36, Chao Yu wrote:
> >>>> Please think about how to optimize this, which is really ugly now
> ---
>   fs/f2fs/checkpoint.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 87b7c988c8ca..089c26b80be3 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -135,7 +135,7 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *s=
bi, pgoff_t index)
>   }
>
>   static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr=
,
> -                                                       int type)
> +                                               int type, bool *record_er=
ror)
>   {
>         struct seg_entry *se;
>         unsigned int segno, offset;
> @@ -160,6 +160,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sb=
i, block_t blkaddr,
>                          blkaddr, exist);
>                 set_sbi_flag(sbi, SBI_NEED_FSCK);
>                 dump_stack();
> +               *record_error =3D true;
>         }
>
>         return exist;
> @@ -209,10 +210,13 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_=
info *sbi,
>                         dump_stack();
>                         goto err;
>                 } else {
> -                       valid =3D __is_bitmap_valid(sbi, blkaddr, type);
> -                       if ((!valid && type !=3D DATA_GENERIC_ENHANCE_UPD=
ATE) ||
> -                               (valid && type =3D=3D DATA_GENERIC_ENHANC=
E_UPDATE))
> +                       bool record_error =3D false;
> +
> +                       valid =3D __is_bitmap_valid(sbi, blkaddr, type,
> +                                                       &record_error);
> +                       if (!valid || record_error)
if   type =3D=3D DATA_GENERIC_ENHANCE_UPDATE && bitmap check invalid,  it
is a OK case, but !valid
will goto do error handling.
I think do f2fs_handle_error in __is_bitmap_valid is a good way.

>                                 goto err;
> +                       return valid;
>                 }
>                 break;
>         case META_GENERIC:
> --
> 2.40.1
>

