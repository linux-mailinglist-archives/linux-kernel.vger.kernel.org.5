Return-Path: <linux-kernel+bounces-123701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2AB890CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578941F25E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D68513B591;
	Thu, 28 Mar 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3e9R8CFY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FC13173E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663504; cv=none; b=UUJxBGk8XdB0ShHQvY6j1Z/h2/ORW+PihQ5Pg+2rftoiHbbUu1CjW+cgD+1o6C/nBwNTnWlhPC2s08CTfbEKA/Zm4/VY3OyER1LEkUf8X4n9ivBil636z8qvwg6Ffva9ZBSuwNMiBVPu7i7RDku2s4EPoBFad0DBkhVD+Ry95iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663504; c=relaxed/simple;
	bh=9ZSPvENfmgfhIsnuJFWhvL6BmUkVhFz5PSQ7INGUgHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1Z/yfD1RankBlPeAiTs1QEqrjJijMJehfn8Qw9NXdCwaLZucOSjlziUzzMt/pjhDme0uIKMUcjTyejKDqHwgDe2LUEgy66LmZduaIUpIyCmpKLDMVkETDyIBtn/yTFO7rHAVaH2hgllq2oS6V4EK4ZZ8ikgPiDi8eArybS2dOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3e9R8CFY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso2248876a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711663501; x=1712268301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGMxoG8AQ8BGP67PTNjLH3VS7bl1OwfTgMURF7OtwG4=;
        b=3e9R8CFYk4xjW7QBhCdJc/gM8mLEfGvLcbf051vzhpu2zFvFzZX0urTkZ6D3i9795p
         29DbUncFM+7y1IktSL96E1UC5aMZlFJnO0g6C9vb9wIqcsVtNxCMXqMpSV2n/q+ecnzv
         pYmuMpikZ9fkSnRWZMhYqQAl51UYAnQeMul8Jyjp2vlvxdRmX0Iyyd4EA0qi+XcFUxG4
         rT6uKbHEHvYaEsI+nhXf2DR5WZclKPXe9/tV37YTK9Z3CQVu4kVQMmizqwbkVfBoDvIg
         CZmjqR9MuDLE9xf4gftr5D33nqTy1cuyuHeF+ZBzWix/r5u70eh3ACzKBJ3uTYcMYgTp
         ibuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663501; x=1712268301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGMxoG8AQ8BGP67PTNjLH3VS7bl1OwfTgMURF7OtwG4=;
        b=Ljf/gtr+BTCNb1gS/AtdIeGrXGsjlsYu0H7N1Sdfls/m9gFhaDhjJXM6Ja1TpC8YR6
         gWGPsPYWJ7Aup6A5c7UzYthhb6/HsGIO4tYB+FjIqVLapne7MpOX3VMZTrUyCKeXj1Y4
         sPGAFRMdO7Ufe39MEugA7VBFQWnntBWQXjzdkO90Yk0PIRoh5zqtFmzFYLOjpEVH3dDQ
         FBvw8trn56kPoNdxyrT4LrZW+LB3/r/wRKhKP9/6EvTjwHKij5iHup/kz+hJGbtli7VI
         ow9EjG8szbObl2/LKwsSv5ANvjmzYfYSxotNZakBPoXb/tvVYivQYvGX5kwNeytm88Yt
         swfA==
X-Gm-Message-State: AOJu0YzlKKCcwCgU9VfJqAy0UWA01ZmlcPU8VKUknJRx4pQj9LDbaPf8
	G7/HgFWfk6GYp6dKoOUEH++ir6/N2NwoZk5zu8OD8Nen3sqPx3ZzguTJdDrrR20zSHfcEQJ97Gg
	H11HiFUvXbM+IGGQk8k9DtpVQqUDEt38dSWXnyaB5zWPx6lpDpbHt
X-Google-Smtp-Source: AGHT+IGI1NuivKb4Ji1liwhmjoNA08qow9K2J1nHBY2lkA7t+bjvkMMP3tHaIzK6dIha9lwR+QhUcEEc6nDcKmlEY7E=
X-Received: by 2002:a05:6402:35ca:b0:56c:2ef7:f3ed with SMTP id
 z10-20020a05640235ca00b0056c2ef7f3edmr442959edc.35.1711663501455; Thu, 28 Mar
 2024 15:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-7-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-7-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 15:04:49 -0700
Message-ID: <CAFhGd8oJ5trNE7na9jCDbEt5kox1rg0mia59EHj+XikHUnay5w@mail.gmail.com>
Subject: Re: [PATCH 6/9] nilfs2: fix out-of-range warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Philipp Stanner <pstanner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Thorsten Blum <thorsten.blum@toblux.com>, linux-nilfs@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:32=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-14 points out that v_size is always smaller than a 64KB
> page size if that is configured by the CPU architecture:

Is this only with clang-14?

>
> fs/nilfs2/ioctl.c:63:19: error: result of comparison of constant 65536 wi=
th expression of type '__u16' (aka 'unsigned short') is always false [-Werr=
or,-Wtautological-constant-out-of-range-compare]
>         if (argv->v_size > PAGE_SIZE)
>             ~~~~~~~~~~~~ ^ ~~~~~~~~~
>
> This is ok, so just shut up that warning with a cast.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

My question out of curiosity aside,

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  fs/nilfs2/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index f1a01c191cf5..8be471ce4f19 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -60,7 +60,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilf=
s,
>         if (argv->v_nmembs =3D=3D 0)
>                 return 0;
>
> -       if (argv->v_size > PAGE_SIZE)
> +       if ((size_t)argv->v_size > PAGE_SIZE)
>                 return -EINVAL;
>
>         /*
> --
> 2.39.2
>

