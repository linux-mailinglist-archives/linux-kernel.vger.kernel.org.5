Return-Path: <linux-kernel+bounces-45353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C49842F39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E098286999
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AE125D5;
	Tue, 30 Jan 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4stz5ff"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0114AAA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651743; cv=none; b=T4OX7o/Pse7bbXMk8uzKFNh1aLN+4JGsGtyHP/3lNCCvlgTFNvXKBQuWPJTxtC2XsbNLkootZEPzyFqhim4rzsbEk0S/ujQsGzlJ7/4b3OF3aOasim9zTrskeJchLGMwtHaaPv3OJCJ3KYsmiJvVnUZ4VCCW4q6G1KxAaK3maLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651743; c=relaxed/simple;
	bh=Q65Legcaqxpk83zwUxTW+gQWMAoQAmgQ7r7moKmFE/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D53pyphmwXJe8pTBbrBdE4AH5zyL7nYP2LAs+Z2ZVF4yEvJRzgmSplFlHpqHmg8vd3iTwmEFicz6TtBxC94UzGldJxHGBmFm7GbFIl7vpNVbunu2UVMGDRABelXwERnGmQ6Sx5DmcF9k8KIDV/mtWvb45KPQGcl/HkJydFQ0jAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h4stz5ff; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so2713598a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706651741; x=1707256541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgCw758SnRU10FmXGJ6fL0E+0y68xRsCAN6bqEGIiyI=;
        b=h4stz5ffhVjUZ6HXZFpmFWmSsXE4MmAj6prdup2kNs+ODL7hU1+L9oaEbq5wrhVUHZ
         EglrL2QccnN+hUblX7n5PGyaMe0ncE9OHkA8qs2k9egMraNr4F8puUpvSLbxv7FiW5QQ
         VT3zDednCv8/hYlj1qxOH5ranKNlSWsBy0RJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651741; x=1707256541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgCw758SnRU10FmXGJ6fL0E+0y68xRsCAN6bqEGIiyI=;
        b=TtU3vRRbACHHAyE6CiqXbFEooda5gOPeod2EI4RE13cDfRwkQuczwUP7ALDmwMJhGN
         6Ab/t1qW0ixxWKF97C+4+gdopO/l3BlgNbjtlMyLRdTex7XIVLre5q+S+wgAf63W61fB
         scrEextRVjfoBPmHtGZvvl3Yi1yCj89a/EXOHHQ3R9jCheRrxhijRILPSE7ouH7lF2Qg
         gd27BAs0pYu9FGqzh/rsMx/jC3/qDUyozCC80DxoReaLiIbEaFzqgj7ZBIidl5th3VnD
         kxz79Dw6L65cgKslRkry5+gFeSLsMYh5JleOejbsiXcdrSKBKklQet2/OXg/7wXkxFMW
         jTfw==
X-Gm-Message-State: AOJu0YynFwbSE6OpWH10ZWFkuqtCCqogmryr9+Tp7U4a0fsLIJmuJKLK
	FpBXYaqWlhaUqcXB61dw8f2H3AofXjlzXjBe4wSwVZdZ5M7yEQSd2yaRH2eaxg==
X-Google-Smtp-Source: AGHT+IFNNuJ2tpadInRyYT/MIBretl+h+m8yAcR8cRLKOZm1Oa7taQG2Zh8eDqCVcHX76clnYsUfpQ==
X-Received: by 2002:a17:902:bcc5:b0:1d7:8816:a81f with SMTP id o5-20020a170902bcc500b001d78816a81fmr6408751pls.134.1706651741309;
        Tue, 30 Jan 2024 13:55:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm9078626pgb.50.2024.01.30.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:55:40 -0800 (PST)
Date: Tue, 30 Jan 2024 13:55:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, David Laight <David.Laight@aculab.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Message-ID: <202401301351.83A809993@keescook>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com>
 <20240130150721.GA692144@google.com>
 <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>

On Tue, Jan 30, 2024 at 04:18:42PM +0100, Rasmus Villemoes wrote:
> So here scnprint() would have returned 1, leaving size at 1. scnprintf()
> has the invariant that, for non-zero size, the return value is strictly
> less than that size, so when passed a size of 1, all subsequent calls
> return 0 (corresponding to the fact that all it could do was to write
> the '\0' terminator).
> 
> This pattern already exists, and is really the reason scnprint exists.
> Yes, scnprintf() cannot distinguish overflow from
> it-just-exactly-fitted. Maybe it would have been better to make it work
> like this, but I don't think there's a real use - and we do have
> seq_buf() if one really wants an interface that can build a string
> piece-meal while keeping track of whether it ever caused overflow.

Yeah, I think we can take the handful of places that really need to know
about the overflow and can't reliably use scnprintf() and migrate them
to the seq_buf API. It should be much easier to use now[1] too.

That way we won't add a new string API, and we can continue to remove
snprintf.

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/seq_buf.h?id=dcc4e5728eeaeda84878ca0018758cff1abfca21
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/seq_buf.h?id=7a8e9cdf9405819105ae7405cd91e482bf574b01

-- 
Kees Cook

