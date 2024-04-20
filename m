Return-Path: <linux-kernel+bounces-152335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 839BB8ABC90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B684B20DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07733A1C2;
	Sat, 20 Apr 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W6hYVprZ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28688DF5C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713634479; cv=none; b=btGZEmFEvCnTkirN4yO7kGZ9YiI6eftFlCajP+eYxF+vwmMhsfYVmvPWXeC9QwgZ/OBX3ppyF4NS3FJjGbJGxJlUFPAYh53ExAPMU2FttkxILIF0i6djEPQ26vNzJ/EP7qTx6dNpd+RggOs9JzIuTfN7xMo+KVPBj1v/Wt9SlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713634479; c=relaxed/simple;
	bh=FZui6/jAqpSCf4l3i1TeoGcFiXdATKG0xPtGvjtat9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVqQeVUL0Rx3vUbsmLLGXo5CskGfjqut2a6VbpGAlBQ2ioZzb9gXPWgZyO5rBQPP33f6WLF0xB6LN4d63mFHY2bKn3HjqsuG4NXqAiph8nyGN2Ga9TT6ZnPVf3Bp5uCC/jgVu2PzTzk5QvItV3+zWVExcKRaPCJ37oBnKkL8WMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W6hYVprZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso4703595a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713634475; x=1714239275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azgKuVXWo1stoA6zH6ErzXlXBirYMEprw5yf7intLHQ=;
        b=W6hYVprZQ1Msy2EtH4FVgc6phK9xWnkp6I8XK40hIPj7AIZ3CAtUwOBZn99XOOJttT
         3fPqKfo/JyQec9bNJWKoE+vWTNbDF15fpcdXlecbHacj6XoFb/NtYYziqdhdHBkJtv08
         amLQWoLYld37W0WMmI7Zanb63jPiYm/L/NAVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713634475; x=1714239275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azgKuVXWo1stoA6zH6ErzXlXBirYMEprw5yf7intLHQ=;
        b=r3zRzBIuACvEdhFZ9SWVaaFq77D6R4M+sqycpxnyn+UwEXfXdpjWviwOT512X0wcl6
         RmIV5WSWcIkVhCq6Z9x89c/eiofx86sw3qaoQu51q817STUUfMiaYG4TwXuKQXirwElI
         JtHwH13pQ3djdvmWJjtUe/c77aQfJ1bo4hVhykpO7QN1Ev+htMpxMi6qM8EaeVdGLxJR
         c0OB1J6TLJdUKta+yjnxO3O/ulsT98IoPXFACTnyuDAi/zwAHT6eJfjS+Q7y/g/Syk7l
         KHSxMjVwCQSF2Ys15fnRrs8q70pOczTXuDHJ+tNq+rN8DCvXiAYHHLxTRVIvP6uz8RTn
         ++fw==
X-Forwarded-Encrypted: i=1; AJvYcCVewi9wvAotjgN8P+Ppem9TglFK10mGyTxS68rvfvQU5OFv02BxtNXavWb4jr7X/ybEaZxTOBNxJ5eMyjJf+OOyycDNCQgRprX6Vk3w
X-Gm-Message-State: AOJu0YxQG2vRyyyPDpvBECDiw2Gng9+awtU49ZOOrsxEl1BgK3h/3BVT
	AQHrJDeiRBf2o2BgtFhZku681bsdsxkq+8r10qi4zHWt8xbE0FKXHIHKC8NSFqWG8cbWt4Mjkjf
	gc7E=
X-Google-Smtp-Source: AGHT+IHv9YqCBLsw0E1Pqjt7cjtf7kyc88aWfeZZkS+YTfO26huw7+v62olhVrFMLOCedHkHChzqgA==
X-Received: by 2002:a50:8e58:0:b0:56e:2daf:1ee6 with SMTP id 24-20020a508e58000000b0056e2daf1ee6mr4143777edx.16.1713634475054;
        Sat, 20 Apr 2024 10:34:35 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id p8-20020a05640243c800b00571fad0647csm302926edc.74.2024.04.20.10.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 10:34:34 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44f2d894b7so287911666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 10:34:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzECgP10NDd4XmN3U3b2QBAljb5iF4ilfVgim8sNlpiS8lW6ay8EMM65eXuclXSVRvfEuo+RObufEdEE95qw9GZ/vcyFpHDSkARkGp
X-Received: by 2002:a17:906:c0c5:b0:a55:339d:bd20 with SMTP id
 bn5-20020a170906c0c500b00a55339dbd20mr3813061ejb.51.1713634473876; Sat, 20
 Apr 2024 10:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
In-Reply-To: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Apr 2024 10:34:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
Message-ID: <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 04:12, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since n_gsm is designed to be used for serial port [1], reject attaching to
> virtual consoles and PTY devices, by checking tty's device major/minor
> numbers at gsmld_open().

If we really just want to restrict it to serial devices, then do
something like, this:

   drivers/tty/n_gsm.c | 2 ++
   1 file changed, 2 insertions(+)

  diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
  index 4036566febcb..24425ef35b2b 100644
  --- a/drivers/tty/n_gsm.c
  +++ b/drivers/tty/n_gsm.c
  @@ -3629,6 +3629,8 @@ static int gsmld_open(struct tty_struct *tty)

        if (tty->ops->write == NULL)
                return -EINVAL;
  +     if (tty->ops->set_serial == NULL)
  +             return -EINVAL;

        /* Attach our ldisc data */
        gsm = gsm_alloc_mux();

which at least matches the current (largely useless) pattern of
checking for a write function.

I think all real serial sub-drivers already have that 'set_serial()'
function, and if there are some that don't, we could just add a dummy
for them. No?

Alternatively, we could go the opposite way, and have some flag in the
line discipline that says "I can be a console", and just check that in
tty_set_ldisc() for the console.

That would probably be a good idea regardless, but likely requires more effort.

But this kind of random major number testing seems wrong. It's trying
to deal with the _symptoms_, not some deeper truth.

                  Linus

