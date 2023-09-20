Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334AA7A88F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjITPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjITPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1AC9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DFC8C433CD;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225025;
        bh=5E6/vgeNSXlsDaOqY3PRSrvn+uv7qLRwo9AGA/fIhnU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OLSHdp+ogP4FIvjxhDedd5cpeI6W6XqV7Ur8CBSaTPOBYxESPvfAspV5crBvC4qiS
         1UjaZsW3INkiTdUJTZ/AqCZovpQFE7PkLlxEJPv1UuAibZSkAThZ1SXEHk4pYrFeIs
         rKsvR2qvY2h0ZCR1qlW6w+dLsbpQs0EdKxeRzrrmYk8mD9kKLuR0eGxDTtN5ddKTLr
         lfu8xe3DGtE8x/o0kyidlyxrFBv7GeFMbERZLCjcMAPYFVVLI9MuCMYAT4ZdV3cdEk
         mcUzDnjoCDHMHMbPnnpm9Pzihit8ZzV0VBPXolBlgp1FFf2dyX40JEq+1PPzegbYY9
         o0YtshVXQy4gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A8DCE11F4A;
        Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to drop meta_inode's page cache in
 f2fs_put_super()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169522502530.22557.11815726181069240505.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 15:50:25 +0000
References: <20230905045753.24964-1-chao@kernel.org>
In-Reply-To: <20230905045753.24964-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org,
        syzbot+ebd7072191e2eddd7d6e@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  5 Sep 2023 12:57:53 +0800 you wrote:
> syzbot reports a kernel bug as below:
> 
> F2FS-fs (loop1): detect filesystem reference count leak during umount, type: 10, count: 1
> kernel BUG at fs/f2fs/super.c:1639!
> CPU: 0 PID: 15451 Comm: syz-executor.1 Not tainted 6.5.0-syzkaller-09338-ge0152e7481c6 #0
> RIP: 0010:f2fs_put_super+0xce1/0xed0 fs/f2fs/super.c:1639
> Call Trace:
>  generic_shutdown_super+0x161/0x3c0 fs/super.c:693
>  kill_block_super+0x3b/0x70 fs/super.c:1646
>  kill_f2fs_super+0x2b7/0x3d0 fs/f2fs/super.c:4879
>  deactivate_locked_super+0x9a/0x170 fs/super.c:481
>  deactivate_super+0xde/0x100 fs/super.c:514
>  cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
>  task_work_run+0x14d/0x240 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>  exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
>  do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to drop meta_inode's page cache in f2fs_put_super()
    https://git.kernel.org/jaegeuk/f2fs/c/a4639380bbe6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


