Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D867D22AB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJVKkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjJVKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E0124
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE2ABC433C7;
        Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697971223;
        bh=AmxucS0I6jpezYSp6CUJ8OIsJn2NqODuFduq57nFTjw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OrB1dyuzfdbJ/7oZW/qkEYhUCM01qzeJMC0F+gFPLAjZJqlvN1mGGAq0gmOQBp4m5
         RVC/bcn4oJWuzKy4tm3BAiqVAU9STic0TZ8dyrkC5Mg6qWeIhGtkT18IhvH1Ojr/4g
         dP0ic1nRnHyeGv+QxAs9E7TEf2VAb/kFWOvQne/rMRDCtANrMNj+aD5gmdDWUiSwIU
         YqDEXGe6Tp7mxF39hHX0FJAwdMR0ApMCZL/+qY8ZPiytbLK8WfVW5trlE8R3vdbSWI
         j0g9A/yG445tMPWGRX7U+bZWAJ3JkaMma1HXHgubfX7IXzWxufhqoDXfMTpE8Bt9y/
         WY6E/WysvL21g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0E3AC691E1;
        Sun, 22 Oct 2023 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: smsc95xx: Fix uninit-value access in
 smsc95xx_read_reg
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169797122372.373.6344765542608925929.git-patchwork-notify@kernel.org>
Date:   Sun, 22 Oct 2023 10:40:23 +0000
References: <20231020170344.2450248-1-syoshida@redhat.com>
In-Reply-To: <20231020170344.2450248-1-syoshida@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c74c24b43c9ae534f0e0@syzkaller.appspotmail.com,
        syzbot+2c97a98a5ba9ea9c23bd@syzkaller.appspotmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 21 Oct 2023 02:03:44 +0900 you wrote:
> syzbot reported the following uninit-value access issue [1]:
> 
> smsc95xx 1-1:0.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x00000030: -32
> smsc95xx 1-1:0.0 (unnamed net_device) (uninitialized): Error reading E2P_CMD
> =====================================================
> BUG: KMSAN: uninit-value in smsc95xx_reset+0x409/0x25f0 drivers/net/usb/smsc95xx.c:896
>  smsc95xx_reset+0x409/0x25f0 drivers/net/usb/smsc95xx.c:896
>  smsc95xx_bind+0x9bc/0x22e0 drivers/net/usb/smsc95xx.c:1131
>  usbnet_probe+0x100b/0x4060 drivers/net/usb/usbnet.c:1750
>  usb_probe_interface+0xc75/0x1210 drivers/usb/core/driver.c:396
>  really_probe+0x506/0xf40 drivers/base/dd.c:658
>  __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
>  driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
>  __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
>  bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
>  __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
>  device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
>  bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
>  device_add+0x16ae/0x1f20 drivers/base/core.c:3622
>  usb_set_configuration+0x31c9/0x38c0 drivers/usb/core/message.c:2207
>  usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:238
>  usb_probe_device+0x290/0x4a0 drivers/usb/core/driver.c:293
>  really_probe+0x506/0xf40 drivers/base/dd.c:658
>  __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
>  driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
>  __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
>  bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
>  __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
>  device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
>  bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
>  device_add+0x16ae/0x1f20 drivers/base/core.c:3622
>  usb_new_device+0x15f6/0x22f0 drivers/usb/core/hub.c:2589
>  hub_port_connect drivers/usb/core/hub.c:5440 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
>  port_event drivers/usb/core/hub.c:5740 [inline]
>  hub_event+0x53bc/0x7290 drivers/usb/core/hub.c:5822
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
>  worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
>  kthread+0x3e8/0x540 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> [...]

Here is the summary with links:
  - [net] net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg
    https://git.kernel.org/netdev/net/c/51a32e828109

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


