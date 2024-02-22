Return-Path: <linux-kernel+bounces-77020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015886002D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23A71F24B74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41D157E74;
	Thu, 22 Feb 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C/GZKSCx"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95C15696C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624643; cv=none; b=Foc8tf9+nqXeqrmC2EuSBsw3afS07lg9+UVt0nxjqJSwoojuWGnvorpCZPIxRWU193u8gwYvWcSCsdPuI4/TVgJLS1bD5xIEXYZxkimCDqNg9vcUjt15MrbMG0crEshawa6PYn4e6qSIyPnpaUk04yElI+S15K5K6Mma7jmdUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624643; c=relaxed/simple;
	bh=hlPKjlQSc0kMs/W05kmcLVH3IEjiTit6toh7GkaAPKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMoSAfXBKBuARnz+b0EuSPMb9MX9a0hK5H3DFSugsh2dWwa5+yYRrnwuBYaTfBC6PmIqX5pf9KXt2NRHU4mqe9zpIVZKhU6Ze8UBjWix/4VWpaXf+Vv0fgNMnP4vxnQAtCc/83Yoj4lM+VofbnJiCn7WqQjaGR2Lf40bjlCa/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C/GZKSCx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso56254e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708624639; x=1709229439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=C/GZKSCx9krnzW/91GYSpXCFzd4lSh/fVce4znbLwfR8AxIHeSj99gMXHqiEgt+MYl
         zhUlkyyYyhXJ47/KDPwISDkS/uDO9DYrfAXEN7Yefz03EBkVymKB3ugTh4dKQ2oIbS8P
         BRSLPUJqVNlkHCSOQDeDKklgoNgB2P8ZbIQD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624639; x=1709229439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n36AeyXiuh8a+bUOx1L+r2cwQosoX8vn/3R6qLfBBs=;
        b=JWTHhPWvB3lrsrGRnAU8bHZLUL/upfZ9wrY1Sj6xShKMtjdZimyIBqRBa1kWwk9F3S
         5bwc80j+PnI30Zf1iuEvLwcsoZb/rxl/5DAVEGCRGFs1GvA2VWbEaIkXZboh69a0EQ7Z
         JPquEL4V4zFqwQBFBb/WFjrb7cGIQkBr4FCMmevik6bX0t+w8vnej/UOHTjYDGXsMFcC
         n9atsIIKDycf1hRhGXuGL0anKNtY9QGSrXJhWQjmIPlyh/UL+RniswKvmjzMr0pLI7tc
         0F40atikc0qEgv9tnG1cgt04L7ihKYS4puF5CZbUGK2UZNTQnSYmhnFi8duwOsyH7L7J
         XeVw==
X-Forwarded-Encrypted: i=1; AJvYcCXWeQQI4sMiKscHTwFPf2N//GtFLYQmTQd8pxTptHNhMGKAvB8dg8CbVS5Cn3h54xm2oEAtInxeIvlEE3C/2OWRkA4Qboonpi1Kux2H
X-Gm-Message-State: AOJu0YzpuMF55TA2BbdkipXuBejtcYs2/Y0JsShj87PyCBCfkNVh0Lu2
	AGyd/BsiakZyDBGJLfZzhTOwsnW0J314VyjQ2Ryf9IrTSOzZSNcQd0DaWbasMbV5BH0YIShOX9z
	ZZTbEPw==
X-Google-Smtp-Source: AGHT+IFbn6Zujz9IfNQwpjWHUzRCs3c7C2S0L6f8YPLavfcdkJZMZLyYX++t/wveUI6Tms7UoMCLjw==
X-Received: by 2002:a05:6512:3f29:b0:512:ca34:664a with SMTP id y41-20020a0565123f2900b00512ca34664amr6511778lfa.32.1708624639648;
        Thu, 22 Feb 2024 09:57:19 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id bi10-20020a0565120e8a00b00512b7948baesm1494084lfb.41.2024.02.22.09.57.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:57:18 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512c2e8c6cfso56231e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYGUdwiowKkebk0boaZXBE6UVDTMUUv4xWxAZ5V7vddtK9phLjCWirS9hpnppAXtVtvw61H3cQjx2KhTqTpzQkeRYskmL1hFwW6nkP
X-Received: by 2002:a05:6512:3089:b0:512:acf1:6970 with SMTP id
 z9-20020a056512308900b00512acf16970mr11555378lfd.35.1708624617484; Thu, 22
 Feb 2024 09:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-3-davidgow@google.com>
 <20240221201008.ez5tu7xvkedtln3o@google.com> <CABVgOSn+VxTb5TOmZd82HN04j_ZG9J2G-AoJmdxWG8QDh9xGxg@mail.gmail.com>
 <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
In-Reply-To: <CAGS_qxoW0v0eM646zLu=SWL1O5UUp5k08SZsQO51gCDx_LnhcQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2024 09:56:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Message-ID: <CAHk-=wiODww51Kz-TTWn0ka5T8oMtt0AfbO9t0U3iJqfLZO+8w@mail.gmail.com>
Subject: Re: [PATCH 2/9] lib/cmdline: Fix an invalid format specifier in an
 assertion msg
To: Daniel Latypov <dlatypov@google.com>
Cc: David Gow <davidgow@google.com>, Justin Stitt <justinstitt@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rae Moar <rmoar@google.com>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 09:36, Daniel Latypov <dlatypov@google.com> wrote:
>
> Copying the line for context, it's about `p-r` where
>   p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
> `p-r` should never be negative unless something has gone horribly
> horribly wrong.

Sure it would - if 'p' is NULL.

Of course, then a negative value wouldn't be helpful either, and in
this case that's what the EXPECT_PTR_EQ checking is testing in the
first place, so it's a non-issue.

IOW, in practice clearly the sign should simply not matter here.

I do think that the default case for pointer differences should be
that they are signed, because they *can* be.

Just because of that "default case", unless there's some actual reason
to use '%tu', I think '%td' should be seen as the normal case to use.

That said, just as a quick aside: be careful with pointer differences
in the kernel.

For this particular case, when we're talking about just 'char *', it's
not a big deal, but we've had code where people didn't think about
what it means to do a pointer difference in C, and how it can be often
unnecessarily expensive due to the implied "divide by the size of the
pointed object".

Sometimes it's actually worth writing the code in ways that avoids
pointer differences entirely (which might involve passing around
indexes instead of pointers).

                 Linus

