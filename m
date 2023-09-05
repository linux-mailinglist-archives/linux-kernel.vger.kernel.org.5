Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795E792F99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbjIEUJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbjIEUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F1113;
        Tue,  5 Sep 2023 13:08:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 962D7C433CA;
        Tue,  5 Sep 2023 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693936913;
        bh=UeCnBfGRR27Bp4L1bePKrudEhg5rLWXlnlgNPZrCoEY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TZakgHbIrdtF06C79N6m8ODKoeNqxiKjqTe2YJP/VjilPawkI9IoNFJJgyUZT3lJD
         6+ZC5b8LESvNZjvassNAUYbZ5OFsRn3+CompvHzQrFGeAlpFLpgXH0EmWB3XWH9nJ4
         Q6EhFeJtLN6JzswPkttbiJmjvrgzoo/BuXyZg+gZvtJi0Kbv7OrhnuNNBNmTVo4mv/
         nKgtbCAOp96tIeMhvNniazfr/2XeeSksJ/IyK4Je2S04hldqqpNZChaF2rWAYhoC4r
         VgErB6I0plKWYENRANJ2mOXRGvSry4ZMDBX/uD2gf/YLoZvrG7bJLS7/Fces+E2TFs
         VbmS/Y/0A0ESA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80BACC595D2;
        Tue,  5 Sep 2023 18:01:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix hci_link_tx_to RCU lock usage
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169393691352.22693.18079475480346597244.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Sep 2023 18:01:53 +0000
References: <20230904141155.1688673-1-yinghsu@chromium.org>
In-Reply-To: <20230904141155.1688673-1-yinghsu@chromium.org>
To:     Ying Hsu <yinghsu@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, marcel@holtmann.org,
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

On Mon,  4 Sep 2023 14:11:51 +0000 you wrote:
> Syzbot found a bug "BUG: sleeping function called from invalid context
> at kernel/locking/mutex.c:580". It is because hci_link_tx_to holds an
> RCU read lock and calls hci_disconnect which would hold a mutex lock
> since the commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code
> for aborting connections"). Here's an example call trace:
> 
>    __dump_stack lib/dump_stack.c:88 [inline]
>    dump_stack_lvl+0xfc/0x174 lib/dump_stack.c:106
>    ___might_sleep+0x4a9/0x4d3 kernel/sched/core.c:9663
>    __mutex_lock_common kernel/locking/mutex.c:576 [inline]
>    __mutex_lock+0xc7/0x6e7 kernel/locking/mutex.c:732
>    hci_cmd_sync_queue+0x3a/0x287 net/bluetooth/hci_sync.c:388
>    hci_abort_conn+0x2cd/0x2e4 net/bluetooth/hci_conn.c:1812
>    hci_disconnect+0x207/0x237 net/bluetooth/hci_conn.c:244
>    hci_link_tx_to net/bluetooth/hci_core.c:3254 [inline]
>    __check_timeout net/bluetooth/hci_core.c:3419 [inline]
>    __check_timeout+0x310/0x361 net/bluetooth/hci_core.c:3399
>    hci_sched_le net/bluetooth/hci_core.c:3602 [inline]
>    hci_tx_work+0xe8f/0x12d0 net/bluetooth/hci_core.c:3652
>    process_one_work+0x75c/0xba1 kernel/workqueue.c:2310
>    worker_thread+0x5b2/0x73a kernel/workqueue.c:2457
>    kthread+0x2f7/0x30b kernel/kthread.c:319
>    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix hci_link_tx_to RCU lock usage
    https://git.kernel.org/bluetooth/bluetooth-next/c/d606d5f4024d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


