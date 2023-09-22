Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8057AB999
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjIVSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIVSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:51:10 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B44AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:04 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7a29ef55d5fso1110274241.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695408663; x=1696013463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5AL1Er8cli5ohxxEFsApKY49GAAyyURjGo4thr5dpk=;
        b=NR/+TUM3phQo+YrxUBZUSvNN2iEwDNCqZ9R2AM3U8zPa8P0ZYJcpEKeUdbiX6XiG99
         F5CsmqM2el6nenU0qZOTLgR0AuS/t1abdSD9EmVtlF3mwWwBW0rcPJRCc5IM9gfQKC+g
         oOg65jBV2y07hjNyXfO/RxD/tXjv5NzyQ5914Kjou34soO6ed9LjdmuxbnkjlPEZIiI0
         ElwpxicyfL4iU+zjojK3cFM+g3T4sFKdFEGb9JqheE5k3ROpKHWvWg0A95bbly2JeWKY
         x06HEwmNIw+2g2xXOjclrp+3WpSAtsWVVhf9Az3aJ0Cj4x4uyFyFvDpBSrwuw2Jvf8CA
         0pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408663; x=1696013463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5AL1Er8cli5ohxxEFsApKY49GAAyyURjGo4thr5dpk=;
        b=VgRrKcWTc1lGBgBPfvxJZbT3BGtJmij+K0u2AAFjHV4QYqCCZrY8TLfPJoS4GZE86j
         yJS4caXyX6zXpNCf1WJrIB7gjqk8LsMUQGBwYUi6iXNX+xXckaXaJayrtIbnWB2zv7p1
         lYylANse61zgx+7mYj1Pw4YXmYQsN6de7DteHb0cjiARg+7aoCl4en22bKUsy2Sn3A0u
         jf5QxEvPQCgXRsa0i5WAhWB46TRzyxTJrCSFtmltofl3XZ+1Hn8kiNl5KS0McIdRp615
         zSpV5p3mq+J24Yy/6mCMrij8X9NdU8CEzg7NaLbmLJATlLvURBJo3yNqZzR+ZVNlgLU6
         1GUg==
X-Gm-Message-State: AOJu0Yz14hufKpng0rxJCAmpEE8BVBhWfRxvEjMofdcDmuKFydqP7LG3
        iN7JHK4Ph2Hb0z733E+Hh9tLkbL7J9931w4DHmYhBQ==
X-Google-Smtp-Source: AGHT+IG8GrYLYLKrpxCZ8ijSlhEwiI7BW8cuSIiVFfkNcuRYAG/NrYULiEo5kokoHWBH2qxMwKjbllYHpchAy3oq9wo=
X-Received: by 2002:a05:6102:51b:b0:452:70f7:ca4a with SMTP id
 l27-20020a056102051b00b0045270f7ca4amr323013vsa.34.1695408663172; Fri, 22 Sep
 2023 11:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230922044241.322832-1-cmllamas@google.com> <20230922175138.230331-1-cmllamas@google.com>
In-Reply-To: <20230922175138.230331-1-cmllamas@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Fri, 22 Sep 2023 20:50:51 +0200
Message-ID: <CAH5fLgivUrTGxFjmnN2XYv5_hL==A+UfmJibC0vzy4Bw1AMxAQ@mail.gmail.com>
Subject: Re: [PATCH v2] binder: fix memory leaks of spam and pending work
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Li Li <dualli@google.com>, Hang Lu <hangl@codeaurora.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
        syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 7:51=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> A transaction complete work is allocated and queued for each
> transaction. Under certain conditions the work->type might be marked as
> BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT to notify userspace about
> potential spamming threads or as BINDER_WORK_TRANSACTION_PENDING when
> the target is currently frozen.
>
> However, these work types are not being handled in binder_release_work()
> so they will leak during a cleanup. This was reported by syzkaller with
> the following kmemleak dump:
>
> BUG: memory leak
> unreferenced object 0xffff88810e2d6de0 (size 32):
>   comm "syz-executor338", pid 5046, jiffies 4294968230 (age 13.590s)
>   hex dump (first 32 bytes):
>     e0 6d 2d 0e 81 88 ff ff e0 6d 2d 0e 81 88 ff ff  .m-......m-.....
>     04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
>     [<ffffffff83d41873>] kmalloc include/linux/slab.h:599 [inline]
>     [<ffffffff83d41873>] kzalloc include/linux/slab.h:720 [inline]
>     [<ffffffff83d41873>] binder_transaction+0x573/0x4050 drivers/android/=
binder.c:3152
>     [<ffffffff83d45a05>] binder_thread_write+0x6b5/0x1860 drivers/android=
/binder.c:4010
>     [<ffffffff83d486dc>] binder_ioctl_write_read drivers/android/binder.c=
:5066 [inline]
>     [<ffffffff83d486dc>] binder_ioctl+0x1b2c/0x3cf0 drivers/android/binde=
r.c:5352
>     [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
>     [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
>     [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
>     [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inlin=
e]
>     [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:=
80
>     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Fix the leaks by kfreeing these work types in binder_release_work() and
> handle them as a BINDER_WORK_TRANSACTION_COMPLETE cleanup.
>
> Cc: stable@vger.kernel.org
> Fixes: 0567461a7a6e ("binder: return pending info for frozen async txns")
> Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace wh=
en detected oneway spamming")
> Reported-by: syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7f10c1653e35933c0f1e
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
