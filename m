Return-Path: <linux-kernel+bounces-40806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0E83E652
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9B81F21644
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4A23751;
	Fri, 26 Jan 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CmF3bLZb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151B55E66
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310736; cv=none; b=ki3YghLMuiNatYbnvMh4s9ZTqri7vNnGwJ1oTJTTMbD8I8pEIfaKCr1FrxZySSbn1Gpjr9ILd2yQCJRGYUgd0/51jMCyW+j55k4zUHSe/ZmI4hdAg6RGWDU7hjzoOxDekafv2DQaStUoFCSH7IeyO5PLdWqizgq0ZndKEx9iUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310736; c=relaxed/simple;
	bh=2P1MSft8X93++r9/w92I/KK2xvEAgYJknw4bsWY3hGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F31wvBwTtSvS8Z2HWN6sbQiSPpoge8QKpW8nJTey31cER+GAQnt+kfpN6T1xHOT+EPSHrn6B1GBSTxjKEUabtPM+yyOQwrek4YSM+crmHK5zSWJIN6dFSxHHKrqyApcbeL2qC9T+RisqfHybDoLBzetR1YDeg1V/E26j6X3nxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CmF3bLZb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso16246015e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706310732; x=1706915532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdf20BJ6O42hFp/1Syn6ytLGURr08JkqxpxmJ3QroSs=;
        b=CmF3bLZbZpRjGd3lVkMpnIUpHNOb19oXWWdDGQik3yEEeWGl7qgw7ZZLaXn7ij4VJW
         1u4FgBUd9GFnZXIKzxiHv9JCRhZbc/b6zylfMxEwaAcjfNtooaXnGecD7kiaeGj1FXPj
         /x5DR0LZE6vjAigFxgg4NCSvcVDy+LB9copzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310732; x=1706915532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bdf20BJ6O42hFp/1Syn6ytLGURr08JkqxpxmJ3QroSs=;
        b=mGeNQEytHIjnvjs1JhlB2II1AK6M2PjDsZZi9Lk4/mLfdfxO5EuJx4VsQ25Fts7kHN
         l4vceGIsD9bFjKRkUQt7sLf99mnlUOa13R9ad5rdCG1FooNQH6tD/hxHM6tK0RKAsfFD
         l6846TUMSnSY0F7IHQeUxhKgfDBIb5UJlOX4y18JK6j++nlhveqpuOTB3KCBX86Z202m
         x90xdTZmXlsP9HU+c+kCrkKBX2hAU/U3PomRrsGtS23eAt05bzJfxYNWdbWjDbI/wLQO
         Q45W8jAeDOMGrHb1fe61T8+5slL+0gy4uvlz/QhMPOhTQjQat/HtcxFH4Kl6rNnEx/La
         wuIw==
X-Gm-Message-State: AOJu0YyagPKdyKdX8TjlNMEQTF+opZuru/T4IIzr9tvrt7g51m0Joki2
	J+yU+uUfI48jl2njOgSkrou4wsGTt71ZkAZAqofk9NkcUhn88H4VtF+BvlfU/oPfj1qTil69Jr1
	Y4Mz9Fw==
X-Google-Smtp-Source: AGHT+IHe9LbvlVid+nlTDW78xUQRfnzJsFiDhN1q8NEwbbClfSLykGqYBCPQpURBw0RXUQR/ZsrRTg==
X-Received: by 2002:a05:600c:4ecb:b0:40e:a982:62d9 with SMTP id g11-20020a05600c4ecb00b0040ea98262d9mr359744wmq.113.1706310732771;
        Fri, 26 Jan 2024 15:12:12 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id c9-20020a509f89000000b0055eb53aae03sm2119edf.94.2024.01.26.15.12.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 15:12:12 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso593112a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:12:11 -0800 (PST)
X-Received: by 2002:aa7:c3cc:0:b0:55c:f699:c393 with SMTP id
 l12-20020aa7c3cc000000b0055cf699c393mr269406edr.32.1706310731406; Fri, 26 Jan
 2024 15:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <ZbQzXfqA5vK5JXZS@casper.infradead.org>
 <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com> <ZbQ6gkZ78kvbcF8A@casper.infradead.org>
In-Reply-To: <ZbQ6gkZ78kvbcF8A@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 15:11:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
Message-ID: <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Matthew Wilcox <willy@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 15:04, Matthew Wilcox <willy@infradead.org> wrote:
>
> Maybe we should take advantage of that historical oddity.  All files
> in eventfs have inode number 0, problem solved.

That might not be a horrible idea.

The same way "a directory with st_nlink 1 clearly cannot have a
subdirectory count" (which tools like 'find' know about), maybe it
would be a good idea to use a zero inode number for 'this file doesn't
have an inode number".

Now, presumably no tool knows that, but we could try to aim for that
being some future standard thing.

(And by "standard", I mean a practical one, not some POSIX thing. I
think POSIX just mentions "numberr of hardlinks", and then the whole
"a value of one means that we can't count subdirectories" is just a
practical reality for things like FAT).

               Linus

