Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6B77C1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjHNUu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjHNUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8EBC3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CEB4647CC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D4E7C43395;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692046222;
        bh=HyxFxhf4E18n+HFsMV0CE+FpVTTOA6JA7lROJ6EF848=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CcwPvzKVwTQr3lffWFUCBr5l2Edfo/5qK3NmwWP68ZS5RO/Z8vEMcMPJ7IjaBv1rG
         3qJORsZ4DFZq4bFDDQhvSduLSFAI4w5Ro/vBbt1iYIT/JMHc7U3fiBeHffLMbiwcV+
         iL9meFKFQdIzLslhRcg9GpEguJHF0G5HyfUbRsVYsE1ohLog/MeLo+lK47J+gnOlXa
         vdzZiC0h+E9DaZy5JpjUJLsABlqO+ex4pK9Mvs7MEKAIv32ZTzp2i9fJeInh6tWAJH
         EacQS8eYzc7CdyPcuWtX+Hiq6v4uOGwpDwAgIbeXxRd6tTQ1BaWPpQSdyO2AvW+YMJ
         a1D6cyvZGI9EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 601CAE93B37;
        Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: fix to do sanity check on extent
 cache correctly"
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169204622238.5033.822780908633322584.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 20:50:22 +0000
References: <20230720112953.3764050-1-chao@kernel.org>
In-Reply-To: <20230720112953.3764050-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org,
        syzbot+601018296973a481f302@syzkaller.appspotmail.com,
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

On Thu, 20 Jul 2023 19:29:53 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> UBSAN: array-index-out-of-bounds in fs/f2fs/f2fs.h:3275:19
> index 1409 is out of range for type '__le32[923]' (aka 'unsigned int[923]')
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
>  inline_data_addr fs/f2fs/f2fs.h:3275 [inline]
>  __recover_inline_status fs/f2fs/inode.c:113 [inline]
>  do_read_inode fs/f2fs/inode.c:480 [inline]
>  f2fs_iget+0x4730/0x48b0 fs/f2fs/inode.c:604
>  f2fs_fill_super+0x640e/0x80c0 fs/f2fs/super.c:4601
>  mount_bdev+0x276/0x3b0 fs/super.c:1391
>  legacy_get_tree+0xef/0x190 fs/fs_context.c:611
>  vfs_get_tree+0x8c/0x270 fs/super.c:1519
>  do_new_mount+0x28f/0xae0 fs/namespace.c:3335
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] Revert "f2fs: fix to do sanity check on extent cache correctly"
    https://git.kernel.org/jaegeuk/f2fs/c/958ccbbf1ce7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


