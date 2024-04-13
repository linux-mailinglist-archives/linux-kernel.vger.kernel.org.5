Return-Path: <linux-kernel+bounces-143825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A8C8A3DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C9E281D15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A784A4CB2E;
	Sat, 13 Apr 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="arRQsuH2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9B42069
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028092; cv=none; b=Oc6tYElv0syiJrp1Rb52GrQMYRh/RP1Pd5b0qRI83Ht3dSCX3eeDtK/7YcYeA5+he6wX+oQTdNTOgnlW38B0WnU2Gd708sfcNQzP1xePIHKIPloahr5XETfYhYFs7rdDmK1woNJ2JIi8sN7dlqC49s2s/Ed11lUOIdqCaetmpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028092; c=relaxed/simple;
	bh=/khNbArPndluhqCaANPbWbHRwmuLkIPd8/Lt2wdByhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjf2nIdDz7q0ajCUj5c2YhsFNhQI1P+/J0rDKtI5eHi8w4o6LIvb8fTbe230nZX0RltxrKS9U+k7bKpwOjOQpSip33VgdzEeO9Mr/c8viMnP7dpMv7HbpvBV0yqm42i/dXoyst+eUi4CYR/iT66Rj3qTCFy0LH//rIehFtYJIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=arRQsuH2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516ef30b16eso2232701e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713028088; x=1713632888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4OnnwVVaFTHIt4jRXFbPcAEbvxYG9TZ1uG1UtFPzbms=;
        b=arRQsuH2WJqyMC4vkUo2mGe3dfiOcrRDal9eG31aNThmzmFiajyzgSSy9RsO5VB6go
         XnvzmJDW7qS3FW4ZaRnIyD5n3O7NZg9Gx5IbRW38y/mXkT93jZ+LW3dWrAMnZRCQOC59
         xOGjtN4CwX7+U6l3iYWDhQTzwc/yAr4DL20EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713028088; x=1713632888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OnnwVVaFTHIt4jRXFbPcAEbvxYG9TZ1uG1UtFPzbms=;
        b=p2fhqFSwMNLSBcYdXfAjd3501NayG4TJrkt5jP1Y3psFIP2xn2tj+dSZIKuq6Z/Ocp
         WDXp5+++HnIBxgwfQ318EJJcTpycn8NRUF4AvjIOxS8yb/c3pYHqLmllVV7BEG1XwtZR
         oAbwPN1gt0/eO0whC2SoHzVWBYjuHYMDFbWEk6C9+Mv2M8ICTeRvB+hY+SOvRCITXgG5
         TjDqnIYXRCbGqxou8qZv6aoBgOrygOB6CNlYVQKjU7x9LoC8A9euTcnnk4Ly/ZvOUN/h
         0DlTPUixo5DqLNEYIFxv6bcpfIZPtwtH4z3wwtbxqkKwXkW0BMr7Rw21xaaP+b7HQb6a
         uOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQtTV4jnrhqS22L/hh5eHxGNeY4+vbjMrETHoZlkBc4KLsS0TQQA0J/ELCnIuH+OlnHMhbjo7vTLrZ7pBffEFzrTODE0LckQcF5ATI
X-Gm-Message-State: AOJu0YwpY57gbnng/1l4C3iCTJkTbOptP+/gQp5ETIRnqSCdOLHs8svy
	aGY8yO1WeAIKI7/cR0tAUA9+JgDdDTnBkErJ0DpbMbR22Ot3aavUa0NmkPrRN8Jad3Bj+we0sGY
	xMztjaw==
X-Google-Smtp-Source: AGHT+IF/fExxX0AaJ5wGVHm3SL1RcwmPaJg65/zy6danKaoZNzo2wH9MymXzJdqsTCmpY0zwsO4/xg==
X-Received: by 2002:a19:5e4c:0:b0:516:d538:35b2 with SMTP id z12-20020a195e4c000000b00516d53835b2mr3193280lfi.23.1713028088163;
        Sat, 13 Apr 2024 10:08:08 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id cb12-20020a0564020b6c00b0056e67aa7118sm2842096edb.52.2024.04.13.10.08.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 10:08:07 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5252e5aa01so48226066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:08:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQ/vE6dbp7JUxXb1Y/tzIDA5PCnjt82gsXC2hSabozWEon89Z2cDDqdYcuQEsIJ5bp0W2BXmfH0EA4u5jvDgHoBYFHHRdfU4s3X130
X-Received: by 2002:a17:907:5c5:b0:a52:1be:f4a6 with SMTP id
 wg5-20020a17090705c500b00a5201bef4a6mr4223271ejb.21.1713028086862; Sat, 13
 Apr 2024 10:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <20240412-vegetarisch-installieren-1152433bd1a7@brauner> <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
 <20240413-aufgaben-feigen-e61a1ec3668f@brauner> <20240413-armbrust-specht-394d58f53f0f@brauner>
In-Reply-To: <20240413-armbrust-specht-394d58f53f0f@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Apr 2024 10:07:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifPKRG2w4mw+YchNtAuk4mMJBde7bG-Z7wt0+ZeQMJ_A@mail.gmail.com>
Message-ID: <CAHk-=wifPKRG2w4mw+YchNtAuk4mMJBde7bG-Z7wt0+ZeQMJ_A@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 08:16, Christian Brauner <brauner@kernel.org> wrote:
>
> I think it should be ok to allow AT_EMPTY_PATH with NULL because
> userspace can detect whether the kernel allows that by passing
> AT_EMPTY_PATH with a NULL path argument and they would get an error back
> that would tell them that this kernel doesn't support NULL paths.

Yeah, it should return -1 / EFAULT on  older kernels.

> I'd like to try a patch for this next week. It's a good opportunity to
> get into some of the more gritty details of this area.
>
> From a rough first glance most AT_EMPTY_PATH users should be covered by
> adapting getname_flags() accordingly.
>
> Imho, this could likely be done by introducing a single struct filename
> null_filename.

It's probably better to try to special-case it entirely.

See commit 9013c51c630a ("vfs: mostly undo glibc turning 'fstat()'
into 'fstatat(AT_EMPTY_PATH)'") and the numbers in there in
particular.

That still leaves performance on the table exactly because it has to
do that extra "get_user()" to check for an empty path, but it avoids
not only the pathname allocation, but also the setup for the pathname
walk.

If we had a NULL case there, I'd expect that fstatat() and fstat()
would perform the same (modulo a couple of instructions).

Of course, the performance of get_user() will vary depending on
microarchitecture. If you don't have SMAP, it's cheap. It's the
STAC/CLAC that is most of the cost, and the exact cost of those will
then depend on implementations - they *could* be much faster than they
are.

              Linus

