Return-Path: <linux-kernel+bounces-77356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E0860446
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEB91F2678A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE573F02;
	Thu, 22 Feb 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VtCed+W0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116F6E5EC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635643; cv=none; b=Ib+l+rKN6eQr5RPhYHLAuRlx+G+2K8o6CSvVa3NxnbJQIoqFH2A4r049TDvdyH/D/t3enIOinaCG8AQFERv9mZD9z1NVBJZCmT5B5DuZEim7+Kk2eQIsOXdKFhN8L41YvVNoIDU8EYRyskJsT/4/Ory63owI+gnfD+B0+MsJuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635643; c=relaxed/simple;
	bh=HYirffWuREqInys6H1sJGnW444LN+8gm7IIzreiFbV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSOmqWhPQQT81MUbawIUG3VUABjs5vj8sZ/mpwU7htwHAqEBMQH3P9NzHhQpEL4fvKGRvmvSkfC1hoFhYkfbxWAUSEJ7zHyOkHVKdOk/n/rgOXoCxWV2ddv/KU7Rer0timkUIPr151tq6cChuTrzgGYzE5kcm8ARnwn5w2P6Pbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VtCed+W0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e4751b97eeso74848b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708635641; x=1709240441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwpFD5/+GTNERxZKsWUikWXT7ybqY7JIlXCpe9IyarY=;
        b=VtCed+W0fGrXk2PMGyL5dqZwL4zC90lxa5dQQq3rqPcJtLiXw3hZ2Hp1vwgcu0Ilrb
         xFlqOLt/iND4nkLL692ezNq6zDwzc0cF6um2gErDKQJUjWTwYu0BB0MVBR2RUSFkjDxs
         qgzNP4AqfUaPwYt0BttOmjA7YTjxC9ImQOvsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635641; x=1709240441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwpFD5/+GTNERxZKsWUikWXT7ybqY7JIlXCpe9IyarY=;
        b=nXYE9ODgXV4v/Qj5mu3cPH0DH1h57qZdhZA1i9L2sxZgxbqTznk6CGGoGykwzEQPSz
         luodNeKsjsh9oGzdUZ9L/FuxBHU0jthtUiLTe4L0LP8m32s+HajgN1c/84Q84682ztxK
         MRmYAgq2NCOND1QSmKEyD56IZK+TAqfDUvoA2P7bkDXwKyQPYpJmCvid38DbllyLzkcE
         AvUexohIh20Qj7z6Alx2vUpPyaugyXs6TyjIy0cZZ3ZzJdEXZzU+pEYVdM3QbDM98Sm1
         EWeEsj9HrxryXUGimDaT8vwKDBfZNT04Pho6PDfjwJtTZ/2VSGGRKwl8TealXjC8rQ+W
         Xa/w==
X-Forwarded-Encrypted: i=1; AJvYcCWpdTyTICS6eAfKY8V86v/rdRacyIpzuCJhSSbnQk8yBLbE2D2q9oGFJuQ8e5Zosjbj+/jIN8v8E93MhIimYqpZQK7TuaR81d9mJA0E
X-Gm-Message-State: AOJu0Yy0FJjYgCuk/FNqJi5lDfnVUGw1O54QG8iHpuVVFeWz9mg6gN3b
	egVSNKvCpiZkI11m9qft85/Dc1PEzOIwonNfJzspSTCB2R/FVItLEQI3AfzjLw==
X-Google-Smtp-Source: AGHT+IEJ5nbdhE42w3G704058D1d35mQpG8k93pV0OzcXNwLvIqqhhJHitHMTlm1oAZ/Re19xJq4Uw==
X-Received: by 2002:a05:6a21:3945:b0:19e:cce1:ed7e with SMTP id ac5-20020a056a21394500b0019ecce1ed7emr25404565pzc.62.1708635641391;
        Thu, 22 Feb 2024 13:00:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h2-20020a62b402000000b006e45c823660sm9172303pfn.122.2024.02.22.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:00:41 -0800 (PST)
Date: Thu, 22 Feb 2024 13:00:40 -0800
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: "Tobin C. Harding" <me@tobin.cc>, Greg KH <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Message-ID: <202402221249.FA17A8940@keescook>
References: <20240218173809.work.286-kees@kernel.org>
 <ZddnEtnxhJsafdcF@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZddnEtnxhJsafdcF@tycho.pizza>

On Thu, Feb 22, 2024 at 08:24:02AM -0700, Tycho Andersen wrote:
> Hi Kees,
> 
> On Sun, Feb 18, 2024 at 09:38:12AM -0800, Kees Cook wrote:
> > Introduce --kallsyms argument for scanning binary files for known symbol
> > addresses. This would have found the exposure in /sys/kernel/notes:
> > 
> > $ scripts/leaking_addresses.pl --kallsyms=<(sudo cat /proc/kallsyms)
> > /sys/kernel/notes: hypercall_page @ 156
> > /sys/kernel/notes: xen_hypercall_set_trap_table @ 156
> > /sys/kernel/notes: startup_xen @ 132
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Patch itself is
> 
> Reviewed-by: Tycho Andersen <tandersen@netflix.com>
> 
> And if you can carry it, that would be great (see below :).

Sure!

> This does bring up some interesting questions. From off-list
> discussions with Tobin, I believe he is not particularly interested in
> maintaining this script any more. I was never set up to do the PRs
> myself, I agreed to be a reviewer to help Tobin out. I'm happy to
> adopt it if that makes sense, but I'm curious about the future of the
> script:
> 
> 1. is it useful? (seems like yes if you're adding features)

Yes, LKP runs it as part of 0-day, and it's found leaks in the past[1].
(Though its usage could be improved.)

> 2. does it make sense to live here as a separate thing? should we
>    perhaps run it as part of kselftests or similar? I think that e.g.
>    681ff0181bbf ("x86/mm/init/32: Stop printing the virtual memory
>    layout") was not discovered with this script, but maybe if we put it
>    inline with some other stuff people regularly run more of these would
>    fall out? Maybe it makes sense to live somewhere else entirely
>    (syzkaller)? I can probably set up some x86/arm64 infra to run it
>    regularly, but that won't catch other less popular arches.

We could certainly do that. It would need some work to clean it up,
though -- it seems like it wasn't designed to run as root (which is how
LKP runs it, and likely how at least some CIs would run it).

> 3. perl. I'm mostly not a perl programmer, but would be happy to
>    rewrite it in python pending the outcome of discussion above.

I am not a Perl fan either. It does work as-is, though. Address leaks,
while worth fixing, are relatively low priority over all, so I wouldn't
prioritize a rewrite very highly.

-Kees

[1] https://lore.kernel.org/all/20210103142726.GC30643@xsang-OptiPlex-9020/

-- 
Kees Cook

