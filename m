Return-Path: <linux-kernel+bounces-153444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8838ACE32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8961A1F21CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B134214F9D0;
	Mon, 22 Apr 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUh7iEef"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E814F13F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792530; cv=none; b=o7FwvAhnIoUsJzUk5HYQRg/seY5Qe5H6/sX8CRlXNi2G39+GK7/PT8BBPV7e2GHxdSgtCsRRuon9ecABSLymcLByThppoiitk7AhLV+lNaRpOaA+5+xenyA2XkKQzZ+9Cb/ACAK8HQa8K4Q/od6ZMO9LXyvziOLSUQSgcUDnWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792530; c=relaxed/simple;
	bh=ICBRHlNv7/Wy1dHLCfNb0/4GATOt0LHkmAk8lRNZVZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUNdic4REQuAp9u92iljig5THF7RoPl+QV9ZTI6r/0mGYS7K1/0NIMM7J8k0PAnkcNVKpGQVdKT9HK7MCGKYdcqP0fElhhW8oYF0E0Xh8muwbbVABM7YEfy3QRtrERkX9iy/KT+tM4GPIx1C9CzRStNvXGNr67vpiOVoYJx6MTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUh7iEef; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713792527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7nGMYM1ObJNYkSWSkE2Vwl6HKyd/jmr+aEnngjs+Gw=;
	b=aUh7iEefR62L7yKV0Z72fSkmu4Lm/bC6LELlcTirTCPBd8YU5ElCG5GimA7ryFblyzImXb
	Chrrlg6M+7hfX//eqivZp+bCRuGy1NFjKtE0suPD8zpr+QoQBLG9K61pUg6dvUmFW2ZDr5
	IIdXa3ChD/cSs7kS6eVWu9Ov/oFAC4Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-m8uv9udRN8ud9Hv11xwSTg-1; Mon, 22 Apr 2024 09:28:46 -0400
X-MC-Unique: m8uv9udRN8ud9Hv11xwSTg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6a0426cdfe6so615536d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792525; x=1714397325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7nGMYM1ObJNYkSWSkE2Vwl6HKyd/jmr+aEnngjs+Gw=;
        b=uypt0zvCBHzjRvRTf9vDyES2IQZGoUtY7PC9nSa9YAlY+TM9XLu+FCiFoqyB62YBHr
         cvX0V9BM8FC1/wL+3hs+qh6TdvdA5ZktVSxM2n3L6eJwfQ9vPY4vJp577gJTH7Ab/ruk
         pfwH0efeyjlsPEVhFHRR+JiPN/2HfNEVd1w0SSlcfsV1oCYyHpaNYnwJz2rBlTltDPTv
         9c1dLyrlJLfDb14GLw4UmBoFmcNpbW7LKiiB01iuvZck4DsWU741dFzvVmHyt4/XhQ2H
         AyA4aflTKISj7jpNYWWoonWDtmCEbSbzhck6K++1YdqZkgFMbIo4WQCJnYOzZIHvMBZK
         KbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFkvpEeULvQ9OUAwiijQmJtk5M3bH6BrQdxM89H/jqaC3CptwliTdQVejFbWZj2+sNOTnvYP4XVN63RK3YiKbbjbtQR7V1bYapeMqk
X-Gm-Message-State: AOJu0YyTJj412hyEcFT1tAFa+boo+TPfPRe5S1hMUjfREHrh1PUcWDdm
	1IcjGUVQejj76pqAry8KWnow09BvI5+qFM1qhLoHOWuOLx8o/6gBj78quV29AJCq1yqLhGnXKqM
	hqr1nQcfADe7DfR9VKFv6g3U4kbF+uIe4kutHx94S+HyjdYb3JPKnCG4EkMRDTQ==
X-Received: by 2002:a0c:c483:0:b0:6a0:611e:468 with SMTP id u3-20020a0cc483000000b006a0611e0468mr12727257qvi.6.1713792525233;
        Mon, 22 Apr 2024 06:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjujza0JD41mP8hhaa5pLNh8YrQ9lS+Dksq6zcK9/U+bbdFWeDHpsWDUF2UW0470X0BylS8g==
X-Received: by 2002:a0c:c483:0:b0:6a0:611e:468 with SMTP id u3-20020a0cc483000000b006a0611e0468mr12727213qvi.6.1713792524596;
        Mon, 22 Apr 2024 06:28:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id v15-20020a0c8e0f000000b0069b4ddcbd42sm3366921qvb.0.2024.04.22.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:28:44 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:28:42 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, pasha.tatashin@soleen.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set
Message-ID: <ZiZmCl3fTFfIYf1t@x1n>
References: <000000000000ca4df20616a0fe16@google.com>
 <71cf84d4-77d2-42d7-a649-b67497b171f6@redhat.com>
 <a4c4c508-0d04-428c-b674-ec6e8847ea9f@redhat.com>
 <bbeb3704-e4a6-42fa-90e7-28de1e885249@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbeb3704-e4a6-42fa-90e7-28de1e885249@redhat.com>

On Mon, Apr 22, 2024 at 01:46:20PM +0200, David Hildenbrand wrote:
> On 22.04.24 12:38, David Hildenbrand wrote:
> > On 22.04.24 12:07, David Hildenbrand wrote:
> > > On 21.04.24 22:16, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    4eab35893071 Add linux-next specific files for 20240417
> > > > git tree:       linux-next
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1727a61b180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=27920e47287645ff
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=d8426b591c36b21c750e
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156da22d180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163dfec7180000
> > > > 
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/9f7d6c097fb4/disk-4eab3589.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/287b16352982/vmlinux-4eab3589.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/23839c65c573/bzImage-4eab3589.xz
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
> > > > 
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 5084 at mm/page_table_check.c:199 __page_table_check_pte mm/page_table_check.c:199 [inline]
> > > > WARNING: CPU: 0 PID: 5084 at mm/page_table_check.c:199 __page_table_check_ptes_set+0x1db/0x420
> > > 
> > > I think this is
> > > 
> > > if (pte_present(pte) && pte_uffd_wp(pte))
> > > 	WARN_ON_ONCE(pte_write(pte));
> > > 
> > > mm/page_table_check.c:213
> > > > Modules linked in:
> > > > CPU: 0 PID: 5084 Comm: syz-executor382 Not tainted 6.9.0-rc4-next-20240417-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > > > RIP: 0010:__page_table_check_pte mm/page_table_check.c:199 [inline]
> > > > RIP: 0010:__page_table_check_ptes_set+0x1db/0x420 mm/page_table_check.c:213
> > > > Code: 48 8b 7c 24 40 48 c7 c6 80 19 46 8e e8 ee df 8e ff 41 83 fc 1d 74 18 41 83 fc 1a 75 1d e8 5d da 8e ff eb 10 e8 56 da 8e ff 90 <0f> 0b 90 eb 10 e8 4b da 8e ff 90 0f 0b 90 eb 05 e8 40 da 8e ff 48
> > > > RSP: 0018:ffffc9000366f740 EFLAGS: 00010293
> > > > RAX: ffffffff8207833a RBX: ffffc9000366f7c0 RCX: ffff888022af3c00
> > > > RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> > > > RBP: ffffc9000366f830 R08: ffffffff820782af R09: 1ffffd40000a6a10
> > > > R10: dffffc0000000000 R11: fffff940000a6a11 R12: 0000000000000000
> > > > R13: 0000000014d42c67 R14: 0000000000000001 R15: 0000000000000000
> > > > FS:  0000555567f79380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 000000000066c7e0 CR3: 0000000078cb0000 CR4: 00000000003506f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >     <TASK>
> > > >     page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
> > > >     set_ptes include/linux/pgtable.h:267 [inline]
> > > >     __ptep_modify_prot_commit include/linux/pgtable.h:1269 [inline]
> > > >     ptep_modify_prot_commit include/linux/pgtable.h:1302 [inline]
> > > >     change_pte_range mm/mprotect.c:194 [inline]
> > > >     change_pmd_range mm/mprotect.c:424 [inline]
> > > >     change_pud_range mm/mprotect.c:457 [inline]
> > > >     change_p4d_range mm/mprotect.c:480 [inline]
> > > >     change_protection_range mm/mprotect.c:508 [inline]
> > > >     change_protection+0x2770/0x3cc0 mm/mprotect.c:542
> > > >     mprotect_fixup+0x740/0xa90 mm/mprotect.c:655
> > > >     do_mprotect_pkey+0x90d/0xe00 mm/mprotect.c:820
> > > >     __do_sys_mprotect mm/mprotect.c:841 [inline]
> > > >     __se_sys_mprotect mm/mprotect.c:838 [inline]
> > > >     __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:838
> > > >     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >     do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> > > >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7f45514bf429
> > > > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007ffe52191598 EFLAGS: 00000246 ORIG_RAX: 000000000000000a
> > > > RAX: ffffffffffffffda RBX: 00007ffe52191768 RCX: 00007f45514bf429
> > > > RDX: 000000000000000f RSI: 0000000000004000 RDI: 0000000020ffc000
> > > > RBP: 00007f4551532610 R08: 00007ffe52191768 R09: 00007ffe52191768
> > > > R10: 00007ffe52191768 R11: 0000000000000246 R12: 0000000000000001
> > > > R13: 00007ffe52191758 R14: 0000000000000001 R15: 0000000000000001
> > > >     </TASK>
> > > 
> > > Did we find a real issue that involves mprotect()?
> > > 
> > > At least can_change_pte_writable() should always return "false" for
> > > userfaultfd_pte_wp().
> > > 
> > > Do we maybe have a uffd-wp PTE outside of a UFFD_WP VMA?
> > > 
> > > Or was the PTE already writable and we only detect it now as we call
> > > mprotect()? (missed to detect it earlier?)
> > 
> > Staring at the reproducer, we do
> > 
> > 
> >     syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
> >             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
> >             /*offset=*/0ul);
> >     syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
> >             /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
> >             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
> >             /*offset=*/0ul);
> > 
> > -> Writable anonymous memmory
> > 
> >     syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
> >             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
> >             /*offset=*/0ul);
> >     intptr_t res = 0;
> >     res = syscall(__NR_userfaultfd,
> >                   /*flags=UFFD_USER_MODE_ONLY|O_NONBLOCK*/ 0x801ul);
> >     if (res != -1)
> >       r[0] = res;
> >     *(uint64_t*)0x200004c0 = 0xaa;
> >     *(uint64_t*)0x200004c8 = 0;
> >     *(uint64_t*)0x200004d0 = 0;
> >     syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc018aa3f, /*arg=*/0x200004c0ul);
> > 
> > -> _UFFDIO_API handshake?
> > 
> >     syscall(__NR_mprotect, /*addr=*/0x20ffc000ul, /*len=*/0x3000ul,
> >             /*prot=PROT_SEM|PROT_EXEC*/ 0xcul);
> > 
> > -> Protect target range R/O. I assume: no page populated yet?
> > -> 3 pages starting at 0x20ffc000ul;
> > 
> >     *(uint64_t*)0x20000180 = 0x20ffc000;
> >     *(uint64_t*)0x20000188 = 0x3000;
> >     *(uint64_t*)0x20000190 = 3;
> >     *(uint64_t*)0x20000198 = 0;
> >     syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc020aa00, /*arg=*/0x20000180ul);
> > 
> > -> _UFFDIO_REGISTER (aa00)
> > -> _range = 3 pages starting at 0x20ffc000ul
> > -> _mode = UFFDIO_REGISTER_MODE_WP | UFFDIO_REGISTER_MODE_MINOR
> > 
> >     *(uint64_t*)0x20000000 = 0x20ffd000;
> >     *(uint64_t*)0x20000008 = 0x20ffb000;
> >     *(uint64_t*)0x20000010 = 0x1000;
> >     *(uint64_t*)0x20000018 = 3;
> >     *(uint64_t*)0x20000020 = 0;
> >     syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc028aa03, /*arg=*/0x20000000ul);
> > 
> > -> _UFFDIO_COPY (aa03)
> > -> dst = 0x20ffd000
> > -> src = 0x20ffb000
> > -> len = 0x1000 (single page)
> > -> mode = UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP
> > 
> > -> We are copying into the R/O range. src should be R/W and trigger a page fault
> >      on access where we get a fresh page.
> > 
> >     *(uint16_t*)0x200000c0 = 1;
> >     *(uint64_t*)0x200000c8 = 0x20000040;
> >     *(uint16_t*)0x20000040 = 6;
> >     *(uint8_t*)0x20000042 = 0;
> >     *(uint8_t*)0x20000043 = 0;
> >     *(uint32_t*)0x20000044 = 0x7fffffff;
> >     res = syscall(__NR_seccomp, /*op=*/1ul, /*flags=*/0ul, /*arg=*/0x200000c0ul);
> >     if (res != -1)
> >       r[1] = res;
> >     syscall(__NR_open_tree, /*dfd=*/-1, /*filename=*/0ul, /*flags=*/0ul);
> > 
> > -> No idea what happens here and if it is relevant. If __NR_seccomp failed, we would
> >      no set r[1].
> > 
> >     syscall(__NR_close_range, /*fd=*/r[1], /*max_fd=*/-1, /*flags=*/0ul);
> > 
> > -> Is that closing uffd as well, especially if __NR_seccomp failed?
> > 
> >     syscall(__NR_mprotect, /*addr=*/0x20ffc000ul, /*len=*/0x4000ul,
> >             /*prot=PROT_SEM|PROT_WRITE|PROT_READ|PROT_EXEC*/ 0xful);
> > 
> > -> Restore write permissions. This seems to fire the uffd-wp page table check I assume.
> 
> I think the issue is that userfaultfd_release() will clear the VMA UFFD_WP flag,
> but it will not clear PTE uffd-wp bits. So we have leftover PTE uffd-wp bits at
> the time we wr-unprotect.
> 
> I thought we removed that lazy handling, but looks like we didn't consider the
> "close uffd" case in:
> 
> commit f369b07c861435bd812a9d14493f71b34132ed6f
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Aug 11 16:13:40 2022 -0400
> 
>     mm/uffd: reset write protection when unregister with wp-mode
> 
> 
> close should behave just like unregister.
> 
> 
> Simplified+readable reproducer:
> 
> #define _GNU_SOURCE
> 
> #include <stdint.h>
> #include <fcntl.h>
> #include <sys/syscall.h>
> #include <sys/mman.h>
> #include <sys/types.h>
> #include <sys/ioctl.h>
> #include <linux/userfaultfd.h>
> #include <unistd.h>
> 
> int main(void)
> {
>         void *src = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>         void *dst = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
>         struct uffdio_register uffdio_register = {};
>         struct uffdio_copy uffdio_copy = {};
>         struct uffdio_api uffdio_api = {};
>         int uffd;
> 
>         uffd = syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>         uffdio_api.api = UFFD_API;
>         ioctl(uffd, UFFDIO_API, &uffdio_api);
> 
>         uffdio_register.range.start = (uintptr_t)dst;
>         uffdio_register.range.len = 4096;
>         uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
>         ioctl(uffd, UFFDIO_REGISTER, &uffdio_register);
> 
>         uffdio_copy.dst = (uintptr_t)dst;
>         uffdio_copy.src = (uintptr_t)src;
>         uffdio_copy.len = 4096;
>         uffdio_copy.mode = UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP;
>         ioctl(uffd, UFFDIO_COPY, &uffdio_copy);
> 
>         close(uffd);
> 
>         mprotect(dst, 4096, PROT_READ|PROT_WRITE);
>         return 0;
> }

Thanks, I'll post a patch.

PS: next time feel free to try "strace ./reproducer", it'll do the
translations and I found it handy to work with syzbot.

-- 
Peter Xu


