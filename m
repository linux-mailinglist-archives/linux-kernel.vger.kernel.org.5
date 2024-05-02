Return-Path: <linux-kernel+bounces-166866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C28BA113
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA601F245BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54C17BB05;
	Thu,  2 May 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xl45zKQu"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C3174EF7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678188; cv=none; b=XI+lLxR+m6myIMOqxeHQ0jAn5aMBrV1PE+ymKqnA2OiDu9RMRa422umHQqIAZRxLpHYggrec/snMNT7yLolO791lRdLwGGCCTZwQEn+7UMjUq2xmY4cDX77AI2uqX3620sL+wQdv0CGEExkx2kSKmQ2Ua0+tb7h80vyksmpNGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678188; c=relaxed/simple;
	bh=MwkMKS4+l4TV1o0qWW34OZNxyZ6VP57C3O5jGg0r+BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGIO2s9+vuJjWdedEgqpLbsuIKMHgksnAYUbwsXUjox+I/uFvIvnSKKRHWwYkGl5IEF7gwmDpo8mcbVcVM5idRtZmHN2V8zy/JqFJJE0USvhHwJpwINQ1ixM61aXbV4+duOsdjuoyHTgdVk8LAwcKVB/5P4OZZ/IPdrROcrDp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xl45zKQu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso1593620e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714678184; x=1715282984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+vhIIFygRb6/a4FZGMKCLtWx5aUmAaotE0L/rIDHVY=;
        b=xl45zKQuaUCWiC/n75llorm39xxJhB9GCbnTazJElib6xi8mcu7qrVnFjl8yRySPe1
         apcL+TEu4dRFoqvXmUDX8eW2yqr9vW9rfvWfjy8ZMvYzkl4gZGU0BKTAgQ+6hEoB3Kts
         r1tJjTYRcdHviS3F10GDly+KzHhGQKl56o63QOSFJKEo3waq2kM0QjHCUxAF/nqhOH7C
         KCZ7KlMUW3bOnWArxR0O0H608SrZgM2WOqdSoHSRy3+VPF65asvB9Lup2n8yCuHjA/0Z
         OumiAqCmmsyamCaQ7R7VQDl65SP1r8whNmZsUbWqAofufOeU2lZ7QdEQnBfKRwIX39CN
         m11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678184; x=1715282984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+vhIIFygRb6/a4FZGMKCLtWx5aUmAaotE0L/rIDHVY=;
        b=gNb3YWS3Qc8V7CvG7u42aKhTy7FRuTfilr7arwWZfpyDRZff/UQ6rQIzmA/eNzyNnj
         yaljKZqi/ITxEbZUhC1soluubm7a00FpAA5OtAbSA9JuiVeZSScL42v+1OnyE3jZSa2a
         v9Saux+ZgIyxRS0P+XMSbCP24sO6k4AtZYZyWa/MBAIWbERokt8XEJ3MTI3SkMbgkDir
         yua5d9jGAnWMNRCV8rr/mLrMBpLwLWu6xoQfOiGhmf+YveOSCtImX9X8FQVOEp32kgBZ
         z59zdmgUC8Zt9sO5T5FLMp8JY3XBun9i6Zh7y7K30EDkr7dJ1jgD91pP9CY1EKhzc7ce
         Wqvg==
X-Forwarded-Encrypted: i=1; AJvYcCU1JyAkfNPVHeLQ4y3g9bByrBRFmUR6GxiU6d49NZLWtQgrcPw7vRDOPpx9nsG6gNh0S6fWxqua2SM2FhvZrI1q8hrxUxUud/PdsSWP
X-Gm-Message-State: AOJu0YxxD/Xs1Le3mT91twa2lR9AphkwYcGJE0nh2xmsSB88F8+BRGol
	yBF0OEO2jZ1zWhcjsrZ/CKTPCkhy80HhzyCBdPXU8Sw79mdIkh+KeEj5nnbUFJX+zAk/GRx0eOL
	WrXOkSfLqUysl3/zoxD0CgxvgPADOJ50fofszo2qBwqpScXm3G5lG
X-Google-Smtp-Source: AGHT+IF9pYk2ReVWCxrbRwREYnqLs3kaT1Wzji2TKCzo5iKnW5z1kcFgi8yDFbDx2ZpdjJG6QXugBJIA3z8LRsVaLKs=
X-Received: by 2002:ac2:4945:0:b0:51b:6ed6:af3f with SMTP id
 o5-20020ac24945000000b0051b6ed6af3fmr419412lfi.16.1714678184074; Thu, 02 May
 2024 12:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
 <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop> <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CANpmjNNo_jyTPrgPVCeSfgvsX-fK8x0H81zbBA6LZMVNodO6GA@mail.gmail.com>
 <b13ab60e-503a-4c11-8a99-0ccccce33c6c@I-love.SAKURA.ne.jp>
 <CAHk-=wi_QBG68QshO1e-xK-jt0ZFsMpZczEJe4nQMu+U7q_7EQ@mail.gmail.com> <20240502181444.GF2118490@ZenIV>
In-Reply-To: <20240502181444.GF2118490@ZenIV>
From: Marco Elver <elver@google.com>
Date: Thu, 2 May 2024 21:29:04 +0200
Message-ID: <CANpmjNN0n9UkYheZyBCQykrLYM9EDsmkp41a=x4hbgYyKDPZxw@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, paulmck@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 20:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 02, 2024 at 10:29:52AM -0700, Linus Torvalds wrote:
>
> > Yes, this is unusual. The *common* thing is to mark pointers as being
> > volatile. But this really is something entirely different from that.
>
> The common thing is to mark pointers are pointers to volatile;
> calling them "volatile pointers" is common and incorrect, and the only
> reason why that sloppy turn of phrase persists is that real "volatile
> pointers" are rare...
>
> Marco,

I think we agree on what we want. I misread the intention of Tetsuo in
[1], and provided incorrect feedback.

[1] https://lore.kernel.org/all/CANpmjNPtoKf1ysbKd=E8o753JT0DzBanzFBP234VBsazfufVAQ@mail.gmail.com/T/#u

>         struct foo volatile *p;
> declares p as a (non-volatile) pointer to volatile struct foo.
>         struct foo * volatile p;
> declares p as volatile pointer to (non-volatile) struct foo.
>
> The former is a statement about the objects whose addresses might
> be stored in p; the latter is a statement about the object p itself.
>
> Replace volatile with const and it becomes easier to experiment with:
>         char const *p;
>         char s[] = "barf";
>         char * const q = s;
>         ...
>         p = "yuck";     - fine, p itself can be modified
>         *p = 'a';       - error *p can not be modified, it's an l-value of type const char
>         q = s + 1;      - error, can't modify q
>         *q = 'a';       - fine, *q is l-value of type char
>         p = q;          - fine, right-hand side of assignment loses the top
>                           qualifier, so q (const pointer to char as l-value)
>                           becomes a plain pointer to char, which can be
>                           converted to pointer to const char, and stored in
>                           p (l-value of type pointer to const char)
>         strlen(q);      - almost the same story, except that it's passing
>                           an argument rather than assignment; they act the
>                           same way.
>         strcpy(q, "s"); - almost the same, except that here the type of
>                           argument is pointer to char rather than pointer to
>                           const char (strlen() promises not to modify the
>                           string passed to it, strcpy() obviously doesn't)
>         strcpy(p, "s"); - error; pointer to char converts to a pointer
>                           to const char, but not the other way round.
>
> The situations where you want a const (or volatile) pointer (as opposed to
> pointer to const or volatile object) are rare, but this is exactly what
> you are asking for - you want to say that the value of 'f_op' member
> in any struct file can change at any time.  That value is an address of
> some instance of struct file_operations and what you want to express is
> the property of f_op member itself, not that of the objects whose addresses
> might end up stored there.
>
> So having a driver do
>         const struct file_operations *ops = file->f_op;
> is fine - it's basically "take the value of 'file'; it will be an address
> of some struct file instance.  Fetch 'f_op' from that instance, without
> any assumptions of the stability of that member.  Use whatever value
> you find there as initial value of 'ops'".
>
> That's fine, and since nobody is going to change 'ops' itself behind your
> back, you don't need any qualifiers on it.  The type of 'ops' here is
> "(unqualified) pointer to const struct file_operations".

Is this feedback for the __data_racy attribute patch [2], or a comment
for the patch "tty: tty_io: remove hung_up_tty_fops"? [ With the
former I can help, with the latter Tetsuo can help. ]

[2] https://lore.kernel.org/all/20240502141242.2765090-1-elver@google.com/

The __data_racy attribute should behave like any other type qualifier
(be it const, volatile), and what you point out above applies equally,
no doubt about it. But I think it's important to treat it as a
completely distinct type qualifier - volatile is an implementation
detail (in non-KCSAN kernels it's a no-op).

Thanks,
-- Marco

