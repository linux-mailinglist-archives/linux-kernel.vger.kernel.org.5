Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E07820F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 02:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjHUAnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 20:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjHUAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 20:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB051A1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 17:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2611960B9F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825BCC433C7;
        Mon, 21 Aug 2023 00:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692578583;
        bh=WtS4/Vqr9KgvbVTQNwzz4UGJYF/XOrLdJxcAlDH7rY8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=leKct9eM/b5mU2ZmpcS/6p/mndjZlK3eTqyvk7RZpWD9taVio7ZlRwe6y1Ukd30nw
         Q/bVaFkGbhz36z+SWR2fN33/telBPGOUwX2ejbwOf93eskM4KC6MvMWveXBOOZoX2H
         ZVAemA8NaAqnB+kM/ktT+kC9sw7HcQ0YRt3tO/6V4QCJjogk87COsi03UgK7tepGnE
         apP1bnIDO6ZcZVtGdr4XaUrFgSmCmpcqBkQG0nI1Kd1HmeLfKWO8fHIc/BGaslgI3X
         8SDglCdZqZAKFpYWKdd7aTCfDR3tV7evDoCRmQQPyfijsUxli1YOajg0/qrHFotj1p
         l5bQgHcaY9URQ==
Message-ID: <608462ac-5a26-bc14-4a74-ed133eb5cdca@kernel.org>
Date:   Mon, 21 Aug 2023 08:42:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid false alarm of circular locking
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
References: <20230819003012.3473675-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230819003012.3473675-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/19 8:30, Jaegeuk Kim wrote:
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.5.0-rc5-syzkaller-00353-gae545c3283dc #0 Not tainted
> ------------------------------------------------------
> syz-executor273/5027 is trying to acquire lock:
> ffff888077fe1fb0 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
> ffff888077fe1fb0 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_add_inline_entry+0x300/0x6f0 fs/f2fs/inline.c:644
> 
> but task is already holding lock:
> ffff888077fe07c8 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
> ffff888077fe07c8 (&fi->i_xattr_sem){.+.+}-{3:3}, at: f2fs_add_dentry+0x92/0x230 fs/f2fs/dir.c:783
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&fi->i_xattr_sem){.+.+}-{3:3}:
>         down_read+0x9c/0x470 kernel/locking/rwsem.c:1520
>         f2fs_down_read fs/f2fs/f2fs.h:2108 [inline]
>         f2fs_getxattr+0xb1e/0x12c0 fs/f2fs/xattr.c:532
>         __f2fs_get_acl+0x5a/0x900 fs/f2fs/acl.c:179
>         f2fs_acl_create fs/f2fs/acl.c:377 [inline]
>         f2fs_init_acl+0x15c/0xb30 fs/f2fs/acl.c:420
>         f2fs_init_inode_metadata+0x159/0x1290 fs/f2fs/dir.c:558
>         f2fs_add_regular_entry+0x79e/0xb90 fs/f2fs/dir.c:740
>         f2fs_add_dentry+0x1de/0x230 fs/f2fs/dir.c:788
>         f2fs_do_add_link+0x190/0x280 fs/f2fs/dir.c:827
>         f2fs_add_link fs/f2fs/f2fs.h:3554 [inline]
>         f2fs_mkdir+0x377/0x620 fs/f2fs/namei.c:781
>         vfs_mkdir+0x532/0x7e0 fs/namei.c:4117
>         do_mkdirat+0x2a9/0x330 fs/namei.c:4140
>         __do_sys_mkdir fs/namei.c:4160 [inline]
>         __se_sys_mkdir fs/namei.c:4158 [inline]
>         __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4158
>         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>         do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (&fi->i_sem){+.+.}-{3:3}:
>         check_prev_add kernel/locking/lockdep.c:3142 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3261 [inline]
>         validate_chain kernel/locking/lockdep.c:3876 [inline]
>         __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
>         lock_acquire kernel/locking/lockdep.c:5761 [inline]
>         lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
>         down_write+0x93/0x200 kernel/locking/rwsem.c:1573
>         f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
>         f2fs_add_inline_entry+0x300/0x6f0 fs/f2fs/inline.c:644
>         f2fs_add_dentry+0xa6/0x230 fs/f2fs/dir.c:784
>         f2fs_do_add_link+0x190/0x280 fs/f2fs/dir.c:827
>         f2fs_add_link fs/f2fs/f2fs.h:3554 [inline]
>         f2fs_mkdir+0x377/0x620 fs/f2fs/namei.c:781
>         vfs_mkdir+0x532/0x7e0 fs/namei.c:4117
>         ovl_do_mkdir fs/overlayfs/overlayfs.h:196 [inline]
>         ovl_mkdir_real+0xb5/0x370 fs/overlayfs/dir.c:146
>         ovl_workdir_create+0x3de/0x820 fs/overlayfs/super.c:309
>         ovl_make_workdir fs/overlayfs/super.c:711 [inline]
>         ovl_get_workdir fs/overlayfs/super.c:864 [inline]
>         ovl_fill_super+0xdab/0x6180 fs/overlayfs/super.c:1400
>         vfs_get_super+0xf9/0x290 fs/super.c:1152
>         vfs_get_tree+0x88/0x350 fs/super.c:1519
>         do_new_mount fs/namespace.c:3335 [inline]
>         path_mount+0x1492/0x1ed0 fs/namespace.c:3662
>         do_mount fs/namespace.c:3675 [inline]
>         __do_sys_mount fs/namespace.c:3884 [inline]
>         __se_sys_mount fs/namespace.c:3861 [inline]
>         __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
>         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>         do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    rlock(&fi->i_xattr_sem);
>                                 lock(&fi->i_sem);
>                                 lock(&fi->i_xattr_sem);
>    lock(&fi->i_sem);
> 
> Reported-and-tested-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
> Fixes: 5eda1ad1aaff "f2fs: fix deadlock in i_xattr_sem and inode page lock"
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
