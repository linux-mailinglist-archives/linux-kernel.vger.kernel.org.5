Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFFC755C51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGQHC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjGQHCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:02:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9647E5E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:02:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so4443e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689577340; x=1692169340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=12KfeSD9MMayl4iugwpxlpwtkls//PC2ordHuUGm4yM=;
        b=Mz/RypmjQK2KJw6jXx9+3DuK77oiWPflmUuJFPGsoVOjhWfkNBNyLtb/xjT9OepLiS
         iVEiAj7ZEMN/BFBtvxFWfJIgb8MQtYYM7kvQHJs7Hd8DOxAC4CKmjE0Vici6UUCtNCOD
         Z7Y9xMVqtvphCR7GVOE3oQErhu5A/zGuRWfJVwUKTTpH5sPVc2rcgKGSoEEm9rZut3wr
         Ro4w8dR+8wvIxNxT/nAzf3rwS3qdfNQEqSC0cHHm1KKenG1gB5hbnkFqzUp4SacLjYRY
         SxQ33mxoeO4qKvpqzByWuajYu8kptiBdxDYvOhCPekVpnpYVeQ+rHg8TQaAAHKHFi63v
         BGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689577340; x=1692169340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12KfeSD9MMayl4iugwpxlpwtkls//PC2ordHuUGm4yM=;
        b=LkZWH9qPmP8OByvbIqvrQ1FFt2X61EmETqNyniUkkl7GlUKJQqrE6SsPZ5gNgGFbqa
         uoFgNCXimoMiLu4C4QVEAKwW+7LkcItfKbpb2EDCQfA7x+1wZKV/lsUj5t5XNQZd9pud
         vB5hFr3B5t3zJ4BlLLljJC3Rh6Px75FsCvClV+SXQHELCip78Y06BNKzHx0z5dJeKdEH
         hMJxlDFNAgOLAekwm9TOrWOwXxLCI5B7wdxMT0vTusb0yIQUZPgRf8fFrcj+90c2hv28
         dCv8+MxFac+vvO28v+S0DyXsjRU/7PZtxtcFYpkckSsm2D4sNrmQn28XX1+AEUZhRbXB
         W5yw==
X-Gm-Message-State: ABy/qLbg1rFeriJ/kpmog/lvwKu/CbaylvXl1Y8n3zPxgSuu5GK9sIi+
        ef6BzZN5JwBsXeMT8bSo0PlLk47K1LncxiUVXpzENw==
X-Google-Smtp-Source: APBJJlHEtR6u9F1Mb+3YI3LdPIt7e9gDeGhOoet/px6RkHkBLqBrWj/2Mx+h5iKeVLZPafpGXdcfDRLUV77OxnBuUQA=
X-Received: by 2002:ac2:414c:0:b0:4ec:5157:bb37 with SMTP id
 c12-20020ac2414c000000b004ec5157bb37mr329167lfi.2.1689577339751; Mon, 17 Jul
 2023 00:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000098ed3a0600965f89@google.com> <87v8ekattg.wl-tiwai@suse.de>
 <ZLQ/zKgTGMHy/6Jn@geday>
In-Reply-To: <ZLQ/zKgTGMHy/6Jn@geday>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Jul 2023 09:02:07 +0200
Message-ID: <CACT4Y+bXLZf9iAgiLcxo7coNsOCsn_1C26zuvNBa48qLp2Juxg@mail.gmail.com>
Subject: Re: [syzbot] [alsa?] memory leak in snd_seq_create_port
To:     Geraldo Nascimento <geraldogabriel@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot <syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2023 at 22:47, Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> On Sun, Jul 16, 2023 at 03:07:23PM +0200, Takashi Iwai wrote:
> > On Sun, 16 Jul 2023 10:21:49 +0200,
> > syzbot wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14b07344a80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=75da4f0a455bdbd3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=cf8e7fa4eeec59b3d485
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15877dc2a80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12905004a80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/441fb7ea58b8/disk-3f01e9fe.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/8fa7790ba0c3/vmlinux-3f01e9fe.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/5e7a6471dadf/bzImage-3f01e9fe.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com
> > >
> > > Warning: Permanently added '10.128.1.1' (ED25519) to the list of known hosts.
> > > executing program
> > > executing program
> > > BUG: memory leak
> > > unreferenced object 0xffff888100877000 (size 512):
> > >   comm "syz-executor257", pid 5012, jiffies 4294941742 (age 12.790s)
> > >   hex dump (first 32 bytes):
> > >     80 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > >     [<ffffffff83d29e28>] kmalloc include/linux/slab.h:582 [inline]
> > >     [<ffffffff83d29e28>] kzalloc include/linux/slab.h:703 [inline]
> > >     [<ffffffff83d29e28>] snd_seq_create_port+0x78/0x300 sound/core/seq/seq_ports.c:135
> > >     [<ffffffff83d1f681>] snd_seq_ioctl_create_port+0xe1/0x2a0 sound/core/seq/seq_clientmgr.c:1324
> > >     [<ffffffff83d20e5e>] snd_seq_ioctl+0x13e/0x290 sound/core/seq/seq_clientmgr.c:2327
> > >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> > >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> > >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff888106742c00 (size 512):
> > >   comm "syz-executor257", pid 5013, jiffies 4294942276 (age 7.450s)
> > >   hex dump (first 32 bytes):
> > >     80 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> > >     [<ffffffff83d29e28>] kmalloc include/linux/slab.h:582 [inline]
> > >     [<ffffffff83d29e28>] kzalloc include/linux/slab.h:703 [inline]
> > >     [<ffffffff83d29e28>] snd_seq_create_port+0x78/0x300 sound/core/seq/seq_ports.c:135
> > >     [<ffffffff83d1f681>] snd_seq_ioctl_create_port+0xe1/0x2a0 sound/core/seq/seq_clientmgr.c:1324
> > >     [<ffffffff83d20e5e>] snd_seq_ioctl+0x13e/0x290 sound/core/seq/seq_clientmgr.c:2327
> > >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> > >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> > >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Likely a forgotten kfree() at the error path.
> > The patch below should fix it.
> >
> >
> > Takashi
> >
> > -- 8< --
> > From: Takashi Iwai <tiwai@suse.de>
> > Subject: [PATCH] ALSA: seq: Fix memory leak at error path in
> >  snd_seq_create_port()
> >
> > We forgot to release a newly allocated item at the error path in
> > snd_seq_create_port().  This patch fixes it.
>
> Thanks for the clarification and quick proposed resolution Takashi. As
> an ALSA novice these bots always stunt me, personally. I understand how
> helpful they are however, even if cryptic.

Hi Geraldo,

What exactly is cryptic in the report? Is there anything that can be
done to make it less cryptic?


> But shouldn't this be reported to security? It's always prone to bad
> stuff when we forget a kfree()
>
> Thanks,
> Geraldo Nascimento
>
> >
> > Reported-by: syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/r/00000000000098ed3a0600965f89@google.com
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  sound/core/seq/seq_ports.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
> > index 9b80f8275026..f3f14ff0f80f 100644
> > --- a/sound/core/seq/seq_ports.c
> > +++ b/sound/core/seq/seq_ports.c
> > @@ -149,6 +149,7 @@ int snd_seq_create_port(struct snd_seq_client *client, int port,
> >       write_lock_irq(&client->ports_lock);
> >       list_for_each_entry(p, &client->ports_list_head, list) {
> >               if (p->addr.port == port) {
> > +                     kfree(new_port);
> >                       num = -EBUSY;
> >                       goto unlock;
> >               }
> > --
> > 2.35.3
