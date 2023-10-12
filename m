Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6A17C7717
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442334AbjJLTkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442228AbjJLTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A274C9;
        Thu, 12 Oct 2023 12:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F8B1C433C9;
        Thu, 12 Oct 2023 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139626;
        bh=iRuEDYBMKlSEm7CBmdnAfuU+j5cDNY8VO8ZzrAGazgw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Aykr+cCXazwTwsAnJ2Sfzkj+k3mwXewNb7Dl9RUbQ32V2+bewULp4/8M+fZ4xI0it
         cl2L9xVoOVBZk3lrmCqVkB1OKN9GRCg0LuT8COQUuxwUvZmRV3cBAqwr1lheKJOfxW
         O6bUrDFBzOZL3whswAWHhn48mN2en4NgaygZ5rZ7wbSjYi8LivKGozMKB11DdvG3JX
         efd0Cc3UUsSiK1tbllV2ifW2sDqWWBSGFoFXlBpkC+c7mEPuzx/tF4sHCOqIDk35nf
         gXsEk7q67KrYQz9CD2O+K2Dfse/Qasu1AMO2ygva/kZLUKMjzeD6ts8rp+QjbS8KlA
         gGwEmoEum0nSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05273E21EC2;
        Thu, 12 Oct 2023 19:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add date->evt_skb is NULL check
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169713962601.24492.6840832383405920187.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 19:40:26 +0000
References: <20231011051447.92581-1-wangyouwan@126.com>
In-Reply-To: <20231011051447.92581-1-wangyouwan@126.com>
To:     wangyouwan <wangyouwan@126.com>
Cc:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Oct 2023 13:14:47 +0800 you wrote:
> From: youwan Wang <wangyouwan@126.com>
> 
> fix crash because of null pointers
> 
> [ 6104.969662] BUG: kernel NULL pointer dereference, address: 00000000000000c8
> [ 6104.969667] #PF: supervisor read access in kernel mode
> [ 6104.969668] #PF: error_code(0x0000) - not-present page
> [ 6104.969670] PGD 0 P4D 0
> [ 6104.969673] Oops: 0000 [#1] SMP NOPTI
> [ 6104.969684] RIP: 0010:btusb_mtk_hci_wmt_sync+0x144/0x220 [btusb]
> [ 6104.969688] RSP: 0018:ffffb8d681533d48 EFLAGS: 00010246
> [ 6104.969689] RAX: 0000000000000000 RBX: ffff8ad560bb2000 RCX: 0000000000000006
> [ 6104.969691] RDX: 0000000000000000 RSI: ffffb8d681533d08 RDI: 0000000000000000
> [ 6104.969692] RBP: ffffb8d681533d70 R08: 0000000000000001 R09: 0000000000000001
> [ 6104.969694] R10: 0000000000000001 R11: 00000000fa83b2da R12: ffff8ad461d1d7c0
> [ 6104.969695] R13: 0000000000000000 R14: ffff8ad459618c18 R15: ffffb8d681533d90
> [ 6104.969697] FS:  00007f5a1cab9d40(0000) GS:ffff8ad578200000(0000) knlGS:00000
> [ 6104.969699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6104.969700] CR2: 00000000000000c8 CR3: 000000018620c001 CR4: 0000000000760ef0
> [ 6104.969701] PKRU: 55555554
> [ 6104.969702] Call Trace:
> [ 6104.969708]  btusb_mtk_shutdown+0x44/0x80 [btusb]
> [ 6104.969732]  hci_dev_do_close+0x470/0x5c0 [bluetooth]
> [ 6104.969748]  hci_rfkill_set_block+0x56/0xa0 [bluetooth]
> [ 6104.969753]  rfkill_set_block+0x92/0x160
> [ 6104.969755]  rfkill_fop_write+0x136/0x1e0
> [ 6104.969759]  __vfs_write+0x18/0x40
> [ 6104.969761]  vfs_write+0xdf/0x1c0
> [ 6104.969763]  ksys_write+0xb1/0xe0
> [ 6104.969765]  __x64_sys_write+0x1a/0x20
> [ 6104.969769]  do_syscall_64+0x51/0x180
> [ 6104.969771]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 6104.969773] RIP: 0033:0x7f5a21f18fef
> [ 6104.9] RSP: 002b:00007ffeefe39010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [ 6104.969780] RAX: ffffffffffffffda RBX: 000055c10a7560a0 RCX: 00007f5a21f18fef
> [ 6104.969781] RDX: 0000000000000008 RSI: 00007ffeefe39060 RDI: 0000000000000012
> [ 6104.969782] RBP: 00007ffeefe39060 R08: 0000000000000000 R09: 0000000000000017
> [ 6104.969784] R10: 00007ffeefe38d97 R11: 0000000000000293 R12: 0000000000000002
> [ 6104.969785] R13: 00007ffeefe39220 R14: 00007ffeefe391a0 R15: 000055c10a72acf0
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add date->evt_skb is NULL check
    https://git.kernel.org/bluetooth/bluetooth-next/c/79fd960e01d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


