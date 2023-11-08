Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA57E5886
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjKHOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKHOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:19:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8A1FC1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:19:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so15013a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699453157; x=1700057957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sYNnjAcMQ8gCIe4cIzjWRlbHFIhha8H1RklK74YtPo=;
        b=uxs05mpGSIdXlmdYd/s2YDwWA2313+WgW+YVF2x3jFcLiSbh6GAP9v1L0bfCsy+J5S
         0GTLJuL+sbU/+PWUGe6F25lUGhJ9zKWGFAP184hcBPXnWMR78l4VJB/hKmshxA4udv8S
         WRheh9wDpF13m9bYXsK28HddB1yAJdZwlaewrpic3g46K9wC+pKQkpKsqgxlBF9ddozT
         AYFuDPJqr0TC18MD1Kh+EKXGvanviQ5wozSt1x0HfxptbOf4hi+AGYKwX+r4lbveeCT0
         JnNboUpp9cU6sBhd+m9/6NS0xmoNmwwYGG1o2UfNXvi5RNFbO20OakOc+35ODgYuJ63a
         Z5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453157; x=1700057957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sYNnjAcMQ8gCIe4cIzjWRlbHFIhha8H1RklK74YtPo=;
        b=HqoPrR0FOjZaCiYVZ3J5Aim5Cup75KfmTlIJ6hlku75U/JwQrgP3XNxu0DwbhnAqRD
         gl/ozLfgSwQlBJ7eKkFX7UZxPsE4yRdiIY/iREAUGF/TFQ8tTq9fNbHtT+mDy90jQOPI
         ry/Sm6bhzHOc+leZoBnh3QzjYTttJhcveoBCpYk3zdUBa3wQXzgMv+OV0omuPPlkOfk4
         ONyQbtU2AtCrB5IkWW5pFYFR1bWEIQTyE/kq61EbVGI/aFlc5BTVfr4EgwCrxQ/sY89+
         pcoU7aZVBDmkDw5Tg1EEnhyxTUop1C1Yppekjvu64IzcNkhoRbFepyRKDv0H71F/0Q7K
         5KFQ==
X-Gm-Message-State: AOJu0YwtVMGTk6MGPT0g6nX/XfqGturgeQ2o5IsWKs6uKWckyy6r2Ami
        bfeD7qZxvuev/gtTMUnXQG5qz8qpaBIB9SbVDBkRTA==
X-Google-Smtp-Source: AGHT+IHj4bJ+yiU4h9OblJOTjRI0jqw1FY6a7GwD4yc2B+lCC4iQ346itd6XVNguMuvx1MB2vtj6nSqzVvv5/MzQg4s=
X-Received: by 2002:a05:6402:528e:b0:544:e37e:d597 with SMTP id
 en14-20020a056402528e00b00544e37ed597mr284537edb.7.1699453156652; Wed, 08 Nov
 2023 06:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
In-Reply-To: <20231108064641.65209-1-haifeng.xu@shopee.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 8 Nov 2023 15:19:03 +0100
Message-ID: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 7:47=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com> w=
rote:
>
> call stack:

These stacks should either be removed from the changelog, or moved
_after_ the description
of the problem. These are normal looking call stacks, you are not
fixing a crash or deadlock.

> ......
> PID: 210933  TASK: ffff92424e5ec080  CPU: 13  COMMAND: "kworker/u96:2"
> [ffffa7a8e96bbac0] __schedule at ffffffffb0719898
> [ffffa7a8e96bbb48] schedule at ffffffffb0719e9e
> [ffffa7a8e96bbb68] rwsem_down_write_slowpath at ffffffffafb3167a
> [ffffa7a8e96bbc00] down_write at ffffffffb071bfc1
> [ffffa7a8e96bbc18] kernfs_remove_by_name_ns at ffffffffafe3593e
> [ffffa7a8e96bbc48] sysfs_unmerge_group at ffffffffafe38922
> [ffffa7a8e96bbc68] dpm_sysfs_remove at ffffffffb021c96a
> [ffffa7a8e96bbc80] device_del at ffffffffb0209af8
> [ffffa7a8e96bbcd0] netdev_unregister_kobject at ffffffffb04a6b0e
> [ffffa7a8e96bbcf8] unregister_netdevice_many at ffffffffb046d3d9
> [ffffa7a8e96bbd60] default_device_exit_batch at ffffffffb046d8d1
> [ffffa7a8e96bbdd0] ops_exit_list at ffffffffb045e21d
> [ffffa7a8e96bbe00] cleanup_net at ffffffffb045ea46
> [ffffa7a8e96bbe60] process_one_work at ffffffffafad94bb
> [ffffa7a8e96bbeb0] worker_thread at ffffffffafad96ad
> [ffffa7a8e96bbf10] kthread at ffffffffafae132a
> [ffffa7a8e96bbf50] ret_from_fork at ffffffffafa04b92
>
> 290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-expor=
ter"
> [ffffa7a8d14dbb80] __schedule at ffffffffb0719898
> [ffffa7a8d14dbc08] schedule at ffffffffb0719e9e
> [ffffa7a8d14dbc28] schedule_preempt_disabled at ffffffffb071a24e
> [ffffa7a8d14dbc38] __mutex_lock at ffffffffb071af28
> [ffffa7a8d14dbcb8] __mutex_lock_slowpath at ffffffffb071b1a3
> [ffffa7a8d14dbcc8] mutex_lock at ffffffffb071b1e2
> [ffffa7a8d14dbce0] rtnl_lock at ffffffffb047f4b5
> [ffffa7a8d14dbcf0] bonding_show_bonds at ffffffffc079b1a1 [bonding]
> [ffffa7a8d14dbd20] class_attr_show at ffffffffb02117ce
> [ffffa7a8d14dbd30] sysfs_kf_seq_show at ffffffffafe37ba1
> [ffffa7a8d14dbd50] kernfs_seq_show at ffffffffafe35c07
> [ffffa7a8d14dbd60] seq_read_iter at ffffffffafd9fce0
> [ffffa7a8d14dbdc0] kernfs_fop_read_iter at ffffffffafe36a10
> [ffffa7a8d14dbe00] new_sync_read at ffffffffafd6de23
> [ffffa7a8d14dbe90] vfs_read at ffffffffafd6e64e
> [ffffa7a8d14dbed0] ksys_read at ffffffffafd70977
> [ffffa7a8d14dbf10] __x64_sys_read at ffffffffafd70a0a
> [ffffa7a8d14dbf20] do_syscall_64 at ffffffffb070bf1c
> [ffffa7a8d14dbf50] entry_SYSCALL_64_after_hwframe at ffffffffb080007c
> ......
>
> Problem description:
>
> Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
> but there are many readers which hold the kernfs_rwsem, so it has to slee=
p
> for a long time to wait the readers release the lock. Thread 278176 and a=
ny
> other threads which call bonding_show_bonds() also need to wait because
> they try to accuire the rtnl_mutex.

acquire

>
> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
> However, the addition and deletion of bond_list are only performed in
> bond_init()/bond_uninit(), so we can intoduce a separate read-write lock

introduce

> to synchronize bond list mutation.
>
> What's the benefits of this change?
>
> 1) All threads which call bonding_show_bonds() only wait when the
> registration or unregistration of bond device happens.
>
> 2) There are many other users of rtnl_mutex, so bonding_show_bonds()
> won't compete with them.
>
> In a word, this change reduces the lock contention of rtnl_mutex.
>

This looks good to me, but please note:

1) This is net-next material, please resend next week, because
net-next is currently closed during the merge window.

2) Using a spell checker would point few typos (including in the title
"boning" -> "bonding")

Thanks.
