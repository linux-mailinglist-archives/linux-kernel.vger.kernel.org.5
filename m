Return-Path: <linux-kernel+bounces-29083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D09830822
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875A51F25A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC27208D4;
	Wed, 17 Jan 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E4kJUHOw"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78220DC1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501966; cv=none; b=bIjYPXxP3rtuAXgkwPbVfwNei3z/80x/+s/g6P+l2An6OYOwgBrrz0QiBVie2gZB336K6TEFUafIuQK+HSVraNl0vWERnW0qVrSPMHGJ136NyFbxYXiYyxWOmYVQwsgmZ+jUwt5KWv5yM6NUrtgPkhUhQdgtGLKTzTfisR5uWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501966; c=relaxed/simple;
	bh=kkzjZHd7WNS4qBwCTQwi+455aFyXB+g748QuNeAbzBo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=V0iaJP7L3sY7zzNGFR/t+cBelMvKRYyD7JX6NW2jEPHG6bi3HixSx9Ivs1YJYXd8BRw35yHFPBgZh1/tSYpOeKAKs15RWRKHnDCwPD18G3RNjDHR7dx4qx5+z3bGAgfKSJZiV03z8DzfNZNPbcE5G8laeng9mgihOrRJUnsYwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E4kJUHOw; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd8cd40a04so1032244b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705501964; x=1706106764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RONH//ElZU86u60opp7THU7PsxqZBvC44A1MdMu3w=;
        b=E4kJUHOw94wgHUapWkCjecBzf7N6IwfJeqw9RBS/vVMKe2De9ae8PiSyuV0XF+uY4v
         2F7f81ioV1hg68em+PKeGq1sYJj6Gfq9CHN1va0JxDJXficeO+1rtYETpwgL21JKMK8R
         PkD8OJCsEAi3nNDIjZcEUiopbsEgqgMe0OtoD2K00DXy6kXg+JnHqrf9PwlfR0/V7poi
         1+SwCiu0EknKBsUVRD9mRXjAIvWVfQ5+erTypOshe00mR/XYyN8bV+kdJO7td+jDmofz
         ksdDQBy0sRQ1LBsJ5J4aNufvmSCMi4oJ10vGZzPU3u6RLq31z7RZi8IbQA601bjR4aoK
         vf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705501964; x=1706106764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8RONH//ElZU86u60opp7THU7PsxqZBvC44A1MdMu3w=;
        b=Zm3hjt1i9TIQlJfqKmmZ/flr4bD4kx4UUGw6b5wwn11ayyACs8y+HMa6twcSxyyIBa
         D9Ajtcii4X081quLcFyAqPkVn64ooRqgJQnTUqCEl+WVAnOW0SCV2MgFTCdXrs4+1t1D
         tNZct/Yed7x+6yvbZPAMC+xhFGQ6PwJ37FCeIw9GfoiC48YQkHlZwzNfpLuhmdvn/kf3
         zazZGgFnwamSVLUwR4I6uq4vicEV2X7G8hwQIKlUTzTweOP9atIsAX7QmGYtAthbt+Rz
         rDLw8XMPE5cABiPo4Wc+qJIj8gHj6AWr74HyqFUeA/+IO/HQGoRlWkVCPKK/3lxZz7e9
         9jSQ==
X-Gm-Message-State: AOJu0YwaCELHFyned28P6l5JwyCyXxWJvCWzE0aHWl9IvaBFiNVjN/if
	YQrpApsGXbX4s9qn8O9AUyRkcwY871QxF4feHVefMb2aGzJF
X-Google-Smtp-Source: AGHT+IE87eI9wptFf+xs4U6oR2zLXgl41vrThD1gFTxI6V//8WMTGlbbkeIOJ6ozq/sUoNyyugHRJ1IDoJg3F/CGQZI=
X-Received: by 2002:a05:6808:1290:b0:3bd:428e:744e with SMTP id
 a16-20020a056808129000b003bd428e744emr10251437oiw.53.1705501964261; Wed, 17
 Jan 2024 06:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117014541.8887-1-yaolu@kylinos.cn>
In-Reply-To: <20240117014541.8887-1-yaolu@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Jan 2024 09:32:33 -0500
Message-ID: <CAHC9VhSs6bxXFCAhw7i5cN=iZtuG3-E8xDBRjyGsop=BrhbmSw@mail.gmail.com>
Subject: Re: [PATCH] lsm: Resolve compiling 'security.c' error
To: Lu Yao <yaolu@kylinos.cn>, linux-hardening@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 8:46=E2=80=AFPM Lu Yao <yaolu@kylinos.cn> wrote:
>
> The following error log is displayed during the current compilation
>   > 'security/security.c:810:2: error: =E2=80=98memcpy=E2=80=99 offset 32=
 is
>   > out of the bounds [0, 0] [-Werror=3Darray-bounds]'
>
> GCC version is '10.3.0 (Ubuntu 10.3.0-1ubuntu1~18.04~1)'
>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm adding the linux-hardening folks to the to To: line as this has
now come up multiple times and my best guess is that this is an issue
with the struct_size() macro, compiler annotations, or something
similar and I suspect they are the experts in that area.  My
understanding is that using the struct_size() macro is preferable to
open coding the math, as this patch does, but if we have to do
something like this to silence the warnings, that's okay with me.

So linux-hardening folks, what do you say?

> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..37168f6bee25 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -792,7 +792,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, si=
ze_t *uctx_len,
>         size_t nctx_len;
>         int rc =3D 0;
>
> -       nctx_len =3D ALIGN(struct_size(nctx, ctx, val_len), sizeof(void *=
));
> +       nctx_len =3D ALIGN(sizeof(struct lsm_ctx) + val_len, sizeof(void =
*));
>         if (nctx_len > *uctx_len) {
>                 rc =3D -E2BIG;
>                 goto out;
> --
> 2.25.1

--=20
paul-moore.com

