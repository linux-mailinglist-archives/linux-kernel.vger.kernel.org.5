Return-Path: <linux-kernel+bounces-20326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873A827D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56921F24103
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488C3FFF;
	Tue,  9 Jan 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sp8LDrYy"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE928FE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so2776694a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704770923; x=1705375723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2n04rycTbVj98G4Oti5JohO5PKOBYnQTDfzjI/yRas=;
        b=Sp8LDrYysiKUwFAN/rHoEVJWCXUbeOc1POniDowgYx3xTnxiKUxt9XbaR3OKxS+AXc
         WjzepJTqaASNsDI6ELWTjDQVJP2ON+re2f3XvAeaGEtSNvQPmPlB7PXc2qezq+BkHkkS
         3uysPBXFV1edCV+DA0YLMx7M2oOk89WkDlR7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704770923; x=1705375723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2n04rycTbVj98G4Oti5JohO5PKOBYnQTDfzjI/yRas=;
        b=L1Z5Y+x4aXkJ03oTKsxbq5gnfYb9Zk6B+ke9rCM2rTdGhzqsfFvKi5LOH8P4dRRozB
         l3AXyReuxJHmoQ9S0MWDllXFFoCq0afui1mTAr6vDZxzvRQRJRJlH5nJGs8poRUE3tvd
         LKDuG5xqhZ3e1YttdPjF/1Iz3D9QVO3POCe/Y2OwHNNqPpkv/y3dOu7200qshp3cdfBY
         DSg9QXx4rRAKfaGB5f0JdHP3GrxqEGIcgKA4c4BOoW83dmg50xSGB/2YERXE5rn9k2ge
         gJ8Xr7E7FNQG6GSVWeAYpN1G/BjWPpzGMcnJBg+GYq3LKcFJHT8Ul/wJrV3xQue4liw8
         OTmQ==
X-Gm-Message-State: AOJu0YwCS3fMduVet7M5bJeeUQZ/xaN4MSKTfrqqpUamcbOhY7APfvKF
	bQheP2Bh3FxCeFfyz0aDVfXAcoVhHhIvkziDZaUtXfR54w5yehOO
X-Google-Smtp-Source: AGHT+IFzPrBqfjSA5gCduhypKVEkQZZSDbTbFwlu5Qww1HDkf/lbCTqev/AqGX3nhodGSS9odLZ5lQ==
X-Received: by 2002:a17:906:f102:b0:a29:f46f:f572 with SMTP id gv2-20020a170906f10200b00a29f46ff572mr147058ejb.104.1704770923692;
        Mon, 08 Jan 2024 19:28:43 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ch19-20020a170906c2d300b00a2b091e93aesm525605ejb.115.2024.01.08.19.28.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 19:28:42 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso2785813a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:28:42 -0800 (PST)
X-Received: by 2002:a17:906:36c7:b0:a28:e76c:f928 with SMTP id
 b7-20020a17090636c700b00a28e76cf928mr156222ejc.6.1704770921784; Mon, 08 Jan
 2024 19:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <CAHk-=wgnLA7Jhjiuz8W76PRyQheLCkNS__=D1onenqbhpiXsVQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgnLA7Jhjiuz8W76PRyQheLCkNS__=D1onenqbhpiXsVQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 19:28:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1vvUhNd_+s8Cuvh-wO2iT7bN-vFfxhVXNOsGGGigDZg@mail.gmail.com>
Message-ID: <CAHk-=wj1vvUhNd_+s8Cuvh-wO2iT7bN-vFfxhVXNOsGGGigDZg@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, Josh Triplett <josh@joshtriplett.org>
Content-Type: multipart/mixed; boundary="000000000000379261060e7ae964"

--000000000000379261060e7ae964
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 17:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because I *guarantee* that we can trivially write another benchmark
> that shows that looking up the pathname twice is worse.

Ok, so I just took a look at the alleged benchmark that was used for
the "look  up twice" argument.

It looks quite broken.

What it seems to do is to "fork+execve" on a small file, and do
clock_gettime() in the parent and in the child, and add up the
differences between the times.

But that's just testing random scheduler interactions, not the speed
of fork/exec.

IOW, that one improves performance if you always run the child first
after the fork(), so that the child runs immediately, finishes the
work, and when the parent then resumes, it reads the completed result
from the pipe.

It will give big behavior changes for any scheduling behavior - like
trying to run children concurrently on another CPU vs running it
immediately on the same CPU etc etc.

Using "vfork()" instead of "fork()" will remove *one* variable, in
that it will force that "child runs first" behavior that you want, and
would likely help performance a lot. But even then you'll end up with
a scheduling benchmark: when the child does "execve()" that will now
wake up the parent again, and the *optimal* behavior is probably to
run the child fully until it does "exit" (well, at least until it runs
"clock_gettime()") before scheduling the parent.

You might get that by just forcing it all to run on one single CPU,
unless the wakeup by the execve() synchronously wakes up the parent.

IOW, you can probably get closer to the numbers you want with vfork(),
but even then it's a crap-shoot and depends on scheduling.

If you want to actually test execve() itself, you shouldn't use fork()
at all - you should literally execve() in a loop, using the execve()
argument as the "loop variable". That will actually test execve(), not
the scheduling of the child, which will be pretty random.

IOW, something (truly stuipid) like the attached, and then you do

    $ gcc -O2 --static t.c
    $ time ./a.out 100000 1

to time a hundred thousand execve() calls.

Look ma, no fork, vfork, or scheduler interactions.

Of course, if you then want to check the pathname lookup failure cost,
you'd need to change the "execve()" into a "execvpe()" and play around
with the PATH variable, putting "." in different places etc. And you
might want to write your own PATH lookup one, to make sure it actually
uses the "execve()" system call and not "stat()" to find the
executable.

. and do you want to then check using "execveat()" (new model) vs
"path string created by appending in user space" (classic model)?

Tons of variables. For example, modern "execveat()" behavior is
*probably* using a small pathname that is looked up by opening the
different directories in $PATH, but the old-school thing that creates
pathnames all in user space and then does "execve()" on them will
probably have fairly heavy path lookup costs.

So now the whole "look up path twice" might be very differently
expensive depending on just how you ended up dealing with the $PATH
components. It *could* be cheap. Or it might be looking up a long
path.

End result: there's a million interactions here. You need to decide
what you want to test. But you *definitely* shouldn't decide to test
some random scheduler behavior and call it "execve cost".

                Linus

--000000000000379261060e7ae964
Content-Type: text/x-c-code; charset="US-ASCII"; name="t.c"
Content-Disposition: attachment; filename="t.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lr5rvloi0>
X-Attachment-Id: f_lr5rvloi0

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjaGFyICoqZW52cCkKewoJY2hhciBi
dWZmZXJbMTBdOwoJaW50IG4sIG07CgoJaWYgKGFyZ2MgPCAzKQoJCWV4aXQoMSk7CgluID0gYXRv
aShhcmd2WzFdKTsKCWlmIChuIDw9IDApCgkJZXhpdCgyKTsKCW0gPSBhdG9pKGFyZ3ZbMl0pOwoJ
aWYgKG0gPj0gbikKCQlleGl0KDApOwoJc25wcmludGYoYnVmZmVyLCBzaXplb2YoYnVmZmVyKSwg
IiVkIiwgbSsxKTsKCWFyZ3ZbMl0gPSBidWZmZXI7CglleGVjdmUoIi4vYS5vdXQiLCBhcmd2LCBl
bnZwKTsKCWV4aXQoMyk7Cn0K
--000000000000379261060e7ae964--

