Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199A77EF146
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbjKQK7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbjKQK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:59:46 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538A3B4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:59:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so10286a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700218781; x=1700823581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGSJhMQLQHd9biRHUxWSjeHfJhsfFu4krkHp3T9mhXE=;
        b=1W/gjNcgwACeQkSRlaIOy6nekpNO9R5VaFkHjQrmCs1CFbgPBdbT9NeshWDDjQ0nYR
         tVOObHzQQKzJnK8SRfqGTHgyrD1vu6irbzgqoUZnnjQK5m3RQJHZlE9tTGF3bdw8LUV+
         6naiQ93CWjPMr/vFAah1XjQJbKvb/HtHHTPR2uC52sgEL+vsg6L88h0BWuxBbE5oTbbm
         UTuHfGJtUb227S1qclr0IfwXFiYAoiGSMnvuEzVc70GdZ+oj+8XWTnnyTvZbTfOGvsFK
         5s3OIZb0UhqayC31ihUU9Xwp/rhNjkWl32M1629HsQehz5X6ii5ObaMdfCrg0V60LXtw
         kCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218781; x=1700823581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGSJhMQLQHd9biRHUxWSjeHfJhsfFu4krkHp3T9mhXE=;
        b=GH3BmlfSyxYUnUAgNra66TqOMoPO6WDY/QYIJrcE9Bh2xl0VL1fxvghIwuN8DVabFb
         fediQUpt/ElKwdEm/HDK5fGFKe9Kpc+6ut2D5/FCWJkAyP8EZBfIhbUuSHJzNkItbTAj
         6h8r/ZeVgrPQ5CLY9pPjkS/z7t9cmc8jiFhElxgAnztotUPmqDg/mSUxqP4MixOcknKU
         3k6p80sFKEDnpdsBRpN2Oqj67Up6ofIASwZwSuUOvgIRjrkQ+zLuiKvHPY5Vfl+86QKD
         C5deCCkxHofdqZJwA5wvxzFtjAWdrIxuac/CZP41PeHyyth+JIOYcEyKr4Rvis2flJWm
         Chpw==
X-Gm-Message-State: AOJu0YwZvJXh+vNywgQW4Geaq6TwCOH4JeZ0vWLBg0v+5a3+VGTnXYML
        ozHG6JDWgC8nohvS3s0VBfB9VA/HhdzoPVGJFKl8TA==
X-Google-Smtp-Source: AGHT+IEZCsl7cGhKoqE5WneQsLe+U1yQ/gra+BndxIG1+VURv+zKznyx2chZoVGDEYpKu+UqLrDXYcPwtlJmEQgjZ1Q=
X-Received: by 2002:a05:6402:10ca:b0:544:466b:3b20 with SMTP id
 p10-20020a05640210ca00b00544466b3b20mr87286edu.5.1700218780533; Fri, 17 Nov
 2023 02:59:40 -0800 (PST)
MIME-Version: 1.0
References: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
 <20231117104311.1273-1-haifeng.xu@shopee.com>
In-Reply-To: <20231117104311.1273-1-haifeng.xu@shopee.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Nov 2023 11:59:27 +0100
Message-ID: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
Subject: Re: [PATCH v2] bonding: use a read-write lock in bonding_show_bonds()
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:43=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com>=
 wrote:
>
> Problem description:
>
> Call stack:
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
> Thread 210933 holds the rtnl_mutex and tries to acquire the kernfs_rwsem,
> but there are many readers which hold the kernfs_rwsem, so it has to slee=
p
> for a long time to wait the readers release the lock. Thread 278176 and a=
ny
> other threads which call bonding_show_bonds() also need to wait because
> they try to acquire the rtnl_mutex.
>
> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
> However, the addition and deletion of bond_list are only performed in
> bond_init()/bond_uninit(), so we can introduce a separate read-write lock
> to synchronize bond list mutation.
>
> What are the benefits of this change?
>
> 1) All threads which call bonding_show_bonds() only wait when the
> registration or unregistration of bond device happens.
>
> 2) There are many other users of rtnl_mutex, so bonding_show_bonds()
> won't compete with them.
>
> In a word, this change reduces the lock contention of rtnl_mutex.
>
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
> v2:
> - move the call stack after the description
> - fix typos in the changelog
> ---
>  drivers/net/bonding/bond_main.c  | 4 ++++
>  drivers/net/bonding/bond_sysfs.c | 6 ++++--
>  include/net/bonding.h            | 3 +++
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 8e6cc0e133b7..db8f1efaab78 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5957,7 +5957,9 @@ static void bond_uninit(struct net_device *bond_dev=
)
>
>         bond_set_slave_arr(bond, NULL, NULL);
>
> +       write_lock(&bonding_dev_lock);
>         list_del(&bond->bond_list);
> +       write_unlock(&bonding_dev_lock);
>
>         bond_debug_unregister(bond);
>  }
> @@ -6370,7 +6372,9 @@ static int bond_init(struct net_device *bond_dev)
>         spin_lock_init(&bond->stats_lock);
>         netdev_lockdep_set_classes(bond_dev);
>
> +       write_lock(&bonding_dev_lock);
>         list_add_tail(&bond->bond_list, &bn->dev_list);
> +       write_unlock(&bonding_dev_lock);
>
>         bond_prepare_sysfs_group(bond);
>
> diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_=
sysfs.c
> index 2805135a7205..e107c1d7a6bf 100644
> --- a/drivers/net/bonding/bond_sysfs.c
> +++ b/drivers/net/bonding/bond_sysfs.c
> @@ -28,6 +28,8 @@
>
>  #define to_bond(cd)    ((struct bonding *)(netdev_priv(to_net_dev(cd))))
>
> +DEFINE_RWLOCK(bonding_dev_lock);
> +
>  /* "show" function for the bond_masters attribute.
>   * The class parameter is ignored.
>   */
> @@ -40,7 +42,7 @@ static ssize_t bonding_show_bonds(const struct class *c=
ls,
>         int res =3D 0;
>         struct bonding *bond;
>
> -       rtnl_lock();
> +       read_lock(&bonding_dev_lock);
>
>         list_for_each_entry(bond, &bn->dev_list, bond_list) {
>                 if (res > (PAGE_SIZE - IFNAMSIZ)) {
> @@ -55,7 +57,7 @@ static ssize_t bonding_show_bonds(const struct class *c=
ls,
>         if (res)
>                 buf[res-1] =3D '\n'; /* eat the leftover space */
>
> -       rtnl_unlock();
> +       read_unlock(&bonding_dev_lock);
>         return res;
>  }

This unfortunately would race with dev_change_name()

You probably need to read_lock(&devnet_rename_sem); before copying dev->nam=
e,
or use netdev_get_name(net, temp_buffer, bond->dev->ifindex)
