Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C79756AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGQRef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjGQReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50695D8;
        Mon, 17 Jul 2023 10:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FE56119F;
        Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08AF9C433CB;
        Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615262;
        bh=H4YvqdwXcs9eWwYRBHtp/bsnkn4MD/1phpJSu1I1qso=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iMCRy6Piwp7fJc2J5aqFnZYSidIGFYUyZ5PRUUV5uDT/is62H9cFM4TQDnP+lvs0y
         +w/5GH4Zxz8bLmd13kzbamExWkL1QDyG+/b1s8tSCXdICFFBxhBoMWI74iju5wmR3l
         PJN6ifUw6p5AhI5kXLNAx65wCL6niHBbpWzgpOYPkwq3BkrvgJBC3wQvr1kPjeIp8X
         LqAPvlRjKZ9gDy90GlIByfhaNCwP/oHt5/xLYTdmsKn+l+bsejyATYLzCL3a3uzYDV
         Sv0Q14UTacYpem5dziUAZL1U+1c8h92+zYlASPxNrQDHZn7rhVYRVe+oKnzHWHrvWA
         +h1656MyBgkKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D99CBE29F33;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: flush inode if atomic file is aborted
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168961526188.4078.2630269781392789426.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 17:34:21 +0000
References: <20230707141142.2276510-1-jaegeuk@kernel.org>
In-Reply-To: <20230707141142.2276510-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com,
        stable@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  7 Jul 2023 07:11:42 -0700 you wrote:
> Let's flush the inode being aborted atomic operation to avoid stale dirty
> inode during eviction in this call stack:
> 
>   f2fs_mark_inode_dirty_sync+0x22/0x40 [f2fs]
>   f2fs_abort_atomic_write+0xc4/0xf0 [f2fs]
>   f2fs_evict_inode+0x3f/0x690 [f2fs]
>   ? sugov_start+0x140/0x140
>   evict+0xc3/0x1c0
>   evict_inodes+0x17b/0x210
>   generic_shutdown_super+0x32/0x120
>   kill_block_super+0x21/0x50
>   deactivate_locked_super+0x31/0x90
>   cleanup_mnt+0x100/0x160
>   task_work_run+0x59/0x90
>   do_exit+0x33b/0xa50
>   do_group_exit+0x2d/0x80
>   __x64_sys_exit_group+0x14/0x20
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: flush inode if atomic file is aborted
    https://git.kernel.org/jaegeuk/f2fs/c/eb4ebfac51db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


