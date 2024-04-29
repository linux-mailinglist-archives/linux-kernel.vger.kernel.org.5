Return-Path: <linux-kernel+bounces-162856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E658B6160
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C76283E68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781E13AA39;
	Mon, 29 Apr 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H73aODyz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1613AD13
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416491; cv=none; b=RxjSZ//AIVXDhx5qy5LGzRJS3jBdDi+U1RMNLFd8soX8I+KxAe+jjVTVmk93ju4rnHIkKfJn5PRMyzdIG5RaTy7GUEDAyLfvwqkUzmFiuLcrguW3zB7NMfSCAituKNuJ5t5XAFmUNy3+iprvmmKyyVj+uB32Igy9kEdrfZOaifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416491; c=relaxed/simple;
	bh=u7kw+FkzxObVPiQnaVCOnkmZSnrlks2HiY7Vm3Bnv1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elzNSHtCcupVzFR/3/MtLPgQ+dUFiEHWYKs3urbe0BjZECRRsdIyZqXuMT/FzHsiGHijbmG1bU6jUOTTOZsQJvKRmqbRkj8UZdPZ5mUf56HwTMrdliHcH/EeZ0jW5kRtffKbhItUMd/eKQQes+Rf+lwale5Ljm1PBrNLX6B/rjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H73aODyz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516ef30b16eso5424278e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714416487; x=1715021287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gYXEmIPmKlUCv4MlmDP09ZBKONhIZhGPFSWq4/CxW8A=;
        b=H73aODyzgVy1GR4fRWCCb6np4mwVRvKwNR60n1Lm15rPYKNVxkTUnTg2SaIf9jWSR+
         ft6fd8t685k/ASTc/H88RQ3i9gaGNuOuPL74YDzGU2eD82rlqO2fmpGTwAupwD0Cc0FJ
         kyk6e2Tqlfdp1Ly2yb//VpqISs3nuPYKC+hBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416487; x=1715021287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYXEmIPmKlUCv4MlmDP09ZBKONhIZhGPFSWq4/CxW8A=;
        b=R9ZJGQnHgDK+EUzRmONteYxFdFb7oWy4KpWQ6u0WevFuWfOS8VohMwiohzYFZ+NaiH
         BXsoP1HaibuKS5kigZd1heRZne1YKcW3kJdndWPGqBPTgjlZh73mzc1gP1tfd7BnImhw
         oQBvX6Rbx0aHAXLO80/zBxp6V91jIAjUa6evyfhtcx0YnSTDOGeIDJ0g/CN1w95K65e5
         T+tSciDaHpWIPpcEFosf0NG2qe+SwXYJzbqQ+NMK+zwpPdghaExo9diWlvCY/NlH9AJ+
         ibs/MfTnaYcrOY/js82vPwQBmPinHGBp3ogJa96G/bMPv6mV7dB7d6i+651X+jkO9553
         cenA==
X-Forwarded-Encrypted: i=1; AJvYcCX/AXekivrY+f/S5pGJCj0uZizr/rfXX4maTsFCutmpNv/nHbs3DJwTZJd6P+ELEW0cQfLm7/dKg47J9SzwwE9jufMU9HjVs/ELhMp0
X-Gm-Message-State: AOJu0YxyUNoabFl+VjQlgVORxog1YdlKTQpmFxReRR6JaDrFhR5ZvzSD
	UvY64ekfXl9Z0FPLNbCthkF0XXH7uQhNt127ZnYnrxKa71DSUbTt0Ep/RYUKoAuxzyxgVO/MWzB
	n6DdhPg==
X-Google-Smtp-Source: AGHT+IFLRY0JvM20+jfIhN4Iy9pcmSDe3apNLriOoO6whaUzTcS8sotrwha47JsukbI/6SQkYvG/Fg==
X-Received: by 2002:a05:6512:33d4:b0:51c:32fc:a551 with SMTP id d20-20020a05651233d400b0051c32fca551mr335226lfg.45.1714416487456;
        Mon, 29 Apr 2024 11:48:07 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id dq5-20020a170907734500b00a58874312d6sm7236421ejc.212.2024.04.29.11.47.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 11:47:57 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58e7628aeaso291742466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:47:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAlPs2hWlgk/UexsluZORkec3UffrshOI7GVgmTyQuzNcaVMXoJD7f10AJs0buZJ8yAl6Guz1oL9/QPZshLvJjrM43auPOwMf7Kx8z
X-Received: by 2002:a17:906:c252:b0:a52:6fcb:564a with SMTP id
 bl18-20020a170906c25200b00a526fcb564amr321186ejb.9.1714416477325; Mon, 29 Apr
 2024 11:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com> <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
In-Reply-To: <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 11:47:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
Message-ID: <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Ingo Molnar <mingo@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 08:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, Hilf had it go through the syzbot testing, and Jiri seems to
> have tested it on his setup too, so it looks like it's all good, and
> you can change the "Not-Yet-Signed-off-by" to be a proper sign-off
> from me.

Side note: having looked more at this, I suspect we have room for
further cleanups in this area.

In particular, I think the page fault emulation code should be moved
from do_user_addr_fault() to do_kern_addr_fault(), and the horrible
hack that is fault_in_kernel_space() should be removed (it is what now
makes a vsyscall page fault be treated as a user address, and the only
_reason_ for that is that we do the vsyscall handling in the wrong
place).

I also think that the vsyscall emulation code should just be cleaned
up - instead of looking up the system call number and then calling the
__x64_xyz() system call stub, I think we should just write out the
code in-place. That would get the SIGSEGV cases right too, and I think
it would actually clean up the code. We already do almost everything
but the (trivial) low-level ops anyway.

But I think my patch to remove the 'sig_on_uaccess_err' should just go
in first, since it fixes a real and present issue. And then if
somebody has the energy - or if it turns out that we actually need to
get the SIGSEGV siginfo details right - we can do the other cleanups.
They are mostly unrelated, but the current sig_on_uaccess_err code
just makes everything more complicated and needs to go.

                     Linus

