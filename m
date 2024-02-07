Return-Path: <linux-kernel+bounces-56475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6304D84CA9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179BA1F27DC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB75A4CB;
	Wed,  7 Feb 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CD5Y07JU"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921355A110
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308401; cv=none; b=kv7E1GjZJQFViv0/noENehFrG60cqW5FJACRnUhPTdYk1VCBf4/eTHRqgzGPiIb8slQHSWe6JO8GUfP1743uGRJRFZlWn9QS4I45azgSC1eOru9M2gcyuU+5a5J7EodE7zEwmah6OudcU9XsWIz8yR2+vyYvkmc24AMCfAJ3tto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308401; c=relaxed/simple;
	bh=VxHyCQHmmWVFgH5PeO7vMYEFUMu8X9qb6MlTex58/bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfXgOGchNcorK/YKe+1aAx3BRxji9f+D+z+/r53LNGOsFL8juDQIwLQGkOUn32JAM6FCsndambguKg+kY+mNliosjvldnLRD89k0EiXwIQ3BjYj+WN8wP0JDIZ5CUiFPn+GOwDw0f95zXNqvKEWjMqq+X96mXKVAmWsN8Hxed3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CD5Y07JU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so3061044a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707308398; x=1707913198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zDDMQO/u1F7IHrBB5QtsezbFNTZVMkbylHAKSxKrCA=;
        b=CD5Y07JUcCPJJb+yz034svMye1nvUSLCv1D3WcQfJK1w18eZG9lELCoZS7Pe6iDwRm
         UG4U2Qn6Z/MJEWjuTZNZuCXl4j8FwjRd2YIkbJc/zqGpRw6gTPA447/taFrrpGRY3cRW
         QcFpAYAmz81hO3NyDvQTqPUVfQOqCne2pYUNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707308398; x=1707913198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zDDMQO/u1F7IHrBB5QtsezbFNTZVMkbylHAKSxKrCA=;
        b=mysLG2bQj5PnRD4yQt9QILlHuIMj6uFCDjZWC9QhckN/LM4fgFC0F6kR8+/Ug3dyzR
         nYQAAOvoQ/heqQinMwFYx5OGN8y3z8dxXIj2nv/cIo8uQXYmG3TS2PxdlYPwd3FA53H4
         cNsaf8OFg8uFzweuErA5xLm3OwXwdfWp68ud8iguOh947+cwDIw8zk1z8VnCFcLrLkw0
         lYlxWV9/Tmz1LeSKjhnMb3v/MnAGLtVqZmfWuEzGKwRde1grzmw2XN9kONkFHR+QPPGN
         7YHHf9G5uzcbtm8c54iR62yHuu6UxYVyZm9CW8jq/fDR5A4FaljMjvU52t29mW4QASiC
         7Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCVHeDTr4VCBvk41QGg09//ziFIhY/ivIH/QQTP6f2qtJHTrfw4ynkkNP1aQ7RD8APeMUOrDvaYn1tlbJj4nnbsZ9US7D5tgwGHL6HkC
X-Gm-Message-State: AOJu0Yxi0rHIhTkWpLeM+l4kR0HgXq2uQ8dQYuxkXEtNow918MH/0Mbv
	w12nbQraNIiwBRbr/EVXbcMx/6VhMdVqt5q1ACU5+e1prNU9u+0Qu91iLzmcV5T0fmlayMuEnFb
	w27TWaG/kS4bom6N/RUVUtXFKoP/vyLhDpF9lFQ==
X-Google-Smtp-Source: AGHT+IHzKQ0RYqAT/GDn4Hmr1R2HRVZELwU6NMz1FXiolA++wwYj9diX44wqd6JLXXbOK1o7LQA9USbuPopflB4CpWI=
X-Received: by 2002:a17:907:7703:b0:a38:5b3c:7c9b with SMTP id
 kw3-20020a170907770300b00a385b3c7c9bmr2616933ejc.18.1707308397758; Wed, 07
 Feb 2024 04:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <20240207110041.fwypjtzsgrcdhalv@quack3> <CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>
 <ZcNw-ek8s3AHxxCB@casper.infradead.org>
In-Reply-To: <ZcNw-ek8s3AHxxCB@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Feb 2024 13:19:46 +0100
Message-ID: <CAJfpegssQ73Wv2w0F6oHm7yhUP3Q2n2vmqAPWw2E72Xa2MMSSw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 13:00, Matthew Wilcox <willy@infradead.org> wrote:

> To be perfectly clear, you're suggesting two things.
>
> Option (a) change "all" code like this:
> -       ret = -EINVAL;
> +       ret = -ERR(EINVAL);
>
> where ERR would do some magic with __func__ and __LINE__.
>
> Option (b)
>
> -#define EINVAL         22
> +#define E_INVAL        22
> +#define EINVAL         ERR(E_INVAL)
>
> and then change all code that does something like:
>
>         if (err == -EINVAL)
> to
>         if (err == -E_INVAL)
>
> Or have I misunderstood?

Something like that, yes.

Thanks,
Miklos

