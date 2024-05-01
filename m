Return-Path: <linux-kernel+bounces-165767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E216C8B90FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD29B21BC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE49165FB6;
	Wed,  1 May 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZCxbbEVl"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20710165FB1
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597611; cv=none; b=JDH2Opqz8aRoB/ILaHtJKHSsLHkKmO0J/ZzBrSXmDoy35eG+mKlUQMQCm79WVBCxFvQ/nNGlk6yJSZ9k9VEI9viFjtaEXtWy3FWi/NBofBKsEmKnJxUV4/GslHSipHII4eCPjmvE1oWr50HD73SqKoJBefLeYh8OPVoSAYWRRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597611; c=relaxed/simple;
	bh=Ar/qVvtSowlddZJ7GU3UpoafBU0STOS0g4iNU8zGeqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHujYS/u02dIffwNYtTU8kgLc973KYRmWp1ZX0IcNMROtc4pkvCWHA4vXWr8Wo/rVpl7ttY3Lyj/pxuwBho4svcrzmZyG0R8BA9iwwd94l0R4Dz4STKh746DBxqpxzXV5hbqFNM5EVf0QI89mZwuoL02IdbU6AqgHnLGWTHp4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZCxbbEVl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a58ebdd8b64so526584566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714597608; x=1715202408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEeYJfQKf2FYDJRjHSGwp+n8JlaIpd1XzlOy/wItCMc=;
        b=ZCxbbEVl1HuafuyG4y+mzyWi5AzIMOQ/TL7hIIelEhAtTqHQQ1ndOG5b9xfKQL7gAp
         dRUl2eriRgHPFhS02DWA1UZyZziCSsk3hlBZ1iqYoYf2mPPvyCOotYZ2iHjGt+ns6dLA
         iJ3+5BWthilNTy6OuDQigG3q2fF7yR8SPLWZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714597608; x=1715202408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEeYJfQKf2FYDJRjHSGwp+n8JlaIpd1XzlOy/wItCMc=;
        b=bdq6Jpt6M4ymSwCdspy8XATofD1gI7us8adlAJzYSNtcejV1CVBBKzj2/nmj0d3WEO
         PxJw+V+rmCA15Hlzhspg7MFPr9fmiaxzxLYLOUMk6qGJZGL+rw6SXVDU0LXFGbbdcnkL
         W3zqDtLMrSh0RmQkD2Vc12iPwFVcpKDSR/RGf3r9ys3QnDYsXe8Gh5uYoiwHtayiGd63
         ZYiq24knU4THrdgXXLSIyVsJhZNLIOnZ8J0DABTd1qsfvuRthEAuQTdR3JjhXSozEbVR
         dHQk1haz4hl6sBrGNCAkJBjs5mwEB793kfgluJIyoHNqe/QUjrgCJdIVudIL1Z490sPv
         I/KA==
X-Forwarded-Encrypted: i=1; AJvYcCVR2Jx+yovT++deP2Sp6lZcU4dHcScn03jbc/XzAMoLW+6z+Q7Shlempl35dmsmkMGEpsEL7EW7RL5UtpYDsiJ7FgzlIOwNTzyDEm+N
X-Gm-Message-State: AOJu0Ywpc9De+Dh2pC3oJnT7IKhIWjp4yDgD28p8vDFVtIr+jiFfE0K0
	AZWNVXXh/YT7o1jxkS5t3MfTi3dqIu5QXmGeuI+AHi48f9muYXp71yVc17dyF4NlnJ5/TP84bvE
	BJX2tdA==
X-Google-Smtp-Source: AGHT+IGuVSy/Dy5uo4CpEzJMo6UfGPyEWpVHsDT2bTmHP7wPh3tWkdIwv3Hc6Ww8/SPPduITprYqfQ==
X-Received: by 2002:a17:906:e2d1:b0:a58:be32:b454 with SMTP id gr17-20020a170906e2d100b00a58be32b454mr2483550ejb.27.1714597608320;
        Wed, 01 May 2024 14:06:48 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906388a00b00a46aba003eesm16682305ejd.215.2024.05.01.14.06.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 14:06:47 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a7d4466bso779437766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 14:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyeqWuYzJ5IphOmWtZ+XGZPp/MGTHoak6yRbPS5KOWI4cJHIqoBflp2kxFophPGS70SftQfEzDLRjaR8wOqdkKyot7DlZ0DTuCg7rG
X-Received: by 2002:a17:906:af85:b0:a58:a1e3:a2cd with SMTP id
 mj5-20020a170906af8500b00a58a1e3a2cdmr2381710ejb.55.1714597606507; Wed, 01
 May 2024 14:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
 <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
In-Reply-To: <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 May 2024 14:06:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
Message-ID: <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 13:15, Marco Elver <elver@google.com> wrote:
>
> This is relatively trivial:
>
> #ifdef __SANITIZE_THREAD__
> #define __data_racy volatile
> #endif

I really wouldn't want to make a code generation difference, but I
guess when the sanitizer is on, the compiler generating crap code
isn't a huge deal.

> In some cases it might cause the compiler to complain if converting a
> volatile pointer to a non-volatile pointer

No. Note that it's not the *pointer* that is volatile, it's the
structure member.

So it would be something like

        const struct file_operations    * __data_racy f_op;

and only the load of f_op would be volatile - not the pointer itself.

Of course, if somebody then does "&file->f_op" to get a pointer to a
pointer, *that* would now be a volatile pointer, but I don't see
people doing that.

So I guess this might be a way forward. Anybody want to verify?

Now, the "hung_up_tty_fops" *do* need to be expanded to have hung up
ops for every op that is non-NULL in the normal tty ops. That was a
real bug. We'd also want to add a big comment to the tty fops to make
sure anybody who adds a new tty f_op member to make sure to populate
the hung up version too.

                Linus

