Return-Path: <linux-kernel+bounces-147675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D08A7791
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B39284093
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F07FBC4;
	Tue, 16 Apr 2024 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ5QzIx+"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E816BFCF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305681; cv=none; b=YlYqiPpmwPSGPJHeuPYDZMINs3ywlEcugK1M9h8+l8ID0Ua3pkncNVrmnfJoswkSELvCNeWTbqVn8pvmRv707pG1xBRiUE2iZs4qtrqhpHJkD4vEqTyOj0qzBKMRIWrSzaNVMLzuKTAbFB9xZYSay2I4n+lZn3EzCdPF0JOpcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305681; c=relaxed/simple;
	bh=q4fRLk9+tAhkY4aESShDjw4n0G93kWV+J2n0vSGFIRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftOGNHiEuHJyOxAK6DCLLzjEGRPWoGzAhiFMWIMxrAZRqcLSBHOjLAWvCm6J35bhfPKuy5Cfsey8fPZlB+od3pNHn9n46zUiOcNyostFSXVkiOqCU89HymdRIPvGN353ja+XoDrsopemOZKE4OS4ojJ+PrVojdjTVXmE99v+z0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJ5QzIx+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6962950c6bfso37637956d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713305678; x=1713910478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aYsMRrzYxQCUVBrOxNqk13aw5qaXXmFEDQjj8kthyE=;
        b=fJ5QzIx+htdbVzubF9+j/RGMfa37mPkZ7KFa/Ua0AZUkIBadFciFNnFyiegq30G8GO
         WbCZDWhidCuH/tzE0hpOQjHOI60nHrCcF9UL0cPTsKcAd1UPPhaC+in6F8m8ZuRGvuSD
         EBQ1/ESAn8My6HUwJtyr/3maoFAgprfGIAvCOn6mwV5sldzRfHt5bTOH8jLTkU3hm8F5
         v3nkb8qQtgwopciJVK5QMDt3U8J3GhYXHJxOH6XpOZ2e0mg7QCn/sUHA4qFflcsCamwU
         Syc2UW5m9SIhA1szrc7VZed3PP4tOhLijiEcsAepAh1i7dLDUNNG4DUPeAM9Cp3K4tnE
         0hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305678; x=1713910478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aYsMRrzYxQCUVBrOxNqk13aw5qaXXmFEDQjj8kthyE=;
        b=l4pRLDQ4Suzr4HgBVQc8Yadg0wzMu6Rx6NVkAeNlHdbVsG27u4/L1GHDoxIuiLxtFu
         J3L1vod5x5HY4U9kBg9QAkFQc7oPAOpk7ufGclFdGJuAuSaUUnRJfkUP/HNPj3K4Q1rs
         S7SMuB//NjX6g0rlfJTH33+dF8jPYcQ8HZAweqqSS33UE5hnYvmFvqS/GEI+FsMNMbwv
         OL41ZmsFYq7BZjN9hRsaUKE7emxfBHuaJPt82oM8xDSNItRh9YiYlNaS1R6fdqTYjPQE
         rNrYq4tLv+/LYdiz+74liHnOtfXBh05HmzzIRVwm8TDZsAdlH5d6z85QqsQMfiKYHyVM
         mPYA==
X-Forwarded-Encrypted: i=1; AJvYcCUdSqqelPy/cAgcClFShhOUAbABT1vprg37SJ3UJf1S9Nx5fFhWmawdJ2RxNbM30C808gl8s77t60qTNOLqOWEQ0r8fhE7/2kzYDPZ5
X-Gm-Message-State: AOJu0Yy7hW9Msk6TS0oHsm8Zu1rZSfUO3dHdG6doD7uvYqxbf0GobOH+
	6mEBV4LbFsYz5Ja3s90Diaf94QjV6SFXeDhx2QO0BbXaOALU6L+D8rEbEwdWMeMrp7EMz8Mz228
	ftJ5GLtaLlxqgETV2232h0sSgJ1E=
X-Google-Smtp-Source: AGHT+IF5j7OYKDgP51t6gSbfFRcYCRp2cPH43nkOP42LlbiQe6j923ydWMOPUyDg1JrFYTGi0haAc1fc4gVhM8xSLMQ=
X-Received: by 2002:a0c:f98c:0:b0:69b:ff74:4c6 with SMTP id
 t12-20020a0cf98c000000b0069bff7404c6mr5181182qvn.24.1713305678593; Tue, 16
 Apr 2024 15:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
In-Reply-To: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 16 Apr 2024 15:14:27 -0700
Message-ID: <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
To: Christian Heusel <christian@heusel.eu>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>, 
	"Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>, regressions@lists.linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:19=E2=80=AFAM Christian Heusel <christian@heusel.=
eu> wrote:
>
> Hello everyone,

Thanks for the report, Christian! Looking at it now.

>
> while rebuilding a few packages in Arch Linux we have recently come
> across a regression in the linux kernel which was made visible by a test
> failure in libguestfs[0], where the booted kernel showed a Call Trace
> like the following one:
>
> [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-mai=
nline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M

Is this one of the kernel versions that was broken? That looks a bit
odd, as zswap shrinker landed on 6.8...

> [  218.739007] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS A=
rch Linux 1.16.3-1-1 04/01/2014^M
> [  218.739787] RIP: 0010:memcg_page_state+0x9/0x30^M
> [  218.740299] Code: 0d b8 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 <=
48> 8b 87 00 06 00 00 48 63 f6 31 d2 48 8b 04 f0 48 85 c0 48 0f 48^M
> [  218.740727] RSP: 0018:ffffb5fa808dfc10 EFLAGS: 00000202^M
> [  218.740862] RAX: 0000000000000000 RBX: ffffb5fa808dfce0 RCX: 000000000=
0000002^M
> [  218.741016] RDX: 0000000000000001 RSI: 0000000000000033 RDI: 000000000=
0000000^M
> [  218.741168] RBP: 0000000000000000 R08: ffff976681ff8000 R09: 000000000=
0000000^M
> [  218.741322] R10: 0000000000000001 R11: ffff9766833f9d00 R12: ffff9766f=
fffe780^M
> [  218.742167] R13: 0000000000000000 R14: ffff976680cc1800 R15: ffff97668=
2204d80^M
> [  218.742376] FS:  00007f1479d9f540(0000) GS:ffff9766fbc00000(0000) knlG=
S:0000000000000000^M
> [  218.742569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> [  218.743256] CR2: 0000000000000600 CR3: 0000000103606000 CR4: 000000000=
0750ef0^M
> [  218.743494] PKRU: 55555554^M
> [  218.743593] Call Trace:^M
> [  218.743733]  <TASK>^M
> [  218.743847]  ? __die+0x23/0x70^M
> [  218.743957]  ? page_fault_oops+0x171/0x4e0^M
> [  218.744056]  ? free_unref_page+0xf6/0x180^M
> [  218.744458]  ? exc_page_fault+0x7f/0x180^M
> [  218.744551]  ? asm_exc_page_fault+0x26/0x30^M
> [  218.744684]  ? memcg_page_state+0x9/0x30^M
> [  218.744779]  zswap_shrinker_count+0x9d/0x110^M
> [  218.744896]  do_shrink_slab+0x3a/0x360^M
> [  218.744990]  shrink_slab+0xc7/0x3c0^M
> [  218.745609]  drop_slab+0x85/0x140^M
> [  218.745691]  drop_caches_sysctl_handler+0x7e/0xd0^M
> [  218.745799]  proc_sys_call_handler+0x1c0/0x2e0^M
> [  218.745912]  vfs_write+0x23d/0x400^M
> [  218.745998]  ksys_write+0x6f/0xf0^M
> [  218.746080]  do_syscall_64+0x64/0xe0^M
> [  218.746169]  ? exit_to_user_mode_prepare+0x132/0x1f0^M
> [  218.746873]  entry_SYSCALL_64_after_hwframe+0x6e/0x76^M
>
> The regression is present in the mainline kernel and also was
> independently reported to the redhat bugtracker[1].
>
> I have bisected (see log[2]) the regression between v6.9-rc4 and v6.6
> and have landed on the following results (removed unrelated test commit)
> as remainders since some of the commits were not buildable for me:
> - 7108cc3f765c ("mm: memcg: add per-memcg zswap writeback stat")
> - a65b0e7607cc ("zswap: make shrinking memcg-aware")
> - b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")

