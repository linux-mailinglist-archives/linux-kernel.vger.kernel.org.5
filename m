Return-Path: <linux-kernel+bounces-161563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8CA8B4DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD631C20A37
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F272F1DFC7;
	Sun, 28 Apr 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LNVdFvlY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341A7350E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714335768; cv=none; b=ZdgpY9vC4kARYLOJK18XNYI1XcbgN67v39m/IIjGPVvz2scfst3z3AtOCzwS3vONvmIV+Fsftij2e9PoBtOtfQCnBhXJBhuEfdZMA2KhzHpHMvnNYyHciHIDhyZTVhXWb8L4E7QrYH96z/v7yyyq1xLknh6guarprvMvf1bZmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714335768; c=relaxed/simple;
	bh=H71Tv2dUxdSU6L0QrBYX2j1pl48rzgL4H1/kXqthOD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TosgaTGDLGzmr+JUQfxSRvM3SbtBUCH1oEIxBv8qYd808oblz0R+xVDNogMYvTAjLPuQUyNhrERYUEvDBg1kJGBe+g2vqvFjNX8ybDlT70frx3+ZiqrQK0bvVbgmQi4AwMe0+PbJT3Qh/pF95xM8Zvo+szRCI021MVIXphnd+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LNVdFvlY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5724f26b8c9so4762763a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714335764; x=1714940564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qNIV9pJKRQ0bK2019WbvTNRu1m1w296Oj9c68XnoHTQ=;
        b=LNVdFvlYt3jhy1z81Dj21uiB8CbhCD6yi9O0SMUv6XspmSCCK7Mn3tiQLhtZDip0NR
         xBo78b3zyWpgC36WezkH1Z5hPmKE8IaCmF9RSSko90yyuCFDGWntvQk2aEyUNZOHMXAm
         whdl0h5yNkQskhT7z07FUGJYRhFz3JDrHXVwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714335764; x=1714940564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNIV9pJKRQ0bK2019WbvTNRu1m1w296Oj9c68XnoHTQ=;
        b=qoqeO3LvH0psG7Yxc5ujUUfIKCpNF/K51FOLt+miqLGN0axWHWNNUbgX+438KEUkKd
         yjXwHfGsZAKiPFWZaMVPeJRou4LSOQ2tlh8SQYWN0S5CPTXLPYMY6nv06MSQPG/XyGLI
         4k4lLNfE74Ji9pIO5iR4556RSlilrtjmaqrXX862Jlia+ZCAHo+T3w7zN+HRN0sEmTVN
         4fH2ZX12u/7T0tWqgkgBLTuL4aPgZgnw0trv1mUOkXCGZ3pEW1YC4vyQQvHWJ1lyCvye
         bGBJkmScgrsRNy+knEd6fWGbsQj2KeAp/Aw5aG8/N9PDNilvxivRJBQ2dMLNfqutFSmx
         ignw==
X-Forwarded-Encrypted: i=1; AJvYcCX2hixjMru40xtvDSCGNwvrTySi2iOkF4+FTvi5JfOTj0PNTWRpur70jxU/U93xNnumllqlYWHjuwnCzGeNMKp99Fq3m4LSYCGZUzC3
X-Gm-Message-State: AOJu0YyF40tfIRc7Ii2vrPLIHjzgb/JE1NGyeajCFBIVFq88VwLFNWgS
	lV6hUHV3gcL8+/5kkCvZG58crPk2lqJzQza8dzIRV+ttIIqTNLzs3yAoLhdVVa1Y1UBHOCAAc9c
	GafRfVA==
X-Google-Smtp-Source: AGHT+IGSOGUd5GxDHoQzOBb+ChhZiW8XCgvmkzwvpHe7emLjcIiYYKMIhmYslZ6zR+0PknIg3MQ6kA==
X-Received: by 2002:a17:906:f595:b0:a55:9574:48a6 with SMTP id cm21-20020a170906f59500b00a55957448a6mr5692206ejd.30.1714335764508;
        Sun, 28 Apr 2024 13:22:44 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709065a9200b00a58a4ccf970sm4765081ejq.103.2024.04.28.13.22.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 13:22:43 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724f26b8c9so4762747a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:22:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUs+11548ojt4luN2kxW9mUBSmuNNmneKzQFbF9xUfA6IvLarV7XteX5URy8ePCAP3Z8CZ6ySRNjSdE7BIyKWIP4tk+zxn483UzBA/c
X-Received: by 2002:a17:906:370f:b0:a58:eb0d:f2a6 with SMTP id
 d15-20020a170906370f00b00a58eb0df2a6mr3640636ejc.31.1714335763076; Sun, 28
 Apr 2024 13:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 13:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8U1PjW_L6Ng9_A80L_1keyEOKud3PVh-8bwPL9W0CNg@mail.gmail.com>
Message-ID: <CAHk-=wi8U1PjW_L6Ng9_A80L_1keyEOKud3PVh-8bwPL9W0CNg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 13:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The *problem* here is that the page fault doesn't actually happen on a
> user access, it happens on the *ret* instruction in
> rep_movs_alternative itself (which doesn't have a exception fixup,
> obviously, because no exception is supposed to happen there!):

Actually, there's another page fault deeper in that call chain:

   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
  RIP: 0010:__put_user_handle_exception+0x0/0x10 arch/x86/lib/putuser.S:125
  Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 01 cb 48 89 01 31
c9 0f 01 ca c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 <0f> 01
ca b9 f2 ff ff ff c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90
  RSP: 0000:ffffc90004137d98 EFLAGS: 00050202
  RAX: 00000000662d5943 RBX: 0000000000000000 RCX: 0000000000000019
  RDX: 0000000000000000 RSI: ffffffff8bcaca20 RDI: ffffffff8c1eaba0
  RBP: ffffc90004137e50 R08: ffffffff8fa7cd6f R09: 1ffffffff1f4f9ad
  R10: dffffc0000000000 R11: fffffbfff1f4f9ae R12: ffffc90004137de0
  R13: dffffc0000000000 R14: 1ffff92000826fb8 R15: 0000000000000019
   __do_sys_gettimeofday kernel/time/time.c:147 [inline]
   __se_sys_gettimeofday+0xd9/0x240 kernel/time/time.c:140

which is also nonsensical, since that "<0f> 01 ca" code is just the
"CLAC" instruction (which is the first instruction of
__put_user_handle_exception, which is the exception fixup for the
__put_user() functions.

So that seems to be the *first* problem spot, actually. It too is
incomprehensible to me. I must be missing something. A "clac"
instruction cannot take a page fault (except for the instruction fetch
itself, of course).

So if the page fault on the 'RET' instruction was odd, the page fault
on the CLAC is *really* odd.

That original page fault looks like it's just from one of the
put_user() calls in gettimeofday():

                if (put_user(ts.tv_sec, &tv->tv_sec) ||
                    put_user(ts.tv_nsec / 1000, &tv->tv_usec))

and yes, they can fault, but I'm not seeing how that then points to
the CLAC in the exception handler.

                Linus

