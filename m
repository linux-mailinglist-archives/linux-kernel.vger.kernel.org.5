Return-Path: <linux-kernel+bounces-162601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774098B5DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B021F22700
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76882499;
	Mon, 29 Apr 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IM9nb9E/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FF7E0F6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405130; cv=none; b=R7/Fq93+nfDiSUn81Yt0QdRQIwKybS0qzJfbswfk+LmFgkhdwt2bb2Fcq/okJQ+FqthSMhCAKQDCAz2MoZsUABH4U9/rxqZ9tuJKQ14mBSdD9SnYftJ0Bs4Zb1+rkJ8j1RZsXbMkhsqmbE1drQ3JQCnIumCuyPwZ0J09U6vbrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405130; c=relaxed/simple;
	bh=v0HkdwseVtxbUG+TpIadKDFDMEX1O+OVMMIYGmNmfBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJsbil/Q4ylowgEmUHdIL9RlVMrqjvj2RuO6efFRBngpDPgCyUCQWRe9VtSOucIVWBuKNaAaZ06KbSgiU5Hx0MqJL8meA6MvnNSyzCbnkftiX5P3YcKVjnCatYvXtwIgbtuSmA/AfFfIcXbBSXjHCVYCMKtwZmFub0uQLJcwIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IM9nb9E/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51d62b0ecb7so2518076e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714405126; x=1715009926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yzvwkbrrAC9JiUG9n8YloB91+ZmYMnCxhqfGJQxrqwQ=;
        b=IM9nb9E/iQ9AmoxGKiClzhen7ssbqIH/WfNV3l6Msbsm+MGaQUcfvwx8aqZkcF0QpW
         DIAI6zNVBx4xwP/IyFaEDMLuxjmhAKTC8dSvkCEsGsgHT3bl3oJdJ5LH3V12mF+7kNnq
         ixY0NsrPYKNcC1SEDlNafHAX5LUFbWvoLzXwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405126; x=1715009926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzvwkbrrAC9JiUG9n8YloB91+ZmYMnCxhqfGJQxrqwQ=;
        b=RA0sxhyvbBlqFfOUV/43rZGbVkGMTw1hjSeniDdOwQbWXXwqBZsOTqDNra+6vn+zTz
         ZtBJyVpFETxraeoXkP9RVf8o86nBKn37Rjh5Mx1Z6LxnbBg1YMiveZ3EwFz4nFoZW8jH
         qTTO7eSP4/bA0EdrKCG7YF+UFzogBaMSLErfluk6m+92gtKzJ/3xAf0B+0ZvCDuND0B0
         rlE4/DIJscic0bXUaGJ7Q+JKy63oNYVg7DhCfsCs359XhTtPsLYfTVQP8V8qvT2zBkA3
         swa4owMTM4/GnIlwB0/lRJC2c6XjppM0z0kxfvC75rbP1xzR/w7EnrR3mIcJMmhMMFLm
         E2fg==
X-Forwarded-Encrypted: i=1; AJvYcCWJxBJ7McZvGiFiUCkDh3CiElVCmPBuDUmeGaxtlKEGoj8dX/AxUqzt6HGqU3utNEaGuLdULL5wgxMP9Nsq/kpRcNLpf73e9NyEpjyj
X-Gm-Message-State: AOJu0YzAKyBCv0PoJwXsFGuOQug2PB/wO40kHTFB4Z7sUWZVQjiWaUDX
	LW4T2YsYI7isc2z2xp8V8GSUaQlqOZhHXcRE02M6lQHlyBOCzo/s3DsVhte4YObRBVRcNvcuO7O
	GTJ/w7g==
X-Google-Smtp-Source: AGHT+IHfaJSak0O590tk2IkM9nll8CKFBK05zAJ+xj5BxGyXw5A4lvxMiKdBypT2q9QzFV9cpE63Zg==
X-Received: by 2002:a05:6512:baa:b0:51d:d630:365c with SMTP id b42-20020a0565120baa00b0051dd630365cmr2567307lfv.4.1714405126060;
        Mon, 29 Apr 2024 08:38:46 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id s14-20020a19770e000000b005188ea5d2b5sm4232478lfc.303.2024.04.29.08.38.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:38:45 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5176f217b7bso7946288e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:38:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYVeQuBW+axr4igMRrJgAbqWZi8+Y+s1uNZX/g55pw3Rp4dTp0hDwPKSkRcgpDoxNw9BsVNQg39kkm/pLOdCfBOJjIv/HlpBCO3OXU
X-Received: by 2002:a19:5f5d:0:b0:512:e02f:9fa7 with SMTP id
 a29-20020a195f5d000000b00512e02f9fa7mr8210499lfj.1.1714405125069; Mon, 29 Apr
 2024 08:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV> <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV> <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh> <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com>
 <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
 <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com> <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
In-Reply-To: <CANpmjNN250UCxsWCpUHAvJo28Lzv=DN-BKTmjEpcLFOCA+U+pw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 08:38:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
Message-ID: <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Marco Elver <elver@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 06:56, Marco Elver <elver@google.com> wrote:
>
> A WRITE_ONCE() / READ_ONCE() pair would do it here. What should we use instead?

Why would we annotate a "any other code generation is insane" issues at all?

When we do chained pointer loads in

    file->f_op->op()

and we say "I don't care what value I get for the middle one", I don't
see the value in annotating that at all.

There is no compiler that will sanely and validly do a pointer chain
load by *anything* but a load. And it doesn't matter to us if it then
spills and reloads, it will *STILL* be a load.

We're not talking about "extract different bits in separate
operations". We're talking about following one pointer that can point
to two separate static values.

Reality matters. A *lot* more than some "C standard" that we already
have ignored for decades because it's not strong enough.

                       Linus

