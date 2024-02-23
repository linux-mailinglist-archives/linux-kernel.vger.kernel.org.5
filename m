Return-Path: <linux-kernel+bounces-79018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82F861C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431C31C234A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3608143C40;
	Fri, 23 Feb 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BMp0xEww"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6984FBB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715498; cv=none; b=Necgdu/mk2xU+NS1z+DKefLBhcBhJUyCCsTUsigL1sxAINuX7ziUwX/zMZS34YvszxcTvtGUz6kAxmiWpcq4kK+H3ADtYRsfx+GeLLE/8wYvrkD0gMxgqTUEwS0K3eRC+di2ed2XD8AmErQGR0WUWbgVuaT0Od9rGq2EzRMDfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715498; c=relaxed/simple;
	bh=ClfBlzO7QpgXN5F3JKLl+3YPCiaYFHLAJGvdDZM4QEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE2khOZfAFprzrcS5+mFenWFB6ZNETUI8HEFGj2+FqwDxPpplxuQQAFNWvc7F2/BK6LimVH4yJLjCCaxon7w66ETgbfouhqvIjAXmq+JCofK6dEZkWvZ+XpR+L8d5O7iXDLX8PesAi2sHMjkaOpbb+HmPRRk52o4SKd3vyhkR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BMp0xEww; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d995bd557eso360524241.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708715494; x=1709320294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0XCvTK0JutYyKCTFM1dWFP+TyUZlvqtwx4Xm5HJezU=;
        b=BMp0xEwwkNSaExo3V3Djl3bbXRw75NUaNr4aOrAlwlxLA36VIrZ7oqbUPRBhM7uj4w
         /0W2+aAnTOCIdSXugAXsN5ohh2iZhP7613aVf3+uD1zkmeKot5aGDZ79yYCi9dZ72LiS
         CgLf5MBwlEwrpuZ3xBsgcLkxlXwytXRXTRxW4e7VNEgiXsPZ7TwrXUSAzjOISMsVaIts
         vbUv+M0DGt97XuXmhSIBD8+4TgYgfDluctR8D7q9TC8ftTdQO2XebmTUcCeTdE6vWFtN
         QG1jLs2Mco31KKSB9OXvXP/Ken46oEM/TdjgDilXnP9SassootgM0VkGrsCN6+Uc4Y5U
         ERvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708715494; x=1709320294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0XCvTK0JutYyKCTFM1dWFP+TyUZlvqtwx4Xm5HJezU=;
        b=D0mXQT9yT5YAjIpeyfzSc8ZTP4vRhifkXBNG8LouUyUoBdMQ8yKVoj4ccpj0SZ8jGP
         +juInize/Pd0SF1zV3KKbSi9sNoe9zCnz3chhjI3WZjWSdcia8l+G5wGgSsULiIXHKpz
         12JfPTYpfSAkce8cVVbXS3CuO90P7lENaRZ5E0Wfql/4UmCHPsYtEVrG7FY2arwheKMy
         POclK1vLfRIthRK7GcKhTwweiBK2+/lGHQGUnR3GpvSuEbn5PVCY+OO5Yn+NJrcpOkvK
         7GDZS/ANDK7EEUD0DpM+f8aKPIcd1/yJKCYxGEnmQGuRRQJeThm05qFjxQa5iNnwZCMW
         f83A==
X-Forwarded-Encrypted: i=1; AJvYcCWIEViHedpkHf3yK1ZyZideISCPNuJgH7kCYAG8GmecWducQQzLnAB/6ynAdb++8A5nZOh+yAzxNh2mT4SIBM/SfBm5OhYZMxVAfBLM
X-Gm-Message-State: AOJu0YzZtoi4nyytdZzDvmMpgr4MhwBMNOah7UEUbNx/VZOvzzpeZx4B
	6MdoI1sLsvvomGXYBqTv2gNDUc1L7+HOS1lSruJxKB8S7YhfRyq/v1C7wAfu/t535acj4EjoCPd
	U+UbWnIjpAJ5PTVNiYwMUjYJktDxBHVbZzT5k
X-Google-Smtp-Source: AGHT+IHgnpzrAJiqOtQa0RtIP05NlipiiJgyjy+Jaz0pPBXd/km1Jma/USlORd79vvIIEbsdXpIneAyVk15v6ZKaFuo=
X-Received: by 2002:a1f:c4c3:0:b0:4c0:2182:3cdc with SMTP id
 u186-20020a1fc4c3000000b004c021823cdcmr866522vkf.1.1708715494038; Fri, 23 Feb
 2024 11:11:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223170824.work.768-kees@kernel.org>
In-Reply-To: <20240223170824.work.768-kees@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 14:11:22 -0500
Message-ID: <CAHC9VhSyupEj_WfD=6tFUkujqBrNS86_TVFLpb+Um=5hc2C-8w@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: Lower GCC version check for -Warray-bounds
To: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Lu Yao <yaolu@kylinos.cn>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Petr Mladek <pmladek@suse.com>, Suren Baghdasaryan <surenb@google.com>, 
	=?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:08=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> We continue to see false positives from -Warray-bounds even in GCC 10,
> which is getting reported in a few places[1] still:
>
> security/security.c:811:2: warning: =E2=80=98memcpy=E2=80=99 offset 32 is=
 out of the bounds [0, 0] [-Warray-bounds]
>
> Lower the GCC version check from 11 to 10.
>
> Reported-by: Lu Yao <yaolu@kylinos.cn>
> Closes: https://lore.kernel.org/lkml/20240117014541.8887-1-yaolu@kylinos.=
cn/
> Link: https://lore.kernel.org/linux-next/65d84438.620a0220.7d171.81a7@mx.=
google.com [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  init/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks Kees.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

