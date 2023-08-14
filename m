Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028AE77B978
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjHNNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjHNNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:12:35 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F5E6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:12:34 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68790b952bbso4833155b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692018754; x=1692623554;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkUsQ1wrjvx9w9pGAMLpP0B4qOOaUFlPw9+26kywtpU=;
        b=ULd+u2WCCxTUlAG9KNiGJThQ0Cl/76CSbykkSKauOrxauAeJh3++ggyPMd4djZRVoQ
         WaIe/5+xkYWsW1pRCAm01eYJvvBtR7s9/BDXOcsUvcMsuvZPegFK5vYqeO33TlyAuzYY
         l+PLMkdFFvy5z1VEybjflQmbUe3/wStpvARppimiPigwLsCTU72hFWrWLzSEPM4wtnDP
         Ur+hC1zh45brqC5YIiJK0+fM0CI9nlA8gfwcTdhLHuNP2pAn+CEOTZj2BhJno0rUwsOs
         b/4xzPzmZWW3Jt3RgE2Gr7xA4e/jJSvn7EzAjDLmkdvsZYQ4t3a8T9o0DZKBKDthoUpk
         Youw==
X-Gm-Message-State: AOJu0Yx1A+4UxLmy6MiCwi4XTL7N/e55SziRKzVK4ygU3hosjwRFJCh9
        siP7mfivx4IrFz0Ix8rT0jXKMPz8gCtEBrduWGX5TSpcW9M2
X-Google-Smtp-Source: AGHT+IHzL2RazM92wVEoVMl//dQglkomTDOyKJBBJbRtQJItDXTcwMv7/H4PJ0Ai13M+1wyKNN48sJ8q3IRSuJbMMgIydjW36kOe
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d13:b0:682:24c1:2951 with SMTP id
 fa19-20020a056a002d1300b0068224c12951mr4397426pfb.0.1692018753818; Mon, 14
 Aug 2023 06:12:33 -0700 (PDT)
Date:   Mon, 14 Aug 2023 06:12:33 -0700
In-Reply-To: <20230814125546.1492-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6570d0602e1d030@google.com>
Subject: Re: [syzbot] [dri?] [reiserfs?] WARNING: bad unlock balance in vkms_vblank_simulate
From:   syzbot <syzbot+5671b8bcd5178fe56c23@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in corrupted

BUG: unable to handle page fault for address: 000000000000ff01
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 68064067 P4D 68064067 PUD 6806d067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5037 Comm: kworker/1:3 Not tainted 6.5.0-rc5-next-20230808-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue:  0x0 (events)
RIP: 0010:0xff01
Code: Unable to access opcode bytes at 0xfed7.
RSP: 0018:ffffc90003b2fc60 EFLAGS: 00010086
RAX: ffff888024685940 RBX: 000000000000ff01 RCX: 0000000000000000
RDX: ffff888021963b80 RSI: ffffffff812d721d RDI: 0000000000000007
RBP: 0000000100040020 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000100040020
R13: 000000000000ff01 R14: 0000000100040020 R15: 000000000000ff01
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000ff01 CR3: 000000001ef98000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 </TASK>
Modules linked in:
CR2: 000000000000ff01
---[ end trace 0000000000000000 ]---
RIP: 0010:0xff01
Code: Unable to access opcode bytes at 0xfed7.
RSP: 0018:ffffc90003b2fc60 EFLAGS: 00010086

RAX: ffff888024685940 RBX: 000000000000ff01 RCX: 0000000000000000
RDX: ffff888021963b80 RSI: ffffffff812d721d RDI: 0000000000000007
RBP: 0000000100040020 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000100040020
R13: 000000000000ff01 R14: 0000000100040020 R15: 000000000000ff01
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000ff01 CR3: 000000001ef98000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         71cd4fc4 Add linux-next specific files for 20230808
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=166b9763a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e36b5ba725f7349d
dashboard link: https://syzkaller.appspot.com/bug?extid=5671b8bcd5178fe56c23
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10060e27a80000

