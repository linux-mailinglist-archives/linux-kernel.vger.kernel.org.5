Return-Path: <linux-kernel+bounces-104966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14987D6B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF071F2388B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA45677B;
	Fri, 15 Mar 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fvtASvfd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A25C4595D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542321; cv=none; b=di/gH2MAPIFN1j8YMqzmXJf6LlhenR/XzdwtaW9rHgdEawMX4SUiDXhS1pEbrXdhNOCNVj7F9YvttCck8UmYD1s6QgRvKs8TM9+Zo8t27V2BzWraV+1/4bgcNB2Zj51IsLkCJXB2LbRsPNLyP4W0OPrc0y6GVbYX0vf3RHSpXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542321; c=relaxed/simple;
	bh=ZtmGBms18y5rLruGa78SQlS9w6D2T7MxwMlTdsX4dsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UMM0KL8ygnImQjjUu+9AyDV8BMGoaTCUp9mnfFTzzU8i+SRHprIG608Iv2R1jxraCYE0jtRKfB1WAnS1MQRpUhKd8KFwoiz66hf5yronwSdaLm3xLQW2n+uc6qts1CjbmTtZlyvR6ryFFhmeVdiwOx2ocOiE5I0P2XeGVMVtPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fvtASvfd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1def81ee762so2193755ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710542316; x=1711147116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ic+kabnMCMY5KJ+q4SJK00XV6xYupnupycxy1eugygg=;
        b=fvtASvfdsG/qGWoIa55zZBR3s2EWEf2TCtxXLc0OlQraH2o99FJJ/DEV11AadyaZ/a
         X9MfGqoqtkAv/jTsJrHefD5l8wa3OFvjERzqo1Hhqf1qty2Hg1N/k9IjKWbtu1wgYGmr
         ahXEAk77JLNP9xSTybrhMK+v5IA7yvf1QJy3C8UAJopyTd9fvUh+0hOZFWH9AoRyb6r6
         hWe5qGgpPvnxoPpvqgAt+tk9xCaqnU37LTziQiKzzYkfqWPGwzeXOSsu4HPGZmWZ4Blp
         LcFDWdOHy5VdvKks/ux83nOsbSH5OxR7KYI/1K7RbAnE7CZ3LMGCr0oHwk/71iwGBKBu
         DfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710542316; x=1711147116;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic+kabnMCMY5KJ+q4SJK00XV6xYupnupycxy1eugygg=;
        b=B21HnMXDcJq2ooX8HfsjXGO7yOiLGRcmugi7JnO/rGKBpiIY2oj7BDqMCtn3Z2cHv4
         DvrLrSzwVcEmCw0SLG7VGIT/B0PSEOiUmwk8hyAReIo3zeCRjBozuXc91IGegRA3j/9L
         GFBmmjB1ekccDxU9jqTCGRVGLju7UooZXefEgGovaAQOK7hO5HhIZ6SNHfI4L34VngVZ
         +GHnBXRc5zPW/VUX+Ro9uVStLlhzVkU2l48CCNNV9y4fzUaV4cZfuNAdAsVlB2PcnD3q
         TZ871M40zTp03SCqUUzRLejvl9hnZ5W0bkmQ+kFm7e6tcB/xVD5hZ/kpnv3KI9dZNIyX
         sJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26BtGn0IG0iTHNcQ7+SMc0/vW/GEUxNptJ80LiIZ4rSyPHaGSbPpnsMe1AWHaDa6S9xqZy7ty/Eng8qSHSEpw7KZwcE3tb4RdiN6D
X-Gm-Message-State: AOJu0YydpeHORbIkXBoRgehbxyfSKjnov6IgoCxwi8R/oDF4NN962d2c
	yrDyif7n/6dPUeJw4HEfFyeOPDrcACK8NuiD6S2dtOndo6JR9cFc8Dc2q1cy7KA=
X-Google-Smtp-Source: AGHT+IE+Rl8hRNTw4LjSIwnzdcVlE7pqV6EbEBqwGh98PqS29g23gF2U93X3qctGYOUNlZ9RRhvz1A==
X-Received: by 2002:a05:6a21:1706:b0:1a1:694d:d4f7 with SMTP id nv6-20020a056a21170600b001a1694dd4f7mr6813196pzb.0.1710542316403;
        Fri, 15 Mar 2024 15:38:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id n45-20020a056a000d6d00b006e6ff8ba817sm1208238pfv.16.2024.03.15.15.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 15:38:35 -0700 (PDT)
Message-ID: <b090c928-6c42-4735-9758-e8a137832607@kernel.dk>
Date: Fri, 15 Mar 2024 16:38:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
Content-Language: en-US
To: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000024b0820613ba8647@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <00000000000024b0820613ba8647@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 4:28 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8ede842f669b Merge tag 'rust-6.9' of https://github.com/Ru..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=138f0ad6180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a271c5dca0ff14df
> dashboard link: https://syzkaller.appspot.com/bug?extid=f8e9a371388aa62ecab4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b4a6fa180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a59799180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/af1cd47b84ef/disk-8ede842f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/be9297712c37/vmlinux-8ede842f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c569fb33468d/bzImage-8ede842f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1334
>  io_sendrecv_fail+0x91/0x1e0 io_uring/net.c:1334
>  io_req_defer_failed+0x3bd/0x610 io_uring/io_uring.c:1050
>  io_queue_sqe_fallback+0x1e3/0x280 io_uring/io_uring.c:2126
>  io_submit_fail_init+0x4e1/0x790 io_uring/io_uring.c:2304
>  io_submit_sqes+0x19cd/0x2fb0 io_uring/io_uring.c:2480
>  __do_sys_io_uring_enter io_uring/io_uring.c:3656 [inline]
>  __se_sys_io_uring_enter+0x409/0x43e0 io_uring/io_uring.c:3591
>  __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3591
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b

This is similar to the issue fixed by:

commit 0a535eddbe0dc1de4386046ab849f08aeb2f8faf
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Dec 21 08:49:18 2023 -0700

    io_uring/rw: ensure io->bytes_done is always initialized

which I did fix separately for this case, just not in the 6.9 pile. I'll
move it over there to silence this one.

Only side effect of this is that cqe->res may not be -EINVAL, when it
should've been, for an ill formed request that was issued with
ISOQE_ASYNC.

#syz test: git://git.kernel.dk/linux.git io_uring-6.0

-- 
Jens Axboe


