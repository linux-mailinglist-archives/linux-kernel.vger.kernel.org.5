Return-Path: <linux-kernel+bounces-7910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDC981AEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943DD2875E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED6BE62;
	Thu, 21 Dec 2023 06:58:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEBBA33
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35fcf7a999aso2473075ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703141909; x=1703746709;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F33JpJCGkVMAPFCqhQGDy7W529WxuPQzQDW2IWFcVg0=;
        b=Bmu6GKRBxr7op6r+aeAG5kFO1KANZDHHQvxTUzfrCFDFK/llYpftuaAokNrJiMTX9Z
         /w2rvAD8I/XCnoCZMfpa5uKJZx3R/6YIzkdrGsMkJ8B9iNi8re5I4nN+IsMC6ANSy7Tg
         zRHptPf8LLW1Ria+qHTslvn04Acl/0JJleCGYu/tjNbEX6mrc1E8eNRRJbiI8BRgM4VU
         r9rWfyJE3O2oDe/68Hb4nCxqn6wzqX6MTPyG1eaaWzB3KF+c+2L3oHZusuc31lW6FZpu
         sQ/qeF+6RYr4cMqxVJqeo0NIwkMmhGUBSBnRMwPNGZQ/T1E7p24XpVWzHiPM1y7sy4dm
         nyYw==
X-Gm-Message-State: AOJu0YybmXJtG5rvfVtxK1w/kFGHDPbUxxEPDaV1IcPKUzvpsUOlWTdd
	LQ362xGMf/iU6X10zKnZN1g0biss2uCfpAMf9WarLfbUYIg=
X-Google-Smtp-Source: AGHT+IHSMFNOTN8S2FDbHXvNpdlVFEYdfgqOGU/DJbrFFNn9BXOx0k0lPo7HTNp/r10yOmtp5jquT79bf2jCvcAQKnk=
X-Received: by 2002:a05:6e02:1caa:b0:35d:59b3:2f86 with SMTP id
 x10-20020a056e021caa00b0035d59b32f86mr190327ill.27.1703141908722; Wed, 20 Dec
 2023 22:58:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Thu, 21 Dec 2023 07:58:02 +0100
Message-ID: <CAKAoaQ=U9iMbZ+TpoJ_Tim+cA653D291F1icMW_txdA8ysrv8w@mail.gmail.com>
Subject: nsfd goes BOOOM with allocation failure in |nfsd_shutdown_threads()| ...
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

----

Is this a known bug - nfsd goes "boooom" in a regular basis, once or
twice a week (kernel is stock Debian Linux "5.10.0-22-rt-amd64", NFSv4
client is both Debian Linux NFSv4 /home on the same machine and
Windows NFSv4 client (git
https://github.com/kofemann/ms-nfs41-client/commit/0be33d4eceeb7be668d6252f06c79394100e98e0)
compiling Cygwin gcc in two instances in a Win10 VMware VM):
---- snip ----
Dec 21 03:47:22 derfwpc5131 kernel: nfsd: page allocation failure:
order:4, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
nodemask=(null),cpuset=/,mems_allowed=0
Dec 21 03:47:22 derfwpc5131 kernel: CPU: 4 PID: 938 Comm: nfsd
Tainted: G           OE     5.10.0-22-rt-amd64 #1 Debian 5.10.178-3
Dec 21 03:47:22 derfwpc5131 kernel: Hardware name: FUJITSU ESPRIMO
P500/D2991-A1, BIOS V4.6.4.0 R1.9.0 for D2991-A1x 11/22/2011
Dec 21 03:47:22 derfwpc5131 kernel: Call Trace:
Dec 21 03:47:22 derfwpc5131 kernel:  dump_stack+0x6b/0x83
Dec 21 03:47:22 derfwpc5131 kernel:  warn_alloc+0x138/0x160
Dec 21 03:47:22 derfwpc5131 kernel:  ? __alloc_pages_direct_compact+0x13c/0x160
Dec 21 03:47:22 derfwpc5131 kernel:
__alloc_pages_slowpath.constprop.0+0xd2a/0xd60
Dec 21 03:47:22 derfwpc5131 kernel:  __alloc_pages_nodemask+0x330/0x360
Dec 21 03:47:22 derfwpc5131 kernel:  kmalloc_order+0x28/0x100
Dec 21 03:47:22 derfwpc5131 kernel:  kmalloc_order_trace+0x19/0xc0
Dec 21 03:47:22 derfwpc5131 kernel:
nfs4svc_decode_compoundargs+0x1c4/0x4e0 [nfsd]
Dec 21 03:47:22 derfwpc5131 kernel:  nfsd_dispatch+0x74/0x190 [nfsd]
Dec 21 03:47:22 derfwpc5131 kernel:  svc_process_common+0x4c4/0x760 [sunrpc]
Dec 21 03:47:22 derfwpc5131 kernel:  ? nfsd_svc+0x330/0x330 [nfsd]
Dec 21 03:47:22 derfwpc5131 kernel:  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
Dec 21 03:47:22 derfwpc5131 kernel:  svc_process+0xb7/0xf0 [sunrpc]
Dec 21 03:47:22 derfwpc5131 kernel:  nfsd+0xed/0x150 [nfsd]
Dec 21 03:47:22 derfwpc5131 kernel:  kthread+0x184/0x1a0
Dec 21 03:47:22 derfwpc5131 kernel:  ? __kthread_parkme+0xa0/0xa0
Dec 21 03:47:22 derfwpc5131 kernel:  ret_from_fork+0x1f/0x30
Dec 21 03:47:22 derfwpc5131 kernel: Mem-Info:
Dec 21 03:47:22 derfwpc5131 kernel: active_anon:877124
inactive_anon:1712597 isolated_anon:0
                                     active_file:2886463
inactive_file:2349094 isolated_file:0
                                     unevictable:5345 dirty:41979 writeback:0
                                     slab_reclaimable:129086
slab_unreclaimable:62421
                                     mapped:2173650 shmem:2222800
pagetables:11932 bounce:0
                                     free:78612 free_pcp:165 free_cma:0
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 active_anon:3508496kB
inactive_anon:6850388kB active_file:11545852kB inactive_file:9396376kB
unevictable:21380kB isolated(anon):0kB isolated(file):0kB
mapped:8694600kB dirty:167916kB writeback:0kB shmem:8891200kB
writeback_tmp:0kB kernel_stack:14240kB all_unreclaimable? no
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 DMA free:11264kB min:8kB
low:20kB high:32kB reserved_highatomic:0KB active_anon:0kB
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB
writepending:0kB present:15984kB managed:15360kB mlocked:0kB
pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
Dec 21 03:47:22 derfwpc5131 kernel: lowmem_reserve[]: 0 2850 31933 31933 31933
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 DMA32 free:118320kB
min:2040kB low:4956kB high:7872kB reserved_highatomic:0KB
active_anon:54420kB inactive_anon:128020kB active_file:848044kB
inactive_file:1680696kB unevictable:0kB writepending:224kB
present:3033892kB managed:2968356kB mlocked:0kB pagetables:108kB
bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
Dec 21 03:47:22 derfwpc5131 kernel: lowmem_reserve[]: 0 0 29083 29083 29083
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 Normal free:184864kB
min:20824kB low:50604kB high:80384kB reserved_highatomic:2048KB
active_anon:3454076kB inactive_anon:6722368kB active_file:10697808kB
inactive_file:7715632kB unevictable:21380kB writepending:167692kB
present:30406656kB managed:29788648kB mlocked:64kB pagetables:47620kB
bounce:0kB free_pcp:664kB local_pcp:344kB free_cma:0kB
Dec 21 03:47:22 derfwpc5131 kernel: lowmem_reserve[]: 0 0 0 0 0
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 DMA: 0*4kB 0*8kB 0*16kB
0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M)
2*4096kB (M) = 11264kB
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 DMA32: 2816*4kB (UME)
1184*8kB (UME) 135*16kB (UME) 197*32kB (UME) 24*64kB (UME) 403*128kB
(UM) 139*256kB (M) 4*512kB (UM) 0*1024kB 0*2048kB 0*4096kB = 119952kB
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 Normal: 20111*4kB (UME)
7934*8kB (UME) 2449*16kB (UMEH) 78*32kB (UEH) 7*64kB (H) 5*128kB (H)
2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 187196kB
Dec 21 03:47:22 derfwpc5131 kernel: Node 0 hugepages_total=0
hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Dec 21 03:47:22 derfwpc5131 kernel: 7487517 total pagecache pages
Dec 21 03:47:22 derfwpc5131 kernel: 29084 pages in swap cache
Dec 21 03:47:22 derfwpc5131 kernel: Swap cache stats: add 510992,
delete 481907, find 455115/506520
Dec 21 03:47:22 derfwpc5131 kernel: Free swap  = 32781168kB
Dec 21 03:47:22 derfwpc5131 kernel: Total swap = 33554428kB
Dec 21 03:47:22 derfwpc5131 kernel: 8364133 pages RAM
Dec 21 03:47:22 derfwpc5131 kernel: 0 pages HighMem/MovableOnly
Dec 21 03:47:22 derfwpc5131 kernel: 171042 pages reserved
Dec 21 03:47:22 derfwpc5131 kernel: 0 pages hwpoisoned
---- snip ----

The Win10 NFSv4 client at that point lost the NFSv4 session,
recovered, and the gcc build continued without problems.

Is the |nfsd_shutdown_threads()| in the stacktrace "normal", or is
nfsd really shutting down at this moment ?

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

