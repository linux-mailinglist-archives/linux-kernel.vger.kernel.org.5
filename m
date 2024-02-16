Return-Path: <linux-kernel+bounces-67991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DED85740C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28EDB21B78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB54FC0B;
	Fri, 16 Feb 2024 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C5kAc6RZ"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD78F4E2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708055703; cv=none; b=W/ipWZJduIYiAyo/jsWifPXUkyDgxaTxoXGScS4NfeJJOb/GJz/wjjaNAQhN1zis4ZKIzZ5vR2hsV4CnpbB+8Ow5Dp6twguz21+O7HfvYeZpdJk9nYPBo3ByRn6Es7PmOYuzPOZArwA45NLeNF+auhSMutvkpx2i2+gtlFcQF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708055703; c=relaxed/simple;
	bh=V0jgQ2Lgx742mFZq4Y6LE1tkLcmU8d6P9Zpj7Y5krYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPZ1i6xL0NIJ/zwzZskTCue7KfwCPb5SIGLLavqN7sC77Aw2qZkE0iutEsHvy7bcZdjgVLecuYGWYVMgKCB7kC4F8pId+vZZ7r+ZQ7/tKOel82fkBChZAM36j9TnaQt8n6S0cwfeDIleR1KQ/g0qFQwORaMJk0OaU1TqjiIZfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C5kAc6RZ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc73148611so1786600276.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708055700; x=1708660500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zHtN1FZm2hb7D8NWh4qPbFReA57r/z6mK9bZdqJdFk=;
        b=C5kAc6RZ0B8oR1HimzlM3+1eI7ccKE3zzSL81H2DPkUHA5lExAXg9sj8gNx0ubNhR/
         u+KFF1X5g5DinHpM+CimjMFLJ8z4Mvmgvw3vMw7U4O1VAeWQ2BOKeRyLPjN550ue9cRu
         Oxt2nsO2x5qG5QORSPdmFxuHZcJ8cN8mpGIBUWxKTbuf3YkcmlrfVcb49++rl7w5bjj8
         M4Xu/d/ACDjOrNW/QJlmyabiFpl6efb+kZ0mfnr9CVUBt4ZVa+ikrHAEx4YSb2j1gZi4
         OkMLe/lfh17JeC2pXg2pF5dNkJqmNqp3uv0JcBu5P9irnsGotANUag+V5SoqyrrfBIjs
         VoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708055700; x=1708660500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zHtN1FZm2hb7D8NWh4qPbFReA57r/z6mK9bZdqJdFk=;
        b=gs8NQZUA0GZxycTiQaL7HhI+8OGjPNmlofREN4atGrTsI0+f0ZYg/FWcZDE0IIuJ+J
         +6CgGQHePGuSYyF1ICphxcZLR9aQxHrB4lWbyV9fhDFlPKuzezT47ebkYXLvq1UmAfeg
         asVvtXVw/Lia1FdFMEoLAgE9WIbrIv+ZYLih7Aq9ZjfF0N1NE+9yuUe7HRUL5lCxWjyH
         OsCJnajxsZ9GFYF406eUD/ECfbOP7fYI1koh5KJd/UdjhAzT9xscugLw46YhcDsxoHZD
         570Ra/Ela4wSZzNeMKPZcYypzbaMGJt9vETidIXC7+PaZkgUnQzIcH1dJyBAtOhqxtf+
         DKkw==
X-Forwarded-Encrypted: i=1; AJvYcCUEa58Tu0+RBG8u6rmQw1VCoSzA0DbJK3JBs5LcnFDPRmXvt+MiBZjTF5O0fGDX4zLzXYvuBk3ke8q7gj/GudkagdMJr14ZEQvERk/u
X-Gm-Message-State: AOJu0YxWkxLphc6rFVMvDdC9QaPH5oBwIsTH+hxxEAnfXfHzynBIM84G
	f3HE/Klt4E4dnLIxC9VsxbokpIPpwBB2okjh9NcOGR4bTZLefBJrR3NXfR46exrT5y4SIKjyafN
	BVgL8L2By6Am3YgQpyg7A2Xdl7qClBUIDsMVsbF8IK7j4oYo=
X-Google-Smtp-Source: AGHT+IGzgFPaP+jUEakL8hOijRazQoR7FLPkDggq6id1JKug41cmZJ2OBCzxfbTc0xIFItzFoZWm72M01deXiyKSDbM=
X-Received: by 2002:a25:820f:0:b0:dcc:dbb8:ba73 with SMTP id
 q15-20020a25820f000000b00dccdbb8ba73mr3698256ybk.9.1708055700055; Thu, 15 Feb
 2024 19:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130094037.76895-1-chentao@kylinos.cn>
In-Reply-To: <20240130094037.76895-1-chentao@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2024 22:54:49 -0500
Message-ID: <CAHC9VhQG6XAm3R3wtgFrb0b0UHoxkSV2yziVAnUy2x7Ovun_pQ@mail.gmail.com>
Subject: Re: [PATCH] cred: Use KMEM_CACHE instead of kmem_cache_create
To: Kunwu Chan <chentao@kylinos.cn>
Cc: axboe@kernel.dk, elena.reshetova@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 4:40=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  kernel/cred.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This seems reasonable to me, unless I see any objections I can pull
this via the LSM tree next week.

> diff --git a/kernel/cred.c b/kernel/cred.c
> index c033a201c808..02a96e9d9cfd 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -606,8 +606,8 @@ int set_cred_ucounts(struct cred *new)
>  void __init cred_init(void)
>  {
>         /* allocate a slab in which we can store credentials */
> -       cred_jar =3D kmem_cache_create("cred_jar", sizeof(struct cred), 0=
,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL)=
;
> +       cred_jar =3D KMEM_CACHE(cred,
> +                               SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_AC=
COUNT);
>  }
>
>  /**
> --
> 2.39.2

--=20
paul-moore.com

