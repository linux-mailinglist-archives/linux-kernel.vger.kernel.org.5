Return-Path: <linux-kernel+bounces-157993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460458B19E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D21C21BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DA37700;
	Thu, 25 Apr 2024 04:33:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10212B83
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019586; cv=none; b=TGZGBlfMQ/eIzubN/I5ktRLhovEcvZkgxIVe/5Nlne54crzzXNcvGr/8voZIDRdLbLMexyOxLHodi1jmchynVxXYNMNvGdBiKNPZ6/C3ZLzAZxbB3caNm5aTG/QBDITm6NminFgNnWLSsyFp3L64TkezjDiULd84EGESJGeRNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019586; c=relaxed/simple;
	bh=ebgcDUdRQFEg1iI9qOtRZBjUUmvQXBCDjG7hOhqrBJ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DQ+sIBlquW3Uht7acPXTb4uLyN8LGlkyuiV/oTbzM2TV2K4Pa2slF03gNa9sZ/b7F/YZq2nqbUG/BoPmJ7eHrZcd7IB9UiReSU+o4Od5OuksQr+xSIr55a39S8G+HrHnYD/A4IwoSlUh29R6mrfgbWiKYVCe6fMrEOYhQ9Y0eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da3d17a35cso63100539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714019584; x=1714624384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWxAb163aD1htFBZsscrvwOMWbM9Ezz+k+ecJAeOLro=;
        b=rm/4EJEwNZEv93wNBXPNCV1fClQu0nnpnENHsH165jT/8Q8dnbewziovStLJsNFrGD
         Fa/+UpOt4B91gEKRJYpj5IkPNsU4igQ+hzH+AErgWxErpBpJnFQRf0p9/bKFo/m4U75l
         MzIfcka+1x+qhbt9T0oVoWWOJnj11ZMGe4iOA5mAWZ85HBp2uDzXMuEFM1wSF2bglswb
         go16vySxYnOdxefu/nFjNS54xQegVJstOEYR0jbFAwjaqVYajX3+93c8I8ay6cu13Aql
         qKd5yDtCitlLtO21dNt8zCf0tjx8oMN9pRji6kUakVd9Tui1nAcQufAjbM9nUxBFc/Gn
         Fb/g==
X-Forwarded-Encrypted: i=1; AJvYcCUexeUxFOZUIESEEsG+/f3cRC0lOLHY5Jer+rNBy8lGfOBXEPNrdtO66YjtPHiRwbVFYgh1pV8xXHnyl94wFMiv6xGacd8Q2BEleFWV
X-Gm-Message-State: AOJu0YwbRm6QZ/H1zhpaoQ99DKppzWZTHUFvDY0T+HXb3p3XTtOwtENs
	msWXQM2ZHfyffM+xMzuSiATkmuiO2eaq05fV9XwUSdGmDefaYnWNrtHyiw0oUG5ii1ImTrTa3i4
	bhISN/lCRzV1wti6M2Z537ED48KH7KcCoxDMHSjx314t55/4D82ej9n4=
X-Google-Smtp-Source: AGHT+IHR3hRkG2n5PlDeTmSvallrZyB2WD2GHiexL+yazfTqP4uaNd8cHG+26yPOd8RgN7/t7J59MVFDe3mt/4yFRJm1prqsPo/5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841a:b0:485:1cea:feab with SMTP id
 iq26-20020a056638841a00b004851ceafeabmr350533jab.5.1714019583974; Wed, 24 Apr
 2024 21:33:03 -0700 (PDT)
Date: Wed, 24 Apr 2024 21:33:03 -0700
In-Reply-To: <20240425031558.6181-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070eabc0616e4486b@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
From: syzbot <syzbot+241c815bda521982cb49@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in diFree

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:886:2
index 524288 is out of range for type 'struct mutex[128]'
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 0 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 panic+0x349/0x860 kernel/panic.c:348
 check_panic_on_warn+0x86/0xb0 kernel/panic.c:241
 ubsan_epilogue lib/ubsan.c:236 [inline]
 __ubsan_handle_out_of_bounds+0x141/0x150 lib/ubsan.c:429
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         e88c4cfc Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
console output: https://syzkaller.appspot.com/x/log.txt?x=142ec887180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=241c815bda521982cb49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130ccd27180000


