Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF9B7F78D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjKXQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXQVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:21:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE85199A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:22:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so26316a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700842919; x=1701447719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M64ztmWBiARV+bGOkqq9YDeivw9HkSbLr9/sDMlRs+I=;
        b=svb9Q/R28rG88XeCEoV0lfKZ3I9iQrd32uZDHauHkJ6Rnqp/YReWNaHgVR/cwvUihP
         N9K/X3UkJ7vSlT9XsxfACtrpW13I3DJlI7lAr7cMw34g+FNBgICwcW4UKHB8yTeh1nnr
         U/VWYrutjOw6pxBrJmK+ivtX3mOhnvVAmHZFsrDIVWYc3TU/6HOZyHtggv3NkLF0ZDvg
         RO1Ah9C9zqx10iHVmxOtVCh7O+ctEPKJQlikVwK5rsdkmHtwvYzAVuZD2fYFgvIUH4eM
         4ucogFYKy3brOzSs4oUn50F4hs8YXU58rpOymE9nMELGGkLOVxwicNWoL2KGACPFN0YQ
         hmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700842919; x=1701447719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M64ztmWBiARV+bGOkqq9YDeivw9HkSbLr9/sDMlRs+I=;
        b=MzlzSuF2tLFRmi3MjfWhXqe654u8pVNq04F5P+1s9H+x3SpZNTNw8LC1dWflIhbjPz
         WbAs+oZB96X5YlAS6NIAZ5DMkPixVEpyMu7Gk4hVB6TTUUaexk2FgC0D320t+pFWseGu
         zOkvaVTFtiDEiHfGx1PdmciEa0NHMTQOSoQJJsPM+o7nx6hXWxUBrCWXjjSKKXepQBhD
         9zOgy6Xqc8rexsEk4VJabw1rSNdGr9op88ZDGvM/pN6QnzbSX97zBkzsVX99sGaFWPNq
         u0cunbQOahKYgBmUeP5Fe46vJiRfYWfAvkkIBtR56sa6hMLnPHtkLYD30Gz43RxX7/nD
         Vfag==
X-Gm-Message-State: AOJu0YzhT+KYDclUxjvGUjdwGVC7Z7fNKZlAnzvWDTbY7Y1lKYw0TAsi
        Y9tC8Nmja8SQyWCzzaBCLUwgWsCaqZmddjgT/kl2Sg==
X-Google-Smtp-Source: AGHT+IHOeiCqx5ybJGDdPWiIWyOFgVXz//YKTM16O94xCOOn5kmMHZ2WfxY1jX/GPpN0CrU7+gR0RYsxj5OhmA7J/Hg=
X-Received: by 2002:a05:6402:b83:b0:544:e249:be8f with SMTP id
 cf3-20020a0564020b8300b00544e249be8fmr359458edb.1.1700842918703; Fri, 24 Nov
 2023 08:21:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cf908705eaa8c5a7@google.com>
In-Reply-To: <000000000000cf908705eaa8c5a7@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Nov 2023 17:21:20 +0100
Message-ID: <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __kernel_write_iter
To:     syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 9:04=E2=80=AFAM syzbot
<syzbot+12e098239d20385264d3@syzkaller.appspotmail.com> wrote:
> HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D110f6f0a88000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd19f5d16783f9=
01
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D12e098239d20385=
264d3
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da=
-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9/dis=
k-a6afa419.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vmlinu=
x-a6afa419.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 20347 at fs/read_write.c:504 __kernel_write_iter+0x6=
39/0x740
[...]
>  __kernel_write fs/read_write.c:537 [inline]
>  kernel_write+0x1c5/0x340 fs/read_write.c:558
>  write_buf fs/btrfs/send.c:590 [inline]
>  send_header fs/btrfs/send.c:708 [inline]
>  send_subvol+0x1a7/0x4b60 fs/btrfs/send.c:7648
>  btrfs_ioctl_send+0x1e34/0x2340 fs/btrfs/send.c:8014
>  _btrfs_ioctl_send+0x2e8/0x420 fs/btrfs/ioctl.c:5233
>  btrfs_ioctl+0x5eb/0xc10
>  vfs_ioctl fs/ioctl.c:51 [inline]

The issue here is that BTRFS_IOC_SEND looks up an fd with fget() and
then writes into it with kernel_write(). Luckily the ioctl requires
CAP_SYS_ADMIN, and also Linux >=3D5.8 bails out on __kernel_write() on a
read-only file, so this has no security impact.

I'm about to send a fix, let's have syzkaller check it beforehand:

#syz test https://github.com/thejh/linux.git 573fd2562e0f
