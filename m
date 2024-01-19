Return-Path: <linux-kernel+bounces-31637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAFD8331B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CD72848CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2B59174;
	Sat, 20 Jan 2024 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZlTm3ICR"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050F58AAE
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705708804; cv=none; b=iHdnDDEce+Z1P/FwX1yDd9qW5dyQewlR3U37xHuPJL7VM9+4EzvcfF6ZwhX8edtljgDhV1Z3757ix/frnl6Aq1QBBIZzqqaP4r6nQ/+9fZgDFBcdaWOXUEyHmFTMDBuiOJg2z4TEG2GbwY/to6MbO5dkHO+ReOHd+vyQLcgSzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705708804; c=relaxed/simple;
	bh=2Q6PXCNZrdoKAZHFLazUfCoSdXno+GFbgX4A6oP8KSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoGUSA5JY8LdLKfyTNDDXgSkdJkpFGYpPhStkxe4G+eSBkYpl+0ZeHlQomG41TRBoWOqYTk9YOB8BsIAZXW6XlBOxjCaC9CojBtXgnKKn+ZM4Vkmja/ChJpzc4653ipTNqaFurLwUEHnJsIetfmalkN9TMU8ErksnowIYg9jnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZlTm3ICR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2d04888d3dso143268466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705708801; x=1706313601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOFYb/RTZy8MO7nlFfaeJozsL+6Jsio6dI6byv2M1AM=;
        b=ZlTm3ICR3ZRy0BgfySAy6axvWXSQt5OZO5B9Ol118+A9siYwKnWX9mSZBp0lJQYN1u
         gdKmE8BpVMknKVWR7HwutEGPUGCvwkrgjdO1g+XtNmV44XC6hsrWavTRRVA+wFhokcbx
         80tY0AyvD/6WbcFCLH/LhmUWjvWdo6B1bIpYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705708801; x=1706313601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOFYb/RTZy8MO7nlFfaeJozsL+6Jsio6dI6byv2M1AM=;
        b=TTsK16mv0XOb9iIvY0L48613EfK70WHrrNhIf1aRrsvfrElnTEM8aQHi0zD5NmuxQz
         0b6RydDJCHEHZs7tpMGvbdJ18qz+YhBfLFdZ5zEjf2U8dGThpWFONb/zlB1b5YkTJcB5
         EO/ZF2zmITCR/Lp3jSUgkTmpg4Klk4BZh4WWHutar6g/Pu+cAizhxtbR5vIrmN6NgK87
         1a0JavbMG28xowUjo71auC+aVC/eopiBlaKOerZ3eHS2sDJcOKXAeQQg06ond8cxdTsg
         g9j9EGdziaBNXN5uELuKVM76mf9DrzQIEhTwNfRwUx67aSt8t7b1+VYybukhokYtz4ag
         Qr9A==
X-Gm-Message-State: AOJu0Yxiyws1sIhuZjy/Zge+BhRHvk/EiucHzEtDIRduXVMBKfYIzc/z
	ew0Sz4lzPvlHagmLdqh5xugeMp2E0/2ecEGtxm8MOUYbkvcYSsQD8MNAoGWGWj6e9fqE1GdrT2I
	I6bnJcg==
X-Google-Smtp-Source: AGHT+IF+0rOMYC7GwCXSCcsckAdNOg50+aPcxsWK7zJVbu6CBtQXyVWxJvDriSRCn9/ZWQjh9TNN7w==
X-Received: by 2002:a17:906:f8db:b0:a2d:359b:b880 with SMTP id lh27-20020a170906f8db00b00a2d359bb880mr276107ejb.13.1705708800732;
        Fri, 19 Jan 2024 16:00:00 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id ce2-20020a170906b24200b00a26a0145c5esm10793433ejb.116.2024.01.19.15.59.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 15:59:59 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a44bb66d3so1518167a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:59:59 -0800 (PST)
X-Received: by 2002:a05:6402:228a:b0:559:b648:b954 with SMTP id
 cw10-20020a056402228a00b00559b648b954mr243986edb.47.1705708799556; Fri, 19
 Jan 2024 15:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401191311.B6AA79D@keescook> <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
 <202401191450.CAF805687A@keescook>
In-Reply-To: <202401191450.CAF805687A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Jan 2024 15:59:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whu2k-PwHVZS4uKj3kksVUF_Fqzap-YXwnVKeC6S9pBNg@mail.gmail.com>
Message-ID: <CAHk-=whu2k-PwHVZS4uKj3kksVUF_Fqzap-YXwnVKeC6S9pBNg@mail.gmail.com>
Subject: Re: [GIT PULL] strlcpy removal for v6.8-rc1
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Whitcroft <apw@canonical.com>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Brian Foster <bfoster@redhat.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 14:53, Kees Cook <keescook@chromium.org> wrote:
>
> Sorry, I should have called that out in the PR, but the commit itself
> had my rationale for intentionally leaving those in:
>
>     Leave mentions in Documentation (about its deprecation), and in
>     checkpatch.pl (to help migrate host-only tools/ usage).

Hmm. Yeah, I guess the host tooling is an issue, although there
strlcpy makes a lot more sense since I think it exists in various user
space libraries (while strscpy() is kernel-only).

> If you feel like that's not right, I can either respin or send a
> follow-up patch?

Oh, I already took the pull request, I was just reacting to leftovers.
This is not a big deal.

              Linus

