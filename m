Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACDC7E70F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbjKIRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbjKIRzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:55:07 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E587A3A81
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:55:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so122580b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1699552504; x=1700157304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsdJnH/UPwCfccnXmCrjr+pN8ss+UFCd2sCSGOFBt1Q=;
        b=qQHnAoegc4UhbUv7mHPohCeeEhCD7ULqIlkiqZBkiTgH3XjUKM0AMYCsjopHx4m1dY
         45zcxswg3jZ+lJwt0QvGwW7NQ4CIeRTPaAi4wKY1SJm745J1BC1G3xDgf08CuWBFT51Y
         gHCqgMqdHbQLYzVsNFvxW6c+8wTpQLj82EQbAxeVHEKX6JTI+vr+Zvp2XYOSPYKp+FO5
         /kV4i4vQcSYJdlkiym31HfiDfVxisOEV02+admNmlMqji9WdOLwKPrpaGcoF8SIxYUFf
         CDtNmfF4cbE8ZxMH6Z+E+X1y7sA7qpWeq5XmXNPJk2DA4sT1vnUNggE/Plr1Fuk0CuOl
         YvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552504; x=1700157304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsdJnH/UPwCfccnXmCrjr+pN8ss+UFCd2sCSGOFBt1Q=;
        b=mD8CFNqfiQ6JCV1pjLJphN363tY41nbtFQBtgVxNpEvx8W1v9FANwMeutp0TjnTT0z
         OwpSIdz7uZEBcIY6jMnLsOK5F82XAu3dgBwGvBkRPHUVZXHr0ZEaEmMLTSwbStgb3vAS
         5qlfoLHuLjZzttL03kY4WWgadyxTutNDzCjbtanNeXi7S1zEqZTpDgkfengDdPovLgv8
         NxrjuEGhIkwxTbM8flvOsyuQXdbnB07dfM5mDW/kLDuOxbLetKgYh+0RCj5VvJI32ePF
         r89cu1SLmnF9nI6rES8xRwT/ASVJZMNI5v0BdBNZxU2CI1fTa2ycbu06A55Jo7xoo50B
         Id2g==
X-Gm-Message-State: AOJu0YxrLwD4hBKUqSj6G7+H97RtUgzbwWJwwOK88w4YqiXYiveUP8o9
        7Z3eb+dGW46d3uHLJf7Eqgikhg==
X-Google-Smtp-Source: AGHT+IEAezY0GC9QhZdx89YT2zb/H5H4dcMl2pyI6rDFMS8jlVgJ3/InUzO8ecz+JhORfkFhJv76Pw==
X-Received: by 2002:a05:6a00:1acd:b0:6c3:7978:f82f with SMTP id f13-20020a056a001acd00b006c37978f82fmr5902105pfv.9.1699552504349;
        Thu, 09 Nov 2023 09:55:04 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ff6-20020a056a002f4600b006c3328c9911sm11274857pfb.93.2023.11.09.09.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:55:04 -0800 (PST)
Date:   Thu, 9 Nov 2023 09:55:02 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
Message-ID: <20231109095502.5a03bfd5@hermes.local>
In-Reply-To: <20231108064641.65209-1-haifeng.xu@shopee.com>
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 06:46:41 +0000
Haifeng Xu <haifeng.xu@shopee.com> wrote:

> call stack:
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
> 290858 PID: 278176  TASK: ffff925deb39a040  CPU: 32  COMMAND: "node-exporter"
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
> but there are many readers which hold the kernfs_rwsem, so it has to sleep
> for a long time to wait the readers release the lock. Thread 278176 and any
> other threads which call bonding_show_bonds() also need to wait because
> they try to accuire the rtnl_mutex.
> 
> bonding_show_bonds() uses rtnl_mutex to protect the bond_list traversal.
> However, the addition and deletion of bond_list are only performed in
> bond_init()/bond_uninit(), so we can intoduce a separate read-write lock
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
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  drivers/net/bonding/bond_main.c  | 4 ++++
>  drivers/net/bonding/bond_sysfs.c | 6 ++++--
>  include/net/bonding.h            | 3 +++
>  3 files changed, 11 insertions(+), 2 deletions(-)

Reader-writer locks are slower than spin locks and should be discouraged.
Would it be possible to use RCU here instead?
