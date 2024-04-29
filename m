Return-Path: <linux-kernel+bounces-162619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FD8B5E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0CBB2468C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A49282D7C;
	Mon, 29 Apr 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QgzRthGE"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F67BAF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405892; cv=none; b=Q4IxioZeHJYzJxK62U6JjTpHAlmsegJyAATrqLrmyXStIXsOlRKYrLyHhbPfxGJqP0bcvRgJNYy7j8TNpomijJ/08PeBdMfO08Yv1WR4VzVuqvzYTBJ6Mga+w/zs35SUTfroFxMxaFuVLHlolBWjiBn/WcSirbK/RoZIdujH9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405892; c=relaxed/simple;
	bh=D+lhvJrYhUxu/0pChQYcmnU7oKvWHnEID0aAXtlOzO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmYepbRYPWmNj1bPIyOB0ldjq43GHNZkF6E3NLoZGEgKyFQvR9/ypo2FV5xtBQlomMg2QY4gjVtpHtdYMzlA1/iaEC9Z2znu95CxtlB8PF/sI7EwytGQ//d1ciUdMmXntn6SkpCfVdbRzAJWLnkIFN+q+dhrezbAeXJ0neoKTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QgzRthGE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so5793920a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714405889; x=1715010689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXasHxM1egr/YdHGYASIzG/58nZx0kha5r74ZHvQjpw=;
        b=QgzRthGEZDs7SX2U7FD5DpJQtnz2zu7lNNEu/Ok8VNXHadLIZrPSVm7qAWvuhd93nt
         TV14pynJ4+p9HjL88FS28O+0t3Y0EpfV14/hVa03AXzfecIO5775zAUCkTvQHNOrop6Y
         VpA6rZqVZbco6b5Ey4ntPm9h5wUtQsqngncZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405889; x=1715010689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXasHxM1egr/YdHGYASIzG/58nZx0kha5r74ZHvQjpw=;
        b=Dfs+HfmH9bQKdl1cT4VkQZb+iwTyj3RZsKPJA8fyGLh2Laz5VJ7CObk04hSNyjKgBU
         7qKpsGcilsEnqL/jVAmEUw9CRROzaK7UiVuBp++9ZRHhFAm3o18mQennwuoBrLsA1Af9
         JjVxS7wW1kLQqKbwsGxujwmgo13I1onSo4rbemCXJhbcGQj/PcUe8OqcnT3mjam9mBey
         wKttaEjzTzvE05RDDmgts0XISvSVsIB/CmU0SWfwG6T4fp7M3EhuGPcOT1Tkdr3CfBUN
         oH8HU+nsZbRUNwHWY9g4WaA/63bjGAUUXAvyAlaWxWYn87EiRfSm03EZEaPhWUY0hLXa
         c1pw==
X-Forwarded-Encrypted: i=1; AJvYcCVhIaEyYOdqJdRNp/5vZe/EzFV4fZj3dl4zFsCaTNqkqr65MoDyGmB1IX43eOBomY+IwLdiLD43ZuHr8A09bUnX+g5yWpsuNmfXIcBJ
X-Gm-Message-State: AOJu0YzPnmJLQ5o9gsbMJSXO7Kuz59vMRZKSutm6KQVbgtB1ZCdotOJ/
	NeSIdN3tci7z/scOcx5O81AJZok34eHbCpmrnY33Pf4dU1PC/C3+0Iotg3j/CwtcNCz0SkPLCYm
	vN8Gt4g==
X-Google-Smtp-Source: AGHT+IGBES3PEMyD7pRck4jc6Xxx1FwvX2XD4dD/n9AhptpfW7iIHQoCDWYyuCh3yLRnRJA7E4jypw==
X-Received: by 2002:a17:907:76c2:b0:a55:b2da:3e92 with SMTP id kf2-20020a17090776c200b00a55b2da3e92mr8831878ejc.68.1714405888870;
        Mon, 29 Apr 2024 08:51:28 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id eb16-20020a170907281000b00a58764e6c45sm8279513ejc.173.2024.04.29.08.51.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:51:28 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200202c1bso623995866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:51:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4MM3rC7QqhqqvRD3y41yxUehWIz1FRAsl1C8bebFBU4XN84fyDaXCMZOtGfqUcxVswlOSjtLfwB+A8OMB2e8pJ8QJVCzjvQIjFI00
X-Received: by 2002:a17:907:7890:b0:a55:54ec:a2fe with SMTP id
 ku16-20020a170907789000b00a5554eca2femr8987483ejc.29.1714405887417; Mon, 29
 Apr 2024 08:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com> <Zi9Ts1HcqiKzy9GX@gmail.com>
In-Reply-To: <Zi9Ts1HcqiKzy9GX@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 08:51:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
Message-ID: <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Ingo Molnar <mingo@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 at 01:00, Ingo Molnar <mingo@kernel.org> wrote:
>
> I did some Simple Testing=E2=84=A2, and nothing seemed to break in any wa=
y visible
> to me, and the diffstat is lovely:
>
>     3 files changed, 3 insertions(+), 56 deletions(-)
>
> Might stick this into tip:x86/mm and see what happens?

Well, Hilf had it go through the syzbot testing, and Jiri seems to
have tested it on his setup too, so it looks like it's all good, and
you can change the "Not-Yet-Signed-off-by" to be a proper sign-off
from me.

It would be good to have some UML testing done, but at the same time I
do think that anybody running UML on modern kernels should be running
a modern user-mode setup too, so while the exact SIGSEGV details may
have been an issue in 2011, I don't think it's reasonable to think
that it's an issue in 2024.

             Linus

