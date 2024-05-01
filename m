Return-Path: <linux-kernel+bounces-165770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD268B910D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4D9283372
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B88A165FBA;
	Wed,  1 May 2024 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c1B8vUXJ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D4D52F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714598457; cv=none; b=W7xA84CKBBsiXB42o6w71/Lu7rglJtf+o2Q9PaSbn9oS2GTqyk/Jq/dmwTyuEPlJXNgih0LmqoS0kwBBvKT1gPJtGJWUEr/HJi+andVKl2m8pkJpsDJaXs4AqYsUI1Tgn1Qxli4Jx2mq33Qvt687hXo/Cm+33ZPUGMnMc3z3lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714598457; c=relaxed/simple;
	bh=O34grSvAn3ldZ0aHb/U4Q+6zVX17IPoCgaWasx5R/TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxfO1+rbFdOth37Kv5d8syH6/mudvFljOC4f8cCv+xWtg+Ak9Kb3cqVTTjbnAW7Resj1beIRc/1IubFp/gUpBnSExuime+e1gE9Gmys18tKDt8ygIXA2/1sWJmdpt6Pd1DVuWl2OOc/U2ruz4xWOXFFkiHqqlml9ihj7EKqOUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c1B8vUXJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so6603830a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714598454; x=1715203254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0f+lrtMA8Tr8cBnaWXK4wxxIlkiIC1fLe265KtbI7g=;
        b=c1B8vUXJ+Gc6JL1h/iab4RhLdu/i9CoRx4djGzqSPqzTJjjCLkQqaxCm3U1JW9/iou
         o471sQC4jqirHTn02irdZAYzn7rBmHqEC0c59ejXQ1dQPEq0z7hkLAZiX5zmWQDC19Of
         QrM3bl+DWqPuItdkYe6sC/Ftyg6nA92I1Y6Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714598454; x=1715203254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0f+lrtMA8Tr8cBnaWXK4wxxIlkiIC1fLe265KtbI7g=;
        b=mVbkc42pIAbmIXyyTP2dXQ0H3igGTmKd5/hWgpsSTDDy06i1RumovrHSOFl2DCrOLA
         rLAVI62FOqFA6vgNDZ89cJ7Edzbbc2HAQM4lWUN39tooH/vlbfXdUQYYGrqK9euOZe9W
         S/X8IvBgPAUZYsRa2pCPZgU4vvjtvufu1NIf+jGlUWqUsoz/L6jF+Uuel1ucn/Q2YGfm
         OJp/aTtJo9zgufhRuO2Kvw/Ew06MdGV3z9IfaAD9pX0tVUN8VgwQr7hLoM1RI8YJTVEt
         bOSO4rWWuN3ZGY+5CTgV4bdMeHmWo+ixQDW1EOizuBJsTR9t9hZ3woSvKguD8nW+9B77
         olbg==
X-Forwarded-Encrypted: i=1; AJvYcCVMGkGUZcT+ebNiJpxXZUmqxBO50F6LBCrAg7Ry9hI2AL3BxbVsz/m6geD797xJnzCJn8lwVW7XsDJG7nXKMZakD2C0tCYpFlZPTViF
X-Gm-Message-State: AOJu0Yw2gWc1hpcPJA1WULpwZBQXWbu6Z1eZ1b/iOCjFocCwDlcwZWDx
	Jg9Z142+tN46zDQt+d9aOqdz+iyPRNDjvATsuA5B/04T2W95jsRGwqb06bKgpqxYKvWPGcaR2oE
	1iYrC8Q==
X-Google-Smtp-Source: AGHT+IGb7WUaYjODnFI1iueNFB//cAE+dMAW6LLnn3+dZ4+f13PWVLWC5f5bKxUu7SIOjF7A8Uxc2w==
X-Received: by 2002:a50:f619:0:b0:572:72fc:df54 with SMTP id c25-20020a50f619000000b0057272fcdf54mr149557edn.22.1714598454100;
        Wed, 01 May 2024 14:20:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ec4-20020a0564020d4400b00572accd13dasm1019037edb.80.2024.05.01.14.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 14:20:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso955962866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 14:20:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZa3cqOY0AstqDlSvVaS1jGZNzAklJdUWEUwODLe99xziPhEyRBADd9fYQHXNFZJb/cuO/lllzQ9XnxPANWzaqoFArzxks81jDRsH5
X-Received: by 2002:a17:906:2e87:b0:a55:b581:dca8 with SMTP id
 o7-20020a1709062e8700b00a55b581dca8mr92670eji.38.1714598452573; Wed, 01 May
 2024 14:20:52 -0700 (PDT)
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
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
In-Reply-To: <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 May 2024 14:20:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
Message-ID: <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 14:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So it would be something like
>
>         const struct file_operations    * __data_racy f_op;
>
> and only the load of f_op would be volatile - not the pointer itself.

Noe that in reality, we'd actually prefer the compiler to treat that
"__data_racy" as volatile in the sense of "don't reload this value",
but at the same time be the opposite of volatile in the sense that
using one read multiple times is actually a good idea.

IOW, the problem is rematerialization ("read the value more than once
when there is just one access in the source"), not strictly a "read
the value separately each time it is accessed".

We've actually had that before: it's not that we want each access to
force a read from memory, we want to avoid a TOCTOU race.

Many of our "READ_ONCE()" uses are of that kind, and using "volatile"
sadly generates horrible code, but is the only way to tell the
compiler to not ever rematerialize the value by loading it _twice_.

I'd love to see an extension where "const volatile" basically means
exactly that: the volatile tells the compiler that it can't
rematerialize by doing the load multiple times, but the "const" would
say that if the compiler sees two or more accesses, it can still CSE
them.

Oh well. Thankfully it's not a hugely common code generation problem.
It comes up every once in a while, and I think the last time this
worry came up, I think we had gcc people tell us that they don't
actually ever rematerialize loads from memory.

Of course, that was an implementation issue, not a guarantee.

                           Linus

