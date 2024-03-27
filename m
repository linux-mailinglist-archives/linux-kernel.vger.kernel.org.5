Return-Path: <linux-kernel+bounces-121851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149D88EE81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7372A3DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F01514CC;
	Wed, 27 Mar 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vz588ZcO"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9F150981
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565218; cv=none; b=Wmlv4kHiaSUXJFGWlKHbzS1cwc37UgxbMvowLsctjeOPIv6vJKnbBz1xhCca6SeddOsJJhdgccvepo+h5AyReKddUIyHnxOmPFALtgAwg60vSpdZysJ92hNv+5dlkghTRziQuZjApSW76E1D1EhNXpsWBJwe6eOfvkP9tDba0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565218; c=relaxed/simple;
	bh=wOYDqXQBwndxLNpGzVpA/alUz261GjYTc0wTNh/rnrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFqpaKNY0U8Zce0QRGYiF6MsEQpyjioSeNUNczmU5VAJEgzNN9r7RxIl9xefF2eW0oOkpFNmeJwY6dnArkcbB3b3ZwosrsBkyB9hQTZr0EnNHqV97WYYFGX+u1Kz6p6k9FJy22tH1fb9nyGKdlvAqpuZWDxzzz1udgBEQKWmjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vz588ZcO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c621f56d-6354-45a3-8c41-1380f5f03b1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711565213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx1UbkHwdHZLLbNuRcSx7DJyIY0QwP+4nFSmm21yDtQ=;
	b=Vz588ZcOD6FrUivNA4zc/O2aYjnlG2CqGtHPSocyox7umNsKF3yrwoGxP1Xubf7bKxC3qD
	PdLQbAW86bvNr3QJAtjD+9zFfsK5J7mP1o1wTd3mzIRv2X7ddNDqhmGbirF6+MM4bUQ+Ib
	vU6poku+UMDG74k7C13EYaeERKDSLeA=
Date: Wed, 27 Mar 2024 11:46:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>,
 bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>
References: <0000000000006f876b061478e878@google.com>
 <a402206e-a9c9-40bd-bf78-710054506071@linux.dev>
 <CAADnVQLXyQ_o5hSA0OpHYj231WKPFNRNMyr0NePMr2ypusiLmg@mail.gmail.com>
 <5063d525-d9df-4aaf-991d-bcb9f495c041@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5063d525-d9df-4aaf-991d-bcb9f495c041@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/26/24 9:47 PM, Yonghong Song wrote:
> 
> On 3/26/24 6:07 PM, Alexei Starovoitov wrote:
>> On Tue, Mar 26, 2024 at 5:54 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>> On 3/25/24 2:36 AM, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    5e74df2f8f15 Merge tag 'x86-urgent-2024-03-24' of git://gi..
>>>> git tree:       upstream
>>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=148872a5180000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
>>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for 
>>>> Debian) 2.40
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15921a6e180000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e081f1180000
>>>>
>>>> Downloadable assets:
>>>> disk image: 
>>>> https://storage.googleapis.com/syzbot-assets/1a82880723a7/disk-5e74df2f.raw.xz
>>>> vmlinux: 
>>>> https://storage.googleapis.com/syzbot-assets/fd3046ac43b9/vmlinux-5e74df2f.xz
>>>> kernel image: 
>>>> https://storage.googleapis.com/syzbot-assets/2097be59cbc1/bzImage-5e74df2f.xz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com
>>>>
>>>> =====================================================
>>>> BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:441 
>>>> [inline]
>>>> BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 
>>>> kernel/bpf/devmap.c:796
>>>>    __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
>>>>    dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
>>>>    ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
>>>>    bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
>>>>    ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>>>>    __bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237
>>> It should be in the interpreter mode.
>>>
>>> The C reproducer is trying to run the following bpf prog:
>>>
>>>      0: (18) r0 = 0x0
>>>      2: (18) r1 = map[id:49]
>>>      4: (b7) r8 = 16777216
>>>      5: (7b) *(u64 *)(r10 -8) = r8
>>>      6: (bf) r2 = r10
>>>      7: (07) r2 += -229
>>>              ^^^^^^^^^^
>>>
>>>      8: (b7) r3 = 8
>>>      9: (b7) r4 = 0
>>>     10: (85) call dev_map_lookup_elem#1543472
>>>     11: (95) exit
>>>
>>> I think this KMSAN report (and a few others related to lookup/delete_elem)
>>> should only happen in the interpreter mode.
>>>
>>> Does it worth to suppress it by always initializing the stack in the interpreter
>>> mode considering the interpreter is not very speed sensitive ?
>> Maybe we can mark it as initialized from kmsan pov ?
>> There are kasan_poison/unpoison helpers that may fit ?
> 
> Maybe use kmsan_unpoison_memory()?

Good idea. It should do. My qemu cannot boot with CONFIG_KMSAN somehow.
I will ask syzbot to test.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git interpreter.kmsan

