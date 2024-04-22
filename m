Return-Path: <linux-kernel+bounces-152708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765788AC334
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3239F280CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD85FBFC;
	Mon, 22 Apr 2024 03:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnZ8uJkp"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4483234
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713757600; cv=none; b=MTOMlRf8cte8sg6VoqQQC8DwcSMeeJPKAYV8EIonTQcGXipdbyEPXxYhZU0n/lc6zkDFEIeqrJoXi1EJN+2t4nHP+lbKOfaLFCs6Wg5nJLDwl+z+PeG/6f/tmeQwYajVtXoXclT/jzx0XaD9fm32sbfEPAIBYWDHZbZZkDw7qNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713757600; c=relaxed/simple;
	bh=c6HRCsksVRPLJjiT9UI6pfGIoW0YjE5oXgE1QpL2YJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmqRmsZgno3UoMOfPMh6mYK92n6kJ9FUxOjhp5LFpFsTjHvI89NmPKRzbWpVYs9EWtcRVikNkyOxCsC4FUhD/9ibdgBSqYBxBJfE8EZFv5KxGa5NVHJ9/5f3vkBk8umtypEhDSQq/sO5AQN2bCkAyPJ0d0zEfd/PSHOZQOc4IMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnZ8uJkp; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-479dbcdba2dso1673084137.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713757598; x=1714362398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF+1DYovCBZQoynvQ2g2R4mxJuXf8rUbM7cLDdzJiIE=;
        b=WnZ8uJkpXUoTmJl/04/4YZ2go/PuJN/v/BurwnvvkaAbNt+FsY24W049GJJKzoptCY
         N61yDuuxA8id6mIYczKlR3CrCbztaFPAHdC5ReUcX8cJncjyqi/kB4BYNtvwG433cQqI
         BINhWj89/N34s2dYk0POy7mvnE/QEySx4lsG3IXRcxt/AFr5Z4GpWqbUpFq9sVBQuHkf
         XUDWaNzHfo4oPBbj9bLviBnNyevwY52FL1hwiC981VaqRnj0NlzjFy2VNjT3P+T2k0JK
         VhMWiIfT7THHh2DHZEwu71EYgUvRfrDuEJQsHl34REIIkSzuaE9QBvYF7KO7yoytGNly
         z6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713757598; x=1714362398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uF+1DYovCBZQoynvQ2g2R4mxJuXf8rUbM7cLDdzJiIE=;
        b=G723gfqc5WfMH3OhiZKmNGPx++6oMaC9RGJwPxgzVBS2p4ufOpX79p4EcNj5rAVpiS
         ld7/9/HYqDwUS7k4ufyJ4ucZN22WBOAW7Ri6QHCpcQepyNyIfP5FojX4SxUCbvgsZMTx
         co4NXdydzmYQY4kvuoNaPAc0NvTTAp5dSqzMLAxmOEuYcsvtG/hGgqy5o91JaOJEOefi
         hChLFdkZ/X9PRAtLl6sseSHDSaFNjfYTUMmh3+17ShskijpKK6+Fh/4dEh4qPE9MQyH0
         XafqmL55r36mlx6fI6zE5iTeP3EpoQY26xUbcoTniViMtNi4jhTj8nuGyrWT8gkRwu6h
         wv0A==
X-Forwarded-Encrypted: i=1; AJvYcCW7WvG4abldvIdVDwKYLMc9nxmZf4xDvtRUN8uen2azHBiMdFrHkS1RE49onYqoj1B6+fzG5h3bt9YqoNqfDhTuoHeNg/CfizQYNlby
X-Gm-Message-State: AOJu0Yzc7pkhVSGnJMGqbCSa/N2zYZsHNt4UdyfIII/aRlUlelPlEf2c
	gLsO1VU21rFRM9OLkd6VEUJszqwSDC7fG6L5tkz1WvvrBjMZ6jZDE2JWx/JuRRUtC1XcBWyXJUs
	MePK3Dm0eWgdBnhEGTjLQC1eQBRo=
X-Google-Smtp-Source: AGHT+IERpXWMynjY5c+mYROntV+AfnygzyfXC9gvLtE/N6YT9dvcT3QsqIo12Vlu52TTkYxN5OYRdCpq/AD39wn14SE=
X-Received: by 2002:a05:6102:c90:b0:47b:bac2:259e with SMTP id
 f16-20020a0561020c9000b0047bbac2259emr14152627vst.34.1713757597564; Sun, 21
 Apr 2024 20:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419101643.11534-1-hailong.liu@oppo.com>
In-Reply-To: <20240419101643.11534-1-hailong.liu@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 22 Apr 2024 11:46:26 +0800
Message-ID: <CAGsJ_4zUhnAAUb77ktJxDvAQpZhGrs00+8iQU3dhwpy=C_CjDA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix return value of vb_alloc if size
 is 0.
To: hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:17=E2=80=AFPM <hailong.liu@oppo.com> wrote:
>
> From: "Hailong.Liu" <hailong.liu@oppo.com>
>
> vm_map_ram check return value of vb_alloc by IS_ERR. if
> vm_map_ram(page, 0, 0) , vb_alloc(0, GFP_KERNEL) would return NULL
> which cause kernel panic by vmap_pages_range_noflush=E3=80=82fix this by
> return ERR_PTR(-EINVAL) if size is 0.
>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> ---
> Changes since v1 [1]:
> - Return ERR_PTR(-EINVAL) or not check IS_ERR_OR_NULL
>
> BTW,  Barry suggests me that if count is 0, return directly, in my
> opinion, change return value is more resonable.
>
> [1] https://lore.kernel.org/all/84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo=
com/
>
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a3fedb3ee0db..c430a999805b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2173,7 +2173,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp=
_mask)
>                  * get_order(0) returns funny result. Just warn and termi=
nate
>                  * early.
>                  */
> -               return NULL;
> +               return ERR_PTR(-EINVAL);

might be ZERO_SIZE_PTR.

>         }
>         order =3D get_order(size);
>
> --
> 2.34.1

