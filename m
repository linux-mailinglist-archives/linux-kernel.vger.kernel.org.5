Return-Path: <linux-kernel+bounces-51386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF560848AB9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F5E1F23500
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C946FDC;
	Sun,  4 Feb 2024 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vB6EymuB"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830E63A1
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015581; cv=none; b=KlhWWzSzUgBwMJq018zPDg5+EfP/Wap7K/X6fPHilnqw0th7URmCLOb8lIZPLkY8sQfRXWfZ5yXx5szoTFwRQ/VZQ2ohyyPckEa4ly8vRyyF+rVZC40Ww601dSsbOXy0eI2kRJmLcBtEiXpKkoZ1sZxjmw+1BuOVGkzz349slmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015581; c=relaxed/simple;
	bh=ZT04HtB3mKaVDTC+tZUBXsKVqxI/TuiYloRo0jx9BQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m41GWAPbXvLQ48O6A6o4y1OG0K5V/X/RuHMFlSQfT0QfxfJURMQ6xrjOaLCTMoWExjlo19zS+4DdOafNQjA8JTF3apvSHtOFqYNHjXy0Ff0DdATgQcaLyQpkSZFt8ugKwmYCZAbafgM+F9IBFyi5eFYq8noz8TcO4aUllCAf0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vB6EymuB; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ea0950d-1b2e-47ae-b8a0-8bc0e99479f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707015576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtQLtcv75Hp76wlNnxYlPTsE3iyYS6NrvoUGxNyUIs4=;
	b=vB6EymuB3TpJMhRRntrC59cd5US6NXdH/dlN7iHTxlXCPlB9iJnsbaialYBRgO1aTgHzYs
	8RERJmfdF47juRBaMoIA4gHAlklWEe6JQvmTrhu3TsGWBCL1fX4gzBNaWZCE5oRXLg/VKb
	ELW5yF96K/30cmNq+KGfqTTOCPWAkCs=
Date: Sun, 4 Feb 2024 10:59:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [mm?] WARNING in zswap_folio_swapin
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>,
 syzbot <syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, yosryahmed@google.com
References: <000000000000ae47f90610803260@google.com>
 <CAKEwX=O1xg=BuLMbmv=n3L_mNRwhrumZ-ig4Y5N4JJ4Mu=d4Hg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=O1xg=BuLMbmv=n3L_mNRwhrumZ-ig4Y5N4JJ4Mu=d4Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/4 09:28, Nhat Pham wrote:
> On Sat, Feb 3, 2024 at 12:37 PM syzbot
> <syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=174537bbe80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
>> dashboard link: https://syzkaller.appspot.com/bug?extid=17a611d10af7d18a7092
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-861c0981.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/b2b204c7b4a0/vmlinux-861c0981.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/170ec316e557/bzImage-861c0981.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
>>
>>  kcov_ioctl+0x4f/0x720 kernel/kcov.c:704
>>  __do_compat_sys_ioctl+0x2bf/0x330 fs/ioctl.c:971
>>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>  __do_fast_syscall_32+0x79/0x110 arch/x86/entry/common.c:321
>> page has been migrated, last migrate reason: compaction
>> ------------[ cut here ]------------
>> WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 folio_lruvec include/linux/memcontrol.h:775 [inline]
>> WARNING: CPU: 2 PID: 5104 at include/linux/memcontrol.h:775 zswap_folio_swapin+0x47d/0x5a0 mm/zswap.c:381
>> Modules linked in:
>> CPU: 2 PID: 5104 Comm: syz-fuzzer Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> RIP: 0010:folio_lruvec include/linux/memcontrol.h:775 [inline]
> 
> Hmm looks like it's this line:
> VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled(), folio);
> 
> Looks like memcg was cleared from the folio. Haven't looked too
> closely yet, but this (and the "page has been migrated" line above)
> suggests maybe there is some migration business going on -
> mem_cgroup_migrate() clears the old folio's memcg_data (via
> old->memcg_data = 0).

Yeah, I think it's this case.

> 
> Here's my theory (which could be wrong - someone please fact-check
> me): swap_read_folio(), which precedes zswap_folio_swapin(), unlocks

And another case is !page_allocated, the returned folio is unlocked, right?

> the folio. Could this be sufficient to allow for migration? If this is

IMHO, folio locked is sufficient to avoid concurrent memcg migration.

> the case, all we need to do is move this to above swap_read_folio(),
> while the folio is still locked. __read_swap_cache_async() already
> charges the folio to an memcg, so no need to wait till after
> swap_read_page() anyway.

Should we call zswap_folio_swapin() in the !page_allocated case?

Thanks.

