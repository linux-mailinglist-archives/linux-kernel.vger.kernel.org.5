Return-Path: <linux-kernel+bounces-130652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D095C897AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00ACF1C21A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4816156969;
	Wed,  3 Apr 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SeMLSi4c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30475156960
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180694; cv=none; b=qRCT/01Sqjj5AXL/ulerTsY3v8nHXEHA2JyfkVohiJfgHYhz7jruzXf9X9q7ykXJo7Fgm8QdYbFVy4F9LdRA+C8ic9U0kguAQto9WMhW/4qQPHI80Eq7fS1NxAUbdDWMEkZpf/37cZWUgJu8pAILuk96EDygE517oIjCgC3vz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180694; c=relaxed/simple;
	bh=CDKPrN1TxldCtbd7s9KjHV0KIdtctnJ3llKI7zwSwVA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nQr4p72Y/D78K+GA2eg53Cy0kKcr73+td/tX9CWatgEcXUj63dDnQH7u9Am+y6EVi3teKk9ZxRrCUAS79XLJ8XWfy9K+jwICV/N35l01gDxr27ht/nIdA79P8ObEtcNUA5by28U3Va2sj31mavChcyY3rVddJOmfL41x97hVTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SeMLSi4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1B0C433F1;
	Wed,  3 Apr 2024 21:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712180693;
	bh=CDKPrN1TxldCtbd7s9KjHV0KIdtctnJ3llKI7zwSwVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SeMLSi4cdcTkjlXHDLRQ4ZdgokBSDp4hY6UCBlLXNt/E1ltZAxKMF/8BqAdNEsI5r
	 EnqX3FlGkf45q/FQCnlriIjCnVkoQ5x5q3F7Bk/AP+mxYh/S/lJQ7br02WB6CsdYTj
	 7YezKPrh22gnLI1TtVgV275YQN2CZSEgG5mPl07k=
Date: Wed, 3 Apr 2024 14:44:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in __delete_from_swap_cache /
 folio_mapping (3)
Message-Id: <20240403144452.1c68c2be42383de895795cfd@linux-foundation.org>
In-Reply-To: <00000000000092ec58061522b2c7@google.com>
References: <00000000000092ec58061522b2c7@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Apr 2024 13:10:29 -0700 syzbot <syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=129de21d180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d024e89f7bb376ce
> dashboard link: https://syzkaller.appspot.com/bug?extid=58fc2a881f3b3df5e336
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b9b2dcffd7d5/disk-39cd87c4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5f4981fa60e6/vmlinux-39cd87c4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/691f671f70ad/bzImage-39cd87c4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in __delete_from_swap_cache / folio_mapping
> 
> write to 0xffffea0004798fa8 of 8 bytes by task 29 on cpu 0:
>  __delete_from_swap_cache+0x1f2/0x290 mm/swap_state.c:161

	folio->swap.val = 0;

>  delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:241
>  folio_free_swap+0x19f/0x1c0 mm/swapfile.c:1600
>  free_swap_cache mm/swap_state.c:290 [inline]
>  free_pages_and_swap_cache+0x1d9/0x400 mm/swap_state.c:322
>  __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
>  tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
>  tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
>  tlb_finish_mmu+0x8c/0x100 mm/mmu_gather.c:465
>  __oom_reap_task_mm+0x231/0x2e0 mm/oom_kill.c:553
>  oom_reap_task_mm mm/oom_kill.c:589 [inline]
>  oom_reap_task mm/oom_kill.c:613 [inline]
>  oom_reaper+0x264/0x850 mm/oom_kill.c:654
>  kthread+0x1d1/0x210 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> 
> read to 0xffffea0004798fa8 of 8 bytes by task 14567 on cpu 1:
>  folio_mapping+0xd2/0x110 mm/util.c:797

		return swap_address_space(folio->swap);

>  folio_evictable mm/internal.h:256 [inline]
>  move_folios_to_lru+0x137/0x690 mm/vmscan.c:1808
>  shrink_inactive_list mm/vmscan.c:1929 [inline]
>  shrink_list mm/vmscan.c:2163 [inline]
>  shrink_lruvec+0xbd8/0x1640 mm/vmscan.c:5687
>  shrink_node_memcgs mm/vmscan.c:5873 [inline]
>  shrink_node+0xa78/0x15a0 mm/vmscan.c:5908
>  shrink_zones mm/vmscan.c:6152 [inline]
>  do_try_to_free_pages+0x3cc/0xca0 mm/vmscan.c:6214
>
> ...
>

These both point at David's 3d2c90876887 ("mm/swap: inline
folio_set_swap_entry() and folio_swap_entry()") which is probably
innocent, but I have to blame someone ;)


