Return-Path: <linux-kernel+bounces-34571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A88381D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E50B27B02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A31487EA;
	Tue, 23 Jan 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hyJk89p0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202EA1487D4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972081; cv=none; b=uTydSia4t1vcEQBBTC1HX3/6QWp2o05h4vNbZh3MEW5nAyjK54agoPHRgJ0Mh/FD7dUasVQbCWG7Z4imVbw3I0QDi8nNHZkcyGm+71aP8UTV8zqvqQM+c1zWNKdiO+uqwrn6JbqXx/x1MgRBKcREW/a5qSJHWA3BfTAaU6A8+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972081; c=relaxed/simple;
	bh=uDChScHA8/keZbVJoSWpHzwdBcCCYoYhS7GeA9recLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzHmwfGkp6v4ged5ido1z0AnV8dLR5ittQ3gJsjM12nI89vrFjIFMyuqiS7nuv6LIQ/6ka4vFqTC80wL25Q/xsOiyJczC1LQah5iHXxTdZPs2m6AGCMmLtEb5q4jTUcGgiZLSGgkoycaTs9GYBsuVOb+EpZ9AP39oM86/4/jAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hyJk89p0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-559edcee47eso3179891a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705972078; x=1706576878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FqBTpX0vWqNsF5lS1C9n4e9u8Ca0XIeIP2mzdNVJ8OY=;
        b=hyJk89p0lr7D4H5IFrTlLMSqx0IE3sCmggufqrn8Dc2/LW9zYTjwJxt+NIHMocrV3e
         YtVei/DbgGr5T4XeTuBl9VUVSXTXVwvessH2G7uIgMYY2Q6EpqaR7ZKegGwEAD6ZPkXN
         heto7ZrQk0iB8EK7mOUUgiRlvqR4LIEWayrQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972078; x=1706576878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqBTpX0vWqNsF5lS1C9n4e9u8Ca0XIeIP2mzdNVJ8OY=;
        b=P6QpgdvgltIL79gp43gcY+6qUrZyqUmNz1/CWoPvYNtjDCDL3LSPIAxNRg9HHF2WQt
         CfE+x09/JVwFCS0eQ7VColgr8Ox3cJ+vBp1/cpYImWBZK/XFI4YYMHGQ0uoRlSiJQDbb
         JgLn+ZzCwMuIpIz4PfUQdC9AXmHJFvOaJV11D1WnY/hlUanOOzZxOloAbKN7uRemgtu9
         GkEBnLBHchc4YMZCN48kbQU0qYqLBu6Jzp22do0tuNDBNfckBmF32mpUK18HAT+vtVkt
         +v04ke6wLqv8XFMqbBXIJG+YBZVBlMHEj9WK8gGREqxgrGYhwfCDxjJCLTZeD6MQRFe7
         GAHw==
X-Gm-Message-State: AOJu0YwX7VEFhE4XOo1NRTrOnUrhM5N6z0P7jwHLqQxbXR49SlXzZYxK
	70+8hgLkMLP5GkZMo0WzPxuw70L6HqeA5dJxlya/bvdcH86ZfuPqnNw0ePPUJCgNBOw5ITAxkFL
	x7hspkQ==
X-Google-Smtp-Source: AGHT+IERA+6HlqKfTiUseBTME3z2E7hqP1kOv5iHiwgD8pdOHhnEfcyja5dpqtVkOE9nTYLKd8M03A==
X-Received: by 2002:a17:907:1689:b0:a30:7362:a654 with SMTP id cx9-20020a170907168900b00a307362a654mr966992ejd.43.1705972078129;
        Mon, 22 Jan 2024 17:07:58 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906c00400b00a298adde5a1sm13847791ejz.189.2024.01.22.17.07.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 17:07:57 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so4270476a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:07:57 -0800 (PST)
X-Received: by 2002:a05:6402:14d4:b0:55a:553c:a987 with SMTP id
 f20-20020a05640214d400b0055a553ca987mr474350edx.79.1705972077074; Mon, 22 Jan
 2024 17:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-34-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-34-keescook@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 17:07:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
Message-ID: <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Brown <broonie@kernel.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Vasily Averin <vasily.averin@linux.dev>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 16:46, Kees Cook <keescook@chromium.org> wrote:
>
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(),

NAK.

First off, none of this has anything to do with -fno-strict-overflow.
We do that, because without it gcc ends up doing various odd and
surprising things, the same way it does with strict-aliasing.

IOW, you should think of -fno-strict-overflow as a hardening thing.
Any optimization that depends on "this can overflow, so I can do
anything I want" is just a dangerous optimization for the kernel.

It matches -fno-strict-aliasing and -fno-delete-null-pointer-checks,
in other words.

And I do not understand why you mention it in the first place, since
this code USES UNSIGNED INTEGER ARITHMETIC, and thus has absolutely
nothing to do with that no-strict-overflow flag.

So the commit message is actively misleading and broken. Unsigned
arithmetic has very well-defined behavior, and the code uses that with
a very traditional and valid test.

The comment about "redundant open-coded addition" is also PURE
GARBAGE, since the compiler will trivially do the CSE - and on the
source code level your modified code is actively bigger and uglier.

So your patch improves neither code generation or source code.

And if there's some unsigned wrap-around checker that doesn't
understand this traditional way of doing overflow checking, that piece
of crap needs fixing.

I don't want to see mindless conversion patches that work around some
broken tooling.

I want to see them even less when pretty much EVERY SINGLE WORD in the
commit message seems to be actively misleading and irrelevant garbage.

Stop making the world a worse place.

                 Linus

