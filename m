Return-Path: <linux-kernel+bounces-81535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D66867734
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88EB1F27C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A71129A8F;
	Mon, 26 Feb 2024 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fasx7DXb"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F21BC43
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955385; cv=none; b=ucezz7I3YBEOf81qSFYRLCz520w8El+DqevBRyDMKIesI6i1MSeP6ePET/pzXZKmaCMhvV4tDqB40xW3iSPEJUoUHCkiBBwZ2UwU2XmYH2usW6wrohfAMJ+CfuzVQpJqQ9jy290074SOZ0vXfUTgSFfFftMvQeLOdq/Fc3jAb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955385; c=relaxed/simple;
	bh=GOUQ9EgukG6RRtnE1Su278zy8DeEqSUNKqbnNEQsCzk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b1JQX76PMvHY0+8zRXoNpP9fZ8cfMaGQmmc8mCuML274N0vhrg+OfOMlWPA/eX0KHWmteMlv6oSbKFpJ6ZL5YVNi1xKlMcVYo1EMZcS4yRH9ygxPN4mdxgg6W6Rix5gIO0+ssFEVMXONnRy73aIw2Ow5ATs+MHgJQcyNhOXn6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fasx7DXb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso4178011a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708955381; x=1709560181; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JHO/J+vf2DDcCI4GqVxCtzd8SIKAxrbqAtBS777veKY=;
        b=fasx7DXbdWy8gNpO8onf1gq/18DvbDReEWDRDdqVeycgvR9yXZp/s8TkmToJa6BhVK
         l+JcNv8V8VG3xGCWPzp4lNoa6Bv5c3d5uQthHe4Ku91IUe3KDG6fp9cupNZNS61XuTaI
         q5xs08nSh+jNBHEJTvyPN98FZY2udN4FkHtZ4Xxh47HIVg0l+1so9vCcqATiF/m/Zu46
         LoAPA2zuh0HPU8BRIRBdkbmnjGjqxrjF22Sv5YgJ0NPGlupcB0nCb191MGp4ESDbqWl0
         HoIBraPq24vXOxQnb6OMqDLHVHcXfTWLt61fTuDWiuSTpyKr0kPPdCc93sORiPHMBvT/
         Gykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955381; x=1709560181;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHO/J+vf2DDcCI4GqVxCtzd8SIKAxrbqAtBS777veKY=;
        b=I2XqzQKV1TVqHwtvlKNUH8sJDe3xF0ThUjp8Rlc9BAjb4CKav4oGBt/qyvBIHKG1Rw
         q50lF8TnEmoeLwFpljL/EXkqETLlAC7dJ/01FH9CR4UnGDVxGUbthgOk3JYUwiK/2gL/
         cxzlnzXJSTJAHHCdGd0qU7eA9PriwzfljqmoaMh8JfLrtRXFAFbMRzNfCrbNRCzT93GX
         6hwt4Rw0XFuFhczHMfO4gYJjAKB7qqYfjuTFJrWitqG64RtL8B02R9J1QgqmNH2G7/Pz
         kAfiADU1dKZuHyEX3+kfmYBicaCR1SgA234KJCZj0S3TswdQjBfPWvGQFIse6H/cWK8o
         9K5A==
X-Forwarded-Encrypted: i=1; AJvYcCW64opLSbf91OtoLLA/PbDOkbnMM/BZ1firTHZwkY2KLmUVVB5n5YBaeJQIjc83rFwzfJjQzVp4s2SoCqcMHHOQ+dWfSHO2IgNJtB1i
X-Gm-Message-State: AOJu0YzH9zfg7As7X2HqwKZFnNPHFj26tvdvy8R0fSIejOy50yfc1y+2
	kBQOKy+kW+lhvwPnMQSlweSCgdeeHYpiOYMwOPhQ2EUXa8YIbiBCnO7Kg9KwZG0zoi+MR/oUclc
	l55JiAKWAexIlnIAfaf3byCXGjE5Cxmzv2UdDEojXTZGk+lEgsTc=
X-Google-Smtp-Source: AGHT+IHbFR3DTeHeRXHbuoR6pQDWl3aEEaHxb90ISrA6C0BnPpw2vDhqvaggbLWZO/1OmyvIWSu+EMwFszJEzlvmHdQ=
X-Received: by 2002:aa7:d385:0:b0:565:9b29:ad3e with SMTP id
 x5-20020aa7d385000000b005659b29ad3emr4302106edq.6.1708955380782; Mon, 26 Feb
 2024 05:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 26 Feb 2024 14:49:29 +0100
Message-ID: <CAMGffE=jkiaK5c9xcm4WJxxz8joYJwkCHWCXkbj2EMf3zRQ_Ug@mail.gmail.com>
Subject: [BUG] Null pointer deref from fib6_walk_continue+0x6d (kernel 5.15.137)
To: netdev <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Folks on the list,

We hit following a null pointer deref from fib6_walk_continue+0x6d
from kernel 5.15.137 during test:
[277691.646765] BUG: kernel NULL pointer dereference, address: 0000000000000008
[277691.646877] #PF: supervisor read access in kernel mode
[277691.646971] #PF: error_code(0x0000) - not-present page
[277691.647067] PGD 0 P4D 0
[277691.647158] Oops: 0000 [#1] SMP
[277691.647249] CPU: 14 PID: 5186 Comm: ovs-vswitchd Kdump: loaded
Tainted: G           O      5.15.137-pserv
er #5.15.137-7~deb11
[277691.647376] Hardware name: Supermicro SBI-7228R-T2F2/B10DRT-IBF2,
BIOS 2.0b 07/11/2017
[277691.647493] RIP: 0010:fib6_walk_continue+0x6d/0x170
[277691.647592] Code: 43 28 00 00 00 00 48 85 d2 75 d2 31 c0 5b c3 cc
cc cc cc 83 f8 03 0f 84 a4 00 00 00 83 f8 04 75 b7 48 39 53 10 74 e4
48 8b 02 <48> 8b 48 08 48 8b 70 10 48 89 43 18 48 39 50 18 0f 84 a7 00
00 00
[277691.647751] RSP: 0018:ffffad1bce1bfae0 EFLAGS: 00010283
[277691.647846] RAX: 0000000000000000 RBX: ffff8c5f35ec8840 RCX:
0000000000000000
[277691.647962] RDX: ffff8c5ec748e398 RSI: ffffad1bce1bfb38 RDI:
ffff8c5ec956f400
[277691.648077] RBP: ffff8c3f49272368 R08: 0000000000000000 R09:
ffff8c5f19fa3d29
[277691.648192] R10: 0000000000000002 R11: ffff8c7e3f6348e0 R12:
0000000000000003
[277691.648308] R13: ffffffffa5ad9b40 R14: ffff8c41751b3314 R15:
ffff8c45c78fa100
[277691.648424] FS:  00007f6c6d73ca40(0000) GS:ffff8c7e3f600000(0000)
knlGS:0000000000000000
[277691.648542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[277691.648637] CR2: 0000000000000008 CR3: 00000020f42b7004 CR4:
00000000003726e0
[277691.648752] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[277691.648868] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[277691.648983] Call Trace:
[277691.649074]  <TASK>
[277691.649163]  ? __die_body.cold+0x1a/0x1f
[277691.649258]  ? page_fault_oops+0x135/0x2a0
[277691.649353]  ? __nla_put+0xc/0x20
[277691.649446]  ? nla_put+0x28/0x40
[277691.649536]  ? rt6_fill_node+0x2fc/0x880
[277691.649628]  ? exc_page_fault+0x5d/0x110
[277691.649723]  ? asm_exc_page_fault+0x22/0x30
[277691.649817]  ? fib6_walk_continue+0x6d/0x170
[277691.649910]  fib6_dump_table.isra.0+0x67/0x1d0
[277691.650004]  inet6_dump_fib+0xea/0x340
[277691.650096]  rtnl_dump_all+0xd3/0x110
[277691.650189]  netlink_dump+0x193/0x3f0
[277691.650282]  netlink_recvmsg+0x21c/0x3e0
[277691.650375]  ____sys_recvmsg+0x87/0x180
[277691.650470]  ? __check_object_size+0x4a/0x160
[277691.650565]  ? _copy_from_user+0x2b/0x70
[277691.650658]  ? iovec_from_user+0xf5/0x1a0
[277691.650750]  ___sys_recvmsg+0x82/0x110
[277691.650843]  ? slab_free_freelist_hook.constprop.0+0xf4/0x1a0
[277691.650940]  ? __dentry_kill+0x127/0x160
[277691.651033]  ? __fput+0xf9/0x250
[277691.651125]  ? __fget_files+0x79/0xb0
[277691.651218]  __sys_recvmsg+0x56/0xa0

While checking the kdump, I noticed it failed in following lines:

2122                 case FWS_U:
2123                         if (fn == w->root)
2124                                 return 0;
2125                         pn =
rcu_dereference_protected(fn->parent, 1);
2126                         left =
rcu_dereference_protected(pn->left, 1); ---> this line crashed, seems
pn is NULL, which lead to NULL pointer deref.
2127                         right = rcu_dereference_protected(pn->right, 1);

crash> struct fib6_walker ffff8c5f35ec8840
struct fib6_walker {
  lh = {
    next = 0xffffffffa5ada268 <init_net+1832>,
    prev = 0xffffffffa5ada268 <init_net+1832>
  },
  root = 0xffff8c41751b3318,
  node = 0xffff8c5ec748e398,
  leaf = 0x0,
  state = FWS_U,
  skip = 0,
  count = 2057,
  skip_in_node = 0,
  func = 0xffffffffa3839010 <fib6_dump_node>,
  args = 0xffffad1bce1bfb38
}
crash> struct fib6_node 0xffff8c5ec748e398
struct fib6_node {
  parent = 0x0,
  left = 0xffff8c5f340aea80,
  right = 0xffff8c43895ac500,
  subtree = 0x0,
  leaf = 0xffff8c5ec956f400,
  fn_bit = 0,
  fn_flags = 7,
  fn_sernum = 64134,
  rr_ptr = 0x0,
  rcu = {
    next = 0x0,
    func = 0x0
  }

So the parent pointer is NULL, and while access left, null pointer
deref crashed the system.
I checked in git history, and can't find a fix for this case, does
this ring any bell? If you need any info from the crash dump, I'm
happy to share.

Thx!
Jinpu Wang @ IONOS

