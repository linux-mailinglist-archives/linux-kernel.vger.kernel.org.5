Return-Path: <linux-kernel+bounces-153305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46448ACC43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBCA282A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D0146A75;
	Mon, 22 Apr 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd81K1JT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768414430B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786388; cv=none; b=Q7Y/Inf47uhp4l3kkfhKpSn3V5IIfrUsjJihg8FMGDyWCRZmLKwVnxgRHwUYRcCE9Glj71uTTpV55/eMC/glh62pQxbwQnvYGdDqL+fwHvZE05DT30GktjTcU58mTeVUjmj7o7yU1kXvP+JR2PXMj3yjcmBJCfU0/zX7d7DIk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786388; c=relaxed/simple;
	bh=ARHZuCptwbv7C5Dgs1AF8iyq6rJ37Vt2LSt3YAGzFc4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=H8SbnfFK2St/3UpAZV6yjh1ul9wPjjKYRoJ2qSKVFyiXHqWJLvRsbRz+yf8UySkOTKz9HYEwVifwxQAh4QlsEOzp9hPABv/m8fm0/SMsEYgedrJgw0ldavW7N0bIKWBOWKBEGzQFhvsKwZw0E3CXQZPWm95je2pN4esdRvtuu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd81K1JT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713786385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T9E2I3ZgUstGU5oyWcD7lv3c7NkIABQRlMBFbsEuJkw=;
	b=bd81K1JTSXLfOLGJRDAvikFYM8xER1hAZYYUnXT2cSo5Yf8FwwOEb+znqjtSEhlMhrv4Uu
	u6AY+TJnArlc5QnqBXGT3jw+W7LgdoO9DV0q6mlMSypGMcYGudCPIjyzHAYgQlffxMVazl
	mi6VV4CJnhtc3orPpNt0W5nGQWk+JTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-EQB_OmFuMZW5G3orhDU1Jg-1; Mon, 22 Apr 2024 07:46:24 -0400
X-MC-Unique: EQB_OmFuMZW5G3orhDU1Jg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-345aa380e51so2770443f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713786383; x=1714391183;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9E2I3ZgUstGU5oyWcD7lv3c7NkIABQRlMBFbsEuJkw=;
        b=UWVETIA19xj8gR2thZzN0oVSltjnmpwtW4DQa+6Bsm+sQv2hkc9AQPh5oHElPWO0dV
         iOdOVxRblYGn7/6xI6OXS+m5qh2jsIH7/W6Qn+AdllEQFw0xeMOM/rN50EAY4xiOF104
         THwvemc1hlMHU4JLvxjkZqC3ArMUi6eveFGMoeW5bLGMoHDFKMobpMv8+9DJxM7BBj2d
         jo3qNzvQEEHVrr1vM4Q5Y/Gi5qj6ASN8tzYCPpDiB/MNaJw0u1YirBwSP/LOldxya0ui
         rFO12IiuKnPKJHp2TeioSXTxlBuWb1yM0b+9lNOVrq4Jymz8KRX5zSsdjXs5D8OZefZX
         JAGA==
X-Forwarded-Encrypted: i=1; AJvYcCUxPzBZnpXZof2t7Zwb3L0Fgqlze1ovEN/Ac4aboV90YbHhTZQwwovgujdSl4fC8UO9qXihTRpY0yFq1M54xnB5ouhk32+idHlDQ/nD
X-Gm-Message-State: AOJu0YyMHbILzLXVVYH6yDn9KSZOR2A1sthu3ZT8r9ixCGfO1T2rYogm
	x0bX7lpEFE2PglRvuuGF7LjeVTK8DXgOK9JymUKwO3OGdBb1joQzegWKiY6ML3wkLdgadNjOcdt
	b+R7Rd3D7vEk+FCWhAjOPjg4d7etN8lI1edkDid8HPRv5nCkP5XRSjWFuFFHjtQ==
X-Received: by 2002:a5d:4f82:0:b0:349:bd11:1bea with SMTP id d2-20020a5d4f82000000b00349bd111beamr5576952wru.11.1713786382734;
        Mon, 22 Apr 2024 04:46:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiSpCwqZ4FQsMj03pvDBJLAoVgJqGFNi95lVGd7c4KFN4kVCyYgI5htdvSri6YCGFo2xCTmg==
X-Received: by 2002:a5d:4f82:0:b0:349:bd11:1bea with SMTP id d2-20020a5d4f82000000b00349bd111beamr5576935wru.11.1713786382251;
        Mon, 22 Apr 2024 04:46:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id d13-20020adfa34d000000b0034b1a91be72sm2187163wrb.14.2024.04.22.04.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:46:21 -0700 (PDT)
Message-ID: <bbeb3704-e4a6-42fa-90e7-28de1e885249@redhat.com>
Date: Mon, 22 Apr 2024 13:46:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set
From: David Hildenbrand <david@redhat.com>
To: syzbot <syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com
References: <000000000000ca4df20616a0fe16@google.com>
 <71cf84d4-77d2-42d7-a649-b67497b171f6@redhat.com>
 <a4c4c508-0d04-428c-b674-ec6e8847ea9f@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a4c4c508-0d04-428c-b674-ec6e8847ea9f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 12:38, David Hildenbrand wrote:
> On 22.04.24 12:07, David Hildenbrand wrote:
>> On 21.04.24 22:16, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    4eab35893071 Add linux-next specific files for 20240417
>>> git tree:       linux-next
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1727a61b180000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=27920e47287645ff
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=d8426b591c36b21c750e
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156da22d180000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163dfec7180000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/9f7d6c097fb4/disk-4eab3589.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/287b16352982/vmlinux-4eab3589.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/23839c65c573/bzImage-4eab3589.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 5084 at mm/page_table_check.c:199 __page_table_check_pte mm/page_table_check.c:199 [inline]
>>> WARNING: CPU: 0 PID: 5084 at mm/page_table_check.c:199 __page_table_check_ptes_set+0x1db/0x420
>>
>> I think this is
>>
>> if (pte_present(pte) && pte_uffd_wp(pte))
>> 	WARN_ON_ONCE(pte_write(pte));
>>
>> mm/page_table_check.c:213
>>> Modules linked in:
>>> CPU: 0 PID: 5084 Comm: syz-executor382 Not tainted 6.9.0-rc4-next-20240417-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>>> RIP: 0010:__page_table_check_pte mm/page_table_check.c:199 [inline]
>>> RIP: 0010:__page_table_check_ptes_set+0x1db/0x420 mm/page_table_check.c:213
>>> Code: 48 8b 7c 24 40 48 c7 c6 80 19 46 8e e8 ee df 8e ff 41 83 fc 1d 74 18 41 83 fc 1a 75 1d e8 5d da 8e ff eb 10 e8 56 da 8e ff 90 <0f> 0b 90 eb 10 e8 4b da 8e ff 90 0f 0b 90 eb 05 e8 40 da 8e ff 48
>>> RSP: 0018:ffffc9000366f740 EFLAGS: 00010293
>>> RAX: ffffffff8207833a RBX: ffffc9000366f7c0 RCX: ffff888022af3c00
>>> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
>>> RBP: ffffc9000366f830 R08: ffffffff820782af R09: 1ffffd40000a6a10
>>> R10: dffffc0000000000 R11: fffff940000a6a11 R12: 0000000000000000
>>> R13: 0000000014d42c67 R14: 0000000000000001 R15: 0000000000000000
>>> FS:  0000555567f79380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000000000066c7e0 CR3: 0000000078cb0000 CR4: 00000000003506f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>     <TASK>
>>>     page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
>>>     set_ptes include/linux/pgtable.h:267 [inline]
>>>     __ptep_modify_prot_commit include/linux/pgtable.h:1269 [inline]
>>>     ptep_modify_prot_commit include/linux/pgtable.h:1302 [inline]
>>>     change_pte_range mm/mprotect.c:194 [inline]
>>>     change_pmd_range mm/mprotect.c:424 [inline]
>>>     change_pud_range mm/mprotect.c:457 [inline]
>>>     change_p4d_range mm/mprotect.c:480 [inline]
>>>     change_protection_range mm/mprotect.c:508 [inline]
>>>     change_protection+0x2770/0x3cc0 mm/mprotect.c:542
>>>     mprotect_fixup+0x740/0xa90 mm/mprotect.c:655
>>>     do_mprotect_pkey+0x90d/0xe00 mm/mprotect.c:820
>>>     __do_sys_mprotect mm/mprotect.c:841 [inline]
>>>     __se_sys_mprotect mm/mprotect.c:838 [inline]
>>>     __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:838
>>>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>     do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f45514bf429
>>> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007ffe52191598 EFLAGS: 00000246 ORIG_RAX: 000000000000000a
>>> RAX: ffffffffffffffda RBX: 00007ffe52191768 RCX: 00007f45514bf429
>>> RDX: 000000000000000f RSI: 0000000000004000 RDI: 0000000020ffc000
>>> RBP: 00007f4551532610 R08: 00007ffe52191768 R09: 00007ffe52191768
>>> R10: 00007ffe52191768 R11: 0000000000000246 R12: 0000000000000001
>>> R13: 00007ffe52191758 R14: 0000000000000001 R15: 0000000000000001
>>>     </TASK>
>>
>> Did we find a real issue that involves mprotect()?
>>
>> At least can_change_pte_writable() should always return "false" for
>> userfaultfd_pte_wp().
>>
>> Do we maybe have a uffd-wp PTE outside of a UFFD_WP VMA?
>>
>> Or was the PTE already writable and we only detect it now as we call
>> mprotect()? (missed to detect it earlier?)
> 
> Staring at the reproducer, we do
> 
> 
>     syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>             /*offset=*/0ul);
>     syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
>             /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>             /*offset=*/0ul);
> 
> -> Writable anonymous memmory
> 
>     syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>             /*offset=*/0ul);
>     intptr_t res = 0;
>     res = syscall(__NR_userfaultfd,
>                   /*flags=UFFD_USER_MODE_ONLY|O_NONBLOCK*/ 0x801ul);
>     if (res != -1)
>       r[0] = res;
>     *(uint64_t*)0x200004c0 = 0xaa;
>     *(uint64_t*)0x200004c8 = 0;
>     *(uint64_t*)0x200004d0 = 0;
>     syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc018aa3f, /*arg=*/0x200004c0ul);
> 
> -> _UFFDIO_API handshake?
> 
>     syscall(__NR_mprotect, /*addr=*/0x20ffc000ul, /*len=*/0x3000ul,
>             /*prot=PROT_SEM|PROT_EXEC*/ 0xcul);
> 
> -> Protect target range R/O. I assume: no page populated yet?
> -> 3 pages starting at 0x20ffc000ul;
> 
>     *(uint64_t*)0x20000180 = 0x20ffc000;
>     *(uint64_t*)0x20000188 = 0x3000;
>     *(uint64_t*)0x20000190 = 3;
>     *(uint64_t*)0x20000198 = 0;
>     syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc020aa00, /*arg=*/0x20000180ul);
> 
> -> _UFFDIO_REGISTER (aa00)
> -> _range = 3 pages starting at 0x20ffc000ul
> -> _mode = UFFDIO_REGISTER_MODE_WP | UFFDIO_REGISTER_MODE_MINOR
> 
>     *(uint64_t*)0x20000000 = 0x20ffd000;
>     *(uint64_t*)0x20000008 = 0x20ffb000;
>     *(uint64_t*)0x20000010 = 0x1000;
>     *(uint64_t*)0x20000018 = 3;
>     *(uint64_t*)0x20000020 = 0;
>     syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0xc028aa03, /*arg=*/0x20000000ul);
> 
> -> _UFFDIO_COPY (aa03)
> -> dst = 0x20ffd000
> -> src = 0x20ffb000
> -> len = 0x1000 (single page)
> -> mode = UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP
> 
> -> We are copying into the R/O range. src should be R/W and trigger a page fault
>      on access where we get a fresh page.
> 
>     *(uint16_t*)0x200000c0 = 1;
>     *(uint64_t*)0x200000c8 = 0x20000040;
>     *(uint16_t*)0x20000040 = 6;
>     *(uint8_t*)0x20000042 = 0;
>     *(uint8_t*)0x20000043 = 0;
>     *(uint32_t*)0x20000044 = 0x7fffffff;
>     res = syscall(__NR_seccomp, /*op=*/1ul, /*flags=*/0ul, /*arg=*/0x200000c0ul);
>     if (res != -1)
>       r[1] = res;
>     syscall(__NR_open_tree, /*dfd=*/-1, /*filename=*/0ul, /*flags=*/0ul);
> 
> -> No idea what happens here and if it is relevant. If __NR_seccomp failed, we would
>      no set r[1].
> 
>     syscall(__NR_close_range, /*fd=*/r[1], /*max_fd=*/-1, /*flags=*/0ul);
> 
> -> Is that closing uffd as well, especially if __NR_seccomp failed?
> 
>     syscall(__NR_mprotect, /*addr=*/0x20ffc000ul, /*len=*/0x4000ul,
>             /*prot=PROT_SEM|PROT_WRITE|PROT_READ|PROT_EXEC*/ 0xful);
> 
> -> Restore write permissions. This seems to fire the uffd-wp page table check I assume.

I think the issue is that userfaultfd_release() will clear the VMA UFFD_WP flag,
but it will not clear PTE uffd-wp bits. So we have leftover PTE uffd-wp bits at
the time we wr-unprotect.

I thought we removed that lazy handling, but looks like we didn't consider the
"close uffd" case in:

commit f369b07c861435bd812a9d14493f71b34132ed6f
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Aug 11 16:13:40 2022 -0400

     mm/uffd: reset write protection when unregister with wp-mode


close should behave just like unregister.


Simplified+readable reproducer:

#define _GNU_SOURCE

#include <stdint.h>
#include <fcntl.h>
#include <sys/syscall.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <linux/userfaultfd.h>
#include <unistd.h>

int main(void)
{
         void *src = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
         void *dst = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
         struct uffdio_register uffdio_register = {};
         struct uffdio_copy uffdio_copy = {};
         struct uffdio_api uffdio_api = {};
         int uffd;

         uffd = syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
         uffdio_api.api = UFFD_API;
         ioctl(uffd, UFFDIO_API, &uffdio_api);

         uffdio_register.range.start = (uintptr_t)dst;
         uffdio_register.range.len = 4096;
         uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
         ioctl(uffd, UFFDIO_REGISTER, &uffdio_register);

         uffdio_copy.dst = (uintptr_t)dst;
         uffdio_copy.src = (uintptr_t)src;
         uffdio_copy.len = 4096;
         uffdio_copy.mode = UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP;
         ioctl(uffd, UFFDIO_COPY, &uffdio_copy);

         close(uffd);

         mprotect(dst, 4096, PROT_READ|PROT_WRITE);
         return 0;
}


-- 
Cheers,

David / dhildenb


