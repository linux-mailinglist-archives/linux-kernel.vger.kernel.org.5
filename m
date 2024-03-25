Return-Path: <linux-kernel+bounces-116808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9F88A422
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D7E1F3DAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFA18AC6C;
	Mon, 25 Mar 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kg+jWj3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F074182F12
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361793; cv=none; b=jSX4S71zVbbmO6CsJHFeFKMn9GjYMo6n6pochB8v0cqrzwH+7P0LArnkNe+xEDY4pd3eoZysjm5AdU8m61qx25KWVETt++Q1DBAgqd4QCU6t+AZV/Fv0Pf07joq/U+MS5IZ1NPc2q4tjJ9SY50LgqmL8sSxhH85NwbTQijrvNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361793; c=relaxed/simple;
	bh=DgYnEWpTQ108hV9DM8tc4WEgzCuOwVmBEZv5o/A9edo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FwvXSG1BfY0WmEtkgM3cdCZFqlXMlUNgXMl1em2sm19+otC0pnT1JdSnsDs7+Pxrr1L4VYV/8DAzTNDLJdgLGtrbsZRbjh7HScveKoYZ3PV6Xv8N3S9i/Fe2gfDWcTkDeq8jGl+XGVWPgxWtLIfF69rbsnsQ2ZaPfjWI80I9/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kg+jWj3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711361790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6ZKgX6D7i5Cn/qjXqXdvqP6oFuLWD4CuZbhd6/PXjIM=;
	b=Kg+jWj3vma0IfGXjLDOHUZyYHBV0a7XLcc8CnjnnOSuXx0awgTPedgT8K35JFmVd/JsyMU
	TQYB8zDnC+tvEe896pTCHiipqP/TwVOfci60YfHUa7ruPa61OTVfKoCFYK+AElbwOQt2v6
	qcxhrqiHSxaI5JDlmtc0NJI/Y2MvGak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-tT3Pui3vPgOSvjwDQGrJWw-1; Mon, 25 Mar 2024 06:16:28 -0400
X-MC-Unique: tT3Pui3vPgOSvjwDQGrJWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed26afd99so2317437f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361787; x=1711966587;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :from:references:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZKgX6D7i5Cn/qjXqXdvqP6oFuLWD4CuZbhd6/PXjIM=;
        b=NnTL6+edR7XYgL5iHJ00+7nSeaOqtir7/0eSYQaMux41s5ZzFnIzSSJKlg3hlQelzS
         gL58VJSKTMYqlNg90AuFXBuwuHz+ZfOfnSSXZ52lRaWfQo7rqXyQKSTxgZ4fr1dfDfqi
         gahByxDpIGSeIOCUDV5GQOKmFRvr4KaFli2QRuIeYi1bNuz7Ao28qjjk8DtEwYc3RWTc
         lhfT7QAMzR686Ef4Ofxeiv4N8NRGR2ThE/4TgDM/AiNRtk2/cbW8yX654gmcaQBbIGmN
         y1neVO8o91i4R7dQut/9HSp1NDYY9YDMk+nBnlWIWVtISj7cBd1Adcpz65WAQEJF/STN
         M0dA==
X-Forwarded-Encrypted: i=1; AJvYcCVfv4s7K+7TGUlqRd/VXVNaFHlkLXrMZYBPVA7HTDu8GULXeK0sgDWSRmRdiyv1ekbqBGtC0vfTmaMrwWPYHy/GBwOESN1gm3F6vkYZ
X-Gm-Message-State: AOJu0YzTBC6viMp1oh6ewRZtk9UugL41eI/M04WmOKbBoHAxs64fMgA1
	QaJ76/c9LSvm5hLTkMU4f4reIlk44j/a5Y4JPebreGH6n+a9/LZkmglXXhaSBjoJMjPuLI0yxfK
	yDtKlKdcc2mT3fTpqgGRC3jhiycewmtWCemCJYqirxopcQGRuBWENN8iO8vAETg==
X-Received: by 2002:a05:6000:1d8f:b0:341:cf6f:e044 with SMTP id bk15-20020a0560001d8f00b00341cf6fe044mr1274393wrb.62.1711361787342;
        Mon, 25 Mar 2024 03:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh15bPGETSIl5LrFzvzkyv7YH6WsaTtImWhdG0TtEPW5a/fNlzgKKCZRU7iTUyjIfDzl7+xw==
X-Received: by 2002:a05:6000:1d8f:b0:341:cf6f:e044 with SMTP id bk15-20020a0560001d8f00b00341cf6fe044mr1274373wrb.62.1711361786892;
        Mon, 25 Mar 2024 03:16:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:b400:6a82:1eac:2b5:8fca? (p200300cbc738b4006a821eac02b58fca.dip0.t-ipconnect.de. [2003:cb:c738:b400:6a82:1eac:2b5:8fca])
        by smtp.gmail.com with ESMTPSA id dw1-20020a0560000dc100b0033e3cb02cefsm9160367wrb.86.2024.03.25.03.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 03:16:26 -0700 (PDT)
Message-ID: <fd667164-5a8d-44ca-8d22-9ff5ccd8c884@redhat.com>
Date: Mon, 25 Mar 2024 11:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in PageHuge
Content-Language: en-US
To: syzbot <syzbot+adb570fc6161d33edb01@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
References: <00000000000026e662061475a373@google.com>
From: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <00000000000026e662061475a373@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.03.24 06:42, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=155105be180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
> dashboard link: https://syzkaller.appspot.com/bug?extid=adb570fc6161d33edb01
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+adb570fc6161d33edb01@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:314!
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 12282 Comm: syz-executor.2 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : folio_flags include/linux/page-flags.h:314 [inline]
> pc : folio_test_hugetlb include/linux/page-flags.h:849 [inline]
> pc : PageHuge+0x1f8/0x1fc mm/hugetlb.c:2173
> lr : folio_flags include/linux/page-flags.h:314 [inline]
> lr : folio_test_hugetlb include/linux/page-flags.h:849 [inline]
> lr : PageHuge+0x1f8/0x1fc mm/hugetlb.c:2173
> sp : ffff800097ca6d00
> x29: ffff800097ca6d00 x28: dfff800000000000 x27: fffffdffc318ac00
> x26: 00000000000000b0 x25: fffffdffc3188000 x24: 05ffc00000000840
> x23: 1fffffbff8631580 x22: 1fffffbff8631581 x21: dfff800000000000
> x20: 05ffc00000000000 x19: fffffdffc318ac00 x18: 1fffe000367fff96
> x17: ffff80008ec9d000 x16: ffff80008ad6b09c x15: 0000000000000001
> x14: 1ffff00012f94ce4 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000040000 x10: 000000000003ffff x9 : ffff80009a5da000
> x8 : 0000000000040000 x7 : ffff800080297c0c x6 : 0000000000000000
> x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800082f248d0
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000166
> Call trace:
>   folio_flags include/linux/page-flags.h:314 [inline]
>   folio_test_hugetlb include/linux/page-flags.h:849 [inline]
>   PageHuge+0x1f8/0x1fc mm/hugetlb.c:2173
>   isolate_migratepages_block+0x7d8/0x2f9c mm/compaction.c:950
>   isolate_migratepages mm/compaction.c:2074 [inline]
>   compact_zone+0x26a8/0x4120 mm/compaction.c:2530
>   compact_node+0x234/0x3c0 mm/compaction.c:2851
>   compact_nodes mm/compaction.c:2864 [inline]
>   sysctl_compaction_handler+0x110/0x1d4 mm/compaction.c:2910
>   proc_sys_call_handler+0x4cc/0x7cc fs/proc/proc_sysctl.c:595
>   proc_sys_write+0x2c/0x3c fs/proc/proc_sysctl.c:621
>   call_write_iter include/linux/fs.h:2087 [inline]
>   iter_file_splice_write+0x894/0xfc0 fs/splice.c:743
>   do_splice_from fs/splice.c:941 [inline]
>   direct_splice_actor+0xec/0x1d8 fs/splice.c:1164
>   splice_direct_to_actor+0x438/0xa0c fs/splice.c:1108
>   do_splice_direct_actor fs/splice.c:1207 [inline]
>   do_splice_direct+0x1e4/0x304 fs/splice.c:1233
>   do_sendfile+0x460/0xb3c fs/read_write.c:1295
>   __do_sys_sendfile64 fs/read_write.c:1356 [inline]
>   __se_sys_sendfile64 fs/read_write.c:1348 [inline]
>   __arm64_sys_sendfile64+0x23c/0x3b4 fs/read_write.c:1348
>   __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
>   el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
>   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
>   el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>   el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> Code: f0052f01 912c0021 aa1303e0 97fbce80 (d4210000)
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: mm: turn folio_test_hugetlb into a PageType

-- 
Cheers,

David / dhildenb


