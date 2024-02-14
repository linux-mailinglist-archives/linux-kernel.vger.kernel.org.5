Return-Path: <linux-kernel+bounces-66119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022B8855738
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5418CB217F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6F1419AD;
	Wed, 14 Feb 2024 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bci9uY+N"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4A1DDD7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953085; cv=none; b=hF+s2nYrMx2JvpVSMuHcCZaY3InUdKncfd1eiKnoDZJPbJap4BI13Eef7nU1xADmRoSJXEqgObJP07FIJjHuafwkfZZ3T14IBdYDNVf6eDWSM1AXlEhMHoG+UGx/Qrp1E5gCl/NYs7lIpHLb5zDqZNlh8wVxiJC1VZdP9r9IL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953085; c=relaxed/simple;
	bh=z3FV6SculjJxKoq8cb1i2S4q1XbiP+WG8CbFW/oAXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvyjqglAVENE+14kNtR9ak+Mgz5E2TXyAYV9LvE9qA4ByijUOTTTopA/JHv/P17TCNCmpa1PTlljGFgbk1lownUGgKlSjxIrYfzksEdA6wVh5v/0AeRp+8S/4Q2U1ZzIRADKjtb7vydOd5pQVPc4+q/1JYb0rhhKTFjjXjdnMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bci9uY+N; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso296044b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707953083; x=1708557883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOQlVf5qnnKk5eJkb2R3QyzFtOwnY+yrwTa/skPqH2g=;
        b=Bci9uY+NRjdfbwxOM8ynNOWIcM3AwfJmNJwABSWS+BQTXyW7r1f0UYcgdrPXS/k2lz
         qGeL3eTnQc5pQq3pFRrZXXUd47Jmx6J6K96TNxCAqJ5HDy4z69D7czKsK4zrnrgVg84E
         /7D5ea1F1YRDqjf2WjIN1pic+bKmV4t+o717w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707953083; x=1708557883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOQlVf5qnnKk5eJkb2R3QyzFtOwnY+yrwTa/skPqH2g=;
        b=N+Jw6heF4dRNWEdtqMwlA91oIbWf7y0v0kiM4AJMHqyfYrmimFzPLidGKuhxFyz3Jt
         fEm1t57qEX/Rtymc9oG4U65YbrUvlNJdVffEjXJfP3oqk+ULxDpPlxcaCASTn8ibn4ku
         P8DbULhvab1aUPjjjOEVi/2Gwzn9wjQZy/bEPPf8kivcrVILnVOVry8FQ96FtCmK1BSI
         tDG+Vc3xtTpFTjzMD6C55weTo8e8Q/D9CE7rcgT4ywFCWWn9vtkYdIU89kCHhgQ2IP4v
         9YtR5sBjYI5Z2P3MB11cCvQKhnhD9xtAI435w5tiNyMkzTMMVCxuZ1uxLhlKjMowsEnM
         YNAw==
X-Forwarded-Encrypted: i=1; AJvYcCUK8vq7E7NZeXD3w+3MFrygA/7y77Xp+M7uKEocfovE3tRqgYyADk14R4QJdA6lqxec0EF22E68oJxyS59zwztCIoZMQQWxpc2nIAMb
X-Gm-Message-State: AOJu0YzGW98sXP1uF+Gohkymq6nFQPMCPh0VY/jkSNiJ8gqvkAShgpbr
	pZW9pgi53pLkIlNTkDJ2ddiOb4g1cqekoWxXPC95oFhPrs492bXVnOvjze4Txw==
X-Google-Smtp-Source: AGHT+IHH81j493fbEm73R9N7GsBSIcalWlZobL21hSz9Qms+VNW8HqoLZNKIQJjFHeRShvyprQ418g==
X-Received: by 2002:a05:6a00:1803:b0:6e1:eb1:cc8f with SMTP id y3-20020a056a00180300b006e10eb1cc8fmr4109107pfa.4.1707953083534;
        Wed, 14 Feb 2024 15:24:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUj0vkPjui6LzJeZojNrXuDHzO6EZj4cwuyR4iuh6X2ksCiiEw0V4Y06/EH9T6pIPIttLPSnuvYtpm6Ee237lpSnQBrwdCUiPDLoWs9nFXwkp/pOl4nJ0C+q60EYAZWs5z8/W0H4lXTEXHxXoYn7kLkoC4/BikYH5JP465O8YciGPyA+Nq32SqR5H6o/9WioHN7Ay6ZjEKsr9KAcKjEMDXX9zyQUsZlivfx4DKlf1U6MwP8OU8ws0qA33DcaLU3iJIPKkp5N3b7kOSmi0vO
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a637d12000000b005dc36761ad1sm4882021pgc.33.2024.02.14.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:24:43 -0800 (PST)
Date: Wed, 14 Feb 2024 15:24:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: fix integer overflow in lsm_set_self_attr()
 syscall
Message-ID: <202402141453.FEC8EF722@keescook>
References: <20240214160538.1086089-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214160538.1086089-1-jannh@google.com>

On Wed, Feb 14, 2024 at 05:05:38PM +0100, Jann Horn wrote:
> security_setselfattr() has an integer overflow bug that leads to
> out-of-bounds access when userspace provides bogus input:
> `lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
> redundantly, also against `size`), but there are no checks on
> `lctx->ctx_len`.
> Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
> value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
> will then be passed to an LSM module as a buffer length, causing LSM
> modules to perform out-of-bounds accesses.

Ugh. Thanks for catching this. I continue to want to get the unsigned
integer overflow sanitizer rolled out, which would have caught this.

> 
> The following reproducer will demonstrate this under ASAN (if AppArmor is
> loaded as an LSM):
> ```
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <sys/syscall.h>
> 
> struct lsm_ctx {
>   uint64_t id;
>   uint64_t flags;
>   uint64_t len;
>   uint64_t ctx_len;
>   char ctx[];
> };
> 
> int main(void) {
>   size_t size = sizeof(struct lsm_ctx);
>   struct lsm_ctx *ctx = malloc(size);
>   ctx->id = 104/*LSM_ID_APPARMOR*/;
>   ctx->flags = 0;
>   ctx->len = size;
>   ctx->ctx_len = -sizeof(struct lsm_ctx);
>   syscall(
>     460/*__NR_lsm_set_self_attr*/,
>     /*attr=*/  100/*LSM_ATTR_CURRENT*/,
>     /*ctx=*/   ctx,
>     /*size=*/  size,
>     /*flags=*/ 0
>   );
> }
> ```
> 
> (I'm including an ASAN splat in the patch notes sent to the list.)
> 
> Fixes: a04a1198088a ("LSM: syscalls for current process attributes")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> ASAN splat from the reproducer:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in do_setattr (security/apparmor/lsm.c:860) 
> Read of size 1 at addr ffff888006163abf by task setselfattr/548

I'd rather prefer that this splat (or some portion of it) stay in the
actual commit log. It makes it easier to scan for sanitizer-related
fixes, etc.

-Kees

-- 
Kees Cook

