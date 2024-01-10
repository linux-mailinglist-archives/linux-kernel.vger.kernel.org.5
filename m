Return-Path: <linux-kernel+bounces-21695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441148292E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE121C255B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594F46A2;
	Wed, 10 Jan 2024 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N44KXWay"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5CB2579
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd64022164so20577401fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704858888; x=1705463688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQomWPw7lpBHTPwDyjrX+b+lVnzi0pFQdhguQua8zrE=;
        b=N44KXWaypo9aHt6JHghPJzINSA04N5R9POZhO3yh5UlWN1jnig2fdlqfCoJMITP+V4
         kTIJRSygJQvzatOnzuymEi6i5sc9xih38ldMVVsKA+40fryh2zsPH9N0ktKCrUI80ka9
         1t/EmY1TkdNO2cd0l5xDNAcO+flqsVHLTjFHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704858888; x=1705463688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQomWPw7lpBHTPwDyjrX+b+lVnzi0pFQdhguQua8zrE=;
        b=Zf+YMsMmq+u5WzyNIsAOcYthQUip0EsmilvTzH/7CsFMsle6G6TemsIZAwuaDSyHfA
         aKx7JJnx/JX+aQcU4pEnOKQwyzqmfTjhvYHgSD8utF2EHQcFiOKiz/BjgU+AFeJQ3VHq
         lD5j8QD13Bk0KiVJ4Ky/Lbc5Du97pIqC3g4URX0Cm1NIvC/QL2KcguKm21XsHitAwZOs
         xqlBgZx2AofvcSzmHGm5OkT4AdZgAAm/RjhzwP2mcW1TgrUQ7/utKMLOe+NRj0nWQyeo
         UZpgLOoKeEOn+1lVTU0oAC2iO0k2XdDbmS5/+FMbL3Ap1hSQdaDGl51JKj8rnSQEvVmH
         44gw==
X-Gm-Message-State: AOJu0YwmOZZVFPu0QJaoS96YMY3d0Jb6uFOXqW3KSnumcxS55h/L36/q
	JR8X80ji+N9Sc8b9un5XQjDFqstHdh2zWze13bIOvjUdPDoR/Q==
X-Google-Smtp-Source: AGHT+IFopGQxwPsMG6itu0ACpBW/1nTzIVRYJ22jIVOUWR/Gn/aX3d+1bpU6zv13zeb6zGvcoAAm3Q==
X-Received: by 2002:a2e:99d3:0:b0:2cd:ccc:40a0 with SMTP id l19-20020a2e99d3000000b002cd0ccc40a0mr186465ljj.3.1704858888562;
        Tue, 09 Jan 2024 19:54:48 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id y24-20020a056402135800b00557b0f8d906sm1571579edw.70.2024.01.09.19.54.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 19:54:48 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28a997f3dfso276559966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:54:47 -0800 (PST)
X-Received: by 2002:a17:906:b75a:b0:a2a:ee98:f43d with SMTP id
 fx26-20020a170906b75a00b00a2aee98f43dmr198586ejb.76.1704858887577; Tue, 09
 Jan 2024 19:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com> <ZZ3_Jmb1sb2wQWO_@localhost>
In-Reply-To: <ZZ3_Jmb1sb2wQWO_@localhost>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jan 2024 19:54:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
Message-ID: <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Josh Triplett <josh@joshtriplett.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 18:21, Josh Triplett <josh@joshtriplett.org> wrote:
>
> Instead, here are some numbers from Linus's suggested benchmark
> (modified to use execvpe, and to count down rather than up so it doesn't
> need two arguments; modified version and benchmark driver script
> attached; compiled with `musl-gcc -Wall -O3 -s -static`):

Yeah, that's better. I had actually only benchmarked the success case.

And I see what the problem is: the "sane" way that only opens the
pathname once does so using

        file = do_filp_open(fd, name, &open_exec_flags);

and the "open path twice" does the first open with

        retval = filename_lookup(AT_FDCWD, filename, 0, &path, NULL);

and guess what the difference is?

The difference is that path_openat() starts out with

        file = alloc_empty_file(op->open_flag, current_cred());

and when the open fails, it will free the file with

        fput(file);

So if there are a lot of failures (because "." is at the end of the
path), it will have done a fair amount of those useless file
allocations and frees.

And - not surprisingly - the "open once" is then faster if there are
*not* a lot of failures, when the executable is found early in the
PATH.

Now, there's no fundamental *reason* to do that alloc_empty_file()
early, except for how the code is structured.

It partly makes the error handling simpler and since all the cases
want the filp in the end, doing it at the top means that it's only
done once.

And we occasionally do use the file pointer early (ie lookup_open()
will clear/set FMODE_CREATED in it even if it doesn't otherwise touch
the file pointer) even before the final lookup - and at creation time,
atomic_open() will actually want it for the final lookup.

Anyway, the real fix is definitely to just fix do_filp_open() to at
least not be *too* eager to allocate a file pointer.

In fact, that code is oddly non-optimal for another reason: it does
that "allocate and free file" not just when the path lookup fails, but
it does it for things like RCU lookup failures too.

So what happens is that if RCU lookup fails, do_filp_open() will call
path_openat() twice: first with LOOKUP_RCU, and then without it. And
path_openat() will allocate that "struct file *" twice.

On NFS - or other filesystems that can return ESTALE - it will in fact
do it three times.

That's pretty disgusting.

Al, comments? We *could* just special-case the execve() code not to
use do_filp_open() and avoid this issue that way, but it does feel
like even the regular open() case is pessimal with that whole RCU
situation.

                Linus

