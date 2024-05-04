Return-Path: <linux-kernel+bounces-168440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95218BB8A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77B9B2287D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980481F;
	Sat,  4 May 2024 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cyxqGlJg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2C36D
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714781683; cv=none; b=b9PjvSq2VAhPD2C/4JlQdPV7gmcivqw/C5elgwqZj+L8nB7wcYcVh/mgPkMGwC7sPR3w/1frUgUft288hnawnCpoBR6hrsS+o+GSotq1CL4YSjECdqy9XvVeunnHMFIX4kr3PQmFRi94XxZkCs4weu1Z9TTb5UO+MdBFukDTSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714781683; c=relaxed/simple;
	bh=T2URmGhyGMl4Ds55r5EmQIdTuhtkYth+3ELjtiIO1/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU1dIwsCPSaZgou6exVn/MkhOPXzIYcLDt4sjO4T6ZwVTDUHFfLtDx7OG+UgE5aaNWb/DqL7ddZBRGYbb+7fFVhTJqoOBvO1z8JKx2xTyGkd/5V5yi+hLt+HCpZbL+ys7xuta/DWsHWXdZXV8hzGbC+JHL/aH98UyfSvrYIZWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cyxqGlJg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so230874e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714781680; x=1715386480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VCzgS+IY0IS064Sorg1TCiXuLWe5FHSNuzBQJmhuYM=;
        b=cyxqGlJgLUWYlJmIc3ZAzquvdzp9srvmer9LEB5+Pr3IzhqphwKhTN8p5Krp5Fw61g
         7Dv8XLsb4k5lNY/erMxXbgE5jDpgo9Zwul+hZKhi6bF1DAlKxI2yy1Kapb7zZhZk+lEE
         8NFhU3SzEfKtGjy/KefcLgWI+VXg9H4/37Uqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714781680; x=1715386480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VCzgS+IY0IS064Sorg1TCiXuLWe5FHSNuzBQJmhuYM=;
        b=TyDhNrggVouP8AMoys/0fCUayVSuzUlS3LQKD+bblDST7278nWwRygjfratq4sZqxR
         Q4Yak4IBUaP9r4Z0PDUZIGYDyW87f/YC14EbL9ke3IaR4u0bAFsD/wAiwxC4WjT0R8WY
         fvmF3EN2MH95jpzAZGj2xje5xha69bRefJfrx4mr7XWH86g9sCSH8F3WCngre08g/t1P
         q7HQiwswfRjZGEUSZcwKd4E+vitjOe3vThMbBkykQ0JtyzL/RBWk3Dhcl2VhD0FTx7Ru
         qRCLg157+JhcT5cYDjw6Coy1hK9tcYzmKiqJUJbU5hiQ0cltU/JDeWlyPE+BSDvh1WfW
         IvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVbr8S+5/09nMXa3Vbv7tCxuIEcEuubxmCHiT+geUILjaEacyo4H9T8S6e8zsMEYj1oiI2z9TDK7oiDqu2Tfe/Sn9R/qE3yz+eKS/MA
X-Gm-Message-State: AOJu0YyLRZspzgoIba81p9rWDASejuEIjtG2+iXqy5HNNQgLWGFF0CHp
	JoYE09FrQmuv4Ey10idRhUJGiE14GjS6nkhsIT49ma1pMCqoQBLpr2Uk4CWCK/dPCMFHPjVVAOM
	CnabP/A==
X-Google-Smtp-Source: AGHT+IHSkn2H0+zAl5xy36F6+wCABlTw8GOerjPACZmrRkClZ9bEV5aAHO0Kd3MsCLolOpX5WoI4sA==
X-Received: by 2002:a05:6512:20c7:b0:516:cc06:fa03 with SMTP id u7-20020a05651220c700b00516cc06fa03mr2337364lfr.56.1714781679956;
        Fri, 03 May 2024 17:14:39 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090652cb00b00a4da28f42f1sm2320592ejn.177.2024.05.03.17.14.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 17:14:38 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a64db066so30525766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 17:14:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKRWc2x9GCqHfmnRDWU9lIW8W3PIwZaF4AWEvpN6eQdD0Mneqo5H8fdqw728WCc6izr/LP/ofEbvT0I6wvAi0ZoCV47PnkMqv8wwrm
X-Received: by 2002:a17:906:4a54:b0:a55:41fd:a013 with SMTP id
 a20-20020a1709064a5400b00a5541fda013mr2161357ejv.23.1714781678453; Fri, 03
 May 2024 17:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop> <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux> <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
In-Reply-To: <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 17:14:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
Message-ID: <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 16:59, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hmmm...  Maybe something like this very lightly tested patch?

I'm a bit nervous about using the built-in atomics, when it's not
clear what the compiler will do on various architectures.

Gcc documentation talks about __atomic_is_lock_free(), which makes me
think that on various architectures it might end up doing some "fall
back to helper functions" cases (possibly for odd architectures).

IOW: I don't think the patch is wrong, but I do think we need to
verify that all compilers we support generate the obvious code for
this, and we don't have some "fall back to function calls".

                 Linus

