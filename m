Return-Path: <linux-kernel+bounces-85453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0A86B633
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D451C21F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7915E5AE;
	Wed, 28 Feb 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmrImjj2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12515DBC5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141973; cv=none; b=ku56GG1gaKqpEWhwgyp8+UfAJWK+kQTJho1HEqv3TEvbuKSgrZXnp0O9WLvWFx+K4A/7RVOb8AzSw7sIUHdiPOGDT9Y7EQx8OGQiQVXA+TbNS1qyXhNdjrFpYPlblme54FmeKg2H2cCeunes1mgFJOCz6hP3LWvoNQB5JPfGPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141973; c=relaxed/simple;
	bh=QC8X8RLJg/EcMAAM6B4fCWDSCW+dwBVTLUthDex9rDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/7hIj9IMHOGYJDtDV8wKM9NCDfCfQUIuNAJPHh1uHrHBS7TfdCX52kIxJFXx+Sn8IPM9YQrmW2EGAlwt0suAMa+2wlwlQs+WNlWw8HmozXFWUy0PVwozMj3+F525pvYavUlMycYMh5KONRJAgfR6YRTurtmYauHa3kYHY26K/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CmrImjj2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299e0271294so3820062a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709141971; x=1709746771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NODDRAJhqWW7+B+ilVMpkZpvr1dJVh6fzecoPQ05aGY=;
        b=CmrImjj2aqfntU7U0gcG7SHvevqf+uO71X/YwqojTsy2H0ulvOGGMhj9hnhOg7ntYR
         O+HuVbSzj6jVauuSSX2aSK/x34vd7iMFJhNxrrfugi2fqqB0ZckeDGvklPjNcBSEf2Uv
         YNW80ZATRm5WtR35OE0SUB+V0Yocmy6hl9NEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141971; x=1709746771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NODDRAJhqWW7+B+ilVMpkZpvr1dJVh6fzecoPQ05aGY=;
        b=tUWPUWiWxGNIOnQQoOaJp31SHuWMmk5iFhpDJHgWGU/PQaQGVQP6x7m+LSBBZjcgw4
         a75foW17oSQVOQlfLoneLzIJwWZ4tSyg900NanxfJBawwIfhbFxPZGl2Pk87S2PvG/wS
         CXt7THmQm71CrZSGjW12hufb5PR29O+SNaWDlOyHZGbfItWUio0ijNSl9I86M5njK/Xb
         XKi+RQMMyWX6QBP54cz+zxNrqYKwELaFk7t5Sr7DC5DF+H7Wc0Zh5whbup1LAA30q8ug
         b5BH6L1lcYQd4g9NzzcSEPB1oLwwMbqeR/4TuozY+41axsE81v9j08gkv3bqkp/Rn0xx
         vZmw==
X-Forwarded-Encrypted: i=1; AJvYcCVtVk6f1mtBwpGS5uczFLqn0nJq+ijv66FrqzqvHPZBPATeqLqj6vEoyDgPXOH19SBX72/NPkzor2SOHBxNYiyT5qr5cZqc6R5vkvaj
X-Gm-Message-State: AOJu0YzQl/Z6iBr9k1CaMs86AOzUg39/Qc8ua0G6G/kjxP6uosHCkrwJ
	Djrk1Ew+XBYOhZOJQZq9ec58EI2m0PYvQc9+TfAYx+E1ZpMEU2drWfF24HCjFw==
X-Google-Smtp-Source: AGHT+IGp/woc+TexLF/WvhjGKbASp59EBqxFySULqYfcyiys7bw1alzskx50yFi4SAk3a5wWSI6Icw==
X-Received: by 2002:a17:90a:cf8a:b0:299:58af:c873 with SMTP id i10-20020a17090acf8a00b0029958afc873mr400790pju.10.1709141971163;
        Wed, 28 Feb 2024 09:39:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sz3-20020a17090b2d4300b002961a383303sm1953273pjb.14.2024.02.28.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:39:30 -0800 (PST)
Date: Wed, 28 Feb 2024 09:39:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Clang __bos vs loop unrolling (was Re: [PATCH] ALSA: asihpi: work
 around clang-17+ false positive fortify-string warning)
Message-ID: <202402280925.5B709A60F@keescook>
References: <20240228140152.1824901-1-arnd@kernel.org>
 <87msrkhcz6.wl-tiwai@suse.de>
 <1265517d-b98a-4ec6-9215-10cd988ff78f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265517d-b98a-4ec6-9215-10cd988ff78f@app.fastmail.com>

On Wed, Feb 28, 2024 at 04:03:56PM +0100, Arnd Bergmann wrote:
> My first thought was that clang warns about it here because
> the 'u16 adapter' declaration limits the index to something
> smaller than an 'int' or 'long', but changing the type
> did not get rid of the warning.

Our current theory is that Clang has a bug with
__builtin_object_size/__builtin_dynamic_object_size when doing loop
unrolling (or other kinds of execution flow splitting). Some examples:
https://github.com/ClangBuiltLinux/linux/issues?q=label%3A%22loop+unroller%22+

Which is perhaps related to __bos miscalculations:
https://github.com/ClangBuiltLinux/linux/issues?q=label%3A%22%5B__bos%5D+miscalculation%22+

-Kees

-- 
Kees Cook

