Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A369B7513E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGLXBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLXBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:01:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA801FD7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6D561995
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B61A7C433C8;
        Wed, 12 Jul 2023 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689202821;
        bh=qvHHbl0p2tQLedpUeZ4QhvF8czKekLbTODRAToIkIms=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WlTh2Kr8bbNq7xMuMZ0KXRJ+l9XPMPRQlUF4k6Bw+E4jnpWIslkC3r/IJOBkN1r4s
         c4LU45HwYmFoiIrufGH9F0Px+lrCRplSlfG+Zx2zx7NiBpAV+ko66JlIFkYrcIg7lD
         aWx92y7PrCCH2Bze3ForhnrmzWoyHC9+9VF/FBqBkjZmLIPg7K+lscgaP1tz+gw0EU
         gNL3Ji+Qcc+OWdqf8Zxet4TXucihxrdiWCDwHgBDkENYGfgWa/b7H/dGhTZ7WbLgPH
         t9m8pt/kQ0nGZ/w4qYi2/adNDpTMOscoc31u5QZDy9Ff2veP1Em/I9l74Wqbe3JRQZ
         aLRWIz+dMNaoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C8F1C04E32;
        Wed, 12 Jul 2023 23:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: fix shift-out-of-bounds in exponential backoff
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168920282162.4587.10421020284292608288.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 23:00:21 +0000
References: <20230711013621.GE1926@templeofstupid.com>
In-Reply-To: <20230711013621.GE1926@templeofstupid.com>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
        ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jul 2023 18:36:21 -0700 you wrote:
> The ENA adapters on our instances occasionally reset.  Once recently
> logged a UBSAN failure to console in the process:
> 
>   UBSAN: shift-out-of-bounds in build/linux/drivers/net/ethernet/amazon/ena/ena_com.c:540:13
>   shift exponent 32 is too large for 32-bit type 'unsigned int'
>   CPU: 28 PID: 70012 Comm: kworker/u72:2 Kdump: loaded not tainted 5.15.117
>   Hardware name: Amazon EC2 c5d.9xlarge/, BIOS 1.0 10/16/2017
>   Workqueue: ena ena_fw_reset_device [ena]
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4a/0x63
>   dump_stack+0x10/0x16
>   ubsan_epilogue+0x9/0x36
>   __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
>   ? __const_udelay+0x43/0x50
>   ena_delay_exponential_backoff_us.cold+0x16/0x1e [ena]
>   wait_for_reset_state+0x54/0xa0 [ena]
>   ena_com_dev_reset+0xc8/0x110 [ena]
>   ena_down+0x3fe/0x480 [ena]
>   ena_destroy_device+0xeb/0xf0 [ena]
>   ena_fw_reset_device+0x30/0x50 [ena]
>   process_one_work+0x22b/0x3d0
>   worker_thread+0x4d/0x3f0
>   ? process_one_work+0x3d0/0x3d0
>   kthread+0x12a/0x150
>   ? set_kthread_struct+0x50/0x50
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net: ena: fix shift-out-of-bounds in exponential backoff
    https://git.kernel.org/netdev/net/c/1e9cb763e9ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


